Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E882619BBB
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 16:33:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232681AbiKDPd0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 11:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232637AbiKDPdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 11:33:17 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F3513123E
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 08:33:07 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id k7so5212286pll.6
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 08:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fwuTjqh5pt+T/yYu3FHsWOz2YtfUvi8Iieag/ZSiRiI=;
        b=mUGHyoC6q0AXBVQqWwsb32J2056BLwrKl4y7GwDajJHCUtjvfbwRFnqKRnFA1xr7RB
         v63EqXCwpiveM3wF3wyelzhFz/2rC9ZGb1cVRjjI0udOf9pVtxWu2V6t/AxwEStkLlFM
         Hdf2j8e3uQWAdke63x6t9s7Fw3ODFkC1jGHzMcpo4SHdNYpeUy0h23e5YCROwxsfszMA
         VNP3XVVDtvY3oTmKVjF81d61hn5manpCmKspE6DfmFzubsUmkW3+O9Tnhje6cIQjHyW1
         ckq5QODV+iGkwaI2kLOq+o53YPPVAoMNSaMMQ2ONUV+ckA/F7+HNYLS0TEHWkacuJUgb
         7dAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fwuTjqh5pt+T/yYu3FHsWOz2YtfUvi8Iieag/ZSiRiI=;
        b=wm6AHhawTqLTUj89iwqEdqej5JNZ/z5R8IBUG/3c4oMd4lmsSfsUntLHKrGzdWqc8x
         c2g7OY6mVDZ3B+QO287wxET+Kr9vGF+BzSQhNYNIAqxiJY9m0tN1bWv6HsvW64NPhNM0
         Yp/VXtzDNwNsOJ8cn/DIkSNcP9Jqern2CzlP8t8ebCjZlVigrA8bvLTj8UEyZlLHra7d
         zS0qaJrcoc1uO9rbqfoM8xceUzE1UUg8OKKGVbfCcJv0IGpNo4ljwFpMpDnWD7CIjVAp
         1Lc/7Fz/wCWT9sfuBHfRXpeOaTJElwmVo6340Yzlk0fdFvtxcRcaJ2lsQn2+1Y4bGGDC
         5kRw==
X-Gm-Message-State: ACrzQf1cFcMMaAXOscG3xg6fm8Vv8BA4VdXnOsRUBQha1IkgHiqz3nVT
        8bk/BxI4kQFhq5VC/TfHNRSydA==
X-Google-Smtp-Source: AMsMyM7JAkk+7adsv1QrArHLc7M40uX5VtZ5DcNDHDmI2vsZJDwFKlnpmjGImj3BDo+hl+pG+d3Dgw==
X-Received: by 2002:a17:902:e54b:b0:188:4c74:300e with SMTP id n11-20020a170902e54b00b001884c74300emr12478917plf.45.1667575986981;
        Fri, 04 Nov 2022 08:33:06 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id n6-20020a170902e54600b00186b280a441sm2784224plf.239.2022.11.04.08.33.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 08:33:06 -0700 (PDT)
Date:   Fri, 4 Nov 2022 09:33:03 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "andersson@kernel.org" <andersson@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH V2 0/2] remoteproc: imx: add start up delay
Message-ID: <20221104153303.GB1873068@p14s>
References: <20221102112451.128110-1-peng.fan@oss.nxp.com>
 <CANLsYky1j_BMD-Dg1Lath4bftE-0qPEod7fxcaN3UkKUpjP7dw@mail.gmail.com>
 <DU0PR04MB94170F02CF6BD02D7869A75388389@DU0PR04MB9417.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DU0PR04MB94170F02CF6BD02D7869A75388389@DU0PR04MB9417.eurprd04.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2022 at 05:08:15AM +0000, Peng Fan wrote:
> > Subject: Re: [PATCH V2 0/2] remoteproc: imx: add start up delay
> > 
> > On Wed, 2 Nov 2022 at 05:23, Peng Fan (OSS) <peng.fan@oss.nxp.com>
> > wrote:
> > >
> > > From: Peng Fan <peng.fan@nxp.com>
> > >
> > > V2:
> > >  Rebased on linux-next
> > >
> > > V1:
> > >
> > >
> > https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore
> > > .kernel.org%2Flkml%2F20220609123500.3492475-1-
> > peng.fan%40oss.nxp.com%2
> > >
> > F&amp;data=05%7C01%7Cpeng.fan%40nxp.com%7Cf14584bdef9349e744ca
> > 08dabcf7
> > >
> > e1be%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63803007007
> > 2451509%7
> > >
> > CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJ
> > BTiI6Ik1
> > >
> > haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=Ck73gkOPpNVT
> > kcZL8olCZP8B
> > > %2BrIpZHV48uZBl2R8HdM%3D&amp;reserved=0
> > >
> > > There is case that after remoteproc start remote processor[M4], the M4
> > > runs slow and before M4 finish its own rpmsg framework initialization,
> > > linux sends out vring kick message, then M4 firmware drops the kick
> > > message. Some NXP released Cortex-M[x] images has such limitation that
> > > it requires linux sends out vring kick message after M4 firmware
> > > finish its rpmsg framework initialization.
> > >
> > > The best case is to use a method to let M4 notify Linux that M4 has
> > > finished initialization, but we could not patch released firmware,
> > > then update driver to detect notification.
> > >
> > > So add delay before linux send out vring kick message. It is not good
> > > to use a fixed time delay in driver, so I choose to get that from
> > > device tree.
> > >
> > 
> > From where I stand this is a hack to hide the lack of motivation to enact the
> > real solution that is outlined above.  I also wonder how these problems
> > were not caught during the testing phase.  Either find a way to upgrade your
> > firmware or keep this in your internal tree.
> In the beginning, i.mx not migrated to use remoteproc, i.MX release only support
> uboot kick Cortex-M core and use downstream imx_rpmsg driver to
> communicate with remote core. There is no runtime stop/start.
> 
> After migrated to remoteproc, we do see some issue, but old firmware was
> there.

You could also attach() to that remote processor, if the HW supports it.  But my
position remains the same - either find a way to work with this situation that
is not a hack or keep this patch in your internal tree.

> 
> Thanks,
> Peng.
> 
> > 
> > > Peng Fan (2):
> > >   dt-bindings: remoteproc: imx_rproc: add fsl,startup-delay-ms
> > >   remoteproc: imx_rproc: delay after kick remote processor
> > >
> > >  .../devicetree/bindings/remoteproc/fsl,imx-rproc.yaml    | 4 ++++
> > >  drivers/remoteproc/imx_rproc.c                           | 9 +++++++++
> > >  2 files changed, 13 insertions(+)
> > >
> > > --
> > > 2.37.1
> > >
