Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F7C06F152C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 12:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346051AbjD1KSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 06:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345595AbjD1KSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 06:18:20 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B3162D49;
        Fri, 28 Apr 2023 03:18:19 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 265436602097;
        Fri, 28 Apr 2023 11:18:17 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1682677097;
        bh=Yk5D9b+oPUkoCZwzeMIIJtHOgvXide7fZoW+I8ghpV0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mhhECMNxkLs1iW+QaB2pRm8nUySryOtAT9Y4NOyMqr2EqHYzZmpOT+adaU6/ID1a9
         no1OdnK+ALZIj8/C7cBWw20X2bNzE89ZFuf6mYMbos909zeCh8D7m0E2UFsLyi3fri
         MJloqfSnhMn9R9NfMh89i03ukNYFMrsV08bymj3SSPhXtXvaNygxNTThFredKI91aT
         E3NP3647tgYI23H9PtLyuLvhEXAJoK4jHGAjfi09ZqIlAzfKWTKK6G/5bZj9bKGvUX
         sM8uGnfSD66AngdfS1WteFdbKzplq4xmhjx4GPFm5NVhHHnboQ0n6DZdSmsdshX2G0
         mCGmVSSVOfJmw==
Date:   Fri, 28 Apr 2023 12:18:13 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Danilo Krummrich <dakr@redhat.com>
Cc:     airlied@gmail.com, daniel@ffwll.ch, tzimmermann@suse.de,
        mripard@kernel.org, corbet@lwn.net, christian.koenig@amd.com,
        bskeggs@redhat.com, Liam.Howlett@oracle.com,
        matthew.brost@intel.com, alexdeucher@gmail.com, ogabbay@kernel.org,
        bagasdotme@gmail.com, willy@infradead.org, jason@jlekstrand.net,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Dave Airlie <airlied@redhat.com>
Subject: Re: [PATCH drm-next v3 04/15] drm: manager to keep track of GPUs VA
 mappings
Message-ID: <20230428121813.309ea609@collabora.com>
In-Reply-To: <20230404012741.116502-5-dakr@redhat.com>
References: <20230404012741.116502-1-dakr@redhat.com>
        <20230404012741.116502-5-dakr@redhat.com>
Organization: Collabora
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-redhat-linux-gnu)
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

On Tue,  4 Apr 2023 03:27:30 +0200
Danilo Krummrich <dakr@redhat.com> wrote:

> +struct drm_gpuva_manager {
> +	/**
> +	 * @name: the name of the DRM GPU VA space
> +	 */
> +	const char *name;
> +
> +	/**
> +	 * @mm_start: start of the VA space
> +	 */
> +	u64 mm_start;
> +
> +	/**
> +	 * @mm_range: length of the VA space
> +	 */
> +	u64 mm_range;
> +
> +	/**
> +	 * @mtree: the &maple_tree to track GPU VA mappings
> +	 */
> +	struct maple_tree mtree;
> +
> +	/**
> +	 * @kernel_alloc_node:
> +	 *
> +	 * &drm_gpuva representing the address space cutout reserved for
> +	 * the kernel
> +	 */
> +	struct drm_gpuva kernel_alloc_node;
> +
> +	/**
> +	 * @ops: &drm_gpuva_fn_ops providing the split/merge steps to drivers
> +	 */
> +	struct drm_gpuva_fn_ops *ops;

Any reason for not making that a const object (same goes for all the
functions being passed a drm_gpuva_fn_ops)?

> +};
