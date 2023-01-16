Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4683A66B9F9
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 10:14:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231954AbjAPJOc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 04:14:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232758AbjAPJN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 04:13:56 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7181913506
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 01:13:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Kwtryj1HCBFMowhvUsB8ib2dwQrySNMnhO0NS2CkGbQ=; b=fL34W63fUC/XvD2Z3ptNvw8G8a
        FTOVlIkTnPr/ESjmavB79YyPUbKJbBW9CY2+qWn8xZCQkSzZZrehxK37u2dDt4spOuPEstoggX/+o
        rbrBLVnCuZQio8BsPRDwYPLHNonYLHwwrDmeFDabsXzr5foisEmnDcbybjJeWMHPPR7Z9DeBOlKwt
        S1FDmqLc35Kppc7hQWzuT/E2K7rjYlSDiCSiVC7/h4TUkCslR/zdAl7jvV88gStKgxs6Fn8i3+/48
        soi/xtuHAscLZbFSPhPNUACSXsGgy/slwncXr3F2CiQRIPWmNX3YBGAIL5DAMUhULfAHz6LQJ5366
        BhK/mVfw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pHLXi-005Xef-1V;
        Mon, 16 Jan 2023 09:12:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7754A30030F;
        Mon, 16 Jan 2023 10:12:44 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C608420A006E1; Mon, 16 Jan 2023 10:12:44 +0100 (CET)
Date:   Mon, 16 Jan 2023 10:12:44 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Juergen Gross <jgross@suse.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org,
        Josh Poimboeuf <jpoimboe@kernel.org>
Subject: Re: [PATCH 0/2] x86/xen: don't return from xen_pv_play_dead()
Message-ID: <Y8UVDAgXh/y+B66k@hirez.programming.kicks-ass.net>
References: <20221125063248.30256-1-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221125063248.30256-1-jgross@suse.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 25, 2022 at 07:32:46AM +0100, Juergen Gross wrote:
> All play_dead() functions but xen_pv_play_dead() don't return to the
> caller.
> 
> Adapt xen_pv_play_dead() to behave like the other play_dead() variants.
> 
> Juergen Gross (2):
>   x86/xen: don't let xen_pv_play_dead() return
>   x86/xen: mark xen_pv_play_dead() as __noreturn
> 
>  arch/x86/xen/smp.h      |  2 ++
>  arch/x86/xen/smp_pv.c   | 17 ++++-------------
>  arch/x86/xen/xen-head.S |  7 +++++++
>  tools/objtool/check.c   |  1 +
>  4 files changed, 14 insertions(+), 13 deletions(-)

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
