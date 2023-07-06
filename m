Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D19F474A216
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 18:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbjGFQRs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 12:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjGFQRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 12:17:46 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 557D71BD0;
        Thu,  6 Jul 2023 09:17:44 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 530526606FC4;
        Thu,  6 Jul 2023 17:17:42 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1688660262;
        bh=4cV/8VdwLXH2eQQcsUWFWhhwEQt7rM/qzAqlvLShfgU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NnO4ma2CFt85JPIzCSWDPOL/s22MT7Y8TKuN0Mn5aRnPK5LRvyYn6PeGRVh//Oqzi
         p9c7y2J7vGMdC9Mh6iJmIiE3Q1TQBCGqmcEBmxUkZlLjnSWXcbP8v5q5LOraWPzIM4
         EyJqNchWG0HPb1FlXXUNA84WBdEJgUFTVcaY2TqdiuY7rtAP3Zcz8D2E8QKzuborXe
         696gPDul6pbSYLPtRpZ9dR1RcFi4NaGEV1Q9DCgWIANz6C/LWkmTxQIq2UfWIP58rh
         OZ0RnjjsohZ8pJ2st60CZyt3PCBwQt8ve7sqGAXv3dmJG6XHtEfSCrVgO1ugL6yUJe
         1a7FEuXKsrHtQ==
Date:   Thu, 6 Jul 2023 18:17:39 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Danilo Krummrich <dakr@redhat.com>
Cc:     airlied@gmail.com, daniel@ffwll.ch, tzimmermann@suse.de,
        mripard@kernel.org, corbet@lwn.net, christian.koenig@amd.com,
        bskeggs@redhat.com, Liam.Howlett@oracle.com,
        matthew.brost@intel.com, alexdeucher@gmail.com, ogabbay@kernel.org,
        bagasdotme@gmail.com, willy@infradead.org, jason@jlekstrand.net,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Donald Robson <donald.robson@imgtec.com>,
        Dave Airlie <airlied@redhat.com>
Subject: Re: [PATCH drm-next v6 02/13] drm: manager to keep track of GPUs VA
 mappings
Message-ID: <20230706181739.57afbcfa@collabora.com>
In-Reply-To: <755b3aeb-8067-2fa5-5173-d889811e954a@redhat.com>
References: <20230629222651.3196-1-dakr@redhat.com>
        <20230629222651.3196-3-dakr@redhat.com>
        <20230630100252.7ff6421d@collabora.com>
        <755b3aeb-8067-2fa5-5173-d889811e954a@redhat.com>
Organization: Collabora
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Jul 2023 17:06:08 +0200
Danilo Krummrich <dakr@redhat.com> wrote:

> Hi Boris,
> 
> On 6/30/23 10:02, Boris Brezillon wrote:
> > Hi Danilo,
> > 
> > On Fri, 30 Jun 2023 00:25:18 +0200
> > Danilo Krummrich <dakr@redhat.com> wrote:
> >   
> >> + *	int driver_gpuva_remap(struct drm_gpuva_op *op, void *__ctx)
> >> + *	{
> >> + *		struct driver_context *ctx = __ctx;
> >> + *
> >> + *		drm_gpuva_remap(ctx->prev_va, ctx->next_va, &op->remap);
> >> + *
> >> + *		drm_gpuva_unlink(op->remap.unmap->va);
> >> + *		kfree(op->remap.unmap->va);
> >> + *
> >> + *		if (op->remap.prev) {
> >> + *			drm_gpuva_link(ctx->prev_va);  
> > 
> > I ended up switching to dma_resv-based locking for the GEMs and I
> > wonder what the locking is supposed to look like in the async-mapping
> > case, where we insert/remove the VA nodes in the drm_sched::run_job()
> > path.  
> 
> If you decide to pick the interface where you just call 
> drm_gpuva_sm_[un]map() and receive a callback for each operation it 
> takes to fulfill the request, you probably do this because you want to 
> do everything one shot, updating the VA space, link/unlink GPUVAs 
> to/from its corresponding backing GEMs, do the actual GPU mappings.
> 
> This has a few advantages over generating a list of operations when the 
> job is submitted. You've pointed out one of them, when you noticed that 
> with a list of operations one can't sneak in a synchronous job between 
> already queued up asynchronous jobs.
> 
> However, for the asynchronous path it has the limitation that the 
> dma-resv lock can't be used to link/unlink GPUVAs to/from its 
> corresponding backing GEMs, since this would happen in the fence 
> signalling critical path and we're not allowed to hold the dma-resv lock 
> there. Hence, as we discussed I added the option for drivers to provide 
> an external lock for that, just to be able to keep some lockdep checks.

Uh, okay, I guess that means I need to go back to a custom lock for VM
operations then.

> 
> > 
> > What I have right now is something like:
> > 
> > 	dma_resv_lock(vm->resv);
> > 
> > 	// split done in drm_gpuva_sm_map(), each iteration
> > 	// of the loop is a call to the driver ->[re,un]map()
> > 	// hook
> > 	for_each_sub_op() {
> > 		
> > 		// Private BOs have their resv field pointing to the
> > 		// VM resv and we take the VM resv lock before calling
> > 		// drm_gpuva_sm_map()
> > 		if (vm->resv != gem->resv)
> > 			dma_resv_lock(gem->resv);
> > 
> > 		drm_gpuva_[un]link(va);
> > 		gem_[un]pin(gem);
> > 
> > 		if (vm->resv != gem->resv)
> > 			dma_resv_unlock(gem->resv);
> > 	}
> > 
> > 	dma_resv_unlock(vm->resv);
> >   
> 
> I'm not sure I get this code right, reading "for_each_sub_op()" and 
> "drm_gpuva_sm_map()" looks a bit like things are mixed up?
> 
> Or do you mean to represent the sum of all callbacks with 
> "for_each_sub_op()"?

That ^.

> In this case I assume this code runs in 
> drm_sched::run_job() and hence isn't allowed to take the dma-resv lock.

Yeah, I didn't realize that taking the dma-resv lock in the
dma-signaling path was forbidden. I think it's fine for the drm_gpuva
destroy operation (which calls drm_gem_shmem_unpin(), which in turns
acquires the resv lock) because I can move that to a worker and get it
out of the dma-signaling path. The problem remains for remap operations
though. I need to call drm_gem_shmem_pin() so we retain the pages even
after the unmapped gpuva object that's in the middle of a mapping is
released. I guess one option would be to use an atomic_t for
drm_shmem_gem_object::pages_use_count, and
have something like:

int drm_gem_shmem_pin(struct drm_gem_shmem_object *shmem)
{
	int ret;

	if (atomic_inc_not_zero(&shmem->pages_use_count))
		return 0;

	dma_resv_lock(shmem->base.resv, NULL);
	ret = drm_gem_shmem_pin_locked(shmem);
	dma_resv_unlock(shmem->base.resv);

	return ret;
}

Given the object already had its pages pinned when we remap, we're sure
the fast path will be taken, and no dma-resv lock aquired.

> 
> > In practice, I don't expect things to deadlock, because the VM resv is
> > not supposed to be taken outside the VM context and the locking order
> > is always the same (VM lock first, and then each shared BO
> > taken/released independently), but I'm not super thrilled by this
> > nested lock, and I'm wondering if we shouldn't have a pass collecting
> > locks in a drm_exec context first, and then have
> > the operations executed. IOW, something like that:
> > 
> > 	drm_exec_init(exec, DRM_EXEC_IGNORE_DUPLICATES)
> > 	drm_exec_until_all_locked(exec) {
> > 		// Dummy GEM is the dummy GEM object I use to make the VM
> > 		// participate in the locking without having to teach
> > 		// drm_exec how to deal with raw dma_resv objects.
> > 		ret = drm_exec_lock_obj(exec, vm->dummy_gem);
> > 		drm_exec_retry_on_contention(exec);
> > 		if (ret)
> > 			return ret;
> > 
> > 		// Could take the form of drm_gpuva_sm_[un]map_acquire_locks()
> > 		// helpers
> > 		for_each_sub_op() {
> > 			ret = drm_exec_lock_obj(exec, gem);
> > 			if (ret)
> > 				return ret;
> > 		}
> > 	}
> > 
> > 	// each iteration of the loop is a call to the driver
> > 	// ->[re,un]map() hook
> > 	for_each_sub_op() {
> > 		...
> > 		gem_[un]pin_locked(gem);
> > 		drm_gpuva_[un]link(va);
> > 		...
> > 	}
> > 
> > 	drm_exec_fini(exec);  
> 
> I have a follow-up patch (still WIP) in the queue to generalize dma-resv 
> handling, fence handling and GEM validation within the GPUVA manager as 
> optional helper functions: 
> https://gitlab.freedesktop.org/nouvelles/kernel/-/commit/a5fc29f3b1edbf3f96fb5a21b858ffe00a3f2584

Thanks for the heads-up. That's more or less what I have, except I'm
attaching a dummy_gem object to the VM so it can be passed to drm_exec
directly (instead of having a separate ww_acquire_ctx).
