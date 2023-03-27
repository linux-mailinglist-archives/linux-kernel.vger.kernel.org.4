Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA356CA1CB
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 12:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231990AbjC0Kz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 06:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbjC0Kz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 06:55:27 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF2553C14
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 03:55:24 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 5E6795C006D;
        Mon, 27 Mar 2023 06:55:22 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 27 Mar 2023 06:55:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1679914522; x=
        1680000922; bh=PlZnDrcoAzOg901ZQvqNUg/0TK1Smj7F72AYZPUYd6w=; b=X
        X8mibLJriKAFFyjK5XKJ0lFDhq7FN4vag8rwmWdAtJxzFz1olPVIDG6zq7v48Lwx
        uyi6O7y+HhiGeVbZgz0zbuIDIJgNr3TYLKJUI+roC+0042NABidpaRVaN+bf09wY
        NhM8WaiAHapcyYggFykqQXKJyjzbf64EDfJAp69w4bjkda0Z12A8DsXSViCnxjWG
        +hObCSzqVlESXpIZnVLKjB8U7sUG2QXt6AxPt2uhbT+/CxdfX81PWGL7NgtLshp2
        j/mlAMWbyRTpReqgE19+akhSwn25/tmi7GPSA+CiuzmZc0ncqka24fkO3hoijpHS
        eZk/cyWk8bNhi01rOcJ9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1679914522; x=1680000922; bh=PlZnDrcoAzOg9
        01ZQvqNUg/0TK1Smj7F72AYZPUYd6w=; b=fkqiXJ9OpGW2dbYJKk+wLeuscsO3Q
        DGH8z1G8WOUGiSTGAiG6I0dkRa82tH25JQuXZogrwOtDC6vqA0hoOZn5SHOTMD/I
        i/J2Ub3FchOgJdSRCOlv2NpTnxXT2pB1TxltXwd6DECxAUR1qgktJ53LP8LLVOP0
        8FlYG1ervcoeii8emWpIFGdjanXR81xyvZOq+zDr22Y0de5lp8iPupKsiTOkiiqO
        YygHmtJPHtVhCbaDa7APfxOxAzGIHEKe9EyFQGHt7R45CAofZMQVDYbz5BJiLdx8
        wOw0pmPsB+akCKUhJXyIrtdthu2bi4CD1D9KFRMwIEKPaCRcl6h3LYXyQ==
X-ME-Sender: <xms:GXYhZAnPpMh0pOpLKBtcNa6uPieIhZEoxE5Zse0TKQCtx0cxVNA1hA>
    <xme:GXYhZP1YcHKIFqKc7jv0MMas6esZIxOY6o0rsKzEGXmtFF8yCniYZMkNVZYhd25KZ
    _NEUXEEcQkAhleswZ0>
X-ME-Received: <xmr:GXYhZOqJZRAHCMasS2m9gIz9HtnZQjzKbKTTE3EcPwsptWOGWSF-5JvK7gWuUiwSIy17BQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdehvddgfeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdttddttddtvdenucfhrhhomhepfdfmihhr
    ihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlsehshhhuthgvmhhovhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpefffeevkefhffeghfeifeffjeehjeffheeujeeh
    ieekveevhfejleevveejtdeuvdenucffohhmrghinhepieegrdhssgenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhht
    vghmohhvrdhnrghmvg
X-ME-Proxy: <xmx:GXYhZMlgv4mq_Uyw7hNUX0ZPODaym-gryutOOG_5X0Tvaq31W2uswQ>
    <xmx:GXYhZO2PAFvCwh2U8BngfUAiUZXoDMdV5EDlF69sACzmCrMsqSisQw>
    <xmx:GXYhZDvS7vXDOrUfCeoS5ydFBMFWpPXRzpMOwROQE8kngcaJ-M_0Dg>
    <xmx:GnYhZMxFgtBGUJ5RiJA0ivg9twDuzZD9IqJCnumiICDWZFP4WkuBSA>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Mar 2023 06:55:21 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 97E21109BD6; Mon, 27 Mar 2023 13:55:18 +0300 (+03)
Date:   Mon, 27 Mar 2023 13:55:18 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Eric Biederman <ebiederm@xmission.com>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andrew Cooper <andrew.cooper3@citrix.com>
Subject: Re: [PATCH] x86: Disable kexec for TDX guests
Message-ID: <20230327105518.zuswpklvyvz72u6i@box.shutemov.name>
References: <20230325160128.21857-1-kirill.shutemov@linux.intel.com>
 <ebead33b-0594-73df-56ae-f40473ac0ffc@intel.com>
 <20230325192524.wetlbycbcsxc4plk@box>
 <b16bcda0-f190-7849-cbbb-412d328c8806@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b16bcda0-f190-7849-cbbb-412d328c8806@intel.com>
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 26, 2023 at 10:01:23AM -0700, Dave Hansen wrote:
> > I guess we can go this path if you are fine with taking CR4.MCE and shared
> > memory reverting patches (they require some rework, but I can get them
> > into shape quickly). After that we can forbid kexec on machines with MADT
> > if nr_cpus > 1.
> 
> This goes back to what I asked before: is anyone actually going to *use*
> a single-processor system that wants to kexec()?  If not, let's not
> waste the time to introduce code that is just going to bitrot.  Just
> mark it broken and move on with life.
> 
> I'm also a _bit_ curious what the implications of the CR4.MCE
> preservation are.  IIRC, systems are quite a bit less stable when
> CR4.MCE==0. So, maybe there are some benefits to leaving it set during
> kexec() for everyone.

Hm. I thought the opposite: keeping MCE set brings more risks.

Andrew had feedback on the patch:

	Async events, including NMIs, cannot be taken between this point and the
	target having set itself up into it's intended operating mode.  During
	this period you get all kinds of fun with type confusion in the IDT/TSS
	and/or not having a safe stack to service the event.

I tend to agree with him, but maybe I miss bigger picture.

Based on that I adjusted the patch to only affect TDX guests:

From edbef5f1e6c31929ae1249c58b29c38f86e676c0 Mon Sep 17 00:00:00 2001
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Date: Fri, 10 Feb 2023 12:53:11 +0300
Subject: [PATCH] x86/kexec: Keep CR4.MCE during kexec for TDX guest

TDX guests are not allowed to clear CR4.MCE. Attempt to clear it leads
to #VE.

Use alternatives to keep the flag during kexec for TDX guests.

The change doesn't affect non-TDX environments.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/kernel/relocate_kernel_64.S | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index 4a73351f87f8..9e83a638a2b8 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -145,8 +145,11 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 	 * Set cr4 to a known state:
 	 *  - physical address extension enabled
 	 *  - 5-level paging, if it was enabled before
+	 *  - Machine check exception on TDX guest. Clearing MCE is not allowed
+	 *    in TDX guests.
 	 */
-	movl	$X86_CR4_PAE, %eax
+	ALTERNATIVE "movl "$X86_CR4_PAE", %eax", \
+		    "movl "$(X86_CR4_PAE | X86_CR4_MCE)", %eax", X86_FEATURE_TDX_GUEST
 	testq	$X86_CR4_LA57, %r13
 	jz	1f
 	orl	$X86_CR4_LA57, %eax
-- 
  Kiryl Shutsemau / Kirill A. Shutemov
