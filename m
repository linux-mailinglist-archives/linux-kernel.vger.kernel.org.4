Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C04EE6FCD68
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 20:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234986AbjEISKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 14:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjEISJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 14:09:50 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 476CB19B3
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 11:09:49 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-50bcae898b2so11287356a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 11:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683655787; x=1686247787;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wTAOCVPOPtOy5y17r+mtI5VSueoAcoLIpQdMbfiTcg8=;
        b=D1PFvAm7SlYpPsPFpbjzQy80gA8ralWcfpyiMeU/EMEfyrmde5hbToU9wgYycOcF5v
         YAGOBiJA9kXiZKh8/GLzZg7upeXk909wM4m461AZhHh7bb2RhFQ8yBduQ0nJJ4Nq/o2K
         RJBJUS6ydoWHlz9PeO/s9mEkytwTeKthMGp9hCNp8d2M6W/gi66naI1GvRJq+QY4uGz3
         ajzSsfVMOtdHHDtZEvJR4ZoDkE3zvfXq1G47DUgEzDOobj7be99w7fHB6KSl80Yqzuw4
         Bzc8ItdSUVWIHCFNGojsGVJQUzgptt6T3EG/wu3hWZwAytyZn5TQuhJcJP6Fph8ngztz
         7J2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683655787; x=1686247787;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wTAOCVPOPtOy5y17r+mtI5VSueoAcoLIpQdMbfiTcg8=;
        b=MAhI+vxtm1QYneS4RZRS/etUNSQIAAaLtFuLt+LMIa2Bfh+PIYa/cWG0Bg0e7HY32H
         98PGt7WYlgBBJmQErQ5TApkTzZypwFWpofU426NgD1vv9FqnbT9zQNr4pabA6s5lV17+
         hznRigN9Bn4KquGxDR4ZMy3L1jNIeKESQ3sLVV+VGDUBb/PniBZgAX/QhyGksXbM07qB
         kVLiRLZ432YGvWKbPh7fiwHkdsSG8NTWtLmEQbFJYBjHUodK997kRNJjgu7onYon4ZsX
         mZJrtFdx5ZDVo0Y19EKimCjkDqOscvs9BumDgS843xB2rml3mkZJFM8nzu7k6YzENayp
         yyIw==
X-Gm-Message-State: AC+VfDy1z9BFugzl0LEhIC1tQCdYYmCBp40WLrnEUofhR/+DEGaqC+KI
        4ne+ufcyjgaRw/+vLB/LWUG+Gg==
X-Google-Smtp-Source: ACHHUZ5hovFjTjykdEntWpkRkWy8gjb9Ub7wb8Lh4BgtsqFJo3AnBC7o0FPzHT4uW5ImOYI0KpKMUA==
X-Received: by 2002:a05:6402:10d7:b0:50d:bb87:247c with SMTP id p23-20020a05640210d700b0050dbb87247cmr2359508edu.1.1683655787536;
        Tue, 09 May 2023 11:09:47 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:d0d5:7818:2f46:5e76])
        by smtp.gmail.com with ESMTPSA id dy28-20020a05640231fc00b0050d8b5757d1sm1015286edb.54.2023.05.09.11.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 11:09:47 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Artur Weber <aweber.kernel@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>, soc@kernel.org,
        Russell King <linux@armlinux.org.uk>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Kukjin Kim <kgene@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-media@vger.kernel.org,
        linux-phy@lists.infradead.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: (subset) [PATCH v3 05/13] clk: samsung: Add Exynos4212 compatible to CLKOUT driver
Date:   Tue,  9 May 2023 20:09:32 +0200
Message-Id: <168365575565.242810.6906601762854965924.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230501195525.6268-6-aweber.kernel@gmail.com>
References: <20230501195525.6268-1-aweber.kernel@gmail.com> <20230501195525.6268-6-aweber.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 01 May 2023 21:55:17 +0200, Artur Weber wrote:
> Support for the Exynos4212 SoC was originally dropped as there were
> no boards using it. We will be adding a device that uses it, so add
> it back.
> 
> This reverts commit d5cd103b06f9d766295d18798de484528eb120ea.
> 
> 
> [...]

Applied, thanks!

[05/13] clk: samsung: Add Exynos4212 compatible to CLKOUT driver
        https://git.kernel.org/krzk/linux/c/48b359732e166d0f5d53649e21eac8d9343b8e13

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
