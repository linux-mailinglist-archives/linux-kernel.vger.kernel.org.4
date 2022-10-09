Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66CE95F8EFD
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 23:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbiJIVrS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 9 Oct 2022 17:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbiJIVrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 17:47:14 -0400
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C39DA25C54;
        Sun,  9 Oct 2022 14:47:12 -0700 (PDT)
Received: from omf10.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay07.hostedemail.com (Postfix) with ESMTP id 3636E1602A7;
        Sun,  9 Oct 2022 21:47:11 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf10.hostedemail.com (Postfix) with ESMTPA id 5A2CF2F;
        Sun,  9 Oct 2022 21:46:37 +0000 (UTC)
Message-ID: <a3425582d1b1bf4eb3eb5a5813e01b1409ef56cc.camel@perches.com>
Subject: Re: kernel style preference trivia: '* const' vs '*const' ?
From:   Joe Perches <joe@perches.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-doc <linux-doc@vger.kernel.org>
Date:   Sun, 09 Oct 2022 14:47:08 -0700
In-Reply-To: <CANiq72=duGy7Rakm=JG9ifB4D5qufemKvXMfvpW3Ky7wZ4bXcQ@mail.gmail.com>
References: <9ff662d738612f0ed2cea39266768a2eff21edc3.camel@perches.com>
         <CANiq72=duGy7Rakm=JG9ifB4D5qufemKvXMfvpW3Ky7wZ4bXcQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Stat-Signature: 1q8tc4sp6skjdqg5qisoawj4ukmaqwcu
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 5A2CF2F
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/NsC8X6U5zlkd31K9xW+AJj9cPdq8iGLE=
X-HE-Tag: 1665351997-648461
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2022-10-09 at 18:52 +0200, Miguel Ojeda wrote:
> On Sun, Oct 9, 2022 at 6:21 PM Joe Perches <joe@perches.com> wrote:
> > 
> > The kernel uses '* const' about 10:1 over '*const'
> 
> Yeah, going with the most commonly used one sounds best.
> 
> clang-format will be able to handle either way with
> `SpaceAroundPointerQualifiers` as soon as the minimum is LLVM 12.

Perhaps the below.

Perhaps it should be a --strict only CHK, but the rest of the const
tests are WARN as well.

---
 scripts/checkpatch.pl | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 2737e4ced5745..eccd7940eb18b 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -4605,6 +4605,14 @@ sub process {
 			}
 		}
 
+# check for foo *const, prefer foo * const
+		if ($line =~ /\*const\b/) {
+			if (WARN("POINTER_CONST",
+				 "Prefer * const over *const\n" . $herecurr) &&
+			    $fix) {
+				$fixed[$fixlinenr] =~ s/\*const\b/* const/;
+			}
+		}
 # check for non-global char *foo[] = {"bar", ...} declarations.
 		if ($line =~ /^.\s+(?:static\s+|const\s+)?char\s+\*\s*\w+\s*\[\s*\]\s*=\s*\{/) {
 			WARN("STATIC_CONST_CHAR_ARRAY",
