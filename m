Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4005C6736A3
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 12:20:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbjASLTz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 19 Jan 2023 06:19:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbjASLTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 06:19:44 -0500
Received: from ouvsmtp1.octopuce.fr (ouvsmtp1.octopuce.fr [194.36.166.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2BC16DB13;
        Thu, 19 Jan 2023 03:19:37 -0800 (PST)
Received: from panel.vitry.ouvaton.coop (unknown [194.36.166.20])
        by ouvsmtp1.octopuce.fr (Postfix) with ESMTPS id 7E630F7;
        Thu, 19 Jan 2023 12:19:35 +0100 (CET)
Received: from sm.ouvaton.coop (ouvadm.octopuce.fr [194.36.166.2])
        by panel.vitry.ouvaton.coop (Postfix) with ESMTPSA id 3554A5E1D6F;
        Thu, 19 Jan 2023 12:19:35 +0100 (CET)
MIME-Version: 1.0
Date:   Thu, 19 Jan 2023 11:19:34 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
From:   "Yann Droneaud" <ydroneaud@opteya.com>
Message-ID: <954f693d29923cfc538adacddb53acf84d767475@opteya.com>
Subject: Re: [RFC PATCH 0/4] random: a simple vDSO mechanism for reseeding
 userspace CSPRNGs
To:     "Andy Lutomirski" <luto@amacapital.net>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "Andy Lutomirski" <luto@kernel.org>,
        "Vincenzo Frascino" <vincenzo.frascino@arm.com>, x86@kernel.org,
        linux-crypto@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Florian Weimer" <fweimer@redhat.com>,
        "Adhemerval Zanella Netto" <adhemerval.zanella@linaro.org>,
        "Carlos O'Donell" <carlos@redhat.com>
In-Reply-To: <15F7D57C-8CC6-4CAE-8B7E-6F480B5F4133@amacapital.net>
References: <15F7D57C-8CC6-4CAE-8B7E-6F480B5F4133@amacapital.net>
 <585ddb35-adc5-f5cf-4db3-27571f394108@zytor.com>
X-Originating-IP: 10.0.20.16
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

16 janvier 2023 à 20:50 "Andy Lutomirski" <luto@amacapital.net> a écrit:
> > On Jan 13, 2023, at 7:16 PM, H. Peter Anvin <hpa@zytor.com> wrote:  
> >  On 1/12/23 11:55, Yann Droneaud wrote:
> > >  12 janvier 2023 à 18:07 "Jason A. Donenfeld" <Jason@zx2c4.com> a écrit:
> > > 
> > 
> >  Sorry Yann, but I'm not interested in this approach, and I don't think
> >  reviewing the details of it are a good allocation of time. I don't
> >  want to lock the kernel into having specific reseeding semantics that
> >  are a contract with userspace, which is what this approach does.
> > 
> > > 
> > > This patch adds a mean for the kernel to tell userspace: between the
> > >  last time you call us with getrandom(timestamp,, GRND_TIMESTAMP),
> > >  something happened that trigger an update to the opaque cookie given
> > >  to getrandom(timestamp, GRND_TIMESTAMP). When such update happen,
> > >  userspace is advised to discard buffered random data and retry.
> > >  The meaning of the timestamp cookie is up to the kernel, and can be
> > >  changed anytime. Userspace is not expected to read the content of this
> > >  blob. Userspace only acts on the length returned by getrandom(,, GRND_TIMESTAMP):
> > >  -1 : not supported
> > >  0 : cookie not updated, no need to discard buffered data
> > >  >0 : cookie updated, userspace should discard buffered data
> > >  For the cookie, I've used a single u64, but two u64 could be a better start,
> > >  providing room for implementing improved behavior in future kernel versions.
> > > 
> > 
> >  Please just let me iterate on my original patchset for a little bit,
> >  without adding more junk to the already overly large conversation.
> > 
> > > 
> > > I like the simplicity of my so called "junk". It's streamlined, doesn't
> > >  require a new syscall, doesn't require a new copy of ChaCha20 code.
> > >  I'm sorry it doesn't fit your expectations.
> > > 
> > 
> >  
> >  Why would anything more than a 64-bit counter be ever necessary? It only needs to be incremented.
> > 
> 
> This is completely broken with CRIU or, for that matter, with VM forking.
>

Which raise the question of the support of CRIU with Jason's vDSO proposal.

AFAIK CRIU handle vDSO[1] by interposing symbols so that, on restore, the process
will call the interposed functions, which will resolve the new vDSO's functions.

vgetrandom_alloc() would have been called before the checkpoint, allocating one
opaque state of size x. After the restore, the vDSO's getrandom() would be given
this opaque state, expecting it having size y. As the content of the opaque state
should have been cleared per MADV_WIPEONFORK, there's nothing in the state that
could help vDSO's getrandom() to achieve backward compatibility.

I think backward compatibility can be achieved by adding an opaque state size
argument to vDSO's getrandom().

What to think Jason ?

[1] https://criu.org/Vdso

Regards.

-- 
Yann Droneaud
OPTEYA
