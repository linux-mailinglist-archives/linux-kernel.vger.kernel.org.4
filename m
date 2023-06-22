Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE6F073A186
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 15:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231528AbjFVNK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 09:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbjFVNK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 09:10:56 -0400
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com [IPv6:2607:f8b0:4864:20::a2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B0410F8
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 06:10:54 -0700 (PDT)
Received: by mail-vk1-xa2a.google.com with SMTP id 71dfb90a1353d-47169fc1a40so2157770e0c.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 06:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1687439453; x=1690031453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P2ExnUNvm4puj2j+jBwDuVgUcMJgNpTHsaeUbPYv1HA=;
        b=yGJPcTf5yJ0LAQHbCs0//5u7zTlviWAP4S4kkO82hHeGqqVnJDo/C15mxkMnjVBse6
         sfzsKQg/tJSVZGfVAk+tv2ZXymwjUI5lj9RIwv2zgWtET1Lze47M1HqsNjk9drvIftQ0
         pVzHirWFhN1bcVZtplp/G3rDRFkBvIk7Ohha7vbGdSWN68j99aBXZCkf8V4jrhPnbTP+
         nhOe8iYPriWxHdLafESB8L8s6g/NsqEs7txzboyYTOG09Qzhiu6TWoV4V1fLyW2wxBud
         pWUKDeA7HjpbY62da6LVs0OiSI+2C/hOb/HcR/1eqFf7XNA9+3dGBuxxi6RAqth1l4dS
         18Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687439453; x=1690031453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P2ExnUNvm4puj2j+jBwDuVgUcMJgNpTHsaeUbPYv1HA=;
        b=B8/wkdZcdNMxr3GbAQ7N5ob2dXZ6WhiL7Fkr2r96gpdNxmoLtwp3xJvO7TBGJMIJOg
         yonC+9ey4+4HGBPKxZ2zRu3P3u9A/IXfmKCzX2AAmc3x1iM1ZSu4j3Uc49F9swBfs7Zr
         +ZC2K5MBl3+Ez2fklcqS2bORGhrgGGlmrr+4ddFgcH3lqQRGx2QDfD4dzGZbnpiYgnjg
         iFJ1eAGoFhGjbYRSMrRbwy/snHVm64loqduYwyQN9wf/ziAfdMDBpfb8xBK7YU3q8mY6
         HxeHw0dMZ+v+vHRT9QlfENEyryv4GPtgM2zuuLo4/nAQ/3iBLHnp7rys4MKHPT4Q1KPh
         XRLA==
X-Gm-Message-State: AC+VfDxu1EbbwTBVCUXJs/ceXNpPKBbaEqz48f1XqDuBTm5/IT4rqJAB
        FS/6717p0xRoC9yuptCbFQ2qJFWG8UM7GYs7qSB9lg==
X-Google-Smtp-Source: ACHHUZ51ts75wkyfRCqdLOdLzUY3leYxdAIzn0un4E/YRo60Xqah11aqcikjs7PUlI+S5vg4oKw+3YC6Mm8RyX4xhqs=
X-Received: by 2002:a1f:e784:0:b0:471:6119:95cc with SMTP id
 e126-20020a1fe784000000b00471611995ccmr7694191vkh.14.1687439453218; Thu, 22
 Jun 2023 06:10:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230621182558.544417-11-brgl@bgdev.pl> <202306220657.ikVUl0zU-lkp@intel.com>
In-Reply-To: <202306220657.ikVUl0zU-lkp@intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 22 Jun 2023 15:10:42 +0200
Message-ID: <CAMRc=McU+eo3TSFmpR71mak08qJsA19hz8rZo5qk=rMbxoKOzQ@mail.gmail.com>
Subject: Re: [PATCH net-next 10/12] net: stmmac: replace the int_snapshot_en
 field with a flag
To:     kernel test robot <lkp@intel.com>
Cc:     Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, llvm@lists.linux.dev,
        oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2023 at 1:31=E2=80=AFAM kernel test robot <lkp@intel.com> w=
rote:
>
> Hi Bartosz,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on net-next/main]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Bartosz-Golaszewsk=
i/net-stmmac-replace-has_integrated_pcs-field-with-a-flag/20230622-022944
> base:   net-next/main
> patch link:    https://lore.kernel.org/r/20230621182558.544417-11-brgl%40=
bgdev.pl
> patch subject: [PATCH net-next 10/12] net: stmmac: replace the int_snapsh=
ot_en field with a flag
> config: i386-randconfig-i012-20230621 (https://download.01.org/0day-ci/ar=
chive/20230622/202306220657.ikVUl0zU-lkp@intel.com/config)
> compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project.git =
8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
> reproduce: (https://download.01.org/0day-ci/archive/20230622/202306220657=
.ikVUl0zU-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202306220657.ikVUl0zU-lkp=
@intel.com/
>
> All errors (new ones prefixed by >>):
>
> >> drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c:612:2: error: use of=
 undeclared identifier 'priv'
>            priv->plat->flags &=3D ~STMMAC_FLAG_INT_SNAPSHOT_EN;
>            ^
>    1 error generated.
>

Eek, must have disabled this driver in my config by accident. Now fixed for=
 v2.

Bart
