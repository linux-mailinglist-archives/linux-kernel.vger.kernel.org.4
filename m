Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FAB164885A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 19:19:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbiLISTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 13:19:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiLISTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 13:19:43 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D6B6BE3C
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 10:19:42 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id jl24so5717545plb.8
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 10:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jJC0werUyNhAsXSVGaSByQ+qaL+qg21eS8qrY583cU0=;
        b=VfDzog69pafNSi9HXPraqhYDJDxJO07kAUltK/JGGq4/H67YJhcdJPGYkJyM5SN5Ty
         oUTOpF1um2Ressl58IolXuMADr34fgz4S7xoMxcBJrM3UjpixFYR8RzfWJU5UzW4WJY6
         OlvTpxPmGPCOO8e8EKJrcXEvHD5HCBxKXL+0WrxxaIu6MivanoOZ/IRprL7bJEImMlOV
         rwOUjh+d3TNWgB872Bv8jw0GJmp5uNCUtt/zheafTcYISrYfb0t7ZBoWrt3R3US10KMe
         MPoOJGsMbCmueo3AL5avbyrICJvdGsY1Guh11L0fVla6GVU/IYdEYniS13bBQH/dJlKo
         6eXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jJC0werUyNhAsXSVGaSByQ+qaL+qg21eS8qrY583cU0=;
        b=aeG1y0yMIoHaFuKg0isiqUbIkGczGXFPF527Q1H2gPwnpjbFzOCtm5Dzmr79rFYavb
         5gVkchFMTDLEQGP1IQ3KETRwYwrEt0qOhePbOhjyAbMEVtIErAYuWxsOfhu7jcXEzUMZ
         IBZX8Fm4kkvM79dRKq1kfddPr4/eEoL2XPX5O0oYaIuBg+GJRJ65W60qfqXNnF8t0XLs
         eK2lwWUCNv34oJAQA1V4jw6MlCTXRCWnRYfpzmxX8Lac4Qic+Cdt3NAInVkKUlBdJ8V5
         int53lEAG5DagCf8jq0KuDvGchEt19zK75OHbx0iR+yQoqGdCtmyWKKIM/SmttpSjtuV
         CYBw==
X-Gm-Message-State: ANoB5pnADex3a62p48Us+bhTWSXgLn0G7FIDQ+nj0LeUvsHqDiZxFxbl
        v6d7ZN4plbceM3yWKGijLeAroOn8GA5QEOJfMGL4+Q==
X-Google-Smtp-Source: AA0mqf74rzyA/1a76a1lmHt2M7jttY7ci9jChhcQS5FHi1zSnHU5FptiMukscyl5HpepsVgoGxhe3nzHtLlXA/pvthY=
X-Received: by 2002:a17:90a:ab84:b0:213:343:9873 with SMTP id
 n4-20020a17090aab8400b0021303439873mr109317887pjq.102.1670609981609; Fri, 09
 Dec 2022 10:19:41 -0800 (PST)
MIME-Version: 1.0
References: <20221122001125.765003-1-irogers@google.com> <20221122001125.765003-3-irogers@google.com>
In-Reply-To: <20221122001125.765003-3-irogers@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 9 Dec 2022 10:19:30 -0800
Message-ID: <CAKwvOdm3hTJWKequrVXgOouA8a6wNQLaz9WHcFitOUi4HjZ51A@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] objtool: Install libsubcmd in build
To:     Ian Rogers <irogers@google.com>
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Stephane Eranian <eranian@google.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2022 at 4:11 PM Ian Rogers <irogers@google.com> wrote:
>
> +ifneq ($(OUTPUT),)
> +  LIBSUBCMD_OUTPUT = $(abspath $(OUTPUT))/libsubcmd
> +else
> +  LIBSUBCMD_OUTPUT = $(CURDIR)/libsubcmd
> +endif

Seeing an else clause when the predicate is negated makes this read as:

if !foo:
  baz()
else:
  bar()

Consider using:

if foo:
  bar()
else
  baz()

in the future.
-- 
Thanks,
~Nick Desaulniers
