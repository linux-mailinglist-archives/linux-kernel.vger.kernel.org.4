Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83FA274026E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 19:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbjF0Rm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 13:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjF0Rmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 13:42:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E84EF271D;
        Tue, 27 Jun 2023 10:42:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 81C5B611E4;
        Tue, 27 Jun 2023 17:42:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A6E8C433C0;
        Tue, 27 Jun 2023 17:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687887772;
        bh=3zgdhuyrFC6SsBoe3wLBBlLUnpWWGaTZeYQukBm5EqY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hqstb6AI4dmTpmLp8UV1hINQMfhmB5TPUy+LICqcMMged5gjIrkoAa7f4x6Nb+gOd
         9jtlPNIXII28U4IEse3/2HbILIBUlspD4Inu2lwfgIRTPI0WytXkTOLbemUIq7qNyy
         IninGIol3JiVuNEH7XThgZ7WvdeRxxtBJbNU3d8zeRvBD0oxOXLr5W8mdUETzF+LNJ
         t/bJ001R355xjR763WuxPIIcytoJALWgj7Toa3SzblqjOIwgSSPQ5k/bU4QDcGfGjB
         ASkOU8zwpC9c8O1JoAP69k6qqQ1v2WXZVPQfNYmsuuzmKvIUIRp50dsgufwqn7TfE7
         LuXVEF4CWAIsA==
Date:   Tue, 27 Jun 2023 18:42:48 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Andrew Jones <ajones@ventanamicro.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>, palmer@dabbelt.com,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Evan Green <evan@rivosinc.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 7/9] RISC-V: split riscv_fill_hwcap() in 3
Message-ID: <20230627-prevail-jurist-7de0b50f2eed@spud>
References: <20230626-provable-angrily-81760e8c3cc6@wendy>
 <20230626-prevalent-heaviness-e35188de1225@wendy>
 <20230626-0176f6ea5768a6013a7aecdc@orel>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="k6sMAfmx4wMaD7zR"
Content-Disposition: inline
In-Reply-To: <20230626-0176f6ea5768a6013a7aecdc@orel>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--k6sMAfmx4wMaD7zR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 26, 2023 at 06:17:51PM +0200, Andrew Jones wrote:
> > +void __init riscv_fill_hwcap(void)
> > +{
> > +	struct device_node *node;
> > +	const char *isa;
> > +	char print_str[NUM_ALPHA_EXTS + 1];
> > +	int i, j, rc;
> > +	unsigned long isa2hwcap[26] =3D {0};
> > +	struct acpi_table_header *rhct;
> > +	acpi_status status;
> > +	unsigned int cpu;
>=20
> I see all these unused variables get removed in the next patch, but they
> should get removed here, lest they trigger some warnings and bots come
> after you!

Funnily enough, I'd pushed this out for LKP and it never complained
about the unused variables - but my own stuff on patchwork did.

--k6sMAfmx4wMaD7zR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZJsflwAKCRB4tDGHoIJi
0lOkAQDCTj05VCKYILzRvRfUnZcGzqw9r9bdBbez5rNRofNHXgD/RSA5WAwLyGC6
k1l4a7QDIvTEug4W7pYln2cxrAAEPA4=
=RLJs
-----END PGP SIGNATURE-----

--k6sMAfmx4wMaD7zR--
