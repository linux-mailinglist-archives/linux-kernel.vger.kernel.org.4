Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 518536F7088
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 19:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbjEDRL0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 13:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjEDRLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 13:11:22 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 016B14202
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 10:10:52 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id E99AC32009D0;
        Thu,  4 May 2023 13:10:36 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 04 May 2023 13:10:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1683220236; x=
        1683306636; bh=//tZme3BQaKm/c8SpP4uC9baNxKQkK0g/hUP0dNsZzk=; b=q
        felpSvMGVixQ9XVoTbgze97iLLUEbUv48WL1RFFeDI5cQ9wuCdZVdaENf5ZDs93j
        tycMC6lrD8nDT2HftnYMXuFw/nL9cOdkFXAV+Be4xGx4uiLD3rJUpVOYnKksJIvw
        vx6Vg4imjxaZuZ4UD1Au6N4JCeieM2HKSITpKXxxzoFf+8lU1mFPudpC9VoUDwQQ
        0OzZWIAfc9h0uEL60x4VNuRqHw44iQ53l3NEY1qLQORar7WE/b7AtBm2R+Rm23lI
        PtU5IfF/aaqZXmUysYILmoc+it1GcESO48/J5D2oFqVvPe6ubUwjom66YkaH95UX
        JxC4R923qyzRs/LC41E6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1683220236; x=1683306636; bh=//tZme3BQaKm/
        c8SpP4uC9baNxKQkK0g/hUP0dNsZzk=; b=PgE4Bdh0cLKVUidBv5nf+nGrxlrxv
        OBBRHk6dKnXk/5qXhVjcxtuuuLnrZJh5zHQDra8yc3yZG5rEU7MAk4sVEBDoDKYr
        9pYjRFExIbGgD4jhlvilybu21TG18McxE0NPSrgmZzODy1B5pcWky1W1dEYq1pp3
        NDXnta+G4yLrRINc1cW0Vuzvbf23N94+i3fGzcKsk30oY5ZgDLaxI+BYtNcWcYie
        16D/IxTdKkFmBmyLUj4/aTgh1B7xqcpOGVnQrInmbRmROT3sh5aAVLk3mfbyCPi6
        V8EzTvwS7TDRNg5kMMX0c9dC25d5Jfs9wHtj5VGcuhElCEgD3O7DjBdFA==
X-ME-Sender: <xms:C-dTZDWa0S1xp35CGoXE5vLd5NL8ihwd8e08HpItsfrlxD5nSE9lJg>
    <xme:C-dTZLlinDnGephXa7sHMGfgPdK69FQ-MIhpfAOnQZP6CjFusmzGYIm9K5otXanLw
    HKk5ci61hvOqkZKZYQ>
X-ME-Received: <xmr:C-dTZPaWNHBUqxK5IowP-TwEgW_BpeCLerRj-WwM9n19RAPBZMopj47bWwD6ZozchRzleg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeftddguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttddttddttddvnecuhfhrohhmpedfmfhi
    rhhilhhlucetrdcuufhhuhhtvghmohhvfdcuoehkihhrihhllhesshhhuhhtvghmohhvrd
    hnrghmvgeqnecuggftrfgrthhtvghrnhephfeigefhtdefhedtfedthefghedutddvueeh
    tedttdehjeeukeejgeeuiedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepkhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgv
X-ME-Proxy: <xmx:C-dTZOW2sMmiZrJr5CdPc_oPSC8e9IxetuobUJ9jfzV-ujU7D6YxDw>
    <xmx:C-dTZNlh7xGcfVya8ixbACotAMuCsSsdj_Mq_3HSRmRfnrQyhRGOQQ>
    <xmx:C-dTZLc7yJcpVpognNx5iLGOwj8D_-vytIdhFrlri6z9Gv_DOdsbng>
    <xmx:DOdTZAuDHEMgYuyLsz3iz-4OVpz1ipyq9DcVPZZz2xdsWJb30AIp-A>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 May 2023 13:10:35 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 694FC10CE5D; Thu,  4 May 2023 20:10:32 +0300 (+03)
Date:   Thu, 4 May 2023 20:10:32 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kirill.shutemov@linux.intel.com,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [GIT PULL] x86/mm for 6.4
Message-ID: <20230504171032.wk53kzswwugmofhh@box.shutemov.name>
References: <CAHk-=wiHvdgbLxayyCsRU45JnKCZkCOpEJPfOvE3eYCnGjVcSA@mail.gmail.com>
 <20230429003822.n3mglslg666j3npp@box.shutemov.name>
 <641a9348-a052-6bb5-e6c7-64acb6405328@intel.com>
 <CAHk-=wgnGoj8qZg3SRh1Z1-mU=b3ryydXZykUuarnrAn6LuHBw@mail.gmail.com>
 <CAHk-=wgN=GY2A0htYQQRmPaLCorWnFatY_XO0X2w_m9xXQDcPA@mail.gmail.com>
 <f5983c42-82a5-1cd8-c717-67bfd72377dc@intel.com>
 <CAHk-=wgpOqujY210W9-KJPEfD42W_bvUdLwF-PAvyxJQ92tzDg@mail.gmail.com>
 <CAHk-=wj7q6Ng5uemZtrDnhtcfrgkzX5Z18eKZj94FY5d2quP6A@mail.gmail.com>
 <20230504062827.algltnmlddtzmfz5@box.shutemov.name>
 <1ea18c96-162f-a606-f37b-aaa1bfb2443c@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ea18c96-162f-a606-f37b-aaa1bfb2443c@intel.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 04, 2023 at 08:25:58AM -0700, Dave Hansen wrote:
> On 5/3/23 23:28, Kirill A. Shutemov wrote:
> >> Untagging a kernel address will "corrupt" it, but it will stay a
> >> kernel address (well, it will stay a "high bit set" address), which is
> >> all we care about anyway.
> > The interesting case to consider is untagging kernel pointer when LAM_U48
> > is enabled (not part of current LAM enabling). LAM_U48 would make the
> > untagging mask wider -- ~GENMASK(62, 48). With 5-level paging and LAM_SUP
> > enabled (also not supported yet) untagging kernel may transform it to
> > other valid kernel pointer.
> > 
> > So we cannot rely on #GP as backstop here. The kernel has to exclude
> > kernel pointer by other means. It can be fun to debug.
> 
> Yeah, I have the feeling that we're really going to need a pair of
> untagging functions once we get to doing kernel LAM for a _bunch_ of
> reasons.

There's already arch_kasan_reset_tag() used on ARM64 (and two more helpers
to set/get tag). Don't see a reason to add new.

> Just as a practical matter, I think we should OR bits into the mask on
> the kernel side, effectively:
> 
> unsigned long untag_kernel_addr(unsigned long addr)
> {
> 	return addr | kernel_untag_mask;
> }
> 
> and kernel_untag_mask should have bit 63 *clear*.
> 
> That way the pointers that have gone through untagging won't look silly.
>  If you untag VMALLOC_END or something, it'll still look like the
> addresses we have in mm.rst.
> 
> Also, it'll be impossible to have the mask turn a userspace address into
> a kernel one.
> 
> Last, we can add some debugging in there, probably conditional on some
> mm debugging options like:
> 
> 	if (WARN_ON_ONCE(!valid_user_address(addr)))
> 		return 0;
> 
> It's kinda like "void __user *" versus "void *".  The __user ones can
> *absolutely* point anywhere, user or kernel.  That's why we can't WARN()
> in the untagged_addr() function that takes user pointers.
> 
> But "void *" can only point to the kernel.  It has totally different rules.
> 
> We should probably also do something like the attached patch sooner
> rather than later.  'untag_mask' really is a misleading name for a mask
> that gets applied only to user addresses.

A bit too verbose to my liking, but okay.

Maybe _uaddr() instead of _user_addr()?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
