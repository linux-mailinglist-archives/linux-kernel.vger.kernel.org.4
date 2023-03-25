Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED94E6C8BDC
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 07:46:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231621AbjCYGqd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 02:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjCYGq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 02:46:29 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F101514EA0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 23:46:28 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id i5so16164868eda.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 23:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679726787;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t31lSdxlv+f3UnKTCzTXxPs8SFs291Ak4ggkxKHEWCQ=;
        b=e85LsIzLXSkT6C6qzyR6esfIlJwHGYIuolsxpNnw5tvV9y5tDCdl1Qg2BlDfObHagg
         yIRCfK7X5P7COJwH+93g72ZCQbk363DZT2jw6tdoCQqwk/tG9UEsTff/B8pFiwMImGOT
         +I/tYfVWlrrAUulcuCxRGew85XWWP5iznzIFwYAbAZuDQ5kzEA2iTWuMGYhuQrEqYacI
         4C3aNAHkl/tUjCLnjtZ+i/E8+rPlzMvpBYAjMv6dRGGb+UwS0b126I1HnHV292hu+4IT
         PK5RijKaOJ3p4ZIdyVeMzdFc47dsM0+7woqrGfxYZLzwzpLFzvHkeYIoM22o2dE1eycO
         ZWvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679726787;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t31lSdxlv+f3UnKTCzTXxPs8SFs291Ak4ggkxKHEWCQ=;
        b=Lg6IbRbjvWkPeRlh8sY0W4vGfYGRwyOXE+AlorITgGF99vvbOvU7DjYUjozbUVQNn2
         HwohkwLrNRjLlHNqSJUSD1MfiGveV1eZOdMpQWWHDDf8ETGQhEGTWSd974o29VoZKEhC
         RWDgmD4YXXEDtrMWOuI4eNvocFFx092VyDuZ15UYjCb8tST7XCjMaSVd2uy5WjBbw3hB
         mBS/46q3BCkD1RJ77bQIeSJ6QxXl9zrJeZRow7rfex1N6aSESP5cvIO0uKrvcG6tQcgT
         OqNnDosc+i/bIou2G0Xj3XZA6w65cBPYPOW38SCKwy8fysgJOtgf85cbWGDRIwBpM72k
         gVUg==
X-Gm-Message-State: AAQBX9ffgqofjJhvbahk1FKlC0GG3q6TsZAcoaotACf5wYElvgBQCatD
        fuNQpi1DD62CnH859zGczyI=
X-Google-Smtp-Source: AKy350Z4pgYd8lR+O+hzCHw4O91G7VyXRBc7036pm9ql4cKpkKK5ONOROkWXHrjQJTd2IP89fQMPGg==
X-Received: by 2002:a17:906:f190:b0:931:a321:7640 with SMTP id gs16-20020a170906f19000b00931a3217640mr6505658ejb.74.1679726787167;
        Fri, 24 Mar 2023 23:46:27 -0700 (PDT)
Received: from kista.localnet (82-149-1-233.dynamic.telemach.net. [82.149.1.233])
        by smtp.gmail.com with ESMTPSA id i19-20020a170906251300b009312cc428e4sm11287169ejb.165.2023.03.24.23.46.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 23:46:26 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     srinivas.kandagatla@linaro.org,
        Yang Li <yang.lee@linux.alibaba.com>
Cc:     wens@csie.org, samuel@sholland.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>
Subject: Re: [PATCH -next] nvmem: sunxi_sid: Use devm_platform_ioremap_resource()
Date:   Sat, 25 Mar 2023 07:46:25 +0100
Message-ID: <2671819.mvXUDI8C0e@kista>
In-Reply-To: <20230324070449.8182-1-yang.lee@linux.alibaba.com>
References: <20230324070449.8182-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne petek, 24. marec 2023 ob 08:04:49 CET je Yang Li napisal(a):
> According to commit 7945f929f1a7 ("drivers: provide
> devm_platform_ioremap_resource()"), convert platform_get_resource(),
> devm_ioremap_resource() to a single call to use
> devm_platform_ioremap_resource(), as this is exactly what this function
> does.
> 
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


