Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDF2C6027D5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 11:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbiJRJDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 05:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231237AbiJRJCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 05:02:44 -0400
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC3B6A99F3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 02:02:33 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R481e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VSUDmyd_1666083748;
Received: from 30.221.129.41(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0VSUDmyd_1666083748)
          by smtp.aliyun-inc.com;
          Tue, 18 Oct 2022 17:02:29 +0800
Message-ID: <bf27f347-5ced-98e5-f188-659cc2a9736f@linux.alibaba.com>
Date:   Tue, 18 Oct 2022 17:02:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.3
Subject: Re: [PATCH] ocfs2: possible memory leak in mlog_sys_init()
To:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-kernel@vger.kernel.org, ocfs2-devel@oss.oracle.com
Cc:     mark@fasheh.com, jlbec@evilplan.org, gregkh@linuxfoundation.org,
        akpm@linux-foundation.org
References: <20221018075213.736562-1-yangyingliang@huawei.com>
Content-Language: en-US
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <20221018075213.736562-1-yangyingliang@huawei.com>
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

Hi,

On 10/18/22 3:52 PM, Yang Yingliang wrote:
> Inject fault while probing module, kset_register() may fail,
> if it fails, but the refcount of kobject is not decreased to
> 0, the name allocated in kobject_set_name() is leaked. Fix
> this by calling kset_put(), so that name can be freed in
> callback function kobject_cleanup().
> 
> unreferenced object 0xffff888100da9348 (size 8):
>   comm "modprobe", pid 257, jiffies 4294701096 (age 33.334s)
>   hex dump (first 8 bytes):
>     6c 6f 67 6d 61 73 6b 00                          logmask.
>   backtrace:
>     [<00000000306e441c>] __kmalloc_node_track_caller+0x44/0x1b0
>     [<000000007c491a9e>] kstrdup+0x3a/0x70
>     [<0000000015719a3b>] kstrdup_const+0x63/0x80
>     [<0000000084e458ea>] kvasprintf_const+0x149/0x180
>     [<0000000091302b42>] kobject_set_name_vargs+0x56/0x150
>     [<000000005f48eeac>] kobject_set_name+0xab/0xe0
> 
> Fixes: 34980ca8faeb ("Drivers: clean up direct setting of the name of a kset")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  fs/ocfs2/cluster/masklog.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ocfs2/cluster/masklog.c b/fs/ocfs2/cluster/masklog.c
> index 563881ddbf00..7f9ba816d955 100644
> --- a/fs/ocfs2/cluster/masklog.c
> +++ b/fs/ocfs2/cluster/masklog.c
> @@ -156,6 +156,7 @@ static struct kset mlog_kset = {
>  int mlog_sys_init(struct kset *o2cb_kset)
>  {
>  	int i = 0;
> +	int ret;
>  
>  	while (mlog_attrs[i].attr.mode) {
>  		mlog_default_attrs[i] = &mlog_attrs[i].attr;
> @@ -165,7 +166,11 @@ int mlog_sys_init(struct kset *o2cb_kset)
>  
>  	kobject_set_name(&mlog_kset.kobj, "logmask");
>  	mlog_kset.kobj.kset = o2cb_kset;
> -	return kset_register(&mlog_kset);
> +	ret = kset_register(&mlog_kset);

If register fails, it will call unregister in o2cb_sys_init(), which
will put kobject.

Thanks,
Joseph

> +	if (ret)
> +		kset_put(&mlog_kset);
> +
> +	return ret;
>  }
>  
>  void mlog_sys_shutdown(void)
