Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3643F6B69FE
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 19:20:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231829AbjCLSUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 14:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231193AbjCLSTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 14:19:42 -0400
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E14B83C78B;
        Sun, 12 Mar 2023 11:12:42 -0700 (PDT)
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-177b78067ffso410821fac.7;
        Sun, 12 Mar 2023 11:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678644617;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/5OWdrxNHbrZ4Nz2Tj3c5aciSG4U6fCqb++Fj/eR2zw=;
        b=A30SVc7P/2K17UUXFEJm+5fxj+LazUi9c3iEeRiCMX+0X+XxZtCaYpoUqD4GXOmjwV
         UgbrK50LZx+QM2k86Mkgp+Q4NiguwLaeFeirp8v/mpIe4/RbDgH14wELmJy+U+JABPKk
         WQGrK1SK/Z9W8l+Ztjf/xr4HeKx8AS/X6wI11NYcJOqdpFkoWAdIRG9CoQMsg7SI+TY6
         2mgugcNJsK0HEkFmiMWhzFGT3qnCFKskM0CBqnOCq5v1VZu6hbypZ6qEuFKsOaiLW49J
         nTDbEMFuQmwEZyW19Zsyo19B/M8buUJvu6X0cK43Qj3hvvUCMkbfexq1mOAgS4ZL9+w1
         XSyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678644617;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/5OWdrxNHbrZ4Nz2Tj3c5aciSG4U6fCqb++Fj/eR2zw=;
        b=LIvbR5/5ht0ffSgesfv99ryaMBUBugI8ZkCqVRjB3/oJnB5mw2D7jF3SDC1t0Cx8r9
         zE1LXV7bmkIrKMm3k6GIiELmZdIpHiA8Xkm4Udfav13rT777jPSRnMeymMQrPGdtV/0W
         8Goyedf2Hmp/M0W+Bea301f831JbVwAIb757wR92Tinf2uMgsYNFXPvqztFmJ+n99Ww/
         /aWcW+K27J8MWtzYLIMDrov7B/YQCjKgPqb7n8V2QbQejMgKrZR2gumJmpdW0nwBbAkd
         +0DwwkSflycjvGSV93hDIJN4oAxeadVu06P4j12NFXpgFymks1sFLKFLQRrnCzudLdZq
         +Cfg==
X-Gm-Message-State: AO0yUKWAjYgH7sy4qSuzUu747PdbLK1lxKYjScrlwdY4t+AtCJ/FTxue
        imEsw40jPH8cNmtIvwoc77f2EVCX9Ao=
X-Google-Smtp-Source: AK7set86yzXz3FzWQ4JlBAq6djBAsmrboViOfeRyOFjOAZ5npSRtjnPvPPH61KXd7enLLum2Sb1XWg==
X-Received: by 2002:a05:6870:e40c:b0:16e:907:e198 with SMTP id n12-20020a056870e40c00b0016e0907e198mr18895797oag.45.1678644616885;
        Sun, 12 Mar 2023 11:10:16 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z13-20020a056870e14d00b00172721f6cd5sm2261635oaa.16.2023.03.12.11.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 11:10:16 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 12 Mar 2023 11:10:15 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Eric Tremblay <etremblay@distech-controls.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] hwmon: tmp512: mark OF related data as maybe unused
Message-ID: <ad8c23e2-8a92-4fdd-b785-c485ebb597a5@roeck-us.net>
References: <20230311111610.251774-1-krzysztof.kozlowski@linaro.org>
 <20230311111610.251774-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230311111610.251774-2-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 11, 2023 at 12:16:10PM +0100, Krzysztof Kozlowski wrote:
> The driver can be compile tested with !CONFIG_OF making certain data
> unused:
> 
>   drivers/hwmon/tmp513.c:610:34: error: ‘tmp51x_of_match’ defined but not used [-Werror=unused-const-variable=]
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/tmp513.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/tmp513.c b/drivers/hwmon/tmp513.c
> index 47bbe47e062f..78cdd2d2d875 100644
> --- a/drivers/hwmon/tmp513.c
> +++ b/drivers/hwmon/tmp513.c
> @@ -607,7 +607,7 @@ static const struct i2c_device_id tmp51x_id[] = {
>  };
>  MODULE_DEVICE_TABLE(i2c, tmp51x_id);
>  
> -static const struct of_device_id tmp51x_of_match[] = {
> +static const struct of_device_id tmp51x_of_match[] __maybe_unused = {
>  	{
>  		.compatible = "ti,tmp512",
>  		.data = (void *)tmp512
