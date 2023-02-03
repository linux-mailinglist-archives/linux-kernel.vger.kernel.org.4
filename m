Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62697689DA5
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 16:17:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234121AbjBCPNv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 10:13:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234144AbjBCPNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 10:13:32 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68BECAA27C
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 07:11:29 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id q5so4972195wrv.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 07:11:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kGmKrLVAinuf+Yd12cozByuxIVGNNesLNwLCgObEIhQ=;
        b=bQZOosridMitZ85XsgNASWSpQbIYYoe6OaCkcZsZrIoOgpcKlBglkK6Qade9fgx/5v
         GDvMJr9l+4KgLMHQ5XrNClvSRIzqC5KgVO0xxuDZyK01TQUJtSjIhZmGZUhj/qFmVOvL
         qtxnIiKrqKDgABE94zs+vBa81Ep9bhaTQ3gqUjBhhmekeAseaZS5LHDtx/ShyIs3NiJI
         YAA4rCFd7EwVKSegcClHu/eEIMQtX8XsYuGQ1FQj/aBTIUx4HUp0Gv3ueunTHpa6HAoY
         T+RDAQi8slgRqGO81NTBCIA82nxDzoOnFgm8MhNoBcPRPMBw9FyCO4Ushv+goxc2yF/N
         iOnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kGmKrLVAinuf+Yd12cozByuxIVGNNesLNwLCgObEIhQ=;
        b=1PMryxB7KI//GmmLK0drDKurHP/DjXC6mOcH1iPTs2R9CKN/QBUInx6QAldWdjpCBz
         9NxEuQXfhZVi64YU+SeVhxutrBOyJd1md5U2acQ4E3sJF8ta6DN2szsm0HFaKmU7uVU4
         tjqqmWZGkCayTU17RrH1l+6gwAnsObi4OTf1/oarJJx3/LdRgNh3Z8zV6AmjqMlaH/N6
         ZizEU0RgEOA7bMobBUSq/f81Cpyo5NlIBeKzGskwuExmY9hA3UQZvmj5nRDuhNcS7Tau
         hmyxic54U/PeF4GOPI45SgCRYuGKsKwJoDAdjYiYVRTQU2+T4Q4ucJylU2yyTzg9goQS
         7vJQ==
X-Gm-Message-State: AO0yUKUDA1k7DNIsk5OKw0P9KetREVUSLaurpqMdR0SIkV7PFm3i3eiI
        oR5DW3nYPXhw2tos6HOv+wIQIQ==
X-Google-Smtp-Source: AK7set9gQ5JH74bSBe4RleWOEM98URh1eZ02Rn1u6lvKIWMrueK9oJ7Gcfw/lDY1mRKdSvkvzqGRRA==
X-Received: by 2002:a05:6000:1e07:b0:2bf:f7e9:2a18 with SMTP id bj7-20020a0560001e0700b002bff7e92a18mr4243608wrb.45.1675437033335;
        Fri, 03 Feb 2023 07:10:33 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id h4-20020a5d5044000000b002bdf3809f59sm2202419wrt.38.2023.02.03.07.10.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 07:10:33 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        linux-phy@lists.infradead.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-kernel@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, devicetree@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-samsung-soc@vger.kernel.org
Cc:     =?UTF-8?q?Martin=20J=C3=BCcker?= <martin.juecker@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        phone-devel@vger.kernel.org, replicant@osuosl.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Henrik Grimler <henrik@grimler.se>
Subject: Re: (subset) [PATCH 3/8] dt-bindings: phy: samsung,mipi-video-phy: deprecate syscon phandle
Date:   Fri,  3 Feb 2023 16:10:26 +0100
Message-Id: <167543702106.62628.547907360569271270.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230127194057.186458-4-krzysztof.kozlowski@linaro.org>
References: <20230127194057.186458-1-krzysztof.kozlowski@linaro.org> <20230127194057.186458-4-krzysztof.kozlowski@linaro.org>
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

On Fri, 27 Jan 2023 20:40:52 +0100, Krzysztof Kozlowski wrote:
> The MIPI phy is actually part of the Power Management Unit system
> controller, thus it should be its child, instead of sibling node with
> syscon phandle.
> 
> 

Applied, thanks!

[3/8] dt-bindings: phy: samsung,mipi-video-phy: deprecate syscon phandle
      https://git.kernel.org/krzk/linux/c/4694dd1b9d43f5b8af710b8e4efc25d3cf388a00

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
