Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6EFD6AB39C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 01:05:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbjCFAF0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 5 Mar 2023 19:05:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCFAFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 19:05:25 -0500
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 108D1F97A
        for <linux-kernel@vger.kernel.org>; Sun,  5 Mar 2023 16:05:23 -0800 (PST)
Received: from omf06.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay06.hostedemail.com (Postfix) with ESMTP id C0A2AAAA90;
        Mon,  6 Mar 2023 00:05:21 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf06.hostedemail.com (Postfix) with ESMTPA id BFBE02000F;
        Mon,  6 Mar 2023 00:05:19 +0000 (UTC)
Message-ID: <3e32e97858d5bf9d88cc03136d7abc7af2dd7f30.camel@perches.com>
Subject: Re: Infinite loop in checkpatch.pl
From:   Joe Perches <joe@perches.com>
To:     Alexander Potapenko <glider@google.com>
Cc:     apw@canonical.com, dwaipayanray1@gmail.com,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Sun, 05 Mar 2023 16:05:18 -0800
In-Reply-To: <CAG_fn=XDzM_+nXpypPFG95r7EKRWhPGd7C=JZOy7kYrpcC+XDQ@mail.gmail.com>
References: <CAG_fn=WZnBtRujLyhouz1AmerSKB71oPej442JDOw2OaORbWQg@mail.gmail.com>
         <e1be073e8e53da8dcdd9e37ffc6e60d1375c59bb.camel@perches.com>
         <CAG_fn=XDzM_+nXpypPFG95r7EKRWhPGd7C=JZOy7kYrpcC+XDQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Rspamd-Queue-Id: BFBE02000F
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Stat-Signature: gei575jwhuswx4mepa47sbjug36g14jk
X-Rspamd-Server: rspamout02
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18KGFOPzr8VeZ6OI+4dfIa0YXDGjNgHspM=
X-HE-Tag: 1678061119-842173
X-HE-Meta: U2FsdGVkX1+QWtGF35Cs5P6Bp12xO2T57XFNmV40Oo500rMx8evZEU0eLQaUvAUUk/KY0n2hplAbVUAIc2juKg==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-03-03 at 21:53 +0100, Alexander Potapenko wrote:
> On Fri, Mar 3, 2023 at 5:53 PM Joe Perches <joe@perches.com> wrote:
> > 
> > On Fri, 2023-03-03 at 15:28 +0100, Alexander Potapenko wrote:
> > > Hi folks,
> > > 
> > > I've noticed that checkpatch.pl chokes on the following file (also attached):
> > > 
> > > ==================================
> > > $ cat test-checkpatch.txt
> > > diff --git a/mm/kmsan/kmsan_test.c b/mm/kmsan/kmsan_test.c
> > > @@ -504,6 +504,25 @@ static void
> > > test_memcpy_aligned_to_unaligned2(struct kunit *test)
> > > + EXPECTATION_NO_REPORT(expect);                              \
> > > + volatile uint##size##_t uninit;                             \
> > 
> > checkpatch isn't a syntax complete c parser.  Don't expect to be.
> 
> That's understandable, and I sure don't. But as a user I expect it to
> not loop infinitely, and I think that's also reasonable.
> The example I gave is not a randomly generated code snippet, but an
> excerpt from a valid patch that I sent earlier today:
> https://lore.kernel.org/lkml/20230303141433.3422671-4-glider@google.com/,
> which checkpatch cannot process.

I think this may be appropriate instead.  Andy W?
---
 scripts/checkpatch.pl | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index bd44d12965c98..3328fb9f6d048 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -999,7 +999,9 @@ if (defined($typedefsfile)) {
 }
 
 sub build_types {
-	my $mods = "(?x:  \n" . join("|\n  ", (@modifierList, @modifierListFile)) . "\n)";
+	my $mods = "(?x:  \n" . join("|\n  ", @modifierList);
+	$mods .= "|(?^:  \n" . join("|\n  ", @modifierListFile) . "\n)" if ($#modifierListFile >= 0);
+	$mods .= ')';
 	my $all = "(?x:  \n" . join("|\n  ", (@typeList, @typeListFile)) . "\n)";
 	my $Misordered = "(?x:  \n" . join("|\n  ", @typeListMisordered) . "\n)";
 	my $allWithAttr = "(?x:  \n" . join("|\n  ", @typeListWithAttr) . "\n)";
