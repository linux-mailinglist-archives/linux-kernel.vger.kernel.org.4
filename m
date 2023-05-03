Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5256B6F5C34
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 18:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbjECQqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 12:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbjECQqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 12:46:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF4C55AF
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 09:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683132320;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g92hv1ymff3iuH84Dp6ewyUwzDFuT7AEfYAUYl+e558=;
        b=RfC9gRXlkQ5KpiWrsfsZQDcI3jY3nD5q5JrQ1vIttTq3Ra6lALNDt+wmSq7t2R6kgLr9Ll
        Bg6V2BuKVDkTb3/h6C/WzHhDEnTUSeMiI87Q0LlpMAQoD8pTAuvefUkEqss7S01oPt4zSi
        GQVwWCUWVYu4Yq4SHuuhzyVm/m8vKmQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-558-TjAa1g4lMYGZSLAssHvzZg-1; Wed, 03 May 2023 12:45:16 -0400
X-MC-Unique: TjAa1g4lMYGZSLAssHvzZg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2673B811E7E;
        Wed,  3 May 2023 16:45:16 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.2.16.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0189B492C13;
        Wed,  3 May 2023 16:45:13 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Justin M. Forbes" <jforbes@fedoraproject.org>
Subject: Re: [PATCH v2] perf: Avoid implicit function declarations in
 lexer/parse interface
References: <87sfcn7uot.fsf@oldenburg.str.redhat.com>
        <CAP-5=fXZv+KCdCN05wVUcAwDCZAgXjWunoaviGBQEiUPqNwOmg@mail.gmail.com>
        <ZEx0IQAtBatrRDCR@kernel.org> <ZEx0xAamEl66qk2w@kernel.org>
        <874jot69ks.fsf@oldenburg.str.redhat.com>
        <87zg6l4utl.fsf@oldenburg.str.redhat.com>
        <ZFJ39HKzBUg64QPO@kernel.org>
        <CAP-5=fUukHuVsPS_Am6VTGvpuiEVo=2X=BuN2feh+ibhnSFAUg@mail.gmail.com>
Date:   Wed, 03 May 2023 18:45:12 +0200
In-Reply-To: <CAP-5=fUukHuVsPS_Am6VTGvpuiEVo=2X=BuN2feh+ibhnSFAUg@mail.gmail.com>
        (Ian Rogers's message of "Wed, 3 May 2023 08:28:22 -0700")
Message-ID: <87a5yl4b53.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Ian Rogers:

> On Wed, May 3, 2023 at 8:04=E2=80=AFAM Arnaldo Carvalho de Melo <acme@ker=
nel.org> wrote:
>>
>> Em Wed, May 03, 2023 at 11:40:06AM +0200, Florian Weimer escreveu:
>> > * Florian Weimer:
>> > > * Arnaldo Carvalho de Melo:
>>
>> > >>> Thanks, applied. BTW b4 coulnd't find this message (nor the origin=
al):
>>
>> > > Yes, vger drops the message after accepting it for some reason, prob=
ably
>> > > something in the patch contents.  I tried to resubmit from a complet=
ely
>> > > separate account, no luck.
>> > >
>> > >> Not so fast, removed it for now:
>> > >>
>> > >>   CC      /tmp/build/perf-tools-next/util/parse-events-bison.o
>> > >> In file included from util/pmu.y:14:
>> > >> /tmp/build/perf-tools-next/util/pmu-flex.h:496:1: error: unknown ty=
pe name =E2=80=98YYSTYPE=E2=80=99
>> > >>   496 |
>> > >>       | ^
>> > >> /tmp/build/perf-tools-next/util/pmu-flex.h:498:19: error: unknown t=
ype name =E2=80=98YYSTYPE=E2=80=99
>> > >>   498 |
>> > >>       |                   ^
>> > >> /tmp/build/perf-tools-next/util/pmu-flex.h:546:17: error: unknown t=
ype name =E2=80=98YYSTYPE=E2=80=99
>> > >>   546 | extern int yylex \
>> > >>       |                 ^~
>> > >> util/pmu-bison.c: In function =E2=80=98perf_pmu_parse=E2=80=99:
>> > >> /tmp/build/perf-tools-next/util/pmu-bison.c:69:25: error: implicit =
declaration of function =E2=80=98perf_pmu_lex=E2=80=99; did you mean =E2=80=
=98perf_pmu_free=E2=80=99? [-Werror=3Dimplicit-function-declaration]
>> > >>    69 | #define yylex           perf_pmu_lex
>> > >>       |                         ^~~~~~~~~~~~
>> > >> util/pmu-bison.c:1007:16: note: in expansion of macro =E2=80=98yyle=
x=E2=80=99
>> > >
>> > > This appears to be related to some BPF filter stuff that is only in
>> > > perf-next, not mainline.
>> > >
>> > > Is this the right tree on which to base the patch?
>> > >
>> > >   <https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/>
>> > >
>> > > Branch perf-tools-next?
>> >
>> > Sorry, it doesn't build even without my patch:
>> >
>> > make[4]: *** No rule to make target 'zip.h', needed by '/tmp/build/lib=
bpf/staticobjs/libbpf.o'.  Stop.
>>
>> I'm noticing this, but then I haven't merged with upstream yet, I bet
>> this is something upstream after merging the bpf branch... Nope, I just
>> did a test merge of what is in
>> git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git perf-tools
>> with upstream and it builds without problems on:
>>
>> [acme@quaco perf-tools]$ head -2 /etc/os-release
>> NAME=3D"Fedora Linux"
>> VERSION=3D"37 (Workstation Edition)"
>> [acme@quaco perf-tools]$
>>
>> I'll check on f38 and rawhide.
>>
>> - Arnaldo
>
> The zip.c and zip.h in libbpf are new, perhaps it is a fixdeps issue?
> Perhaps doing a clean build and retrying will address the problem.

Yeah, it's that.  I tried to reproduce the issue with a make command
similar to Arnaldo's, and forgot that *of course* O=3D overrides =E2=80=9Cg=
it
clean=E2=80=9D.

I'm now on 5d27a645f60940fdf589e4ff5351506a7f0fdbaa, can built it
cleanly, and will try to rebase my patch onto that.

Thanks,
Florian

