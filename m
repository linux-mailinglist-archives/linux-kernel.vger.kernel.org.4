Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C57277388DE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 17:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233309AbjFUPYX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 21 Jun 2023 11:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233297AbjFUPYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 11:24:01 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E619D1706
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 08:23:29 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1qBzg3-0008SF-2I; Wed, 21 Jun 2023 17:23:23 +0200
Message-ID: <87c9576e6ca1b58fa94e0bc1a2f4be3847f0518c.camel@pengutronix.de>
Subject: Re: [PATCH v10 07/11] drm/etnaviv: Add support for the dma coherent
 device
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Sui Jingfeng <suijingfeng@loongson.cn>,
        Sui Jingfeng <18949883232@163.com>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        etnaviv@lists.freedesktop.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>
Date:   Wed, 21 Jun 2023 17:23:21 +0200
In-Reply-To: <aa73348d-5ec8-4ac0-2ec0-0cce24756c63@loongson.cn>
References: <20230620094716.2231414-1-18949883232@163.com>
         <20230620094716.2231414-8-18949883232@163.com>
         <8f74f0962c8bab6c832919a5340667c54e1a7ddc.camel@pengutronix.de>
         <aa73348d-5ec8-4ac0-2ec0-0cce24756c63@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, dem 21.06.2023 um 22:44 +0800 schrieb Sui Jingfeng:
> Hi,
> 
> On 2023/6/21 18:00, Lucas Stach wrote:
> > > diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.h b/drivers/gpu/drm/etnaviv/etnaviv_drv.h
> > > index 9cd72948cfad..644e5712c050 100644
> > > --- a/drivers/gpu/drm/etnaviv/etnaviv_drv.h
> > > +++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.h
> > > @@ -46,6 +46,12 @@ struct etnaviv_drm_private {
> > >   	struct xarray active_contexts;
> > >   	u32 next_context_id;
> > >   
> > > +	/*
> > > +	 * If true, the GPU is capable of snooping cpu cache. Here, it
> > > +	 * also means that cache coherency is enforced by the hardware.
> > > +	 */
> > > +	bool dma_coherent;
> > > +
> > No need for this, I think. Just use dev_is_dma_coherent() where you
> > need to know this.
> > 
> No, we want this value cached by the driver.
> 
Why? dev_is_dma_coherent() is a header-only function with a single
pointer chasing operation. Your cache is also a single pointer chasing
access, just that we now need storage for this information in both
struct device and struct etnaviv_gpu.

Regards,
Lucas

> We only need call  dev_is_dma_coherent() once!
> 
> We need to reuse this variable on other places.
> 

