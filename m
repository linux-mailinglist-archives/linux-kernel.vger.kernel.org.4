Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A57426123EA
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 16:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbiJ2OiT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 29 Oct 2022 10:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiJ2OiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 10:38:17 -0400
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E3416CD0B
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 07:38:16 -0700 (PDT)
Received: from omf12.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay10.hostedemail.com (Postfix) with ESMTP id 783E3C0110;
        Sat, 29 Oct 2022 14:38:14 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf12.hostedemail.com (Postfix) with ESMTPA id DCF0717;
        Sat, 29 Oct 2022 14:37:55 +0000 (UTC)
Message-ID: <efab1f11d5008188988813e3f3c27ce1297e71c0.camel@perches.com>
Subject: Re: [PATCH] Remove Unnecessary typecast of c90 int constant
From:   Joe Perches <joe@perches.com>
To:     Julia Lawall <julia.lawall@inria.fr>,
        UMWARI JOVIAL <umwarijovial@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev
Date:   Sat, 29 Oct 2022 07:38:10 -0700
In-Reply-To: <alpine.DEB.2.22.394.2210280918550.2845@hadrien>
References: <20221028063711.GA35659@rdm>
         <alpine.DEB.2.22.394.2210280918550.2845@hadrien>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Rspamd-Queue-Id: DCF0717
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Stat-Signature: 3kpugo777z3hb3xfdrd5mryxt7uasajh
X-Rspamd-Server: rspamout02
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18BJ6iGaBQ/gDxUl5GMVObh7DN5jwxKBPo=
X-HE-Tag: 1667054275-197456
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-10-28 at 09:22 +0200, Julia Lawall wrote:
> 
> On Fri, 28 Oct 2022, UMWARI JOVIAL wrote:
> 
> > According to Linux kernel coding style.
> > 
> > Reported by checkpatch:
> > WARNING: Unnecessary typecast of c90 int constant - '(int)2.412e8' could be '2.412e8'
> > WARNING: Unnecessary typecast of c90 int constant - '(int)2.487e8' could be '2.487e8'
> 
> It's not ideal to just include the checkpatch messges verbatim in your log
> message.  It woudl be better to say what you are doing and why, in
> complete sentences ("According to the Linux coding style" is not a
> complete sentence).
> 
> I also suspect that the checkpatch message is wrong.  Floating point
> numbers cannot be used in the kernel, and the case of the constant ensures
> that the value will be converted to an integer at compile time.

Yes, it's a checkpatch defect.

checkpatch should have this:
---
diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 4e187202e77a6..9958a774efaf1 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -6758,7 +6759,8 @@ sub process {
                }
 
 # check for cast of C90 native int or longer types constants
-               if ($line =~ /(\(\s*$C90_int_types\s*\)\s*)($Constant)\b/) {
+               if ($line =~ /(\(\s*$C90_int_types\s*\)\s*)($Constant)\b/ &&
+                   $2 !~ /^$Float$/) {
                        my $cast = $1;
                        my $const = $2;
                        my $suffix = "";

