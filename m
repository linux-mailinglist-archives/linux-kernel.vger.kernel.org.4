Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15F0966197B
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 21:45:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236167AbjAHUpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 15:45:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235924AbjAHUp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 15:45:27 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B739B7F1;
        Sun,  8 Jan 2023 12:45:25 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id v10so8593518edi.8;
        Sun, 08 Jan 2023 12:45:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n4q6oMwCm/gTCrJ8zmSnOgEED+29tA9nSZ+RX66hDuE=;
        b=CqWy6eWNskIRB1eU28NVg8geynNqjY6Aoi0d40nKO0fqamMoDMOqYWA1EWLhYEROUN
         XEpiBFCWMXlK5pux/4inKU9j5i3/MQbN5xd29yNgZTKgHWx0x/lwRdR1E6kgcOh1cNNm
         am7xl6rQz05zj6EzgwkhwBDsk1IYk5z67cYNe7PDC9o7aJ8vesUMJZt3FeqeGdBx2oRk
         HGsSA1ztKvWIe800HRszVWa59v9tmh+FIr8ocgaiQ5pqiwsFWgE890/kz01avTeUtH9j
         7he+qpvsuiOeWdxPIzkt3tGOKo4VfnSVLK5MeqNxgqJh74C2O0GtMxhykXPKnAaFwp46
         221w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n4q6oMwCm/gTCrJ8zmSnOgEED+29tA9nSZ+RX66hDuE=;
        b=oGox1rVMYjqRvpQdYGtTUQCrbx+8jLjCE1vOkts2hcrzsM8YSH0a9X7aHNJKohHaKi
         gX1MM+2VBpp2YovH79DTqVHd4kSUogb4Uue0oYl/d9MbSCMWqVPPyT9rnH4a6rQKwExc
         RgSSKJ33zjbA2rx26KU63MCroJrEXm47n0AXA5QFh3SA7+SclvEfUyjPTRB0ghbwSbgU
         jbTrJ9emImzk5ei/pY2RCeCul3uKvEFzPWbesrHdwfmWG1oFr0rLHzZz8Y9u5tW3cAQP
         mv/LCyPzmo3U1gCU5L3m+dVf+uhgj9VN6gqnyWlIQv1n1uZqx1wH4QE4spiG+fEQawgt
         EiPQ==
X-Gm-Message-State: AFqh2kp1UJpxJQbki6qpXK3XcHl2bgra68zPlh42Y2nxVQzbSCttWm8T
        p6m9GqmJzhsMyHNerpAkDX4=
X-Google-Smtp-Source: AMrXdXt7tkRvV/unsvlcOLXlm6E0PeHcJAMS2YvEvKWEeYhUt+Yv9NlwkSHxpJinl7xdfk3BCP0Mzw==
X-Received: by 2002:a05:6402:3887:b0:496:4d2f:1b4b with SMTP id fd7-20020a056402388700b004964d2f1b4bmr8860882edb.7.1673210724121;
        Sun, 08 Jan 2023 12:45:24 -0800 (PST)
Received: from jernej-laptop.localnet (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id p24-20020a056402075800b0049668426aa6sm2946544edy.24.2023.01.08.12.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jan 2023 12:45:23 -0800 (PST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] ARM: dts: sun8i: h3-beelink-x2: align HDMI CEC node names with
 dtschema
Date:   Sun, 08 Jan 2023 21:45:22 +0100
Message-ID: <21769801.EfDdHjke4D@jernej-laptop>
In-Reply-To: <20221204183341.139946-1-krzysztof.kozlowski@linaro.org>
References: <20221204183341.139946-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne nedelja, 04. december 2022 ob 19:33:41 CET je Krzysztof Kozlowski 
napisal(a):
> The bindings expect "cec" for HDMI CEC node.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied, thanks!

Best regards,
Jernej


