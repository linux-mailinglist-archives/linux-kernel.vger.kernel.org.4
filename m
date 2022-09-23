Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2A05E76E4
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 11:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231809AbiIWJZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 05:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231708AbiIWJZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 05:25:23 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 773F29FAB8
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 02:25:20 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id x18so13460862wrm.7
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 02:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=MRMPaYOZfRCFMzm//UQtHGBmnKZ92vWhPYsR/JQQCX8=;
        b=xPAwfG4lwIZe1N2CQA2b5d58frzx6XaqGIgTIPpkeutE3qwSyOnJA4iwB1gE6wejAm
         ECZVSlIB+AJ0IrTt8Db5oZOkm/Sl/htleP4s8l5fkAkG/4FgD3TMRO1H4RAH3pXFCVTp
         0CFtcooCmg8YZ0YAwwlUhfI4i3gTDQfqsc9S6bEjDR21ZljvfV8MihhdUbP81Y+EVzIq
         kwH+sPTJitlezkxCc60MV8Wo8WBYbvCfX6qJrAfod2VcBm2QwnlauNKJCTIlMNlLA3ix
         awG7sYa0cV8DWPhGVivGj+3bRgTIFSTltsZ7TRQBZPSkfu1g0/f4c/a9ZOUmeU6Ejr06
         83bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=MRMPaYOZfRCFMzm//UQtHGBmnKZ92vWhPYsR/JQQCX8=;
        b=xZa2nlGUkQ6reI4rs+ARiHTPZk6B2exffdBC6sA0puwHgXYWuRCPFUgLzo9/41b+Mf
         j1p8Vsh5GuukI2GVg57xJhs00Un3WFoXjnb5XekqwT3atQe8oaRolXmdkETplm/i3DP5
         7zEu/Txjq9YrAlYtZrfqBMWWmggi2GrndQ6p/C8VKEprPn+pcoaYsc/ePlxOLEQZqooL
         0MlVGO4GPJwV1yGj0bzLafXLY55WBNdcQEPvJwmoxKT3+u21r0CGGh8hShHgalq0iwlm
         vEdIHp4aYCNzMa34PROZJ37ZGnZ0WhFyY2Fp8kZwgCvCTpEVESknpFGdGWnbIViungVz
         Br1Q==
X-Gm-Message-State: ACrzQf3kPLiF6TllyFkz9AvjKAKiXNm2JPWdO/3PT01DEi3JvLoYPJhK
        nBviYGWJkoDpoqnwW6u21PnqlQ==
X-Google-Smtp-Source: AMsMyM4l58g79jGtvMO+UdAXgSJqnb8aVzNb7Eb1oWURmqua3q3sfZwcBOixGa/oM2iNe+lXwCYqUQ==
X-Received: by 2002:adf:f385:0:b0:228:dbf1:d731 with SMTP id m5-20020adff385000000b00228dbf1d731mr4374900wro.364.1663925118554;
        Fri, 23 Sep 2022 02:25:18 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id u7-20020a056000038700b002258235bda3sm7493347wrf.61.2022.09.23.02.25.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 02:25:17 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     dri-devel@lists.freedesktop.org,
        Adrien Grassein <adrien.grassein@gmail.com>,
        Philippe Schenker <dev@pschenker.ch>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        linux-kernel@vger.kernel.org, Robert Foss <robert.foss@linaro.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>
Subject: Re: (subset) [PATCH 0/4] drm/bridge: lt8912b: Fix corrupt display output due to wrong bridge config
Date:   Fri, 23 Sep 2022 09:25:15 +0000
Message-Id: <166392509385.2599200.1091239047831409182.b4-ty@linaro.org>
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

Thanks, Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-next)

[4/4] drm/bridge: lt8912b: clarify lvds output status
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=fc44f3636a4db6544fd1532280e8adcd1ef13ba2

-- 
Neil
