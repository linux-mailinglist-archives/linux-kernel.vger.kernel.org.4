Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA836038C4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 05:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbiJSD42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 23:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiJSD4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 23:56:25 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98EF2E4C05
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 20:56:24 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id d26so36989528ejc.8
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 20:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IXizNkH/R+e1pcdGI2c2lbV1I/baxKR1Zsps8qTE1LY=;
        b=gXpUibeLCHIQqA7BBqDECEJr8yqLLBsXJElo/a+slr6k/AMsbCRKQMhm7FfIH5j38w
         48apUQLuteTAq5izn6kTO71ajX8BhYTGN3VpkcmsAzJmZ1uErbISfqnzE58JV1ZAf+WC
         dYg+9FG90XSdNeqMFzVd7KWKhqdpxkV0mMFB7YxjSUTquUbTsanyv+LVShas5ynG6kQB
         /zxMMZEsZsSgJ4mvgMED8J5oGM9OlV/VC7f32uBY/l8s4hzcUH46x/wWYhyz4WLvyxzs
         0SIARvrOAYitMxbi0/Vy20cbQ5+AWDTlukvjj8ziCYC+PAboF13HOq6kiDEoKHNrOjVb
         Yayg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IXizNkH/R+e1pcdGI2c2lbV1I/baxKR1Zsps8qTE1LY=;
        b=BzFS9VYdayFBLmTu2g2xR0ZKGMDPtOAmlNvAPafcb7JmNUAhDHLN94WnlKFRL0D/fp
         TovEPFm+Cmt8PIFXaXxrrcJxjPhlHsnfN8cudBOHjvMyLscJNYDRCpKfqxcV0hokmtNF
         PJI2gRAii1ZdbTgMRkRlwA3MpaUqXhtZYa+DCNOcv48VRmZkvQPyFaB2+2bq16gNb0F5
         8R21HLic5oOBkBpHYZuya2725jCVfkWkJxC+wQhH8EkGCytNgdUqfQ3FvtNy9PuXRP8Q
         an+eoSs3uexoO3ymGBLFJu2nPl312hIVONXrQti+0wzSGypoWyjn3hzS4ngeJHYbCBMS
         Gv0A==
X-Gm-Message-State: ACrzQf1FL3wU2oodEYfovsXPZFbfiuJRIktIPia7OSxuLyk89x181ZB+
        A4kYw3cnhEembDQLaeMCGlc=
X-Google-Smtp-Source: AMsMyM5OM4R2vvUMIxygwEZlzJovtBMpE3TkEgi5My/X78KaifFnKstqebCkO6xhWoH4vnkCmxEudw==
X-Received: by 2002:a17:906:d54d:b0:78e:f130:7099 with SMTP id cr13-20020a170906d54d00b0078ef1307099mr5143652ejc.142.1666151783174;
        Tue, 18 Oct 2022 20:56:23 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id ti5-20020a170907c20500b00782e9943c99sm8041009ejc.219.2022.10.18.20.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 20:56:22 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     fengzheng923@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, wens@csie.org, samuel@sholland.org,
        Ban Tao <fengzheng923@gmail.com>
Cc:     alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: sun50i-dmic: avoid unused variable warning for sun50i_dmic_of_match
Date:   Wed, 19 Oct 2022 05:56:21 +0200
Message-ID: <4775101.31r3eYUQgx@jernej-laptop>
In-Reply-To: <1665895524-122458-1-git-send-email-fengzheng923@gmail.com>
References: <1665895524-122458-1-git-send-email-fengzheng923@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne nedelja, 16. oktober 2022 ob 06:45:24 CEST je Ban Tao napisal(a):
> In configurations with CONFIG_OF=n, we get a harmless build warning:
> 
> sound/soc/sunxi/sun50i-dmic.c:268:34: warning: unused variable
> 'sun50i_dmic_of_match' [-Wunused-const-variable]
> 
> Signed-off-by: Ban Tao <fengzheng923@gmail.com>
> Reported-by: kernel test robot <lkp@intel.com>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


