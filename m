Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD0473F489
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 08:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbjF0Gaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 02:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjF0Gav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 02:30:51 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A826BF;
        Mon, 26 Jun 2023 23:30:50 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1b51488ad67so21378355ad.3;
        Mon, 26 Jun 2023 23:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687847450; x=1690439450;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=okd4Hx4unIxXnS558GJb5i+FkVyJr3dJEH0kXxONQ18=;
        b=L8xL/5g9Lo6HDZeVzpi3Yay84jPsOMEVqbOmis+uy4vLf+BmN06o05VSF4L+LWjbjr
         A1MRcn9JSPpTsWld0zEMa85czsjVKeWkX+z6NyN5W7VzxmG98kcZ2lWaP3O88CtgPhUE
         WYXRFSy3K7bM1W0eoLjgVAdHpWbeYtzW+TTKccdKvc1UwQTr+eFQVo6aAq2WEMWkQhIr
         8Q+In/6o23jKll8xjzqaHIpFwchdjn0f8kIuGCfxlcl8Itv+HOi2JOxsgbRFvwaylox9
         Uud8cCQNUAagBhf5j9cct6+v1GE0wwEdg/zVsjtBxNgBay/sfZxdmfu8as149RcCcJqm
         PkcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687847450; x=1690439450;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=okd4Hx4unIxXnS558GJb5i+FkVyJr3dJEH0kXxONQ18=;
        b=k0mw1RkS1Dpr7aSkGwtzzUX05WqSPjvGGlo6DA+aUY8SVU2ESYgfeLZtw5ebC6IrW5
         YcYxJjfEh7X757QrelnjuthsYMUEgfq+cyWoxymyjv90wL3hf3ebO40C84vTNw6gZMVP
         0uNPV2wQlEH1Ekvnrm1W9JmxMY8QGEUBkFfnXDwzk5fIbS+5b+ELfUaNbYLd9azj6vC6
         swHbXC4gMZ9Y41pGs7V/l+kQyh9JXDIbPzouLSxdKSOSEi1Bf1tfWCwr8b+5+T4BSPmL
         J4nwPb53htEkG9XNVdVTos4b8qjZ9AhgUlZJDNYDw3WdEpOoKj7xi8YeuF2pQ/1GIilt
         k/SA==
X-Gm-Message-State: AC+VfDw14xRWUE8XEWLSPU7Rn68VCx/+bWd/U80mx3LmnduFWZZ9Mt3G
        s0IlCsUVR8Ux7o5Cv+3+U/8=
X-Google-Smtp-Source: ACHHUZ6lSEEedS7ImrIIIDH/Kscr+1QcGy6C6gw7mCE6QOBsKaMEdvanGduqC35z6dEE8QhIxcertg==
X-Received: by 2002:a17:902:d48d:b0:1b4:fd48:d734 with SMTP id c13-20020a170902d48d00b001b4fd48d734mr7054440plg.47.1687847449713;
        Mon, 26 Jun 2023 23:30:49 -0700 (PDT)
Received: from moohyul.svl.corp.google.com ([2620:15c:2a3:200:1663:6fac:d111:59cf])
        by smtp.gmail.com with ESMTPSA id z7-20020a170903018700b001b02162c86bsm5199541plg.80.2023.06.26.23.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 23:30:49 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Andres Freund <andres@anarazel.de>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [BUG] perf build: fail with BUILD_NONDISTRO=1 FEATURES_DUMP=...
Date:   Mon, 26 Jun 2023 23:30:30 -0700
Message-ID: <20230627063046.548573-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm having a failure during `make build-test` in the perf tree.
It calls make BUILD_NONDISTRO=1 with FEATURES_DUMP defined.
Building with BUILD_NONDISTRO=1 alone was fine but it fails when I
define the FEATURES_DUMP too.

  $ make build-test
            make_nondistro_O: cd . && make BUILD_NONDISTRO=1 \
		FEATURES_DUMP=./BUILD_TEST_FEATURE_DUMP -j64 \
		O=/tmp/tmp.6JwPK1xbWG DESTDIR=/tmp/tmp.sWSewBwO13
  ...
    CC      util/annotate.o
  In file included from util/annotate.c:1814:
  tools/include/tools/dis-asm-compat.h:10:6: error: redeclaration of ‘enum disassembler_style’
     10 | enum disassembler_style {DISASSEMBLER_STYLE_NOT_EMPTY};
        |      ^~~~~~~~~~~~~~~~~~
  In file included from util/annotate.c:1809:
  /usr/include/dis-asm.h:53:6: note: originally defined here
     53 | enum disassembler_style
        |      ^~~~~~~~~~~~~~~~~~
  tools/include/tools/dis-asm-compat.h: In function ‘init_disassemble_info_compat’:
  tools/include/tools/dis-asm-compat.h:50:9: error: too few arguments to function ‘init_disassemble_info’
     50 |         init_disassemble_info(info, stream,
        |         ^~~~~~~~~~~~~~~~~~~~~
  /usr/include/dis-asm.h:480:13: note: declared here
    480 | extern void init_disassemble_info (struct disassemble_info *dinfo, void *stream,
        |             ^~~~~~~~~~~~~~~~~~~~~
  util/annotate.c: In function ‘symbol__disassemble_bpf’:
  util/annotate.c:1896:36: error: incompatible type for argument 1 of ‘disassembler’
   1896 |         disassemble = disassembler(bfdf);
        |                                    ^~~~
        |                                    |
        |                                    bfd *
  /usr/include/dis-asm.h:409:63: note: expected ‘enum bfd_architecture’ but argument is of type ‘bfd *’
    409 | extern disassembler_ftype disassembler (enum bfd_architecture arc,
        |                                         ~~~~~~~~~~~~~~~~~~~~~~^~~
  util/annotate.c:1896:23: error: too few arguments to function ‘disassembler’
   1896 |         disassemble = disassembler(bfdf);
        |                       ^~~~~~~~~~~~
  /usr/include/dis-asm.h:409:27: note: declared here
    409 | extern disassembler_ftype disassembler (enum bfd_architecture arc,
        |                           ^~~~~~~~~~~~


Thanks,
Namhyung


Cc: Andres Freund <andres@anarazel.de>
Cc: Sedat Dilek <sedat.dilek@gmail.com>
Cc: Roberto Sassu <roberto.sassu@huawei.com>
