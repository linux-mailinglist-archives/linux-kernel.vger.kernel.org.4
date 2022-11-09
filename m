Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 144D962325D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 19:24:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbiKISY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 13:24:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbiKISYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 13:24:09 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 486B813F07;
        Wed,  9 Nov 2022 10:24:07 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id s4so10843632qtx.6;
        Wed, 09 Nov 2022 10:24:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lCT0WGIrmgfAytsO6gVTNOPByIoquPTLcjJ7VRnmjS4=;
        b=eLnLOakmhh71IelupohutXa3A5VomDRscBjTm9qxnIvJJ/2ON7YJQMVDTZbdXaOFX7
         fMlSk6i6/lvTXyj5jkXEpI9Jqdq8sPW4fgs76tb/csRRLKkcOJDERDuCOSMejrkSvAl4
         bNej+TDcBrhOCe62Uzh34OvfuuoQ+pOWlnY5EE6/NuH46Z0Rw8qJ2QqMWNofuUJxtvRQ
         sl1d6j9CkkaKuT1J+zxqCLFEF/khbNPNY8vZY0KItoQwnGAkzoiokJz5tjJZsGKG6Z4B
         wKPANZ9Y39WLyhBAYajekr3cRrO7yReyz6fD0p0Po3en3dxiRD2Y0jBpUrWd65NmflSm
         DdeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lCT0WGIrmgfAytsO6gVTNOPByIoquPTLcjJ7VRnmjS4=;
        b=yZZDNWViG1smc33HlCsN8XT+fnVWcfiR5sJlO8Q3mwqmd6vFOxO4XNs4qYmfZbI4oh
         SyQxNqb1bXhBamPGRgnjMgVK9NGVRpVEn6cvF8Abkof7rQpazEgC9NmlLgTgqxIw6olD
         r49OCPup19pVBTOQwBwHfWBdwtE1RcbPdGiIZhA5JNd5gw3gjZdUb6fC7hvkWejBHvaI
         tZIpt5nweSCFy7tpSf4Ci0P7wBCIC2i5fi7NNFPAtsps4QlJ6POZ9iA/ZRLQDMxr/Hbs
         Ih936JRlX1qkVltsQEjmzGbu7UErN0aavQ0WJiiwfwbgdRg3NDbC+0Mj+pYkJO8s5fWm
         D/pw==
X-Gm-Message-State: ANoB5plbIZOjzyVy6BLKB3cjSQkczZ6yEmwS7bitiALZTbCD1333Rb9X
        /ejAqrrv80e8US0LVjNu+htpUhnILP+dlw==
X-Google-Smtp-Source: AA0mqf4Oes0QVwulcKnNIjw8rUGGWVWkd0wb7g6M2QdfYluRQd9r+DOAdOy9c9t6TLcV1nK01LkhZA==
X-Received: by 2002:ac8:6f11:0:b0:3a5:8300:ddb9 with SMTP id bs17-20020ac86f11000000b003a58300ddb9mr15336014qtb.58.1668018246384;
        Wed, 09 Nov 2022 10:24:06 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id bs6-20020a05620a470600b006b61b2cb1d2sm11615549qkb.46.2022.11.09.10.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 10:24:05 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com, maxime@cerno.tech,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     linux-rpi-kernel@lists.infradead.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Phil Elwell <phil@raspberrypi.com>,
        linux-kernel@vger.kernel.org, Dom Cobley <dom@raspberrypi.com>
Subject: Re: [PATCH 1/2] ARM: dts: bcm283x: Remove bcm2835-rpi-common.dtsi from SoC DTSI
Date:   Wed,  9 Nov 2022 10:24:03 -0800
Message-Id: <20221109182403.879152-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221026-rpi-display-fw-clk-v1-1-5c29b7a3d8b0@cerno.tech>
References: <20221026-rpi-display-fw-clk-v1-0-5c29b7a3d8b0@cerno.tech> <20221026-rpi-display-fw-clk-v1-1-5c29b7a3d8b0@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Oct 2022 15:17:38 +0200, maxime@cerno.tech wrote:
> According to the commit log of the commit 3ac395a5b3f3 ("ARM: dts:
> bcm283x: Use firmware PM driver for V3D"), the initial intent behind the
> bcm2835-rpi-common DTSI was to share data between the RaspberryPies
> based on the BCM2835, 36 and 37.
> 
> However, it was included by these SoCs' main DTSI. This is creating an
> improper layering.
> 
> On top of that, bcm2835.dtsi is being included by bcm2711.dtsi, which
> means that, even though the bcm2835-rpi-common DTSI wasn't actually
> meant to contain data for the BCM2711, it actually leaks into the
> BCM2711 DTSI.
> 
> In order to remove both issues, let's remove the include of
> bcm2835-rpi-common.dtsi from bcm283{5-7}.dtsi and put them into the
> bcm283{6,7}-rpi.dtsi.
> 
> BCM2835 has to be handled with special care due to the fact that
> bcm2835.dtsi is being included by bcm2711.dtsi. Thus, we chose to
> include bcm2835-rpi-common.dtsi directly into the board DTS. This will
> be more error-prone, but given that it's a fairly old SoC by now, the
> chance that we will get more BCM2835 boards is fairly low.
> 
> BCM2711 isn't modified since the content of bcm2835-rpi-common.dtsi was
> only a power-domain for the v3d that was overridden anyway.
> 
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/devicetree/next, thanks!
--
Florian
