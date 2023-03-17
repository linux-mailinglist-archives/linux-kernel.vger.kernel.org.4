Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DCC96BE7E7
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 12:21:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjCQLU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 07:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbjCQLU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 07:20:56 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1144E1FEA;
        Fri, 17 Mar 2023 04:20:25 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id c4so2904592pfl.0;
        Fri, 17 Mar 2023 04:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679052025;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KH3sDhveeP+HgjB/MBfU5c/5KaPz4VTPorwSz2k9Oik=;
        b=lJUscY2d4a6HncL6cbFB7bK+fd9kDlRHz42ieVf54xv45lC5bbYAFwzknil9nBDR3P
         FJpGUt/rw3YidoDR/0LNahaxQA5SbhZFXG0F1F7+Z/m1i8PTKuy6fcyBFGQlanCk7UOI
         2/UfAmdZi0m2zTmkSB2BWhrM1VSmxs2eqENG0UH2bFDzfxpptr47YmIT9mWUCbjQmOXw
         fn3o4lEc207zPD7qA9b2wkjlFkvNOmxrL46A7quJaYNgArArsN6iav+pbfxvpTmkPvRF
         TnNrACWIRef+zSPOGveRJRO5xGjp6Sd7tYAEZ6P83E4Au29bi03AOp65pJkFyS+G2cqx
         ZBdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679052025;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KH3sDhveeP+HgjB/MBfU5c/5KaPz4VTPorwSz2k9Oik=;
        b=FHxGxsTcS9q5YCSX2xEYZ38x/I0UYbyfgCGvOa+aTQuidqtjQXMoJD9uyjWkUcXtgf
         6ZfCTWnnIPLyNNkSKY5ZTDNxu5Iu8xjoGr6pcTAOoN/nPRRpsZGxiHvbt5Cy75xgB1Sa
         V9yv3zueyaIMgFnP45FGjHGSYGMW88aoSdrxMtTQWFpISAJqByvjE9URvXgYNz/J5TSo
         3h/YyU5+tv/7Dy2LCOTQcMY1tCGzw6PYJDK+eqvhO+dcmu5fevID78uO3lUv/QEJ/eI7
         hehAJ60/o1uloirmffUd2agR7MzwJfgqYzA2ulVC88UYFsvmZ0e+5jTmBKVekgBy1IP4
         S4HA==
X-Gm-Message-State: AO0yUKXurj/PP8AHum1TG2vxfNgRV02IIF+gahmmF6hjd0JLV74PnevS
        duVHjoNj5rpXSOq2DLaUVrM=
X-Google-Smtp-Source: AK7set8S3IgT90Iwi4OgXWmUJoFTXB0GAENTgqr+iLtDA+giTAnJ48TQtwwhBFwxNP9uDYoSzQ9lFA==
X-Received: by 2002:a62:7910:0:b0:626:248d:4ece with SMTP id u16-20020a627910000000b00626248d4ecemr1879513pfc.30.1679052025033;
        Fri, 17 Mar 2023 04:20:25 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:d084:8252:e846:af61])
        by smtp.gmail.com with ESMTPSA id x5-20020aa79185000000b0062612b97cfdsm1323540pfa.123.2023.03.17.04.20.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 04:20:24 -0700 (PDT)
Date:   Fri, 17 Mar 2023 04:20:20 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 3/4] Input: sun4i-ts: drop of_match_ptr for ID table
Message-ID: <ZBRM9KV9nDnjao/D@google.com>
References: <20230312131514.351603-1-krzysztof.kozlowski@linaro.org>
 <20230312131514.351603-3-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230312131514.351603-3-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 12, 2023 at 02:15:13PM +0100, Krzysztof Kozlowski wrote:
> The driver can match only via the DT table so the table should be always
> used and the of_match_ptr does not have any sense (this also allows ACPI
> matching via PRP0001, even though it might not be relevant here).  This
> also fixes !CONFIG_OF error:
> 
>   drivers/input/touchscreen/sun4i-ts.c:392:34: error: ‘sun4i_ts_of_match’ defined but not used [-Werror=unused-const-variable=]
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied, thank you.

-- 
Dmitry
