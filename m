Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E52F7088D3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 21:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbjERT66 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 18 May 2023 15:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjERT64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 15:58:56 -0400
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE41E45;
        Thu, 18 May 2023 12:58:54 -0700 (PDT)
Received: from omf10.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay03.hostedemail.com (Postfix) with ESMTP id 5B407A0989;
        Thu, 18 May 2023 19:58:53 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf10.hostedemail.com (Postfix) with ESMTPA id F2FA032;
        Thu, 18 May 2023 19:58:50 +0000 (UTC)
Message-ID: <cc2ebace1821381e2eaac0a774aa39818dc9dc12.camel@perches.com>
Subject: Re: [PATCH] checkpatch: Warn about 0-length and 1-element arrays
From:   Joe Perches <joe@perches.com>
To:     Kees Cook <keescook@chromium.org>,
        Andy Whitcroft <apw@canonical.com>
Cc:     Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Date:   Thu, 18 May 2023 12:58:49 -0700
In-Reply-To: <20230517204530.never.151-kees@kernel.org>
References: <20230517204530.never.151-kees@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Stat-Signature: puwyt1swyp41oowuiiowm11we38kzxpn
X-Rspamd-Server: rspamout08
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Rspamd-Queue-Id: F2FA032
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+QD/3IXieWNNZePhd0mmr+m+MoTjTlcfQ=
X-HE-Tag: 1684439930-789484
X-HE-Meta: U2FsdGVkX1/R7LzBAcxWckEg3KFE0ItBSO2do6msyznA+8otsM8C2GluhqU4y0waxsgNs9ZBDx2mAZIK9Up33w==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 * On Wed, 2023-05-17 at 13:45 -0700, Kees Cook wrote:
> Fake flexible arrays have been deprecated since last millennium. Proper
> C99 flexible arrays must be used throughout the kernel so
> CONFIG_FORTIFY_SOURCE and CONFIG_UBSAN_BOUNDS can provide proper array
> bounds checking.

I don't think this does what you want.

After adding this patch to checkpatch with this diff: No warning

-----------------------
diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 4f4f79532c6cf..513cb102b3b38 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -73,6 +73,11 @@ static DEFINE_SPINLOCK(target_list_lock);
 */
 static struct console netconsole_ext;
+struct foobar {
+ int a;
+ int b[1];
+};
+
 /**
 * struct netconsole_target - Represents a configured netconsole target.
 * @list: Links this target into the target_list.
-----------------------

because $context_function is DEFINE_SPINLOCK

I think you want something like:
---
 scripts/checkpatch.pl | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index b30114d637c40..778a0808c37cf 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -7418,6 +7418,18 @@ sub process {
 }
 }
+ # check for array definition/declarations that should use flexible arrays instead
+ if ($sline =~ /^[\+ ]\s*}\s*;\s*$/ &&
+ $prevline =~ /^\+\s*$Type\s*$Ident\s*\[\s*(0|1)\s*\]\s*;\s*$/) {
+ if ($1 =~ '0') {
+ WARN("ZERO_LENGTH_ARRAY",
+ "Prefer C99 flexible arrays instead of zero-length arrays - see https://github.com/KSPP/linux/issues/78\n" . $hereprev);
+ } else {
+ WARN("ONE_ELEMENT_ARRAY",
+ "Prefer C99 flexible arrays instead of one-element arrays - see https://github.com/KSPP/linux/issues/79\n" . $hereprev);
+ }
+ }
+
 # nested likely/unlikely calls
 if ($line =~ /\b(?:(?:un)?likely)\s*\(\s*!?\s*(IS_ERR(?:_OR_NULL|_VALUE)?|WARN)/) {
 WARN("LIKELY_MISUSE",

