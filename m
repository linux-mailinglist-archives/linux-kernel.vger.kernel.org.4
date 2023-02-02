Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF22B688507
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 18:04:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232178AbjBBREK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 2 Feb 2023 12:04:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbjBBREI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 12:04:08 -0500
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56679442F2
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 09:04:03 -0800 (PST)
Received: from omf09.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay01.hostedemail.com (Postfix) with ESMTP id 425A01C6891;
        Thu,  2 Feb 2023 17:04:02 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf09.hostedemail.com (Postfix) with ESMTPA id 6447C2002B;
        Thu,  2 Feb 2023 17:03:59 +0000 (UTC)
Message-ID: <14023b12a84a23dd083f90a631d36604aed83747.camel@perches.com>
Subject: Re: Checkpatch errors that should be downgraded
From:   Joe Perches <joe@perches.com>
To:     David Howells <dhowells@redhat.com>,
        Andy Whitcroft <apw@canonical.com>
Cc:     linux-kernel@vger.kernel.org
Date:   Thu, 02 Feb 2023 09:03:58 -0800
In-Reply-To: <1068166.1675336573@warthog.procyon.org.uk>
References: <1068166.1675336573@warthog.procyon.org.uk>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Rspamd-Queue-Id: 6447C2002B
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Rspamd-Server: rspamout03
X-Stat-Signature: 81dk81h436ojyoxrnymskuudtdfie1gk
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19EQOv3lU/de8RsiEmOUL9A4QhMGLmBQuI=
X-HE-Tag: 1675357439-875552
X-HE-Meta: U2FsdGVkX1+bVFOovNh2oLxKIoT0zNB/hGPMEqM0usiNnVoKUiwEcxBhIbXRGxxnXap1NNePgCjR3OikhHaQsg==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-02-02 at 11:16 +0000, David Howells wrote:
> In the trace headers, the following should probably be ignored:
> 
> 	CHECK: Lines should not end with a '('
> 	#73: FILE: include/trace/events/rxrpc.h:1947:
> 	+	    TP_STRUCT__entry(
> 
> 	CHECK: Lines should not end with a '('
> 	#80: FILE: include/trace/events/rxrpc.h:1954:
> 	+	    TP_fast_assign(
> 
> as it's standard practice to bump the contents onto the next line for these
> two macros.

trace has its own grammar.
Might as well ignore all of it.

> Also checkpatch is wrong in giving this error:
> 
> 	ERROR: Macros with complex values should be enclosed in parentheses
> 	#37: FILE: include/trace/events/rxrpc.h:425:
> 	+#define rxrpc_sack_traces \
> 	+	EM(rxrpc_sack_advance,			"ADV")	\
> 	+	EM(rxrpc_sack_fill,			"FIL")	\
> 	+	EM(rxrpc_sack_nack,			"NAK")	\
> 	+	EM(rxrpc_sack_none,			"---")	\
> 	+	E_(rxrpc_sack_oos,			"OOS")
> 
> as the contents, when found in a trace header, are going to be used to
> generate a string table and maybe an enum.  It's standard practice, so if it
> could be ignored in trace headers or at least downgraded to a warning?

Don't care.

There are lots of weird macros that don't fit the typical uses
like this not just for trace weirdness.

Maybe:

---

 scripts/checkpatch.pl | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index a2fc7d5561267..126a8d4c07ce0 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3876,6 +3876,9 @@ sub process {
 			}
 		}
 
+# trace include files use a completely different grammar/style
+		next if ($realfile =~ m{/trace/.*\.h$} || $realfile =~ m{trace\.h$});
+
 # check for assignments on the start of a line
 		if ($sline =~ /^\+\s+($Assignment)[^=]/) {
 			my $operator = $1;

