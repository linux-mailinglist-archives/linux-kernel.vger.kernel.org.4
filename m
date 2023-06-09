Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7AB57299BB
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 14:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240505AbjFIMWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 08:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240431AbjFIMV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 08:21:58 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 179D5210D;
        Fri,  9 Jun 2023 05:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=s31663417; t=1686313292; x=1686918092; i=georgmueller@gmx.net;
 bh=rDJ96Ond18rti0M0ERtO5yAhZ7vSgGDs74k8wtklLaA=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=HDtUWG55ofayJttAlrqBl7m1HtZoGsiTdGqaWH4/p/VA8RsCQrKTACPgBhYK+YMlvTGIlX1
 j5uXYlpzqJQsBUHasIk+pPrh2W56x4PgVIhE/sJDiEXtAsdXrYHqqDETJLc0/VXALevMjGGt2
 /WnO7zLBJj9qx0y0iFQWRGYPze1iC9e+sEa3Z2GC2Fi0Wa9tZdkhxXqCsNvL7bVwoN9Rurv1O
 FBdlRvP5yyJ/baSDHvaFCdZEsPKJwHuiKU0/BOBjATYBO6Qh7x0aE2qx/XEOQp1ePNk45a2OF
 k7fXdSA5werNWCjrYHowDwuxKHR6scs80ROmGwV1EFN7vb7WoyCw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.54.0.101] ([79.246.89.172]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MrhQ6-1pmrIu16qC-00nkDC; Fri, 09
 Jun 2023 14:21:32 +0200
Message-ID: <5a00d5a5-7be7-ef8a-4044-9a16249fff25@gmx.net>
Date:   Fri, 9 Jun 2023 14:21:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 3/3] tools/perf: Fix to get declared file name from
 clang DWARF5
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
References: <166731050151.2100653.8202870942871353491.stgit@devnote3>
 <166731052936.2100653.13380621874859467731.stgit@devnote3>
Content-Language: en-US
From:   =?UTF-8?Q?Georg_M=c3=bcller?= <georgmueller@gmx.net>
In-Reply-To: <166731052936.2100653.13380621874859467731.stgit@devnote3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4YgK/ryWsH9FYmn+Uvzb6n4O/gu9LSWq35UPCgte30kDd9x2/Fn
 6Qo7lUkXlG4H0u05zCBb3IrHuyhew9B99nKdKc2EeexO3p4EHy+JZoVKly5KftUy3+zJsBb
 ExZ1RcwoSCj/6lOc+QyqWZ6D9qL7yiqLuarR6R852mTCeJSCg1G6r2syD4mG3PF/1BMGxEs
 AoRbY+V4cYRhUF+iLR3PQ==
UI-OutboundReport: notjunk:1;M01:P0:rPVGmtrfnhk=;+FiGbdS4umrSz0yeBOLaZJLLOJO
 o7opFQwJ5SKBd9p7F6u63m2PZ5kZBeybH+GPVct7XNWNF3XxOIpR/PGslJ3f0a+/VovW7ZpWq
 b2sc3blbASpD0M5Ki1PKHlCAr6OCo0zFL/AxWNOxgz3m7ncr3fijgIGssJD4LPQd0aATx8F+0
 TJ1zobZwm9wwl0H3Wm/aOq42Z/5gt+PlARbiaKs0embDnGUrv/fYAj/Q/C9GELlIWsFnpDNO+
 JhKkgshJGillPi6dhw/KwQYP10uIzF/w88vFyzdZrPPmAWzFqIc56GskI7BcMl2WcW8E/sf4u
 GzWg8dl8IOEnnEmWjjckkT07Re5xgDzxP1T+B48mne23z0QpafS7xIQXbZo7WbJ/QckCrU5C1
 3w7nqKYYa0yIXbJZzQlTO9OTYApGx/k1mclUzvZWVqJVjbhFPZOGXtOalzPIvCnwxux3aMb80
 bflfqTF0gFkpgurDWTe1FHE89YenUU2p++eBKKqXNNFyJ7czLLUSthBAPzL/ZLPHfiPypTZKJ
 dZgliEAuxmk0x3mB5VR07S4rTKh9xq0Fz1cSI86NHwFq8dzkiWFCU4Zwm/pDrsSPqb4R3sPtd
 Kx1mpL7Ca05xX0HNPjLIOGT8odYoEpq03BxU2AYD168hTp6lS5scRQV5kmj8gWFK4B9hlSwUq
 9iflACzYmk0reWKSwBl36s7YHqhgyMahYkVq4RretDDE7rLdW0KyUDeBK63l50qL1mimqnaEw
 8ZkIv41ujCZcbHFmzqLWTVUqOLu3Q9DCMV/7UgElcfogRbpQtayc9vpW42q38EnnqC5KRMoka
 vsZrYbj1MJz2nJGy3rPuBz5I/bsBQxh9fUn4zfqqOZrUwafudu8kPF85b4q7lZibozTfAAFtU
 QazWfb1VnSj2C95NxmwLEiNa2b4D9XWVcd0YxpJQfJtvUeBswLJMdKCPVUosezTomFkpKQB2g
 u0dcyAsZH8Wxfjx95j+2dnzcHTI=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am 01.11.22 um 14:48 schrieb Masami Hiramatsu (Google):
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>
> Fix to get the declared file name even if it uses file index 0
> in DWARF5, using custom die_get_decl_file() function.
>

this patch breaks perf probe on fedora 38.

I was trying to a add a probe to systemd-logind using kernel-6.3.6-200.fc3=
8.x86_64 with kernel-tools-6.3.3-200.fc38.x86_64.

When trying to add a probe, I get the following message:

# perf probe -x /usr/lib/systemd/systemd-logind --funcs=3D"match_unit_remo=
ved"
match_unit_removed

Function exists and was found:

# perf probe -x /usr/lib/systemd/systemd-logind match_unit_removed
A function DIE doesn't have decl_line. Maybe broken DWARF?
A function DIE doesn't have decl_line. Maybe broken DWARF?
Probe point 'match_unit_removed' not found.
   Error: Failed to add events.

When reverting dc9a5d2ccd5c823cc05cafe75fcf19b682d8152c, I was able to add=
 the probe point:

# ./perf probe -x /usr/lib/systemd/systemd-logind match_unit_removed
Added new event:
   probe_systemd:match_unit_removed (on match_unit_removed in /usr/lib/sys=
temd/systemd-logind)

You can now use it in all perf tools, such as:

	perf record -e probe_systemd:match_unit_removed -aR sleep 1


Probe point is then visible with and without this commit:

# perf probe -l
   probe_systemd:match_unit_removed (on match_unit_removed in /usr/lib/sys=
temd/systemd-logind)
# ./perf probe -l
   probe_systemd:match_unit_removed (on match_unit_removed@../src/login/lo=
gind-dbus.c in /usr/lib/systemd/systemd-logind)


Best regards,
Georg
