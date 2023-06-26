Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F348A73DCF5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 13:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbjFZLKt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 26 Jun 2023 07:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbjFZLKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 07:10:43 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B438B1999
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 04:10:14 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1qDk6W-0006UL-1D; Mon, 26 Jun 2023 13:10:00 +0200
Message-ID: <dcbc91af5ac17e7618440a693b71d8d4e2b4a8ef.camel@pengutronix.de>
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
Date:   Mon, 26 Jun 2023 13:08:52 +0200
In-Reply-To: <064a39bd-cfca-2799-f72f-0e253215b927@loongson.cn>
References: <20230620094716.2231414-1-18949883232@163.com>
         <20230620094716.2231414-8-18949883232@163.com>
         <8f74f0962c8bab6c832919a5340667c54e1a7ddc.camel@pengutronix.de>
         <66fc74ae-299c-a5de-9cfb-07ae24fb3f07@loongson.cn>
         <8212078bd56c54ce508205eae0ed0b69e78d4c38.camel@pengutronix.de>
         <fd5dd250-b01e-fd00-1419-88398cb13347@loongson.cn>
         <62bf84f19318c54c50f154e1eb64a179fb2389ce.camel@pengutronix.de>
         <064a39bd-cfca-2799-f72f-0e253215b927@loongson.cn>
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

Hi,

Am Sonntag, dem 25.06.2023 um 11:51 +0800 schrieb Sui Jingfeng:
> Hi,
> 
> On 2023/6/22 01:45, Lucas Stach wrote:
> > Am Donnerstag, dem 22.06.2023 um 01:21 +0800 schrieb Sui Jingfeng:
> > > Hi,
> > > 
> > > On 2023/6/21 23:58, Lucas Stach wrote:
> > > > Am Mittwoch, dem 21.06.2023 um 23:30 +0800 schrieb Sui Jingfeng:
> > > > > Hi,
> > > > > 
> > > > > On 2023/6/21 18:00, Lucas Stach wrote:
> > > > > > >     		dma_sync_sgtable_for_cpu(dev->dev, etnaviv_obj->sgt,
> > > > > > >     					 etnaviv_op_to_dma_dir(op));
> > > > > > >     		etnaviv_obj->last_cpu_prep_op = op;
> > > > > > > @@ -408,8 +421,9 @@ int etnaviv_gem_cpu_fini(struct drm_gem_object *obj)
> > > > > > >     {
> > > > > > >     	struct drm_device *dev = obj->dev;
> > > > > > >     	struct etnaviv_gem_object *etnaviv_obj = to_etnaviv_bo(obj);
> > > > > > > +	struct etnaviv_drm_private *priv = dev->dev_private;
> > > > > > >     
> > > > > > > -	if (etnaviv_obj->flags & ETNA_BO_CACHED) {
> > > > > > > +	if (!priv->dma_coherent && etnaviv_obj->flags & ETNA_BO_CACHED) {
> > > > > > >     		/* fini without a prep is almost certainly a userspace error */
> > > > > > >     		WARN_ON(etnaviv_obj->last_cpu_prep_op == 0);
> > > > > > >     		dma_sync_sgtable_for_device(dev->dev, etnaviv_obj->sgt,
> > > > > > > diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c b/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c
> > > > > > > index 3524b5811682..754126992264 100644
> > > > > > > --- a/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c
> > > > > > > +++ b/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c
> > > > > > > @@ -112,11 +112,16 @@ static const struct etnaviv_gem_ops etnaviv_gem_prime_ops = {
> > > > > > >     struct drm_gem_object *etnaviv_gem_prime_import_sg_table(struct drm_device *dev,
> > > > > > >     	struct dma_buf_attachment *attach, struct sg_table *sgt)
> > > > > > >     {
> > > > > > > +	struct etnaviv_drm_private *priv = dev->dev_private;
> > > > > > >     	struct etnaviv_gem_object *etnaviv_obj;
> > > > > > >     	size_t size = PAGE_ALIGN(attach->dmabuf->size);
> > > > > > > +	u32 cache_flags = ETNA_BO_WC;
> > > > > > >     	int ret, npages;
> > > > > > >     
> > > > > > > -	ret = etnaviv_gem_new_private(dev, size, ETNA_BO_WC,
> > > > > > > +	if (priv->dma_coherent)
> > > > > > > +		cache_flags = ETNA_BO_CACHED;
> > > > > > > +
> > > > > > Drop this change. Instead etnaviv_gem_new_impl() should do the upgrade
> > > > > > from WC to CACHED as necessary by adding something like this:
> > > > > I understand you are a profession person in vivante GPU driver domain.
> > > > > 
> > > > > I respect you reviews and instruction.
> > > > > 
> > > > > But, I'm really reluctant to agree with this, is there any space to
> > > > > negotiate?
> > > > > 
> > > > > > /*
> > > > > >     * Upgrade WC to CACHED when the device is hardware coherent and the
> > > > > >     * platform doesn't allow mixing cached and writecombined mappings to
> > > > > >     * the same memory area.
> > > > > >     */
> > > > > > if ((flags & ETNA_BO_CACHE_MASK) == ETNA_BO_WC &&
> > > > > >        dev_is_dma_coherent(dev) && !drm_arch_can_wc_memory())
> > > > > >            flags = (flags & ~ETNA_BO_CACHE_MASK) & ETNA_BO_CACHED;
> > > > > This is policy, not a mechanism.
> > > > > 
> > > > > Using what cache property is a user-space program's choice.
> > > > > 
> > > > > While you are override the WC with CACHED mapping. This is not correct
> > > > > in the concept!
> > > > > 
> > > > Please explain why you think that this isn't correct.
> > > Again,
> > > 
> > > this is user-space things!
> > > 
> > > this is user-space things!
> > > 
> > > this is user-space things!
> > > 
> > > I have explained several times.
> > > 
> > > made the decision for the user-space program is wrong.
> > > 
> > This mode of communication isn't helpful. Please stop it.
> > 
> > As I tried to explain to you multiple times: if userspace can break
> > coherency by selecting the wrong mapping type then this is something
> > the kernel should prevent.
> 
> You are right in overall.
> 
> 
> This is the only one benefit which WC mapping is preferred over the 
> cached mapping.
> 
> As you already told me,  the WC mapping don't *pollute CPU's cache*.
> 
> 
> If we can make sure that a BO is *only* going to be used by the GPU,
> 
> then we still can choose WC mapping as the cache property of this BO.
> 
> As the cache property is CPU side thing.
> 
But if it only used by the GPU, then WC won't help you either as the
CPU is never touching the memory. The benefit of WC is that the CPU can
write around the cache, so if it uploads data to the GPU this data
won't pollute the cache. If the buffer is only used by the GPU, then
there is no risk of cache pollution through the CPU, right?

> 
> > > > It allows
> > > > userspace to use WC mappings that would potentially cause loss of
> > > > coherency between CPU and GPU, which isn't acceptable.
> > > Before made the WC works correctly,  you need the developing environment.
> > > 
> > > userspace program can tune the BO cache mapping easily.
> > > 
> > > Either environment or supply a conf file.
> > > 
> > > 
> > > While with your implement, we don't have the opportunity to do debugging
> > > and the development.
> > You can always add a patch to your local kernel to re-allow WC mappings
> > while you work on making them behave as expected on your platform.
> 
> 
> We are doing the things about the *upstream*.
> 
Upstream is not about doing experiments. You can always do those
experiments in your development kernel and if they prove to be
beneficial, we can think about how to integrate them with the upstream
kernel without the risk of inadvertently breaking things.

> 
> >   With
> > the mainline kernel there is no way that the kernel driver will allow
> > broken coherency.
> 
> 
> A buffer is used by the GPU solely won't break the coherency.
> 
> 
> > And as I also mentioned before, there is a clear upgrade path here:
> > once WC mappings work as expected on your platform we can easily drop
> > the upgrading from the kernel driver again. The userspace driver can
> > already be changed to use CACHED BOs where beneficial on your platform
> > in the meantime.
> 
> For our platform, I think the problem is that the GPU always write to L3 
> share cache,
> 
> even you use the WC mapping.

As long as that is the case, I think forcing the CPU to go through the
same cache by upgrading the BOs to cached is the right thing to do.
> 
> As I already said, the WC mapping only influence the CPU side.
> 
> How can I control the GPU when a BO is WC mapping ?

Hm, newer GPUs allow to use different AXI attributes (which include the
cachability) controlled via a pagetable setting, but I'm not sure if
the GC1000 on your platform supports this.

Can you ask your hardware guys if there is a way to set the PCI "no-
snoop" transaction flag from the GPU and if that will cause the GPU
memory accesses to bypass the L3 cache?
 
> 
> Does the GPU know that whether a BO  is WC mapping or not ?
> 
> How can I let(or tell) the GPU that
> 
> please not write to shared L3 cache,  write to the system RAM directly?
> 
> On out platform, the coherency between the CPU and peripheral IO 
> device's cache
> 
> is maintained by hardware. While at here.  the hardware is the shared L3 
> cache.
> 
> 
> I guess the current problem is that the GPU don't listen to me,
> 
> he still write to CPU cache's even you choose the WC mapping.
> 
> Then if you want to read the rendered image by CPU,
> 
> the CPU go the un-cached path. Then I think the CPU will get wrong data.
> 
Yes, that sounds plausible and I don't see much of a way around this
other than forcing the CPU to use the same path through the cache.

Regards,
Lucas

