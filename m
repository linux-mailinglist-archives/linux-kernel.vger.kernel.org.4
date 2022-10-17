Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F38706018CA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 22:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbiJQUJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 16:09:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230518AbiJQUJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 16:09:23 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD4F7B1D6
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 13:08:47 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id bb5so8442292qtb.11
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 13:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k2yG6Gjsi7uVuEkO4PcTE/6BYb7rGQdaDDBYOAGvceU=;
        b=lHba3ZSUEhzCkzHYnY5Ud+x7AzLmlymb3+N6CheMD9Ep3AcQKmWcWw8eUW/HEMeAHy
         nDQzrFWO4EDxrkS8uAXKEhPN83zA7WHD+4UGVT6SeW11Fwf12P1eEsLu4J96rCzgTcxJ
         QLUKJTaYOYKv6FylopUITAenisPVZSk38xdZ1ZczEtsRzLsWixtCEhOxVb+oSDxJrNXL
         /XtGZOn+bncsuZBbiVuaZmFYgo3HfZ6YLwzRcM9BVzchuA6wxpuQ3ag5ER4E+xcVF5YQ
         Phg6TeY6XSbcGhtNu2NMJBeup02oo8tZCUqx+PUV2AH4Nmfa0ZjenHND6qV3LAFt/It3
         SYWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k2yG6Gjsi7uVuEkO4PcTE/6BYb7rGQdaDDBYOAGvceU=;
        b=SMbzXcw5WUG75fVA+z8SQLe8YMoDH9Qm6Nwp2qV4/r5K9O2QuHlt11bz4ls5eHCAbN
         89artfsjS9z75Xmx46hi7mr9VkmcX5QAElo7SjzIQCxeVHPR4unxJCyd8EtuY6jGoMgS
         eoaZ4zKKk95XUetM+IX0ZK5vjnWs8sA2t8xK9MqvvbRcKYZ1rtoTp0b6/wyK0FRLtr4X
         U7ucgSd3DF6tSDltpKRrLAF477bRbMxf4UI1eoxj8GEXK0F8el2umY3/sRTZxQmPi/+Z
         mcoewZaD7SeM8gxGVWXPBr1TOHDAF2cLA/SO/YvleDs4Ye6O+QtllvhdYW+iaBsYuNuw
         PaZA==
X-Gm-Message-State: ACrzQf2PAFZe8aGacd0zLWlUydgX14XE78oV99gWvyCUY1S2uAwl3vDh
        T9tbL1voV0OuAnbGI4yfwBFiSg==
X-Google-Smtp-Source: AMsMyM5vPAMMRxWHtcqfaO7YXRAuZlcGqYw4OyWkwPg1IC555sSt4i+uEM88iFgDmgW5UkpBEO93RQ==
X-Received: by 2002:ac8:5890:0:b0:39c:d67d:1f63 with SMTP id t16-20020ac85890000000b0039cd67d1f63mr10252901qta.450.1666037326472;
        Mon, 17 Oct 2022 13:08:46 -0700 (PDT)
Received: from localhost.localdomain (pool-72-83-177-149.washdc.east.verizon.net. [72.83.177.149])
        by smtp.gmail.com with ESMTPSA id m13-20020a05620a24cd00b006ce76811a07sm536793qkn.75.2022.10.17.13.08.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 13:08:45 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>, Shawn Guo <shawn.guo@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-gpio@vger.kernel.org,
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
Subject: Re: (subset) [PATCH v5 14/34] dt-bindings: pinctrl: qcom,msm8226: fix matching pin config
Date:   Mon, 17 Oct 2022 16:07:55 -0400
Message-Id: <166603728601.4991.14367705632384871695.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221016170035.35014-15-krzysztof.kozlowski@linaro.org>
References: <20221016170035.35014-1-krzysztof.kozlowski@linaro.org> <20221016170035.35014-15-krzysztof.kozlowski@linaro.org>
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

On Sun, 16 Oct 2022 13:00:15 -0400, Krzysztof Kozlowski wrote:
> The TLMM pin controller follows generic pin-controller bindings, so
> should have subnodes with '-state' and '-pins'.  Otherwise the subnodes
> (level one and two) are not properly matched.  This method also unifies
> the bindings with other Qualcomm TLMM and LPASS pinctrl bindings.
> 
> 

Applied, thanks!

[14/34] dt-bindings: pinctrl: qcom,msm8226: fix matching pin config
        https://git.kernel.org/krzk/linux-dt/c/43dc3f2bc1140c9dd93b5aad4e8e52f3b2c2fef4

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
