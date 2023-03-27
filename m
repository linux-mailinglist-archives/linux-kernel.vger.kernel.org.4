Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0A986CA8B2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 17:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232642AbjC0PM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 11:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjC0PM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 11:12:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7F9A2D71
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 08:12:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 344E3B81601
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 15:12:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDB9BC433EF;
        Mon, 27 Mar 2023 15:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679929943;
        bh=j9PLzn1taq+ed5KwV9+KtXcTo4kwdryon7XM4NMATIM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LqYZHTGkHPwNoqIaOlBa/ktJhPtXjVZO/dW9L6Sxt5vDwXSkuSpWAjpPW3m0YPzvP
         jrFk++EaJ+ExJ4A1hmaA90ZOATVUBWZrREdrjMNFKscakqDjOtC6c0hit5zX2dOku4
         yqZF8/dueJqwHIebIsdna2DZ4t+akvxDJRCOV2rh49LhCg9UmsqRaLSyiH/M55o5Oq
         WR5+bTffX9syAAMlrqKognv2cmerhbcIB34cZ+9qmqgmVHuyKCzJtX+Xf4SypGX+QC
         /eoCXgo6QGSVGgBBR7uJqfpQ8DpU0qDf8Bnrj4/C6Z/34ukdu+4Bgt0ltqmQSmZ/JR
         YzAHRhVmT4yFA==
Date:   Mon, 27 Mar 2023 16:12:17 +0100
From:   Will Deacon <will@kernel.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Marc Gonzalez <mgonzalez@freebox.fr>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Jiucheng Xu <jiucheng.xu@amlogic.com>,
        Pierre-Hugues Husson <phh@phh.me>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 3/3] perf/amlogic: adjust register offsets
Message-ID: <20230327151216.GA32275@willie-the-truck>
References: <20230327120932.2158389-1-mgonzalez@freebox.fr>
 <20230327120932.2158389-4-mgonzalez@freebox.fr>
 <f0432ff5-7e73-1e7e-1745-6f3b679153fe@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0432ff5-7e73-1e7e-1745-6f3b679153fe@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 04:17:29PM +0200, Neil Armstrong wrote:
> On 27/03/2023 14:09, Marc Gonzalez wrote:
> > Commit "perf/amlogic: resolve conflict between canvas & pmu"
> > changed the base address.
> > 
> > Fixes: 2016e2113d35 ("perf/amlogic: Add support for Amlogic meson G12 SoC DDR PMU driver")
> > Signed-off-by: Marc Gonzalez <mgonzalez@freebox.fr>
> > ---
> >   drivers/perf/amlogic/meson_g12_ddr_pmu.c | 34 +++++++++++++++++-----------------
> >   1 file changed, 17 insertions(+), 17 deletions(-)
> > 
> > diff --git a/drivers/perf/amlogic/meson_g12_ddr_pmu.c b/drivers/perf/amlogic/meson_g12_ddr_pmu.c
> > index a78fdb15e26c2..8b643888d5036 100644
> > --- a/drivers/perf/amlogic/meson_g12_ddr_pmu.c
> > +++ b/drivers/perf/amlogic/meson_g12_ddr_pmu.c
> > @@ -21,23 +21,23 @@
> >   #define DMC_QOS_IRQ		BIT(30)
> >   /* DMC bandwidth monitor register address offset */
> > -#define DMC_MON_G12_CTRL0		(0x20  << 2)
> > -#define DMC_MON_G12_CTRL1		(0x21  << 2)
> > -#define DMC_MON_G12_CTRL2		(0x22  << 2)
> > -#define DMC_MON_G12_CTRL3		(0x23  << 2)
> > -#define DMC_MON_G12_CTRL4		(0x24  << 2)
> > -#define DMC_MON_G12_CTRL5		(0x25  << 2)
> > -#define DMC_MON_G12_CTRL6		(0x26  << 2)
> > -#define DMC_MON_G12_CTRL7		(0x27  << 2)
> > -#define DMC_MON_G12_CTRL8		(0x28  << 2)
> > -
> > -#define DMC_MON_G12_ALL_REQ_CNT		(0x29  << 2)
> > -#define DMC_MON_G12_ALL_GRANT_CNT	(0x2a  << 2)
> > -#define DMC_MON_G12_ONE_GRANT_CNT	(0x2b  << 2)
> > -#define DMC_MON_G12_SEC_GRANT_CNT	(0x2c  << 2)
> > -#define DMC_MON_G12_THD_GRANT_CNT	(0x2d  << 2)
> > -#define DMC_MON_G12_FOR_GRANT_CNT	(0x2e  << 2)
> > -#define DMC_MON_G12_TIMER		(0x2f  << 2)
> > +#define DMC_MON_G12_CTRL0		(0x0  << 2)
> > +#define DMC_MON_G12_CTRL1		(0x1  << 2)
> > +#define DMC_MON_G12_CTRL2		(0x2  << 2)
> > +#define DMC_MON_G12_CTRL3		(0x3  << 2)
> > +#define DMC_MON_G12_CTRL4		(0x4  << 2)
> > +#define DMC_MON_G12_CTRL5		(0x5  << 2)
> > +#define DMC_MON_G12_CTRL6		(0x6  << 2)
> > +#define DMC_MON_G12_CTRL7		(0x7  << 2)
> > +#define DMC_MON_G12_CTRL8		(0x8  << 2)
> > +
> > +#define DMC_MON_G12_ALL_REQ_CNT		(0x9  << 2)
> > +#define DMC_MON_G12_ALL_GRANT_CNT	(0xa  << 2)
> > +#define DMC_MON_G12_ONE_GRANT_CNT	(0xb  << 2)
> > +#define DMC_MON_G12_SEC_GRANT_CNT	(0xc  << 2)
> > +#define DMC_MON_G12_THD_GRANT_CNT	(0xd  << 2)
> > +#define DMC_MON_G12_FOR_GRANT_CNT	(0xe  << 2)
> > +#define DMC_MON_G12_TIMER		(0xf  << 2)
> >   /* Each bit represent a axi line */
> >   PMU_FORMAT_ATTR(event, "config:0-7");
> 
> 
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> 
> Will, I've applied DT patches 1 & 2, can you apply this one via your fixes tree for v6.3 ?

If you're sending the DT patches as fixes, you may as well just take this
driver change at the same time with my ack:

Acked-by: Will Deacon <will@kernel.org>

Does that work for you?

Will
