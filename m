Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C78D86AB8B3
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 09:46:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjCFIqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 03:46:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjCFIqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 03:46:02 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F3593
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 00:45:59 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id e13so7904001wro.10
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 00:45:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678092358;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KGgblINf1oSUrHE7vG5UT+0t4KWItuliO8YSeFEQXWY=;
        b=iOJyqICbzCSAVKWpCfc6JpA9YbSYbxHXP4R5jAPaCHCsvueoKbxUQMlYCWgeLcrbge
         Hncqgks31sxch5hNeBQqK7AENqtXDM8PGlZ6cTh5f86NaLzbFiqGx4WSupKawRwdp6E2
         f8ODmJ9eqUvR9KcceYLmgQz+4kdBCnjeNtq8Pj2ANL44gtk/vn07L4AESDHjmP5tuf6k
         0UKHXzk3KhV2mjSzwr9B+s8L7CkUKxmRrJCCeuyriS+00MWf7nCScqtTnrGZUU4Tebs2
         kxXFmIBLzAkg3p36h37mkHUvEwyIlIw3C1/VsQkbr/ALxDPLFn6quZUHHuZZWCKu9XWP
         vsEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678092358;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KGgblINf1oSUrHE7vG5UT+0t4KWItuliO8YSeFEQXWY=;
        b=2otwt90YAeUko07PWFmdeGBTnVJOS0nixCbKpmf/1kppdT0snTkFU3EFZ+5Ush6IMB
         4DswolF9GIa3sdC7LWrSKnRUS53KMNqVeQEvwYWl6uZeZjrEvWdkevYbXFbPWsUQ88Wb
         zYTYds2QzZMicL7reX5F2diU6lDvZrWZ404fLGpXURAXlaFY+2ofQoXRw8FDB5Pxu27W
         l6bQEAyIfFtf2etfVLqqfoV2zgsRGwm4lXdRXkxPrC+kUXV0TUThBsBiJQTpIQrtLrhU
         VhfhO0iz/u/yZNNIwd4xrwqS8WaIMDgGc5rZ9q1vMcm5LnOQxthQFXvWYVAQKpbMvRws
         elAA==
X-Gm-Message-State: AO0yUKW+VMTRYmzVB6HcKjl8/SOHZMoW+zeDqeyXe6sxZGJEj2hDQ6Rw
        KfjAdd+S5YuNBb/QE5UXSHcCag==
X-Google-Smtp-Source: AK7set/Gb8DdX2nE0tkhozoqEePJKzDSd7X/y8H/U/U9bI2QOtXMyKO3rmaLpFPIItSL5DQyJNdN7A==
X-Received: by 2002:a5d:5407:0:b0:2c6:676c:4af with SMTP id g7-20020a5d5407000000b002c6676c04afmr5664040wrv.36.1678092358179;
        Mon, 06 Mar 2023 00:45:58 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id h18-20020a5d4312000000b002c7107ce17fsm9345093wrq.3.2023.03.06.00.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 00:45:57 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Da Xue <da@lessconfused.com>,
        Carlo Caione <ccaione@baylibre.com>
Cc:     dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230210-relax_dmt_limits-v2-1-318913f08121@baylibre.com>
References: <20230210-relax_dmt_limits-v2-1-318913f08121@baylibre.com>
Subject: Re: [PATCH v2] drm/meson/meson_venc: Relax the supported mode
 checks
Message-Id: <167809235742.23820.6915365420027351819.b4-ty@linaro.org>
Date:   Mon, 06 Mar 2023 09:45:57 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 13 Feb 2023 10:32:09 +0100, Carlo Caione wrote:
> Relax a bit the supported modes list by including also 480x1920 and
> 400x1280. This was actually tested on real hardware and it works
> correctly.
> 
> 

Thanks, Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-next-fixes)

[1/1] drm/meson/meson_venc: Relax the supported mode checks
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=bf458e5b139894234444e4f88500616a8398b719

-- 
Neil

