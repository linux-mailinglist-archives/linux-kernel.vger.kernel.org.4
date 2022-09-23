Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA86A5E76CC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 11:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231649AbiIWJXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 05:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231640AbiIWJW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 05:22:57 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF68E109B
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 02:22:56 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id r7so19502309wrm.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 02:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=+FMrWVPMEdwOx/W55baV9JxuYDjrfIXtXPnEvm7boTY=;
        b=gYCUK6As6KB+HLSu3BT7UX66xB7PkHmzNVE6h8asKIIKTx98ShJWCMzL9c1NK5Cq+B
         0QsPRzfnsMZjiK20X+6OV8Fe4ohhva8mccwVObMeNcDXzJnacfPKeCaMolvwM6bDWt63
         ckFeKgs+Mgk6A3ES7vSqAn3tp6b5HF+LXAZA1iQe/yBXmVNTfXZo2Lc3Ocdld1JSPhom
         tbdibbmROVsjhbsxBll1pNjRoZZsrAXfiIaMT/xtPbIDgaOswJkNb4Cw7jy2y4nE/JtK
         tKEPVV6prpcb17g+e8AsyIQyNFTgqZYp6B+vgy9+m7YJ41kPOX53yGVAame/QAT5grdA
         amDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=+FMrWVPMEdwOx/W55baV9JxuYDjrfIXtXPnEvm7boTY=;
        b=CtiABeTcrszuxukVTUWuaqOXs+cUIiZKmc8P6JC6g1FN7ax27UVXD74sRikLgb6R4+
         RW2voJJeZcXSoDeKiSBGP6QcyMALzdZifVoo/2+NPJl34PNsj9Hro3qFldR4MVWFH/1o
         941idx322KdEKtLXzGjj0FUQmGMbhCqnUFQbkeMPqyArr6WgBeGJSpBsRGocoHV3pcFz
         UY2NEDrKjq+/P8R2AbTZlv5KTM5iw+o+SIE6m8mV2VmP8ZcHynDlEKOeLyuzpk/EkJOF
         eUoeDu6EkfqO4jO45Y7MX5TplDg8h5W42Pp43U80LoVoKM30K/wprRnDtjodLc5TdM5A
         KBaA==
X-Gm-Message-State: ACrzQf3wCQus4zJ4iTeigHSMtFrs18FEeU/017xOvMoK98rCmPCzhw9a
        abDsrKs7H8TIzPfJ832oRr3hqw==
X-Google-Smtp-Source: AMsMyM4QFxOpC09rxWp8RxoPj+GvwVFgv0PH2mQHmJD/3gtMAWmmXhkNvMwxQLHUsYAgkKJ/Z9g8ug==
X-Received: by 2002:a5d:66cb:0:b0:228:63bd:dfd6 with SMTP id k11-20020a5d66cb000000b0022863bddfd6mr4604502wrw.86.1663924974899;
        Fri, 23 Sep 2022 02:22:54 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id p19-20020a05600c05d300b003b3365b38f9sm1921256wmd.10.2022.09.23.02.22.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 02:22:54 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     dri-devel@lists.freedesktop.org,
        Philippe Schenker <dev@pschenker.ch>,
        Adrien Grassein <adrien.grassein@gmail.com>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <robert.foss@linaro.org>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>
Subject: Re: (subset) [PATCH 0/4] drm/bridge: lt8912b: Fix corrupt display output due to wrong bridge config
Date:   Fri, 23 Sep 2022 09:22:52 +0000
Message-Id: <166392495428.2592704.16276233833718753255.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220922124306.34729-1-dev@pschenker.ch>
References: <20220922124306.34729-1-dev@pschenker.ch>
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

Hi,

On Thu, 22 Sep 2022 14:43:02 +0200, Philippe Schenker wrote:
> From: Philippe Schenker <philippe.schenker@toradex.com>
> 
> This patch-set fixes the lt8912b driver that currently does not take
> care whether or not the attached display has postiive or negative syncs
> and or reports on EDID if it needs HDMI mode or DVI.
> 
> This series addresses also an issue where the LVDS startup sequence was
> written to the wrong I2C address (the lt8912 has three). This caused
> writing into reserved registers and causing an unstable HDMI picture
> that manifests itself only sometimes and depending on the monitor with a
> flickering and a repeating of going black and coming up again. While at
> it move also some sensible comments to the sequence.
> 
> [...]

Thanks, Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-fixes)

[1/4] drm/bridge: lt8912b: add vsync hsync
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=da73a94fa282f78d485bd0aab36c8ac15b6f792c
[2/4] drm/bridge: lt8912b: set hdmi or dvi mode
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=6dd1de12e1243f2013e4fabf31e99e63b1a860d0
[3/4] drm/bridge: lt8912b: fix corrupted image output
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=051ad2788d35ca07aec8402542e5d38429f2426a

-- 
Neil
