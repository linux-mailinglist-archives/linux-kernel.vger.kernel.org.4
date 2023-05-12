Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B49A6FFF83
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 06:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbjELEDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 00:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjELEDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 00:03:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87075E2
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 21:03:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 160C063E6C
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 04:03:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4C0DC433D2;
        Fri, 12 May 2023 04:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683864180;
        bh=4Hv121P/Sj7BAXfRRl37k5PAP4WfnZcp1qJTu0V6SHM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JXHmw7X4NKI6lI1CauY30/ZJlDt+MSyrUDC0CJfgUFRotKK6WtmHMFeGz4hcX/kVH
         NoGceq1udwIkzPl1NalO7xaD+Ecd30aC1v0lLmLSGzzjRJ90ewtlVq/CqoK/uuE1jj
         55yCmzzl/e5YjZLH6C/57hrCzBNJ64aNxfW1hpK0gVHqktDuZL6OO/Qh3Nr9Z/u40m
         xs/A38ElRpSPBabXGYmGGgbKrjhMk0VBPtvyogPGdAntoV+81A3UJfIzzZXOIrbs/F
         9uq94IlVnUzmWFD0o6+z+lbDK63SvVfMVBp/jDEZnFdI0dTqGAn3LyY0g9oEixD79r
         yz8JGOxMJLqjw==
Date:   Fri, 12 May 2023 13:02:57 +0900
From:   Mark Brown <broonie@kernel.org>
To:     Kristina Martsenko <kristina.martsenko@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 11/11] kselftest/arm64: add MOPS to hwcap test
Message-ID: <ZF24SVYq27LKOwmW@finisterre.sirena.org.uk>
References: <20230509142235.3284028-1-kristina.martsenko@arm.com>
 <20230509142235.3284028-12-kristina.martsenko@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="CXfWWGf7Bizbf7PV"
Content-Disposition: inline
In-Reply-To: <20230509142235.3284028-12-kristina.martsenko@arm.com>
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


--CXfWWGf7Bizbf7PV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 09, 2023 at 03:22:35PM +0100, Kristina Martsenko wrote:
> Add the MOPS hwcap to the hwcap kselftest and check that a SIGILL is not
> generated when the feature is detected. A SIGILL is reliable when the
> feature is not detected as SCTLR_EL1.MSCEn won't have been set.

Reviewed-by: Mark Brown <broonie@kernel.org>

> +	/* CPYP [x0]!, [x1]!, x2! */
> +	asm volatile(".inst 0x1d010440"
> +		     : "+r" (dstp), "+r" (srcp), "+r" (size)
> +		     :
> +		     : "cc", "memory");

Verified against DDI0602 2023-03.

--CXfWWGf7Bizbf7PV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRdunAACgkQJNaLcl1U
h9CmZggAhHA/CXsC6+GZWboyNKrPZpCGcROekjNW7m2iVobs1ar0sgZ6VZ7TIgFv
e9T9qiGV1uja3u/kEukTwTHjjSsye7NwxraWPNNxe6eVndkrLk32PTYtoZSDNvfN
jede3PKmUxWvrK7zWcQSXMImm+PJEEZ+gIzhS5WJ1AyZBfXX5yud1J5k99GKM/MK
l7mKLH/G5Dj/NqHWntDUXisUP07TIVOlOs+FDJ1I2LOsocJ52mPPwwaq0GcugmP7
0eLItzCseg9bNc3tKb/wA+AvYt3uTlwcIFq88VTDglllC5B52FWqqUU2NT6uiD3s
hXORHP7fG9furKNaLPf3yk7SlWuPxw==
=6yHa
-----END PGP SIGNATURE-----

--CXfWWGf7Bizbf7PV--
