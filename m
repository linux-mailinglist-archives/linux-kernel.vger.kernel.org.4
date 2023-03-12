Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5B516B68C0
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 18:21:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbjCLRVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 13:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjCLRVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 13:21:31 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38CAE34013
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 10:21:30 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id k10so39750288edk.13
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 10:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678641689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B2jFUNzqqRCDLI/6nYZx2Ja0Za/TmGMlbNfoy2LoUTs=;
        b=oLF81Y9ESa+qrxvLu8LvsOuQ99msMDyUyRUR1kfbRibooxnGxYhg+CzdbJz6bez4KM
         aEmQKTiqNzwXeYKIgl/RJwdXv9ydi41LEcaED+lNvzS2Wx0M5JiIqcSsTsCqpaG2oX1V
         Pr6x95K1+PySHOsFub3A7vQ6szdqev8l+PYA9Vp4mMUR7HV8GbfiyljZvypEAosuoXFG
         TAfqiPSfRygjK94zX1olBaZBrqdzKQ5pLlncnETkq3dnHfd8G02puLsQ+Ipifv9iCLG1
         wFDO84iw+dwoMiOkAyHe5KAlsPLoOqsh8fK4P/ioDftjj1PmwiiwF7ryLUuQjckkIaWn
         gQAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678641689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B2jFUNzqqRCDLI/6nYZx2Ja0Za/TmGMlbNfoy2LoUTs=;
        b=j34D0K/pJouVMy28kgsMQPBYpjn2YHkivKko2QFQCqMiwir8jKDfPgGQtIcNYlfYIX
         prDWQjUhlsrvC0+tsM0A1VkJHOUu1Pd9SC1DS4wYIvEA8UTHqFRNT+jkHzDc9uJhKkRi
         lpMWx6Lkbd2uAFlz8JCpAMWSeizqQqq4+kTbn8uy+UO5y5Tfk72IurV3qmCjKEqvkEtZ
         G1VGaDtAOcmZeCCfW7330pxKMTekrYuTe5URYlmpauT/Q5cfTuDgsfCoD4akayQkzdpP
         GkdMFcju/+o6gT97JRmeZRAeryyo/c29nJVsBUUqeDbJZhf6ePzYCmdEJN9s2hxsS9lg
         qJ/w==
X-Gm-Message-State: AO0yUKXRrDlwp+JHr+OgyfWulCQ/LTrpDs/ihVinjJiT8l/AuU1u5H8c
        dTJG/cE5b/XNpTvo22GYPmnrcQ==
X-Google-Smtp-Source: AK7set+cL33+vHAjkESY8UEX/3MAdl182jZV7Je3gOlYfun4sjeFigKvM4R1ccOJ3+5C5gX9YP3S/g==
X-Received: by 2002:aa7:c053:0:b0:4fa:18d3:a8fb with SMTP id k19-20020aa7c053000000b004fa18d3a8fbmr5819674edo.26.1678641688749;
        Sun, 12 Mar 2023 10:21:28 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:d9f6:3e61:beeb:295a])
        by smtp.gmail.com with ESMTPSA id y13-20020a50ce0d000000b004fa380a14e7sm2055395edi.77.2023.03.12.10.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 10:21:28 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Tony Lindgren <tony@atomide.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: omap: align UART node name with bindings
Date:   Sun, 12 Mar 2023 18:21:22 +0100
Message-Id: <167864162126.395859.15093808144511870577.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230123151531.369419-1-krzysztof.kozlowski@linaro.org>
References: <20230123151531.369419-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Jan 2023 16:15:31 +0100, Krzysztof Kozlowski wrote:
> Bindings expect UART/serial node names to be "serial".
> 
> 

Applied, thanks!
(Patch was waiting for quite a long on the lists, let me know if anyone wants
to pick it up instead)

[1/1] ARM: dts: omap: align UART node name with bindings
      https://git.kernel.org/krzk/linux-dt/c/f7ec6efef4560edeebdca10b73a92f37c6fb16cf

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
