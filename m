Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE37732099
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 22:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231853AbjFOUHH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 16:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbjFOUHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 16:07:04 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4737C1BC;
        Thu, 15 Jun 2023 13:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=s31663417; t=1686859594; x=1687464394; i=georgmueller@gmx.net;
 bh=SF7krEugBcbEaty+ms7t8FwsytmGbU50M+05W/OeTBE=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=qA0MsTm+jGrZa0eDpOEaQ5qIb4acTUPAzVBpRm9WzolE+XPtZhOKs2cgRs8rUXT8EwTULWc
 6fbtIKZLRhVL3Xn28/QtVM+omdTsy7NQDSREvxlzdJXQUIfkouZNUWPjJI35Uppl14u6thyc9
 w4mJHh3V/UnO4M5XQpW8d/sXD/w3vUkQRZev7NwzRHrX1DUohzEGLRbB9E0DDwqeDNSTPgiRx
 gLQiGmJrL/24qDfWgV4RcY4ay6NrINXMTm+6Qvm3GUH+FW7s4ZI9LH7yBEPD1PPsasYSG0gVD
 j/4rssY2ZKhr/+9zTsurF2qHOw9YiIr8kGa1501nugt0UBTYiu+Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from nb-georg.home ([109.104.48.14]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MZktZ-1qery11niJ-00WpM1; Thu, 15
 Jun 2023 22:06:34 +0200
From:   =?UTF-8?q?Georg=20M=C3=BCller?= <georgmueller@gmx.net>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     =?UTF-8?q?Georg=20M=C3=BCller?= <georgmueller@gmx.net>,
        regressions@lists.linux.dev,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] perf probe: read DWARF files from the correct CU
Date:   Thu, 15 Jun 2023 22:01:37 +0200
Message-ID: <20230615200147.664346-3-georgmueller@gmx.net>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <5a00d5a5-7be7-ef8a-4044-9a16249fff25@gmx.net>
References: 
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qr7vePAVHWLbBcxjvp+SEeQGn7f3KAGrgNQCrHKaN0cRxabhpm0
 y2kIA+nrDbuHzg/PW3dnJvQPbGIZgQgMv3Pr1Sa3c70hSLMaVyWdEJ3eWULNtuOIndn4tS5
 h/gEPNdr75YLYKicEuwW7Cm5+sw1IFTxLDJ7u0MFmhh/7k+iDsTdQ//VsVxoi0S0Ku4jXBO
 4/sOMZFF+0nZq85crWRjw==
UI-OutboundReport: notjunk:1;M01:P0:QjZSc8JTKTA=;S5arEdPf+pvu6Wm9xZTj45kLxqT
 XIjUARnXit25nPRwDnkttjxXN8GGpSaD8QXcdImjtiROA++E14qlQVSDLQC7mk1fIZStz18vF
 0U2PoYQq3LXIvfOPzFeLgoXesjC/XJWTyZkX2yabnHT627Z09bB5lHoq2ObVcAHuLN1zaRhbj
 Z3zQi/7cMgJVWvI/9EXQo6iWWm9ymbpMm012420w3PVjmC78lz71dc/iL0AdZ3dLR9R7vb2Sd
 TBfUiVxRqzKSlqCKyUMyPZ/vmDRpmdOKUSOtKV838kaFttgVk+M9kifqjwb3UsUWZcyPyvxTp
 QODCJ6m3U9RsVooI8NK8s6VVOcep+rdbQkc/LYS3HmbQpe6txupNPkW9Ujn33Y7nXoHFTV8su
 RaHhXCAKdl8XQUw+n08rhr7Ror5EDuyuU5PX7dlZWACtZO/U6BUbYdvibMxUyuqifJ96ZiGpL
 2MsqZGXELthkXWjvtLU2ydL15PbLCxkO7g4TfEciyLPjVLVONf/dCj6gJqj9HDwjRTniyshjw
 aoIxt+HIOesAYwN/biU3X4jtYcfy23QzixdprME+LN5GFewJxtu6jOGDMHO+3qoSUoPNYAhm7
 d8vOeub71g1gTAVstfFFnt0QUWFSY5tzpRecQxRfBt68GGHjNN14dvdIOXjh5IG02qEdAYTEH
 fcgNsGmW0+LLrTYK6SfKKwvl4SyL3ZqWUTN59n6gAIPMPSIHCtKlbPsOBJtqv3dtrkTqKQ/S5
 J3+0D9tTX/iNAtBtrc1T3Vt4vhUhxn/NVtQ20rHZ4Rbv8t3gd2zIBppVlEuF8fAte7xPiXN/7
 hYNVoxtUOLlE2ywQe8/bRtHZKVaxlc0wQsEj+m+HlTLglxDe5Z4pFLVFSuhnfrqYhtnx5yIUT
 HzkzhOQVIXoUGJ9IE6DU/skarnzTkWJQHbNgTeqqzq+fznrHB04EMcj6wrL5W6G23k/N8ttyZ
 /rh/wA==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After switching from dwarf_decl_file() to die_get_decl_file(), it is not
possible to add probes for certain functions of certain binaries:

 $ perf probe -x /usr/lib/systemd/systemd-logind match_unit_removed
 A function DIE doesn't have decl_line. Maybe broken DWARF?
 A function DIE doesn't have decl_line. Maybe broken DWARF?
 Probe point 'match_unit_removed' not found.
    Error: Failed to add events.

The problem is that die_get_decl_file() uses the wrong CU to search for
the file. elfutils commit e1db5cdc9f has some good explanation for this:

    dwarf_decl_file uses dwarf_attr_integrate to get the DW_AT_decl_file
    attribute. This means the attribute might come from a different DIE
    in a different CU. If so, we need to use the CU associated with the
    attribute, not the original DIE, to resolve the file name.

This patch uses the same source of information as elfutils: use attribute
DW_AT_decl_file and use this CU to search for the file.

Fixes: dc9a5d2ccd5c ("perf probe: Fix to get declared file name from clang=
 DWARF5")
Signed-off-by: Georg M=C3=BCller <georgmueller@gmx.net>
Link: https://lore.kernel.org/r/5a00d5a5-7be7-ef8a-4044-9a16249fff25@gmx.n=
et/
=2D--
 tools/perf/util/dwarf-aux.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
index b07414409771..137b3ed9897b 100644
=2D-- a/tools/perf/util/dwarf-aux.c
+++ b/tools/perf/util/dwarf-aux.c
@@ -478,8 +478,10 @@ static const char *die_get_file_name(Dwarf_Die *dw_di=
e, int idx)
 {
 	Dwarf_Die cu_die;
 	Dwarf_Files *files;
+	Dwarf_Attribute attr_mem;

-	if (idx < 0 || !dwarf_diecu(dw_die, &cu_die, NULL, NULL) ||
+	if (idx < 0 || !dwarf_attr_integrate(dw_die, DW_AT_decl_file, &attr_mem)=
 ||
+	    !dwarf_cu_die(attr_mem.cu, &cu_die, NULL, NULL, NULL, NULL, NULL, NU=
LL) ||
 	    dwarf_getsrcfiles(&cu_die, &files, NULL) !=3D 0)
 		return NULL;

=2D-
2.41.0

