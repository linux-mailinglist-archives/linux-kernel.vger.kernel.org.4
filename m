Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0D963FD67
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 01:58:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231961AbiLBA6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 19:58:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231591AbiLBA6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 19:58:20 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F215C0C0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 16:58:19 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id g7so5141483lfv.5
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 16:58:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MxkuzgUgTifQFdxhVWtsmKUpSCQdyimcV2FkUnufBLc=;
        b=hEKWleQh2i+coIcgnXZbCte2WweMX/4rdEPNBC4I72YPpG558YYdUC4fOePrPsorTm
         EHPrqFfQsXLYlxX2BcJfTnzEoMNfkMDARFrw9zWcv2rvRuq47qOzVq7h3tzi2rM6UrgV
         T9I/XGQ8zYHn5ePdix76dWi26hvtQt9cjY26rSG+R7eRGCwqy7Pibsgxy+XiDgud+2RW
         6DloAOKq3Cn5k/2bNPsTZMwO9Gf5PVje3i79eHmMzYCh0Y5K7DH2ImTv54BklKMpeY6/
         DIs5AhoOB3wOf+bQNB+nAi48QTPsPJ2I5r1Xw8Nj5Ixxawy26rPBYAGupqgVqXkouDHC
         xzTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MxkuzgUgTifQFdxhVWtsmKUpSCQdyimcV2FkUnufBLc=;
        b=liiQDsFWZ5isZ8yKHMS2szqSC5jysZhUU/j3cQkaCB+Nd+37k3qaUQlUGuttI6Z6xW
         Kmh88PJ7ByB2k4Ce/DTJ3R77yiD1NRvn91Vqoq5m2OgJYN3WAUUVX29DExUy4gmrrCR4
         cGfz36UM7bEi8GP0akFwXpva3gxz0Iip2e9u8sBMrH288xF1z1Pa6K2aprjKNwXGchBF
         xKxY7ALnycBhIptfyqPfUJDdJzEJfA0HxHh9Q64a4mk3JW0eT9WWH2sJE3VOwYbooaO9
         jc4wkMJXm37BXtLUMNQY4PoLsJMTLF4MqqXP/I60U3Wk1XPoJJ5Tg44U6jAGzFRchVyO
         yA3Q==
X-Gm-Message-State: ANoB5pmvevIuJas+x+5QjnABpY8CePYeqF2ENsgPO/A2XwtTxD01k28X
        Hy+tE8UCxoGD7F1Hx52CCAMv+Q==
X-Google-Smtp-Source: AA0mqf7ugLlYgzqNY4td3eTdffNA1JNbGconIkradRBMScyhPpphWZqVWKGCXfhlAfixQHasGwz7Fw==
X-Received: by 2002:ac2:558c:0:b0:4a2:4b78:a8e8 with SMTP id v12-20020ac2558c000000b004a24b78a8e8mr19587673lfg.292.1669942697389;
        Thu, 01 Dec 2022 16:58:17 -0800 (PST)
Received: from mutt (c-e429e555.07-21-73746f28.bbcust.telenor.se. [85.229.41.228])
        by smtp.gmail.com with ESMTPSA id s22-20020a056512315600b004979e1ff641sm815816lfi.115.2022.12.01.16.58.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 16:58:16 -0800 (PST)
Date:   Fri, 2 Dec 2022 01:58:14 +0100
From:   Anders Roxell <anders.roxell@linaro.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>,
        Pankaj Gupta <pankaj.gupta@nxp.com>,
        Gaurav Jain <gaurav.jain@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, kernel test robot <lkp@intel.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] crypto/caam: Avoid GCC constprop bug warning
Message-ID: <20221202005814.GD69385@mutt>
References: <20221028210527.never.934-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221028210527.never.934-kees@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-10-28 14:05, Kees Cook wrote:
> GCC 12 appears to perform constant propagation incompletely(?) and can
> no longer notice that "len" is always 0 when "data" is NULL. Expand the
> check to avoid warnings about memcpy() having a NULL argument:
> 
>    ...
>                     from drivers/crypto/caam/key_gen.c:8:
>    drivers/crypto/caam/desc_constr.h: In function 'append_data.constprop':
>    include/linux/fortify-string.h:48:33: warning: argument 2 null where non-null expected [-Wnonnull]
>       48 | #define __underlying_memcpy     __builtin_memcpy
>          |                                 ^
>    include/linux/fortify-string.h:438:9: note: in expansion of macro '__underlying_memcpy'
>      438 |         __underlying_##op(p, q, __fortify_size);                        \
>          |         ^~~~~~~~~~~~~
> 
> The NULL was being propagated from:
> 
>         append_fifo_load_as_imm(desc, NULL, 0, LDST_CLASS_2_CCB |
>                                 FIFOLD_TYPE_MSG | FIFOLD_TYPE_LAST2);
> ...
> static inline void append_##cmd##_as_imm(u32 * const desc, const void *data, \
>                                          unsigned int len, u32 options) \
> { \
>         PRINT_POS; \
>         append_cmd_data(desc, data, len, CMD_##op | options); \
> }
> ...
> APPEND_CMD_PTR_TO_IMM(fifo_load, FIFO_LOAD);
> ...
> static inline void append_cmd_data(u32 * const desc, const void *data, int len,
>                                    u32 command)
> {
>         append_cmd(desc, command | IMMEDIATE | len);
>         append_data(desc, data, len);
> }
> 
> Cc: "Horia Geantă" <horia.geanta@nxp.com>
> Cc: Pankaj Gupta <pankaj.gupta@nxp.com>
> Cc: Gaurav Jain <gaurav.jain@nxp.com>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: linux-crypto@vger.kernel.org
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/lkml/202210290446.qBayTfzl-lkp@intel.com
> Signed-off-by: Kees Cook <keescook@chromium.org>


Tested-by: Anders Roxell <anders.roxell@linaro.org>

> ---
>  drivers/crypto/caam/desc_constr.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/crypto/caam/desc_constr.h b/drivers/crypto/caam/desc_constr.h
> index 62ce6421bb3f..ddbba8b00ab7 100644
> --- a/drivers/crypto/caam/desc_constr.h
> +++ b/drivers/crypto/caam/desc_constr.h
> @@ -163,7 +163,7 @@ static inline void append_data(u32 * const desc, const void *data, int len)
>  {
>  	u32 *offset = desc_end(desc);
>  
> -	if (len) /* avoid sparse warning: memcpy with byte count of 0 */
> +	if (data && len) /* avoid sparse warning: memcpy with byte count of 0 */

Maybe we should update the comment, since newer releases of sparse
doesn't warn about this.


Cheers,
Anders
