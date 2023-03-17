Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3455D6BE9CD
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 14:03:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbjCQNDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 09:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbjCQNDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 09:03:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DFB12B9E7
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 06:03:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0D569B82560
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 13:03:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67FC6C433D2;
        Fri, 17 Mar 2023 13:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679058220;
        bh=iNSOOAOLJkrNZv9kPsAMl/cmeqa4OkILJKFPik6I9gY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fGo9DMAjIWgX1yybKyJfozi59brR3yf9AEx2ZzvCSQm+GXECKiZYJtMduFxf3WptW
         WlP2cEsagwXeEjNKarl8rIYyIzhzYT/P5R1sMNGTkCoBFA3BqCf1UI991hR+aOX0Ph
         DoaiqbYARNxKFMmLartxcZeAL1DB4EDGZr7LYy3RIAuV3fT6nHZcyX+Mglz7KlNtk/
         eNExdUyodcZ0ugKLFr89Sf7xpiuOsBikn5dLnxVHHTuyTXaYYMav8zYXrHxgVL9fsR
         ezCATOh50ACtE2RkiQa+t1939uw8FcM1TFRQNZOkJDIPmdcSlB08DI9ji0UMpl8t9Y
         OmhpPEKAOsMyw==
Date:   Fri, 17 Mar 2023 13:03:36 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Dongxu Sun <sundongxu3@huawei.com>
Cc:     catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        wanghaibin.wang@huawei.com
Subject: Re: [PATCH 3/4] arm64/signal: Add tpidr2/za/zt sigframe size in
 comment
Message-ID: <e47440be-5dcd-4d2c-b7ff-8d45c9f82537@sirena.org.uk>
References: <20230317124915.1263-1-sundongxu3@huawei.com>
 <20230317124915.1263-4-sundongxu3@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cWaXcKvI4RHikrwN"
Content-Disposition: inline
In-Reply-To: <20230317124915.1263-4-sundongxu3@huawei.com>
X-Cookie: Life is like an analogy.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cWaXcKvI4RHikrwN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 17, 2023 at 08:49:14PM +0800, Dongxu Sun wrote:

>   *	0x8a0		sve_context (vl <= 64) (optional)
> + *	 0x10		tpidr2_context (optional)
> + *	 0x10		za_context (optional)

The size of the ZA context is variable, going with what the SVE has a VL
which might fit into the base context should be included but that's
complicated what with it likely appearing after another variably sized
frame.

> + *	 0x10		zt_context (optional)

The ZT context is never this small, it's always got register contents if
present.

>   *	 0x20		extra_context (optional)
>   *	 0x10		terminator (null _aarch64_ctx)
>   *
> - *	0x510		(reserved for future allocation)
> + *	0x4e0		(reserved for future allocation)

TBH I'm not sure this comment is actually useful or helpful, it's
already not fully taking into account the variablility of the SVE frame
size (quoting a fixed value) and with the way we allocate things once
we've gone into the extra_context we'll allocate new frames from there
so even smaller frames like the tpidr2_context will go there.  I'm not
sure trying to suggest a layout/ordering is clarifying anything for
anyone.

--cWaXcKvI4RHikrwN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQUZScACgkQJNaLcl1U
h9AmYAf/XKfjlbk9sMs+Zuvf0UQc9VSBUeozqNnGcMyC1G3FUjtE5vbZyVBrYMyk
khUCe1yMWcvOuxL1jBo5p+xUaFyp969lON8L2Kped57YTlAOhsV2wS5D7T2tvtfL
sTqb6TvLZHupCWzmqeMgsRhZCbgntD46eY3XWiJ86ebAIsknyTRBPsUvlKtQGyfZ
dWQivG/s6udXHELQo3i7IlKTVEEuwHNCG7mBS0yPvbDI9u7VyZMpFE87c0EsUs38
g4MGOTNdJ3AhZfP4wlOeMLdFfm9wisIAPCvgFzuAdmbHUXKJLspcn5lHzv99JmIL
XODhDYKSXW6wlCuG37JMObeYr6VDsQ==
=wNmx
-----END PGP SIGNATURE-----

--cWaXcKvI4RHikrwN--
