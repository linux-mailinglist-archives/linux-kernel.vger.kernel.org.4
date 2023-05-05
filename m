Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 235CE6F7BD2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 06:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbjEEEVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 00:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjEEEUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 00:20:55 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F949AD1A;
        Thu,  4 May 2023 21:20:54 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-64115eef620so17004060b3a.1;
        Thu, 04 May 2023 21:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683260453; x=1685852453;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T+H5ShYKXnau2RWmBTnF7eshUhRmfZdb8St2JsqG3xU=;
        b=LfjctpWuD10Xa/y2KqlBIfxZynN6xBSPexmgYWukzTddf1+ZudamLY92gLUWBq2C/l
         y0uIsNaat7nYupBL477HofEtd+V8m7xMTYp31zNM+ade7D53Fp1EXCAlKFspGZijF1Ow
         J4T5vy/ix7UGME9yqY0b096/ZCnBo3Lc/JTvYixq5v+PnaydfKofSQcQX343cXxCGK3f
         db0+zPfPTU6mdQlfNKYHcFEuzBYZPaeSszsUnK3YLJVW/AVsdXWv5jp64iCX9HouJBoa
         qBrxWMbvCIvXdhwvFo56MBo2GchhSb39Zkhbp2nrFaFJiFMLKjgDZ5Go7wmC7wsUyy+Y
         gq5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683260453; x=1685852453;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T+H5ShYKXnau2RWmBTnF7eshUhRmfZdb8St2JsqG3xU=;
        b=hL8Rkrx4/ZFpkFlmkOsPMB7/Fe/a6AeuMR7yP/pM42c+wWzlK5lFXmey8BBnkK91A9
         fEiyvCtCEaMQsw46fKKzJUbNqabAsx2bziCY0yAPSCu2qNv/fVEnQD+wGcc3qxQbqP8F
         Q7C5nsrE77dkz5zfebMC3crt7mckVCUjKQ6fUpMLpwwaUv8NPS86CSUjF97NUt2yK50A
         5imayeW3V6tlgBXji+ndoMS+8p0YMZlHEF/1Sx/bfshtGNdl/BlhYJW3/fYdfydgj9vE
         K3HNYHmI32asAL1vQJf4QVLVzJGKh6uO7HYsVjMrxx+tMAL71Tw5/14FLvljN+DElG6M
         LZDQ==
X-Gm-Message-State: AC+VfDwRnzHYP+tClPUZK6ZgW1PhbXd0e5asU/vqb7iyxdNr9AjtQPVD
        0wpHfBH5BLErLXL9uRKlxiaZtek/Lhs=
X-Google-Smtp-Source: ACHHUZ7A887DgMwC2RoPEX/M1B79k9R2hovEnsFLOaS+XMafztx750rhlkXHB0rW0I+eVc9e087Wdw==
X-Received: by 2002:a17:902:c945:b0:1a1:d54b:71df with SMTP id i5-20020a170902c94500b001a1d54b71dfmr570535pla.0.1683260453467;
        Thu, 04 May 2023 21:20:53 -0700 (PDT)
Received: from debian.me (subs03-180-214-233-25.three.co.id. [180.214.233.25])
        by smtp.gmail.com with ESMTPSA id ik26-20020a170902ab1a00b001aaeeeebaf1sm489188plb.201.2023.05.04.21.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 21:20:52 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 067B4106259; Fri,  5 May 2023 11:20:49 +0700 (WIB)
Date:   Fri, 5 May 2023 11:20:49 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     James Seo <james@equiv.tech>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC 04/11] Documentation/hwmon: Revise hwmon kernel API
 reference
Message-ID: <ZFSEIahcPf2QUYDv@debian.me>
References: <20230504075752.1320967-1-james@equiv.tech>
 <20230504075752.1320967-5-james@equiv.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230504075752.1320967-5-james@equiv.tech>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 04, 2023 at 12:57:45AM -0700, James Seo wrote:
> +========================================
>  The Linux Hardware Monitoring kernel API
>  ========================================
>  
>  Guenter Roeck

I forget to mention this.

Elsewhere in the doc tree (Documentation/), metadata is usually marked
up like:

---- >8 ----
diff --git a/Documentation/hwmon/hwmon-kernel-api.rst b/Documentation/hwmon/hwmon-kernel-api.rst
index cf084e04052228..541835f7826352 100644
--- a/Documentation/hwmon/hwmon-kernel-api.rst
+++ b/Documentation/hwmon/hwmon-kernel-api.rst
@@ -2,7 +2,7 @@
 The Linux Hardware Monitoring kernel API
 ========================================
 
-Guenter Roeck
+:Author: Guenter Roeck
 
 .. contents::
 
Thanks.

-- 
An old man doll... just what I always wanted! - Clara
