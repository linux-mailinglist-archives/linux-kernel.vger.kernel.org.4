Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B159618D9C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 02:27:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbiKDB1q convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 3 Nov 2022 21:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiKDB1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 21:27:41 -0400
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B761923174
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 18:27:40 -0700 (PDT)
Received: from omf16.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay04.hostedemail.com (Postfix) with ESMTP id E00641A0286;
        Fri,  4 Nov 2022 01:27:38 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf16.hostedemail.com (Postfix) with ESMTPA id 981B32000D;
        Fri,  4 Nov 2022 01:27:10 +0000 (UTC)
Message-ID: <8a23b1d3ee853cee73385e8144338f399cbe3165.camel@perches.com>
Subject: Re: [PATCH] checkpatch: add warning for non-lore mailing list URLs
From:   Joe Perches <joe@perches.com>
To:     Peter Collingbourne <pcc@google.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Date:   Thu, 03 Nov 2022 18:27:35 -0700
In-Reply-To: <Y2RlxvPAvzVXtw9t@google.com>
References: <20221019202843.40810-1-helgaas@kernel.org>
         <Y2RlxvPAvzVXtw9t@google.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Stat-Signature: k5fbijti5u4cnio9x1rtsq7paj7gh18m
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 981B32000D
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX195DEQza47zJE3kAJu+iVXs3kMvJuV1/Y0=
X-HE-Tag: 1667525230-345043
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-11-03 at 18:07 -0700, Peter Collingbourne wrote:
> On Wed, Oct 19, 2022 at 03:28:43PM -0500, Bjorn Helgaas wrote:
> > From: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > The lkml.org, marc.info, spinics.net, etc archives are not quite as useful
> > as lore.kernel.org because they use different styles, add advertising, and
> > may disappear in the future.  The lore archives are more consistent and
> > more likely to stick around, so prefer https://lore.kernel.org URLs when
> > they exist.
> 
> If the commit message contains a line like:
> 
> Cc: linux-arm-kernel@lists.infradead.org
> 
> this patch causes checkpatch.pl to complain. Would it be possible to
> restrict this to URLs?

Yes, I believe this would probably work well enough:
---
 scripts/checkpatch.pl | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 7be93c3df2bcb..fe25642d8bacc 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3336,7 +3336,8 @@ sub process {
 		}
 
 # Check for mailing list archives other than lore.kernel.org
-		if ($rawline =~ m{\b$obsolete_archives}) {
+		if ($rawline =~ m{\b$obsolete_archives} &&
+		    $rawline !~ /^\s*cc:/i) {
 			WARN("PREFER_LORE_ARCHIVE",
 			     "Use lore.kernel.org archive links when possible - see https://lore.kernel.org/lists.html\n" . $herecurr);
 		}

