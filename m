Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B28E05BC030
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 23:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbiIRVtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 17:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiIRVtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 17:49:12 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7126015A33;
        Sun, 18 Sep 2022 14:49:11 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id z2so2741437edi.1;
        Sun, 18 Sep 2022 14:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=P6S6LshpwgqP4u2Qp5J9LrUP6dyOR3py1H73QdQkr+8=;
        b=byODDZqjDOXISKuvoOVjruzPjk2kL7kmzaGbWtyraZbtsGSG7biN3VHswXta14pOLZ
         Udyqh8biLK88qhky8WnIH0GKSkXBtEJS6Lj9DNaFBU11bGAaetdVLDgkoi8A5vhNGpNv
         84RoaHCHMUuk7brlOVWGIs3z21L0hR0BAONOIlLvsAgcbZY0qXtr+NWYTnR8sIqAI1iP
         IkvX1jMSVO/Ck8l/DJ/jNUARqYQCqt5lva8EY0lXL0HWKx5qSdXN+tmtiO4xmyfGnchH
         D+0CgEllmaMhDoaV2d4T6rMkzHDRkyofV1jOirpAKEndR4+LHWi7Bml7IxogTR9CZy5R
         3Dew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=P6S6LshpwgqP4u2Qp5J9LrUP6dyOR3py1H73QdQkr+8=;
        b=uJTBuNdcTT89lg7x/ZZFQ0uLTUrTS/VgtLapUCdLndxxbWXs6o7I+x3FbBNLRmUORJ
         yBG/igCmFg9wFqE9foi0/kr+sarI3aCozuUtP8lTCWxKVmeHBrYO74gT6dgUrm6E9m/6
         UwmJLT3lCGzlm/xGiRK+Gr8lsb/ztpE2cp85YGUxvpHjuNo+1qWLhpf3m3vbgM3K+DX5
         dRAtCRQeVccRKyU+riP7OHM69/W5IAFXFBHvng8n3xdHz4bhEzDcEStHJnidfueLCu6/
         /j7Is3dOKJTndl7tseFe5fOClhJZSIvDu8lR5ueM0KAym5hw4ydp+iecZJT9ZWS9NdtO
         3kew==
X-Gm-Message-State: ACrzQf0Y/H2SjUZzwBMEOb2mcUScb8bGoeviW24y4op2h1KngA/U5ODY
        XhykCxf7LhSQ9vaVNwOvgQ4=
X-Google-Smtp-Source: AMsMyM5YXccGcZWDHWBdl4JZk8RyuLxu8RKUcRZ3cq8XLcuqqH+3wkG1CfuhJK93RAZs67GYfD6Kqw==
X-Received: by 2002:aa7:da4f:0:b0:44e:864b:7a3e with SMTP id w15-20020aa7da4f000000b0044e864b7a3emr13311882eds.378.1663537749929;
        Sun, 18 Sep 2022 14:49:09 -0700 (PDT)
Received: from kista.localnet (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id b13-20020aa7c90d000000b0044eda621b08sm19047074edt.54.2022.09.18.14.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Sep 2022 14:49:09 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>
Cc:     Samuel Holland <samuel@sholland.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v2 00/10] soc: sunxi: sram: Fixes and D1 support
Date:   Sun, 18 Sep 2022 23:49:08 +0200
Message-ID: <2646007.mvXUDI8C0e@kista>
In-Reply-To: <20220815041248.53268-1-samuel@sholland.org>
References: <20220815041248.53268-1-samuel@sholland.org>
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

Dne ponedeljek, 15. avgust 2022 ob 06:12:37 CEST je Samuel Holland napisal(a):
> This series cleans up a few issues in the system controller driver, and
> then expands the exported regmap to support one of the pairs of LDOs
> built in to the D1 SoC.
> 
> Eventually, we will need to update the SRAM region claiming API so
> ownership can be swapped back and forth by consumer drivers. This will
> be necessary for uploading firmware to the R329/D1 DSPs, but it is not
> needed for initial bringup.
> 
> Changes in v2:
>  - New patch to first clean up the binding
> 
> Samuel Holland (10):
>   dt-bindings: sram: sunxi-sram: Clean up the compatible lists
>   dt-bindings: sram: sunxi-sram: Add D1 compatible string
>   soc: sunxi: sram: Actually claim SRAM regions
>   soc: sunxi: sram: Prevent the driver from being unbound
>   soc: sunxi: sram: Fix probe function ordering issues
>   soc: sunxi: sram: Fix debugfs info for A64 SRAM C
>   soc: sunxi: sram: Return void from the release function
>   soc: sunxi: sram: Save a pointer to the OF match data
>   soc: sunxi: sram: Export the LDO control register
>   soc: sunxi: sram: Add support for the D1 system control

Applied all, thanks!

Best regards,
Jernej

> 
>  .../allwinner,sun4i-a10-system-control.yaml   | 82 ++++++++-----------
>  drivers/soc/sunxi/sunxi_sram.c                | 74 +++++++++--------
>  include/linux/soc/sunxi/sunxi_sram.h          |  2 +-
>  3 files changed, 73 insertions(+), 85 deletions(-)
> 
> --
> 2.35.1


