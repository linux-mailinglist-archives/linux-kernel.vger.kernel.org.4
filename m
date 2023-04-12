Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4E0F6DECAA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 09:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbjDLHiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 03:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbjDLHhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 03:37:40 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E1F1BC0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 00:37:38 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id g5so13279877wrb.5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 00:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681285057; x=1683877057;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CiF0mgU3/wD4pOn8H8hIqODLGj9JpvM6ISvsGRm0Re8=;
        b=RLM3qCOQYqUPqVlPl8GisAhq+i+qQ/Sf6zrRu4Pzx1bd/n3BJi/0ckvwQwk4bRa48w
         EcGKdZaG4z1jPm+MlRHSKOBx8bpnGjDp/8N/ZAk3GSw4g6wn4Ts2ljabxfXI5QDykNIS
         h8iGcPEcpbvavlZlNimUXGW5ELFvoglmIoWIYZRw5ZufVm4s83F18DZLfAoHwM1o6xSU
         m2aiAQ3oV8zRIRZczC7FTx7Ea2+K+vkGcmRgSewLxkQ81SanMCH36vPICKebxCuzDP2K
         dsiqSZ1H2GQ540pr5YimAwwEUhvgXRDzjyFWwPHAzwW2soKFcgc6yNdqXBszFobtNeAr
         BLpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681285057; x=1683877057;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CiF0mgU3/wD4pOn8H8hIqODLGj9JpvM6ISvsGRm0Re8=;
        b=0qQGM9LLHzrjFfvxVku9o+9TAYFLwJgZUX4FJebJsURm/+T8EMQ3iI5gUgUltrVXXN
         pS0M1SlZHxq464W7qeXnSNxEsx7wISfWiPJnBPrXRcjrolm6i2HmhDCgOhNZCoDIrOEq
         8HUYNhyZKdt8g/plnc7Pj63iItW9Q/9FEpYrcoZK/525+iZzVXsbdVkO2b5nCA7S/UEn
         a19l9IZutb18Cl5srJJxqKeMHDl5Sq9z9TN+bpq9P2KmQjF81t5h6hQPkkf2C6sPNsWF
         uax6dcsLmD0b26KRZRKxbk3+oQC/jmQ9IvYUqbYtHGKxQSUSeLRcXRYZtj4CF/hYV2mk
         d+Tg==
X-Gm-Message-State: AAQBX9cBTlnFHwVQUJe7Ey5Ln2AtDbikYFOKk3zJYJSLbS4qBm2wVbwv
        sANwYoqaTaTPvqH/MmtClY/h7g==
X-Google-Smtp-Source: AKy350Z/SLp317LxYEPlad+keulW3xjgxVXR1yy97XsOkHvy0kkKdPqlBPYhSQtIfSkn6yBlVfwwXg==
X-Received: by 2002:a05:6000:c:b0:2f4:f2c9:171b with SMTP id h12-20020a056000000c00b002f4f2c9171bmr59898wrx.17.1681285057178;
        Wed, 12 Apr 2023 00:37:37 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:b777:4c24:cbcf:795f? ([2a01:e0a:982:cbb0:b777:4c24:cbcf:795f])
        by smtp.gmail.com with ESMTPSA id l1-20020adfe581000000b002f22c44e974sm6598619wrm.102.2023.04.12.00.37.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Apr 2023 00:37:36 -0700 (PDT)
Message-ID: <055a9886-ea3f-6df2-f4a0-a3eff47e6b69@linaro.org>
Date:   Wed, 12 Apr 2023 09:37:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v1 2/5] mtd: rawnand: meson: replace GENMASK() macro with
 define
Content-Language: en-US
To:     Arseniy Krasnov <AVKrasnov@sberdevices.ru>,
        Liang Yang <liang.yang@amlogic.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Yixun Lan <yixun.lan@amlogic.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>
Cc:     oxffffaa@gmail.com, kernel@sberdevices.ru,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230412061700.1492474-1-AVKrasnov@sberdevices.ru>
 <20230412061700.1492474-3-AVKrasnov@sberdevices.ru>
Organization: Linaro Developer Services
In-Reply-To: <20230412061700.1492474-3-AVKrasnov@sberdevices.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/04/2023 08:16, Arseniy Krasnov wrote:

Please add a commit message

> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
> ---
>   drivers/mtd/nand/raw/meson_nand.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/meson_nand.c
> index 256c37c76526..45b53d420aed 100644
> --- a/drivers/mtd/nand/raw/meson_nand.c
> +++ b/drivers/mtd/nand/raw/meson_nand.c
> @@ -110,6 +110,8 @@
>   
>   #define PER_INFO_BYTE		8
>   
> +#define NFC_CMD_RAW_LEN		(GENMASK(13, 0))

Drop the () around GENMASK(13, 0)

> +
>   struct meson_nfc_nand_chip {
>   	struct list_head node;
>   	struct nand_chip nand;
> @@ -300,7 +302,7 @@ static void meson_nfc_cmd_access(struct nand_chip *nand, int raw, bool dir,
>   
>   	if (raw) {
>   		len = mtd->writesize + mtd->oobsize;
> -		cmd = (len & GENMASK(13, 0)) | scrambler | DMA_DIR(dir);
> +		cmd = (len & NFC_CMD_RAW_LEN) | scrambler | DMA_DIR(dir);
>   		writel(cmd, nfc->reg_base + NFC_REG_CMD);
>   		return;
>   	}
> @@ -550,7 +552,7 @@ static int meson_nfc_read_buf(struct nand_chip *nand, u8 *buf, int len)
>   	if (ret)
>   		goto out;
>   
> -	cmd = NFC_CMD_N2M | (len & GENMASK(13, 0));
> +	cmd = NFC_CMD_N2M | (len & NFC_CMD_RAW_LEN);
>   	writel(cmd, nfc->reg_base + NFC_REG_CMD);
>   
>   	meson_nfc_drain_cmd(nfc);
> @@ -574,7 +576,7 @@ static int meson_nfc_write_buf(struct nand_chip *nand, u8 *buf, int len)
>   	if (ret)
>   		return ret;
>   
> -	cmd = NFC_CMD_M2N | (len & GENMASK(13, 0));
> +	cmd = NFC_CMD_M2N | (len & NFC_CMD_RAW_LEN);
>   	writel(cmd, nfc->reg_base + NFC_REG_CMD);
>   
>   	meson_nfc_drain_cmd(nfc);

Thanks,
Neil
