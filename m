Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7AF62325F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 19:24:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbiKISYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 13:24:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbiKISYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 13:24:20 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D27D5581;
        Wed,  9 Nov 2022 10:24:19 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id w4so10883470qts.0;
        Wed, 09 Nov 2022 10:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pqM046dwqBjUM6C2NT0DiNjIN/cY6VK7zdFsopKz1JA=;
        b=nFSh2Fwu+wKzUsBmsb+BYG+RgavImc+Rzh686scINHamuRaoiVlQ2VspEmOt8bH/8s
         fQKSE/vdn8xxg7l02oU//fn4ctdtrRs09GvXIbUBoiLXKl1FtHxgfeAgFxr/lHnbabXj
         TSqtDnc+EOmH+9kn819KlFV0P0HIk+EeY6KRzJ9Rkt9JxO6pqVguJVkcJ1DSc8nI+Qh4
         HmqRqriWQaKsZ1WxiJFhgkksrCOcX/ZwhIKjz4Uk7YEIwI8EBqRNV5EKWuJZ9DkPR9Fv
         NTB6ANTaH8OfImV1BbE0mWeO96rLbLXtKWg+zDgNOC2mlEvvML2v8ORXA7KUON7vh/9r
         sPbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pqM046dwqBjUM6C2NT0DiNjIN/cY6VK7zdFsopKz1JA=;
        b=UOyheojyYKMHO7oWgJfPWdqtxmojNqUXYGWmUahoaFgnYiNlULkQoDwo0wEReX7K3/
         aIEHYgv/vk5FcMb0VSSXUl5vwuj/DgmPzEvDuLcgy3dvaZ/I4tzm33G03bpDTTN4vn5W
         F6jm74I+3zKcV/Jcsrs8pFCL9kCKlFu+9HDMN6iDQpEPs4R1/fNus/7o3HkvuWQ0R0xv
         EYK4Yrje3PHrO2Cn1bSObZNL8j1OGmW34zWomtpYmeHa/ngYPmPoAOTPDi9qxONkttZl
         oK/t9dmDLxTBvf2XIkGtUTG0w8d+occ7Av1j26/uIjim7kZ28rBMCJvW6SIIznjqykfd
         Uk5Q==
X-Gm-Message-State: ANoB5pnb26jCLU7hxpFQKbbPBQrtKqoX727x12o0X0EpoHj2886Frdkn
        Yt8yHqIt8qVZZFPiB02mmkI=
X-Google-Smtp-Source: AA0mqf5KyFAZ6v1IYSH+sJpTcTplj6JKYfL7K8Bzoy3InLw+3D/VPe62vWwcekJ3En3k4w/oYmFvpQ==
X-Received: by 2002:ac8:543:0:b0:3a5:ac2c:97be with SMTP id c3-20020ac80543000000b003a5ac2c97bemr5887308qth.374.1668018258511;
        Wed, 09 Nov 2022 10:24:18 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id az36-20020a05620a172400b006ce9e880c6fsm11642106qkb.111.2022.11.09.10.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 10:24:17 -0800 (PST)
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
Subject: Re: [PATCH 2/2] ARM: dts: bcm2835-rpi: Use firmware clocks for display
Date:   Wed,  9 Nov 2022 10:24:15 -0800
Message-Id: <20221109182415.879238-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221026-rpi-display-fw-clk-v1-2-5c29b7a3d8b0@cerno.tech>
References: <20221026-rpi-display-fw-clk-v1-0-5c29b7a3d8b0@cerno.tech> <20221026-rpi-display-fw-clk-v1-2-5c29b7a3d8b0@cerno.tech>
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

On Wed, 26 Oct 2022 15:17:39 +0200, maxime@cerno.tech wrote:
> We've experienced a number of issues around the cohabitation between the
> "real" clock driver in Linux and the one backed by the firmware.
> 
> One solution around this is to follow what the RaspberryPi foundation
> in its downstream clock, which is also what we've been doing on the
> RaspberryPi4: to use the clocks exposed by the firmware.
> 
> Link: https://lore.kernel.org/linux-clk/20221021140505.kjmw5x4s6qhnrfif@houat/
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/devicetree/next, thanks!
--
Florian
