Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 025716B1603
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 00:00:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbjCHXAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 18:00:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbjCHXAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 18:00:11 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79564D291D;
        Wed,  8 Mar 2023 14:59:59 -0800 (PST)
Received: from pendragon.ideasonboard.com (117.145-247-81.adsl-dyn.isp.belgacom.be [81.247.145.117])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 52E7E10C;
        Wed,  8 Mar 2023 23:59:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1678316397;
        bh=vHyaUtCFeU2/4Ta/PI4vbeoNl6AwG3fH2hx/mVRgAcY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eR68+2dRUfUErtnqDz2pdrBlnsy7eEVZNgNAm1GBFAKFfOj+PASNdZk2DUzt28SWm
         G2b+ouNSUp/4idldoNR+MbEBEig1rQGxCQnuz6bWYH8iwAg2RVm73t+1vk15YAtT+z
         zCCThd9wn9VB/tFM8kBVjg71dYnk1vqPgJDWwyrU=
Date:   Thu, 9 Mar 2023 01:00:01 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Prabhakar <prabhakar.csengg@gmail.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Niklas =?utf-8?Q?S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 2/3] arm64: dts: renesas: rzg2l-smarc: Add OV5645 node
Message-ID: <20230308230001.GF31765@pendragon.ideasonboard.com>
References: <20230216175347.99778-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20230216175347.99778-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdXNrBCdLvMKK6kPbMLhSmuxXtd5A+Lt4J0ddVorODqCvw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdXNrBCdLvMKK6kPbMLhSmuxXtd5A+Lt4J0ddVorODqCvw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2023 at 08:27:19PM +0100, Geert Uytterhoeven wrote:
> Hi Prabhakar,
> 
> On Thu, Feb 16, 2023 at 6:57 PM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > OV5645 sensor can be connected to the CN1 connector on the
> > carrier board. This patch adds the ov5645 node under i2c0 node.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> Thanks for your patch!
> 
> > --- a/arch/arm64/boot/dts/renesas/r9a07g044l2-smarc.dts
> > +++ b/arch/arm64/boot/dts/renesas/r9a07g044l2-smarc.dts
> > @@ -6,6 +6,10 @@
> >   */
> >
> >  /dts-v1/;
> > +
> > +/* comment the #define statement if OV5645 is not connected to CN1  */
> > +#define CAM_INTERFACE_OV5645   1
> 
> I believe the camera is optional ("can be connector" above).
> So shouldn't this be commented out by default?

Even better, could you turn this into a DT overlay ?

> The rest LGTM, so with the above sorted out:
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

-- 
Regards,

Laurent Pinchart
