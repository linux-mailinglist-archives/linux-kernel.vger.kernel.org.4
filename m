Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D593863CA6E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 22:18:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237055AbiK2VSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 16:18:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236889AbiK2VSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 16:18:32 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9E4A5CD24
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 13:18:30 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669756708;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kE3agNpQbCMxGAh1tjuuMDPZbQ68guiLd4sGQzwul8w=;
        b=F2Xe4BKdR/KuHRBtBHesfNN2VV1yXl2PhtB82Dzj+CuLVpizvsQlji9g74pogDdYviPBuu
        g1b5P2YIB0DPU1zZk/VcTjoxPMudmHdZnY5hJnm20SqHrmDwrZ1CZfJCloObnHlWs9XyQ5
        066i67bu82AZRvQVTJaSVjL55Wfqe4sV+GJcB7l3SnAMDi7Hm8w0+DJK1Pt0NpoKYLcRF2
        KG5OrquCTUwqdf7y8CshvmuyJHOfOaWiM3SoVV+UApVYaYdDVsqJtaEF+q+xqSMgtsFjMx
        b5+KFncw0aSxQVs+Jnv8BnjT68nM2Z5gywCWVwbScS5oo11chGZYZ+sve+h7tw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669756708;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kE3agNpQbCMxGAh1tjuuMDPZbQ68guiLd4sGQzwul8w=;
        b=QB/qfxQbauK5SgMGo2Oc15pcMvrjrrwURVIx0A+9Dm6/ZG/MzZndcGQM63VTu+cwl7mL2D
        fkzc5Dt2Zq4oZJAw==
To:     Jann Horn <jannh@google.com>
Cc:     Andrei Vagin <avagin@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] time/namespace: Forbid timens page faults under
 kthread_use_mm()
In-Reply-To: <20221129191839.2471308-2-jannh@google.com>
References: <20221129191839.2471308-1-jannh@google.com>
 <20221129191839.2471308-2-jannh@google.com>
Date:   Tue, 29 Nov 2022 22:18:28 +0100
Message-ID: <87fse1v4rf.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29 2022 at 20:18, Jann Horn wrote:

> find_timens_vvar_page() doesn't work when current's timens does not match
> the timens associated with current->mm.
> v6 of the series adding this code [1] had some complicated code to deal
> with this case, but v7 [2] removed that.
>
> Since the vvar region is designed to only be accessed by vDSO code, and
> vDSO code can't run in kthread context, it should be fine to error out in
> this case.

Should? Either it is correct or not.

But the way more interesting question is:
  
>  struct page *find_timens_vvar_page(struct vm_area_struct *vma)
>  {
> +	/*
> +	 * We can't handle faults where current's timens does not match the
> +	 * timens associated with the mm_struct. This can happen if a page fault
> +	 * occurs in a kthread that is using kthread_use_mm().
> +	 */

How does a kthread, which obvioulsy did kthread_use_mm(), end up trying to
fault in the time namespace vvar page?

It's probably something nasty, but the changelog has a big information
void.

It neither answers the obvious question why this is a problem of the
time namespace vvar page and not a general issue versus a kthread, which
borrowed a user mm, ending up in vdso_fault() in the first place?

None of those VDSO (user space) addresses are subject to be faulted in
by anything else than the associated user space task(s).

Thanks,

        tglx
