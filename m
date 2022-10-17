Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC0266018B1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 22:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbiJQUJE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 16:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbiJQUIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 16:08:37 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCB937AC29
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 13:08:32 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id 8so7410795qka.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 13:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9U9Xu7FWZ2QwPIrCKuU7A4hzI+BFH1Pi5wIbut8zVVA=;
        b=SwCtKPqeIy0KknGg6jQvkG9G7L8nO2g1DznnxYwEIjjie0o09PZdcgnDHVAxTM3128
         2tJLhSucNO/vNInx6fdRl/cOTqW0LGJrME2u5beda8fG1uNZNhO+k6cwPP2X8pcAczB5
         t/BNqnwKw/IfP/E7EjzphihS/5XP09fYZbZSoATedheI/p9511zLLtWhTSrL9NMhU/9a
         kD+hHM0IyNXH8eTONSP9zYrwP7Lsa4Y3aTMQhauoxa9hV5nTaeXIsDiWMDDyS/75Tp7p
         HNUm6fbzkM6GoEN6Nzwnn6NQMm0cpW/UX2D7M6r7y5E+oNIx3hKVaQE7SH+4CQsmO421
         ZtEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9U9Xu7FWZ2QwPIrCKuU7A4hzI+BFH1Pi5wIbut8zVVA=;
        b=5fYHweQhpoksrosBSwAkfsG1ZPc7IgcpRM7WuXKqvHVbc3UHBdPDXQjjmURd4rWQMp
         ZvsWmsTCeApoDfvgX2SxtZZEv5VYM9iqbpbx8DEZ7uWU4ONaVLTvj0TVbMV5z4L4go6P
         l/M/InksLcc/YCYkAiQjpCXw1cNAjdox6PwBOyPu+42lkDSZfAZ+0nqG+ZionfyYCSbG
         LivKvP/2m2v3c5NbxTDQjazKfFJx/l3LRiwFJ0gQKwIsHOxyULMmqY4u0CDKkG0Xg5PQ
         3vqaswbXurf/kG/b6GjOZYqyej+hsDCWcfvc8JC0Iwse3S7ZdpgeR6Dcq0d/WsjP1ARu
         jZzw==
X-Gm-Message-State: ACrzQf0cDz0IkT1iNJmCb0V6ZkKWNqtqKg3OiJaXVNRqGioM32ChrOn2
        pdcGPeizKJ6kIrLfuAW0tjA0sA==
X-Google-Smtp-Source: AMsMyM4nvI/wBJBzmlWNP7g9XW790rjVWOsh4cFqHRZcvrCQu/qhAYt1Rs3TsgCt1oD3J/PALz08uw==
X-Received: by 2002:ae9:f214:0:b0:6e4:35ec:a7fe with SMTP id m20-20020ae9f214000000b006e435eca7femr8858591qkg.253.1666037312244;
        Mon, 17 Oct 2022 13:08:32 -0700 (PDT)
Received: from localhost.localdomain (pool-72-83-177-149.washdc.east.verizon.net. [72.83.177.149])
        by smtp.gmail.com with ESMTPSA id m13-20020a05620a24cd00b006ce76811a07sm536793qkn.75.2022.10.17.13.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 13:08:31 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        linux-gpio@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh@kernel.org>
Subject: Re: (subset) [PATCH v2 12/12] dt-bindings: pinctrl: qcom,sm8250-lpass-lpi: add bias-bus-hold and input-enable
Date:   Mon, 17 Oct 2022 16:07:47 -0400
Message-Id: <166603728600.4991.16013389355354109273.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220927153429.55365-13-krzysztof.kozlowski@linaro.org>
References: <20220927153429.55365-1-krzysztof.kozlowski@linaro.org> <20220927153429.55365-13-krzysztof.kozlowski@linaro.org>
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

On Tue, 27 Sep 2022 17:34:29 +0200, Krzysztof Kozlowski wrote:
> The existing SC7280 LPASS pin controller nodes use bias-bus-hold and
> input-enable, so allow them.  Squash also blank lines for readability.
> 
> 

Applied, thanks!

[12/12] dt-bindings: pinctrl: qcom,sm8250-lpass-lpi: add bias-bus-hold and input-enable
        https://git.kernel.org/krzk/linux-dt/c/a76a13c89a59e9310c6dafb1eb7f43bf04ea001f

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
