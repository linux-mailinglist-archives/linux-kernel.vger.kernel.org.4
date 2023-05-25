Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09B3A710C93
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 14:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241152AbjEYM4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 08:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241058AbjEYM4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 08:56:33 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DB3210C6
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 05:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1685019365; x=1716555365;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dCZ7qHilHCnoBJIJpLO6SCWRxEDx/w1XHLVY79Vbh/c=;
  b=u0MBOBtkuAPnrIMdkANJC/k3+86JlJNvlBNNapUe2WQf/o2D80fkp+nU
   9wO3eSnE3ydFnkXARaQLG/gVJ/SsPzY5MYFd6Q2ySSg3OkdWlm5LhY8qV
   T7wAKhR4ZBj9LtR66fnJdUBdfEbUDjcvkrMmG//kM2LbB0Hrafyb9CZJ7
   +pEo56GLa2Lgz4ucEnTPEebMA1ye0GNdz7QrKJA/QR593Mytx6Zy+PBPy
   NrIJMcPtqDw0L/1S7MVVHFaZzK8m1hraTWsNNTlvqK8dnDjkwahmnpd4u
   jIxG0V6UfljBsa+W4sW/OjXKalEFWUqAHMpLeeaQNOQbvw4kEVLjo4vqS
   g==;
X-IronPort-AV: E=Sophos;i="6.00,191,1681196400"; 
   d="asc'?scan'208";a="217254719"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 May 2023 05:56:02 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 25 May 2023 05:56:01 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Thu, 25 May 2023 05:55:59 -0700
Date:   Thu, 25 May 2023 13:55:37 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Atish Patra <atishp@atishpatra.org>
CC:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        Anup Patel <anup@brainfault.org>,
        Song Shuai <suagrfillet@gmail.com>, <robh@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>, <palmer@rivosinc.com>,
        <jeeheng.sia@starfivetech.com>, <leyfoon.tan@starfivetech.com>,
        <mason.huo@starfivetech.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Guo Ren <guoren@kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <regressions@lists.linux.dev>
Subject: Re: Bug report: kernel paniced when system hibernates
Message-ID: <20230525-geologist-cottage-a51fa889a3d0@wendy>
References: <CAHVXubgse4Lw7ucg52FkQW4c=QrNo56BXsRZ_nkCHAAPxUXUig@mail.gmail.com>
 <CAHVXubj92O_dwGShOJgrYezqk2pA2NtFyhNFbAPyhn7=PztK6Q@mail.gmail.com>
 <20230517-preacher-primer-f41020b3376a@wendy>
 <CAHVXubhMLgb54_7zV2yFuGPoMKCkUXwozHbDvghc7kQqNLK-JA@mail.gmail.com>
 <CAAhSdy3tKAk1xjinwnSWan0ivdDapcLvSb+hGNynPFZMUsoB9A@mail.gmail.com>
 <20230518-mobilize-dipper-051dfbc41971@wendy>
 <CAHVXubhpkkC_1sYkHJvjuHB24YhmHJJ_ZvjRhzaqvygCvfbRnw@mail.gmail.com>
 <20230518-cauterize-game-636a6aac4871@wendy>
 <CAHVXubgsHKfNaRgvXT0A=7cnnCMrZMrpvxEGrGobcytuFCsLKQ@mail.gmail.com>
 <CAOnJCUJQdZZ3kT099Z6gcj+A4fP7ste3dC9QZ8G-2XH7x8DL7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="EuBXBxH8HufsmTdu"
Content-Disposition: inline
In-Reply-To: <CAOnJCUJQdZZ3kT099Z6gcj+A4fP7ste3dC9QZ8G-2XH7x8DL7A@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--EuBXBxH8HufsmTdu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 24, 2023 at 04:53:59PM -0700, Atish Patra wrote:

> We can also just revert the commit
> 3335068 ("riscv: Use PUD/P4D/PGD pages for the linear mapping")
> until a proper solution is available.

I'm actually inclined to go the other day. If hibernation never works
in a released kernel we can't regress it & since we have not settled on
a fix for this yet we don't know whether the fix would then remove
support for hibernation where it used to work.

> IIRC, Alex also suggested the same as there is no measured benefit
> with this patch.
> It is good to have 1GB huge page mappings but it can be delayed until
> we have the fix
> for the hibernation issue.

IIRC it was the 1 GiB hugepages that Alex said were ~worthless.

--EuBXBxH8HufsmTdu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZG9ayQAKCRB4tDGHoIJi
0omaAQCH/7SukuDl3+/+zFpazVIYawnJQLDQEWojXquLnpT64wEAkbYHuYdzDL6j
tQEJ/P7KA9+4KSfH/xw6FR5eL0MWowg=
=00Gl
-----END PGP SIGNATURE-----

--EuBXBxH8HufsmTdu--
