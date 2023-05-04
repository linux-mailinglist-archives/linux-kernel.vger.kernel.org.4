Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 580476F6316
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 05:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbjEDDAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 23:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbjEDDAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 23:00:44 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 006D3170C
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 20:00:28 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-965ab8ed1c0so20599566b.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 20:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1683169227; x=1685761227;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S1sPdfgjBQddTLtJgPwbyySVZe+LzD0cP2bpBXFDlJY=;
        b=FHRSniA7XoR1A6HBNWRiZuLjX8Iawte10XSBPT/yHAEemBhU5RHQU5wq6PrU9txpVm
         xMUyEQmCiYpRD1VHxL/io/tBBz0ZodKL3MjfdpnP540Ha4GcZVC6qywAYRgi2Fwtruwb
         sHoj0Fldz1LmgLJOYaWWvwbdSF2D4WPWkm+F8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683169227; x=1685761227;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S1sPdfgjBQddTLtJgPwbyySVZe+LzD0cP2bpBXFDlJY=;
        b=UJxugSsZ7K9Ma9lyLXfZ/+4BGQKfzOnpJUEw/OvwxoWhgMHou9wOad372fhlRlEKoa
         JksrxOUfWJFmw1taiIXyle5BUJkvyIv4CTZI1ZYktuiL1InZg50k/whTsIiMtL0ePGUq
         dPh+nghAgg1CnddkAAVj7qtvd1iAxHolNZrHD7hKeaQl4Yj9Re634S3BFNxoSVfob4OR
         Vn9yOMZjvoR6+DNx57xThAUCMWe6rjFL60LsKXlAUHYWSwGi+2eyFyscY5oUPvxOkiFJ
         Pr/7p4S2aeDsV4ZQM35wOQF3mo5WaNPaUZytmvdqOOjL+5jLYyPgiPh91mDoUNL2sc4l
         fTWA==
X-Gm-Message-State: AC+VfDwwxXInD8N86cULlxjmbt4PAyJqZ7xSfBRKhuYVadQSlbjesUyl
        hpgakjb5S6gDVSD1GeyhNx2PkfbNrXtuTrBcMxagMw==
X-Google-Smtp-Source: ACHHUZ6jpz18OxL0XnTU+BL97FsThWa+FFbtQ+8ZK7EISWQ6aHJyHsivJ+T7xwA1Hca1DSdJT+CbwQ==
X-Received: by 2002:a17:907:26c4:b0:95d:e076:5033 with SMTP id bp4-20020a17090726c400b0095de0765033mr5456239ejc.16.1683169227272;
        Wed, 03 May 2023 20:00:27 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id s4-20020a170906a18400b0094f1d0bad81sm17984699ejy.139.2023.05.03.20.00.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 May 2023 20:00:27 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-50bc0ced1d9so8086709a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 20:00:26 -0700 (PDT)
X-Received: by 2002:a17:907:98b:b0:94d:69e0:6098 with SMTP id
 bf11-20020a170907098b00b0094d69e06098mr4661982ejc.45.1683169226391; Wed, 03
 May 2023 20:00:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230503211801.897735-1-acme@kernel.org>
In-Reply-To: <20230503211801.897735-1-acme@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 3 May 2023 20:00:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjY_3cBELRSLMpqCt6Eb71Qei2agfKSNsrr5KcpdEQCaA@mail.gmail.com>
Message-ID: <CAHk-=wjY_3cBELRSLMpqCt6Eb71Qei2agfKSNsrr5KcpdEQCaA@mail.gmail.com>
Subject: Re: [GIT PULL] perf tools changes for v6.4
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        Kate Carcia <kcarcia@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Changbin Du <changbin.du@huawei.com>,
        Hao Luo <haoluo@google.com>, Ian Rogers <irogers@google.com>,
        James Clark <james.clark@arm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Roman Lozko <lozko.roma@gmail.com>,
        Stephane Eranian <eranian@google.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 3, 2023 at 2:18=E2=80=AFPM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
>         Please consider pulling,

I did consider it, but the end result doesn't even build, so I unpulled aga=
in..

I get some libbpf error, and I'm just not interested in trying to
debug it. This has clearly not been tested well enough to be merged.

  libbpf: failed to find '.BTF' ELF section in /home/torvalds/v2.6/linux/vm=
linux
  Error: failed to load BTF from /home/torvalds/v2.6/linux/vmlinux: No
data available
  Failure to generate vmlinux.h needed for the recommended BPF skeleton sup=
port.
  To disable this use the build option NO_BPF_SKEL=3D1.
  Alternatively point at a pre-generated vmlinux.h with VMLINUX_H=3D<path>.

the build system assumptions are clearly completely broken.

              Linus
