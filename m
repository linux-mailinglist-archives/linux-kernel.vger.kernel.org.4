Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 385106FBC77
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 03:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233808AbjEIB0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 21:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233265AbjEIB0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 21:26:43 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACAE0903C;
        Mon,  8 May 2023 18:26:39 -0700 (PDT)
From:   "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683595598;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uStzLe1tmofW57614nQAyaAY3eSlDqWR3vQxVmQVS1Y=;
        b=xWNjFDl1s1ucegfBKQoncawd3d6If9tExr6i3v7IB0erVNUwt3jWQ6xpT9t2axmBV47Egz
        Qzzf/6eG0TQWoOSYHLyK98dgGPoWq8ZPdbKnLBF+bFMDkBIgUD80KfV3P4fHDLcVFEmJ1Q
        HKAZoci+2bpbtZ1iv9kQZ1koL34GE6y4AbhhEK5SRuKp1S60+KjRB4v/8MHrfVlyzt/aOm
        ewEZc6123SiU/pGCMhBFSqfDRsFxyVECyL0IWFbGbVRWNXoAghfj67OM2jzDVwAQAmoiQ0
        hUyDmEWmdirizxsc1O1FFxo+AItwBn1ssPhe+phW2iue7vCxNDt/PUrrF1BIfg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683595598;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uStzLe1tmofW57614nQAyaAY3eSlDqWR3vQxVmQVS1Y=;
        b=WJiot4UYEtS47knJadY85GFMDZjw4ZAVKGi64k8JHj3oZMySdSuYS/Vb8RZso5Gw1ThPCM
        4eHRjiXqk7nTejDw==
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kbuild@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        "Ahmed S. Darwish" <darwi@linutronix.de>
Subject: [PATCH v2 1/2] scripts/tags.sh: Resolve gtags empty index generation
Date:   Tue,  9 May 2023 03:26:15 +0200
Message-Id: <20230509012616.81579-2-darwi@linutronix.de>
In-Reply-To: <20230509012616.81579-1-darwi@linutronix.de>
References: <20230504201833.202494-1-darwi@linutronix.de>
 <20230509012616.81579-1-darwi@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gtags considers any file outside of its current working directory
"outside the source tree" and refuses to index it. For O= kernel builds,
or when "make" is invoked from a directory other then the kernel source
tree, gtags ignores the entire kernel source and generates an empty
index.

Force-set gtags current working directory to the kernel source tree.

Due to commit 9da0763bdd82 ("kbuild: Use relative path when building in
a subdir of the source tree"), if the kernel build is done in a
sub-directory of the kernel source tree, the kernel Makefile will set
the kernel's $srctree to ".." for shorter compile-time and run-time
warnings. Consequently, the list of files to be indexed will be in the
"../*" form, rendering all such paths invalid once gtags switches to the
kernel source tree as its current working directory.

If gtags indexing is requested and the build directory is not the kernel
source tree, index all files in absolute-path form.

Note, indexing in absolute-path form will not affect the generated
index, as paths in gtags indices are always relative to the gtags "root
directory" (as evidenced by "gtags --dump").

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Cc: <stable@vger.kernel.org>
---
 scripts/tags.sh | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/scripts/tags.sh b/scripts/tags.sh
index ea31640b2671..3de4b4ebd891 100755
--- a/scripts/tags.sh
+++ b/scripts/tags.sh
@@ -32,6 +32,14 @@ else
 	tree=${srctree}/
 fi
 
+
+# gtags(1) refuses to index any file outside of its current working dir.
+# If gtags indexing is requested and the build output directory is not
+# the kernel source tree, index all files in absolute-path form.
+if [ "$1" = "gtags" -a -n "${tree}" ]; then
+	tree=$(realpath $tree)/
+fi
+
 # Detect if ALLSOURCE_ARCHS is set. If not, we assume SRCARCH
 if [ "${ALLSOURCE_ARCHS}" = "" ]; then
 	ALLSOURCE_ARCHS=${SRCARCH}
@@ -131,7 +139,11 @@ docscope()
 
 dogtags()
 {
-	all_target_sources | gtags -i -f -
+	local gtagsoutdir="${PWD}"
+	local gtagsroot="${tree}"
+
+	[ -z "${gtagsroot}" ] && gtagsroot="."
+	all_target_sources | gtags -i -C $gtagsroot -f - $gtagsoutdir
 }
 
 # Basic regular expressions with an optional /kind-spec/ for ctags and
-- 
2.40.0

