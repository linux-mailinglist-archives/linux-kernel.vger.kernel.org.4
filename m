Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C27727157F1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 10:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbjE3IGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 04:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbjE3IGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 04:06:15 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F10E2E8
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 01:06:13 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3f601c57d8dso29598555e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 01:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685433972; x=1688025972;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x65KE+uKYeb7ssZC2FNtK6B+rqgxlUIxtSzrxN15FOQ=;
        b=ffOEDtzeJr+xuIg4YRJs+HxBmRdZ9NFk4+Mx0Ch6k6aCZWaBMLXytREcCsnIz2iXZa
         UV3bz4l7qnjsf4LaVQtmpjb2KulMGMN43h+oxPPCJuWpFy4eBSA4Cd1hqa9xNUIUkvQ3
         Z9rZTPrtlS1nmm8CYxK4tumA4GTTBO9hqfgdpv0rNAn8Ndg85ynai6XSeciCx3EVBcX2
         egfHQAbYI22wAw34083Gz6t3ownLmZmgHcokMAoj9hFkkdMlea/LWsAG2bflk290xA1f
         LCpw0ngJ9efdnXlM+a3z2r9JEZ4W006Xa9DV/6cX38P7hpsM880lgni9yaqPQsETMqo0
         GjUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685433972; x=1688025972;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x65KE+uKYeb7ssZC2FNtK6B+rqgxlUIxtSzrxN15FOQ=;
        b=FawDH3yZLq4CN7cdZeempFPeUAnmnh4RaqyJEUBekPhlWs/5+d+rpm39DQVcisw774
         1nNok+UTPxLkGfpC7UWjMQhxQjzqLhBQ8okIbnXexwBA0uGVxNEWiTMDHGN8PtOEJ9v1
         9Hdcr/7nJr+GzGiti88lHyRyUrM6m5rETl7jArwSRTJzDabyNCOM0u6f0IM6dxkM3fCc
         EKgyfQMGZ27JfNq6i/QC5rCYNViFO3Y/FqhdBjdXHG9GB8FnLHyHQSbDEAsbwoIAW3IR
         V7tiphdWioGz86eiqwYmwgmJN522VOa8yJYNPfCtgBT3YJiSwIeABx7GZp7vUTUmUXEq
         9/KA==
X-Gm-Message-State: AC+VfDwcFxh+nKQ972ZQg23IgTpq3msmSGvNymoaZEmHQ+p88mECkE1E
        D/mMQ52A8BwFdFZXFEs6lLeyIg==
X-Google-Smtp-Source: ACHHUZ5BFb11PtQ/I26ACejaIx73ewZ0yAW4jCRQ68LHqsCiA8uZpZefR1IYaxoZ9MVi2UkwACp/fQ==
X-Received: by 2002:a05:600c:3651:b0:3f5:fa76:8dd0 with SMTP id y17-20020a05600c365100b003f5fa768dd0mr1311471wmq.0.1685433972473;
        Tue, 30 May 2023 01:06:12 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id v4-20020a5d4a44000000b0030497b3224bsm2369704wrs.64.2023.05.30.01.06.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 01:06:12 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     dri-devel@lists.freedesktop.org, Adam Ford <aford173@gmail.com>
Cc:     aford@beaconembedded.com,
        Conor Dooley <conor.dooley@microchip.com>,
        Inki Dae <inki.dae@samsung.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230528132727.3933-1-aford173@gmail.com>
References: <20230528132727.3933-1-aford173@gmail.com>
Subject: Re: [PATCH V2] dt-bindings: bridge: samsung-dsim: Make some flags
 optional
Message-Id: <168543397153.1595635.3344136004150912350.b4-ty@linaro.org>
Date:   Tue, 30 May 2023 10:06:11 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 28 May 2023 08:27:27 -0500, Adam Ford wrote:
> In the event a device is connected to the samsung-dsim
> controller that doesn't support the burst-clock, the
> driver is able to get the requested pixel clock from the
> attached device or bridge.  In these instances, the
> samsung,burst-clock-frequency isn't needed, so remove
> it from the required list.
> 
> [...]

Thanks, Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-next)

[1/1] dt-bindings: bridge: samsung-dsim: Make some flags optional
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=5769b45abedca0b9d14145e156c180af36139416

-- 
Neil

