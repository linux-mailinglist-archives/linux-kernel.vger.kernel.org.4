Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA1EA5F0E99
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 17:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbiI3PPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 11:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231726AbiI3PPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 11:15:39 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C447C74B
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 08:15:34 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id a8so7314974lff.13
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 08:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=9qe1ituoiVQ6tMTna4qx1CP35n7ZrXQ+Z8Kf3z6Up/k=;
        b=K2ppjZpTcwMXMqHVkbUZy5/PmQebskeMbiEDI8XMJvkxqFQFIjp3zCyX+XO+iW5elo
         UjqqE0Tk0PtRzPeodJgG5AZ7yRtcE0fgKae9x8UwrvG44G5ogXJef+8cltxvSu7VJ3ys
         /bRnODG+csOYM0DA93DZM6WeifBH9xjcL9/+wRzw8Oj67EI4xXySgkOX7kS8ITbDrP4N
         tS+zOo3/Lwyudf1obe7R+sQLVSTH/ALWQv7L4O4jHbwo8VoQJXHJz9S/PaJZX+NIIHEY
         1xktlKMiSjsKRh5KR/GLSy596efrUb9Eik4ELgyYbgq5lX1kOKC+BtGhfUrU5XAh9s+B
         Hh2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=9qe1ituoiVQ6tMTna4qx1CP35n7ZrXQ+Z8Kf3z6Up/k=;
        b=21yPJnhjFn/XeF9cz68xQjFo9jA8OwvwYMZHOGTjMM/yB1c4agbHm/sC4mCjwhsor+
         aCl1mKyDPp72HOjN5qXdWZEuGLwoQaJAjvSC3neb3FDoucMeIxhiMw7WJtknezqOOp85
         Q0szpCqiOWU9rfAWwDVBFNS/65lbM02AY6lkzWCvd+2c0xbTCHDIiQAVr0My6tCx+qN1
         V3G/ygaP0Dn5bXCuSLBP8mJc4OcrS+pMnrXnWgVaE26U8bF4i9d9kqx9YXfQLnav/qoJ
         cYOJXcP5JiPSb+2wLGZUnojPldPgjSE0QjNPVUkym8Bzlja2i+Y+ZeRsUnMJ6f+t4vYA
         9qhg==
X-Gm-Message-State: ACrzQf0Yb9TnWaA26laYkan2VbI3qfbR3VKxO2Kq/SbHEljhU1m/7EbW
        bvnP5KDIMKvP2n1Ac/8YrRBUsw==
X-Google-Smtp-Source: AMsMyM6OH/KU/K3lOw7qM6WdTyenUEIfcDT2JYgFrfRCgd4m0c9smxHRRRMOWigUKN/XtE2bYLMu0A==
X-Received: by 2002:ac2:508b:0:b0:4a0:5d6b:ff14 with SMTP id f11-20020ac2508b000000b004a05d6bff14mr3370963lfm.409.1664550932897;
        Fri, 30 Sep 2022 08:15:32 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id q3-20020a0565123a8300b0049480c8e7bcsm320145lfu.176.2022.09.30.08.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 08:15:32 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org, Alim Akhtar <alim.akhtar@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH] ARM: dts: s5pv210: correct double "pins" in pinmux node
Date:   Fri, 30 Sep 2022 17:15:30 +0200
Message-Id: <166455092698.6630.15512850580722431230.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220926125824.477920-1-krzysztof.kozlowski@linaro.org>
References: <20220926125824.477920-1-krzysztof.kozlowski@linaro.org>
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

On Mon, 26 Sep 2022 14:58:24 +0200, Krzysztof Kozlowski wrote:
> Drop second "pins" suffix from pin configuration/mux nodes.
> 
> 

Applied, thanks!

[1/1] ARM: dts: s5pv210: correct double "pins" in pinmux node
      https://git.kernel.org/krzk/linux/c/17fffac44943a619ec76463655b1ed7fccd8bea7

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
