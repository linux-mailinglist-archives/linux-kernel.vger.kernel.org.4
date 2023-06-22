Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 987CC7395EB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 05:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbjFVDvQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 21 Jun 2023 23:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbjFVDvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 23:51:13 -0400
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BABF91BD4;
        Wed, 21 Jun 2023 20:51:12 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-c01e1c0402cso198611276.0;
        Wed, 21 Jun 2023 20:51:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687405872; x=1689997872;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m/MofGdlyCWHDpo+tEjRP5NVRsAoqM1bdJmP0dhp050=;
        b=FX6AguW3nhUdwfgjYT10BHJMOtzmQmiyeLXnZVvHEb1Jy7jamDTApPGF5tc7Wgmg4h
         49v7VLOUflVOSWes/S10ghd8pAYXQlmUpHFBZRCqKwj8jSfiMG52HK8Q9dIp6RYMqkPW
         aJqlQPnjvRAus87AIQf8TMVWOMreetCAXH9/UP6UaF6+gJqC/QEx/55VJKZ8SEllQqby
         E/4DpiV7WxswHR9QHqmhOrHI5a9NWSVJLetp3XzpbG4Q//ymnyy9AUBYLJhTNE7XpNVs
         O0WQiySd8BY93meIynAZWvZcG2CK1ZJorAuS6zgP6fsuyMTTqhJXpgVhE+aytoNgiZhv
         53zQ==
X-Gm-Message-State: AC+VfDwHTpCWsUUYViWBUsqpvjfYQkddua2yybS8x6L9ml4nalQSK5+W
        POHEJ96jITjLY/h6ITSWL5HHUuh6GVCJXNiH0gg=
X-Google-Smtp-Source: ACHHUZ45QRs9LFRtTmGdjCabgW/IMz5t44EGoCoJIop6UEW5GyAm01ZJTc/udakVyz7NA3sEV0fPNvtnBo+D9VBnYEo=
X-Received: by 2002:a25:838a:0:b0:bfe:e65b:7f with SMTP id t10-20020a25838a000000b00bfee65b007fmr3616507ybk.50.1687405871696;
 Wed, 21 Jun 2023 20:51:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230621063749.3358430-1-irogers@google.com>
In-Reply-To: <20230621063749.3358430-1-irogers@google.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 21 Jun 2023 20:51:00 -0700
Message-ID: <CAM9d7cg-r7Nw807egNFVRBgEXwgBV=A2pVEb+MBS4gvFgnNynQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] perf symbol: Remove symbol_name_rb_node
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Carsten Haitzler <carsten.haitzler@arm.com>,
        Changbin Du <changbin.du@huawei.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Jason Wang <wangborong@cdjrlc.com>,
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

Hi Ian,

On Tue, Jun 20, 2023 at 11:37 PM Ian Rogers <irogers@google.com> wrote:
>
> Most perf commands want to sort symbols by name and this is done via
> an invasive rbtree that on 64-bit systems costs 24 bytes. Sorting the
> symbols in a DSO by name is optional and not done by default, however,
> if sorting is requested the 24 bytes is allocated for every
> symbol.
>
> This change removes the rbtree and uses a sorted array of symbol
> pointers instead (costing 8 bytes per symbol). As the array is created
> on demand then there are further memory savings. The complexity of
> sorting the array and using the rbtree are the same.
>
> To support going to the next symbol, the index of the current symbol
> needs to be passed around as a pair with the current symbol. This
> requires some API changes.
>
> Signed-off-by: Ian Rogers <irogers@google.com>
>
> v2. map__find_symbol_by_name_idx so that map__find_symbol_by_name
>     doesn't need an optional parameter. Separate out
>     symbol_conf.sort_by_name removal.
> ---

[SNIP]
>  void dso__sort_by_name(struct dso *dso)
>  {
> -       dso__set_sorted_by_name(dso);
> -       return symbols__sort_by_name(&dso->symbol_names, &dso->symbols);
> +       mutex_lock(&dso->lock);
> +       if (!dso__sorted_by_name(dso)) {
> +               size_t len;
> +
> +               dso->symbol_names = symbols__sort_by_name(&dso->symbols, &len);
> +               if (dso->symbol_names) {
> +                       dso->symbol_names_len = len;
> +                       dso__set_sorted_by_name(dso);
> +               }
> +       }
> +       mutex_unlock(&dso->lock);

I think this part deserves a separate commit.

Thanks,
Namhyung
