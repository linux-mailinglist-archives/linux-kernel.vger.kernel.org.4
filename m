Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E85C70CDF3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 00:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234078AbjEVW3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 18:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234788AbjEVW2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 18:28:50 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC57811F;
        Mon, 22 May 2023 15:28:43 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-64d5f65a2f7so1447349b3a.1;
        Mon, 22 May 2023 15:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684794523; x=1687386523;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wLjCDw3QwK9X5eTbsYsJ0QqtTyYuhQZWy+R2beHbthE=;
        b=PZy+kdNXMQxFNGCmHbcndS3xPaLJOAO0NvYKwzyJKcZlLiOZSLe+MgL4nsWIUXrXLk
         vJjqHpxziV8NuwDMvLTkjSxasSNf2xGNaJZFMM/idDpLW5gi7vM9s8v7ozonxcFMK5MC
         TQZ0FNPqZZTMi9ypGpmoLNxIEzpuAK0QKtQywoufBUFmcaUwH4uCs1hRRzlhdn5HTL+y
         G1n/JlIm5XwEnofLuHR6DODjgP6d8dG8sXQAOCE/4hpltR13kqNC1wsNlSm+hou5UWw1
         4/Nc9IsOcSLZzt+hxgrWch+5+6AO4Z5O+658DlCjNq865BIV/Mljf5Tf1xaAr3UBsOwP
         YlIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684794523; x=1687386523;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wLjCDw3QwK9X5eTbsYsJ0QqtTyYuhQZWy+R2beHbthE=;
        b=ET0AjcFNtyyEF/qemOYSwHjAbg8IdH5dmN84e7susSECjv7ETLDexlmB3vE/U1pAFJ
         nX1WxjyWcc7VIUdHci69sXV3IpZ4uAfeNQZQjLIX6t8FIk38oD1KY3IxjwOMdrczgHl3
         Ku/SVz59yel9fdHRaNX2UoT8k9rpuVl0nI8J+OLQThk7bpXxzFnLrhbYm0/ZsvzoYL8e
         xkqNwkrLYdfh39tIIpWQnoD4mSQFYqgt5OGjANkLxg2jLESUrYYPcEqUgksseFjVsz4V
         1loH6Dh8pd4WDv3KQVqbnJR0s4iUZosBL86Tm3lrLN0bA7kQxtsJRDCNEJE4PJN0NXNZ
         CMJg==
X-Gm-Message-State: AC+VfDzjBedUVlxNDguZ7ou3dMr7u2jqGxlgU8uEEu0XMkGO2cWIA8H4
        J+3yMuybOn3T5xSfI6tM1wI=
X-Google-Smtp-Source: ACHHUZ7v2PTJU0KvDHJOwX01olVWqIu3tu+p5wahEbZ80AQTsXX3c0e0YsJO26QecsFA43RxTZ8jqQ==
X-Received: by 2002:a05:6a00:893:b0:647:e45f:1a4c with SMTP id q19-20020a056a00089300b00647e45f1a4cmr14615874pfj.11.1684794523236;
        Mon, 22 May 2023 15:28:43 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i24-20020aa787d8000000b0064d3e4c7658sm4695697pfo.96.2023.05.22.15.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 15:28:42 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 22 May 2023 15:28:41 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Matyas, Daniel" <Daniel.Matyas@analog.com>
Cc:     kernel test robot <lkp@intel.com>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v9 2/2] hwmon: max31827: add MAX31827 driver
Message-ID: <297d03ac-4fc3-4163-bac5-7abb74e1fa9e@roeck-us.net>
References: <20230516104609.7095-1-daniel.matyas@analog.com>
 <20230516104609.7095-2-daniel.matyas@analog.com>
 <0e49e860-6f2c-48cb-9ef7-af7891b95237@roeck-us.net>
 <PH0PR03MB6771D471E1AF58B0B50FE4D489439@PH0PR03MB6771.namprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PH0PR03MB6771D471E1AF58B0B50FE4D489439@PH0PR03MB6771.namprd03.prod.outlook.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2023 at 02:18:11PM +0000, Matyas, Daniel wrote:
> 
> 
> -----Original Message-----
> From: Guenter Roeck <groeck7@gmail.com> On Behalf Of Guenter Roeck
> Sent: Monday, May 22, 2023 4:25 PM
> To: Matyas, Daniel <Daniel.Matyas@analog.com>
> Cc: kernel test robot <lkp@intel.com>; Jean Delvare <jdelvare@suse.com>; Rob Herring <robh+dt@kernel.org>; Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>; Conor Dooley <conor+dt@kernel.org>; Jonathan Corbet <corbet@lwn.net>; linux-hwmon@vger.kernel.org; devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; linux-doc@vger.kernel.org
> Subject: Re: [PATCH v9 2/2] hwmon: max31827: add MAX31827 driver
> 
> [External]
> 
> On Tue, May 16, 2023 at 01:46:07PM +0300, Daniel Matyas wrote:
> > MAX31827 is a low-power temperature switch with I2C interface.
> > 
> > The device is a ±1°C accuracy from -40°C to +125°C
> > (12 bits) local temperature switch and sensor with I2C/SM- Bus 
> > interface. The combination of small 6-bump wafer-lev- el package (WLP) 
> > and high accuracy makes this temper- ature sensor/switch ideal for a 
> > wide range of applications.
> > 
> > Signed-off-by: Daniel Matyas <daniel.matyas@analog.com>
> > Reported-by: kernel test robot <lkp@intel.com>
> > Link: 
> > https://urldefense.com/v3/__https://lore.kernel.org/oe-kbuild-all/2023
> > 05112351.DBkFfs76-lkp@intel.com/__;!!A3Ni8CS0y2Y!5SeqSdRyCHcgA6Se6U-EN
> > I_MJfRPgB-FEVkuwWyb944DQypaZ5XQAS6N3aZiVDd1LZDGK45xp7KJHH8RSzw$
> > ---
> 
> Change log goes here. Without it, I'll have to manually re-review and compare against previous versions and look up comments to ensure that all feedback has been addressed. That will take time, which is always
> scarce.   don't have right now. My apologies, but that means that
> review and acceptance of your driver will be delayed.
> 
> Guenter
> 
> 
> Dear Guenter,
> 
> I didn't write a changelog, because I changed literally nothing in the code. I sent a new patch, because in the previous Krzysztof Kozlowski asked me to remove the '--base' when using 'git format-patch'. I wrote this to commit 1/2, but consider it necessary to write the same thing again in patch 2/2.
> 

In that case the appropriate change log would have been "no change
against v8", or "unchanged". Also, the change log should really include
all changes since v1, separated for each version.

v9: No change
v8: xxx
v7: yyy
...

Guenter

> I have the Reported-by flag, because I forgot to add it in patch v8.
> 
> I am sorry for the confusion!
> 
> Best regards,
> Daniel Matyas
