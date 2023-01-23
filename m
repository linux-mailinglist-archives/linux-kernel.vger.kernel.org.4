Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60B516776AE
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 09:48:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbjAWIs1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 03:48:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjAWIs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 03:48:26 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 820D8CC2C
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 00:48:25 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id c4-20020a1c3504000000b003d9e2f72093so10038190wma.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 00:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fprSFVrrJnip/JTZ37qMzy2gRM9AV21W/+RUwbxSVAc=;
        b=G3wEtCktiXpKXO7gbXkzeOUQSo4i5jg5M1xnnovKINwwAGDloR8BE4pWdIviar144X
         nQUALEqMDZ7NFF2Exd06H67XJp0rRWm1iz261S31dYHt1Q3CWmARWE8jGMiktnddzuLG
         GMX4yFuiMTXXzyZubOKw+I9wQBDmhCkqh91rUHpxzAdQryclK1XLQBnE/xj4GnxJKlrS
         vE26TX9Sq42+jyXFnTawzoukkKfcC4C7dJhWLXxmcziRrbIBDfMfdvYgc5Mt9Hj3pbvU
         lxeLXGNn3VMcwf5CbS74yNr9IER++f6trQBOcMzqKvmb5sUhU6Tt6TUyUxoB2NDbcj06
         nytg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fprSFVrrJnip/JTZ37qMzy2gRM9AV21W/+RUwbxSVAc=;
        b=Ti5W8LczEKuT0CvJBVSgdTSZXft6Gjpo9ES8l22VF5S5ZzY2y315aF0giCVxyBsvwA
         FVQBhQGNbtfs43+qDR9IocqUhXvYadO4pC02WOuibWSmlUJSlzFmXRKcD7D88FhSJoYT
         BfjX4XSjkt93QZ5Dx1C4nvQ4zA2B56O27GJtEYi7Cxvt6TDGAFXqX6NnWtO/SJiDg+2Z
         pH4S5ectkrQ6ZNC3Ml3jXn1GtIe3jtOavoykXyZ/7AKqh6cfIpJBLVr2X6vU09C7w9If
         +OwsIgsOOl6GCD8eL+mufo4bjrxFeqW1HIwfeNa5Vhk9ACZraaDaRN93/elXiE8bOEEC
         GVCg==
X-Gm-Message-State: AFqh2kplccAHxik04X8aWHbU6YLLctLy6DzYOFzq45ShTCWX88OZzUeD
        IdIC4FsTsFG5c4CbYmsphgpW5w==
X-Google-Smtp-Source: AMrXdXtdtS5fuxBNA0md8yjriXvzIDmJ7LM4InlDyxE/6GHR5d5ygvek+mbvRKs0XNOWmQVq3dTCkw==
X-Received: by 2002:a1c:7216:0:b0:3cf:614e:b587 with SMTP id n22-20020a1c7216000000b003cf614eb587mr23472481wmc.26.1674463704102;
        Mon, 23 Jan 2023 00:48:24 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id l18-20020a1c7912000000b003db00747fdesm10024711wme.15.2023.01.23.00.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 00:48:23 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Liu Ying <victor.liu@nxp.com>
Cc:     andrzej.hajda@intel.com, robert.foss@linaro.org,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, airlied@gmail.com, daniel@ffwll.ch,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        marex@denx.de, linux-imx@nxp.com, krzysztof.kozlowski@linaro.org
In-Reply-To: <20230123021449.969243-1-victor.liu@nxp.com>
References: <20230123021449.969243-1-victor.liu@nxp.com>
Subject: Re: [PATCH v3 0/2] drm/bridge: fsl-ldb: Add i.MX93 LDB support
Message-Id: <167446370312.2000622.5778653160134240013.b4-ty@linaro.org>
Date:   Mon, 23 Jan 2023 09:48:23 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.11.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 23 Jan 2023 10:14:47 +0800, Liu Ying wrote:
> This patch set aims to add i.MX93 LVDS Display Bridge(LDB) support in
> the existing i.MX8mp LDB DRM bridge driver.  Same to i.MX8mp LDB, i.MX93
> LDB is controlled by mediamix blk-ctrl through two registers.  i.MX93
> LDB supports only one LVDS channel(channel 0) while i.MX8mp supports at
> most two.
> 
> Patch 1/2 adds device tree binding for i.MX93 LDB in the existing
> fsl,ldb.yaml.
> 
> [...]

Thanks, Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-next)

[1/2] dt-bindings: display: bridge: ldb: Add i.MX93 LDB
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=5e68a0ca59c0891d6b7da8ae7f6764565ff67c6d
[2/2] drm/bridge: fsl-ldb: Add i.MX93 LDB support
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=48865413c9ddab68a774b506b1940af0f6b6089d

-- 
Neil
