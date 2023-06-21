Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20C43738D87
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 19:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbjFURqU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 21 Jun 2023 13:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbjFURqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 13:46:15 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EAF5B4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 10:46:11 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1qC1u6-0002mG-9H; Wed, 21 Jun 2023 19:46:02 +0200
Message-ID: <62bf84f19318c54c50f154e1eb64a179fb2389ce.camel@pengutronix.de>
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
Date:   Wed, 21 Jun 2023 19:45:57 +0200
In-Reply-To: <fd5dd250-b01e-fd00-1419-88398cb13347@loongson.cn>
References: <20230620094716.2231414-1-18949883232@163.com>
         <20230620094716.2231414-8-18949883232@163.com>
         <8f74f0962c8bab6c832919a5340667c54e1a7ddc.camel@pengutronix.de>
         <66fc74ae-299c-a5de-9cfb-07ae24fb3f07@loongson.cn>
         <8212078bd56c54ce508205eae0ed0b69e78d4c38.camel@pengutronix.de>
         <fd5dd250-b01e-fd00-1419-88398cb13347@loongson.cn>
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

Am Donnerstag, dem 22.06.2023 um 01:21 +0800 schrieb Sui Jingfeng:
> Hi,
> 
> On 2023/6/21 23:58, Lucas Stach wrote:
> > Am Mittwoch, dem 21.06.2023 um 23:30 +0800 schrieb Sui Jingfeng:
> > > Hi,
> > > 
> > > On 2023/6/21 18:00, Lucas Stach wrote:
> > > > >    		dma_sync_sgtable_for_cpu(dev->dev, etnaviv_obj->sgt,
> > > > >    					 etnaviv_op_to_dma_dir(op));
> > > > >    		etnaviv_obj->last_cpu_prep_op = op;
> > > > > @@ -408,8 +421,9 @@ int etnaviv_gem_cpu_fini(struct drm_gem_object *obj)
> > > > >    {
> > > > >    	struct drm_device *dev = obj->dev;
> > > > >    	struct etnaviv_gem_object *etnaviv_obj = to_etnaviv_bo(obj);
> > > > > +	struct etnaviv_drm_private *priv = dev->dev_private;
> > > > >    
> > > > > -	if (etnaviv_obj->flags & ETNA_BO_CACHED) {
> > > > > +	if (!priv->dma_coherent && etnaviv_obj->flags & ETNA_BO_CACHED) {
> > > > >    		/* fini without a prep is almost certainly a userspace error */
> > > > >    		WARN_ON(etnaviv_obj->last_cpu_prep_op == 0);
> > > > >    		dma_sync_sgtable_for_device(dev->dev, etnaviv_obj->sgt,
> > > > > diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c b/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c
> > > > > index 3524b5811682..754126992264 100644
> > > > > --- a/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c
> > > > > +++ b/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c
> > > > > @@ -112,11 +112,16 @@ static const struct etnaviv_gem_ops etnaviv_gem_prime_ops = {
> > > > >    struct drm_gem_object *etnaviv_gem_prime_import_sg_table(struct drm_device *dev,
> > > > >    	struct dma_buf_attachment *attach, struct sg_table *sgt)
> > > > >    {
> > > > > +	struct etnaviv_drm_private *priv = dev->dev_private;
> > > > >    	struct etnaviv_gem_object *etnaviv_obj;
> > > > >    	size_t size = PAGE_ALIGN(attach->dmabuf->size);
> > > > > +	u32 cache_flags = ETNA_BO_WC;
> > > > >    	int ret, npages;
> > > > >    
> > > > > -	ret = etnaviv_gem_new_private(dev, size, ETNA_BO_WC,
> > > > > +	if (priv->dma_coherent)
> > > > > +		cache_flags = ETNA_BO_CACHED;
> > > > > +
> > > > Drop this change. Instead etnaviv_gem_new_impl() should do the upgrade
> > > > from WC to CACHED as necessary by adding something like this:
> > > I understand you are a profession person in vivante GPU driver domain.
> > > 
> > > I respect you reviews and instruction.
> > > 
> > > But, I'm really reluctant to agree with this, is there any space to
> > > negotiate?
> > > 
> > > > /*
> > > >    * Upgrade WC to CACHED when the device is hardware coherent and the
> > > >    * platform doesn't allow mixing cached and writecombined mappings to
> > > >    * the same memory area.
> > > >    */
> > > > if ((flags & ETNA_BO_CACHE_MASK) == ETNA_BO_WC &&
> > > >       dev_is_dma_coherent(dev) && !drm_arch_can_wc_memory())
> > > >           flags = (flags & ~ETNA_BO_CACHE_MASK) & ETNA_BO_CACHED;
> > > This is policy, not a mechanism.
> > > 
> > > Using what cache property is a user-space program's choice.
> > > 
> > > While you are override the WC with CACHED mapping. This is not correct
> > > in the concept!
> > > 
> > Please explain why you think that this isn't correct.
> 
> Again,
> 
> this is user-space things!
> 
> this is user-space things!
> 
> this is user-space things!
> 
> I have explained several times.
> 
> made the decision for the user-space program is wrong.
> 
This mode of communication isn't helpful. Please stop it.

As I tried to explain to you multiple times: if userspace can break
coherency by selecting the wrong mapping type then this is something
the kernel should prevent.

> 
> > It allows
> > userspace to use WC mappings that would potentially cause loss of
> > coherency between CPU and GPU, which isn't acceptable.
> 
> Before made the WC works correctly,  you need the developing environment.
> 
> userspace program can tune the BO cache mapping easily.
> 
> Either environment or supply a conf file.
> 
> 
> While with your implement, we don't have the opportunity to do debugging 
> and the development.

You can always add a patch to your local kernel to re-allow WC mappings
while you work on making them behave as expected on your platform. With
the mainline kernel there is no way that the kernel driver will allow
broken coherency.

And as I also mentioned before, there is a clear upgrade path here:
once WC mappings work as expected on your platform we can easily drop
the upgrading from the kernel driver again. The userspace driver can
already be changed to use CACHED BOs where beneficial on your platform
in the meantime.

Regards,
Lucas
