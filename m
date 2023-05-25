Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49DAE710D5A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 15:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240749AbjEYNig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 09:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241201AbjEYNie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 09:38:34 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3051AE4E
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 06:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1685021898; x=1716557898;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7/MPnMSTTqvi1h2V28m7HvVkRafCnNib35+NgbBtu4I=;
  b=iUqrv4dJh4xPsLSq1R5ptPyeXBmfArWU3yNjjUhb6am12g08fbUMQ2id
   Qxs5m1r680A7Xq8VcAK3xv2WljMpBKk115ox9jnYG4AqVovOD5vPFGzNY
   2a1bUiOlWaqVHGATO4TdsNgIQtzaBB6ArTGpc1R70/sMfOg3Q21HnpVsp
   zuqkSOWpbkfoxnwfMys50g9PWnOUAx9Bv4p7kqpAPo63zy/rolR6H0xBM
   obrqoDgJ0UXD+2Ly79NpvwZdBa39Xjn0uCoe0VpUq9VKkLBxsOVlE+fUl
   /OoSFuLUW4MNR8LQXRTd72/mK0DqgnmsKTDgY3TPTsh704snonIovB5E3
   w==;
X-IronPort-AV: E=Sophos;i="6.00,191,1681196400"; 
   d="asc'?scan'208";a="153913613"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 May 2023 06:38:08 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 25 May 2023 06:38:08 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Thu, 25 May 2023 06:38:05 -0700
Date:   Thu, 25 May 2023 14:37:43 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Anup Patel <apatel@ventanamicro.com>
CC:     Atish Patra <atishp@atishpatra.org>,
        Alexandre Ghiti <alex@ghiti.fr>, <robh@kernel.org>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        <jeeheng.sia@starfivetech.com>, Anup Patel <anup@brainfault.org>,
        <linux-kernel@vger.kernel.org>, <palmer@rivosinc.com>,
        <leyfoon.tan@starfivetech.com>, <mason.huo@starfivetech.com>,
        Guo Ren <guoren@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Song Shuai <suagrfillet@gmail.com>,
        <linux-riscv@lists.infradead.org>,
        Andrew Jones <ajones@ventanamicro.com>
Subject: Re: Bug report: kernel paniced when system hibernates
Message-ID: <20230525-postnasal-monopoly-98adb96ffaa1@wendy>
References: <CAHVXubgse4Lw7ucg52FkQW4c=QrNo56BXsRZ_nkCHAAPxUXUig@mail.gmail.com>
 <CAHVXubj92O_dwGShOJgrYezqk2pA2NtFyhNFbAPyhn7=PztK6Q@mail.gmail.com>
 <20230517-preacher-primer-f41020b3376a@wendy>
 <CAHVXubhMLgb54_7zV2yFuGPoMKCkUXwozHbDvghc7kQqNLK-JA@mail.gmail.com>
 <CAAhSdy3tKAk1xjinwnSWan0ivdDapcLvSb+hGNynPFZMUsoB9A@mail.gmail.com>
 <fe8d716c-fb4f-1f3f-6c69-de1d8b9fb6af@ghiti.fr>
 <CAK9=C2X1BjZCHfYM33pZQtavu7yRqxwsypWL5OWj79bJrnDMQg@mail.gmail.com>
 <CAOnJCULpa-TJuG=TtCDOxOdUviZzWheLE-GMiU1r7GWaKn0nuQ@mail.gmail.com>
 <20230525-guacamole-swimmer-68048a73baac@wendy>
 <CAK9=C2WUyLxZwQO37cN-i+V+A3yxmEoaj=uE8yR8nseYTDW7oQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="JrOGZxtEPS2oo1aX"
Content-Disposition: inline
In-Reply-To: <CAK9=C2WUyLxZwQO37cN-i+V+A3yxmEoaj=uE8yR8nseYTDW7oQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--JrOGZxtEPS2oo1aX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 25, 2023 at 06:51:28PM +0530, Anup Patel wrote:

> > We should only rely on this node name for known bad versions of opensbi
> > IMO. Going forward, if something needs to be reserved for firmware, the
> > firmware should make sure that it is reserved by using the property for
> > that purpose :)

> There is no issue with OpenSBI since it does the right thing by marking
> memory as reserved in the DT. This real issue is with the kernel handling
> of reserved memory for hibernate.

I don't think we are talking about the same thing here. I meant the
no-map property which OpenSBI does not set.

> Like Atish mentioned, not just OpenSBI, there will be other entities
> (like TSM) or some other M-mode firmware which will also reserve
> memory in DT/ACPI so clearly kernel needs a SBI implementation
> independent way of handling reserved memory for hibernate.

> > > Another option is to use compatible string or label property to indicate
> > > that this memory region is not to be saved/restored during hibernation.
> > > This can be documented in RISC-V DT bindings as well as the booting guide
> > > doc that alex was talking about.
> >
> > Sure, a dt-binding for sbi reserved regions doesn't immediately sound
> > like an awful idea... But we still have to work around the borked
> > firmware - be that disabling hibernation or using the mmode_resv node
> > when we know that the version of OpenSBI is one of those with the
> > problem.

Did you skip over this? I was agreeing that defining a common binding for
sbi reserved regions was a good idea.

--JrOGZxtEPS2oo1aX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZG9kpwAKCRB4tDGHoIJi
0p+GAQCn1Y7yJhVNQl0WAf2V+rgtzqGw5oM5zSzgGijoW2F4KQD/X+ycRbX3wKqC
IsL+AdtJs3lRjPV4gheoUkWsJcmvAA8=
=S5k1
-----END PGP SIGNATURE-----

--JrOGZxtEPS2oo1aX--
