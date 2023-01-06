Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0A56660946
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 23:08:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236354AbjAFWIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 17:08:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235695AbjAFWHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 17:07:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CE2F84BCB;
        Fri,  6 Jan 2023 14:07:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0669FB81C4A;
        Fri,  6 Jan 2023 22:07:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36B8AC433EF;
        Fri,  6 Jan 2023 22:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673042858;
        bh=c66oe5wybRoqWCFcVW6cGO/BKva+TgCILRvTFkO6oBk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ro7RTlMO/NV43orzBNYrUksWo3Cn21zSRcKbp3ja98pQN5zPLJ69zVkusrJWvugh1
         gjUxwPZHi/LZSKRQ4u+hdFie0EdT0gWLjlF7XfPcCnVSMnA16dFaT5Gho1dirM42HP
         DqWJ/imEK1/FPEu1iL+wN6dj0eI3OtLvY0MhE9PMmV84JKDJB1UWUT75Hhx9QxMMtv
         wj2k9URPqM/tXULZ0b/WHmcLFgolO3sSBwbWYImeya38tsuZpMTcTg9VacLXtSz95r
         N8MCM9X5YuibTPtrg++xmgHGl7VxJLBpPoaxnmlmbcwe1FYYi5XezmxLdow2m97Aj2
         /cVI1LRrhnsQA==
Date:   Fri, 6 Jan 2023 22:07:32 +0000
From:   Mark Brown <broonie@kernel.org>
To:     William Zhang <william.zhang@broadcom.com>
Cc:     Linux SPI List <linux-spi@vger.kernel.org>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        anand.gore@broadcom.com, tomer.yacoby@broadcom.com,
        dan.beygelman@broadcom.com, joel.peshkin@broadcom.com,
        f.fainelli@gmail.com, jonas.gorski@gmail.com,
        kursad.oney@broadcom.com, dregan@mail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 14/16] spi: bcm63xx-hsspi: prepend: Disable spi mem dual
 io read op support
Message-ID: <Y7ibpEw8UKKwBksD@sirena.org.uk>
References: <20230106200809.330769-1-william.zhang@broadcom.com>
 <20230106200809.330769-15-william.zhang@broadcom.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="EwWYfXXpNT8odNd5"
Content-Disposition: inline
In-Reply-To: <20230106200809.330769-15-william.zhang@broadcom.com>
X-Cookie: Do not fold, spindle or mutilate.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EwWYfXXpNT8odNd5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 06, 2023 at 12:08:06PM -0800, William Zhang wrote:
> In general the controller supports SPI dual mode operation but the
> particular SPI flash dual io read op switches from single mode in cmd
> phase to dual mode in address and data phase. This is not compatible
> with prepend operation where cmd and address are sent out through the
> prepend buffer and they must use same the number of io pins.
>=20
> This patch disables these SPI flash dual io read ops through the mem_ops
> supports_op interface when prepend mode is used. This makes sure the SPI
> flash driver selects the compatible read ops at run time.

This suggests that your prepend mode is attempting to combine
incompatible transfers doesn't it?  Presumably other devices could
generate similar access patterns...

--EwWYfXXpNT8odNd5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmO4m6QACgkQJNaLcl1U
h9BPoAf/f3LHS3QMDi/9wy02iBggh+iqTs52FZRHzluvZjiMrEUO67cD8y6jJ1Al
dd2+4cgc4J3Sz25wsLKvLuPq7KFehLVAd8n+dUlozQqoVoUBTPqZROzWiavKKfQL
j1YJE3voybTFib1zW9zHMbzevln3nsTNq33ZX+Lid6SX3Liei61SDZz2Iw3af6HW
hvnIdPlr2OEESnwr4VfnnmGM+ZGJ5jIidWsj0zAuPmb8TT39XqWOmVId0/CM+hFB
+WNHNWjHg+wzpp5s2zOJvSl9zUDjWnBJe6LM0cyM9yX9t+syv/atUJzdFDeVr/wW
+Lshri95xSSZ11akM/oxAjnSxANB8A==
=pZKP
-----END PGP SIGNATURE-----

--EwWYfXXpNT8odNd5--
