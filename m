Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A997719F54
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 16:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234056AbjFAONF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 10:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233955AbjFAOM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 10:12:58 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A031B0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 07:12:49 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-3094910b150so963598f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 07:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685628768; x=1688220768;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=blRDmP8zwUxnWYu3O2q7G8SVs+SLeK3eRrnyEq5ozP4=;
        b=qdN3sFmE0bkWjRKWetOAT0HHLZIxe86o4BV9VjIYHiUK3XPu2S8gc0aoVmeWcrs4cy
         agjoc2/Hh7uBRXSKUK6reJT3RUJmkZAEwpys5HDX5bJr6n6VJa7oPa+LItSY9540le1v
         c5xeuCTZ1QVljMhR3nmnMXrrL0arqyhLw8IIxDSf/EhE6ILbEj1sEW03f3QystUPuj5Z
         bDEUctCPLc84Ov0ke0ettWxLK3yjWZ3RCAHD2zRdmVaAybo0NiXe5TLVYrUVI645Qq06
         9BbZlfyjNk5aeQp4Zj1+EaGkNAjjCWOgccsS3/JaCUwjXDNUT+G0TrhVnq5XV5ORs7dF
         6+6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685628768; x=1688220768;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=blRDmP8zwUxnWYu3O2q7G8SVs+SLeK3eRrnyEq5ozP4=;
        b=gA+qkdxTeWBBekrl+fkRI2eeZWxK7Orog4lZ4djxmFyZcc8nmUeFf8XAtpa3414/RT
         1k8DR60+qydbv+ZfjRaxvnt06p24z77GlOccFnucR5f0QNWLGNtn/mDG5Pjj+V2QBgiR
         jGP8LSkgHR6mmIo44xybAn3vEMFwuhI02MkJ8+10Zpwna8P6NcqZfwYG7gk/TECx7KLQ
         13d0aCBSGM+vPnjwfhfn9wtdSWJTrfLY3KFyWo58yBuV94jQTOcFUTQbKpisSw3gV984
         GZJ5fxSCFMgDndf38+qxr0rbVM6s6pByg2k4Zh+/O5lh03dW3MhaEy5De1F9Rt0BwSrt
         XSHA==
X-Gm-Message-State: AC+VfDyaolKhvhUhsSeEPEZv5y1S1i8HMGzdxxt6eehtgruObSQgAse+
        JnnQdqsbdmAEVgwWDO2hELwhtQ==
X-Google-Smtp-Source: ACHHUZ6/ivQPA2lY433i2n8DT8ybJaluMhJNQm/WfFkDzmtsk8A31ifylaUb4N2I4BWnvbWtYj/ztw==
X-Received: by 2002:adf:f244:0:b0:2f6:bf04:c8cc with SMTP id b4-20020adff244000000b002f6bf04c8ccmr2034350wrp.55.1685628767960;
        Thu, 01 Jun 2023 07:12:47 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id p12-20020adfcc8c000000b0030adfa48e1esm10629591wrj.29.2023.06.01.07.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 07:12:47 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     "Lukas F. Hartmann" <lukas@mntre.com>,
        Nicolas Belin <nbelin@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-phy@lists.infradead.org, Rob Herring <robh@kernel.org>,
        Jagan Teki <jagan@amarulasolutions.com>
In-Reply-To: <20230512-amlogic-v6-4-upstream-dsi-ccf-vim3-v5-0-56eb7a4d5b8e@linaro.org>
References: <20230512-amlogic-v6-4-upstream-dsi-ccf-vim3-v5-0-56eb7a4d5b8e@linaro.org>
Subject: Re: (subset) [PATCH v5 00/17] drm/meson: add support for MIPI DSI
 Display
Message-Id: <168562876692.86739.7052062833690353953.b4-ty@linaro.org>
Date:   Thu, 01 Jun 2023 16:12:46 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 30 May 2023 09:38:01 +0200, Neil Armstrong wrote:
> The Amlogic G12A, G12B & SM1 SoCs embeds a Synopsys DW-MIPI-DSI transceiver (ver 1.21a),
> with a custom glue managing the IP resets, clock and data input similar to the DW-HDMI
> glue on the same Amlogic SoCs.
> 
> This adds support for the glue managing the transceiver, mimicing the init flow provided
> by Amlogic to setup the ENCL encoder, the glue, the transceiver, the digital D-PHY and the
> Analog PHY in the proper way.
> 
> [...]

Thanks, Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-next)

[06/17] dt-bindings: display: add Amlogic MIPI DSI Host Controller bindings
        https://cgit.freedesktop.org/drm/drm-misc/commit/?id=0628f2341e96213c9f2d074853b255f65acd3795
[07/17] dt-bindings: display: meson-vpu: add third DPI output port
        https://cgit.freedesktop.org/drm/drm-misc/commit/?id=25b3b35cd51ef0d98165666d250a51f39db6a1fc
[08/17] drm/meson: fix unbind path if HDMI fails to bind
        https://cgit.freedesktop.org/drm/drm-misc/commit/?id=6a044642988b5f8285f3173b8e88784bef2bc306
[09/17] drm/meson: only use components with dw-hdmi
        https://cgit.freedesktop.org/drm/drm-misc/commit/?id=44e16166e0e9b94d8bcdf55fc0e5fcceca1154f0
[10/17] drm/meson: venc: add ENCL encoder setup for MIPI-DSI output
        https://cgit.freedesktop.org/drm/drm-misc/commit/?id=51fc01a03442cce5e4c21375a1ceb2e4ec93c833
[11/17] drm/meson: add DSI encoder
        https://cgit.freedesktop.org/drm/drm-misc/commit/?id=42dcf15f901c8222352da31d622b4ee844068f42
[12/17] drm/meson: add support for MIPI-DSI transceiver
        https://cgit.freedesktop.org/drm/drm-misc/commit/?id=77d9e1e6b8468f701ab024a060aa9c0339356870
[13/17] drm/panel: khadas-ts050: update timings to achieve 60Hz refresh rate
        https://cgit.freedesktop.org/drm/drm-misc/commit/?id=29c6df0d942454cb43334cf0e36de068f4124b94

-- 
Neil

