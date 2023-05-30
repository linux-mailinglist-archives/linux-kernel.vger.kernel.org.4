Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E23F771586C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 10:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbjE3I00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 04:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjE3I0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 04:26:23 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD38BE
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 01:26:22 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9741a0fd134so122590666b.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 01:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685435180; x=1688027180;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QSiMQ4VCxwywpzNt4v+h/rLE7yHkiDldVJtPxOvTVLQ=;
        b=mXJtf23EA0ZCPyt7av8WN/bITC1M2u+POjvSdaSeF/DJe4VF/n8Ano6tVV2L5VV1s1
         2j1jh3l0MlaEv9I4gfFib6VAAYB5057T8dA2iaOff9EMi8/lmtQQ3ADj/QHKlYox3H4N
         hTC7t1xU7CCxMRZaSUn7ZjsmfkkONPEX8BWIe4yVXOGb3NalCZvD0BjdiQB4py8FPeoJ
         4FI5cjmD/9x5Px9DcQ6dFDWX/Af0QcQigA56L5lLeAxqpv0F6B1VBrIvCm01ejm2IYQK
         ek4szT5k3mL89Qk/Z5MRlKHhz5PH/sNcc8c3vBGNVnP6Ro6qYkH//izuZEfUtoCatw+T
         pSWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685435180; x=1688027180;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QSiMQ4VCxwywpzNt4v+h/rLE7yHkiDldVJtPxOvTVLQ=;
        b=I3+rBwWQx1mlRphAqsDstmR5SebIa4NiSBoKljckFHmLsr63aYrcEnaN+cEldW40J1
         r3pqj4x6adAkoKYzTXkpYpccmbTo9r2wNYNbqXtaNlC0e87EQ9eokSF3B7Qi7hOrc7kY
         JnoRU+8YWWkYbqvXn76J24Wb0fgg9TlldloW9sO1eQc6De7xqk/91cZ6GNRXeK+igxA8
         yScr0oQkSPtZmVWNyqByEAwDLF4oPzWqNgEKwWZfzPttLEJos40Hhdq20/y2Bmncz+fk
         i6WToJsEI7b3qDkplr4M56HRr+ceQRUIluXj2phABXCuhl8C90fE7c95D4AArtbl6Hyj
         Wd0Q==
X-Gm-Message-State: AC+VfDzPg/aewMYdZBaUulaXvaR15SGMYlKi9a6qYzppKFOJKYwGyRZM
        UQUt/aN3qYLEVCTIcBzp4eD3hg==
X-Google-Smtp-Source: ACHHUZ5r30Gc6kwt/oZtN5NUwSZGmY7FSmhlu9AmLLDPviBQUhkCY6iC9vZ1bfrnqg/+SEUXxUOAow==
X-Received: by 2002:a17:907:6e06:b0:94e:d951:d4e7 with SMTP id sd6-20020a1709076e0600b0094ed951d4e7mr1660392ejc.59.1685435180551;
        Tue, 30 May 2023 01:26:20 -0700 (PDT)
Received: from krzk-bin.. ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id t14-20020a170906948e00b0096f8d8bd046sm7038253ejx.187.2023.05.30.01.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 01:26:20 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Markus Mayer <mmayer@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] memory: brcmstb_dpfe: fix testing array offset after use
Date:   Tue, 30 May 2023 10:26:17 +0200
Message-Id: <168543517536.14881.4331545598282983377.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230513112931.176066-1-krzysztof.kozlowski@linaro.org>
References: <20230513112931.176066-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 13 May 2023 13:29:31 +0200, Krzysztof Kozlowski wrote:
> Code should first check for valid value of array offset, then use it as
> the index.  Fixes smatch warning:
> 
>   drivers/memory/brcmstb_dpfe.c:443 __send_command() error: testing array offset 'cmd' after use.
> 
> 

Applied, thanks!

[1/1] memory: brcmstb_dpfe: fix testing array offset after use
      https://git.kernel.org/krzk/linux-mem-ctrl/c/1d9e93fad549bc38f593147479ee063f2872c170

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
