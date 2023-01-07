Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43A45660BAC
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 02:55:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236463AbjAGBzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 20:55:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236224AbjAGBzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 20:55:23 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E826F87932;
        Fri,  6 Jan 2023 17:55:21 -0800 (PST)
Received: from kwepemm600009.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Npjsz4cX9zRqsF;
        Sat,  7 Jan 2023 09:53:43 +0800 (CST)
Received: from [10.67.101.184] (10.67.101.184) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Sat, 7 Jan 2023 09:55:18 +0800
Subject: Re: [PATCH] crypto: hisilicon: Wipe entire pool on error
To:     Kees Cook <keescook@chromium.org>
References: <20230106041945.never.831-kees@kernel.org>
CC:     Nathan Chancellor <nathan@kernel.org>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        <linux-crypto@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, <linux-kernel@vger.kernel.org>,
        <llvm@lists.linux.dev>, <linux-hardening@vger.kernel.org>
From:   Weili Qian <qianweili@huawei.com>
Message-ID: <7c9e9870-2456-01af-177f-1af62a0055e3@huawei.com>
Date:   Sat, 7 Jan 2023 09:55:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20230106041945.never.831-kees@kernel.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.101.184]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/1/6 12:19, Kees Cook wrote:
> To work around a Clang __builtin_object_size bug that shows up under
> CONFIG_FORTIFY_SOURCE and UBSAN_BOUNDS, move the per-loop-iteration
> mem_block wipe into a single wipe of the entire pool structure after
> the loop.
> 
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Link: https://github.com/ClangBuiltLinux/linux/issues/1780
> Cc: Weili Qian <qianweili@huawei.com>
> Cc: Zhou Wang <wangzhou1@hisilicon.com>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: linux-crypto@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  drivers/crypto/hisilicon/sgl.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/crypto/hisilicon/sgl.c b/drivers/crypto/hisilicon/sgl.c
> index 2b6f2281cfd6..0974b0041405 100644
> --- a/drivers/crypto/hisilicon/sgl.c
> +++ b/drivers/crypto/hisilicon/sgl.c
> @@ -124,9 +124,8 @@ struct hisi_acc_sgl_pool *hisi_acc_create_sgl_pool(struct device *dev,
>  	for (j = 0; j < i; j++) {
>  		dma_free_coherent(dev, block_size, block[j].sgl,
>  				  block[j].sgl_dma);
> -		memset(block + j, 0, sizeof(*block));
>  	}
> -	kfree(pool);
> +	kfree_sensitive(pool);
>  	return ERR_PTR(-ENOMEM);
>  }
>  EXPORT_SYMBOL_GPL(hisi_acc_create_sgl_pool);
> 
Thanks for your patch.

There is no sensitive data in the pool, so memset zero can be deleted directly.

Thanks,
Weili
