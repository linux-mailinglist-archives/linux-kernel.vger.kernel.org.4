Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAF4C6435E4
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 21:42:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233069AbiLEUmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 15:42:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbiLEUmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 15:42:40 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4087C2BD9;
        Mon,  5 Dec 2022 12:42:39 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id t17so1424773eju.1;
        Mon, 05 Dec 2022 12:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YQzZj9QPO3FSSI2ENjgSMav7mWgYHgG+8g+KxcQQR6s=;
        b=Kgi5D4VGK5CLzDIpcF8arVuXaZx6m2bSHtg2ufyOSUffvRFom3atILD/HLSjye2ChW
         RRtjjir4IPzIKl09teqO9eDKbyp7c1ulRkg4ec8C4bouebg5szGnBHP5uX1rNvl5sc3o
         P9jLXXXs61s9pOKnK9LmYul4OsWakZ9HakZhXyu3Igv724ragHtcaSksnrTF52c3ScMT
         hpoMoFsi8fweKgP8/sVsygYQaniwJ+m/3pymG8qdpE4gSm5SmSJ8/XW/PtfxXtopM6L0
         mc+mSRaNycRTKsYXbCFBh373jAh7IjBB/Uwphv0ZCtI0vDmsN+oJxHyyp8sIkd6FEjOZ
         YxHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YQzZj9QPO3FSSI2ENjgSMav7mWgYHgG+8g+KxcQQR6s=;
        b=ESV0DhjQR/8mjEueZwC4U+dhzYvnTGNZUMInAwWXRMBV+hQxiaAH+PDFmfDiSKCqIL
         LM+qB5HZomeIsC0DrKezm+08Sg3aFEXFgI6DInF3u7T6bAigiadTBLiVlcGWKQ1JfVKs
         Iqyj21MtHvl/vXkdB1CTK6fvtoQUL8qfuM/z3FPzhLFFqfFuuEBhWQ1nrrFa2phEBCgw
         AGqQhqNnm3aHFm0YYRfWmnx0dnK82qxJumHUX+uNu4Kcwihgi1tgcIEoagiJRKqfAp07
         cqtj/m/gA4JZ4GKY5Dm7FrSvVlB8sThmtiPJRsteLjLSsoOFxJrKN1IdG1HgixHIr9B9
         bGNA==
X-Gm-Message-State: ANoB5pnTVOWewYlCJbcb5WNWymcOybv+Eaea7fYC5mvjze/zJbcGZKrY
        mNUXR9BG+1fb7VPjR9zOFxE=
X-Google-Smtp-Source: AA0mqf7R9dwO4bUeGZdSzi/mvPeNrR1HVKTQ1Ep2WHqQyvWYkZdx02/I6EE5f/uTULiBGF4Tb1rcXw==
X-Received: by 2002:a17:906:43d0:b0:78d:a01b:b474 with SMTP id j16-20020a17090643d000b0078da01bb474mr57943718ejn.8.1670272957878;
        Mon, 05 Dec 2022 12:42:37 -0800 (PST)
Received: from kista.localnet (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id 5-20020a170906310500b0073d81b0882asm6539342ejx.7.2022.12.05.12.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 12:42:37 -0800 (PST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Chen-Yu Tsai <wens@csie.org>, linux-sunxi@lists.linux.dev,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <conor@kernel.org>,
        linux-riscv@lists.infradead.org,
        Samuel Holland <samuel@sholland.org>
Cc:     devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Jisheng Zhang <jszhang@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andre Przywara <andre.przywara@arm.com>,
        Samuel Holland <samuel@sholland.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <apatel@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>,
        Christian Hewitt <christianshewitt@gmail.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Guo Ren <guoren@kernel.org>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Stanislav Jakubek <stano.jakubek@gmail.com>
Subject: Re: [PATCH v2 08/12] riscv: dts: allwinner: Add MangoPi MQ Pro devicetree
Date:   Mon, 05 Dec 2022 21:42:36 +0100
Message-ID: <3135032.5fSG56mABF@kista>
In-Reply-To: <20221125234656.47306-9-samuel@sholland.org>
References: <20221125234656.47306-1-samuel@sholland.org> <20221125234656.47306-9-samuel@sholland.org>
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

Dne sobota, 26. november 2022 ob 00:46:52 CET je Samuel Holland napisal(a):
> The MangoPi MQ Pro is a tiny SBC with a layout compatible to the
> Raspberry Pi Zero. It includes the Allwinner D1 SoC, 512M or 1G of DDR3,
> and an RTL8723DS-based WiFi/Bluetooth module.
> 
> The board also exposes GPIO Port E via a connector on the end of the
> board, which can support either a camera or an RMII Ethernet PHY. The
> additional regulators supply that connector.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


