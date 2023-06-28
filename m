Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CCD5740C49
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 11:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233712AbjF1JCo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 05:02:44 -0400
Received: from mout.gmx.net ([212.227.15.18]:51229 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232378AbjF1Isx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 04:48:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=s31663417; t=1687942102; x=1688546902; i=georgmueller@gmx.net;
 bh=Orm7HM4Nr5qYAqgg1QHWxvyxXfs8yHOeAyhjTr7spYE=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
 b=BnqufKbG8+w5OdhYgfQ0/q5PB3NbHkYgg3ayIwvWqrzSmch9Aoqbpduyk7SSdPI5nw8Ho/C
 15k2c2hgICztB1rTj1WVi/yeStN3STd2d0EGsNvwMFmp+c3n5RY+vbgTTLd6xFVp9YR7f+Klm
 4cMcHU8bWfjEn+4P2GzLfiKZKSWMDeRKdvMCDcyTAuzfxFqnyz258HeOM1b0fZGGuycXb++R1
 2dQcXyZ1xJ5DQwSINyGLcV0S+8Hwtt+ww4KMCTUx+P7+jXozMKza/bL+Q1mR1hu7IDVVCI+U4
 W7daR3pxdh+ZNPQxZNxVZAqwNY8ZRiboX0vgixea8Jk8dRi6BCGA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from nb-georg.intra.allegro-packets.com ([79.246.84.17]) by
 mail.gmx.net (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MqJqD-1picGz352x-00nRta; Wed, 28 Jun 2023 10:48:22 +0200
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
Subject: [PATCH v3 0/2] perf probe: fix regression introduced by switch to die_get_decl_file
Date:   Wed, 28 Jun 2023 10:45:48 +0200
Message-ID: <20230628084551.1860532-3-georgmueller@gmx.net>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vdftrqNrwacXojoahUi/4AkpDQu3lw+Y/s2Z1IVvGt6KQvVynFS
 rtFavbm/c7AeXK9HdBH9bJidr9gvJCpKBvJ9mp8z82Lwi0ehQ0blojMTi7jYKa95TXwa+A1
 H9MU6E8uSGhXONhgEAg+mt1d7bXiF/5rUeOpBtpsS7BozblVmvjLm8/BRhtYWoHjdNRms4s
 wI3Abn5TfsodWD2OsKN1A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:e1kA4nQkT8I=;VVYX0fnbzQkmQf1VF9YpEdGAw/Y
 deG7QHd3U8wl8KMJ7QFn8q45eUV2vzcYfw5CTlXBxM574c1FY5dzFjs1NIXoLMw2be9EGNEv0
 OlqGnQuXYzOr3MulmIuywb69sHbSSZ3vqP/MK4xoAK9qcUSee+nY5ZdSdjqUNHvFjKVdqVJqK
 2FU5Tn7gSYuVcZOs6iIFD9FewDyrhUv0xZysQlQk0yLZ/tPU3lRHbPnC8ChhA7xqeYWgXNXhB
 hIAMDfOCJwBVKkMA2DkGCoZimjTpCyiOUlPwnEUiqDkpBciHpY9rbyZT3eOkXnBRKW3XgdOhN
 5nVeKEGx6oI41J2kM/FQx+TKguw0R8VwInG5rUNPoS8lxp3i2ddeIzPOxYeJd8A+wxgJYWey8
 y8MQucB3hA2VHP5nQdmn2eLA8EIvtnN9F3R3NrrW81GSbH6CIy0ElsDX2VcUEAugNLU9Wg/bD
 AvimrSeX+EuOuzStgPoXmHD1CltAfj4UbHW/0j7XTSyjEL4Luii2oueDL5mLKTpc0VvKLXMxm
 LFl8cQppg2fs0AJZCnXbHh4WjIfq9qXkKfdqeR7MYGL1lQLGgd7G/mclSvyFOVEcLyQ1dU8Ka
 N50IomeSTVZYooqfr/pG7RLKzLdOLpUEtgq73zzcELHw5nw9t+sDkjTfjx514X2XB5ykXBWbe
 mhG4PshJagRHFUXnyjmNCNjKSmk9oAGYzcM/I2q1mkFMqrMCxhPkG1yWuxou3iWqPburpRYWf
 wB/oK7eW+QkS3CgBGdY9QSRcVb2+BPHR3QqfDifDpKPE+GMjyF446vNoQdv8C50FSrjnBZorP
 othd3Gm0gvbxUUwcZIyR5KON05WXnKyOzrU4HQjzabSJUmHoyytmMcgSEaL2+Lfbtbbdee3SI
 2GqiAIJfh+0dYhMa27/vQuOmzyk3UVZ6Ig+4ZegYHO34ydM+UUjw6XyliSAw8Z/ZBdk8soNLk
 DBGqroYY7+qlhHFAjm7BfDfuMlg=
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

Changes in v3:
 - start new thread
 - add stable to cc

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

