Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3185070B8B7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 11:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232745AbjEVJVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 05:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbjEVJVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 05:21:16 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A70A1A8
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 02:21:15 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3f607dc98cdso1849685e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 02:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684747274; x=1687339274;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1VacdKeZCjPhD/SpW9R0zd/0SapShlT3F3TXr88hz5s=;
        b=I+Y1NWovJ0NVRaQo+mdhuzI0Bel68VjKxnDspYW/p+A4HoEFpUEfwtxPUwAOXbVxv3
         H0k1+JNyPnQ7sT6sx7i1fqc6UyuA+P9gyeezY9upA270OzcXOHzDNqBzjgJNOTYX06DL
         aA8C0Bp+1oEpF6DGBlOzcwlBXFBvWlwCZPfZ2B6lVgomr7xaegGo3zeFG7dYAYEGzAbN
         XjNrY2DF7AQSJvzBumCk2/Olr0v/TMqCKX/NvVrP4TG7lnP6U8cWcY0JDIwXRznCKZsy
         94ATtcfv5G9fV9sXYxEyqaxgQxpKSZZ0ZCd3HGnbVnLSkHOn1Clg29VdHhqtKXwijDWC
         55dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684747274; x=1687339274;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1VacdKeZCjPhD/SpW9R0zd/0SapShlT3F3TXr88hz5s=;
        b=JwvJWGK+SGc/hXT4VvxR4O6kYrPx2nADpW7W8yZ9vy7BN5c5A16h8s2e3HtXAzghIs
         G96NTxFGqNWH8Sgb6x0bXkFmOxaFnlYstD0HyNWI2eCRkXn3OAlMny5yOO0fwfB3Qim1
         Xvxoq+4er0h6fSAHzGEQyGdtJR/uiBmxOcHmROe6Sj6d0by+U+SfLV/i1aR5f7yn9IgN
         FIsHVGVAu4GNVZPYe8NHHuF5WWJIOi1i46d0sgi7bmtnKmZnyAj4Dl/k9un0cKykDzP5
         p88spFU6t7OGRPyJd9xUM7RDp5JUC6wpWWFRK1eqbLhrGxnqNy5IFl6C9Fv0+Rjw7ZRW
         E+hQ==
X-Gm-Message-State: AC+VfDyyxL8ktk3AUibsmz7WfFnBB3oaGbNc8wB0GVDdKtjEhTRB5X93
        MEeTCwlejdd1t0syc1Ho/17+cg==
X-Google-Smtp-Source: ACHHUZ6xFwRV6290oiBu9zEMu/gtdsqpC8lxQZDtlQEeKNFmqY4beXf6hkZCcpWclRQaO8VLBAaeCA==
X-Received: by 2002:a1c:7405:0:b0:3f4:2148:e8e5 with SMTP id p5-20020a1c7405000000b003f42148e8e5mr6974812wmc.1.1684747274139;
        Mon, 22 May 2023 02:21:14 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id f10-20020a5d58ea000000b002fe96f0b3acsm7073614wrd.63.2023.05.22.02.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 02:21:13 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     thierry.reding@gmail.com, Artur Weber <aweber.kernel@gmail.com>
Cc:     Sam Ravnborg <sam@ravnborg.org>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Nikita Travkin <nikita@trvn.ru>
In-Reply-To: <20230519170354.29610-1-aweber.kernel@gmail.com>
References: <20230519170354.29610-1-aweber.kernel@gmail.com>
Subject: Re: [PATCH v5 0/3] Add Samsung S6D7AA0 panel controller driver
Message-Id: <168474727309.3803091.17592530014097097014.b4-ty@linaro.org>
Date:   Mon, 22 May 2023 11:21:13 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 19 May 2023 19:03:51 +0200, Artur Weber wrote:
> This patchset adds initial support for Samsung S6D7AA0-based panels.
> Currently, the following panels are supported:
> 
>  - S6D7AA0-LSL080AL02 (Samsung Galaxy Tab 3 8.0)
>  - S6D7AA0-LSL080AL03 (Samsung Galaxy Tab A 8.0 2015)
>  - S6D7AA0-LTL101AT01 (Samsung Galaxy Tab A 9.7 2015)
> 
> [...]

Thanks, Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-next)

[1/3] dt-bindings: display: panel: Add Samsung S6D7AA0 LCD panel controller
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=dda445651475b5a2a2941adcf1420fe3e9521bcd
[2/3] drm/panel: Add Samsung S6D7AA0 panel controller driver
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=6810bb390282bb75801832f31d088236503fee89
[3/3] MAINTAINERS: Add entry for Samsung S6D7AA0 LCD panel controller driver
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=0dd53308f74fcb16aa4e5cb90739b831c4a558de

-- 
Neil

