Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69FB6740B99
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 10:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234795AbjF1Idb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 04:33:31 -0400
Received: from mout.gmx.net ([212.227.17.22]:48355 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233251AbjF1I0M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 04:26:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=s31663417; t=1687940741; x=1688545541; i=georgmueller@gmx.net;
 bh=98KXRWjP0kOEQZ8kuG25m3smr7Z8TVhKXrD0YboZOGQ=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=hX0kUFBiLDtRX51ldhFiSrYF6QWnp+dLaADGVtwatP/L/5amPzBjG1/T2Sbry577AkIHZMi
 NbuNd9/xDNyTNtfah1RnG8bXFHBRNHUnxqhsq/Y975qctmwmmCfxyFQRo4mXMrHOQuonSvvzG
 rR+HGfN4hsnmmNeBN9pznKD1Dyi68xB6ocWcz02yW4L+9hAqQS2QdJ0juSTJSwKgIaaMBdiKu
 160/7YblYgRsE4T+lcSbxHEnNJ6sb5IL/8Dgbd1M9d7X6ISxujU6DwgsnDOkjaAaoNM+rVNSV
 Uje3vuljz4tLAZ+cJlhE+lUc5IIVRPEMV6Rm/HOx0yLniD81c3UQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from nb-georg.intra.allegro-packets.com ([79.246.84.17]) by
 mail.gmx.net (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MuDbx-1pvEaH3v01-00uZni; Wed, 28 Jun 2023 10:25:41 +0200
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
Subject: [PATCH v2 2/2] perf probe: read DWARF files from the correct CU
Date:   Wed, 28 Jun 2023 10:23:21 +0200
Message-ID: <20230628082337.1857302-3-georgmueller@gmx.net>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230628082337.1857302-1-georgmueller@gmx.net>
References: <20230628082337.1857302-1-georgmueller@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:swNPtqTzzUzCv4pfzxsJG/x/5jAfwGu0ZfcztYEMdOjLgSxEXCe
 QDrK2UkKJF0fe1Iab9TKFHdwex6PHzaJeyKPEgCrwzD5PLjX9oAIiLKYZwu3Nyq6G38bdPA
 O2DsDeojLIosc6MnjvY7aVlo7RLt/1W1AJA4Lr5cut9euulcal22CcwM9tx+1KEG1kwQfdh
 SZeqTROH1YpAQ5+zlXRUA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:nKs9a50mBPM=;dvQ75/Odc81iVL18grQnWrkOykC
 72eozC5BZbDnaqHaRpV8mh5yulUVHMZYildFlAL2BEWHi9V4V87/lE1XzhDQak+a7+0ehWi9Q
 C3knHDfJ7jq1HxROv9iI282NANepGgQnyfjKIvwcfO+2lT9Tk2B+8+buI9bIbsEm2+nzREmiI
 IOxWROcZ3MTE2LbZqGQ1npfKztueoD69NaR+gp6IdM78dF2/aj7DwEFn8cwuwGhskCRChCKD9
 qAuu7EDk3DwNPHgarkAyZT+zaFVfGWcvjd0dbXJjd02VSc1e58/a0IrTDlqYGu7ql/WNDi3KW
 1WpwkVh5s+7nXj4phEQxJXYWbyNf/Glx2tM6lKUfs8mVpweMC13DZHXA28lHniohvWzKnLHEi
 qCM+VVDcPzMF6flr8KshQvw7Klv8wc2loIGIJ0YGPn3FnIt3E3BSZ2T6G67a4cKKC3/tdy7PH
 C642jyUzBrMQbYYvgDeVH/CpEBjE1eb0lKdF8+zibgpKnMQMJ4zsMDHHhmFEb6cmn0Ox3ua5h
 023ATy+hLGCxlrsYbAlouP5OARS9XOJSzmMnzYHO/7iEPRkcHs3WXIF2MC9LO5i62zgW46P8H
 ZGFjPB8iawsdD/xO3DTXj+RUiGtUx0POjb/kxfsWVlRDAIopHPsRKraoTBOCierM1WDGQ4l6S
 Yiwql10/Ccys2KenwJQPa4MTHcyYGZ6WL/r5MAAblY5Tx6YMzsdMjmuXtbXl7ywL+mqnmPB+w
 dQXHy9Hm5Ghg4obqWXUPJ2rCiuXnanFtIe16OczjLHcKdYrWxmwQsgSa4DthuhPGhBcr8ijuo
 azEsaKdEqVwnG7eLYDbHjiAX2xtrl2+Gw6NCG9iM7e+EiRoWJRK0pRL9wGvLkb5GvU2CqdeP/
 epi2MXjS6CtScNVvV2hE+x2koHqRH5gg4QTv+gUyEBeNMlaZk0nL2gUK+RExetI7aLronGDW5
 G59eCt9weOXLj5Bsp2jg+pjaeRY=
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

