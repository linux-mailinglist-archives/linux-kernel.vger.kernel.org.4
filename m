Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A762B6018D0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 22:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbiJQUKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 16:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbiJQUJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 16:09:45 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 053947B2BC
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 13:09:02 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id g9so8062287qvo.12
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 13:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=noBOM+zys0V7KP1+ylmbcBKWdeoy+cuC29+lfReZWlc=;
        b=I9QDzmbhm6k/kwyqR+r44LTabVOPDvf8/qXp4WsupAV206X/FgJePy+BNzof1xuYYE
         4taF3U1khL7ih/Nf/VRrflEC3aOWi9asFahenuwOreGLW+8xAzjy4nTqAEdiZKrdMY03
         esgtjp4tQxWE7F1OFGvnE/q3bjT90ru0uXPAV9RLwJI6FWCzCtOq3fG/923l/3kANeYq
         F/ZxdgVctA87Qtt0XpEByM8f+m+CVihZoX5Npqsi8+KkiTYKt6bPI+qzyGXpiP+C1UkA
         22mkG4MuelwG0dxK7rU3IE5R0Apcah7ffiHxfbz2reHqUBTa8DwR7/HUXix/mfRW3noV
         93YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=noBOM+zys0V7KP1+ylmbcBKWdeoy+cuC29+lfReZWlc=;
        b=q6kk5s6KHwe4Vfw37FzDg9vGvT85ozPLdRULSJKIkH8umjqczR0suNMp0YjqKPeAfS
         WFTQSPGjiDc0gU52c6cx+ICkmvsRSRLrZ5N3o6tMNJ4Q2EUMbRHDM7jqFbldJ+/DUpPm
         sOtT7VcexGx5ps3GrL6OIFlbyU9esTEomz79dlVZdHft3mxZmaTgQwlLeb5EE3Ka0a9E
         76qj6wotByfiS3ooKB0Zvpw0qECWoYMKY4Sjg0Jt88qbgmlJQHI3i5434hrmsa+tN0hm
         fMcKbhJuBP5rdvFWDgjGKJSNmSpTlLjSK2xul3AZyYAR5U/FW/3yPcnnDbFq4RjKVe2T
         Rs9g==
X-Gm-Message-State: ACrzQf0J4llSjqPRAgHSJLaMo+XYGNjYsDBnQ8SjH7A+fbx6txMG0imI
        LAHUqMGVH+S9Y7ylHlAagFbd2A==
X-Google-Smtp-Source: AMsMyM7uklssFlPjIER3F54jwN0wHiwqh/FyC7PWrpoFasD9fwaQY7+pkikF6ycN7JtLx/aRQ7FePQ==
X-Received: by 2002:a05:6214:2346:b0:496:ba45:bdb0 with SMTP id hu6-20020a056214234600b00496ba45bdb0mr9927621qvb.47.1666037338183;
        Mon, 17 Oct 2022 13:08:58 -0700 (PDT)
Received: from localhost.localdomain (pool-72-83-177-149.washdc.east.verizon.net. [72.83.177.149])
        by smtp.gmail.com with ESMTPSA id m13-20020a05620a24cd00b006ce76811a07sm536793qkn.75.2022.10.17.13.08.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 13:08:57 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawn.guo@linaro.org>, linux-gpio@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sivaprakash Murugesan <sivaprak@codeaurora.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        devicetree@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh@kernel.org>
Subject: Re: (subset) [PATCH v5 15/34] dt-bindings: pinctrl: qcom,msm8226: use common TLMM schema
Date:   Mon, 17 Oct 2022 16:07:56 -0400
Message-Id: <166603728601.4991.8612948687940688749.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221016170035.35014-16-krzysztof.kozlowski@linaro.org>
References: <20221016170035.35014-1-krzysztof.kozlowski@linaro.org> <20221016170035.35014-16-krzysztof.kozlowski@linaro.org>
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

On Sun, 16 Oct 2022 13:00:16 -0400, Krzysztof Kozlowski wrote:
> Reference common Qualcomm TLMM pin controller schema, to bring common
> properties, other pinctrl schemas and additional checks, like function
> required only for GPIOs.
> 
> 

Applied, thanks!

[15/34] dt-bindings: pinctrl: qcom,msm8226: use common TLMM schema
        https://git.kernel.org/krzk/linux-dt/c/4799452e1823c6c9ca8b05d47e116871b0c5921f

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
