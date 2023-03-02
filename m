Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E77E26A89BC
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 20:46:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbjCBTqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 14:46:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjCBTqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 14:46:42 -0500
Received: from vulcan.natalenko.name (vulcan.natalenko.name [IPv6:2001:19f0:6c00:8846:5400:ff:fe0c:dfa0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F7E0168B5;
        Thu,  2 Mar 2023 11:45:54 -0800 (PST)
Received: from spock.localnet (unknown [83.148.33.151])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id 26D0D1251A42;
        Thu,  2 Mar 2023 20:45:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1677786349;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Lwk05NDKiJ+Dz6W3pRoHDF7STJZCibWKfIpahhJPNMM=;
        b=wrIscrOk4++AgxbUBlJw/7I3xktNaykgyH2aH3nOVPsS29SXwg7Rmi/JXNohRoBq7eO5in
        t5A4+BTFKDpRtjygREIlDGBzXwC7UY0btqWRGqvav1KqwrRdAfghtT7h1Sui48OKdgZOwz
        uLzaJKgJ5s0Ld+Ywl3WUz/GHmJ3ZW0I=
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, hpa@zytor.com,
        Stephane Eranian <eranian@google.com>,
        Wyes Karny <wyes.karny@amd.com>
Cc:     x86@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, gautham.shenoy@amd.com,
        ananth.narayan@amd.com,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Wyes Karny <wyes.karny@amd.com>
Subject: Re: [RFC PATCH v2 0/2] Enable Core RAPL for AMD
Date:   Thu, 02 Mar 2023 20:45:47 +0100
Message-ID: <2670154.mvXUDI8C0e@natalenko.name>
In-Reply-To: <20230301181449.14647-1-wyes.karny@amd.com>
References: <20230301181449.14647-1-wyes.karny@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

On st=C5=99eda 1. b=C5=99ezna 2023 19:14:47 CET Wyes Karny wrote:
> This is v2 patch set for enabling per-core RAPL counters through
> energy-cores event on RAPL PMU. Added RFC tag because a new patch is
> added and this additional patch may need clarification from the
> community.
>=20
> While enabling this support with v1 patch [1], Stephane reported an
> issue where for the first reading of energy-cores event for every core was
> invalid [2]. This issue is addressed with patch 1 of this series. There
> is no change in patch 2.
>=20
> [1]: https://lore.kernel.org/lkml/20230217161354.129442-1-wyes.karny@amd.=
com/
> [2]: https://lore.kernel.org/lkml/CABPqkBQ_bSTC-OEe_LrgUrpj2VsseX1ThvO-yL=
cEtF8vb4+AAw@mail.gmail.com/
>=20
> Change log:
> v1 -> v2:
> - Added new patch to fix the issue reported by Stephane
> - Added RFC tag
>=20
> Wyes Karny (2):
>   perf/x86/rapl: Fix energy-cores event
>   perf/x86/rapl: Enable Core RAPL for AMD
>=20
>  arch/x86/events/rapl.c | 20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)

Since I was asked to re-test v2:

```
$ sudo perf stat -a --per-core -C 0-15 -e power/energy-cores/ -- dd if=3D/d=
ev/zero of=3D/dev/null bs=3D1M count=3D1000000
1000000+0 records in
1000000+0 records out
1048576000000 bytes (1,0 TB, 977 GiB) copied, 17,0321 s, 61,6 GB/s

Performance counter stats for 'system wide':

S0-D0-C0              1               6,67 Joules power/energy-cores/
S0-D0-C1              1             197,93 Joules power/energy-cores/
S0-D0-C2              1              11,32 Joules power/energy-cores/
S0-D0-C3              1              13,88 Joules power/energy-cores/
S0-D0-C4              1              12,40 Joules power/energy-cores/
S0-D0-C5              1               5,10 Joules power/energy-cores/
S0-D0-C6              1               3,92 Joules power/energy-cores/
S0-D0-C7              1               5,65 Joules power/energy-cores/
S0-D0-C8              1               4,91 Joules power/energy-cores/
S0-D0-C9              1              57,18 Joules power/energy-cores/
S0-D0-C10             1             174,95 Joules power/energy-cores/
S0-D0-C11             1               3,58 Joules power/energy-cores/
S0-D0-C12             1               5,41 Joules power/energy-cores/
S0-D0-C13             1               5,33 Joules power/energy-cores/
S0-D0-C14             1               2,89 Joules power/energy-cores/
S0-D0-C15             1               5,61 Joules power/energy-cores/

17,034519241 seconds time elapsed
```

Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>

Thanks.

=2D-=20
Oleksandr Natalenko (post-factum)


