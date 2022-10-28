Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A61A361171D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 18:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbiJ1QJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 12:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbiJ1QIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 12:08:01 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBD081A39E;
        Fri, 28 Oct 2022 09:06:48 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e7ce329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e7ce:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4623B1EC0518;
        Fri, 28 Oct 2022 18:06:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1666973207;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=TaSyEs2uDEeNFySFbsAWLGbxmyPJdlW/cEgdh6Dc9LA=;
        b=XHRJ4OhKGvnSUY3FZm5qFAiodKxGqGTCRY5VncUDeCygsxhy9Q4bM8IEzLrXXfF9nBehiX
        F7RLgBP2A6Oi14yCT72nCZ/izgf6RazLC87U75EJpOOQeUI+HZNL9wnR/pPQJCb7fDjnM3
        tBLFlldzMQiEmDed7zRxx/CCa6R7SoA=
Date:   Fri, 28 Oct 2022 18:06:41 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Andrew Jones <ajones@ventanamicro.com>, x86@kernel.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        openrisc@lists.librecores.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        "open list:LINUX FOR POWERPC PA SEMI PWRFICIENT" 
        <linuxppc-dev@lists.ozlabs.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH v3 2/2] x86: Fix /proc/cpuinfo cpumask warning
Message-ID: <Y1v+Ed6mRN9gisJS@zn.tnic>
References: <20221014155845.1986223-1-ajones@ventanamicro.com>
 <20221014155845.1986223-3-ajones@ventanamicro.com>
 <20221028074828.b66uuqqfbrnjdtab@kamzik>
 <Y1vrMMtRwb0Lekl0@yury-laptop>
 <Y1vvMlwf/4EA/8WW@zn.tnic>
 <CAAH8bW_DkvPCH0-q2Bfe0OJ72r63mRM3GP7NKOFrhe3zMO2gbQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAAH8bW_DkvPCH0-q2Bfe0OJ72r63mRM3GP7NKOFrhe3zMO2gbQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2022 at 10:13:28AM -0500, Yury Norov wrote:
> Because it's related to bitmap API usage and has been revealed after
> some work in bitmaps.

So first of all, that "fix" needs to explain what exactly it is fixing.
Not "it fixes this and that warning" but why the input arg to
cpumask_next() cannot be nr_cpu_ids because... yadda yadda...

> And because nobody else cares.

Why do you assume that?

> If you're willing to move it yourself please go ahead.

If it fixes a real issue, we are taking it. And pls note that x86
patches go through the tip tree.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
