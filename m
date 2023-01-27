Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72D1867E099
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 10:47:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233227AbjA0JrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 04:47:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232525AbjA0JrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 04:47:03 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A12B7643D
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 01:47:02 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id f12-20020a7bc8cc000000b003daf6b2f9b9so5000547wml.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 01:47:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YEX5J8B9AU7EZ8H28VRTZd7RQQhYFTy0irZB9bcr5NE=;
        b=NVPk9jKrWCsQVR8bxcVaXSXYzpCJ1prmLx/sFP4SxxCYnCcHVkkSEZp0GKcOlxavtP
         QUe8nKEm5yzz56JPR4IefuHs9lhilOufBMQ66/Id/XFkCmHJ7I1sbeDXUj4pUJuYtRVs
         mvOIy9NqUL4djAF7kaBUs09MIfByWXC1PF9E03NeKu/wcHpoTPFIKGjyd2lYh0qV37Vd
         2AfIaZurId31yvLMjzHEk8b83A7pgjKBRSFO4Jyyl/0s61XohdmXCvxBfatTghUqwcjX
         GiPVY5vqxZ1T1v7Fe+hxScbc6knGbPwSeTzs8rFQ5sjybmCCIoX3q4AkREUKgRSQZbSJ
         boDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YEX5J8B9AU7EZ8H28VRTZd7RQQhYFTy0irZB9bcr5NE=;
        b=OCHHcDQIxPm+BL+Pvl75srK49ojSrqzo4627wN9i5mxVCbndb9Ele6aAQgfZyItZaM
         XFvxJb5qob5/vxtaiNnnqFfIjFBXAVsTOxxGCWadX1OxV37IMBJmZzikvX5DQbsbNlAg
         wQychN8NJeE2v7OZu9RYtw+I47E6hay1Yaaf+iku/2ORZs9FDHuNgjNWfk/8tXuxIujr
         z9axIeHlAwyJd5YTA617NXIn8qvyghflxxahxHedFKeIvfp5uyEvbfeakUKF4YJ1Uk9U
         uXtioaoQKm5KIsneZfAZiX8Or6rrDwq9GKoUXJBNvSdAgvNdJnMBtaW8pzy2wKy3fEdj
         fT2Q==
X-Gm-Message-State: AFqh2kpoj6X0+8UzsyLofb4vZqe9PMJse0+3XfFttzSr3DKi/OpSK7Uj
        4Rx6xrdth08VvH4OMeJZYJYUrDIOOb/NsSKA
X-Google-Smtp-Source: AMrXdXuaxqtDfrdG54noNUE67hY3JZxFMpyWn8NUMDF/F29zdRqMRF/6oxe1AvlfHpAxk4reUqSHJw==
X-Received: by 2002:a05:600c:538c:b0:3cf:6f4d:c259 with SMTP id hg12-20020a05600c538c00b003cf6f4dc259mr38947746wmb.39.1674812820870;
        Fri, 27 Jan 2023 01:47:00 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id h20-20020a05600c351400b003dc1300eab0sm8042087wmq.33.2023.01.27.01.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 01:47:00 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     linux-kernel@vger.kernel.org, Wei Xu <xuwei5@hisilicon.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] arm64: dts: hisilicon: align UART node name with bindings
Date:   Fri, 27 Jan 2023 10:46:55 +0100
Message-Id: <167481277324.62929.15105252250811150744.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230123151516.369130-1-krzysztof.kozlowski@linaro.org>
References: <20230123151516.369130-1-krzysztof.kozlowski@linaro.org>
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

On Mon, 23 Jan 2023 16:15:16 +0100, Krzysztof Kozlowski wrote:
> Bindings expect UART/serial node names to be "serial".
> 
> 

Applied, thanks!

Let me know if anyone preferred to take it via sub-arch/SoC maintainer tree.
I'll drop it then.

[1/1] arm64: dts: hisilicon: align UART node name with bindings
      https://git.kernel.org/krzk/linux-dt/c/b8081b9a80945158e21e62ad31f50b704990cd8a

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
