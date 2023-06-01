Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08D05718FD7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 03:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbjFABGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 21:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjFABGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 21:06:31 -0400
X-Greylist: delayed 103 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 31 May 2023 18:06:28 PDT
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E77119
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 18:06:28 -0700 (PDT)
X-QQ-mid: bizesmtp70t1685581457trmehb6e
Received: from localhost.localdomain ( [112.226.6.6])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 01 Jun 2023 09:04:15 +0800 (CST)
X-QQ-SSF: 01200000000000B0J000000A0000000
X-QQ-FEAT: JLSCbNHoLcDNOd2oUAvDOT/7RABR1rYhxrNDE7mnragaK9lvTSmoDIJtP4MiF
        leSc4QLMYtVWlKX9VSTSWXbBGJ7+nHlqzJrI74MfxtYs92ntbDdDKsXZKgk6hVbAyFohRwg
        KjF1MFJMasScKzQ+UnNHMqwKjBH4LKBHAdqG0/L4xu35Hh5zjhm4wJrZxkRIC+9tUgm1/r5
        ugcwYfW5anB7LS3ES8oIl9xfZeh8Hm3aecDopIGOTm0BFNYY1DGj7HDszVglqZO94KSc8oh
        Z9CZzzLhRJnVIYi1NASAJrpDGxd5kovpNJpf0Rgl+3GrH935R4MpJAWHIhPiJqsRdb99ipf
        Ywjskb+OKqGOJUxBN+eB35QoqjQFQ==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16329342022388256243
From:   Jialu Xu <xujialu@vimux.org>
To:     gregkh@linuxfoundation.org, cristian.ciocaltea@collabora.com,
        masahiroy@kernel.org, vipinsh@google.com, cmllamas@google.com
Cc:     linux-kernel@vger.kernel.org, Jialu Xu <xujialu@vimux.org>
Subject: [PATCH] scripts/tags.sh: improve compiled sources generation
Date:   Thu,  1 Jun 2023 09:04:02 +0800
Message-Id: <20230601010402.71040-1-xujialu@vimux.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:vimux.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use grep instead of sed for all compiled sources generation, it is three
times more efficient.

Signed-off-by: Jialu Xu <xujialu@vimux.org>
---
 scripts/tags.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/tags.sh b/scripts/tags.sh
index ea31640b2671..938dba219534 100755
--- a/scripts/tags.sh
+++ b/scripts/tags.sh
@@ -98,7 +98,7 @@ all_compiled_sources()
 	{
 		echo include/generated/autoconf.h
 		find $ignore -name "*.cmd" -exec \
-			sed -n -E 's/^source_.* (.*)/\1/p; s/^  (\S.*) \\/\1/p' {} \+ |
+			grep -Poh '(?<=^  )\S+|(?<== )\S+[^\\](?=$)' {} \+ |
 		awk '!a[$0]++'
 	} | xargs realpath -esq $([ -z "$KBUILD_ABS_SRCTREE" ] && echo --relative-to=.) |
 	sort -u
-- 
2.30.2

