Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4914B6A030F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 08:01:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233492AbjBWHBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 02:01:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233462AbjBWHBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 02:01:23 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 454C04A1D1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 23:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=poG+9Vm8M0etfF6J8ee7t7i/YsHBs9LeiglyiBclwqI=; b=HeEIYWG+IktEw+xG+xN6elwm6P
        sMIc/dhbkU7QadGMbeCliJQJaqf1yNxRx5/Otiy7xPmZweGlbgKUTaizVptYqSRH9TXCU+EVKt0Cn
        GFAdp44TrUQTLKHa6Xt64Pq7NtINWFlL6PkCLWaZOX5OJXuOCA6s8urSB4FRI6LTYBf6K4miQ+y4l
        SshabeYRnUtV+XzzLSUpV9nLtorGjwKtdgKEHztk2S3Hn5eGFgvknle9Nff93iQYAyeaqnai9lxjd
        5b3eFPuyTFxBwqxBZMP0RGg9lGJ4hkM6AZysi3Alg02GpDt9MRQ956Qk1Pk1suVAfDQEVIX3hYqiQ
        1wfWkrDA==;
Received: from [2601:1c2:980:9ec0::df2f] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pV5bS-00FMG2-FG; Thu, 23 Feb 2023 07:01:18 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Nathan Lynch <nathanl@linux.ibm.com>,
        Roy Zang <tie-fei.zang@freescale.com>,
        Paul Mackerras <paulus@samba.org>,
        Alexandre Bounine <alexandreb@tundra.com>,
        Gerhard Sittig <gsi@denx.de>,
        Anatolij Gustschin <agust@denx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Albert Herranz <albert_herranz@yahoo.es>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Grant Likely <grant.likely@secretlab.ca>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] POWERPC: several build fixes
Date:   Wed, 22 Feb 2023 23:01:12 -0800
Message-Id: <20230223070116.660-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix multiple build errors or warnings for POWERPC.
These are mostly fixes for resource_size_t printk format warnings.
One patch is for RTAS, which requires GENERIC_ALLOCATOR.

Subject: [PATCH 1/4] clk: mpc512x: fix resource printk format warning
Subject: [PATCH 2/4] powerpc: wii: fix resource printk format warnings
Subject: [PATCH 3/4] powerpc/pseries: RTAS work area requires GENERIC_ALLOCATOR
Subject: [PATCH 4/4] POWERPC: sysdev/tsi108: fix resource printk format warnings

diffstat:
 arch/powerpc/platforms/512x/clock-commonclk.c    |    2 +-
 arch/powerpc/platforms/embedded6xx/flipper-pic.c |    2 +-
 arch/powerpc/platforms/embedded6xx/hlwd-pic.c    |    2 +-
 arch/powerpc/platforms/embedded6xx/wii.c         |    4 ++--
 arch/powerpc/platforms/pseries/Kconfig           |    1 +
 arch/powerpc/sysdev/tsi108_pci.c                 |    4 ++--
 6 files changed, 8 insertions(+), 7 deletions(-)

Cc: Nathan Lynch <nathanl@linux.ibm.com>
Cc: Roy Zang <tie-fei.zang@freescale.com>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Alexandre Bounine <alexandreb@tundra.com>
Cc: Gerhard Sittig <gsi@denx.de>
Cc: Anatolij Gustschin <agust@denx.de>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Albert Herranz <albert_herranz@yahoo.es>
Cc: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org
