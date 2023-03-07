Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D3716AD99A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 09:52:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbjCGIwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 03:52:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbjCGIwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 03:52:53 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A8EF2E826;
        Tue,  7 Mar 2023 00:52:45 -0800 (PST)
Received: from kwepemm600015.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4PW8Kq1lmdzKpxF;
        Tue,  7 Mar 2023 16:50:39 +0800 (CST)
Received: from [10.174.176.52] (10.174.176.52) by
 kwepemm600015.china.huawei.com (7.193.23.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 7 Mar 2023 16:52:43 +0800
Message-ID: <48975544-9b5f-eb2a-e2a2-f0ffa537aa1c@huawei.com>
Date:   Tue, 7 Mar 2023 16:52:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH] ksmbd: fix possible refcount leak in smb2_open()
To:     <linkinjeon@kernel.org>, <sfrench@samba.org>,
        <stfrench@microsoft.com>
CC:     <linux-cifs@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230302135804.2583061-1-chenxiaosong2@huawei.com>
From:   ChenXiaoSong <chenxiaosong2@huawei.com>
In-Reply-To: <20230302135804.2583061-1-chenxiaosong2@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.52]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600015.china.huawei.com (7.193.23.52)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Namjae and Steve:

Do you have any suggestions for this patch?

在 2023/3/2 21:58, ChenXiaoSong 写道:
> Reference count of acls will leak when memory allocation fails. Fix this
> by adding the missing posix_acl_release().
> 
> Fixes: e2f34481b24d ("cifsd: add server-side procedures for SMB3")
> Signed-off-by: ChenXiaoSong <chenxiaosong2@huawei.com>
> ---
>   fs/ksmbd/smb2pdu.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
> index 0685c1c77b9f..f04d810a2588 100644
> --- a/fs/ksmbd/smb2pdu.c
> +++ b/fs/ksmbd/smb2pdu.c
> @@ -2977,8 +2977,11 @@ int smb2_open(struct ksmbd_work *work)
>   							sizeof(struct smb_acl) +
>   							sizeof(struct smb_ace) * ace_num * 2,
>   							GFP_KERNEL);
> -					if (!pntsd)
> +					if (!pntsd) {
> +						posix_acl_release(fattr.cf_acls);
> +						posix_acl_release(fattr.cf_dacls);
>   						goto err_out;
> +					}
>   
>   					rc = build_sec_desc(idmap,
>   							    pntsd, NULL, 0,
> 
