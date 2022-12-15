Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9F4E64D9A9
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 11:45:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbiLOKp0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 05:45:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiLOKpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 05:45:23 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C0D21F624
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 02:45:22 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id c65-20020a1c3544000000b003cfffd00fc0so1398778wma.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 02:45:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KHuddhTs1woKQMA5yxy2mTLY+wNV6WvVLa7elkBE4tw=;
        b=vkk0Z84jrKQRm876NHO6IUZ/gtYYo3q7FnC1uP+EyV2QxKZ3VeWyN+x2wUriqyW07k
         gKhLpngEf5ukIXa2tlu9NbZrQxiZSvpZlqMpGS1OH72wv80WzJMG2mJbM3eVfg2S/Jfh
         cs8NEvYSzUmAbxL3szMKEoVmwxe8Fho2Yj3D3ZFi386cyq0PLOlg30BFfHSIz6WqwrGr
         2Ef5xsIC9DhHlTbyqEMnkhDFt9b4ryWhnjVeAhSSNkIMHp5xHvrTCzhoL+MFRAsw7xKu
         WAj/P2WYxMICJO9H3YYeRaasNOjsvB4RRJb2gUxVU9JPOmBQ+te+cyQPWKhofnECAdeu
         4AhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KHuddhTs1woKQMA5yxy2mTLY+wNV6WvVLa7elkBE4tw=;
        b=5WAQWTitgZcyLQiPbJqChV5/9K6IXLWhZAY04SqdHl1sE07K9ayePa0yUnbKpPwBeT
         i4m1mpitc524uRLjKBLe1D8Ed7qvyUwbTRUrCqceFHYiJ3oOtEk+157cx4FebGR1y1RP
         gP5gpebRV0E4TMwOhpRazLrijDX1q8ktyTNT9cR1WuVA+uZbNfBwjfW0uwtPN8pM3AjJ
         xvI/WqMvkG2sSR07ffy/UgeIvsM5oW9U17QR3Fm1304Fu0xnlfyDXjCrik2/QN8nUbLR
         XwIuUtTdpGl4MjG0xFmPcWA04WsPtMXviwvfMxMqMDuwOnkde8iLVqiOjQCW56g7IcP5
         QNqw==
X-Gm-Message-State: ANoB5pkcmZgtuNRANx0EnYnRLqppaahacP5nJ64Gh5kLj/F4t9pINsdv
        +BEthgs+V9m8Xv3Y/5Mep9+TVg==
X-Google-Smtp-Source: AA0mqf61J2YEn7tAitSvNv7cg8MsrjGIppG7rPDoRjCfzx+1rPn+1m9vchRs7d/GhhC+bfyHG2RTxA==
X-Received: by 2002:a05:600c:310e:b0:3cf:b07a:cd2f with SMTP id g14-20020a05600c310e00b003cfb07acd2fmr21041676wmo.37.1671101120589;
        Thu, 15 Dec 2022 02:45:20 -0800 (PST)
Received: from prec5560.. (freifunk-gw.bsa1-cpe1.syseleven.net. [176.74.57.43])
        by smtp.gmail.com with ESMTPSA id m17-20020a7bce11000000b003d2157627a8sm5919771wmc.47.2022.12.15.02.45.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 02:45:19 -0800 (PST)
From:   Robert Foss <robert.foss@linaro.org>
To:     Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Pin-yen Lin <treapking@chromium.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     Robert Foss <robert.foss@linaro.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        allen chen <allen.chen@ite.com.tw>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/bridge: it6505: Add caching for EDID
Date:   Thu, 15 Dec 2022 11:45:10 +0100
Message-Id: <167110107985.909515.966397009406015766.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221115112720.911158-1-treapking@chromium.org>
References: <20221115112720.911158-1-treapking@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Nov 2022 19:27:20 +0800, Pin-yen Lin wrote:
> Add caching when EDID is read, and invalidate the cache until the
> bridge detects HPD low or sink count changes on HPD_IRQ.
> 
> It takes 1.2s for IT6505 bridge to read a 3-block EDID, and skipping
> one EDID read would be a notable difference on user experience.
> 
> 
> [...]

Applied, thanks!

Repo: https://cgit.freedesktop.org/drm/drm-misc/


[1/1] drm/bridge: it6505: Add caching for EDID
      commit: 11feaef69d0cb81278294299bbfd86f94c2004e3



Rob

