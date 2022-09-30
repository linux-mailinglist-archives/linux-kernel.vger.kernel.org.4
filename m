Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A0655F0BB2
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 14:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231611AbiI3MZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 08:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231265AbiI3MZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 08:25:09 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A32CA2034E
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 05:25:07 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id u18so6616580lfo.8
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 05:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=njbWtD08ViSccnQ66ue7s1hY8BgSMKUfwf3StI6pfZQ=;
        b=qKNmQxnFH8bG4C61TzRUUFnmbtU7nuUiN8cOygFVZUui/21GTVsjyK5UTyMP9Qq9/d
         dQgAZbueTYbN+5GV5sv2yjn0iqFKwQnZISXK/mgps27L5XuUOkrarxTvWIOtc69bXEFE
         MLeHg56BmO4aBAbvd+2OESIwwZKE0m5ZLv9zilns25+7BRNaD53ZGa15TtfnHiEwPaJt
         uFe2H8yLnnhnEUNKbjCJyNrJeEqG5EnR5gBK6hqyuHi9XbD6QGZdbDWdJKzfPLb5eq1z
         co8GsuCWIagqCI7xrlRBY37GCR/RDPn4450FWgZ2OZabuwEWcwlHbMkuZZmAMyNLlRut
         1aRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=njbWtD08ViSccnQ66ue7s1hY8BgSMKUfwf3StI6pfZQ=;
        b=Td1YeyExeDbw5g7w58/fQ+tlTcWgG94VHi9rmRYImaQfI8Ze/11iTfDDXiOLshCmCq
         jwTug2VuhipExf3rnjX+LPkC5pL+cIR/GoHfCfRP1SWwqQ0PxDOgNRYjzuNpVfFzbbHY
         FvVfZ2qjioFkId0o1Lanqvbn/M60t5+HVlEbyaP1i5mLV0LGvlYFQHTK5YoDfVY3f2qk
         47xVSX/Y60v3mp1KZPnv62diRLGS3y056DyNCm1ulTuDClqt6d3nscYpWnscB8/4r5bY
         94Xw2oAAkHt0I5XD94NpXenOcIX++6TjRtz50Hca3m59Rep8LKOA9oqKOQFFX92cjWvq
         vGZQ==
X-Gm-Message-State: ACrzQf3k/JEYThBGg/jGY62vFyJ04ea9nOmRN39J7YA0xjjQGDaa+Bd3
        FCryCsy7rnGlPE7Jlon0AmBQFw==
X-Google-Smtp-Source: AMsMyM4fPRKZsl6+dn1tqcCBJgqnDC/nLU7itisMB6n6xQaJb7w+9dbGVQ/2hIynUoFV0Wurk+kw/g==
X-Received: by 2002:ac2:5462:0:b0:49b:8aee:3535 with SMTP id e2-20020ac25462000000b0049b8aee3535mr3078001lfn.410.1664540705955;
        Fri, 30 Sep 2022 05:25:05 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id i12-20020a056512318c00b004a031805c8bsm282968lfe.106.2022.09.30.05.25.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 05:25:05 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Alan Stern <stern@rowland.harvard.edu>
Subject: Re: (subset) [PATCH 1/2] ARM: dts: exynos: fix polarity of VBUS GPIO
Date:   Fri, 30 Sep 2022 14:25:02 +0200
Message-Id: <166454069282.276470.5690165135266592824.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220927220504.3744878-1-dmitry.torokhov@gmail.com>
References: <20220927220504.3744878-1-dmitry.torokhov@gmail.com>
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

On Tue, 27 Sep 2022 15:05:03 -0700, Dmitry Torokhov wrote:
> EHCI Oxynos (drivers/usb/host/ehci-exynos.c) drives VBUS GPIO high when
> trying to power up the bus, therefore the GPIO in DTS must be marked as
> "active high". This will be important when EHCI driver is converted to
> gpiod API that respects declared polarities.
> 
> 

Applied, thanks!

[1/2] ARM: dts: exynos: fix polarity of VBUS GPIO
      https://git.kernel.org/krzk/linux/c/a08137bd1e0a7ce951dce9ce4a83e39d379b6e1b

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
