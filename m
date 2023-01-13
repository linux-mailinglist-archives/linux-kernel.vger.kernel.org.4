Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A582766A45D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 21:47:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbjAMUq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 15:46:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231343AbjAMUqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 15:46:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C41C9892C5
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 12:46:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D90B6231C
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 20:46:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4031C433F0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 20:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673642773;
        bh=7eYc0XhXnQW93GkTSFYdIkOSneTuRRIkHMfKlRT3emM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=S43jiel7jHVWZxXocbPs9onLt6Fmy7xZvOXNcw7RyKIjL9j58y5jmOYd6x9IANi74
         3cG2ay04GatN2G0GsHHOsl6/ORg+pEG78YEAiCsiXpzOqccOOJsij7CHeM5BTOQo8T
         6gQiAPkXmVtgAtO4nyEQw/P31IfjQvynNFaove79hMNNpuiMZEpt3Ac1Gm5EEPvtLK
         uPoN/vq8nTxqn8RljxyKi73zI+0Ws007ZP0FdIpOC/UrFsNx33ShV3wk5m4ifXrtV8
         cGhxoSWe4KlsYoYRILYfMYYQdKevAbpEsQwsAai2c9o1+ZyHdYVOBgSr4RyjLdFL3/
         TXe/sNtjKGiPQ==
Received: by mail-lf1-f48.google.com with SMTP id b3so34726384lfv.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 12:46:13 -0800 (PST)
X-Gm-Message-State: AFqh2krrXhLwGTr4e/PYX1VkcYIJGFxpD0RMMx1bVwFOP1LzFnocqkRF
        KaYL7rHsHzm5DhfYjFjUiV1b+96ZvXPB3QeDVwk=
X-Google-Smtp-Source: AMrXdXsWvsRzFjpBxH0BYvnhEu1soeJwTK2Zeb8O9icHUx42bdlsXNkEMAldp2aBv5UshwYEi5M+2Ymrr+9EPlHaf4I=
X-Received: by 2002:a19:640f:0:b0:4b6:e71d:94a6 with SMTP id
 y15-20020a19640f000000b004b6e71d94a6mr6072221lfb.476.1673642771838; Fri, 13
 Jan 2023 12:46:11 -0800 (PST)
MIME-Version: 1.0
References: <20230112214015.1014857-1-namhyung@kernel.org> <20230112214015.1014857-3-namhyung@kernel.org>
In-Reply-To: <20230112214015.1014857-3-namhyung@kernel.org>
From:   Song Liu <song@kernel.org>
Date:   Fri, 13 Jan 2023 12:45:59 -0800
X-Gmail-Original-Message-ID: <CAPhsuW5t-9uLXvovdR=wj6o=RZhdaUucj_PkeWqcaSDgbn_q1Q@mail.gmail.com>
Message-ID: <CAPhsuW5t-9uLXvovdR=wj6o=RZhdaUucj_PkeWqcaSDgbn_q1Q@mail.gmail.com>
Subject: Re: [PATCH 2/8] perf/core: Add perf_sample_save_callchain() helper
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2023 at 1:40 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> When it saves the callchain to the perf sample data, it needs to update
> the sample flags and the dynamic size.  To make sure this, add the
> perf_sample_save_callchain() helper and convert all call sites.
>
> Cc: x86@kernel.org
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Song Liu <song@kernel.org>
