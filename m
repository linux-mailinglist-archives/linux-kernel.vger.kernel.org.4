Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E08876EFC80
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 23:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240069AbjDZVaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 17:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240147AbjDZVaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 17:30:02 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ECAEE76;
        Wed, 26 Apr 2023 14:29:49 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1682544586;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fwiQaWIRHQyq7je3uiXIYH4HOfAwQIaSflkAEcF6eh8=;
        b=B9QDZ0qRvllVXbYmnanLl1ovYM3aOLpWhAF+F82mr/sHwScw4NB2YzXdlUBccBYRxOd9U4
        bvKiCt1ex+1KKGOFNXNBHRCU1RmAio5V++JhFLqath6WUBx9PKjA6sFtMPGfzw2SKGuO9F
        ssit9S+1Bx9s0QR5XCyOyQDfQghfryUJrJPQe+D5efffpWcLyDrmo11g7jPIfN3FCiRicH
        xKo1OX6bz7cqONbVIeixBvZreanatItV0kQxDGkLA1TtjoaWsQ9nZfsyEhlMLevoNc78YS
        Q0KC6EUH4hCDdJfvDQr/jj61AOQtCllRSbeqE8GGT+SLNm6wfvRQgPFONTrNbQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1682544586;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fwiQaWIRHQyq7je3uiXIYH4HOfAwQIaSflkAEcF6eh8=;
        b=WJX2ivJ5pOIVjXh0XT2pQWl0AO1BXk5NMBCI+1TkxCZps2pFiYmBvL8jn/HqSVE36smstx
        BrCQwH0F6YLGPTAw==
To:     "Bouska, Zdenek" <zdenek.bouska@siemens.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Kiszka, Jan" <jan.kiszka@siemens.com>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        Nishanth Menon <nm@ti.com>, Puranjay Mohan <p-mohan@ti.com>
Subject: Re: Unfair qspinlocks on ARM64 without LSE atomics => 3ms delay in
 interrupt handling
In-Reply-To: <AS1PR10MB567534190B05A4493674173BEB659@AS1PR10MB5675.EURPRD10.PROD.OUTLOOK.COM>
References: <AS1PR10MB567534190B05A4493674173BEB659@AS1PR10MB5675.EURPRD10.PROD.OUTLOOK.COM>
Date:   Wed, 26 Apr 2023 23:29:45 +0200
Message-ID: <87pm7qxrg6.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 26 2023 at 12:03, Zdenek Bouska wrote:
> following patch is my current approach for fixing this issue. I introduced
> big_cpu_relax(), which uses Will's implementation [1] on ARM64 without
> LSE atomics and original cpu_relax() on any other CPU.

Why is this interrupt handling specific? Just because it's the place
where you observed it?

That's a general issue for any code which uses atomics for forward
progress. LL/SC simply does not guarantee that.

So if that helps, then this needs to be addressed globaly and not with
some crude hack in the interrupt handling code.

> Anyone has a better idea how to solve this issue properly?

Use hardware with LSE atomics :)

Thanks,

        tglx
