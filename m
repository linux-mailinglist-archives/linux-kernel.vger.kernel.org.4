Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE7A5E71C6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 04:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232226AbiIWCMB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 22 Sep 2022 22:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231491AbiIWCL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 22:11:57 -0400
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 031CA105D78;
        Thu, 22 Sep 2022 19:11:55 -0700 (PDT)
Received: from omf12.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay07.hostedemail.com (Postfix) with ESMTP id C9E20160333;
        Fri, 23 Sep 2022 02:11:51 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf12.hostedemail.com (Postfix) with ESMTPA id 7D8BE19;
        Fri, 23 Sep 2022 02:11:41 +0000 (UTC)
Message-ID: <3179f4545d3f71358da3e6c6ee18085af601b2eb.camel@perches.com>
Subject: Re: [PATCH v1 3/3] checkpatch: warn on usage of VM_BUG_ON() and
 other BUG variants
From:   Joe Perches <joe@perches.com>
To:     John Hubbard <jhubbard@nvidia.com>,
        David Hildenbrand <david@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        David Laight <David.Laight@ACULAB.COM>,
        Jonathan Corbet <corbet@lwn.net>,
        Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Date:   Thu, 22 Sep 2022 19:11:44 -0700
In-Reply-To: <d0c59eb8-baca-26fd-5f10-4a1f89bcf7b9@nvidia.com>
References: <20220920122302.99195-1-david@redhat.com>
         <20220920122302.99195-4-david@redhat.com>
         <d0c59eb8-baca-26fd-5f10-4a1f89bcf7b9@nvidia.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-Stat-Signature: me7gijswwjx78bt11de9ttdkeerub4ce
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 7D8BE19
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        KHOP_HELO_FCRDNS,SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+TmJmbnGkm+LNw6VlDjRWiozpu+WDNQbw=
X-HE-Tag: 1663899101-987245
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-09-22 at 19:05 -0700, John Hubbard wrote:
> On 9/20/22 05:23, David Hildenbrand wrote:
> > checkpatch does not point out that VM_BUG_ON() and friends should be
> > avoided, however, Linus notes:
> > 
> >     VM_BUG_ON() has the exact same semantics as BUG_ON. It is literally
> >     no different, the only difference is "we can make the code smaller
> >     because these are less important". [1]
> > 
> > So let's warn on VM_BUG_ON() and other BUG variants as well. While at it,
> > make it clearer that the kernel really shouldn't be crashed.
> > 
> > As there are some subsystem BUG macros that actually don't end up crashing
> > the kernel -- for example, KVM_BUG_ON() -- exclude these manually.
> > 
> > [1] https://lore.kernel.org/r/CAHk-=wg40EAZofO16Eviaj7mfqDhZ2gVEbvfsMf6gYzspRjYvw@mail.gmail.com
[]
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> > @@ -4695,12 +4695,12 @@ sub process {
> >  			}
> >  		}
> >  
> > -# avoid BUG() or BUG_ON()
> > -		if ($line =~ /\b(?:BUG|BUG_ON)\b/) {
> > +# do not use BUG() or variants
> > +		if ($line =~ /\b(?!AA_|BUILD_|DCCP_|IDA_|KVM_|RWLOCK_|snd_|SPIN_)(?:[a-zA-Z_]*_)?BUG(?:_ON)?(?:_[A-Z_]+)?\s*\(/) {
> 
> Should this be a separate patch? Adding a bunch of exceptions to the BUG() rules is 
> a separate and distinct thing from adding VM_BUG_ON() and other *BUG*() variants to
> the mix.

Not in my opinion.

> >  			my $msg_level = \&WARN;
> >  			$msg_level = \&CHK if ($file);
> >  			&{$msg_level}("AVOID_BUG",
> > -				      "Avoid crashing the kernel - try using WARN_ON & recovery code rather than BUG() or BUG_ON()\n" . $herecurr);
> > +				      "Do not crash the kernel unless it is unavoidable - use WARN_ON_ONCE & recovery code (if reasonable) rather than BUG() or variants.\n" . $herecurr);
> 
> Here's a requested tweak, to clean up the output and fix punctuation:
> 
> "Avoid crashing the kernel--use WARN_ON_ONCE() plus recovery code (if feasible) instead of BUG() or variants.\n" . $herecurr);

Fixing punctuation here would be removing the trailing period as checkpatch
only has periods for multi-sentence output messages.

And I think that "Do not crash" is a stronger statement than "Avoid crashing"
so I prefer the original suggestion but it's not a big deal either way.
