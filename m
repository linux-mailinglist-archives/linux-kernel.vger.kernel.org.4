Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54CC06C1FB0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 19:29:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbjCTS3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 14:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbjCTS3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 14:29:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99389AD25;
        Mon, 20 Mar 2023 11:21:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 43B38B80E6B;
        Mon, 20 Mar 2023 18:21:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07ACDC4339C;
        Mon, 20 Mar 2023 18:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679336483;
        bh=90Js5AXKAuYFcX6gyojlhCPyfPNMYTsfiXawUSspkjQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nFB6ZtkrHJ98/KzRB+ukoV03uculXitgCJB5bL1y2j5b2PXCRVU8czdtKvQeQ9WFW
         EmfdiXHNRIcKQdBx8Zxce/xHPlJThb1sh3vxhVdxeSZ04AD/R9IDUAB7HPoMwZDn/p
         mLdBgznbugfq8pqdIVq7LgRwD3oz9ynpd+SHi/Sz1rYhkK+8qfrzDS+5WwBHnZGE11
         r9RqAkCtNF2vfrDiIfjirYhi0xe8c3uXW6HkqXxMH1P3U3Q4sYoreWBWvO/yXyv02I
         1KlkDdenat45WWzcult4Q463clJ4KJGlqykH1KhNoeKCE0x0MnT+b/diLdTEM4xstG
         HXWMjz5NRo/5w==
Received: by mail-ua1-f42.google.com with SMTP id g9so4071756uam.9;
        Mon, 20 Mar 2023 11:21:22 -0700 (PDT)
X-Gm-Message-State: AO0yUKVeV2yoIdPg1ld6eA+PJ8JhleJBjFXWh5otIJDVh+HZ9jYs0erG
        8G0yP/nsG1u0D+Ch32ai2rAFnrbBzYuiqA5Tbg==
X-Google-Smtp-Source: AK7set/OvN8aYUC9NkIqrZpBU3dUWhruxYt0hxPWmbNFknRenQlNBhAulaCUdwLMAukgz53ZrJzUKQftgDPBPI5Ok4E=
X-Received: by 2002:a1f:2982:0:b0:401:8898:ea44 with SMTP id
 p124-20020a1f2982000000b004018898ea44mr149758vkp.3.1679336481957; Mon, 20 Mar
 2023 11:21:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220914-arm-perf-tool-spe1-2-v2-v5-0-2cf5210b2f77@kernel.org>
 <20220914-arm-perf-tool-spe1-2-v2-v5-1-2cf5210b2f77@kernel.org> <Y/DQ7Y+FD4cMn29J@kernel.org>
In-Reply-To: <Y/DQ7Y+FD4cMn29J@kernel.org>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 20 Mar 2023 13:21:10 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLD_P1X1+vKODgZP1vaie2+c__X_HM8kWWzSb7PxZqZew@mail.gmail.com>
Message-ID: <CAL_JsqLD_P1X1+vKODgZP1vaie2+c__X_HM8kWWzSb7PxZqZew@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] perf tools: Sync perf_event_attr::config3 addition
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        James Clark <james.clark@arm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 18, 2023 at 7:21=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Fri, Feb 17, 2023 at 04:32:10PM -0600, Rob Herring escreveu:
> > Arm SPEv1.2 adds another 64-bits of event filtering control. As the
> > existing perf_event_attr::configN fields are all used up for SPE PMU, a=
n
> > additional field is needed. Add a new 'config3' field.
> >
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> > This matches commit 09519ec3b19e ("perf: Add perf_event_attr::config3")
> > for the kernel queued in linux-next.
>
> When you mention linux-next where was it that it picked this from?
>
> For me to get this merged into the perf tools "next" (perf/core) it must
> already have been merged in the kernel counterpart (tip/perf/core).
>
> Ok so it is not in tip/perf/core, but got in next yesterday, and PeterZ
> acked it, good, will process it soon.

Hi Arnaldo, Are you going to apply this or are you expecting something from=
 me?

Rob
