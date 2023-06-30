Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1AC743666
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 10:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbjF3IDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 04:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbjF3IC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 04:02:59 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 967E42D70;
        Fri, 30 Jun 2023 01:02:57 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id EA0A66606FDE;
        Fri, 30 Jun 2023 09:02:54 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1688112175;
        bh=AZ8TNuVM1gieOIi8tQeOA/DmOnzpPZU4mn9mx4MyD4Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oDlrCeuTgLPl2QzJpS1vsno/RMHtI/H/HL1oScNeYUexrIbQm8ibBk8hwib4S7p7O
         //xJ1qfGJ6x8hRs9SawXTDJ+8QmISHpyUGxYpLXJOPIteRcM5AYBcnuiZDuY+sCkzb
         V9M15Lurltg9sEVYGaodChSzoFoKxO7Fr5eC6nK15snuNppKxwAxgprehJVA6pTZ/c
         IilIoHqUZU5/rvSAQt3NWZwNobOTxLik9Ht7cqOfd13bFIjzY0GW6kQgxXZAN8tNmd
         zFaX8bwAUoWJ/LZcBBWeHbWG+8IjHuriFjqN8pugoot4ntvBgodJuw2DvJzXhDIZ/k
         rXBQr+yfL9h7A==
Date:   Fri, 30 Jun 2023 10:02:52 +0200
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
Message-ID: <20230630100252.7ff6421d@collabora.com>
In-Reply-To: <20230629222651.3196-3-dakr@redhat.com>
References: <20230629222651.3196-1-dakr@redhat.com>
        <20230629222651.3196-3-dakr@redhat.com>
Organization: Collabora
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Danilo,

On Fri, 30 Jun 2023 00:25:18 +0200
Danilo Krummrich <dakr@redhat.com> wrote:

> + *	int driver_gpuva_remap(struct drm_gpuva_op *op, void *__ctx)
> + *	{
> + *		struct driver_context *ctx = __ctx;
> + *
> + *		drm_gpuva_remap(ctx->prev_va, ctx->next_va, &op->remap);
> + *
> + *		drm_gpuva_unlink(op->remap.unmap->va);
> + *		kfree(op->remap.unmap->va);
> + *
> + *		if (op->remap.prev) {
> + *			drm_gpuva_link(ctx->prev_va);

I ended up switching to dma_resv-based locking for the GEMs and I
wonder what the locking is supposed to look like in the async-mapping
case, where we insert/remove the VA nodes in the drm_sched::run_job()
path.

What I have right now is something like:

	dma_resv_lock(vm->resv);

	// split done in drm_gpuva_sm_map(), each iteration
	// of the loop is a call to the driver ->[re,un]map()
	// hook
	for_each_sub_op() {
		
		// Private BOs have their resv field pointing to the
		// VM resv and we take the VM resv lock before calling
		// drm_gpuva_sm_map()
		if (vm->resv != gem->resv)
			dma_resv_lock(gem->resv);

		drm_gpuva_[un]link(va);
		gem_[un]pin(gem);

		if (vm->resv != gem->resv)
			dma_resv_unlock(gem->resv);
	}

	dma_resv_unlock(vm->resv);

In practice, I don't expect things to deadlock, because the VM resv is
not supposed to be taken outside the VM context and the locking order
is always the same (VM lock first, and then each shared BO
taken/released independently), but I'm not super thrilled by this
nested lock, and I'm wondering if we shouldn't have a pass collecting
locks in a drm_exec context first, and then have
the operations executed. IOW, something like that:

	drm_exec_init(exec, DRM_EXEC_IGNORE_DUPLICATES)
	drm_exec_until_all_locked(exec) {
		// Dummy GEM is the dummy GEM object I use to make the VM
		// participate in the locking without having to teach
		// drm_exec how to deal with raw dma_resv objects.
		ret = drm_exec_lock_obj(exec, vm->dummy_gem);
		drm_exec_retry_on_contention(exec);
		if (ret)
			return ret;

		// Could take the form of drm_gpuva_sm_[un]map_acquire_locks()
		// helpers
		for_each_sub_op() {
			ret = drm_exec_lock_obj(exec, gem);
			if (ret)
				return ret;
		}
	}

	// each iteration of the loop is a call to the driver
	// ->[re,un]map() hook
	for_each_sub_op() {
		...
		gem_[un]pin_locked(gem);
		drm_gpuva_[un]link(va);
		...
	}

	drm_exec_fini(exec);

Don't know if I got this right, or if I'm just confused again by how
the drm_gpuva API is supposed to be used.

Regards,

Boris

> + *			ctx->prev_va = NULL;
> + *		}
> + *
> + *		if (op->remap.next) {
> + *			drm_gpuva_link(ctx->next_va);
> + *			ctx->next_va = NULL;
> + *		}
> + *
> + *		return 0;
> + *	}
