Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FEBF73C6EE
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 07:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbjFXF3N convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 24 Jun 2023 01:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjFXF3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 01:29:10 -0400
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA4F26AB;
        Fri, 23 Jun 2023 22:29:10 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-c14476f8401so70572276.3;
        Fri, 23 Jun 2023 22:29:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687584549; x=1690176549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=psaJ+y5ALa0iw48YhwUPxU83Af9RmIk2zi57O7xwMFE=;
        b=GtPR0MqUgHPL2RRXafh5RY5VtFylfsPvIwqpPmkbAiZo4DQiUVK8IO7aaaBqL3K09H
         3Fxo0eeaDAZgoph7Y9fA8pixnBYoLJVyScOxE+o54/8K1ZIWqBEf3dzcjX6stg8OFIxn
         5oCqKe8AIUFK6Nk710v/dC8dOHyZq7mxvvI3yAHwICKMFu/6H9Y6o9gA4zOCz+krQS1n
         wPLGcWXsYcRGJhOM6FQ6BsWE1jTa1EvL5/F0bgUf9TPoTbD3y9O0DqoV7wA/6RHAzh8e
         DXp/69nAnrbxCJT/gJNyRCmk02CIrv2fNyHGhiSdO87OXCihCwMVLAZs1MF3rOoWyxQW
         Md8Q==
X-Gm-Message-State: AC+VfDxROk7/1W7N07EXwxmendoR77bb437xAzUH98T0gMgSiwPM2F4i
        +uYWdYn2+okdK7kxHrYWGfi5N1Un7Lc8womhFSM=
X-Google-Smtp-Source: ACHHUZ4wOrHKi+qjIftxGauA2oaN1EIsoTxdap9I/malUC/eu7AwVf+Sd1yGWhvnQIunZD1uW15Ez3QyV6yHn8jcogM=
X-Received: by 2002:a25:ce4b:0:b0:bc8:4b44:b3e3 with SMTP id
 x72-20020a25ce4b000000b00bc84b44b3e3mr19237214ybe.50.1687584549168; Fri, 23
 Jun 2023 22:29:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230623054416.160858-1-yangjihong1@huawei.com> <20230623054416.160858-5-yangjihong1@huawei.com>
In-Reply-To: <20230623054416.160858-5-yangjihong1@huawei.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 23 Jun 2023 22:28:57 -0700
Message-ID: <CAM9d7cjzzmjQnJUvE2a6bqDao07o9+mSyJH4C4xRq0zEZJwLnQ@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] perf tools: Add printing perf_event_attr config
 symbol in perf_event_attr__fprintf()
To:     Yang Jihong <yangjihong1@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        anshuman.khandual@arm.com, jesussanp@google.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Thu, Jun 22, 2023 at 10:46 PM Yang Jihong <yangjihong1@huawei.com> wrote:
>
> When printing perf_event_attr, always display perf_event_attr config and
> its symbol to improve the readability of debugging information.
>

[SNIP]
> +
> +#ifdef HAVE_LIBTRACEEVENT
> +static void __p_config_tracepoint_id(char *buf, size_t size, u64 value)
> +{
> +       char *str = tracepoint_id_to_name(value);

This makes the python module import test failing due to the
undefined symbol.  I'll fix it by adding a dummy function in
util/python.c file.  But next time, please run `perf test` first
and make sure you don't break anything.

Thanks,
Namhyung


> +
> +       print_id_hex(str);
> +       free(str);
> +}
> +#endif
> +
> +static void __p_config_id(char *buf, size_t size, u32 type, u64 value)
> +{
> +       switch (type) {
> +       case PERF_TYPE_HARDWARE:
> +               return __p_config_hw_id(buf, size, value);
> +       case PERF_TYPE_SOFTWARE:
> +               return __p_config_sw_id(buf, size, value);
> +       case PERF_TYPE_HW_CACHE:
> +               return __p_config_hw_cache_id(buf, size, value);
> +       case PERF_TYPE_TRACEPOINT:
> +#ifdef HAVE_LIBTRACEEVENT
> +               return __p_config_tracepoint_id(buf, size, value);
> +#endif
> +       case PERF_TYPE_RAW:
> +       case PERF_TYPE_BREAKPOINT:
> +       default:
> +               snprintf(buf, size, "%#"PRIx64, value);
> +               return;
> +       }
> +}
> +
>  #define BUF_SIZE               1024
>
>  #define p_hex(val)             snprintf(buf, BUF_SIZE, "%#"PRIx64, (uint64_t)(val))
> @@ -111,6 +246,7 @@ static void __p_type_id(char *buf, size_t size, u64 value)
>  #define p_branch_sample_type(val) __p_branch_sample_type(buf, BUF_SIZE, val)
>  #define p_read_format(val)     __p_read_format(buf, BUF_SIZE, val)
>  #define p_type_id(val)         __p_type_id(buf, BUF_SIZE, val)
> +#define p_config_id(val)       __p_config_id(buf, BUF_SIZE, attr->type, val)
>
>  #define PRINT_ATTRn(_n, _f, _p, _a)                    \
>  do {                                                   \
> @@ -130,7 +266,7 @@ int perf_event_attr__fprintf(FILE *fp, struct perf_event_attr *attr,
>
>         PRINT_ATTRn("type", type, p_type_id, true);
>         PRINT_ATTRf(size, p_unsigned);
> -       PRINT_ATTRf(config, p_hex);
> +       PRINT_ATTRn("config", config, p_config_id, true);
>         PRINT_ATTRn("{ sample_period, sample_freq }", sample_period, p_unsigned, false);
>         PRINT_ATTRf(sample_type, p_sample_type);
>         PRINT_ATTRf(read_format, p_read_format);
> --
> 2.30.GIT
>
