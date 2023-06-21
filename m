Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDADF738D11
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 19:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbjFUR2E convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 21 Jun 2023 13:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjFUR2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 13:28:02 -0400
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE43BE2;
        Wed, 21 Jun 2023 10:28:01 -0700 (PDT)
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-471c9f2f47aso1327092e0c.3;
        Wed, 21 Jun 2023 10:28:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687368481; x=1689960481;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CmaOCoyILhi3FgVCCQ1JmKKyeL3P35Rtqp7/2iklqXE=;
        b=kw9h7ZlWfdigCSS2vZleN/9MR1q8JoGfBY9IgB6cmRzj3wdMGehxx952L6uQL+eb+v
         MrulV5Y+TO8CDUDqkYp/Ddm63BYErbA3E4Aic7dqzD0u05Dw+6QES0ScMjQ5BIH23+xa
         Vr0rmz0umhpueu9M55SVaJrWpj6hjQS98XvZtoLWdjxIvJezl+W0QW0UkDe+tYp6sG5I
         zL615N6rtCf38504xzz4KNdyEFNaVewwhzJ72cmnu2uhZo1JVSd/BIF0d+eVixkv2hw4
         sXEd3x5UmM2NrI+JNP4lp+f2IdxioF+H0bOIFhsYNyp26dljqnGyLIEyaGTGGmTQgKEM
         gPwA==
X-Gm-Message-State: AC+VfDwTRoXzYJRGGNg+O8OCbCCwjZGzVva3hN7LbEHNhtXPQuFPznZT
        DsJ6zft+PBfn2E6KZ3tLOi6DoMhXeUpnNI7W3E4ui9xKd/0=
X-Google-Smtp-Source: ACHHUZ4rdMM40f9UaN+w8M9TF6iOsxZdswgln6yT/olT5EUVpeMzGIgKTjsQgAhV0bZNhPLOfEULfoxpx7J0VUFFmq8=
X-Received: by 2002:a1f:bd16:0:b0:471:5427:39a4 with SMTP id
 n22-20020a1fbd16000000b00471542739a4mr7529723vkf.0.1687368480680; Wed, 21 Jun
 2023 10:28:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230615040715.2064350-1-irogers@google.com> <CAM9d7cigCUz4i-t2rHaz9Ch0oWxjYWmvnVB73uV1cm+47DtpXw@mail.gmail.com>
In-Reply-To: <CAM9d7cigCUz4i-t2rHaz9Ch0oWxjYWmvnVB73uV1cm+47DtpXw@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 21 Jun 2023 10:27:49 -0700
Message-ID: <CAM9d7cg_PoRu=6u5WYvHeyPLv0_-70_2TevrnPP6Bi=-oxX=eg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] perf sharded_mutex: Introduce sharded_mutex
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Yuan Can <yuancan@huawei.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        Andres Freund <andres@anarazel.de>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2023 at 3:15 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> On Wed, Jun 14, 2023 at 9:07 PM Ian Rogers <irogers@google.com> wrote:
> >
> > Per object mutexes may come with significant memory cost while a
> > global mutex can suffer from unnecessary contention. A sharded mutex
> > is a compromise where objects are hashed and then a particular mutex
> > for the hash of the object used. Contention can be controlled by the
> > number of shards.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
>
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Applied both patches to perf-tools-next, thanks!
