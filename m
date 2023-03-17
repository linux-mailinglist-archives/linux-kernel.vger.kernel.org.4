Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 846EC6BDD53
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 01:07:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbjCQAHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 20:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbjCQAG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 20:06:59 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 593E66C1B0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 17:06:55 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Pd4Dm6VRWz4x1d;
        Fri, 17 Mar 2023 11:06:48 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1679011613;
        bh=FemQ0r+ZrnNoov3LxFCLx/ucheRNYuW9mVDhtcSxxkw=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=o41p3n4gHlMH1a6O9sa4u2HDueAdy5L+DmaZHS1IwqrwxoPhT13FQBLodLJzHVVqc
         qhOP51lQcsVmk73MKlketjZpGz7XjFL++bNbE47gggZVtv//t1eODaSXr5NUL9SdpK
         yZifaVcAy9OHTjk5ey2hiEsPy5izdTkldv/T7ENsboOJ3eTlCa1hLIAOEAs2EILUvL
         voHBq1QiquJC1G7brtNvVtb6SQtDp6M4mM5EGJUOOEbAwD1I+2BYEAji3ZgkuJJ7au
         xgv+jVNKOziNoQzSnfSiEs7Apr29/bAHZqThZfq0J1UrTgdxaMlX2SuArCznJ2kxjX
         EfMz7D1FTU+xQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Ira Weiny <ira.weiny@intel.com>, Ira Weiny <ira.weiny@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Subject: Re: [PATCH 0/3] COVER: Remove memcpy_page_flushcache()
In-Reply-To: <641340e2998b4_2695182944f@iweiny-mobl.notmuch>
References: <20221230-kmap-x86-v1-0-15f1ecccab50@intel.com>
 <3523ddf9-03f5-3179-9f39-cec09f79aa97@intel.com>
 <64126d113d163_2595222942@iweiny-mobl.notmuch>
 <87lejxmax8.fsf@mpe.ellerman.id.au>
 <641340e2998b4_2695182944f@iweiny-mobl.notmuch>
Date:   Fri, 17 Mar 2023 11:06:44 +1100
Message-ID: <87fsa4meaz.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ira Weiny <ira.weiny@intel.com> writes:
> + Konstantin
>
> Michael Ellerman wrote:
>> Ira Weiny <ira.weiny@intel.com> writes:
>> > Dave Hansen wrote:
>> >> On 3/15/23 16:20, Ira Weiny wrote:
>> >> > Commit 21b56c847753 ("iov_iter: get rid of separate bvec and xarray 
>> >> > callbacks") removed the calls to memcpy_page_flushcache().
>> >> > 
>> >> > kmap_atomic() is deprecated and used in the x86 version of
>> >> > memcpy_page_flushcache().
>> >> > 
>> >> > Remove the unnecessary memcpy_page_flushcache() call from all arch's.
>> >> 
>> >> Hi Ira,
>> >> 
>> >> Since the common code user is already gone these three patches seem
>> >> quite independent.  It seems like the right thing to do is have
>> >> individual arch maintainers cherry pick their arch patch and carry it
>> >> independently.
>> >
>> > Yes.
>> >
>> >> 
>> >> Is there a compelling reason to have someone pick up and carry these all
>> >> together that I'm missing?
>> >
>> > No reason.  Would you like me to submit them individually?
>> 
>> I'll just grab the powerpc one from the thread, no need to resend.
>
> Thanks.
>
>> 
>> > Sorry, submitting them separately crossed my mind when I wrote them but I
>> > kind of forgot as they were all on the same branch and I was waiting for
>> > after the merge window to submit them.
>> 
>> It's also much easier to run git-send-email HEAD^^^, rather than running
>> it three separate times, let alone if it's a 20 patch series.
>
> Exactly.  And I'm using b4 which would have forced me to create a separate
> branch for each of the patches to track.  So I was keeping them around in
> a single branch to let 0day run after the merge window.  Then I forgot
> about the idea of splitting them because b4 had it all packaged up nice!
>
>> 
>> I wonder if we could come up with some convention to indicate that a
>> series is made up of independent patches, and maintainers are free to
>> pick them individually - but still sent as a single series.
>
> Maybe.  But perhaps b4 could have a send option which would split them
> out?  I'll see about adding an option to b4 but I've Cc'ed Konstantin as
> well for the idea.

Yes you're right that's probably a better idea. b4 to the rescue!

cheers
