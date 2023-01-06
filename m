Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4D8F6608EA
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 22:47:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236105AbjAFVrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 16:47:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjAFVrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 16:47:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6704B12D1A;
        Fri,  6 Jan 2023 13:47:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 24ACCB81EDF;
        Fri,  6 Jan 2023 21:47:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57AFDC433D2;
        Fri,  6 Jan 2023 21:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673041637;
        bh=S5RbMSkjMYSUvEic9W15Kvy2/xK1BEwbbJpcpFh9EBI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cklrzmsgQ84R8/Wjc6mED0SgNVeYRJU9bcFLtHoR3PaPnWNKHBgDUqrdduH/KzAcD
         G0Sb6nqlppbL2DGVfAbsF8WkXofJIlN05MTjEwPJJnc2WJEjrbsjVA97i3IHRHI22h
         uOcOI3ocUkDTTVvus/oELzm3hhqc0NWh5ebmciM+MovcDzK0DTbx3o0jsnDiy/282X
         i6yLbrvzPJdAld8N8a9B71tnscCmxrA5OGbohDWpS8tS7P1rNiHeg2wKSg5QJBHIn3
         k0OmkauwtSNv/WcFlbyGnt8xECqh+fBKVwG96i2uc3olLxxCoinFSsUmxi/Yb99Nqu
         ODB7bpBn6go5g==
Date:   Fri, 6 Jan 2023 21:47:11 +0000
From:   Mark Brown <broonie@kernel.org>
To:     William Zhang <william.zhang@broadcom.com>
Cc:     Linux SPI List <linux-spi@vger.kernel.org>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        anand.gore@broadcom.com, tomer.yacoby@broadcom.com,
        dan.beygelman@broadcom.com, joel.peshkin@broadcom.com,
        f.fainelli@gmail.com, jonas.gorski@gmail.com,
        kursad.oney@broadcom.com, dregan@mail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/16] spi: bcm63xx-hsspi: Add polling mode support
Message-ID: <Y7iW38Fsj0nIewDm@sirena.org.uk>
References: <20230106200809.330769-1-william.zhang@broadcom.com>
 <20230106200809.330769-8-william.zhang@broadcom.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="BZ9YTddyDyFA6Ziq"
Content-Disposition: inline
In-Reply-To: <20230106200809.330769-8-william.zhang@broadcom.com>
X-Cookie: Do not fold, spindle or mutilate.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BZ9YTddyDyFA6Ziq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 06, 2023 at 12:07:59PM -0800, William Zhang wrote:

> Polling mode provides better throughput in general by avoiding the
> interrupt overhead as the maximum data size one interrupt can handle is
> only 512 bytes.

> When interrupt is not defined in the HSSPI dts node, driver switches to
> polling mode for controller SPI message processing.  Also add driver
> banner message when the driver is loaded successfully.

This should not be something the user selects via the DT, if the polling
mode is better then the driver should just use it regardless of there
being an interrupt wired up.  Generally there's some point at which the
benefits of polling become minimal (and the costs more impactful) but if
the DMA setup is as bad as it sounds then the driver should just ignore
the interrupt.

--BZ9YTddyDyFA6Ziq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmO4lt8ACgkQJNaLcl1U
h9BtSwf9EDCxIB7GCjjTZUo4CcwKhiubo8/b3JnQ1i23/YpKRG3de6GCFJ1NFJKw
DhOMbnblhK1hc9JJCAkK0CcDC4wkCrdXYicBxkTNCUBibzkdKwNHkjvfM8WrP9dJ
uFO3J1hFO4F0E/MQ9E5DSeIuVXXw6QXKtYmteT11umGjZhmRX1xUWH++9S2T4zse
c4c/HqoPWEElISgDKe7hyVnWmLpO1vQhPb1gkGd8NtLEv+QS3l4yV3k+qJQvHF85
bWCrWA+YT3UNag+lUlh4LfyOD8o+4i3VxcDabATMNg47nrdk/rMu3EOPXc2YIr3H
peG2shfjq2Z6KLbMf/hbqeN695vbgg==
=eHcH
-----END PGP SIGNATURE-----

--BZ9YTddyDyFA6Ziq--
