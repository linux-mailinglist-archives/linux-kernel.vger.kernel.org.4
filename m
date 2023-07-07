Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A44D74B039
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 13:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232079AbjGGLrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 07:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjGGLrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 07:47:33 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A69E2110
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 04:47:30 -0700 (PDT)
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id F3CB53F72E
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 11:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1688730448;
        bh=yCrZiw7BEnZOoMlxwV+fDzQMDThIgv0il3cqJ87wTwY=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=Llb7Hv+BkpXGknGE4BLATfOdgDXGpPt6wbOfo3SCNN+N397eA+Hj4q8AOgCw0PxA9
         3D2oTzSM2lRi5Ap0NJn3GPQJfcwU67FqJI024j0gvC+swADRBEt08lgFmOFlD+sqI7
         jOi91Rer+UzqrmrHRT9jcQ61BopVU9aLzGlQ1mo58CrdNAjXO0vwyRPS3tMfMaFTG4
         vaxeeOsOregxRa5QV5hfekuF9R+wlB5hF+CirnaCwWJrBcqfayHZsxQi0THUWE+7UP
         RsEAogfUOTfmCDyT3Vi8kAjY7Ja+UeY6TIF+btkfNmKqGo+bkNBUxPj45y2RU95RTi
         QhnxCPfgIfHpg==
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-31273e0507dso979295f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 04:47:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688730447; x=1691322447;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yCrZiw7BEnZOoMlxwV+fDzQMDThIgv0il3cqJ87wTwY=;
        b=guxVvmNTJzf05tUY3c5/LAD5dFWXxtMdCsFEC1jvltKTohzajpAso/LVFH48InI+Kt
         ifvCM5Nxjsy2uPCK8kW82TzOA6TfxdF6suFAHX4pJAz88Fh92tsSIvZuNC+Bn70DpshS
         LVc3b6npBU1jpSOoaRb8WG40JnYOKbdlXtvncE5DhiZhv7J/4ARM9xUnZ+7eejyF1Vt3
         ECoQIr/Oma68ghinMq13hsgNzvj0dM9sTNueKEObadv54Sc1HwMtHy3RbOn2HNND4Tpe
         /wU4DgEQJxeq6qFFxWT3VCn8Q55QW6FaFY+8bS1bA/KiJw64n7pbXr5PtiV8SqHpPE5g
         pFVw==
X-Gm-Message-State: ABy/qLbMQjkQnVlzonp7kR6vVOg3uvbX8dJTZ0Kd6nIq1HztVuWYgttu
        wDWgtQY6YxUdSyyKNr/kmIwWwn8hdpCKE8N8x9WJLyuC/ZYFD2mcFJe6ZiYrNo6XgDUrxUgjAAJ
        IClB9VCNidDEqCjFaKaK1ZypWyJH/WYrW/4g8nmKE/xuEq3KabOeC1lyzNw==
X-Received: by 2002:adf:ed05:0:b0:313:f0d7:a43 with SMTP id a5-20020adfed05000000b00313f0d70a43mr4002206wro.23.1688730447420;
        Fri, 07 Jul 2023 04:47:27 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGVAIBpTa1MVAlzodE1XgvifnvQI9UgGx54CHGg+qXLudKYtN63Ml6dNysCS8JNx6f/EsqAIEvNKoE2Xvud+mI=
X-Received: by 2002:adf:ed05:0:b0:313:f0d7:a43 with SMTP id
 a5-20020adfed05000000b00313f0d70a43mr4002192wro.23.1688730447144; Fri, 07 Jul
 2023 04:47:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230707105601.133221-1-dimitri.ledkov@canonical.com> <20230707112805.GCZKf2xdf2kMJ/S1DU@fat_crate.local>
In-Reply-To: <20230707112805.GCZKf2xdf2kMJ/S1DU@fat_crate.local>
From:   Dimitri John Ledkov <dimitri.ledkov@canonical.com>
Date:   Fri, 7 Jul 2023 12:46:50 +0100
Message-ID: <CADWks+Y7yRfQgd3iKM=qg8-HnQc51QLFNOsWXmR7Rfdn29SSkw@mail.gmail.com>
Subject: Re: [PATCH] x86/cpu: Add support for modern x86-64-v* march
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Jul 2023 at 12:28, Borislav Petkov <bp@alien8.de> wrote:
>
> On Fri, Jul 07, 2023 at 11:56:00AM +0100, Dimitri John Ledkov wrote:
> > Add support for setting march to x86-64-v2, x86-64-v3, x86-64-v4 with
> > tuning set to an early family of CPUs that support such instruction
> > levels. By default gcc sets generic tuning for x86-64-v*, which is
> > suboptimal for all brands of CPUs with such instruction set support.
>
> Prove that it is suboptimal for the kernel. Numbers please.

It's not suboptimal for the kernel as is, it is suboptimal for
march=x86-64-v* as documented in gcc - probably gcc should actually
prohibit mtune=generic with march=x86-64-v* settings.

> And even if it shows on *some* uarch:
>
> * we need a *single* setting for distro kernels - i.e.,
> CONFIG_GENERIC_CPU and compilers do make sure that -mtune=generic does
> the most optimal code generation for all uarches
>
> * our Kconfig option set is abysmal so don't need any more if useless.
>
> Yeah, a patch like that keeps popping up on a regular basis but no,
> thanks.

The biggest issue is that march & mtune is always set, and there is no
option to use the compiler configured builtin default, or pass in an
arbitrary string.

Would it be acceptable to change GENERIC_CPU to not set neither march
nor mtune and thus use the compiler configured default? If not, would
it be acceptable to have a new option GENERIC_NONE which does not set
any march/mtune and thus uses a compiler configured default? Or for
example, allow a new freeform string for march and mtune?

-- 
okurrr,

Dimitri
