Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFAFD6FF635
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 17:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237526AbjEKPl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 11:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238773AbjEKPlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 11:41:53 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42ACC5255;
        Thu, 11 May 2023 08:41:52 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-969f90d71d4so567849066b.3;
        Thu, 11 May 2023 08:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683819711; x=1686411711;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dJn87lJ+zB7x7vYlqcoYdFAqcEQVzkzw8cISkbBs2PM=;
        b=MS/vKOlgjTFJ16STLx9hkywiw4c8JZR12KReEBjR04OeuXt56Qz/AWNR2lORa8Q9le
         qcfVllR1+I75JnPVB9xm/tHB9ajNViScW5q/fgOctvhzm2Cav3rE3i+z7FFT27Gpu33a
         Vt4h/FY+JgCMyAUFN6ElSYX0l2e6vxhmEQYOMCyDoBjaHoKoLDGJ3F2RhbvOkkwXLIxY
         39dztP+3BZqO5SIsP8Fr5WgWi837L8cLmXWRAk6acX+O/aWZ/6t5PzyCoMVy7FmAnjIB
         0EA05FrOTj0+JlM4IreOiWoGf4dAFLhtnQ7bxNkGlKTXX7SYpfi8lazD2/ZgeIVYatHX
         DYsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683819711; x=1686411711;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dJn87lJ+zB7x7vYlqcoYdFAqcEQVzkzw8cISkbBs2PM=;
        b=fHvCTFCn9Jgwocm2/qRWgeaSaHj2GWxepuiI5XDf20YjtY+owfxresTsTgw2MRL3ep
         VEcb5yCmOSp5znkwCfgWi3wY7VBtT5tVmrrk7GEvEip8Ui4A/Py/PfHAQ0DmxApeCY+O
         /WXJA9M8VdUBU0aF6Yj0CfhCOb7Q96JM28wYYH7qprON6HRqtBnhNEZEtMgdRNq7s3ir
         0T6Ex5XZAHjEiWX669wx3IJc262+lTa0cw7Em0p6gHaudBlHvBAwcut923VuOltoghKd
         ijvXOYPSxXIw8w/d04nimO46TLU+x2dxD+3JOPmSH7uXZsHgFSYOGxDjdvvxBrXb6Odo
         BHMw==
X-Gm-Message-State: AC+VfDz6NmehbNmY63SDh/9tlAKJSuZyUsbsxIXs8DgcVDOBg0sT6TF2
        rHmTQ9CT866OjEUYoZfV20M=
X-Google-Smtp-Source: ACHHUZ6JCiu+908nEHSeb+NqEkZ2J9uyEZ9iWqzL4O/f7zJB+PWkptxto5+kHizkAM11S+cRdWVCxQ==
X-Received: by 2002:a17:907:9347:b0:94f:694e:b953 with SMTP id bv7-20020a170907934700b0094f694eb953mr18294466ejc.59.1683819710654;
        Thu, 11 May 2023 08:41:50 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-1-233.dynamic.telemach.net. [82.149.1.233])
        by smtp.gmail.com with ESMTPSA id n12-20020a1709065dac00b009664cdb3fc5sm4142676ejv.138.2023.05.11.08.41.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 08:41:50 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan McDowell <noodles@earth.li>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
Subject: Re: [PATCH v2 3/5] ARM: dts: sun5i: chip: Enable bluetooth
Date:   Thu, 11 May 2023 17:41:49 +0200
Message-ID: <5832181.MhkbZ0Pkbq@jernej-laptop>
In-Reply-To: <49ff7f3cc79838a55a89baae09a4ba12c88573fb.1683719613.git.noodles@earth.li>
References: <cover.1681580558.git.noodles@earth.li>
 <cover.1683719613.git.noodles@earth.li>
 <49ff7f3cc79838a55a89baae09a4ba12c88573fb.1683719613.git.noodles@earth.li>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne sreda, 10. maj 2023 ob 14:01:43 CEST je Jonathan McDowell napisal(a):
> The C.H.I.P has an rtl8723bs device with the bluetooth interface hooked
> up on UART3. Support for this didn't exist in mainline when the DTS was
> initially added, but it does now, so enable it.
> 
> Signed-off-by: Jonathan McDowell <noodles@earth.li>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


