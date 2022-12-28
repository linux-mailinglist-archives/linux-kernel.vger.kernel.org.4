Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B402A65765C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 13:23:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232637AbiL1MWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 07:22:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbiL1MWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 07:22:40 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9291218B
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 04:22:39 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id 7so10493030pga.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 04:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LFvhTcaRZjgL74aw0ImWpDb76fTfKVSz3niY5jO7t2U=;
        b=6XK8iaEvevvXqDOBb77pn2jRDoRsZbUa51M+NyT8XpjYcuaxY7TVVgDTdJX44JzIT1
         6vItea01ki1fvLX8FOid6Mfm9aEGnD+ivk7GAVyKN2EyZYFut5kuce2/vz/6lLVPJ7Ji
         e4xFy50sBPkC4c6aKDAgIkSv/9g69rOW5gS+8WsG1MZuW2riLAdU+2YDVbWqtWo4WB9p
         tEw3/eL6f8YWvVdn8uAJdzrITvinPwmvvPLcGpjHCY6bO8rA0ZSgLdSIbQQLkrXpPxNT
         bNWYeh3H5gY47F0u6MG4axq5XEIRinEAlW4ZjsoNZR8nQ5z4iB+aO22ksTFhdgC8Gr3a
         p3oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LFvhTcaRZjgL74aw0ImWpDb76fTfKVSz3niY5jO7t2U=;
        b=GpRJv0EQrWVwrdB6ProeB8tf0omxd3ap/w2zcRcDNbr7hnCtJmAC9msEvIl5w5jJuZ
         aBwzhFciuK/i165o8iex7XV6qe+eb7AvWcKZDwJtiYhVZkxrvwz6uyvq7581yw6Kd94h
         g69oh4S45WemvOv2ZpHyp/OgMVwHYo9eBjpE1IztA9A8n+7M0zli93vZvUhnOZdG+D2U
         bucHBcQtKd+hPxNB8JIzBIeGQ7G2ELIn6OQtvf9qKbt6t056j8gjaZHOcQEdH92aw20r
         5pteltP+FDjPkY5b2WxSGUHMCxSIGgF4mMETymsaYjLqWldI3WXyzS5RRnCM9Km9dNdh
         DoFA==
X-Gm-Message-State: AFqh2kqb66+qaCTzw4Y7hJWN9c7a+D1v+/qnJh1S/+8AzQthLxswJ0m8
        7DVHG0lUcZq+TT4tAgBIGMdXDw==
X-Google-Smtp-Source: AMrXdXuPM0D6h33ggS86tdoKbX4wsqChC1KyEbKeUzk2LWBE9WFxvgTxRvaU/KF9H7dMQzvrnz2Ctg==
X-Received: by 2002:a62:6102:0:b0:578:3bc0:57d7 with SMTP id v2-20020a626102000000b005783bc057d7mr24847846pfb.13.1672230159291;
        Wed, 28 Dec 2022 04:22:39 -0800 (PST)
Received: from localhost.localdomain (202.60.225.077.static.cyberec.com. [202.60.225.77])
        by smtp.gmail.com with ESMTPSA id h1-20020a056a00000100b0058124f92399sm5236074pfk.219.2022.12.28.04.22.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 04:22:39 -0800 (PST)
From:   tongjian <tongjian@huaqin.corp-partner.google.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        perex@perex.cz, tiwai@suse.com,
        angelogioacchino.delregno@collabora.com, nfraprado@collabora.com,
        jiaxin.yu@mediatek.com, chunxu.li@mediatek.com,
        ajye_huang@compal.corp-partner.google.com,
        tongjian@huaqin.corp-partner.google.com
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Add new AMP MAX98360A for RT5682S
Date:   Wed, 28 Dec 2022 20:22:28 +0800
Message-Id: <20221228122230.3818533-1-tongjian@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MAX98360A for RT5682S, MAX98360A works same as rt1019. So, it can
be supported.

tongjian (2):
  ASoC: mediatek: mt8186: support rt5682s_max98360
  ASoC: dt-bindings: mt8186-mt6366: add new compatible for max98360a

 .../sound/mt8186-mt6366-rt1019-rt5682s.yaml   |  1 +
 .../mt8186/mt8186-mt6366-rt1019-rt5682s.c     | 22 ++++++++++++++++++-
 2 files changed, 22 insertions(+), 1 deletion(-)

-- 
2.25.1

