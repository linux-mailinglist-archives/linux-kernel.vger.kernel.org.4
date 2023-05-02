Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3956F3C5C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 05:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233413AbjEBDXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 23:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbjEBDXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 23:23:46 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF51830FB;
        Mon,  1 May 2023 20:23:45 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-64115eef620so31492647b3a.1;
        Mon, 01 May 2023 20:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682997825; x=1685589825;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1M9netRuCAis4Ssb9iZBb2Idx5gyfZLsjCy0pMBEHYo=;
        b=YJzkTVzXK+8tD8Ly4Ttq161CvsWjUQO76pao3OUXo/+jrIBbvjeNlgp5k2HtjoiMOF
         IPdBFoU1J+IvQvU5s5fZUAOi+CjmZzBgag165e0yV8m53R1zEsJeUZohs3VFHr2igXD7
         htQCiI+seW1IBUmsKSq0PGHR0HD+OyL9kWIVYzqtKNIaSbj1zKXVIkqDYw8eiLkE4BLD
         IwqTu4Zj4nxRg/vMa/2kT+EcquO4LUyCSd98fI0kqe+IDYTdKtEhClBDP/WbaTNrt4T6
         idiSitzq0N1SaIUy4L0q6DfjRAx2CExwfbmzp8OQunMi9RbmQnOh88W5y4zWCrga7FOA
         pMVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682997825; x=1685589825;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1M9netRuCAis4Ssb9iZBb2Idx5gyfZLsjCy0pMBEHYo=;
        b=foEsxQbAiyJPVuy0b26L0S2TDHdEDmKBDLco6dhcpebpFe4mrxOCNlWeNLQR0VL78H
         n1oGO1sfoO04X8Eb47Ge7LIvOu60sEAJIfbQK0yiHaTrdUUn7JP46OfCw86+u/XcoVxn
         ZMnT/ygcKH6cHfBIyLsI+kpwlVzs5OLHlJOYRJ4Bz4M0F9IdWqm9waF30WpWhtTK1jQD
         6OnxNgvNhriLd/7Y+ruTTlOt1jFkHZrR8alnmQhbyltZhVDouJbnGZQPUz0gqT83yV0O
         MVqBQZ+xzsyK5FKW64TBH3h9LSRUAgliwc4gSrV5zxHtBRqybaEw5wdgYtltWmVaRnOX
         Jr4Q==
X-Gm-Message-State: AC+VfDy7ltZBUdpXjnRjzMVtaM5ZF8/mwmndsRdVl/GivEe+7nXILqz3
        yFIeX6Z/PKYraeWCTVCZKJg=
X-Google-Smtp-Source: ACHHUZ5G7DJgWgs42CE4FqAe2cAv+UM+sRx1HskAhK5ezw+vVPBw6Gxm81+CfN5beodfdEKD/v4yoA==
X-Received: by 2002:a05:6a00:2e91:b0:63b:54e4:871b with SMTP id fd17-20020a056a002e9100b0063b54e4871bmr20146376pfb.8.1682997824947;
        Mon, 01 May 2023 20:23:44 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:b6ce:736b:e4f7:adb])
        by smtp.gmail.com with ESMTPSA id i11-20020a63130b000000b00524dde7231dsm7880326pgl.9.2023.05.01.20.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 20:23:44 -0700 (PDT)
Date:   Mon, 1 May 2023 20:23:41 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     =?iso-8859-1?Q?Andr=E9?= Apitzsch <git@apitzsch.eu>
Cc:     Nick Dyer <nick@shmanahar.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2 0/2] Input: atmel_mxt_ts - support capacitive keys
Message-ID: <ZFCCPcKb9xaBZQee@google.com>
References: <20230407-atmel_keys-v2-0-92446a4343cb@apitzsch.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230407-atmel_keys-v2-0-92446a4343cb@apitzsch.eu>
X-Spam-Status: No, score=1.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 07, 2023 at 02:44:23PM +0200, André Apitzsch wrote:
> Add support for touch keys found in some Atmel touch controller
> configurations.
> 
> Signed-off-by: André Apitzsch <git@apitzsch.eu>
> ---
> Changes in v2:
>   * Added A-b, R-b tags

Applied the lot, thank you.

> 
> ---
> André Apitzsch (2):
>       dt-bindings: input: atmel,maxtouch: add linux,keycodes
>       Input: atmel_mxt_ts - support capacitive keys
> 
>  .../devicetree/bindings/input/atmel,maxtouch.yaml  |  7 ++
>  drivers/input/touchscreen/atmel_mxt_ts.c           | 85 ++++++++++++++++++++++
>  2 files changed, 92 insertions(+)
> ---
> base-commit: f2afccfefe7be1f7346564fe619277110d341f9b
> change-id: 20230407-atmel_keys-7a49c6b677b2
> 
> Best regards,
> -- 
> André Apitzsch <git@apitzsch.eu>
> 

-- 
Dmitry
