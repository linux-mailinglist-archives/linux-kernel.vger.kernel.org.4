Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E40563E5A6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 00:42:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbiK3XmE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 18:42:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbiK3XmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 18:42:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31AE24B761;
        Wed, 30 Nov 2022 15:41:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C08EDB81D75;
        Wed, 30 Nov 2022 23:41:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11DB1C433D7;
        Wed, 30 Nov 2022 23:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669851716;
        bh=eiDyEPrPFONwuiVxz0Bl5Re71qAslT/jb7BX8jhuC4E=;
        h=From:To:Cc:Subject:Date:From;
        b=nGGP8AlviNIGy6DUe4KSoJIk14WQ0lGfsC7QD87q7uSkk74mPS/lE72vj/72ZRYfV
         YT+6/KwXJ9HmJkBWyfBIcorfnPPGneT0mvB6CwzpkaIx98QGjsAvMU2ODOaOHHTghB
         bomhVG8ZIwQMpqE9rGROXa44Lcgxv/jnEB6bHywQw9lHO77qSvIjO/+/kI2fj6SgLk
         ZTufMqnY3Ubw7X6uZNVjRvXYEouyllsZlKb/irw2lpvVnE2LMuQ2EYZ9SwG48vDcek
         v8GUxsC2JMuh+IEVGwYHlsfizOdfcO6R38/bQjmXAyF6DQFxWQkIAR/8rnr68c3p1X
         wM2iVPWXxOT+w==
From:   Conor Dooley <conor@kernel.org>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org
Cc:     Conor Dooley <conor.dooley@microchip.com>, ajones@ventanamicro.com,
        aou@eecs.berkeley.edu, conor@kernel.org, corbet@lwn.net,
        guoren@kernel.org, heiko@sntech.de, paul.walmsley@sifive.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH v1 0/3] Putting some basic order on isa extension lists
Date:   Wed, 30 Nov 2022 23:41:23 +0000
Message-Id: <20221130234125.2722364-1-conor@kernel.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

I don't know for sure that I have not re-ordered something that is
sacrosanct. It seems that all of these are internal use structs, and
should be okay, barring the obvious exception of the, intentionally
re-ordered, isa_ext_arr.

With that caveat out of the way - all I did here was try to make things
consistent so that it'd be easier to point patch submitters at a "do
this order please".

I never know which of these can be moved without breaking stuff - but
they all seem to be internal use stuff since they're not in uapi?

For v2, I added another path with some uapi docs & switched to Drew's
suggested ordering of alphabetically, except in the /proc/cpuinfo array,
as per the discussion today in the pw-sync call. I also added a
sprinkling of comments around which things should be sorted in which
way.

I guess consider this an RFS, with the S being Screaming in the case of
me doing something you abhor :)

Thanks,
Conor.

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

