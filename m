Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAADA5EB733
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 03:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbiI0Bvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 21:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiI0Bvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 21:51:46 -0400
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3030571731
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 18:51:43 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R951e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VQpkeU7_1664243499;
Received: from 30.221.128.222(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0VQpkeU7_1664243499)
          by smtp.aliyun-inc.com;
          Tue, 27 Sep 2022 09:51:40 +0800
Message-ID: <1081a9ca-38d9-1ee5-e380-bf2dbe422eec@linux.alibaba.com>
Date:   Tue, 27 Sep 2022 09:51:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.1
Subject: Re: [PATCH] ocfs2: fix crash issue if access released lockres in
 debugfs
Content-Language: en-US
To:     Rock Li <lihongweizz@inspur.com>, mark@fasheh.com,
        jlbec@evilplan.org
Cc:     ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org
References: <20220920073638.1358-1-lihongweizz@inspur.com>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <20220920073638.1358-1-lihongweizz@inspur.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-12.2 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Sorry for the late reply.
It seems it is indeed an issue and I'll get into it more deeply.
I'm curious about how you figure out this? Is it a real issue you've
encountered?

Thanks,
Joseph

On 9/20/22 3:36 PM, Rock Li wrote:
> Access locking_state of dlm debugfs may cause crash as scene below:
> 
> Proc A:                  Proc that access debuginfo:
> add_lockres_tracking(lockresA)
> ...
>                          ocfs2_dlm_seq_next():
>                            //priv->p_iter_res points to next
>                            //lockres e.g. B. priv->p_tmp_res hold
>                            //copy of lockres A before leave
>                          ocfs2_dlm_seq_show()
> ...
> remove_lockres_tracking(lockres B):
>   //free lockres B, l_debug_list in
>   //priv->p_ter_res is updated but not
>   //priv->p_tmp_res
> ...
>                          ocfs2_dlm_seq_next():
> 			   //priv->p_tmp_res which holds a old copy of
>                            //lockres A, the l_debug_list holds a
>                            //out-of-date succeed pointer, which will
>                            //cause crash as //access invalid memory
>                            iter = v; //priv->p_tmp_res
>                            iter = ocfs2_dlm_next_res(iter, priv)
> 
> The root cause of this issue is that private->p_iter_res acts as the
> agent of accessing lockres and is protected by ocfs2_dlm_tracking_lock
> while p_tmp_res is only a copy of the lockres and will be out-of-dated
> after leave critial region of ocfs2_dlm_tracking_lock. We should use
> priv->p_ter_res as the forward iterater instead.
> 
> Signed-off-by: Rock Li <lihongweizz@inspur.com>
> ---
>  fs/ocfs2/dlmglue.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ocfs2/dlmglue.c b/fs/ocfs2/dlmglue.c
> index c28bc98..5d84350 100644
> --- a/fs/ocfs2/dlmglue.c
> +++ b/fs/ocfs2/dlmglue.c
> @@ -3109,7 +3109,7 @@ static void *ocfs2_dlm_seq_next(struct seq_file *m, void *v, loff_t *pos)
>  	struct ocfs2_lock_res *dummy = &priv->p_iter_res;
>  
>  	spin_lock(&ocfs2_dlm_tracking_lock);
> -	iter = ocfs2_dlm_next_res(iter, priv);
> +	iter = ocfs2_dlm_next_res(dummy, priv);
>  	list_del_init(&dummy->l_debug_list);
>  	if (iter) {
>  		list_add(&dummy->l_debug_list, &iter->l_debug_list);
