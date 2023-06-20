Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B11A7374FD
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 21:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbjFTTTV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 20 Jun 2023 15:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjFTTTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 15:19:20 -0400
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0F41B6;
        Tue, 20 Jun 2023 12:19:19 -0700 (PDT)
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-77e35128efdso111899939f.1;
        Tue, 20 Jun 2023 12:19:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687288758; x=1689880758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZWhE2qlCRRxv0B8Sdv0uBimMEuGi6wFtwjWB8BFO2Z8=;
        b=lo+lBdFIU3Y8JSqdom5KZ5PYd+LgAnnelgOh5s4UeLAnVZ2D6K3iF6a8npaCeHHxis
         sOqyu4YxliOE33S1qI5XTZw0UVV5GE6W4IwtZBeXhqyWFSszAKXVtDykliP9m9fXIbPE
         D1U86f+Ant478vzfQ+Y++abE7TrBCc38KzGRbYjxA/28AW+LC7FUjMKmFPBJHDfQtRrx
         tHg1KRwtsZeN8PKOMg9cB02WVoCKfa9+cdscYIqTSN3k+GCPQc/UspzSlnJfie6IrKlx
         QzLMfhyCkuQR9RspXzewxIfqoYsK4tzRpZ8Asm7FHZzKJQT2wObVsFq8ZV0ed9Uw+7y8
         rSgw==
X-Gm-Message-State: AC+VfDy5NjI2CFdggfJRpp9ydozUndRIC7/wx558gEo5UWzymSPXX5DT
        ddk4v8EhvNeJ8Bb0oQbeF9OdZYGpTXkrk0npQsw=
X-Google-Smtp-Source: ACHHUZ50PWipzLXuS/sQyXd6BqFC+DEdDtC42iLOT8o+ld6GdNwe2kR4YUdGQWeerzIh5BR1iwhu8tat3xKLjIR7CV8=
X-Received: by 2002:a05:6602:2258:b0:777:b1ac:30af with SMTP id
 o24-20020a056602225800b00777b1ac30afmr4651294ioo.12.1687288758466; Tue, 20
 Jun 2023 12:19:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230619082036.410-1-lidong@vivo.com>
In-Reply-To: <20230619082036.410-1-lidong@vivo.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 20 Jun 2023 12:19:07 -0700
Message-ID: <CAM9d7chHMH-uJryUVBYZ6emrGLVH8Huc5frDz4YqG7TU29G-6A@mail.gmail.com>
Subject: Re: [PATCH] tools: Fix incorrect calculation of object size by sizeof
To:     Li Dong <lidong@vivo.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        "open list:PERFORMANCE EVENTS SUBSYSTEM" 
        <linux-perf-users@vger.kernel.org>,
        "open list:PERFORMANCE EVENTS SUBSYSTEM" 
        <linux-kernel@vger.kernel.org>, opensource.kernel@vivo.com
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

Hello,

On Mon, Jun 19, 2023 at 1:21 AM Li Dong <lidong@vivo.com> wrote:
>
> What we need to calculate is the size of the object, not the size of the
> pointer.
>
> Signed-off-by: Li Dong <lidong@vivo.com>

Since this problem was introduced in the current dev cycle and not in the
mainline yet, I think we can skip the Fixes tag.

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


> ---
>  tools/perf/util/scripting-engines/trace-event-python.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
> index 59063ec98619..25fcd6630a4d 100644
> --- a/tools/perf/util/scripting-engines/trace-event-python.c
> +++ b/tools/perf/util/scripting-engines/trace-event-python.c
> @@ -771,12 +771,12 @@ static void set_regs_in_dict(PyObject *dict,
>         int size = __sw_hweight64(attr->sample_regs_intr) * 28;
>         char *bf = malloc(size);
>
> -       regs_map(&sample->intr_regs, attr->sample_regs_intr, arch, bf, sizeof(bf));
> +       regs_map(&sample->intr_regs, attr->sample_regs_intr, arch, bf, size);
>
>         pydict_set_item_string_decref(dict, "iregs",
>                         _PyUnicode_FromString(bf));
>
> -       regs_map(&sample->user_regs, attr->sample_regs_user, arch, bf, sizeof(bf));
> +       regs_map(&sample->user_regs, attr->sample_regs_user, arch, bf, size);
>
>         pydict_set_item_string_decref(dict, "uregs",
>                         _PyUnicode_FromString(bf));
> --
> 2.31.1.windows.1
>
