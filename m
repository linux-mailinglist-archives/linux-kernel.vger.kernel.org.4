Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9F26DAFAC
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 17:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbjDGP3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 11:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjDGP3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 11:29:46 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C9026A5A;
        Fri,  7 Apr 2023 08:29:45 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-17aeb49429eso45993767fac.6;
        Fri, 07 Apr 2023 08:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680881384; x=1683473384;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W6QmnGy4Q8kGJSQkc03Hd5Fyd7ynCqj61KvTIEzBUaQ=;
        b=pQd/tPiKlYZC+eNmpJyCjegxQ87sdjhxl2Tz4XT2lAGislqXeYGCJv/ZaA1yUHwJe6
         nySGv9m0vAstXY/OHApR3OE9D2XiEAIsSQB/WcXh5wfY4Tvijp6nRA15k4320IUsBhNT
         U1qnAImGcl5qZrdZaroG24nPT0aXOltyMtPwIfCCF0+u0GVPzgbMYk8CZTGEneVh7YtO
         BCSMXgBWeAgCW9fUZSMaKUfZ2JT+yVuduVdijqY0iLaNC+7zdlTaRw02H+CLUvPLk8SW
         lJpBCbZ2OzSaBfegb4xTNZ1sK7C78IzMdcTbx660NEFA97+FcJWIKJpWy12V3cfmKmhZ
         A+9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680881384; x=1683473384;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W6QmnGy4Q8kGJSQkc03Hd5Fyd7ynCqj61KvTIEzBUaQ=;
        b=LHfb3hzll2OjwLvLu6Fl335BZGfSnZiBCynJ/1bbg3KrgbbqjewD5EwN1rzHxWlyqr
         NtBxKHU+1W9a42lNSdipGOd/SjVuwPkvlxgGXNAHjDoR9xjX4lr3L757OZ36lEM9+EC4
         NbEnyqVxFSwuOI9bsO66aUxmmGsWI726xP2hhUTB+SkW+bubBgHL4upGLpFaxLhRcDLp
         lq0Kum9VOr7jGgCQjbcPbs7Smsb1Iu2Ahu5bQRHnOiLSDJI/4YRoFLmKSoSkMJV376N3
         o/+DpXHmBjxjBBKyR58K6h3933fxGGtseSmxN28AZ0ztJycbRbnAkugy7woAIp7u9D6v
         Hkpw==
X-Gm-Message-State: AAQBX9fAmmpbPf7e6ruKq87vM9/Nh81OChu6uBAFuptTZSHYyw1O53+U
        ak8f8hWhagUwyNTdqhU4VI0qzPHOCbA=
X-Google-Smtp-Source: AKy350Y7vPsy3E2Sc+Xg9CgybjXGySasdsV2+qnJsJf2t2y5sNE3Y+N7PoJ613x774ZIbeLHw8pteA==
X-Received: by 2002:a05:6870:548d:b0:180:be0e:299f with SMTP id f13-20020a056870548d00b00180be0e299fmr1725438oan.0.1680881384199;
        Fri, 07 Apr 2023 08:29:44 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u4-20020a4a9e84000000b00524faf3d2d7sm1710179ook.41.2023.04.07.08.29.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 08:29:43 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 7 Apr 2023 08:29:41 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] MAINTAINERS: hwmon: drop Agathe Porte
Message-ID: <b3c1bab7-bc57-4fde-ac5d-11d638d74c89@roeck-us.net>
References: <20230406204750.3017850-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230406204750.3017850-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=0.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 06, 2023 at 10:47:50PM +0200, Krzysztof Kozlowski wrote:
> Mails to Agathe Porte bounce ("550 5.4.1 Recipient address rejected:
> Access denied. AS(201806281)").
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Applied.

Thanks,
Guenter

> 
> Changes since v1:
> 1. Update also bindings.
> ---
>  Documentation/devicetree/bindings/hwmon/ti,tmp464.yaml | 2 +-
>  MAINTAINERS                                            | 1 -
>  2 files changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/ti,tmp464.yaml b/Documentation/devicetree/bindings/hwmon/ti,tmp464.yaml
> index e7493e25a7d2..f9c00cbb2806 100644
> --- a/Documentation/devicetree/bindings/hwmon/ti,tmp464.yaml
> +++ b/Documentation/devicetree/bindings/hwmon/ti,tmp464.yaml
> @@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>  title: TMP464 and TMP468 temperature sensors
>  
>  maintainers:
> -  - Agathe Porte <agathe.porte@nokia.com>
> +  - Guenter Roeck <linux@roeck-us.net>
>  
>  description: |
>    ±0.0625°C Remote and Local temperature sensor
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 99b665e85f0a..7f0b8076f144 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -21173,7 +21173,6 @@ F:	Documentation/hwmon/tmp401.rst
>  F:	drivers/hwmon/tmp401.c
>  
>  TMP464 HARDWARE MONITOR DRIVER
> -M:	Agathe Porte <agathe.porte@nokia.com>
>  M:	Guenter Roeck <linux@roeck-us.net>
>  L:	linux-hwmon@vger.kernel.org
>  S:	Maintained
