Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D10AB6EA88C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 12:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbjDUKqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 06:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbjDUKqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 06:46:30 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06B9E83FC;
        Fri, 21 Apr 2023 03:46:28 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 11EA96602040;
        Fri, 21 Apr 2023 11:46:26 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1682073986;
        bh=xy1oqjU5V/MfMlLIxJBwQthAmE3+07DxTdM+2r5CRK4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Jjamna4sOjLQkH1nkuIHUE36adS3B1KZwwMxTmygRn+u3/pxkEYo1F5PkmJVw4239
         wJ2unj8E4sgzv5F/dTBIm4We4BM1YRFVftcf1/unkDQWK2Gd8rlwkOk9isIcl8ZU4K
         u3XVV6sZQ+x6LNMVcVXbvfWEV7n0cWBzE/lFdNDolnKXKo1R0RgZY1KEKNYJjymDZe
         1pjNjYuBEHtQJtRZME2qyikHAFFiWNiovamiotKiNxWQ1hFWpN/6yOaGatSU0+IjMt
         oBZ1VO0ap3BM0VFBCdynQBNuj87otIdpOiix9tBW/8hGrk0GbKGltZP8Kp2AIPgw2M
         F57uTnKdV+DXQ==
Date:   Fri, 21 Apr 2023 12:46:22 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Danilo Krummrich <dakr@redhat.com>
Cc:     airlied@gmail.com, daniel@ffwll.ch, tzimmermann@suse.de,
        mripard@kernel.org, corbet@lwn.net, christian.koenig@amd.com,
        bskeggs@redhat.com, Liam.Howlett@oracle.com,
        matthew.brost@intel.com, alexdeucher@gmail.com, ogabbay@kernel.org,
        bagasdotme@gmail.com, willy@infradead.org, jason@jlekstrand.net,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Dave Airlie <airlied@redhat.com>,
        donald.robson@imgtec.com
Subject: Re: [PATCH drm-next v3 04/15] drm: manager to keep track of GPUs VA
 mappings
Message-ID: <20230421124622.6386cd60@collabora.com>
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

> +/**
> + * drm_gpuva_prealloc_create - creates a preallocated node to store a
> + * &drm_gpuva entry.
> + *
> + * Returns: the &drm_gpuva_prealloc object on success, NULL on failure
> + */
> +struct drm_gpuva_prealloc *
> +drm_gpuva_prealloc_create(void)
> +{
> +	struct drm_gpuva_prealloc *pa;
> +
> +	pa = kzalloc(sizeof(*pa), GFP_KERNEL);
> +	if (!pa)
> +		return NULL;
> +
> +	if (mas_preallocate(&pa->mas, GFP_KERNEL)) {

mas_preallocate() needs a valid tree field to calculate the number
of nodes to pre-allocate. I guess we're missing a MA_STATE_INIT() here,
and we need to pass a gpuva_mgr object to this helper.

> +		kfree(pa);
> +		return NULL;
> +	}
> +
> +	return pa;
> +}
> +EXPORT_SYMBOL(drm_gpuva_prealloc_create);
