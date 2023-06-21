Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15E6373894A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 17:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233176AbjFUPdg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 21 Jun 2023 11:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233497AbjFUPdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 11:33:20 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E44199
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 08:33:17 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1qBzpV-0001GE-N8; Wed, 21 Jun 2023 17:33:09 +0200
Message-ID: <030d44e2753b9b2eea0107cdee6c20e2bc2d3efe.camel@pengutronix.de>
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
Date:   Wed, 21 Jun 2023 17:33:05 +0200
In-Reply-To: <2249b895-84b9-adea-531b-bf190e9c866f@loongson.cn>
References: <20230620094716.2231414-1-18949883232@163.com>
         <20230620094716.2231414-8-18949883232@163.com>
         <8f74f0962c8bab6c832919a5340667c54e1a7ddc.camel@pengutronix.de>
         <2249b895-84b9-adea-531b-bf190e9c866f@loongson.cn>
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

Am Mittwoch, dem 21.06.2023 um 23:00 +0800 schrieb Sui Jingfeng:
> On 2023/6/21 18:00, Lucas Stach wrote:
> > >   static inline enum dma_data_direction etnaviv_op_to_dma_dir(u32 op)
> > > @@ -369,6 +381,7 @@ int etnaviv_gem_cpu_prep(struct drm_gem_object *obj, u32 op,
> > >   {
> > >   	struct etnaviv_gem_object *etnaviv_obj = to_etnaviv_bo(obj);
> > >   	struct drm_device *dev = obj->dev;
> > > +	struct etnaviv_drm_private *priv = dev->dev_private;
> > >   	bool write = !!(op & ETNA_PREP_WRITE);
> > >   	int ret;
> > >   
> > > @@ -395,7 +408,7 @@ int etnaviv_gem_cpu_prep(struct drm_gem_object *obj, u32 op,
> > >   			return ret == 0 ? -ETIMEDOUT : ret;
> > >   	}
> > >   
> > > -	if (etnaviv_obj->flags & ETNA_BO_CACHED) {
> > > +	if (!priv->dma_coherent && etnaviv_obj->flags & ETNA_BO_CACHED) {
> > Why do you need this? Isn't dma_sync_sgtable_for_cpu a no-op on your
> > platform when the device is coherent?
> > 
> I need this to show that our hardware is truly dma-coherent!
> 
> I have tested that the driver still works like a charm without adding 
> this code '!priv->dma_coherent'.
> 
> 
> But I'm expressing the idea that a truly dma-coherent just device don't 
> need this.
> 
> I don't care if it is a no-op.
> 
> It is now, it may not in the future.

And that's exactly the point. If it ever turns into something more than
a no-op on your platform, then that's probably for a good reason and a
driver should not assume that it knows better than the DMA API
implementation what is or is not required on a specific platform to
make DMA work.

> 
> Even it is, the overhead of function call itself still get involved.
> 
cpu_prep/fini aren't total fast paths, you already synchronized with
the GPU here, potentially waiting for jobs to finish, etc. If your
platform no-ops this then the function call will be in the noise.
 
> Also, we want to try flush the write buffer with the CPU manually.
> 
> 
> Currently, we want the absolute correctness in the concept,
> 
> not only the rendering results.

And if you want absolute correctness then calling dma_sync_sgtable_* is
the right thing to do, as it can do much more than just manage caches. 

Right now it also provides SWIOTLB translation if needed.

Regards,
Lucas
