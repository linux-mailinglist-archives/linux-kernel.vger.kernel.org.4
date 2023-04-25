Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E28A6EE664
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 19:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234702AbjDYRLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 13:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231337AbjDYRLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 13:11:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA30E9
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 10:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682442662;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+ZpoRWL6tRWz+9rgVxlO/4wr3EUiwwJ30Ksv9AaqdoE=;
        b=fFM8PmbQbz5dE3WhhAwqMJyW9VkEaHg1POyh/kBn7sLi2gTYEcf364Hb1jzrtIN0fBatUJ
        /8Ku5JVhKHyqfttxXLDXjUyOoOUIhunkjqtD66ZoSDe9t4NRpGWBJ6bT0B1wXDap2qfG1S
        +SqH3xqBGBrC9U4VZ0ICH576GxzPMv4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-638-TM6dE9LHOp6Zlu8reUXo6A-1; Tue, 25 Apr 2023 13:10:59 -0400
X-MC-Unique: TM6dE9LHOp6Zlu8reUXo6A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 37806A0F386;
        Tue, 25 Apr 2023 17:10:58 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.2.16.32])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CDEC6C15BA0;
        Tue, 25 Apr 2023 17:10:55 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Justin M. Forbes" <jforbes@fedoraproject.org>
Subject: Re: [PATCH] perf: Avoid implicit function declarations in
 lexer/parse interface
References: <877cu0827a.fsf@oldenburg.str.redhat.com>
        <CAP-5=fWGUcCrq0rHc0YRGWsgyXZDEAo03MaXXbR46Q7KZ3=-qQ@mail.gmail.com>
Date:   Tue, 25 Apr 2023 19:10:53 +0200
In-Reply-To: <CAP-5=fWGUcCrq0rHc0YRGWsgyXZDEAo03MaXXbR46Q7KZ3=-qQ@mail.gmail.com>
        (Ian Rogers's message of "Tue, 25 Apr 2023 08:18:23 -0700")
Message-ID: <87wn1z7uqq.fsf@oldenburg.str.redhat.com>
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

* Ian Rogers:

> On Tue, Apr 25, 2023 at 7:29=E2=80=AFAM Florian Weimer <fweimer@redhat.co=
m> wrote:
>>
>> In future compilers, -Wno-implicit-function-declaration may not bring
>> back support for implicit function declarations, a feature that was
>> removed from the C language in C99.  Instead, declare the yylex
>> functions using the appropriate argument types.  The solution chosen
>> here is not ideal because the prototypes are not verified against
>> the function implementations, but the way bison and flex generate
>> code make it difficult to share the prototype.
>>
>> This change should prevent build failures with future compilers which
>> no longer support implicit function declarations by default.
>>
>> Signed-off-by: Florian Weimer <fweimer@redhat.com>
>
> This seems non-standard. Isn't the issue that we're not including the
> appropriate <...>-flex.h ? The use of yylex for the function name
> obfuscates this a bit. For example:
>
> pmu-flex.h:
> ...
> #ifdef yylex
> #define perf_pmu_lex_ALREADY_DEFINED
> #else
> #define yylex perf_pmu_lex
> #endif
> ...
> /* Default declaration of generated scanner - a define so the user can
> * easily add parameters.
> */
> #ifndef YY_DECL
> #define YY_DECL_IS_OURS 1
>
> extern int yylex \
>               (YYSTYPE * yylval_param , yyscan_t yyscanner);
>
> #define YY_DECL int yylex \
>               (YYSTYPE * yylval_param , yyscan_t yyscanner)
> #endif /* !YY_DECL */
> ...

I can try to get this to work.  We have to change tools/perf/util/Build
quite extensively because

$(OUTPUT)util/parse-events-flex.c $(OUTPUT)util/parse-events-flex.h: util/p=
arse-events.l $(OUTPUT)util/parse-events-bison.c
	$(call rule_mkdir)
	$(Q)$(call echo-cmd,flex)$(FLEX) -o $(OUTPUT)util/parse-events-flex.c \
		--header-file=3D$(OUTPUT)util/parse-events-flex.h $(PARSER_DEBUG_FLEX) $<

defines two independent rules which may run in parallel and clobber each
other's two output output files.  This becomes an issue once we add the
required

$(OUTPUT)parse-events-bison.o : $(OUTPUT)parse-events-flex.h

so that flex runs before compiling the bison output file, and the header
is actually available for inclusion when it's required.  Maybe it's
possible to avoid the issue by depending on
$(OUTPUT)parse-events-flex.c.

Anyway, the next problem is that if we include expr-flex.h too early,

diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
index 635e562350c5..41c36dc3cf63 100644
--- a/tools/perf/util/expr.y
+++ b/tools/perf/util/expr.y
@@ -7,6 +7,7 @@
 #include "util/debug.h"
 #define IN_EXPR_Y 1
 #include "expr.h"
+#include "expr-flex.h"
 %}
=20
 %define api.pure full

we get this:

In file included from util/expr.y:10:                                      =
     util/expr-flex.h:496:1: error: unknown type name 'YYSTYPE'=20=20=20=20=
=20=20=20=20=20=20=20=20
  496 |=20
      | ^=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20
util/expr-flex.h:498:19: error: unknown type name 'YYSTYPE'
  498 |=20
      |                   ^=20=20=20=20=20=20
util/expr-flex.h:546:17: error: unknown type name 'YYSTYPE'
  546 | extern int yylex \
      |                 ^~=20=20=20=20=20
util/expr-bison.c: In function 'expr_parse':
util/expr-bison.c:69:25: error: implicit declaration of function 'expr_lex'
   69 | #define yylex           expr_lex=20
      |                         ^~~~~~~~=20
util/expr-bison.c:1191:16: note: in expansion of macro 'yylex'
 1191 |       yychar =3D yylex (&yylval, scanner);
      |                ^~~~~

But expr.y seems to be the only one suffering from this, and moving the
#include a bit later appears to fix it:

diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
index 635e562350c5..99581193ca4c 100644
--- a/tools/perf/util/expr.y
+++ b/tools/perf/util/expr.y
@@ -53,6 +53,8 @@
 %destructor { ids__free($$.ids); } <ids>
=20
 %{
+#include "expr-flex.h"
+
 static void expr_error(double *final_val __maybe_unused,
                       struct expr_parse_ctx *ctx __maybe_unused,
                       bool compute_ids __maybe_unused,

It works with my bison/flex combination at least, but as a change, it's
going to be a little bit risiker (both the Makefile part, and the
#include placement and general header compatibility).

I'm going to send a v2, then you can look at both and see which one you
prefer.

Thanks,
Florian

