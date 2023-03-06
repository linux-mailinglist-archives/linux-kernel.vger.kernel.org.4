Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B59516ABB7C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 11:16:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230412AbjCFKQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 05:16:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbjCFKPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 05:15:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F467DAB;
        Mon,  6 Mar 2023 02:15:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 32C2F60DBD;
        Mon,  6 Mar 2023 10:15:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C162EC433AA;
        Mon,  6 Mar 2023 10:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678097704;
        bh=gMn8LBo4YTVz4DCKbMOG8G2eyzp1G0ta2S/O8jCHVPo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i2TaLotztsUci/exTzbvk9XHqyKP3LCim+/r3AbtTx2DCWDp5H4PHEvbFsyO51sNp
         p8rbs/qYmr5RYL9B+Ib7kqYO/h5Mqx9tFRPGudGqigweySeDAjAlPpZJWwCap4LYH4
         I3U8G6hSaAiYdjG9AVDB6OqjG92pWLcdN/4KS8twDy76XcF5c/6mFfMWtaXuGDPsc2
         nAtAdDqt+KeQWlJaqaOg8tdJRLjfl/Mgj+k/0EGB/FfAlitpg0wHx956pRFsg8YuGv
         igujcesHHxhQad991EbKxKYbpS6I0kcZ1NLo1yhw4Kdrb/yA98gbH9lPjPA8YER5S7
         5wJI7DPfOi3Rg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 2/2] kallsyms: expand symbol name into comment for debugging
Date:   Mon,  6 Mar 2023 11:14:51 +0100
Message-Id: <20230306101451.375844-2-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230306101451.375844-1-arnd@kernel.org>
References: <20230306101451.375844-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The assembler output of kallsyms.c is not meant for people to understand,
and is generally not helpful when debugging "Inconsistent kallsyms data"
warnings. I have previously struggled with these, but found it helpful
to list which symbols changed between the first and second pass in the
.tmp_vmlinux.kallsyms*.S files.

As this file is preprocessed, it's possible to add a C-style multiline
comment with the full type/name tuple.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
No idea if there is already a better way to debug this kind of problem,
or if this causes a notable slowdown.
---
 scripts/kallsyms.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index a239a87e7bec..ea1e3d3aaa6b 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -525,7 +525,8 @@ static void write_src(void)
 					table[i]->addr);
 				exit(EXIT_FAILURE);
 			}
-			printf("\t.long\t%#x\n", (int)offset);
+			expand_symbol(table[i]->sym, table[i]->len, buf);
+			printf("\t.long\t%#x	/* %s */\n", (int)offset, buf);
 		} else if (!symbol_absolute(table[i])) {
 			output_address(table[i]->addr);
 		} else {
-- 
2.39.2

