Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85875740C52
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 11:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233926AbjF1JEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 05:04:25 -0400
Received: from mout.gmx.net ([212.227.15.19]:45821 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233129AbjF1Itp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 04:49:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=s31663417; t=1687942157; x=1688546957; i=georgmueller@gmx.net;
 bh=7EYxf2mbjFZfjlwtXaTopEVdIniSJTqMoHEmr5pnAAQ=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=jbLHvXBonqIsNYqv0cmDGf/lc9iYbCb+tMrlV+CXWUXPsekXscsvvKbMjufE1ptSNfrYxR1
 UyMXqBzcrvlrlb5o1IRC+BVc9tA0YsXhValMK+n64dPvKKMcw7SvuNQsb6rkzxI0YUziAQAQy
 1o9ws4uxeZ0gpB5a9se8wxayp/VS57iSM+m1Y2Pmks+pL2Nr8H5KObuc4UUMY8WlzpqAzRsD1
 rqU+NlODhWyL2W2vJ6vsjy5t6GLogH7hjtOf50hmhuxA5nfB+43ecTycsMki+16j/J/UNnGTf
 YuwpVXKc1d/vbskYnHyXG+0jczHi0tW7uhp+SsCT2K9im+M/fHrw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from nb-georg.intra.allegro-packets.com ([79.246.84.17]) by
 mail.gmx.net (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1Msq2E-1puR8P1nKq-00tBRZ; Wed, 28 Jun 2023 10:49:17 +0200
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
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH v3 2/2] perf probe: read DWARF files from the correct CU
Date:   Wed, 28 Jun 2023 10:45:51 +0200
Message-ID: <20230628084551.1860532-6-georgmueller@gmx.net>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230628084551.1860532-3-georgmueller@gmx.net>
References: <20230628084551.1860532-3-georgmueller@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Cb82SGcEsrL11zuH0JhYn8EPvv7SYgVIiYe39ozfB6jCOHBRCG3
 tdBkdi7oMnRW+phUL09ePfExRcxv1JtDBLya3Woi1NpS/u2jFhx1jcsiuFRqmkSVLzmnqbe
 bwyisMG9/BYJriHw3Mf4q8UuPv3OyvXg2esjKwIzlywis/rh3EhFh+Sh1s0HqD0zPm0yQOY
 7UNmWN3HPHoS4XPyv+9Cg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:lcY/W0j30Co=;e7msvmEaR+Q9xqySdxbTx8k8St5
 BOvJXLrzS5VRpHvvuT1aMLe4qblAsZeqsHSyXNQBnfDYnx+XknZJgVsr9ZFuGlFVSyu1RQaYY
 NBzSp3SxlUwSjwUK0vyMaS1ENVzkesXBAw0iFkUHaz98HWRMgW+LqZF9k7dxLRONffu+AnaSr
 LN9S3iPhOy+ByS2cV53aPdWF5AWly1iNIG7Ydm/VepxRdwLq9xqQ7GVgx3nx79xNYylws3t9m
 6BjaLY3geW3davNGhyUbWmRWtPqsfArZwuqv+ahKdLRrya39fZdq6XOqMdWZ94KlZdvWgdkOX
 vgFqH23DqvhJlGRy6+S3TPGfOnqHgymMidK27BF2FaXriit2OGC2hfxhx9xHMUW7LPxh9Z695
 d/1G/mB/i+x5ddSjSpXQBEr2SlsEy2PXBcGWhi5srm7c2296Aqm0Q7pR8HsorvA/Kz7ITBlr6
 EGgE+5dC4k6Iay/2D0ZjPQuBRMaLojzmOskpnmoNhbueCxVxrvVro8jGniSzU3qGZUVyxZ6lL
 Tk7nnqu8TR1RGMCnzjCVYQfX8N8SCdvnQGidZxuOSTVeZfzViIxyD4TCDoV0nWlUQb7tcvXd+
 xyujVGIwReFJ6SkfX7SkRPxPxU0lxxEEaCVfKWlRX464ieccxO9PumWXC1tbEqfgWqP3nSqdu
 s3hCrBXsdvn0BWdn8DOZWIabNqfKJXg+u5kTj5QsYgmI20d32LGTHKgKUiDhT9zbcpmgQBlj8
 x2G6ossF6QZhOcZ/S9JJJOWl5ZQyd0lEBXs+8NRf7PYryP6SOroAcI7M0z1fQZhI9AGzzL4fb
 CVEymTXwgKAoVyo9+I/kS3Ca05Hh8KfW1Z7MbfPL0Ah8ulKph89Lr2EVDnooztVUaXiyML4EN
 o/sJviXjoALTHcR5cJw+O2RCP3bb1ydbH/bA8UWEklxJnFNBprYR36JR5sgAnw11NqaOKZ1S8
 c6QLcpQW7nc6X+nUMvACIWYYPmg=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After switching from dwarf_decl_file() to die_get_decl_file(), it is not
possible to add probes for certain functions:

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
Cc: stable@vger.kernel.org
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

