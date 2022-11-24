Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D46B26379C8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 14:18:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbiKXNSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 08:18:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbiKXNSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 08:18:05 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C7A4627EF;
        Thu, 24 Nov 2022 05:18:04 -0800 (PST)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NHz7F5w0pzRpSh;
        Thu, 24 Nov 2022 21:17:29 +0800 (CST)
Received: from dggpemm500013.china.huawei.com (7.185.36.172) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 24 Nov 2022 21:18:01 +0800
Received: from [10.67.108.67] (10.67.108.67) by dggpemm500013.china.huawei.com
 (7.185.36.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 24 Nov
 2022 21:18:01 +0800
Message-ID: <6651f11c-9c56-6988-2e43-c6890fa51751@huawei.com>
Date:   Thu, 24 Nov 2022 21:18:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: [PATCH] ovl: Fix use inode directly in rcu-walk mode
To:     Miklos Szeredi <miklos@szeredi.hu>
CC:     <syzbot+a4055c78774bbf3498bb@syzkaller.appspotmail.com>,
        <linux-unionfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20221124092602.259809-1-chenzhongjin@huawei.com>
 <Y39nXuhwVi39nZPa@miu.piliscsaba.redhat.com>
Content-Language: en-US
From:   Chen Zhongjin <chenzhongjin@huawei.com>
In-Reply-To: <Y39nXuhwVi39nZPa@miu.piliscsaba.redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.108.67]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500013.china.huawei.com (7.185.36.172)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/11/24 20:45, Miklos Szeredi wrote:
> On Thu, Nov 24, 2022 at 05:26:02PM +0800, Chen Zhongjin wrote:
>> syzkaller reported a null-ptr-deref error:
>> https://syzkaller.appspot.com/bug?id=bb281e89381b9ed55728c274447a575e69a96c35
>>
>> ovl_dentry_revalidate_common() can be called in rcu-walk mode.
>> As document said, "in rcu-walk mode, d_parent and d_inode should not be
>> used without care". Check inode here to protect access under rcu-walk
>> mode.
>>
>> Fixes: bccece1ead36 ("ovl: allow remote upper")
>> Reported-by: syzbot+a4055c78774bbf3498bb@syzkaller.appspotmail.com
>> Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
> Hi,
>
> Thanks for the quick analysis and patch.
>
> I simplified the patch a bit without changing the attribution.
>
> Thanks,
> Miklos
>
> ----
> From: Chen Zhongjin <chenzhongjin@huawei.com>
> Subject: ovl: fix use inode directly in rcu-walk mode
>
> ovl_dentry_revalidate_common() can be called in rcu-walk mode.  As document
> said, "in rcu-walk mode, d_parent and d_inode should not be used without
> care".
>
> Check inode here to protect access under rcu-walk mode.
>
> Fixes: bccece1ead36 ("ovl: allow remote upper")
> Reported-by: syzbot+a4055c78774bbf3498bb@syzkaller.appspotmail.com
> Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
> Cc: <stable@vger.kernel.org> # v5.7
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---
>   fs/overlayfs/super.c |    7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
>
> --- a/fs/overlayfs/super.c
> +++ b/fs/overlayfs/super.c
> @@ -139,11 +139,16 @@ static int ovl_dentry_revalidate_common(
>   					unsigned int flags, bool weak)
>   {
>   	struct ovl_entry *oe = dentry->d_fsdata;
> +	struct inode *inode = d_inode_rcu(dentry);
>   	struct dentry *upper;
>   	unsigned int i;
>   	int ret = 1;
>   
> -	upper = ovl_dentry_upper(dentry);
> +	/* Careful in RCU mode */
> +	if (!inode)
> +		return -ECHILD;
> +
> +	upper = ovl_i_dentry_upper(inode);
>   	if (upper)
>   		ret = ovl_revalidate_real(upper, flags, weak);
>   

Thanks for review! LGTM

Best,
Chen
