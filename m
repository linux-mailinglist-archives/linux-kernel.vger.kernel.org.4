Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C6A574B516
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 18:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbjGGQY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 12:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjGGQY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 12:24:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E27B52105;
        Fri,  7 Jul 2023 09:24:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 66D56618AC;
        Fri,  7 Jul 2023 16:24:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01BD8C433C8;
        Fri,  7 Jul 2023 16:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688747064;
        bh=JiJ8kNxz3/HpazNJ8ioPGb1K6xlXCETCdg30qMkBbz4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AiXZbzsg2zICBlBbDLWe42a5CRX7EW5wt69pcoJixEeZ2PfMK14Fr4EfGz0RQUTQy
         eiNTNL0ZQTaKVw8xtIS/HBAA4KKCtMStJ7NE57XlKZcu/W56KoiPKQV1yJf3YbVDp9
         Q3JA9vFra9At1fldIaWNfxer483Wrk9AwmG4ksnAm+o/tIWFqA4KBLN19J4Vf4oDdU
         zRxBcCsTZVVBzcQG9mw5CKGK4u+QJH4Z6lQQEvbuZ5sc2MiMWVcHIVtWw9jCBCDPbT
         2yaVFYtwubI+86g/9+mM7A5KYNJmitai/p/GMhdu7tyHXjEa8n/Uy5GlwC2rsZPmau
         3xpTcqNFSr/Kg==
Date:   Fri, 7 Jul 2023 17:24:17 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Dong Wei <Dong.Wei@arm.com>
Cc:     =?utf-8?B?6JGb5aOr5bu6?= <geshijian@bytedance.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        ron minnich <rminnich@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        "cuiyunhui@bytedance.com" <cuiyunhui@bytedance.com>,
        "jrtc27@jrtc27.com" <jrtc27@jrtc27.com>,
        "kernel@esmil.dk" <kernel@esmil.dk>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Mark Rutland <Mark.Rutland@arm.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "yc.hung@mediatek.com" <yc.hung@mediatek.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "allen-kh.cheng@mediatek.com" <allen-kh.cheng@mediatek.com>,
        "pierre-louis.bossart@linux.intel.com" 
        <pierre-louis.bossart@linux.intel.com>,
        "tinghan.shen@mediatek.com" <tinghan.shen@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "weidong.wd@bytedance.com" <weidong.wd@bytedance.com>
Subject: Re: [External] Re: [PATCH v3 0/4] Obtain SMBIOS and ACPI entry from
 FFI
Message-ID: <20230707-emboss-fridge-83a0a4e2574d@spud>
References: <CAMj1kXFZren0Q19DimwQaETCLz64D4bZQC5B2N=i3SAWHygkTQ@mail.gmail.com>
 <mhng-b66b085a-eb15-4c9b-b2aa-93ddf16ec7aa@palmer-ri-x1c9a>
 <CAP6exYKwZG=_47r0jAUFYNL5-P-SS==k6vWdKiMJ9nB0upH5Zw@mail.gmail.com>
 <20230707-attach-conjuror-306d967347ce@wendy>
 <ZKfsSsdiso0W8mW6@sunil-laptop>
 <CAN3iYbMhQU5Ng4r6_rQDnLmit1GCmheC5T49rsUP5NgHFEXsHA@mail.gmail.com>
 <ZKgLKvBoWKSxzm6r@sunil-laptop>
 <CAN3iYbOe+i4jVhz0sSQwVQ2PMB7UvaTPyN_sLtZj0uiOD2emDA@mail.gmail.com>
 <20230707-gargle-enjoyable-f9f7f87fc7ea@spud>
 <DBAPR08MB5783AED8329E38D840B7015D9C2DA@DBAPR08MB5783.eurprd08.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="19TBS58esfdODHKA"
Content-Disposition: inline
In-Reply-To: <DBAPR08MB5783AED8329E38D840B7015D9C2DA@DBAPR08MB5783.eurprd08.prod.outlook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--19TBS58esfdODHKA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 07, 2023 at 04:21:17PM +0000, Dong Wei wrote:

> If you are going to keep arguing this, please stop sending top-posted
> HTML to the mailing list. It makes it impossible for those not in the CC
> list to follow along.

Please read the mail you are replying to.

> IMPORTANT NOTICE: The contents of this email and any attachments are
> confidential and may also be privileged. If you are not the intended
> recipient, please notify the sender immediately and do not disclose
> the contents to any other person, use it for any purpose, or store or
> copy the information in any medium. Thank you.

Now deleted, thanks.

--19TBS58esfdODHKA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZKg8MQAKCRB4tDGHoIJi
0tkhAP44T/tUEj+Vr0rQElYhVPyNR629QXJKrl0iKhbhz89W5QD/QqbU95A3ezAa
TTcmbxmj8ehhl9D6q/LUOdmIb1saCQA=
=RX3H
-----END PGP SIGNATURE-----

--19TBS58esfdODHKA--
