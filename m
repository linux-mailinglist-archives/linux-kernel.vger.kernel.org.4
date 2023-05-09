Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49FD46FC926
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 16:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235698AbjEIOhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 10:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234758AbjEIOhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 10:37:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F18CDE56
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 07:37:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 768F9646CB
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 14:37:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D119C433EF;
        Tue,  9 May 2023 14:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683643019;
        bh=vpobpJmD2PRTdK1kFeukPqy706kubskVlykD91dgbyA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JX+7P8OmYI3ocXlnLhmDPDlVH5bI0X9Z2AAHjsU3g9dNsFUF8mp8ZnDHIJ0ulD4At
         YZWaI/YqULzaVS0y8sdfQ4hFMxlJhi0NrQkBTIIXB6NaODxBM6ZZ9oUpQonZ9r0wZ0
         TFDAUn1pisiOH1Ac9izlO8VyAfJIw3YJJS+BjV/TxZq/kqmuReqy0PWIo4ZsPhWnwt
         kAmRxSdoLJd8DfUPYgRLXnRH7NMV6UqHHiiazb/eD+TUOcWyI/21OvXhqjDDZ5Uiv8
         OdnSMs3ZuUL9yeOIf2yXr+OVGF3FHM0EWqrJXZlWcjBxQ56KbPNFec1YclJXhbgG8D
         CMNN/w2EjvQvQ==
Date:   Tue, 9 May 2023 23:36:56 +0900
From:   Mark Brown <broonie@kernel.org>
To:     Ravulapati Vishnu Vardhan Rao <quic_visr@quicinc.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "moderated list:QCOM AUDIO (ASoC) DRIVERS" 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC:codecs: lpass: Fix for KASAN use_after_free out of
 bounds
Message-ID: <ZFpaiBs19P2m2i/q@finisterre.sirena.org.uk>
References: <20230509103232.20953-1-quic_visr@quicinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rp6eN0jACiHvaET+"
Content-Disposition: inline
In-Reply-To: <20230509103232.20953-1-quic_visr@quicinc.com>
X-Cookie: Avoid contact with eyes.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rp6eN0jACiHvaET+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 09, 2023 at 04:02:31PM +0530, Ravulapati Vishnu Vardhan Rao wrote:

>  	val = ucontrol->value.enumerated.item[0];
> +	if (val < 0 && val > 15)
> +		return -EINVAL;

Srini is right that it'd be better to read the upper bound from the
control, that way it can't geto out of sync.

--rp6eN0jACiHvaET+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRaWocACgkQJNaLcl1U
h9DFwwf+OGbDrdaAcrzv8y4tkJVfYVW0CN+Vi2I9TmTYkFz4yMuHLYz4/+Lqrqvb
VwxCESut40IbIG923f8kXLHI1ZLyMYZYfijCjhozfmIMwq+4IDclDAVN7X1nsSl9
U/AlK2kQ1E4hS2TLLqUgno9doE3EFXgJuKCfwT6AAWIK+T169fN3dXTlFT7SeTcP
OO+qkTftBiuYGKMW7hMZCvcOnw7lhgso2MP6iFVSZGHr67rB84cNOvgJ4og6J90U
+2wOn5Xdw4KepnGGOFl7uD8B5XbTeva3ooOEkkRDa+oEZ/L6VmvsnQm30N+iC935
xuGsCPLEIwrsj9V571lsqHei093EBw==
=QfcG
-----END PGP SIGNATURE-----

--rp6eN0jACiHvaET+--
