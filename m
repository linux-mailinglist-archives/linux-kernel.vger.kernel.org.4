Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA2BC6FCDDD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 20:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbjEISeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 14:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234356AbjEISeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 14:34:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7343F2716;
        Tue,  9 May 2023 11:34:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 03C84611A3;
        Tue,  9 May 2023 18:34:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ED74C433EF;
        Tue,  9 May 2023 18:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683657239;
        bh=HJ9e9VEl0w7VA2rj0PZsLjymzP7aQa2aO0mYgN6i5ZU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W8ndzo/NHgZ73cuB8D7wJMXyyMi9eG+3Ww8xiDTLg+aqo+wfwcR1QLAOao1U7TGBC
         K7EuXY2AWtXYqLBCiKcf+qgVvdfnV8qXX7HEYMp4W7ZWogBYdoEzw2/9GkvaJa5Fcl
         ORFBGzUGBKNltFswSw9wQr2Hg8291Dcn+HxdgpUto1lYfex4cyoxN5d/qn+rf7rEyK
         5ZfvKQUzCc+NS+yYqRcmOMWb9QqW9gt3PR8h708wXLRXTQmen5e8zq1X3WVBhTci1j
         hpIBxEW95QHgU5crpKfm0WbEkT1fxF2DVLa00T9uzA0RCNFR7NqzkyQl7N5+3FfV88
         WCfKAK3cq4O8Q==
Date:   Tue, 9 May 2023 19:33:53 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Evan Green <evan@rivosinc.com>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Bresticker <abrestic@rivosinc.com>,
        Celeste Liu <coelacanthus@outlook.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Jonathan Corbet <corbet@lwn.net>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 3/3] RISC-V: hwprobe: Expose Zba, Zbb, and Zbs
Message-ID: <20230509-backlands-unplug-62e4837d843a@spud>
References: <20230509182504.2997252-1-evan@rivosinc.com>
 <20230509182504.2997252-4-evan@rivosinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kjDsgYq9beFkZuRU"
Content-Disposition: inline
In-Reply-To: <20230509182504.2997252-4-evan@rivosinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kjDsgYq9beFkZuRU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 09, 2023 at 11:25:03AM -0700, Evan Green wrote:
> +		if (riscv_isa_extension_available(isainfo->isa, ZBA))
> +			pair->value |= RISCV_HWPROBE_EXT_ZBA;
> +		else
> +			missing |= RISCV_HWPROBE_EXT_ZBA;

Part of me wonders if we should just have a macro for this, since it's
just boilerplate w/ the only "variable" being the extension name.

Just a thought, and we'll have plenty more cracks at changing things
here, so:
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--kjDsgYq9beFkZuRU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZFqSEQAKCRB4tDGHoIJi
0hSEAQDCIH7muHrlaxe+6rHOQyGwsuzPXIuwwl3Icu/7bk/QVAD+LHGFXFJ1zPcN
XdCeb4P9lcmKyh7eyXbBPOlO1y/GDw0=
=mgNB
-----END PGP SIGNATURE-----

--kjDsgYq9beFkZuRU--
