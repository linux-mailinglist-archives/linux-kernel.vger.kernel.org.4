Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE9AD61DC61
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 18:24:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbiKERYj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 5 Nov 2022 13:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiKERYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 13:24:37 -0400
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E69E12607
        for <linux-kernel@vger.kernel.org>; Sat,  5 Nov 2022 10:24:36 -0700 (PDT)
Received: from omf01.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay06.hostedemail.com (Postfix) with ESMTP id D4435AB30C;
        Sat,  5 Nov 2022 17:24:34 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf01.hostedemail.com (Postfix) with ESMTPA id A4EF56000F;
        Sat,  5 Nov 2022 17:24:30 +0000 (UTC)
Message-ID: <85bcafd00fbbf9c8199ce9d10cfa959791a1b96a.camel@perches.com>
Subject: Re: [PATCH -next v2] checkpatch: Add check for array allocator
 family argument order
From:   Joe Perches <joe@perches.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Liao Chang <liaochang1@huawei.com>, apw@canonical.com,
        dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, bagasdotme@gmail.com,
        pbonzini@redhat.com
Date:   Sat, 05 Nov 2022 10:24:27 -0700
In-Reply-To: <dc5a7c79-af45-0e64-80fa-9f1ca8907033@wanadoo.fr>
References: <20221104070523.60296-1-liaochang1@huawei.com>
         <dc5a7c79-af45-0e64-80fa-9f1ca8907033@wanadoo.fr>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Rspamd-Queue-Id: A4EF56000F
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Stat-Signature: qpg798amgqsubot9hhmhmznmhzf8ej6p
X-Rspamd-Server: rspamout02
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/getu2nSdF+wC3drRumdtbYGUc//3UCgg=
X-HE-Tag: 1667669070-101770
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-11-04 at 18:08 +0100, Christophe JAILLET wrote:
> Le 04/11/2022 à 08:05, Liao Chang a écrit :
> > These array allocator family are sometimes misused with the first and
> > second arguments switchted.
> > 
> > Same issue with calloc, kvcalloc, kvmalloc_array etc.
> > 
> > Bleat if sizeof is the first argument.
> > 
> > Link: https://lore.kernel.org/lkml/5374345c-7973-6a3c-d559-73bf4ac15079@redhat.com/
> > Signed-off-by: Liao Chang <liaochang1@huawei.com>
> > Acked-by: Joe Perches <joe@perches.com>
> > ---
> > v2:
> > 1. Acked-by Joe Perches.
> > 2. Use lore links in Link tag.
> > 
> > ---
> >   scripts/checkpatch.pl | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > index 1e5e66ae5a52..a9a9dc277cff 100755
> > --- a/scripts/checkpatch.pl
> > +++ b/scripts/checkpatch.pl
> > @@ -7128,7 +7128,7 @@ sub process {
> >   		}
> >   
> >   # check for alloc argument mismatch
> > -		if ($line =~ /\b((?:devm_)?(?:kcalloc|kmalloc_array))\s*\(\s*sizeof\b/) {
> > +		if ($line =~ /\b((?:devm_)?((?:k|kv)?(calloc|malloc_array)(?:_node)?))\s*\(\s*sizeof\b/) {
> >   			WARN("ALLOC_ARRAY_ARGS",
> >   			     "$1 uses number as first arg, sizeof is generally wrong\n" . $herecurr);
> >   		}
> 
> Hi,
> 
> Should the devm_ and not devm_ cases be separated?
> 
> In the devm_case, sizeof will never be just after the first '('.

Right.

Likely this works better:
---
 scripts/checkpatch.pl | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 7be93c3df2bcb..7f37976a9f8b5 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -7145,12 +7145,18 @@ sub process {
 			     "Reusing the krealloc arg is almost always a bug\n" . $herecurr);
 		}
 
-# check for alloc argument mismatch
-		if ($line =~ /\b((?:devm_)?(?:kcalloc|kmalloc_array))\s*\(\s*sizeof\b/) {
+# check for alloc argument mismatch in alloc functions
+		if ($line =~ /\b(((?:k|kv)?(calloc|malloc_array)(?:_node)?))\s*\(\s*sizeof\b/) {
 			WARN("ALLOC_ARRAY_ARGS",
 			     "$1 uses number as first arg, sizeof is generally wrong\n" . $herecurr);
 		}
 
+# check for alloc argument mismatch in devm_ alloc functions
+		if ($line =~ /\b(devm_((?:k|kv)?(calloc|malloc_array)(?:_node)?))\s*\(\s*$FuncArg\s*,\s*sizeof\b/) {
+			WARN("ALLOC_ARRAY_ARGS",
+			     "$1 uses number as second arg, sizeof is generally wrong\n" . $herecurr);
+		}
+
 # check for multiple semicolons
 		if ($line =~ /;\s*;\s*$/) {
 			if (WARN("ONE_SEMICOLON",

