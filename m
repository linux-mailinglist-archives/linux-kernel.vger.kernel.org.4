Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B118B6B7221
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 10:10:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbjCMJK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 05:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231270AbjCMJJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 05:09:56 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C23F81F93B
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 02:08:57 -0700 (PDT)
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 2257B3F17A
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 09:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1678698536;
        bh=+zLoqF6BfOdUSle6q2rHxZJA0reMzMkFf8cRs0TMdRQ=;
        h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type;
        b=fMOwdmfUBbTRo5135EZxEKjw9rbVkPWydX4ihArwN5XOyOJHgcPKwQ8vzCBefwyAo
         4llscZoosjuF+apGm30LTltKubdMcV0z4sFFQ/PkUHny4p9rYZoAwWpFwQ/IUaO7zD
         cMh4uSClLbkw112W+ptFfICsHjdBuyfMBLsFMSJzZ2fNgKA/ieWUPvoKz9p2OeLSYi
         YDs/q92CSW6SpWN+yhT1UyxQ569QDBjlq7C7IBTQJoyUSNMxbUPgqoTNEVp8r+6wnI
         FKoCpdELm5wE9g1cwZ1JWbw6PU+ZRHdNWLjADpbYPdKvYLE/po6EBJ2Z68dH6mLfVU
         BqWTJVmMkbzgA==
Received: by mail-ed1-f71.google.com with SMTP id p36-20020a056402502400b004bb926a3d54so15863740eda.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 02:08:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678698535;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+zLoqF6BfOdUSle6q2rHxZJA0reMzMkFf8cRs0TMdRQ=;
        b=xKPqmrzUveNXVFZLpJ0BeD69KumgqWIjGofB+3gsJRhTuDaU/+Xe5srvBG5WrlFMd/
         Mk1nNCAJ/IsXaMHlTOOznQ2JQDB79BqY78EEPCWyUsvFteFSRjZVKh7CG9G7mVA3DbxP
         eWK7PxXG1Pz4Gs/p3CumjI+FAMCUxQ473HriE48abxMOHsaSf/UF6FJa/aTw22l4J/Kh
         bkAA3+p9cyUxxgtPyiEsQ3/6XEIJeLQNa0odY6uU+sgXdGM/VVF2vdCjc9ODEAukOwsi
         d3REnsxNpY7i49aj7eqO7C91nrSFqOno+qhoHcxj/AGK/lPkjSM2JJhbDYomkkG4hVi0
         VK8g==
X-Gm-Message-State: AO0yUKV6Y4ts+wsdQNTLSsIt7ckIHzbvsz4s2Inm1F/FD/VIjxCkIm3t
        zdyg+WDzp5NYgeDgUqTo6dlHlJ5VvAbPrTuHF1F2s1p5CUAfVUkPhGmr34h9eQsrmIDCWzCnKBs
        +CVZ4FYUNEN3spZQT/8p7uZhjEBPsHGvIy3ws5y8FsA==
X-Received: by 2002:a17:907:3fa6:b0:877:a9d2:e5e9 with SMTP id hr38-20020a1709073fa600b00877a9d2e5e9mr43351032ejc.42.1678698535565;
        Mon, 13 Mar 2023 02:08:55 -0700 (PDT)
X-Google-Smtp-Source: AK7set8zaIoGIKt5CAbGfpbiLF+2JUW2fmQCY3xX2N3r1L5GI3QhgID5iSiMfAUqw3n4GDt4lI95/w==
X-Received: by 2002:a17:907:3fa6:b0:877:a9d2:e5e9 with SMTP id hr38-20020a1709073fa600b00877a9d2e5e9mr43350998ejc.42.1678698535272;
        Mon, 13 Mar 2023 02:08:55 -0700 (PDT)
Received: from localhost (host-79-53-23-214.retail.telecomitalia.it. [79.53.23.214])
        by smtp.gmail.com with ESMTPSA id ox29-20020a170907101d00b008e53874f8d8sm3157668ejb.180.2023.03.13.02.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 02:08:55 -0700 (PDT)
Date:   Mon, 13 Mar 2023 10:08:54 +0100
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Oleg Nesterov <oleg@redhat.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: boot regression on ppc64 with linux 6.2
Message-ID: <ZA7oJr1/Z4vzWy4N@righiandr-XPS-13-7390>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm triggering the following bug when booting my qemu powerpc VM:

event-sources: Unable to request interrupt 23 for /event-sources/hot-plug-events
WARNING: CPU: 0 PID: 1 at arch/powerpc/platforms/pseries/event_sources.c:26 request_event_sources_irqs+0xbc/0xf0
Modules linked in:
CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W          6.2.2-kc #1
Hardware name: IBM pSeries (emulated by qemu) POWER9 (raw) 0x4e1200 0xf000005 of:SLOF,HEAD pSeries
NIP:  c000000002022eec LR: c000000002022ee8 CTR: 0000000000000000
REGS: c000000003483910 TRAP: 0700   Tainted: G        W           (6.2.2-kc)
MSR:  8000000002029033 <SF,VEC,EE,ME,IR,DR,RI,LE>  CR: 24483200  XER: 00000000
CFAR: c000000000180838 IRQMASK: 0 
GPR00: c000000002022ee8 c000000003483bb0 c000000001a5ce00 0000000000000050 
GPR04: c000000002437d78 c000000002437e28 0000000000000001 0000000000000001 
GPR08: c000000002437d00 0000000000000001 0000000000000000 0000000044483200 
GPR12: 0000000000000000 c000000002720000 c000000000012758 0000000000000000 
GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
GPR20: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
GPR24: 0000000000000000 c0000000020033fc cccccccccccccccd c0000000000e07f0 
GPR28: c000000000db0520 0000000000000000 c0000000fff92ac0 0000000000000017 
NIP [c000000002022eec] request_event_sources_irqs+0xbc/0xf0
LR [c000000002022ee8] request_event_sources_irqs+0xb8/0xf0
Call Trace:
[c000000003483bb0] [c000000002022ee8] request_event_sources_irqs+0xb8/0xf0 (unreliable)
[c000000003483c40] [c000000002022fa0] __machine_initcall_pseries_init_ras_hotplug_IRQ+0x80/0xb0
[c000000003483c70] [c0000000000121b8] do_one_initcall+0x98/0x300
[c000000003483d50] [c000000002004b28] kernel_init_freeable+0x2ec/0x370
[c000000003483df0] [c000000000012780] kernel_init+0x30/0x190
[c000000003483e50] [c00000000000cf5c] ret_from_kernel_thread+0x5c/0x64
--- interrupt: 0 at 0x0

I did a bisect it and it seems that the offending commit is:
baa49d81a94b ("powerpc/pseries: hvcall stack frame overhead")

Reverting that and also dfecd06bc552 ("powerpc: remove
STACK_FRAME_OVERHEAD"), because we need to re-introduce
STACK_FRAME_OVERHEAD, seems to fix everything.

-Andrea
