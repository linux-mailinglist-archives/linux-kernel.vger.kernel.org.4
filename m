Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9285F6DB078
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 18:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbjDGQWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 12:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbjDGQWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 12:22:43 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D54D6BB8E;
        Fri,  7 Apr 2023 09:22:42 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-17aceccdcf6so46092823fac.9;
        Fri, 07 Apr 2023 09:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680884562; x=1683476562;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cgXvgDF0Hwz78yLb5teBoQZ5GeA/oS4aahtnvYtFVmE=;
        b=ikUxbKSZAQa+AebeM1Eq2p9BLibeEH+35T6OrwglmZKquzeaNUJGhpRii4hkdxzSXt
         Xu3A2unnpglsa33ZW5MKziuv1Jzbu22qqx7b421ta18hi4lIs+IFatZlHKS/9MAKF1++
         ufBD6vVEYVLnOdfhBRPgyFgQ/LaNE/DW5JGKtsPsLsvnMEFq3jrPfQxn3Ijen210UNnU
         9/H1OSJrSC5t3ftd/AQHsb/MV6WtB1awxKtoBlqPjnfLXMD75ZTw7vlnNJPMqv4Qm5uM
         yJGgm0FoZABsG5y0pZV8UTBs/+UGHsOEiMSEloC0l3y5LGD5c3zRxRRdV+bCo+vvFx+N
         XITQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680884562; x=1683476562;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cgXvgDF0Hwz78yLb5teBoQZ5GeA/oS4aahtnvYtFVmE=;
        b=yEuSPD+jaw1xDc2g6B1WuATvQwGTx/FcjouqF669BjXDiuzHP/bfF+5QxNLuDh00DJ
         W/kmVytSQYVMH1aAxAsGdbYEtvI7+HnHBBiz9X/ViG9vscgn8tUlFh+shOHk/6poUDRj
         9WYJSBOnajgZHXnO8/bHj5m5zGH5iskcn8NTtjKrdeTZjjDPwmdBzrrGUr1cuSGeJPDl
         WQ2HtZ6hFB7VMoIyJnZq51+X3t3qbE9vFa431UiM6/ALazzZwnRWAJHm+oD/j7XL5WXx
         18tvnaQBI/IFX8EA4a+QCSqg4f26fMHRb3XtPYwsCalDuqxX+VNWCDuS3NMGossHEcaw
         9YDQ==
X-Gm-Message-State: AAQBX9foqBW5q2mDEYthAiGuJ4b0eYyXJC0bH2e+2BX6K//5/PkhXOtP
        oeDimj+KuWqZewcHKf306dQ=
X-Google-Smtp-Source: AKy350bNoIkMkysFfimFYivJmWPnHJPdz+3defAKjQYpHoGEQLBnQevcqD9/dwM6Z+lHhUvnGs+mHQ==
X-Received: by 2002:a05:6870:b69f:b0:17e:cb7:29bc with SMTP id cy31-20020a056870b69f00b0017e0cb729bcmr1943714oab.13.1680884562176;
        Fri, 07 Apr 2023 09:22:42 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id bf24-20020a0568700a1800b0017264f96879sm1750415oac.17.2023.04.07.09.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 09:22:41 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 7 Apr 2023 09:22:40 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Svyatoslav Ryhel <clamor95@gmail.com>
Cc:     Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Add power supply for INA2XX
Message-ID: <68ef9b99-578f-4ea9-8c0e-613b7d27b6aa@roeck-us.net>
References: <20230407160508.20479-1-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230407160508.20479-1-clamor95@gmail.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 07, 2023 at 07:05:06PM +0300, Svyatoslav Ryhel wrote:
> TI ina2xx hwmon has vs power supply, add one for correct work.
> 
> Svyatoslav Ryhel (2):
>   dt-bindings: hwmon: ina2xx: add supply property
>   hwmon: ina2xx: add optional regulator support
> 

Change log missing.

Guenter

>  Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml | 5 +++++
>  drivers/hwmon/ina2xx.c                                 | 4 ++++
>  2 files changed, 9 insertions(+)
> 
> -- 
> 2.37.2
> 
