Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D134860301B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 17:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbiJRPuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 11:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbiJRPtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 11:49:47 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52736B481
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 08:49:30 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id t25so8906467qkm.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 08:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sOF40LnUY4scPwmAlI+IgQw34TPonF5qD+3Aj1xGjXU=;
        b=Jpfh/Nb8dkbG/cB/2xztHveqynNOHD3Lg1ZnQPE/jvrsE6adAYEj8d1Qyhiy7JIH9i
         /dMZOL25p55FhLU8jTlRouZ6z+0fjy3SUS+rgMRZKhO73Yc3bSXAz/H/RXut2UcWquEI
         J8AGFXjrJw5Ir+HWV0+nVNQGt01OlWJXRu/eEoTaeUq6O7EcD4H3kih7tnyfoX78sgFk
         xxt9sqYKUFQYlNLhckjni5fQvewAjeV/emJFhAmNpq7FQ83VF9m8Mtrsoav2d85jqHSS
         pwRY3hTK+jbN6TJ01b0h16ks3Y8cWPIIX/3Od4GNatm7Nx/G1U1szXmJftH8LYs1YX75
         PqLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sOF40LnUY4scPwmAlI+IgQw34TPonF5qD+3Aj1xGjXU=;
        b=Su6I3GYG7+gASKsvSBNnQC71ZvS2JAVqrLuo1dcJQ8opA8H8Q9jyf0ol2JLMaLK6VG
         /ZFy8mUXgQH7o371/T2xgfGxwuRdtJYHz7lHhf5CckzE28AnzUQHlQjvkCFufUpOqrCl
         iJsdXw4Y8HMKkBdQJbp2Mvb/LWaEOU2bemFsO3ExYjljbTSYDsX6+3YHH50r4nSX4Njf
         Qp/1wYzv20RBAwCz9kDvlfdl1fQw774FcEKo3dXazbvbahAwlNoXNZ7SYTKI3GirUcU0
         2/SvEgKZ8XW2HjYx/Rpy6pW688ONTG99iXCyXqkfUY5qHwuSdClssjAj7h0WgbKqwJ7h
         iUlw==
X-Gm-Message-State: ACrzQf0Xf0k1vijPbLESpnkl96try6zUsXu2OBiB/q42kfuEgsIhK4gx
        EAmdey5YZYUwk0vz+GDkX4j8Yg==
X-Google-Smtp-Source: AMsMyM4iKrehOoUiORUFDHlTZsMU8TXPbdWf7ovBYPPelxb0kh6d0lBvjfPeGMc1N2sD+k6DoXS/qQ==
X-Received: by 2002:a05:620a:85c:b0:6ea:c16d:2149 with SMTP id u28-20020a05620a085c00b006eac16d2149mr2311149qku.288.1666108169802;
        Tue, 18 Oct 2022 08:49:29 -0700 (PDT)
Received: from krzk-bin.MSRM (pool-72-83-177-149.washdc.east.verizon.net. [72.83.177.149])
        by smtp.gmail.com with ESMTPSA id c25-20020ac86619000000b0039543f89109sm2029202qtp.96.2022.10.18.08.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 08:49:29 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Rob Herring <robh@kernel.org>
Subject: Re: (subset) [PATCH v3 15/17] dt-bindings: pinctrl: qcom,sc7280: correct number of GPIOs
Date:   Tue, 18 Oct 2022 11:49:07 -0400
Message-Id: <166610814671.37912.14143402454760029222.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221016172212.49105-16-krzysztof.kozlowski@linaro.org>
References: <20221016172212.49105-1-krzysztof.kozlowski@linaro.org> <20221016172212.49105-16-krzysztof.kozlowski@linaro.org>
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

On Sun, 16 Oct 2022 13:22:10 -0400, Krzysztof Kozlowski wrote:
> SC7280 has 175 GPIOs (gpio0-174), so correct size of gpio-line-names and
> narrow the pattern for matching pin names.
> 
> 

Applied, thanks!

[15/17] dt-bindings: pinctrl: qcom,sc7280: correct number of GPIOs
        https://git.kernel.org/krzk/linux-dt/c/06311aa3ad1fd745d6248fc665f4c28880fedff1

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
