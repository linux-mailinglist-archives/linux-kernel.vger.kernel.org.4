Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 048AB6FB6DE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 21:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233419AbjEHTnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 15:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjEHTna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 15:43:30 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D5754209;
        Mon,  8 May 2023 12:43:29 -0700 (PDT)
Message-ID: <20230508181633.089804905@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683575007;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=cSONB8rAwM/DhP8pLyA+5ZPUbC2lOuuQwaVdJRn5WDM=;
        b=TUKnHdyKCm2jhBxD5IlUGRPEG/QaxWUEEk5j+F5TiwGQh75MzfKnWvvga1ogV0FWpqsAk0
        Z/VqPwKzVgozvsmFgeZHc6fKtgAWVGs7xGme4vq54PLJoTakzMDfDNVCbcO2rny0q4HnR6
        qlFXb43Qt1L8lTxJDtVVOKBuzxeXABCLtAFoVNNIdEV1p8ow/ukbkpiR2uIVB/FYpjA6p3
        h6hKX4cZFsqIirm+tNd9G+ACRA1lcKi+gtx7U3umktHuz9juvrtG2mgbwLKrM2SK5QyvS3
        r9jvL2zUpq3y0guhjpTb2zQUgu9MH/0dN+oTlFfspWYXJjDrCu5rao9nchjzhw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683575007;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=cSONB8rAwM/DhP8pLyA+5ZPUbC2lOuuQwaVdJRn5WDM=;
        b=i5YP5va30wPZDaaNSG4+BZNoSkYS91jOjq0F96kx0dzX5lZgVd2tGOGcKaXMK8erIbX4td
        IGoM8wVZMNo8tHAg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, David Woodhouse <dwmw2@infradead.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Brian Gerst <brgerst@gmail.com>,
        Arjan van de Veen <arjan@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Paul McKenney <paulmck@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Piotr Gorski <lucjan.lucjanov@gmail.com>,
        Usama Arif <usama.arif@bytedance.com>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        xen-devel@lists.xenproject.org,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        linux-csky@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Sabin Rapan <sabrapan@amazon.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Subject: [patch v3 00/36] cpu/hotplug, x86: Reworked parallel CPU bringup
Date:   Mon,  8 May 2023 21:43:26 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This is version 3 of the reworked parallel bringup series. Version 2 can be
found here:

   https://lore.kernel.org/lkml/20230504185733.126511787@linutronix.de

This is just a quick reiteration to address the following details:

  1) Drop the two extended topology leaf patches as they are not longer
     relevant (Andrew Cooper)

  2) Make the announce_cpu() fixup work for real (Micheal Kelley)

Other than that there are no changes and the other details are all the same
as in V2.

Thanks,

	tglx





