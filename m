Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4441369D749
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 00:45:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232324AbjBTXpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 18:45:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbjBTXpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 18:45:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46AE32201D
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 15:45:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C930460C56
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 23:45:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29801C433AC
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 23:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676936748;
        bh=lHqy7KaRTiXvEtoIHLDya9sELFHz4Y5zTlEpTGfK2so=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WpKkMJR1KO+e/GG1AaQt3isP8Cp3SqZw+gFPGFGrHTLHz3IngZn1k4tJV62EbOOVa
         TLzI20woFXj0I5r3vpIAgJ7OMcf5vTlpwKAMM8w5JI1+XWcltiDO4TB1VXllxEsMUt
         BdY1k72N/F+Nu8EzLbqCx3mVov6fxbXYacfTxmztjF7tQsQQJ2UWCeX2S1Bn5PFWYi
         I6h/7Z7HXcdJISUHlw1dF04FX71g2J3xBq9HKLmPBUiEGG5CfuUy07jNUrBWNEkqe9
         v6GUTxGraiGRLAKS8lKs/8uYtoDnl6AjAGt8igc0uGoqYCuY5OMgB2X+MD8OL6+dkd
         X+SG+k4OJqA1g==
Received: by mail-ed1-f53.google.com with SMTP id cq23so10199429edb.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 15:45:48 -0800 (PST)
X-Gm-Message-State: AO0yUKVmoncofQ1rN/nm7veE704b8TXP9HmW4CMWPwWuqwirLhDke2g4
        5SppOgBB6ws0XUw6c1sK3Ozhd3ZPpp6lgqUdOmvLDA==
X-Google-Smtp-Source: AK7set+v7ZnTho0nPLYgzxi4AwTt0me1YzleMkwglp/Me6loAowj15CqGWw9nLkhgolRVf1BKnYRgLxYAOhKWheMX5o=
X-Received: by 2002:a17:906:13d9:b0:8de:c6a6:5134 with SMTP id
 g25-20020a17090613d900b008dec6a65134mr212605ejc.15.1676936746315; Mon, 20 Feb
 2023 15:45:46 -0800 (PST)
MIME-Version: 1.0
References: <20230220120127.1975241-1-kpsingh@kernel.org> <20230220121350.aidsipw3kd4rsyss@treble>
 <CACYkzJ5L9MLuE5Jz+z5-NJCCrUqTbgKQkXSqnQnCfTD_WNA7_Q@mail.gmail.com>
 <CACYkzJ6n=-tobhX0ONQhjHSgmnNjWnNe_dZnEOGtD8Y6S3RHbA@mail.gmail.com>
 <Y/OETPFTJbGtCADM@zn.tnic> <3a65d18f-b218-60e7-4748-f1609eb76fd5@citrix.com>
 <Y/PhxDIVsa4WU5gu@zn.tnic> <50231372-2d6d-e4af-be88-5fe45e0c210d@citrix.com>
In-Reply-To: <50231372-2d6d-e4af-be88-5fe45e0c210d@citrix.com>
From:   KP Singh <kpsingh@kernel.org>
Date:   Mon, 20 Feb 2023 15:45:35 -0800
X-Gmail-Original-Message-ID: <CACYkzJ6k+Gm5NogQ6u4kLcHYfhyvNOtL3RvmDoJYq9KH5c4eqw@mail.gmail.com>
Message-ID: <CACYkzJ6k+Gm5NogQ6u4kLcHYfhyvNOtL3RvmDoJYq9KH5c4eqw@mail.gmail.com>
Subject: Re: [PATCH RESEND] x86/speculation: Fix user-mode spectre-v2
 protection with KERNEL_IBRS
To:     Andrew Cooper <andrew.cooper3@citrix.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        linux-kernel@vger.kernel.org, pjt@google.com, evn@google.com,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, peterz@infradead.org,
        pawan.kumar.gupta@linux.intel.com, kim.phillips@amd.com,
        alexandre.chartre@oracle.com, daniel.sneddon@linux.intel.com,
        =?UTF-8?Q?Jos=C3=A9_Oliveira?= <joseloliveira11@gmail.com>,
        Rodrigo Branco <rodrigo@kernelhacking.com>,
        Alexandra Sandulescu <aesa@google.com>,
        Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2023 at 3:31 PM Andrew Cooper <andrew.cooper3@citrix.com> wrote:
>
> On 20/02/2023 9:10 pm, Borislav Petkov wrote:
> > On Mon, Feb 20, 2023 at 07:57:25PM +0000, Andrew Cooper wrote:
> >> I think we're discussing the legacy IBRS case here.  i.e. what was
> >> retrofitted in microcode for existing parts?
> > Any IBRS actually. The one which is *not* the automatic, fire'n'forget
> > thing.
>
> /sigh so we're still talking about 3 different things then.
>
> 1) Intel's legacy IBRS
> 2) AMD's regular IBRS
> 3) AMD's AutoIBRS
>
> which all have different relevant behaviours for userspace.  Just so
> it's written out coherently in at least one place...
>
> When SEV-SNP is enabled in firmware, whether or not it's being used by
> software, AutoIBRS keeps indirect predictions inhibited in all of
> ASID0.  That's all host userspace to the non-hypervisor devs reading
> this thread.
>
> For any AMD configuration setting STIBP, there must be an IBPB after
> having set STIBP.   Setting STIBP alone does not evict previously
> created shared predictions.  This one can go subtly wrong for anyone who
> assumes that Intel STIBP and AMD STIBP have the same behaviour.

This is very useful, but I think this is also why the STIBP and IBPB's
conditionals seemed to be tangled together. The prctl / seccomp code
should set STIBP and trigger an IBPB.

I took a stab at the documentation piece, Andrew and others could you
help me with a review and suggestions?

diff --git a/Documentation/admin-guide/hw-vuln/spectre.rst
b/Documentation/admin-guide/hw-vuln/spectre.rst
index c4dcdb3d0d45..d7003bbc82f6 100644
--- a/Documentation/admin-guide/hw-vuln/spectre.rst
+++ b/Documentation/admin-guide/hw-vuln/spectre.rst
@@ -479,8 +479,17 @@ Spectre variant 2
    On Intel Skylake-era systems the mitigation covers most, but not all,
    cases. See :ref:`[3] <spec_ref3>` for more details.

-   On CPUs with hardware mitigation for Spectre variant 2 (e.g. Enhanced
-   IBRS on x86), retpoline is automatically disabled at run time.
+   On CPUs with hardware mitigation for Spectre variant 2 (e.g. IBRS
+   or enhanced IBRS on x86), retpoline is automatically disabled at run time.
+
+   Setting the IBRS bit implicitly enables STIBP which guards against
+   cross-thread branch target injection on SMT systems. On systems
with enhanced
+   IBRS, the kernel sets the bit once, which keeps cross-thread protections
+   always enabled, obviating the need for an explicit STIBP. On CPUs
with legacy
+   IBRS, the kernel clears the IBRS bit on returning to user-space, thus also
+   disabling the implicit STIBP. Consequently, STIBP needs to be explicitly
+   enabled to guard against cross-thread attacks in userspace.
+

    The retpoline mitigation is turned on by default on vulnerable
    CPUs. It can be forced on or off by the administrator
@@ -504,9 +513,12 @@ Spectre variant 2
    For Spectre variant 2 mitigation, individual user programs
    can be compiled with return trampolines for indirect branches.
    This protects them from consuming poisoned entries in the branch
-   target buffer left by malicious software.  Alternatively, the
-   programs can disable their indirect branch speculation via prctl()
-   (See :ref:`Documentation/userspace-api/spec_ctrl.rst <set_spec_ctrl>`).
+   target buffer left by malicious software.
+
+   On legacy IBRS systems where the IBRS bit is cleared and thus disabling the
+   implicit STIBP on returning to userspace, the programs can disable their
+   indirect branch speculation via prctl() (See
+   :ref:`Documentation/userspace-api/spec_ctrl.rst <set_spec_ctrl>`).
    On x86, this will turn on STIBP to guard against attacks from the
    sibling thread when the user program is running, and use IBPB to
    flush the branch target buffer when switching to/from the program.

>
> Furthermore, extra care needs taking on vmexit because transitioning
> from the guest STIBP setting to the host STIBP setting can leave shared
> predictions intact.



>
> ~Andrew
