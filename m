Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3386E62793F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 10:41:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236053AbiKNJlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 04:41:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236955AbiKNJlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 04:41:04 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A8BB1EC69
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 01:40:51 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id d20so12353056ljc.12
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 01:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wVIrJB62xFytgyX2hXOIwCkUIaWq9adGnSjJaoKJxng=;
        b=IL7q4QAIccunJwfWqTuHGQi1izpTEyFq8ufXrX5+T7lwl4pEYmRVyDDS/Wf4wBVEtm
         A+h8yErXUxZzGoavkINF6Ihw3pmO0QuJG5v28i/FL+0FnjkKsQsg86PIqkpAuWbucUQl
         JLJ1gmB9ioWwwqOG1oh/cmCpieV7flF9QUF69BP8m8jYWfCm2Luz1Hym1r90TmOITXNm
         v454W6JgZTm7WuHTXFieVdrXoBH1jXsscukcueTuRUl4ev4h2P/RDYi1d39ZrzM01bwR
         bhQsgMBqoFQA9usFOct05Kbb0KdZc0HQWXt1ZMTpuwkwBXJ1IHNvQfoW8iHZynKH0fh7
         R61Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wVIrJB62xFytgyX2hXOIwCkUIaWq9adGnSjJaoKJxng=;
        b=Gk2e85PJz6jK+2McRm7A8OhDXSIDUmMuB2DtUTPjv5gtZIjmvSdGyfmyrHouqhL+VO
         Iug5240UOpkqGkwVAhpw2OCX1MxQ6cqiQR9sTnapITgU8F9vukpJ5x45uipTTXC+/j+y
         /h1B3UNMqse77P67QRpEC2KDCgVCH65y33PMzpgWiXHXkHuQM0pPi6/rw8MEspD8YDzb
         8tRipaazYaHFKJA7vlZHVWnG7pYdLQB5oKJQyW5ND1ez5RffH9SxBHLVvWZ0ELIB1yB9
         ktc7ATerySe6jDRF1vpRUeZFhveza0W8ts2mNJ2f6nsLvbmZ/5PlyP20IHV6/8dpLuDw
         5riQ==
X-Gm-Message-State: ANoB5pntwDnByKOmyBVUWU7UR17wGMb0DaBhOT3vJZuvKnCpMcUxqmZv
        eckg2BYatm3Z5f0pLo8Ca/VuJA==
X-Google-Smtp-Source: AA0mqf4/jxt2YzhS5bqE7d3oZSnRUYxSjcA4QKPtBPsohUR7PehtXB8E2onkoMJ2R42SbsaUTYppbg==
X-Received: by 2002:a2e:b011:0:b0:277:6f0:523b with SMTP id y17-20020a2eb011000000b0027706f0523bmr4271345ljk.297.1668418849464;
        Mon, 14 Nov 2022 01:40:49 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id n26-20020ac2491a000000b00494a603953dsm1762430lfi.89.2022.11.14.01.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 01:40:48 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     devicetree@vger.kernel.org, Andy Gross <agross@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: (subset) [PATCH v2 1/3] dt-bindings: pinctrl: qcom,msm8960: convert to dtschema
Date:   Mon, 14 Nov 2022 10:40:46 +0100
Message-Id: <166841878696.36382.16617765528924868503.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221109105140.48196-1-krzysztof.kozlowski@linaro.org>
References: <20221109105140.48196-1-krzysztof.kozlowski@linaro.org>
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

On Wed, 9 Nov 2022 11:51:38 +0100, Krzysztof Kozlowski wrote:
> Convert Qualcomm MSM8960 pin controller bindings to DT schema.  Keep the
> parsing of pin configuration subnodes consistent with other Qualcomm
> schemas (children named with '-state' suffix, their children with
> '-pins').
> 
> 

Applied, thanks!

[1/3] dt-bindings: pinctrl: qcom,msm8960: convert to dtschema

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
