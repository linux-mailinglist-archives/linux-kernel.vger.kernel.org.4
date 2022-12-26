Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8EB66563C6
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 16:17:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232096AbiLZPR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 10:17:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbiLZPRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 10:17:22 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE4D92BF4
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 07:17:20 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id g14so11408041ljh.10
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 07:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NE9vhGolKZh4qk6h13gH/hif2BGc/nXGsk3gcrABu0s=;
        b=Snp+V/1JNPEJWCzyjiW0XERLLTqxUhNzRMR7zbzie3Y5TIPw/Tlz0FXyAozn4yu5RH
         /BC42f+bsjZ6gT4yXvHJ9YcfBFs43KgD8CRFZGunLDgpu0uT/oaPbfXKEtVdBzEpaLN3
         LrB2mlQX93L30I/tRaEBUVSiuWsyqnniotLc0NnkH+oWRwL72gPS66O4yxi2iav/w+Zd
         LjK6XdUBdn0Fx49TxCfq3MuhO5puSLKvUDDL2sFHdUnODG60EjXtVdJSQ8CMlpQ6q1J6
         VQTiSZ2XhHGCx9sWGVweBdfgWVt8y9AMzfMDk+tp0h+wKdCZxInhaR7UmPWOTDcGg+A2
         vfWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NE9vhGolKZh4qk6h13gH/hif2BGc/nXGsk3gcrABu0s=;
        b=L14qEEaRYaWyjCwgAPnHPioJtJJiC9v1qTDRRNXCr1SDtZZuSzDVNwhgUBaVcwdSyS
         B/3EtYchFInket4DsZ6u1c7JsfdLHkH6iQHQCH74nrFN1fLFPaBe+v+SUFWIP6S9hDzs
         BLPxTe4a83DEJma3U0DnVhVvH4zioFXrvjzoEQnG34k16TLF/7U09KqnphJNrxqGhxYY
         v4SytM6/+QIPLC77HTxRVI3mRSkAqX1F5FNouX28rsggtBUBmIyDZ0jGdYR6rU/PkyfU
         5ncENvJZeUUbJg9V0IngFIAVlYmcaPyx/qQf/BQ1B4JS77JrVYrbn89zznGK06vG8nCJ
         cObA==
X-Gm-Message-State: AFqh2kqdj2uZn5pWVxc1O6fNNKRySRjNzrIVmTJsNSN4i8kghwgqS1rq
        sqiO/jf02im1frHK6LdHD68IBA==
X-Google-Smtp-Source: AMrXdXuLyt4i7NA9WzbUQrj7oRqYpVf8cgATRPCrU4EG9oywAaIM6lbk0rHTzoFGKzlVMlYlclyIDw==
X-Received: by 2002:a2e:3c11:0:b0:27f:c557:697a with SMTP id j17-20020a2e3c11000000b0027fc557697amr377016lja.53.1672067839073;
        Mon, 26 Dec 2022 07:17:19 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id k2-20020ac24562000000b004b4ea0f4e7fsm1821286lfm.299.2022.12.26.07.17.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Dec 2022 07:17:18 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] arm64: dts: exynos: use 8-bit for SPI IR LED duty-cycle in TM2
Date:   Mon, 26 Dec 2022 16:17:12 +0100
Message-Id: <167206781676.20416.5753749208705846208.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221204104242.117558-1-krzysztof.kozlowski@linaro.org>
References: <20221204104242.117558-1-krzysztof.kozlowski@linaro.org>
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

On Sun, 4 Dec 2022 11:42:42 +0100, Krzysztof Kozlowski wrote:
> The 'duty-cycle' of SPI IR LED property is u8:
> 
>   exynos/exynos5433-tm2e.dtb: irled@0: duty-cycle:0: [0, 0, 0, 60] is too long
> 
> 

Applied, thanks!

[1/1] arm64: dts: exynos: use 8-bit for SPI IR LED duty-cycle in TM2
      https://git.kernel.org/krzk/linux/c/254b8f4b219211e1e2fb6c91edd96aa583c78720

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
