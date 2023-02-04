Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E3C368AB6B
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 17:58:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231953AbjBDQ6I convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 4 Feb 2023 11:58:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231355AbjBDQ6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 11:58:06 -0500
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D28142D67
        for <linux-kernel@vger.kernel.org>; Sat,  4 Feb 2023 08:58:03 -0800 (PST)
Received: from omf11.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay04.hostedemail.com (Postfix) with ESMTP id 8D1C51A03C4;
        Sat,  4 Feb 2023 16:58:02 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf11.hostedemail.com (Postfix) with ESMTPA id 33C562002C;
        Sat,  4 Feb 2023 16:58:00 +0000 (UTC)
Message-ID: <3afee0493d3718f2e38b6c54dab23d38360cd5d0.camel@perches.com>
Subject: Re: [PATCH] checkpatch.pl: Relax commit ID check to allow more than
 12 chars
From:   Joe Perches <joe@perches.com>
To:     Jonathan =?ISO-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Sat, 04 Feb 2023 08:57:59 -0800
In-Reply-To: <78d224a63f6c27bf700d59007b6f3c89746d728c.camel@perches.com>
References: <20230129123431.1282427-1-j.neuschaefer@gmx.net>
         <78d224a63f6c27bf700d59007b6f3c89746d728c.camel@perches.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Stat-Signature: tn5jxtttymtks9rscjht3g9z7wghnbfa
X-Rspamd-Server: rspamout06
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Rspamd-Queue-Id: 33C562002C
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1855V0Wf5GK0uNZM3DquGABqIbYZv6TBNY=
X-HE-Tag: 1675529880-423293
X-HE-Meta: U2FsdGVkX19gwgiaSca2JRaEbMRHAcolcYgRwC4uciRprs9AGZ7OphjjUgbheEqH2JU7ib0Q5P1ykREu6rWsag==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2023-01-29 at 09:52 -0800, Joe Perches wrote:
> On Sun, 2023-01-29 at 13:34 +0100, Jonathan Neuschäfer wrote:
> > By now, `git log --pretty=%h` (on my copy of linux.git) prints commit
> > hashes with 13 digits, because of the number of objects.
> > 
> > Relax the rule in checkpatch.pl to allow a few more digits (up to 16).
> 
> NAK without updating the process docs first.

btw: it looks like 12 will still be sufficient for awhile yet

$ git count
total 1154908
$ git -c core.abbrev=5 log --pretty=format:%h | \
  perl -nE 'chomp;say length' | sort | uniq -c | sort -n -k2
    198 5
 664613 6
 450955 7
  36667 8
   2312 9
    155 10
      8 11

