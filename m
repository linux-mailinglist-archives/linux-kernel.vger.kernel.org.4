Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1661D712E57
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 22:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242160AbjEZUqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 16:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236530AbjEZUqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 16:46:10 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABC9A114
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 13:46:08 -0700 (PDT)
Received: from nazgul.tnic (dynamic-002-247-249-230.2.247.pool.telefonica.de [2.247.249.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6881F1EC0333;
        Fri, 26 May 2023 22:46:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1685133966;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=KTUqH8SmQtCp0oWxzQ2h7ivdyVYYG5CHox2dbTdkE1Y=;
        b=LNFBSAPZBqYr+6Ui9zM2//Izc8aazh7DCyulZca8PwvuhBZDVNUBOcGcQ2/eW3npyZyDCo
        qp1KLepHAU9IwOm+MWkxhkEjLUMAxtz9U7xvfQy1RcojK6vWqOCdEpRE+tDzrJiDUZ3xbd
        P9+fZPqTsKv8DyaYCwJK9l7UnC2iyC0=
Date:   Fri, 26 May 2023 22:45:59 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] x86/lib: Do not use local symbols with
 SYM_CODE_START_LOCAL()
Message-ID: <20230526204559.GAZHEahxxnQaHhSUul@nazgul.local>
References: <20230525184244.2311-1-namit@vmware.com>
 <38e24fd4-9213-229d-9919-7ae3bfb113bb@intel.com>
 <24E47178-C177-425F-A8EF-CFFAE22597D4@gmail.com>
 <20230526155336.GAZHDWAFi1FRqq83TP@nazgul.local>
 <0F07EEDB-8A3F-4224-9FF1-43A5300B1B8B@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0F07EEDB-8A3F-4224-9FF1-43A5300B1B8B@gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 26, 2023 at 10:29:29AM -0700, Nadav Amit wrote:
> Can you give me some examples for code whose address cannot be mapped
> back to a symbol?

No, this is not what I'm talking about.

I'm talking about all the local labels the compiler uses. For example:

$ make kernel/sched/core.s
$ grep -E "^\.L" kernel/sched/core.s | wc -l
2799

All those local labels are not in the symbol table (get discarded) and
the addresses they represent are shown as belonging to the containing
function.

> I did not ask to make them global. Just to keep them as local after
> linkage in the executable, like all other functions in the kernel.

Ok, not global. But local and present in the symbol table:

105185: ffffffff81b89330    17 NOTYPE  LOCAL  DEFAULT    1 bad_get_user_clac

And again, this helps how exactly?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
