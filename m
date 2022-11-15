Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B10A629FF6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 18:08:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbiKORIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 12:08:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231199AbiKORIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 12:08:00 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88337205FA
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 09:07:57 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id h9so25416313wrt.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 09:07:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8fug7Pycg9JGMbjUFO9hC6GowCXluQVSRide/mfbKV4=;
        b=Fqig9DykvDToXp4VOoUg+TL3umy+3m+nL4Oq3oZnGLtH7N4FnPI3bscxXcJWaiFRT3
         InnvQBKLCRobV7j80oAlqToIiYAOCeiUYuLwMrGebwVzq2vnxIeVR1I6aOCWdXVjbix4
         JxRVkKgmVkp1IZHT2J1BQo6hz3e4XF115alxG2cgfZEXel0QBjw/3Ny2NWsYEytQFdCb
         Dxd2uIWfTyviMjoJgpbMp1U2/5PfY+ggKJENDDNWZ7r95Kg66sCVNSZi0TaBYsCpnWk1
         1TTn6VocENxiVCeO2/U4UHAWEXg7ZecmLzbzTQp/9H/Hs++lmquNfqhp3S6pB0ueP0+D
         HF/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8fug7Pycg9JGMbjUFO9hC6GowCXluQVSRide/mfbKV4=;
        b=qbUVXN+cMaKs1OVDP6Bf/tlq+K3oeham64gAmP4B2PggE9H3PBzqbb6dgJVfOhfRXF
         vmtc79pARewhMyxTc5XP0Jgd/Hp6Io61sla2WMncX4/pzqaCtwqbA2eoGetkGNE72Jj7
         55zZ2Y3gLiJk7R8nome9veq3MvoJQacOZy83iYrSEsWS85+p+npw6W4atCINBg33tYVg
         WWjCb/qWpwVWDRBttb2zU8TIu2kZ+hNIWmzVKV1fP57ra9njHl+Bf5n2/+1S7ye7vhoy
         tfl0A61V6K0ZarZyZwMjYpNNoUaz0A70I/9JRp3U25b/6k6pNCByEW8BdGvI+JSyuIYS
         OoxQ==
X-Gm-Message-State: ANoB5pkLxfkWHMxJoDgRXYDT3JSB+SomQbDqrW8fx+SDOj2AY8ldRd7D
        xuQu0U41x5JisgnkzVWkT1c9Gw0dToWakfpzhnmK5A==
X-Google-Smtp-Source: AA0mqf6ycia/7g/I5oSSKfElMOZhmmAn+pqp77oswR34srY/+gsl33BKvscRc6o3RH+n9LXpyPu4IPl2WoJMYPYCco4=
X-Received: by 2002:a5d:58c1:0:b0:22e:34ee:c67d with SMTP id
 o1-20020a5d58c1000000b0022e34eec67dmr11207928wrf.300.1668532075915; Tue, 15
 Nov 2022 09:07:55 -0800 (PST)
MIME-Version: 1.0
References: <20221115093904.1799-1-ravi.bangoria@amd.com>
In-Reply-To: <20221115093904.1799-1-ravi.bangoria@amd.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 15 Nov 2022 09:07:44 -0800
Message-ID: <CAP-5=fXq-YNKogH4DYQuf7rz8TZhu8=QnEsA2pvzj6YS_DQO7g@mail.gmail.com>
Subject: Re: [PATCH] perf/amd/ibs: Make IBS a core pmu
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     peterz@infradead.org, acme@kernel.org, mark.rutland@arm.com,
        jolsa@redhat.com, namhyung@kernel.org, eranian@google.com,
        kan.liang@linux.intel.com, bp@alien8.de, x86@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        sandipan.das@amd.com, ananth.narayan@amd.com,
        santosh.shukla@amd.com
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

On Tue, Nov 15, 2022 at 1:39 AM Ravi Bangoria <ravi.bangoria@amd.com> wrote:
>
> So far, only one pmu was allowed to be registered as core pmu and thus
> IBS pmus were being registered as uncore. However, with the event context
> rewrite, that limitation no longer exists and thus IBS pmus can also be
> registered as core pmu. This makes IBS much more usable, for ex, user
> will be able to do per-process precise monitoring on AMD:
>
> Before patch:
>   $ sudo perf record -e cycles:pp ls
>   Error:
>   Invalid event (cycles:pp) in per-thread mode, enable system wide with '-a'
>
> After patch:
>   $ sudo perf record -e cycles:pp ls
>   [ perf record: Woken up 1 times to write data ]
>   [ perf record: Captured and wrote 0.017 MB perf.data (33 samples) ]
>
> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>

Acked-by: Ian Rogers <irogers@google.com>

This is awesome!
Ian

> ---
> Note:
> This patch is dependent on the event context rewrite patch which is
> already present in a tip tree:
>   https://git.kernel.org/tip/tip/c/bd27568117664
>
>  arch/x86/events/amd/ibs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
> index 3271735f0070..fbc2ce86f4b8 100644
> --- a/arch/x86/events/amd/ibs.c
> +++ b/arch/x86/events/amd/ibs.c
> @@ -631,7 +631,7 @@ static const struct attribute_group *op_attr_update[] = {
>
>  static struct perf_ibs perf_ibs_fetch = {
>         .pmu = {
> -               .task_ctx_nr    = perf_invalid_context,
> +               .task_ctx_nr    = perf_hw_context,
>
>                 .event_init     = perf_ibs_init,
>                 .add            = perf_ibs_add,
> @@ -655,7 +655,7 @@ static struct perf_ibs perf_ibs_fetch = {
>
>  static struct perf_ibs perf_ibs_op = {
>         .pmu = {
> -               .task_ctx_nr    = perf_invalid_context,
> +               .task_ctx_nr    = perf_hw_context,
>
>                 .event_init     = perf_ibs_init,
>                 .add            = perf_ibs_add,
> --
> 2.37.3
>
