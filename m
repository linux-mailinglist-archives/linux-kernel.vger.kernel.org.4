Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89B2D634E57
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 04:29:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235574AbiKWD3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 22:29:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234070AbiKWD3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 22:29:07 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77DD2C6555
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 19:29:06 -0800 (PST)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NH6695YydzmW4H;
        Wed, 23 Nov 2022 11:28:33 +0800 (CST)
Received: from [10.67.109.51] (10.67.109.51) by canpemm500009.china.huawei.com
 (7.192.105.203) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 23 Nov
 2022 11:29:04 +0800
Message-ID: <ad8ff736-bbce-2ec3-301f-691401a80bd1@huawei.com>
Date:   Wed, 23 Nov 2022 11:29:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v2] ubifs: Fix build errors as symbol undefined
To:     <richard@nod.at>, <s.hauer@pengutronix.de>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <weiyongjun1@huawei.com>, <yusongping@huawei.com>
References: <20221121111847.71648-1-hucool.lihua@huawei.com>
From:   "Lihua (lihua, ran)" <hucool.lihua@huawei.com>
In-Reply-To: <20221121111847.71648-1-hucool.lihua@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.109.51]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping

在 2022/11/21 19:18, Li Hua 写道:
> With CONFIG_UBIFS_FS_AUTHENTICATION not set, the compiler can assume that
> ubifs_node_check_hash() is never true and drops the call to ubifs_bad_hash().
> Is CONFIG_CC_OPTIMIZE_FOR_SIZE enabled this optimization does not happen anymore.
> 
> So When CONFIG_UBIFS_FS and CONFIG_CC_OPTIMIZE_FOR_SIZE is enabled but
> CONFIG_UBIFS_FS_AUTHENTICATION is not set, the build errors is as followd:
>      ERROR: modpost: "ubifs_bad_hash" [fs/ubifs/ubifs.ko] undefined!
> 
> Fix it by add no-op ubifs_bad_hash() for the CONFIG_UBIFS_FS_AUTHENTICATION=n case.
> 
> Fixes: 16a26b20d2af ("ubifs: authentication: Add hashes to index nodes")
> Signed-off-by: Li Hua <hucool.lihua@huawei.com>
> ---
>   fs/ubifs/ubifs.h | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/fs/ubifs/ubifs.h b/fs/ubifs/ubifs.h
> index 478bbbb5382f..2f1f31581094 100644
> --- a/fs/ubifs/ubifs.h
> +++ b/fs/ubifs/ubifs.h
> @@ -1623,8 +1623,13 @@ static inline int ubifs_check_hmac(const struct ubifs_info *c,
>   	return crypto_memneq(expected, got, c->hmac_desc_len);
>   }
>   
> +#ifdef CONFIG_UBIFS_FS_AUTHENTICATION
>   void ubifs_bad_hash(const struct ubifs_info *c, const void *node,
>   		    const u8 *hash, int lnum, int offs);
> +#else
> +static inline void ubifs_bad_hash(const struct ubifs_info *c, const void *node,
> +				  const u8 *hash, int lnum, int offs) {};
> +#endif
>   
>   int __ubifs_node_check_hash(const struct ubifs_info *c, const void *buf,
>   			  const u8 *expected);
> 
