Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD8DA6AC3CE
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 15:49:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbjCFOtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 09:49:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbjCFOth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 09:49:37 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21B3B2E82A
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 06:49:15 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id x3so39519057edb.10
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 06:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678114152;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BW5ffN73HQ58YkV8cenV/bm5sEW0jetRsKJRWVR2v1Q=;
        b=Aqw8aQZAqw41YUibYM5B1DwJKZ2fLsdNk2HP7leWJ5ihp0jWXm90aYCWpLKVl74SMu
         kPRM4j7gvphfvx17GNQ4PfP7p9Q/ym7SJUYq9Eu/3UwtS+4DzVENLQT5pneg1oOKW0lq
         S9oacZ2zgBXN0502iLP+IRpC2ngF+ZmqHlNyH+URIfnklkrbyQ/4bo92nYEt9M0jyEEx
         gtENQqhvvIoVun84CxjQ4ZWxZQoU0eZdqiVb3rcgLLFCy3nuYqzUSVFQFCGaGRpcRM3y
         yyhT5cFW2BkrEYz28YSaC5T6iFS7CD0G+1auAesNJE4zurieVK7Of340Sp5lHnUShiZA
         1IdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678114152;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BW5ffN73HQ58YkV8cenV/bm5sEW0jetRsKJRWVR2v1Q=;
        b=w+7Ht1DTSwJ9PUVkdCgGJnC0+XDyFLZjTTZ7kY38aNyuS0LhHgQRPqOF6G5d+K1FBr
         FjUfBRcYc9NbO+vKghFgGw/xMLJnDvm03KYMzWAlGUoIlRGf5l0LfjJf+EHc8gHn4GTp
         fTpLq0cKvmfMZbUhiXJRiA4Qkhqc3lsL+7sn4E1vCIcOi/1gnoBhxEVCXV6DO1xv2f23
         t7V6fcEAWgDsNCbfiNmdkqYfY6BZ4Prkl2zit9zNwip1BYwSm1ighwU4WsplyCD7NklL
         I8lRZnDu8clama1iheucbdgjZJ4/p3QG8WCcVoV1dYUk9FhaG1H5e28RDf5KNsyHpiAp
         BeCg==
X-Gm-Message-State: AO0yUKWTWLtWl2rEHrjFc4wNUI0JfAZ/4W4ahePHWbjwcC2RIPR8oCLT
        V4Tsr7zXm58UByXr+KIxEYy13g==
X-Google-Smtp-Source: AK7set/NPFuNMfIiX4gyjSrNCiUCPDvK+FTM4lKQNt1KiqBTapHYd7b70utIEyWVvD1J0chS7nChwA==
X-Received: by 2002:a05:6402:205c:b0:4cf:350e:344c with SMTP id bc28-20020a056402205c00b004cf350e344cmr9265464edb.28.1678114152707;
        Mon, 06 Mar 2023 06:49:12 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:c1e7:5006:98ac:f57])
        by smtp.gmail.com with ESMTPSA id j22-20020a1709066dd600b008e6bd130b14sm4706760ejt.64.2023.03.06.06.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 06:49:12 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Sam Protsenko <semen.protsenko@linaro.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Chanho Park <chanho61.park@samsung.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        linux-clk@vger.kernel.org, Alim Akhtar <alim.akhtar@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        David Virag <virag.david003@gmail.com>,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v3 1/6] clk: samsung: Don't pass reg_base to samsung_clk_register_pll()
Date:   Mon,  6 Mar 2023 15:49:07 +0100
Message-Id: <167811414390.14916.7330787578413043996.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230223041938.22732-2-semen.protsenko@linaro.org>
References: <20230223041938.22732-1-semen.protsenko@linaro.org> <20230223041938.22732-2-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Feb 2023 22:19:33 -0600, Sam Protsenko wrote:
> Base address can be derived from context structure. Remove `base'
> argument from samsung_clk_register_pll() and use `ctx->reg_base'
> instead, as it's done in other clock registering functions.
> 
> No functional change.
> 
> 
> [...]

Applied, thanks!

[1/6] clk: samsung: Don't pass reg_base to samsung_clk_register_pll()
      https://git.kernel.org/krzk/linux/c/dc079b9e568ba334a3f0b313a42852e45be4f4ec

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
