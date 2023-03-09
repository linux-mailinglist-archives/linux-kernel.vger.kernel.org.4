Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 049256B1F98
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 10:13:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbjCIJNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 04:13:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbjCIJMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 04:12:50 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 932BE82A8E;
        Thu,  9 Mar 2023 01:12:48 -0800 (PST)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 47A556603007;
        Thu,  9 Mar 2023 09:12:46 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1678353166;
        bh=Qgp7ji/6xp0t3nAXwRde0Z0w/a3gnXKVlDede0CScv8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HzW0uJ9f8N1SQuBc/+pQOt2agrSXDpaAelaubH9DNO+cAA3+eTo0e8e5pVKyH9RHT
         WjHH1nZUqjthdqoFk9uzfGzHA+kTS3p5seqHpSS17XoCPCQVu4zMWdwJq0+DqG2IWw
         /+M3b+ndbg7oWVBOZul8lkOQuMp8ueFAxGzHovB4L38BoVr3CZ7kdvk6mIubAFCoym
         xcvFDjFOTN+CwPZUMtLOd4JBD0rc1O3LTURQAiXU70ArxZLGZe2eDtybluy0Dcpbyy
         PJQBfJa5KEOvA7wBPxMl6tqc4cEepp90XeW4MEysa0axLFc8n9ROPoiBUVkVR9o1VX
         fjos71guF1Yiw==
Date:   Thu, 9 Mar 2023 10:12:43 +0100
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Danilo Krummrich <dakr@redhat.com>
Cc:     airlied@gmail.com, daniel@ffwll.ch, tzimmermann@suse.de,
        mripard@kernel.org, corbet@lwn.net, christian.koenig@amd.com,
        bskeggs@redhat.com, Liam.Howlett@oracle.com,
        matthew.brost@intel.com, alexdeucher@gmail.com, ogabbay@kernel.org,
        bagasdotme@gmail.com, willy@infradead.org, jason@jlekstrand.net,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH drm-next v2 00/16] [RFC] DRM GPUVA Manager & Nouveau
 VM_BIND UAPI
Message-ID: <20230309101243.1150506f@collabora.com>
In-Reply-To: <20230217134422.14116-1-dakr@redhat.com>
References: <20230217134422.14116-1-dakr@redhat.com>
Organization: Collabora
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Danilo,

On Fri, 17 Feb 2023 14:44:06 +0100
Danilo Krummrich <dakr@redhat.com> wrote:

> Changes in V2:
> ==============
>   Nouveau:
>     - Reworked the Nouveau VM_BIND UAPI to avoid memory allocations in fence
>       signalling critical sections. Updates to the VA space are split up in three
>       separate stages, where only the 2. stage executes in a fence signalling
>       critical section:
> 
>         1. update the VA space, allocate new structures and page tables

Sorry for the silly question, but I didn't find where the page tables
pre-allocation happens. Mind pointing it to me? It's also unclear when
this step happens. Is this at bind-job submission time, when the job is
not necessarily ready to run, potentially waiting for other deps to be
signaled. Or is it done when all deps are met, as an extra step before
jumping to step 2. If that's the former, then I don't see how the VA
space update can happen, since the bind-job might depend on other
bind-jobs modifying the same portion of the VA space (unbind ops might
lead to intermediate page table levels disappearing while we were
waiting for deps). If it's the latter, I wonder why this is not
considered as an allocation in the fence signaling path (for the
bind-job out-fence to be signaled, you need these allocations to
succeed, unless failing to allocate page-tables is considered like a HW
misbehavior and the fence is signaled with an error in that case).

Note that I'm not familiar at all with Nouveau or TTM, and it might
be something that's solved by another component, or I'm just
misunderstanding how the whole thing is supposed to work. This being
said, I'd really like to implement a VM_BIND-like uAPI in pancsf using
the gpuva_manager infra you're proposing here, so please bare with me
:-).

>         2. (un-)map the requested memory bindings
>         3. free structures and page tables
> 
>     - Separated generic job scheduler code from specific job implementations.
>     - Separated the EXEC and VM_BIND implementation of the UAPI.
>     - Reworked the locking parts of the nvkm/vmm RAW interface, such that
>       (un-)map operations can be executed in fence signalling critical sections.
> 

Regards,

Boris

