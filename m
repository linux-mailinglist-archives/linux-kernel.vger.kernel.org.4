Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95818738A50
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 17:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233810AbjFUP7P convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 21 Jun 2023 11:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233790AbjFUP66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 11:58:58 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F4A919C
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 08:58:54 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1qC0EI-0004tn-Eh; Wed, 21 Jun 2023 17:58:46 +0200
Message-ID: <8212078bd56c54ce508205eae0ed0b69e78d4c38.camel@pengutronix.de>
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
Date:   Wed, 21 Jun 2023 17:58:43 +0200
In-Reply-To: <66fc74ae-299c-a5de-9cfb-07ae24fb3f07@loongson.cn>
References: <20230620094716.2231414-1-18949883232@163.com>
         <20230620094716.2231414-8-18949883232@163.com>
         <8f74f0962c8bab6c832919a5340667c54e1a7ddc.camel@pengutronix.de>
         <66fc74ae-299c-a5de-9cfb-07ae24fb3f07@loongson.cn>
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

Am Mittwoch, dem 21.06.2023 um 23:30 +0800 schrieb Sui Jingfeng:
> Hi,
> 
> On 2023/6/21 18:00, Lucas Stach wrote:
> > >   		dma_sync_sgtable_for_cpu(dev->dev, etnaviv_obj->sgt,
> > >   					 etnaviv_op_to_dma_dir(op));
> > >   		etnaviv_obj->last_cpu_prep_op = op;
> > > @@ -408,8 +421,9 @@ int etnaviv_gem_cpu_fini(struct drm_gem_object *obj)
> > >   {
> > >   	struct drm_device *dev = obj->dev;
> > >   	struct etnaviv_gem_object *etnaviv_obj = to_etnaviv_bo(obj);
> > > +	struct etnaviv_drm_private *priv = dev->dev_private;
> > >   
> > > -	if (etnaviv_obj->flags & ETNA_BO_CACHED) {
> > > +	if (!priv->dma_coherent && etnaviv_obj->flags & ETNA_BO_CACHED) {
> > >   		/* fini without a prep is almost certainly a userspace error */
> > >   		WARN_ON(etnaviv_obj->last_cpu_prep_op == 0);
> > >   		dma_sync_sgtable_for_device(dev->dev, etnaviv_obj->sgt,
> > > diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c b/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c
> > > index 3524b5811682..754126992264 100644
> > > --- a/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c
> > > +++ b/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c
> > > @@ -112,11 +112,16 @@ static const struct etnaviv_gem_ops etnaviv_gem_prime_ops = {
> > >   struct drm_gem_object *etnaviv_gem_prime_import_sg_table(struct drm_device *dev,
> > >   	struct dma_buf_attachment *attach, struct sg_table *sgt)
> > >   {
> > > +	struct etnaviv_drm_private *priv = dev->dev_private;
> > >   	struct etnaviv_gem_object *etnaviv_obj;
> > >   	size_t size = PAGE_ALIGN(attach->dmabuf->size);
> > > +	u32 cache_flags = ETNA_BO_WC;
> > >   	int ret, npages;
> > >   
> > > -	ret = etnaviv_gem_new_private(dev, size, ETNA_BO_WC,
> > > +	if (priv->dma_coherent)
> > > +		cache_flags = ETNA_BO_CACHED;
> > > +
> > Drop this change. Instead etnaviv_gem_new_impl() should do the upgrade
> > from WC to CACHED as necessary by adding something like this:
> 
> I understand you are a profession person in vivante GPU driver domain.
> 
> I respect you reviews and instruction.
> 
> But, I'm really reluctant to agree with this, is there any space to 
> negotiate?
> 
> > /*
> >   * Upgrade WC to CACHED when the device is hardware coherent and the
> >   * platform doesn't allow mixing cached and writecombined mappings to
> >   * the same memory area.
> >   */
> > if ((flags & ETNA_BO_CACHE_MASK) == ETNA_BO_WC &&
> >      dev_is_dma_coherent(dev) && !drm_arch_can_wc_memory())
> >          flags = (flags & ~ETNA_BO_CACHE_MASK) & ETNA_BO_CACHED;
> 
> This is policy, not a mechanism.
> 
> Using what cache property is a user-space program's choice.
> 
> While you are override the WC with CACHED mapping. This is not correct 
> in the concept!
> 
Please explain why you think that this isn't correct. If using WC
mappings cause a potential loss of coherency on your platform, then we
can not allow the userspace driver to use WC mappings.

As I would like to keep the option of WC mappings, I've asked you if
there are ways to prepare the cache in a way that WC mappings aren't
causing any troubles on your platform. You told me that this might be
possible but needs confirmation from a HW engineer and such
confirmation could take a long time.

With that in mind, our only option right now is to upgrade the mappings
to cached  in order to not lay out traps for the userspace driver.
 
> you approach forbidden any possibility to use the WC BO at anywhere.
> 
> 
> My approach need only check once, while you approach need at least 3 
> check plus
> 
> so much bit-wise logic operations,  plus a function call  (&, ==, &&,  
> &, ~, &) .
> 
> and every time you create a BO. This nasty judgement happens.
> 
BO creation again is not a fast path. You are committing to allocate
new memory, which is a few orders of magnitude more costly than the few
instructions needed for those comparisons.

> 
> Please keep our original implement, it's simple and clear, Please?
> 

It isn't as simple and clear for the userspace interface. It allows
userspace to use WC mappings that would potentially cause loss of
coherency between CPU and GPU, which isn't acceptable.

Regards,
Lucas
