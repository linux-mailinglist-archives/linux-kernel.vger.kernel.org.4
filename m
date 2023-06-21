Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17FD3738DD9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 19:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbjFURzm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 21 Jun 2023 13:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbjFURzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 13:55:20 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09C3E2117
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 10:54:22 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1qC21Q-0003sT-J1; Wed, 21 Jun 2023 19:53:36 +0200
Message-ID: <ba41b807e3af0a1cabb9ba203a401f41254cea1e.camel@pengutronix.de>
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
Date:   Wed, 21 Jun 2023 19:53:34 +0200
In-Reply-To: <02c16e9b-0eca-caf4-b80c-53f1c7eab4e9@loongson.cn>
References: <20230620094716.2231414-1-18949883232@163.com>
         <20230620094716.2231414-8-18949883232@163.com>
         <8f74f0962c8bab6c832919a5340667c54e1a7ddc.camel@pengutronix.de>
         <2249b895-84b9-adea-531b-bf190e9c866f@loongson.cn>
         <030d44e2753b9b2eea0107cdee6c20e2bc2d3efe.camel@pengutronix.de>
         <3911d448-5613-23a8-cfcb-5ae418677338@loongson.cn>
         <87deb46db35b028da74c94f5496b721e14db4745.camel@pengutronix.de>
         <02c16e9b-0eca-caf4-b80c-53f1c7eab4e9@loongson.cn>
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

Am Donnerstag, dem 22.06.2023 um 01:31 +0800 schrieb Sui Jingfeng:
> Hi,
> 
> On 2023/6/22 00:07, Lucas Stach wrote:
> > And as the HW guarantees it on your platform, your platform
> > implementation makes this function effectively a no-op. Skipping the
> > call to this function is breaking the DMA API abstraction, as now the
> > driver is second guessing the DMA API implementation. I really see no
> > reason to do this.
> 
> It is the same reason you chose the word 'effectively', not 'difinitely'.
> 
> We don't want waste the CPU's time,
> 
> 
>   to running the dma_sync_sg_for_cpu funcion() function
> 
> 
> ```
> 
> void dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sg,
>              int nelems, enum dma_data_direction dir)
> {
>      const struct dma_map_ops *ops = get_dma_ops(dev);
> 
>      BUG_ON(!valid_dma_direction(dir));
>      if (dma_map_direct(dev, ops))
>          dma_direct_sync_sg_for_cpu(dev, sg, nelems, dir);
>      else if (ops->sync_sg_for_cpu)
>          ops->sync_sg_for_cpu(dev, sg, nelems, dir);
>      debug_dma_sync_sg_for_cpu(dev, sg, nelems, dir);
> }
> 
> ```
> 
> 
>   to running the this:
> 
> 
> ```
> 
> int etnaviv_gem_cpu_fini(struct drm_gem_object *obj)
> {
>      struct drm_device *dev = obj->dev;
>      struct etnaviv_gem_object *etnaviv_obj = to_etnaviv_bo(obj);
>      struct etnaviv_drm_private *priv = dev->dev_private;
> 
>      if (!priv->dma_coherent && etnaviv_obj->flags & ETNA_BO_CACHED) {
>          /* fini without a prep is almost certainly a userspace error */
>          WARN_ON(etnaviv_obj->last_cpu_prep_op == 0);
>          dma_sync_sgtable_for_device(dev->dev, etnaviv_obj->sgt,
> etnaviv_op_to_dma_dir(etnaviv_obj->last_cpu_prep_op));
>          etnaviv_obj->last_cpu_prep_op = 0;
>      }
> 
>      return 0;
> }
> 
> ```
> 
My judgment as the maintainer of this driver is that the small CPU
overhead of calling this function is very well worth it, if the
alternative is breaking the DMA API abstractions.

> 
> But, this is acceptable, because we can kill the GEM_CPU_PREP and 
> GEM_CPU_FINI ioctl entirely
> 
> at userspace for cached buffer, as this is totally not needed for cached 
> mapping on our platform.
> 
And that statement isn't true either. The CPU_PREP/FINI ioctls also
provide fence synchronization between CPU and GPU. There are a few very
specific cases where skipping those ioctls is acceptable (mostly when
the userspace driver explicitly wants unsynchronized access), but in
most cases they are required for correctness.

Regards,
Lucas
