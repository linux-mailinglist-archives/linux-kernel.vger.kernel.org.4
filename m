Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15EFC6ABB7A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 11:16:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbjCFKQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 05:16:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbjCFKPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 05:15:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10FC922796;
        Mon,  6 Mar 2023 02:15:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A9E26B80D79;
        Mon,  6 Mar 2023 10:15:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F225C433EF;
        Mon,  6 Mar 2023 10:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678097701;
        bh=b8mXcWVvr64LaGiDwsadENDYgpIdOC4YHwo1Q1/sMko=;
        h=From:To:Cc:Subject:Date:From;
        b=Zu8k0Tkvwvb7q/J3jqm9DD2lkIqZIAlMvxqxd5XXdq73BDVe0QUNbtzGWGoFP02g3
         koG9v303G5KWhlmKVFlT86hN3WYUu9HUFUMT7g/S6GRYbUpKX0StsddRz8GENQ5BuJ
         qSzMuiFAPw9LJvUEZsq9pPZt0fc2PRqBhq/8JR44oJDIOw7J566ABaXhX4Izx95Z0W
         Zhz6Q6MY9fXKeB6TgU176iwoTWo8d2T6hkvpBW3WuRUl5D+eWwf5Yme3M0NA8yeHYk
         KIvTEXTn0UN2rnnPxTly3dYqqkdCbjmfDjgq1Zg6Dq5CvBAql1ac7OiYKuxmb/9nzO
         oRGkeAvIk+VwA==
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
Subject: [PATCH 1/2] kallsyms: add kallsyms_seqs_of_names to list of special symbols
Date:   Mon,  6 Mar 2023 11:14:50 +0100
Message-Id: <20230306101451.375844-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
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

My randconfig build setup ran into another kallsyms warning:

Inconsistent kallsyms data
Try make KALLSYMS_EXTRA_PASS=1 as a workaround

After adding some debugging code to kallsyms.c, I saw that the recently
added kallsyms_seqs_of_names symbol can sometimes cause the second stage
table to be slightly longer than the first stage, which makes the
build inconsistent.

Add it to the exception table that contains all other kallsyms-generated
symbols.

Fixes: 60443c88f3a8 ("kallsyms: Improve the performance of kallsyms_lookup_name()")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 scripts/kallsyms.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index 8a68179a98a3..a239a87e7bec 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -119,6 +119,7 @@ static bool is_ignored_symbol(const char *name, char type)
 		"kallsyms_markers",
 		"kallsyms_token_table",
 		"kallsyms_token_index",
+		"kallsyms_seqs_of_names",
 		/* Exclude linker generated symbols which vary between passes */
 		"_SDA_BASE_",		/* ppc */
 		"_SDA2_BASE_",		/* ppc */
-- 
2.39.2

