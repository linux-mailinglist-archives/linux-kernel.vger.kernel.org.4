Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAB9970BCD5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 14:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233656AbjEVMB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 08:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233048AbjEVMBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 08:01:54 -0400
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B816EE41
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 05:01:29 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R321e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VjEZgMP_1684756885;
Received: from 30.221.132.35(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0VjEZgMP_1684756885)
          by smtp.aliyun-inc.com;
          Mon, 22 May 2023 20:01:26 +0800
Message-ID: <a57047d6-8f57-3dde-f15f-b24f63d675cd@linux.alibaba.com>
Date:   Mon, 22 May 2023 20:01:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH] ocfs2: fix use-after-free when unmounting read-only
 filesystem
Content-Language: en-US
To:     =?UTF-8?Q?Lu=c3=ads_Henriques?= <lhenriques@suse.de>
Cc:     ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Heming Zhao <heming.zhao@suse.com>
References: <20230522102506.9205-1-lhenriques@suse.de>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <20230522102506.9205-1-lhenriques@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/22/23 6:25 PM, Luís Henriques wrote:
> It's trivial to trigger a use-after-free bug in the ocfs2 quotas code using
> fstest generic/452.  After mounting a filesystem as read-only, quotas are

generic/452 is for testing ext4 mounted with dax and ro.
But ocfs2 doesn't support dax yet. 

> suspended and ocfs2_mem_dqinfo is freed through ->ocfs2_local_free_info().  When
> unmounting the filesystem, an UAF access to the oinfo will eventually cause a
> crash.

In ocfs2_fill_super(), it won't enable quota if is a readonly mount.
Do you mean remount as readonly?

Thanks,
Joseph

> 
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Luís Henriques <lhenriques@suse.de>
> ---
>  fs/ocfs2/super.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ocfs2/super.c b/fs/ocfs2/super.c
> index 0b0e6a132101..988d1c076861 100644
> --- a/fs/ocfs2/super.c
> +++ b/fs/ocfs2/super.c
> @@ -952,8 +952,10 @@ static void ocfs2_disable_quotas(struct ocfs2_super *osb)
>  	for (type = 0; type < OCFS2_MAXQUOTAS; type++) {
>  		if (!sb_has_quota_loaded(sb, type))
>  			continue;
> -		oinfo = sb_dqinfo(sb, type)->dqi_priv;
> -		cancel_delayed_work_sync(&oinfo->dqi_sync_work);
> +		if (!sb_has_quota_suspended(sb, type)) {
> +			oinfo = sb_dqinfo(sb, type)->dqi_priv;
> +			cancel_delayed_work_sync(&oinfo->dqi_sync_work);
> +		}
>  		inode = igrab(sb->s_dquot.files[type]);
>  		/* Turn off quotas. This will remove all dquot structures from
>  		 * memory and so they will be automatically synced to global
