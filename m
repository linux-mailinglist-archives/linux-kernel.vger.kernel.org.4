Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24ABC7213DE
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 02:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbjFDAXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jun 2023 20:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjFDAXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jun 2023 20:23:04 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D12A19A;
        Sat,  3 Jun 2023 17:23:01 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QYcrs11C6z4x3x;
        Sun,  4 Jun 2023 10:22:52 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1685838176;
        bh=AUJ7jHGZlU1IgO9OqyJ4jwSVRZvI7dVMmKTNxQxKoeI=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=qd2YyRXsuhpUARRns0XW/38b+R1sW7dr4usqM/UPRmx59J5EK5CrM7vQ4ROSYmYcg
         4UILf3rybeo9IVOT6KNFMUY2uox4B+heOXB4A0kqAIOgjeuEv5hoc6sSy6L0B0imXg
         yVii0FpGZVB4mwB5tgEDHEANGRPnikIhFd3Waos+0a73UAszqP6EODPT49dqN4k1Lm
         h1xrxTiQJ8Hrnbb/iQp2q2vIXA3niI7q7Ls2loypcmzfXq67Vt/zY27jAKKzBNEToh
         jHuBh0k8NWaQImrEUUhu3MEr3yfCqzS6aEWGlahbygEZPNHqVtTBPNKFg/1I3KWdKE
         EuBtbBTyBoqGQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Timothy Pearson <tpearson@raptorengineering.com>
Subject: Re: linux-next: Tree for Jun 2 (arch/powerpc/kernel/iommu.c)
In-Reply-To: <2d188c87-ef34-3812-7330-a985f756d959@infradead.org>
References: <20230602140143.0af52cee@canb.auug.org.au>
 <2d188c87-ef34-3812-7330-a985f756d959@infradead.org>
Date:   Sun, 04 Jun 2023 10:22:51 +1000
Message-ID: <87h6rogjok.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Randy Dunlap <rdunlap@infradead.org> writes:
> On 6/1/23 21:01, Stephen Rothwell wrote:
>> Hi all,
>> 
>> Changes since 20230601:
>> 
>
> On powerpc64, a randconfig failed with:
>
> In file included from ../include/linux/list.h:5,
>                  from ../include/linux/preempt.h:11,
>                  from ../include/linux/spinlock.h:56,
>                  from ../include/linux/mmzone.h:8,
>                  from ../include/linux/gfp.h:7,
>                  from ../include/linux/slab.h:15,
>                  from ../arch/powerpc/kernel/iommu.c:15:
> ../arch/powerpc/kernel/iommu.c: In function 'spapr_tce_setup_phb_iommus_initcall':
> ../arch/powerpc/kernel/iommu.c:1391:36: error: 'hose_list' undeclared (first use in this function); did you mean 'zonelist'?
>  1391 |         list_for_each_entry(hose, &hose_list, list_node) {
>       |                                    ^~~~~~~~~
...

hose_list is in pci-common.c which is built when PCI=y.

PSERIES and POWERNV force PCI=y.

But this config has neither:

# CONFIG_PPC_POWERNV is not set
# CONFIG_PPC_PSERIES is not set
CONFIG_HAVE_PCI=y
# CONFIG_PCI is not set
# CONFIG_COMMON_CLK_RS9_PCIE is not set


Probably the spapr_tce code should be wrapped in an #ifdef that is only
enabled when POWERNV || PSERIES is enabled.

cheers
