Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD2263C328
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 15:51:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233145AbiK2OvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 09:51:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbiK2OvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 09:51:17 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB141B4F;
        Tue, 29 Nov 2022 06:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1669733476; x=1701269476;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1i28Wk5Zmf2QpwRYWuzzGRuioCBIh5xXRO+2UEVDDDs=;
  b=vbQUgtwP6DiVjfoSCMUXYRjMF2BREoUAV0+Wdd+0DuseQbqOPbiddmdA
   BKIMUkdQqGn5/pfHnvZWziwXfV86xhSNFdlcSo4cH/rB1J+C1lzoZA9Uc
   1gwzLcQLPkAabXdEUear+1fG6jc+iU6DytK+dVQiB1k3Cgz9/Mx2clxbi
   Ev11uS4WJAcT7g7GTpmYGY+9BEOStE0kI9k+jf4/BTarP9PtTOoOnUUnB
   k118Uar0cJXJoBA6fbZ0OQJCINsNiyi3ei1gAnkt3Ri9AFlE+tH9lMYSP
   HJ9EILpLcdJa2/SM58Nn656BG5E5kPD0KS3iNyZLNk0VU8F5kHgAYvFMX
   w==;
X-IronPort-AV: E=Sophos;i="5.96,203,1665471600"; 
   d="scan'208";a="125626126"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Nov 2022 07:51:15 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 29 Nov 2022 07:51:13 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.12 via Frontend
 Transport; Tue, 29 Nov 2022 07:51:11 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     <linux-riscv@lists.infradead.org>
CC:     Conor Dooley <conor.dooley@microchip.com>,
        <ajones@ventanamicro.com>, <aou@eecs.berkeley.edu>,
        <conor@kernel.org>, <devicetree@vger.kernel.org>,
        <guoren@kernel.org>, <heiko@sntech.de>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-kernel@vger.kernel.org>, <palmer@dabbelt.com>,
        <paul.walmsley@sifive.com>, <robh+dt@kernel.org>
Subject: [RFC 0/2] Putting some basic order on isa extension stuff
Date:   Tue, 29 Nov 2022 14:47:41 +0000
Message-ID: <20221129144742.2935581-1-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <Y4XvnHIPw8ZuBZEk@wendy>
References: <Y4XvnHIPw8ZuBZEk@wendy>
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

RFC:
- I have not even tested this, I just did an allmodconfig
- I don't know if I re-ordered something that is sacrosanct
- I don't know if I changed all of the instances
- I didn't write a proper commit message for "patch" 2/2

With those caveats out of the way - all I did here was try to make
things consistent so that it'd be easier to point patch submitters at a
"do this order please".

I never know which of these can be moved without breaking stuff - but
they all seem to be internal use stuff since they're not in uapi?

@drew, I didn't touch the KVM ones - are they re-sortable too? My base
here is rc7 so if you did a reorder at any point there I'd not see it ;)

CC: conor.dooley@microchip.com
CC: ajones@ventanamicro.com
CC: aou@eecs.berkeley.edu
CC: conor@kernel.org
CC: devicetree@vger.kernel.org
CC: guoren@kernel.org
CC: heiko@sntech.de
CC: krzysztof.kozlowski+dt@linaro.org
CC: linux-kernel@vger.kernel.org
CC: linux-riscv@lists.infradead.org
CC: palmer@dabbelt.com
CC: paul.walmsley@sifive.com
CC: robh+dt@kernel.org

Conor Dooley (2):
  RISC-V: clarify ISA string ordering rules in cpu.c
  RISC-V: resort all extensions in "canonical" order

 arch/riscv/include/asm/hwcap.h |  6 +++---
 arch/riscv/kernel/cpu.c        | 26 +++++++++++++++++++-------
 arch/riscv/kernel/cpufeature.c |  4 ++--
 3 files changed, 24 insertions(+), 12 deletions(-)

-- 
2.38.1

