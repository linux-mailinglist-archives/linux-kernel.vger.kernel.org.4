Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C8F26DB5DC
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 23:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjDGVoW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 7 Apr 2023 17:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjDGVoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 17:44:19 -0400
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7BC9C178;
        Fri,  7 Apr 2023 14:44:18 -0700 (PDT)
Received: by mail-ua1-f43.google.com with SMTP id n1so3978952uae.9;
        Fri, 07 Apr 2023 14:44:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680903858; x=1683495858;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0tna+7RzZSgs0Z3cLwUQqheHwwOhokZ95SIqeSjzzWo=;
        b=brA/pQjfEMJt7OlSOhkOCMHX5//WKVTg+N5XYAiKx2lI7dL44bYkvThKoTJqRLstNn
         nNdaomF0vYzEc+Qwizur4BA03CrMXFU9MhpVLn8Ujxuu1+rjv6glFRfJfds5+jcKWMdP
         fsfjmXL1sr7I92xnVH+vedlhqdRW5LZnSSn1bPHl+WAG3AK/SeyHLn+YIf1cjI0mQLSD
         h8YHKo4PG7lYElJYf0GZ8NlkUqTE+8PwOnSF1UXBREbcse8XAwZ+jWfSu/6BfAHOBPk1
         jQiuoOSimtBgA/14UmGz80zSGRaGFgOaE9dui+4MvlZzPmIsS0AobNXKocuGycu3Qdfj
         bNVA==
X-Gm-Message-State: AAQBX9ecpuRm6kBLSTSN86PJWGEmXIIoLKaP282+Dagw390TPTMfBRdk
        jEzHnA5w1WL28RkStCGTV8huoHfVLxkXqqhK+1PNPVll
X-Google-Smtp-Source: AKy350Yj0lPZ/vdQoI4TtqCb9j+268KaAmV0Ut/ezwWAc/tbpvhyN5ZRbhmXE3nK9FxGeaaAAZbwxgUuD4jDvy6Cg1o=
X-Received: by 2002:a05:6122:925:b0:43c:2cb2:89ae with SMTP id
 j37-20020a056122092500b0043c2cb289aemr1428089vka.10.1680903857921; Fri, 07
 Apr 2023 14:44:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230407112459.548-1-ravi.bangoria@amd.com>
In-Reply-To: <20230407112459.548-1-ravi.bangoria@amd.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 7 Apr 2023 14:44:06 -0700
Message-ID: <CAM9d7cijvZBsaXTMm8d=sxUWy6s+umCCnWhunD3KVhKbpVp_-A@mail.gmail.com>
Subject: Re: [PATCH v3 0/9] perf/mem: AMD IBS and generic tools improvements
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     peterz@infradead.org, acme@kernel.org, mingo@kernel.org,
        eranian@google.com, kan.liang@linux.intel.com, jolsa@kernel.org,
        irogers@google.com, adrian.hunter@intel.com, leo.yan@linaro.org,
        kjain@linux.ibm.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, sandipan.das@amd.com,
        ananth.narayan@amd.com, santosh.shukla@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ravi,

On Fri, Apr 7, 2023 at 4:25 AM Ravi Bangoria <ravi.bangoria@amd.com> wrote:
>
> Kernel IBS driver wasn't using new PERF_MEM_* APIs due to some of its
> limitations. Mainly:
>
> 1. mem_lvl_num doesn't allow setting multiple sources whereas old API
>    allows it. Setting multiple data sources is useful because IBS on
>    pre-zen4 uarch doesn't provide fine granular DataSrc details (there
>    is only one such DataSrc(2h) though).
> 2. perf mem sorting logic (sort__lvl_cmp()) ignores mem_lvl_num. perf
>    c2c (c2c_decode_stats()) does not use mem_lvl_num at all. perf mem
>    prints mem_lvl and mem_lvl_num both if both are set, which is ugly.
>
> Set mem_lvl_num, mem_remote and mem_hops for data_src via IBS. Handle
> first issue using mem_lvl_num = ANY_CACHE | HOPS_0. In addition to
> setting new API fields, convert all individual field assignments to
> compile time wrapper macros built using PERF_MEM_S(). Also convert
> DataSrc conditional code to array lookups.
>
> Interpretation of perf_mem_data_src by perf_mem__lvl_scnprintf() was
> non-intuitive. Make it sane.

Looks good, but I think you need to split kernel and user patches.

>
> v2: https://lore.kernel.org/r/20230327130851.1565-1-ravi.bangoria%40amd.com
> v2->v3:
>   - IBS: Don't club RmtNode with DataSrc=7 (IO)
>   - Make perf_mem__lvl_scnprintf() more sane
>   - Introduce PERF_MEM_LVLNUM_UNC, set it along with PERF_MEM_LVL_UNC
>     and interpreat it in tool.
>   - Add PERF_MEM_LVLNUM_NA to default data_src value
>   - Change some of the IBS bit description according to latest PPR
>
> Namhyung Kim (1):
>   perf/x86/ibs: Set mem_lvl_num, mem_remote and mem_hops for data_src
>
> Ravi Bangoria (8):
>   perf/mem: Introduce PERF_MEM_LVLNUM_UNC
>   perf/mem: Add PERF_MEM_LVLNUM_NA to PERF_MEM_NA
>   perf headers: Sync uapi/linux/perf_event.h
>   perf mem: Add PERF_MEM_LVLNUM_NA to PERF_MEM_DATA_SRC_NONE
>   perf mem: Add support for printing PERF_MEM_LVLNUM_UNC
>   perf mem: Refactor perf_mem__lvl_scnprintf()
>   perf mem: Increase HISTC_MEM_LVL column size to 39 chars
>   perf script ibs: Change bit description according to latest PPR

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


>
>  arch/x86/events/amd/ibs.c             | 156 +++++++++++---------------
>  include/linux/perf_event.h            |   3 +-
>  include/uapi/linux/perf_event.h       |   3 +-
>  tools/include/uapi/linux/perf_event.h |   3 +-
>  tools/perf/util/amd-sample-raw.c      |  14 +--
>  tools/perf/util/event.h               |   3 +-
>  tools/perf/util/hist.c                |   2 +-
>  tools/perf/util/mem-events.c          |  90 ++++++++-------
>  8 files changed, 132 insertions(+), 142 deletions(-)
>
> --
> 2.34.1
>
