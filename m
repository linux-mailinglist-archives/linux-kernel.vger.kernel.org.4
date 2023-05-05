Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34F5F6F7BD7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 06:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbjEEE2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 00:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjEEE2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 00:28:02 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E8D87DB3;
        Thu,  4 May 2023 21:28:01 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6439f186366so191566b3a.2;
        Thu, 04 May 2023 21:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683260881; x=1685852881;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8bWXPTP9V/rNh36FOWh/lW/rMEx219E7peVwHM5/UkY=;
        b=Et0B++Xr3wsL/ORtnieJecJHbflY+ZVN/Xx0ZE7YQZ7JRqIWwHDwgvbCIxnEChi2Sf
         iM9AaS0dAXI1vTGBo7W/90cOBAwmmMplep+8Wi45ORbFMFhz6dShj+UvxnVVpC6hBqcl
         iqzPvv5c+OM3oJb//lqjK+lJC03oYdmkF49w4CRs3GkERwzhYkhXlS+W4VxQKPSsFKJW
         R56oSQSBe9Hkv38YfwsN6xKwSTTMPmc+Z5dseX/hMOaJlRXncKBDXDpZV8ZtH6CapJB3
         1H4IHfELZsbkTX+VCPxZasLfUf0pkC++JRii22IQuF52q2tatcRv0huOoOrN7E+eKQK2
         drcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683260881; x=1685852881;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8bWXPTP9V/rNh36FOWh/lW/rMEx219E7peVwHM5/UkY=;
        b=Lbljys5vmjC4Ly32Z5APHBSlv9h5aKHEvIOlygSUeMfbee8/G0MJAgRVs0uMxP0fAR
         SEJs6m8S6yz+ymrqENkL5B4jYhdBGyFOBs5EcSCqyj1gbUP83U6GqC6VLwpd58LovH36
         A/rqbBQrz5uEJTlEDpUiDEZ3D+MgLS5iEREwcnSR/M72AR3C76YB+qyFXCipmgKZmNlh
         UdkHXUCPeugpCYWkiuKygjEfdp3IBxeDq1V8UhmrdpE3NXu45oAWedCvT8PNloIR1a3a
         7mJHWzv4ZGNnHuSoqTPepMyd0/yFkmQfGI7zJfvfV9WowsEauSjPwkopL6Hi1xDFMiEE
         2sXw==
X-Gm-Message-State: AC+VfDx+3LhTOaE9JATsNoVujgKkeaDeGWD2LJKye1ZzXBruW445IoUa
        Wlu/woYkVuEWo+GSe2EBsAc=
X-Google-Smtp-Source: ACHHUZ5yWfdZ4d1rqUtXSOa7mTxJLpoitfe6NLXK3dCT7TtL+MOvVnM6kVfUAA6XAIelKzeHQZmi/g==
X-Received: by 2002:a05:6a00:a8d:b0:641:24bb:bbb1 with SMTP id b13-20020a056a000a8d00b0064124bbbbb1mr773597pfl.27.1683260881055;
        Thu, 04 May 2023 21:28:01 -0700 (PDT)
Received: from debian.me (subs03-180-214-233-25.three.co.id. [180.214.233.25])
        by smtp.gmail.com with ESMTPSA id m3-20020aa79003000000b0063d2d9990ecsm568605pfo.87.2023.05.04.21.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 21:28:00 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id E519D104C4C; Fri,  5 May 2023 11:27:57 +0700 (WIB)
Date:   Fri, 5 May 2023 11:27:57 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     James Seo <james@equiv.tech>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC 05/11] Documentation/hwmon: Revise PMBus core documentation
Message-ID: <ZFSFzaWZsS9qxmzz@debian.me>
References: <20230504075752.1320967-1-james@equiv.tech>
 <20230504075752.1320967-6-james@equiv.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230504075752.1320967-6-james@equiv.tech>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 04, 2023 at 12:57:46AM -0700, James Seo wrote:
> -[from pmbus.org] The Power Management Bus (PMBus) is an open standard
> -power-management protocol with a fully defined command language that facilitates
> -communication with power converters and other devices in a power system. The
> -protocol is implemented over the industry-standard SMBus serial interface and
> -enables programming, control, and real-time monitoring of compliant power
> -conversion products. This flexible and highly versatile standard allows for
> -communication between devices based on both analog and digital technologies, and
> -provides true interoperability which will reduce design complexity and shorten
> -time to market for power system designers. Pioneered by leading power supply and
> -semiconductor companies, this open power system standard is maintained and
> -promoted by the PMBus Implementers Forum (PMBus-IF), comprising 30+ adopters
> -with the objective to provide support to, and facilitate adoption among, users.
> +  The Power Management Bus (PMBus) is an open standard power-management protocol
> +  with a fully defined command language that facilitates communication with
> +  power converters and other devices in a power system. The protocol is
> +  implemented over the industry-standard SMBus serial interface and enables
> +  programming, control, and real-time monitoring of compliant power conversion
> +  products. This flexible and highly versatile standard allows for communication
> +  between devices based on both analog and digital technologies, and provides
> +  true interoperability which will reduce design complexity and shorten time to
> +  market for power system designers. Pioneered by leading power supply and
> +  semiconductor companies, this open power system standard is maintained and
> +  promoted by the PMBus Implementers Forum (PMBus-IF), comprising 30+ adopters
> +  with the objective to provide support to, and facilitate adoption among,
> +  users.
> +
> +    (from pmbus.org)

Seems like a candidate for attribution:

---- >8 ----
diff --git a/Documentation/hwmon/pmbus-core.rst b/Documentation/hwmon/pmbus-core.rst
index 2f88a03446d2be..75404f088fd777 100644
--- a/Documentation/hwmon/pmbus-core.rst
+++ b/Documentation/hwmon/pmbus-core.rst
@@ -21,7 +21,7 @@ Introduction
   with the objective to provide support to, and facilitate adoption among,
   users.
 
-    (from pmbus.org)
+  -- (from pmbus.org)
 
 Unfortunately, while PMBus commands are standardized, there are no mandatory
 commands, and manufacturers can add as many non-standard commands as they like.

Otherwise the formatting LGTM, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

-- 
An old man doll... just what I always wanted! - Clara
