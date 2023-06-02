Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF4E71FA47
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 08:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234006AbjFBGqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 02:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233879AbjFBGp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 02:45:57 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 615B0EB;
        Thu,  1 Jun 2023 23:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=Bnlp6MxAg99YCHUoCG4a6Z05t5+lypBAqx5s7zPKO8c=; b=PLEtxF59sPHDqs2J6RDAZz9QEX
        Iy7PWm5ZDd8O1vBV+G/4rBZRnFOLP/M1bFTEb/e3XXQ4RJ2Oss7LDCS1/6i5lzEpKOMleXQse+bTq
        khynrKbRDpiVt9oQo0oVhOpEO1O9uKp9mNRr5HJ+UoPF2ctCxMFaxBFyONnC/7nsBSH7VeDeDKaze
        mzjmVhtibXAa0a1j/eQbFKYyH3vOEKKsxtZ3HaWSySGtnoVInWlxb87IRFfm/6Hmf4eJrOz3Tipu1
        lH5gcVVrWO0/gNKoZ4GvDieaO0kZEx2N0AaKUHHrejiCiQYFov8dw/m0VSUXZJ1OD8gf+/nae+2MM
        gXhc5zpw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q4yXH-001FrB-2i;
        Fri, 02 Jun 2023 06:45:22 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3E84630031F;
        Fri,  2 Jun 2023 08:45:16 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1FA23214120A1; Fri,  2 Jun 2023 08:45:16 +0200 (CEST)
Date:   Fri, 2 Jun 2023 08:45:15 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Noonan <steven@uplinklabs.net>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>, kernel@collabora.com
Subject: Re: Direct rdtsc call side-effect
Message-ID: <20230602064515.GA620383@hirez.programming.kicks-ass.net>
References: <6719fb05-382c-8ec4-ccda-72798906a54b@collabora.com>
 <87mt1jeax1.ffs@tglx>
 <87h6rrdoy0.ffs@tglx>
 <L9sTQNWVFoNxz-HmzFoXBX4twp84wuAx5Mf4LcxWw9k0rTAXI32rSl7WEOr7058iN6_Nyf8fLN-Ye3sq5THHjJCKG2vQLlpnVs77kKlLFV4=@uplinklabs.net>
 <20230601203127.GY4253@hirez.programming.kicks-ass.net>
 <YveIgyZYN48CEPKlxf6r_CfVBGuON83brWVxnVJGtXW70bDprPOiAtEMeKELDJj3lVYuZm7fTDQnMIuheMN01YfqfWbCGYia0uWcWIx59oM=@uplinklabs.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <YveIgyZYN48CEPKlxf6r_CfVBGuON83brWVxnVJGtXW70bDprPOiAtEMeKELDJj3lVYuZm7fTDQnMIuheMN01YfqfWbCGYia0uWcWIx59oM=@uplinklabs.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 01, 2023 at 09:41:15PM +0000, Steven Noonan wrote:
> On Thursday, June 1st, 2023 at 1:31 PM, Peter Zijlstra <peterz@infradead.=
org> wrote:
> > What about kernel based emulation? You could tie it into user_dispatch
> > and have a user_dispatch tsc offset.
> >=20
>=20
> > So regular kernel emulation simply returns the native value (keeps the
> > VDSO working for one), but then from a user_dispatch range, it returns
> > +offset.
> >=20
>=20
> > That is; how slow is the below?
>=20
> It's around 1800-1900 clock cycles on this system=20

Much more expensive than the actual instruction ofcourse, but that seems
eminently usable.

> (modified patch attached, compile fix + rdtscp support).

Right, that's what I get for writing 'patches' while falling asleep :/

> Since faulting would still make the vDSO clocks go through this path
> we'd have to be careful that whatever offsets we throw into this path
> don't affect the correctness of the other clocks.

Hence the suggested tie-in with user-dispatch; only add the offset when
the IP is from the user-dispatch range.

