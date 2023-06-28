Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 057D0740B76
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 10:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235065AbjF1I2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 04:28:52 -0400
Received: from mout.gmx.net ([212.227.17.21]:54491 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232429AbjF1I0a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 04:26:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=s31663417; t=1687940720; x=1688545520; i=georgmueller@gmx.net;
 bh=rccuTeBc2qWJPiTs6OkLsciVIrxOS1jPnpLyPXEhnBI=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=LTzY098c0e1hYKxfD2aBTN/5pAu1HVEilTieZoqL8BqcJvFRaTcQC2yQ7QTxCjcOw3rNl8N
 CJfBCzetAnjvubNZnPt2hGmGncDk69na8m211WtNyGQ8FReGqIDbDQK9BGtRr1bSS4ySUcm6d
 LCrcAB19ycFvN2+kBVLuNAAbWlfCbfJWy7hjdBg8KldIItRqKOGNkI4x3bU/OPUQQhfuAaCht
 YsvFzAgZlhRaYDXYBZEe+RdA/NRSQXNZug7flu6DuLuX+00rqQgBeQHGzRcvsDgac/4uxM31s
 laiGb+ohyllckzbI+KF7SrQDB5gaUK3iEydJKSe8a+v7vEUyBTqA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from nb-georg.intra.allegro-packets.com ([79.246.84.17]) by
 mail.gmx.net (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MzQgC-1psEro2tX6-00vN0t; Wed, 28 Jun 2023 10:25:20 +0200
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
Subject: [PATCH v2 0/2] perf probe: fix regression introduced by switch to die_get_decl_file
Date:   Wed, 28 Jun 2023 10:23:19 +0200
Message-ID: <20230628082337.1857302-1-georgmueller@gmx.net>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <5a00d5a5-7be7-ef8a-4044-9a16249fff25@gmx.net>
References: 
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zr1KAHTkPcR3jTbjiAtrdgiGmRMRocjMyQgCXDPPnQqFE2jGOej
 g0wkyiqzToTi5M3rSApy1To5lQXPrkLRPe/sO/eUqeuYwrlf/wAKcBdtQlGCWnNGnO7tAHA
 aZWmlPwBtJwvv/77BpECjpvJ12i93aqS7eV+qJ51RzUIuggioWmp3PNPj6QJIsr8QxavxuY
 SHzaDESBpdcjl49onkm6A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:/nWpDS/5WaU=;j6hoFROtSNxcprQHvvcuyFHibMz
 9rRid5vQ+tUXL2EPPgzt/xlsJogQa+icUGCX4L0qJpPHqFKYhwIwPOigVdNymkq6kw+wZ56I9
 13xWvmRlmvS4/dwxXCkemPG8jGJmMls1SdjDlxeXmMCDBDV5CREUFjwbQtsgVtSSWw0Ec3zXn
 BZDrxlnoOvdHhnevAHoGgh53taiE1+YpoCG4wUY23Gke1I3Ew9kMluNyi7W+lh8WwAWzq3aVo
 B6tH0gWl4lS253NJJmj3lq8PurNItHbT2WhJc1UMmx1jgOeKQbKZ2tAbS/pBeAspay6Ejb7tS
 RtaQL/2JrZwUZfS1WKjbT+E3roPdnS+JpzwEYGe2nkEmUkFDEEmx7Est13dnsYt9eps7knJ7K
 Z43L8lAxRttwGklMo7ZznmZdJ9e0QWE+4h7S0Yk7zQA+6nWIsOR08YXMt3L2Rr90MaFY6Gxa2
 qnOiByd2+v3oTfLAfvTeZbOOmOIoIY0F/fmdCZSWqyEqm6bFtbPm3ZVZdKZUcr4AiY6zDr2cu
 dwS20qX6zl/omf+YsGDlVIJyJr6VpblN1RHrKGtMoWdJG0ZGX3C+NYqE8khthc4Jcl1z2qb9R
 se6vtMtZ7joqOYndXnyyE+YvhHkzWW6XXmJaQwWb+GUgihODhKbTA3nrzClhZzX3hkznuzgg9
 +27aZzl4TR3sxLWJNEj3E+IU1TpKhDC7NvGVjSZ5Y7J0q+zxvwMFXYGreKCXo/B1oD1NawZrE
 3DAmU0JJxuRTrBdfPFO2VyUsaCW+YvaOP2lenD9FEghlNtBye7/jocbGR9pHboxwsnk79DjnN
 bWzFeIb+lJH1mcmpadsaVN2aUtyWwQ7++5YKLJumEzqPiLt+hFP9h0pOypJZVZ+OnK1y+watu
 COHYxA1YDL86HK5l1oFtXoXpfvG6bxbNQ652bhviivWYrqVRQqSjRAXRWG4zrPwtPUcNGgdst
 kdLGYQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When switching from dwarf_decl_file() to die_get_decl_file(), a regression
was introduced when having a binary where the DWARF info is split to
multiple CUs. It is not possible to add probes to certain functions.

These patches introduce a testcase which shows the current regression
and a fix for the issue

Signed-off-by: Georg M=C3=BCller <georgmueller@gmx.net>
Link: https://lore.kernel.org/r/5a00d5a5-7be7-ef8a-4044-9a16249fff25@gmx.n=
et/

=2D--
Changes in v2:
 - Add testcase

Georg M=C3=BCller (2):
  perf probe: add test for regression introduced by switch to
    die_get_decl_file
  perf probe: read DWARF files from the correct CU

 .../shell/test_uprobe_from_different_cu.sh    | 77 +++++++++++++++++++
 tools/perf/util/dwarf-aux.c                   |  4 +-
 2 files changed, 80 insertions(+), 1 deletion(-)
 create mode 100755 tools/perf/tests/shell/test_uprobe_from_different_cu.s=
h

=2D-
2.41.0

