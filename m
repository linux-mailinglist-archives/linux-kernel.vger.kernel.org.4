Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9DD6607574
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 12:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbiJUKxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 06:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbiJUKxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 06:53:16 -0400
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7569624C104;
        Fri, 21 Oct 2022 03:53:15 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1olpdj-004cxK-0C; Fri, 21 Oct 2022 18:53:12 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 21 Oct 2022 18:53:11 +0800
Date:   Fri, 21 Oct 2022 18:53:11 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Kai Ye <yekai13@huawei.com>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        wangzhou1@hisilicon.com
Subject: Re: [PATCH v2 1/3] crypto: hisilicon/qm - increase the memory of
 local variables
Message-ID: <Y1J6F2ZEyRC19xy7@gondor.apana.org.au>
References: <20221014100319.5259-1-yekai13@huawei.com>
 <20221014100319.5259-2-yekai13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221014100319.5259-2-yekai13@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 14, 2022 at 10:03:17AM +0000, Kai Ye wrote:
> Increase the buffer to prevent stack overflow by fuzz test.
> 
> Signed-off-by: Kai Ye <yekai13@huawei.com>
> ---
>  drivers/crypto/hisilicon/qm.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
> index e3edb176d976..5d79e9f0e7e1 100644
> --- a/drivers/crypto/hisilicon/qm.c
> +++ b/drivers/crypto/hisilicon/qm.c
> @@ -250,7 +250,6 @@
>  #define QM_QOS_MIN_CIR_B		100
>  #define QM_QOS_MAX_CIR_U		6
>  #define QM_QOS_MAX_CIR_S		11
> -#define QM_QOS_VAL_MAX_LEN		32
>  #define QM_DFX_BASE		0x0100000
>  #define QM_DFX_STATE1		0x0104000
>  #define QM_DFX_STATE2		0x01040C8
> @@ -4612,7 +4611,7 @@ static ssize_t qm_get_qos_value(struct hisi_qm *qm, const char *buf,
>  			       unsigned int *fun_index)
>  {
>  	char tbuf_bdf[QM_DBG_READ_LEN] = {0};
> -	char val_buf[QM_QOS_VAL_MAX_LEN] = {0};
> +	char val_buf[QM_DBG_READ_LEN] = {0};

Please document how this value was derived in the patch log.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
