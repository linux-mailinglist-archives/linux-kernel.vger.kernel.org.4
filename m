Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB666F54F0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 11:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbjECJkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 05:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjECJkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 05:40:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B20D74682
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 02:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683106813;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PAwstY568npzQXP3akBe128X11f9gfLOJf6c4sba2gw=;
        b=AVoR7+AW8HxKXA58oZxzlamEJzZP7Wto+UpLWTG6erQJDf8CWn3hAVZET6FJKWDvVRNpCC
        gihLai9r7xE6jbPKdhCGAD95BZB0sJCLIOcj96b3ppl70kS2SJWN0BIYvzcq/Dq7/xvuha
        1VgFKdo2kt/qD5ii8OBypnqqCbREoQ4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-617-QzwQ2FwzOS-Rjfza0gbwqQ-1; Wed, 03 May 2023 05:40:11 -0400
X-MC-Unique: QzwQ2FwzOS-Rjfza0gbwqQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 60EE81066541;
        Wed,  3 May 2023 09:40:10 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.2.16.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DFA21C15BAE;
        Wed,  3 May 2023 09:40:07 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ian Rogers <irogers@google.com>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org,
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
Date:   Wed, 03 May 2023 11:40:06 +0200
In-Reply-To: <874jot69ks.fsf@oldenburg.str.redhat.com> (Florian Weimer's
        message of "Wed, 03 May 2023 11:36:03 +0200")
Message-ID: <87zg6l4utl.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Florian Weimer:

> * Arnaldo Carvalho de Melo:
>
>>> Thanks, applied. BTW b4 coulnd't find this message (nor the original):
>
> Yes, vger drops the message after accepting it for some reason, probably
> something in the patch contents.  I tried to resubmit from a completely
> separate account, no luck.
>
>> Not so fast, removed it for now:
>>
>>   CC      /tmp/build/perf-tools-next/util/parse-events-bison.o
>> In file included from util/pmu.y:14:
>> /tmp/build/perf-tools-next/util/pmu-flex.h:496:1: error: unknown type na=
me =E2=80=98YYSTYPE=E2=80=99
>>   496 |
>>       | ^
>> /tmp/build/perf-tools-next/util/pmu-flex.h:498:19: error: unknown type n=
ame =E2=80=98YYSTYPE=E2=80=99
>>   498 |
>>       |                   ^
>> /tmp/build/perf-tools-next/util/pmu-flex.h:546:17: error: unknown type n=
ame =E2=80=98YYSTYPE=E2=80=99
>>   546 | extern int yylex \
>>       |                 ^~
>> util/pmu-bison.c: In function =E2=80=98perf_pmu_parse=E2=80=99:
>> /tmp/build/perf-tools-next/util/pmu-bison.c:69:25: error: implicit decla=
ration of function =E2=80=98perf_pmu_lex=E2=80=99; did you mean =E2=80=98pe=
rf_pmu_free=E2=80=99? [-Werror=3Dimplicit-function-declaration]
>>    69 | #define yylex           perf_pmu_lex
>>       |                         ^~~~~~~~~~~~
>> util/pmu-bison.c:1007:16: note: in expansion of macro =E2=80=98yylex=E2=
=80=99
>
> This appears to be related to some BPF filter stuff that is only in
> perf-next, not mainline.
>
> Is this the right tree on which to base the patch?
>
>   <https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/>
>
> Branch perf-tools-next?

Sorry, it doesn't build even without my patch:

make[4]: *** No rule to make target 'zip.h', needed by '/tmp/build/libbpf/s=
taticobjs/libbpf.o'.  Stop.

Thanks,
Florian

