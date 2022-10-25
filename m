Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7E7F60C280
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 06:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbiJYEMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 00:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiJYEMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 00:12:36 -0400
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2D9C4D4E3;
        Mon, 24 Oct 2022 21:12:33 -0700 (PDT)
Received: by mail-oo1-f52.google.com with SMTP id v8-20020a4ab688000000b00486ac81143fso609353ooo.1;
        Mon, 24 Oct 2022 21:12:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I+n3ELpnrMQZ9UlUM+88jrlsmKbPc2HnIditUU8hHxo=;
        b=ZabQiwBNbE8egXjQLE0EsOY6VYoIhSdBChxKeSGonyF23olE5aqQWBP7aGRXxTewt9
         SCNQhtk/FzbkZi499/2MtNGaLMfTAv9v1aLpkUuO2uU3oMasLauMHPL0B+WkJqW7WcHr
         6dKDx0OJ6gsWgvf/eBmWrDlmiofWNaTX2b8V35y4XfwKLSvz8FU7BCp4c5Vh/2+UOCX2
         chntskEmalEbCdNwoLPZbvS0xEqYXX6VdMPnoHrvpip+IK39W5qCGSTznQfNVjzXovLy
         7G1MzavB7ijFdm5AO8M3GoLTgPe2xUn609yotRrhVvPcEYMm/mvfYWyUz+sJERPv8M/M
         l52g==
X-Gm-Message-State: ACrzQf0JC+QQtJwH/2P82vdxco28GIP9sSapgI5TvZw/TwHzxnFmuoFl
        7WOCec8nWFNQy/gbVi8DXPINgqSgIiceyvG4qRE=
X-Google-Smtp-Source: AMsMyM4a+TrRji3DXcaLtkdv+PXEKCRuKgatUYfE767a0ILZ6tgQBCGXswqANrxmm4UEpJ3eCWe1HhVqB5xFrGumx4c=
X-Received: by 2002:a4a:b4cd:0:b0:476:8f72:5b60 with SMTP id
 g13-20020a4ab4cd000000b004768f725b60mr15884896ooo.58.1666671153179; Mon, 24
 Oct 2022 21:12:33 -0700 (PDT)
MIME-Version: 1.0
References: <20221020172643.3458767-1-namhyung@kernel.org> <20221020172643.3458767-4-namhyung@kernel.org>
 <CAP-5=fWKCdyFzR8ZZSK_2v6vT_RKngxxnXGieUVb8PBATJ64eQ@mail.gmail.com>
 <Y1Z3/t4RtnB8r03t@kernel.org> <960317d2-1bf8-cc2a-8772-8d0f5a136b6b@intel.com>
 <Y1a2lmO/dmjEiZb0@kernel.org>
In-Reply-To: <Y1a2lmO/dmjEiZb0@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 24 Oct 2022 21:12:21 -0700
Message-ID: <CAM9d7cidzNM1XJbcouF47HY0UHH_EoYjx=3FYMJOm3q4f+Cu+w@mail.gmail.com>
Subject: Re: [PATCH 3/8] perf test: Use a test program in perf record tests
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 9:00 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Mon, Oct 24, 2022 at 05:00:14PM +0300, Adrian Hunter escreveu:
> > On 24/10/22 14:33, Arnaldo Carvalho de Melo wrote:
> > > Em Thu, Oct 20, 2022 at 04:52:14PM -0700, Ian Rogers escreveu:
> > >> I wonder if these utilities should just be built into perf to avoid
> > >> the cc dependency. Perhaps we can have a hidden option built into
> > >> perf test.
>
> > > Agreed, not depending on a compiler makes 'perf test' usable in more
> > > systems, particularly production ones where we may want to check if perf
> > > is passing all tests applicable to that system.
>
> > I haven't seen anyone package anything except the perf executable, so
> > I presume the only people running these tests install the source, and
> > so need a compiler anyway.
>
> Humm?
>
> [root@quaco ~]# head -3 /etc/os-release
> NAME="Fedora Linux"
> VERSION="36 (Workstation Edition)"
> ID=fedora
> [root@quaco ~]#G
>
> [root@quaco ~]# rpm -qi perf
> Name        : perf
> Version     : 5.19.4
> Release     : 200.fc36
> Architecture: x86_64
> Install Date: Mon 24 Oct 2022 12:57:34 PM -03
> Group       : Unspecified
> Size        : 12663136
> License     : GPLv2
> Signature   : RSA/SHA256, Thu 25 Aug 2022 07:16:04 PM -03, Key ID 999f7cbf38ab71f4
> Source RPM  : kernel-tools-5.19.4-200.fc36.src.rpm
> Build Date  : Thu 25 Aug 2022 06:30:42 PM -03
> Build Host  : bkernel02.iad2.fedoraproject.org
> Packager    : Fedora Project
> Vendor      : Fedora Project
> URL         : http://www.kernel.org/
> Bug URL     : https://bugz.fedoraproject.org/kernel-tools
> Summary     : Performance monitoring for the Linux kernel
> Description :
> This package contains the perf tool, which enables performance monitoring
> of the Linux kernel.
> [root@quaco ~]#
>
> [root@quaco ~]# rpm -ql perf
> /etc/bash_completion.d/perf
> /usr/bin/perf
> /usr/lib/.build-id
> /usr/lib/.build-id/0c
> /usr/lib/.build-id/0c/54d587cab1b533b9ab777717ddd256ff84f241
> /usr/lib/.build-id/15
> /usr/lib/.build-id/15/6552556be0d4ca8cffb8e002d8a67add55aed5
> /usr/lib/.build-id/15/c4dfaa3861f530ef60def5506385d4b0b8924f
> /usr/lib/.build-id/1f
> /usr/lib/.build-id/1f/799c084e326516a24a647cfd5f484cd054e0a2
> /usr/lib/.build-id/23
> /usr/lib/.build-id/23/311fe148dd3f3d487ca5ace54ff2faa72ea8da
> /usr/lib/.build-id/37
> /usr/lib/.build-id/37/c9ee70f321fae7fc1fc00fca91514c63f9f052
> /usr/lib/.build-id/54
> /usr/lib/.build-id/54/43b6bc332ad188b907fdde69ac02c9a69d158f
> /usr/lib/.build-id/7e
> /usr/lib/.build-id/7e/55e7a8e4df03137ec23b4135e205bc8eb77e05
> /usr/lib/.build-id/84
> /usr/lib/.build-id/84/3c3863a123d129c98fa7cb99a58d620c9e5edc
> /usr/lib/.build-id/86
> /usr/lib/.build-id/86/d063d2f9833a447d96504e5f9e472048d12c49
> /usr/lib/.build-id/98
> /usr/lib/.build-id/98/a28589fde6ce95d9f3d305f7c9853333a9415b
> /usr/lib/.build-id/9e
> /usr/lib/.build-id/9e/567f55ca9c2b4867eb95d4182da07d4843976d
> /usr/lib/.build-id/b6
> /usr/lib/.build-id/b6/f8c9a6d6e1990f8577a9fbac875f812a316a20
> /usr/lib/.build-id/c0
> /usr/lib/.build-id/c0/8b255f02ce8f3e90df2b6156d2d38b1221995d
> /usr/lib/.build-id/d5/e964c3413f52492e6355852d25b2ab23b03e38
> /usr/lib/.build-id/e8
> /usr/lib/.build-id/e8/2de614bf77f501a4511cb70151b98392669c77

Interesting, it contains some build-ids for system libraries?

Thanks,
Namhyung
