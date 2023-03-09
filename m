Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 358536B1A92
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 06:04:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbjCIFEt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 00:04:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjCIFEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 00:04:43 -0500
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F474D49FF
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 21:04:41 -0800 (PST)
Received: by mail-ua1-x92c.google.com with SMTP id f17so359380uax.7
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 21:04:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678338280;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nvkWCp3TULXIw9lqlVxOiEqPNkLIY/UrROP9j1sk4DQ=;
        b=lbAt2URQRLe8LSJFqdWbpmomRJNiXMA2424uR+W3DwF1OllEBMLepSWz3duHq5LKjz
         e3N2GlqN+Jy7R6PLD51J9fQF0wraQPE0TwvU1KO9hG4/sQN5Lp5o03WmBIPppEkT224T
         /kXv/iwsZ732FpJ6xRaE+1J8ASH0gwBJSLqaM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678338280;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nvkWCp3TULXIw9lqlVxOiEqPNkLIY/UrROP9j1sk4DQ=;
        b=VVQQO8B6fj7FctdMgSixai7oc+HKTM3z3GyEEUwg0ryjmPjucKW2X3rZheT/2K+BL3
         VtEYk/MVv7M4pxbN0LIGZszF8p0rMfDtvoYUZmMD19bjbQnTw5K/wl4dMw7mDW7Y+egk
         YgNcNCUMBIuBWqGQ5K8TT516KSpzeQYkhINSFtqYDnEN6ygZCcNj4oCU9Azr/acWavL3
         VC0WR4wwgX5pCVlXLSFbT5YH0HO73jKSsSxXi8sEkSgeoZnZFDQduX0/fdA93vT00NID
         vNQegacnr1PFwh5RycRjInuYG8+WknmuLrFS3QTttXT8dO6vtf7whmdDu2kJVykQccjO
         Mzjw==
X-Gm-Message-State: AO0yUKWP8JkwyUH8VlZh20xal8r6GIOOFcDAHwQMxdoAxEE4IZkl+yOM
        HWHlQKoEXjuO44gRSAUAHrwRxTb2jW3lyyu2DV7y1Q==
X-Google-Smtp-Source: AK7set/OuQNpfgATPmolGrn1KWxAEgo1eFsbDxOcmXs+3rXUpUz7lh8AvnQYkuxuMH2T2pWDyTvifVRol2PYQlc8zIY=
X-Received: by 2002:ab0:5402:0:b0:68a:a9d:13f5 with SMTP id
 n2-20020ab05402000000b0068a0a9d13f5mr13684728uaa.1.1678338280324; Wed, 08 Mar
 2023 21:04:40 -0800 (PST)
MIME-Version: 1.0
References: <20230307163413.143334-1-bchihi@baylibre.com>
In-Reply-To: <20230307163413.143334-1-bchihi@baylibre.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Thu, 9 Mar 2023 13:04:29 +0800
Message-ID: <CAGXv+5E0wUJYUVD3wx3-=uES612ARQmUE0rxgAruFHxpZCBjzA@mail.gmail.com>
Subject: Re: [PATCH 0/4] Add LVTS support for mt8192
To:     bchihi@baylibre.com
Cc:     daniel.lezcano@linaro.org, angelogioacchino.delregno@collabora.com,
        rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, rdunlap@infradead.org,
        ye.xingchen@zte.com.cn, p.zabel@pengutronix.de,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        khilman@baylibre.com, james.lo@mediatek.com,
        rex-bc.chen@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 8, 2023 at 12:34=E2=80=AFAM <bchihi@baylibre.com> wrote:
>
> From: Balsam CHIHI <bchihi@baylibre.com>
>
> Add full LVTS support (MCU thermal domain + AP thermal domain) to MediaTe=
k MT8192 SoC.
>
> This series is a continuation of the previous series "Add LVTS Thermal Ar=
chitecture" v14 :
>     https://patchwork.kernel.org/project/linux-pm/cover/20230209105628.50=
294-1-bchihi@baylibre.com/
> and "Add LVTS's AP thermal domain support for mt8195" :
>     https://patchwork.kernel.org/project/linux-pm/cover/20230307154524.11=
8541-1-bchihi@baylibre.com/
>
> Based on top of thermal/linux-next :
>     base-commit: 6828e402d06f7c574430b61c05db784cd847b19f
>
> Depends on these patches as they are not yet applyied to thermal/linux-ne=
xt branch :
>     [1/4] dt-bindings: thermal: mediatek: Add AP domain to LVTS thermal c=
ontrollers for mt8195
>     https://patchwork.kernel.org/project/linux-pm/patch/20230307154524.11=
8541-2-bchihi@baylibre.com/
>     [2/4] thermal/drivers/mediatek/lvts_thermal: Add AP domain for mt8195
>     https://patchwork.kernel.org/project/linux-pm/patch/20230307154524.11=
8541-3-bchihi@baylibre.com/
>
> Balsam CHIHI (4):
>   dt-bindings: thermal: mediatek: Add LVTS thermal controller definition
>     for mt8192
>   thermal/drivers/mediatek/lvts_thermal: Add mt8192 support
>   arm64: dts: mediatek: mt8192: Add thermal zones and thermal nodes
>   arm64: dts: mediatek: mt8192: Add temperature mitigation threshold

I tried this on my Hayato. As soon as lvts_ap probes and its thermal zones
are registered, a "critical temperature reached" warning is immediately
triggered for all the zones, a reboot is forced. A NULL pointer dereference
is also triggered somewhere. I filtered out all the interspersed "critical
temperature" messages:

[    2.943847] Unable to handle kernel NULL pointer dereference at
virtual address 0000000000000600
[    2.958818] Mem abort info:
[    2.965996]   ESR =3D 0x0000000096000005
[    2.973765] SMCCC: SOC_ID: ID =3D jep106:0426:8192 Revision =3D 0x000000=
00
[    2.975442]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
[    2.987305]   SET =3D 0, FnV =3D 0
[    2.995521]   EA =3D 0, S1PTW =3D 0
[    3.004265]   FSC =3D 0x05: level 1 translation fault
[    3.014365] Data abort info:
[    3.017344]   ISV =3D 0, ISS =3D 0x00000005
[    3.021279]   CM =3D 0, WnR =3D 0
[    3.022124] GACT probability NOT on
[    3.024277] [0000000000000600] user address but active_mm is swapper
[    3.034190] Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP
[    3.044738] Modules linked in:
[    3.044745] CPU: 0 PID: 97 Comm: irq/273-1100b00 Not tainted
6.3.0-rc1-next-20230308-01996-g3c0b9a61a3e5-dirty #575
c7b94096b594a95f18217c2ad4a2bd6d2c431108
[    3.044751] Hardware name: Google Hayato rev1 (DT)
[    3.044755] pstate: 60000009 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=
=3D--)
[    3.052055] pc : __mutex_lock+0x60/0x438
[    3.052066] lr : __mutex_lock+0x54/0x438
[    3.052070] sp : ffffffc008883c60
[    3.070822] x29: ffffffc008883c60 x28: ffffff80c281a880 x27: 000881f0000=
9001f
[    3.070830] x26: 1fc0000000247c00 x25: ffffff80c281a900 x24: 00000000000=
00000
[    3.070837] x23: 0000000000000000 x22: ffffffe5ae5d45f4 x21: 00000000000=
00002
[    3.086211] x20: 0000000000000000 x19: 00000000000005a0 x18: fffffffffff=
fffff
[    3.086218] x17: 6568636165722065 x16: 727574617265706d x15: 00000000000=
00028
[    3.097773] x14: 0000000000000000 x13: 0000000000003395 x12: ffffffe5af7=
f6ff0
[    3.097780] x11: 65706d655428206e x10: 0000000000000000 x9 : ffffffe5adc=
f4b08
[    3.097787] x8 : ffffffe5afe03230 x7 : 00000000000261b0 x6 : ffffff80c2b=
86600
[    3.105609] x5 : 0000000000000000 x4 : ffffff80c2b86600 x3 : 00000000000=
00000
[    3.112565] x2 : ffffff9b505f6000 x1 : 0000000000000000 x0 : 00000000000=
00000
[    3.127593] Call trace:
[    3.127595]  __mutex_lock+0x60/0x438
[    3.127600]  mutex_lock_nested+0x34/0x48
[    3.141844]  thermal_zone_device_update+0x34/0x80
[    3.152879]  lvts_irq_handler+0xbc/0x158
[    3.152886]  irq_thread_fn+0x34/0xb8
[    3.161489]  irq_thread+0x19c/0x298
[    3.161494]  kthread+0x11c/0x128
[    3.175152]  ret_from_fork+0x10/0x20
[    3.175163] Code: 97ccbb7c 9000bea0 b9411400 35000080 (f9403260)
[    3.189402] ---[ end trace 0000000000000000 ]---
[    3.193417] Kernel panic - not syncing: Oops: Fatal exception
[    3.201255] Kernel Offset: 0x25a5c00000 from 0xffffffc008000000
[    3.201257] PHYS_OFFSET: 0x40000000
[    3.201259] CPU features: 0x600000,01700506,3200720b
[    3.201263] Memory Limit: none
[    3.376838] Rebooting in 30 seconds..


>  arch/arm64/boot/dts/mediatek/mt8192.dtsi      | 454 ++++++++++++++++++
>  drivers/thermal/mediatek/lvts_thermal.c       | 106 +++-
>  .../thermal/mediatek,lvts-thermal.h           |  19 +
>  3 files changed, 577 insertions(+), 2 deletions(-)
>
>
> base-commit: 6828e402d06f7c574430b61c05db784cd847b19f
> prerequisite-patch-id: 73be949bd16979769e5b94905b244dcee4a8f687
> prerequisite-patch-id: 9076e9b3bd3cc411b7b80344211364db5f0cca17
> prerequisite-patch-id: e220d6ae26786f524c249588433f02e5f5f906ad
> prerequisite-patch-id: 58e295ae36ad4784f3eb3830412f35dad31bb8b6
> prerequisite-patch-id: d23d83a946e5b876ef01a717fd51b07df1fa08dd
> prerequisite-patch-id: d67f2455eef1c4a9ecc460dbf3c2e3ad47d213ec
> prerequisite-patch-id: b407d2998e57678952128b3a4bac92a379132b09
> prerequisite-patch-id: fbb9212ce8c3530da17d213f56fa334ce4fa1b2b
> prerequisite-patch-id: 5db9eed2659028cf4419f2de3d093af7df6c2dad
> prerequisite-patch-id: a83c00c628605d1c8fbe1d97074f9f28efb1bcfc
> --
> 2.34.1
>
>
