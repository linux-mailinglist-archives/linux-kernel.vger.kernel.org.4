Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED4C642A98
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 15:46:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232008AbiLEOqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 09:46:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231770AbiLEOqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 09:46:17 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC2EF1B1FA;
        Mon,  5 Dec 2022 06:46:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1670251573; x=1701787573;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fNYiF1ogl3tzaX/gkv9v+1He+AojtwgLXxTo8k5gkC4=;
  b=Nv9TCsQc5jgg8O5OmVo+ipvS4H6BBva2QI8YkwtneHjis5lvKR/B0KDN
   xs+UkqWizoEyLLoP99r42BJcHiqcwC8IKotdON0/NVg3b8cvsHalS+vAh
   KefP12qNonobpXGrf9XN2saJHMGXz/WNUh6YKSXD2q16rn6vrO1XJUKY7
   QkNY1l3vH2ZNlIHOUM5TAo093gDJDUbl1p93Sxxr4RZur9eB98nbMBIwb
   wuO8u33CqBlYZS+uCV7OrOQMnOFrXQpOucUfvBB3IZ4oUZYqvTtX3jJoK
   PhnxoDsKQOuhRMTpg+L7CPCq6bYKtCeoZ6yeCf/V0tx8p6IRTmKiXkQLL
   w==;
X-IronPort-AV: E=Sophos;i="5.96,219,1665471600"; 
   d="scan'208";a="126535113"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 Dec 2022 07:46:12 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Mon, 5 Dec 2022 07:46:12 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.12 via Frontend
 Transport; Mon, 5 Dec 2022 07:46:10 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     <linux-riscv@lists.infradead.org>,
        Palmer Dabbelt <palmer@dabbelt.com>
CC:     Conor Dooley <conor.dooley@microchip.com>,
        <ajones@ventanamicro.com>, <aou@eecs.berkeley.edu>,
        <conor@kernel.org>, <corbet@lwn.net>, <guoren@kernel.org>,
        <heiko@sntech.de>, <paul.walmsley@sifive.com>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: [PATCH v2 0/3] Putting some basic order on isa extension lists
Date:   Mon, 5 Dec 2022 14:45:23 +0000
Message-ID: <20221205144525.2148448-1-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For v2+, I added another path with some uapi docs & switched to Drew's
suggested ordering of alphabetically, except in the /proc/cpuinfo array,
as per the discussion today in the pw-sync call. I also added a
sprinkling of comments around which things should be sorted in which
way.

Pasting from the chat on v2, since it's relevant to whether re-ordering
what appears in /proc/cpuinfo is even permitted..

I wrote:
> Drew wrote:
> > My biggest concern is how much we need to care about the order of the
> > string in proc and whether or not we're allowed to fix its order like
> > we're doing with this patch. I hope we can, and I vote we do.
>
> Being a bit hard-nosed about it:
> - the spec has said for years that this order is not correct
>
> - their parser cannot assume any given extension is even present, so the
>   index at which the extension starts was only ever going to vary wildly
>
> - to break a parser, it must expect to see extension Abcd before Efgh &
>   that order has to change for them
>
> - expecting that a given pair of extensions that appeared one after
>   another would always do so is not something we should worry about
>   breaking as it was always noted in the comment (and by the specs?)
>   that new extensions would be added in alphabetical order (I'd like to
>   think that if a clairvoyant wrote a parser and knew that there'd be
>   nothing in the gap between the extensions we have now & what may be
>   produced they'd also account for this re-ordering...)
>
> - the re-order of sstc is going to land for v6.1 & the addition of sstc
>   out of order landed in v6.0, so either that is an issue too or this is
>   fine

I'm sending the patchset, so I think it's bordering on obvious that I
think doing this is likely okay & maintaining a "strict" interpretation
of what the spec says is the way to go.

I think the only case we have to worry about breaking uABI stuff is if
this changes behaviour in a way that could not be done by an otherwise
valid change in the ISA string, so bullet 3 above.

I'll leave that determination up to the Higher Powers, but I think it's
going to be very difficult not to accidentally break this order in the
future if we decide that what is currently there, must remain exactly
as-is.

Thanks,
Conor.

Changes since v1:
- strengthened some wording to use "must"
- reworded the bits in both code & doc about what canonical order is
- added some missing "... must be in alphabetical order" sections to
  both code & doc
- forced an _ before multi-letter extensions
- there's likely a trivial conflict with drew's addition of an assert
  for RISCV_ISA_EXT_ID_MAX.

CC: ajones@ventanamicro.com
CC: aou@eecs.berkeley.edu
CC: conor@kernel.org
CC: conor.dooley@microchip.com
CC: corbet@lwn.net
CC: guoren@kernel.org
CC: heiko@sntech.de
CC: palmer@dabbelt.com
CC: paul.walmsley@sifive.com

CC: linux-kernel@vger.kernel.org
CC: linux-riscv@lists.infradead.org
CC: linux-doc@vger.kernel.org

Conor Dooley (3):
  RISC-V: clarify ISA string ordering rules in cpu.c
  RISC-V: resort all extensions in consistent orders
  Documentation: riscv: add a section about ISA string ordering in
    /proc/cpuinfo

 Documentation/riscv/uabi.rst   | 42 +++++++++++++++++++++++++++
 arch/riscv/include/asm/hwcap.h | 12 ++++----
 arch/riscv/kernel/cpu.c        | 53 ++++++++++++++++++++++++----------
 arch/riscv/kernel/cpufeature.c |  6 ++--
 4 files changed, 91 insertions(+), 22 deletions(-)

-- 
2.38.1

