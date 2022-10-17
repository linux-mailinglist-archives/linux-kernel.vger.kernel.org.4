Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 503336012DB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 17:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbiJQPoi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 11:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbiJQPoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 11:44:32 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 000B3B7E5
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 08:44:31 -0700 (PDT)
Received: from maud (206-47-13-26.static.dsl.ncf.ca [206.47.13.26])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: alyssa)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3CA0D6602374;
        Mon, 17 Oct 2022 16:44:28 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1666021470;
        bh=nA5oW84TlD9lx4SFh3dsX3JFoRKKBcKJQ4YZKlmDfWM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F3m/J3xinHDXomn9zuWZ3Pwbg52ZtYP8zjwHMA5q6cyoLb6XIwkfJaVDcOoLNbabp
         TXOmdXQqkLp3cwsvbvsdxYK/QjqJrQ67r9uAsXeVJZ6sgmHZ+GRvd5BTp88xb5xOPM
         ebed0AyWgzY/19AaZaKeikIksc8lAtTkRV/ZpV5tleLwoEIY8rHGOutnohOaCoBBxk
         SOq5Hz7K+C5eG8QiFzi/27OXUYU6l2TAlIEV7J8osfhVkkawN/RoEMe+sp1WnHC2tY
         faiLNCcS8K2xd3Y/XVR+OPbSFz550BoVuwKFYNRaGirrb/HJW1cQ8ikvX3S4M54XDo
         RRTHmfPlfFETg==
Date:   Mon, 17 Oct 2022 11:44:22 -0400
From:   Alyssa Rosenzweig <alyssa@collabora.com>
To:     Steven Price <steven.price@arm.com>
Cc:     Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Adri??n Larumbe <adrian.larumbe@collabora.com>,
        Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v2 0/2] drm/panfrost: Fix UAPI for C++/BSD compatibility
Message-ID: <Y014Vh1hGahjqUlB@maud>
References: <20221017104602.142992-1-steven.price@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221017104602.142992-1-steven.price@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Series is

	Reviewed-by: Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>

Thank you for this, please push to the appropriate trees so we can fix
the Mesa build.

On Mon, Oct 17, 2022 at 11:46:00AM +0100, Steven Price wrote:
> The Panfrost DRM interface to user space is uesd in Mesa for targets
> other than C/Linux. Specifically the header file needs to compile in C++
> code and for FreeBSD which shares the same UABI.
> 
> The first patch fixes the C++ compilation issue by removing the
> (unnecessary) type name from internal structs which is invalid in C++.
> 
> The second patch technically changes the UABI by changing the header
> values in the dump format to be native endian rather than fixed
> little-endian. Since (a) there are no known big-endian Mali systems, and
> (b) this has only appeared in -rc1, this shouldn't break user space.
> Tools can use the 'magic' field to identify the endianness of the dump
> if they want to support big-endian.
> 
> This is effectively a 'v2' of Adri??n's series here [1].
> 
> [1] https://lore.kernel.org/r/20220920211545.1017355-1-adrian.larumbe%40collabora.com
> 
> Steven Price (2):
>   drm/panfrost: Remove type name from internal structs
>   drm/panfrost: replace endian-specific types with native ones
> 
>  drivers/gpu/drm/panfrost/panfrost_dump.c | 36 ++++++++++++------------
>  include/uapi/drm/panfrost_drm.h          | 36 +++++++++++++-----------
>  2 files changed, 38 insertions(+), 34 deletions(-)
> 
> -- 
> 2.34.1
> 
