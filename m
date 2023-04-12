Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89D766DE92B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 03:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbjDLBxy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 11 Apr 2023 21:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjDLBxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 21:53:53 -0400
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D7A54C07
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 18:53:47 -0700 (PDT)
Received: from omf14.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay08.hostedemail.com (Postfix) with ESMTP id EE183140A95;
        Wed, 12 Apr 2023 01:53:45 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf14.hostedemail.com (Postfix) with ESMTPA id 7192032;
        Wed, 12 Apr 2023 01:53:43 +0000 (UTC)
Message-ID: <2b966f46a5f60de629681527bb00401830118947.camel@perches.com>
Subject: Re: [RFC PATCH] checkpatch: Support __initconst combined with
 struct definition
From:   Joe Perches <joe@perches.com>
To:     Andy Shevchenko <andy@kernel.org>,
        =?ISO-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>
Cc:     Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org,
        =?ISO-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>
Date:   Tue, 11 Apr 2023 18:53:42 -0700
In-Reply-To: <ZDVixjH5qLoy1jTW@smile.fi.intel.com>
References: <20230301094320.15954-1-bjorn@kernel.org>
         <ZDVixjH5qLoy1jTW@smile.fi.intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Rspamd-Queue-Id: 7192032
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Rspamd-Server: rspamout01
X-Stat-Signature: sy964tf6dhz9dnt7e8zigqqwn7xz8i3m
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19GLVU+nzrGdem+UwEVe+zM911VbiL4lys=
X-HE-Tag: 1681264423-285885
X-HE-Meta: U2FsdGVkX19GwP+aELnsxhseFU2M32tOO4PjvNCwiMPweENuspWK00zanBENykIOMWfhhEpA1DpKCsnbQUZdGw==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-04-11 at 16:38 +0300, Andy Shevchenko wrote:
> On Wed, Mar 01, 2023 at 10:43:20AM +0100, Björn Töpel wrote:
> > From: Björn Töpel <bjorn@rivosinc.com>
> > 
> > Checkpatch sometimes report a false positive for __initconst. E.g., for the
> > following snippet:
> > 
> >  | static const struct strspn_test {
> >  | 	const char str[16];
> >  | 	const char accept[16];
> >  | 	const char reject[16];
> >  | 	unsigned a;
> >  | 	unsigned r;
> >  | } tests[] __initconst = {
> >  | 	{ "foobar", "", "", 0, 6 },
> >  | 	{ "abba", "abc", "ABBA", 4, 4 },
> >  | 	{ "abba", "a", "b", 1, 1 },
> >  | 	{ "", "abc", "abc", 0, 0},
> >  | };
> > 
> > checkpatch would report:
> > 
> >  | ERROR: Use of __initconst requires a separate use of const
> >  | #190: FILE: ./test_string.c:190:
> >  | +	} tests[] __initconst = {
> > 
> > Improve the reporting by trying harder to find the 'const'.
> 
> Joe, what do you think about this?

I think the ctx_block_outer_rev  function doesn't handle patch
context blocks and the loop at best needs to be changed to include

	last if $rawlines[$line] =~ /^@/);.

And the loop parsing couldn't handle structs with embedded
unions or structs.

I also think that checkpatch will always have false negatives
and false positives and this might not be that useful as likely
most compilers should now be able to identify this as well.

