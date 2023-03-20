Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E68546C0957
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 04:35:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbjCTDfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 23:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjCTDfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 23:35:10 -0400
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EA6B4EEC
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 20:35:09 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R651e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VeAEmqc_1679283305;
Received: from 30.221.129.198(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0VeAEmqc_1679283305)
          by smtp.aliyun-inc.com;
          Mon, 20 Mar 2023 11:35:05 +0800
Message-ID: <308c0ee8-cf42-1342-9745-76b715086c02@linux.alibaba.com>
Date:   Mon, 20 Mar 2023 11:35:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH v2, RESEND 08/10] ocfs2: convert to kobject_del_and_put()
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org
References: <20230319092641.41917-1-frank.li@vivo.com>
 <20230319092641.41917-8-frank.li@vivo.com>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <20230319092641.41917-8-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/19/23 5:26 PM, Yangtao Li wrote:
> Use kobject_del_and_put() to simplify code.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>  fs/ocfs2/filecheck.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/ocfs2/filecheck.c b/fs/ocfs2/filecheck.c
> index 1ad7106741f8..fb9cf601245b 100644
> --- a/fs/ocfs2/filecheck.c
> +++ b/fs/ocfs2/filecheck.c
> @@ -198,8 +198,7 @@ void ocfs2_filecheck_remove_sysfs(struct ocfs2_super *osb)
>  	if (!osb->osb_fc_ent.fs_fcheck)
>  		return;
>  
> -	kobject_del(&osb->osb_fc_ent.fs_kobj);
> -	kobject_put(&osb->osb_fc_ent.fs_kobj);
> +	kobject_del_and_put(&osb->osb_fc_ent.fs_kobj);
>  	wait_for_completion(&osb->osb_fc_ent.fs_kobj_unregister);
>  	ocfs2_filecheck_sysfs_free(&osb->osb_fc_ent);
>  }

Can't find any implementation of kobject_del_and_put() in mainline.
So I guess you've introduced it at the beginning of this series? Since I
can only see this one:(
So it depends on kobject lib. If kobject lib accepts this helper, it's
fine to me.

Thanks,
Joseph
