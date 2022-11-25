Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 892FC638649
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 10:29:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbiKYJ3h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 04:29:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiKYJ3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 04:29:17 -0500
Received: from out199-13.us.a.mail.aliyun.com (out199-13.us.a.mail.aliyun.com [47.90.199.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C24832BB0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 01:29:00 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VVedjiE_1669368536;
Received: from 30.221.133.6(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0VVedjiE_1669368536)
          by smtp.aliyun-inc.com;
          Fri, 25 Nov 2022 17:28:57 +0800
Message-ID: <03a60f60-6408-b67c-6e66-d4ff1d24089c@linux.alibaba.com>
Date:   Fri, 25 Nov 2022 17:28:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH] ocfs2: properly clean task pointer before o2hb thread
 exits abnormally
Content-Language: en-US
To:     lihongweizz <lihongweizz@inspur.com>, mark@fasheh.com,
        jlbec@evilplan.org
Cc:     ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org
References: <20221125031522.339-1-lihongweizz@inspur.com>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <20221125031522.339-1-lihongweizz@inspur.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/25/22 11:15 AM, lihongweizz wrote:
> From: Rock Li <lihongweizz@inspur.com>
> 
> in case o2hb thread exits abnormally before stop o2cb service,
> heartbeat_drop_group_item will try to stop a noexit thread cause
> ret->hb_task was not clear properly.
> 
Could you please describe the scenario in detail?

Thanks,
Joseph 

> Signed-off-by: Rock Li <lihongweizz@inspur.com>
> ---
>  fs/ocfs2/cluster/heartbeat.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/ocfs2/cluster/heartbeat.c b/fs/ocfs2/cluster/heartbeat.c
> index b13d344..9db448d 100644
> --- a/fs/ocfs2/cluster/heartbeat.c
> +++ b/fs/ocfs2/cluster/heartbeat.c
> @@ -1258,6 +1258,8 @@ static int o2hb_thread(void *data)
>  	/* Unpin node */
>  	o2nm_undepend_this_node();
>  
> +	reg->hr_task = NULL;
> +
>  	mlog(ML_HEARTBEAT|ML_KTHREAD, "o2hb thread exiting\n");
>  
>  	return 0;
