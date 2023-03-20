Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D19FE6C090D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 03:56:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjCTC4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 22:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbjCTC4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 22:56:07 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E44A0F745
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 19:55:54 -0700 (PDT)
Received: from kwepemm600013.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4PfzqL3qpzzrTsP;
        Mon, 20 Mar 2023 10:54:54 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 20 Mar 2023 10:55:52 +0800
Subject: Re: [PATCH v2, RESEND 05/10] ubifs: convert to kobject_del_and_put()
To:     Yangtao Li <frank.li@vivo.com>, Richard Weinberger <richard@nod.at>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20230319092641.41917-1-frank.li@vivo.com>
 <20230319092641.41917-5-frank.li@vivo.com>
From:   Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <9d8258af-4f27-7897-26f9-32dd8ca9b20c@huawei.com>
Date:   Mon, 20 Mar 2023 10:55:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20230319092641.41917-5-frank.li@vivo.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.46]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yangtao,
> Use kobject_del_and_put() to simplify code.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>   fs/ubifs/sysfs.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/ubifs/sysfs.c b/fs/ubifs/sysfs.c
> index 1c958148bb87..9571718e61a9 100644
> --- a/fs/ubifs/sysfs.c
> +++ b/fs/ubifs/sysfs.c
> @@ -130,8 +130,7 @@ int ubifs_sysfs_register(struct ubifs_info *c)
>   
>   void ubifs_sysfs_unregister(struct ubifs_info *c)
>   {
> -	kobject_del(&c->kobj);
> -	kobject_put(&c->kobj);
> +	kobject_del_and_put(&c->kobj);
>   	wait_for_completion(&c->kobj_unregister);
>   
>   	kfree(c->stats);
> 

Maybe you can send the entire patchset to linux-mtd next time, I can 
only see patch 5 from the maillist. After confirming from other 
website(https://www.spinics.net/lists/kernel/msg4727274.html) I see you 
instroduced the implementation of kobject_del_and_put().

I have no objections if other modules can accept the kobject_del_and_put().
