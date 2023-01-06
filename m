Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49042660936
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 23:02:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236699AbjAFWBz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 17:01:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236693AbjAFWBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 17:01:11 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 351DF848E2;
        Fri,  6 Jan 2023 14:00:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 80B90CE1E6D;
        Fri,  6 Jan 2023 22:00:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50C46C433EF;
        Fri,  6 Jan 2023 22:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673042453;
        bh=nY98X/gx6KdA7uOLij50iqYabHvIksPSbU47iL15GCk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LVSEz8npgVEzW/6ZhgEBmyJlBraMWVJelVMT/C0CrxIOdzmNJl8lvGKUXuRc1DmXc
         6uB038RuiDYugVZeiT/I6vmzWknWXmJqvMdk3JJaq37AD0WbfvRjSa6SYd1VkICZvA
         coRBF/pWNUx9OR10Y67++CUXZIVhgqhXBkden9lzD+YYXNrcjtiXjXZYgUYMNA8h1X
         F6sgeTVfp7XhhyneKZp4D0o3aioc0JiwvMBgiqNHl0NgJoH4phSD0wUYLMto73AL50
         U2J23VEgFqgPrxhCSA3nPfqqAykGPoYjdJzLq5VPWzvZCDmiGscvv+DHdIXIMDjDXL
         XcI99nmPUu1zA==
Date:   Fri, 6 Jan 2023 22:00:48 +0000
From:   Mark Brown <broonie@kernel.org>
To:     William Zhang <william.zhang@broadcom.com>
Cc:     Linux SPI List <linux-spi@vger.kernel.org>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        anand.gore@broadcom.com, tomer.yacoby@broadcom.com,
        dan.beygelman@broadcom.com, joel.peshkin@broadcom.com,
        f.fainelli@gmail.com, jonas.gorski@gmail.com,
        kursad.oney@broadcom.com, dregan@mail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/16] spi: bcm63xx-hsspi: Add prepend feature support
Message-ID: <Y7iaEOBP4TRBoDYy@sirena.org.uk>
References: <20230106200809.330769-1-william.zhang@broadcom.com>
 <20230106200809.330769-12-william.zhang@broadcom.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="03fzSve1xfjNt8Ya"
Content-Disposition: inline
In-Reply-To: <20230106200809.330769-12-william.zhang@broadcom.com>
X-Cookie: Do not fold, spindle or mutilate.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--03fzSve1xfjNt8Ya
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 06, 2023 at 12:08:03PM -0800, William Zhang wrote:
> Multiple transfers within a SPI message may be combined into one
> transfer to the controller using its prepend feature. A SPI message is
> prependable only if the following are all true:
>   * One or more half duplex write transfer
>   * Optional full duplex read/write at the end
>   * No delay and cs_change between transfers

There is nothing driver specific here, this should be implemented in the
core - we have existing logic to rewrite messages to match driver
constraints, this could be added there possibly with flags to allow
drivers to disable or enable the merging if they've got special
requirements.

--03fzSve1xfjNt8Ya
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmO4mg8ACgkQJNaLcl1U
h9ACJwf/UE1spDfA2xj1/PcQ+u3EwHKl083wfkb2q6wwMJqDHkKLmUA4U8gD5dU8
/vZWPViLit19LVtn/P/v7n4yhwR4iks3mYnQKcvV9s88QKsuoY1hgfi4362VdbKf
bqciz2t2WhxEu1eGFjYpdEazyEHH+OkzFJDIGgdsYM+s1CLq1R1PCIPB3KFeIopW
5N2gk+83IHLPqNvHp5RM+fdU5kPv6tKLtcAoJO+0eI1HvOGs25Cp7wI7hgtOSR+V
XozRJNL3Nd9TYjvIGJvatNMWACBZ5Xo7h9GHhVxUWNzWvJk5g8GmTvRJS97rBQOT
5WgghfpwqkekaGIzRkCHfjEx4LFs6w==
=M+9u
-----END PGP SIGNATURE-----

--03fzSve1xfjNt8Ya--
