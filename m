Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94DFC66A44A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 21:44:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbjAMUon (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 15:44:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbjAMUok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 15:44:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C6678793B
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 12:44:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF19D60D3B
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 20:44:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 101C0C433F1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 20:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673642678;
        bh=4KWlkhuwcPpYsTSELkGTvyIM676qJP613CiwlFlJz4M=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bUA64pcd/0ISoQhyJtpEirJ7CcWhgshSsNym7VWuGXYBOOX6o+/jy9zk7m2O8euva
         kMaKRI2RQYOAQk+Emo9tuBB58bD/ywY7MSr7DmW5GF3LimadFnq26iwLsJK/cb/C/1
         n9RUNK1eZrvpay+Rwk+UuZmZTTVgRzidl8+O7hq2nfBAlSNp11JnxbUUOGzmg+17Y/
         Lz41dnTtUhfCr10k3lHtX7eLLKiCH9t1UUafTsiuWKD3rc2Z1yJX9h05dhm0uv/Dh2
         jC+GKW7ouiSBly3WqhFzZjzk0wO2GmjSBEJZ1v3giVIDflkFRx7hP+1TvuJbCmqjiX
         TrvW5F6JmLyOw==
Received: by mail-lj1-f181.google.com with SMTP id s22so23657335ljp.5
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 12:44:37 -0800 (PST)
X-Gm-Message-State: AFqh2kos6G0QWNYLCPwxznBHBc6FhcJ2UaHP+hTSMQHuj4MG1gHK52iI
        ztyEeN2tTUNM3urdY3LMmBE+z3rhKG5LL5uJDQ4=
X-Google-Smtp-Source: AMrXdXtCXYienvWzrKZgg9uFC3fsFyLG54NGegsyFZTIaxivnkD5t5YsDqzKQ1yS0ix9L3TPxHWW0x1JOFAxnw7Bv+E=
X-Received: by 2002:a2e:a26a:0:b0:285:3383:6635 with SMTP id
 k10-20020a2ea26a000000b0028533836635mr1408700ljm.323.1673642676044; Fri, 13
 Jan 2023 12:44:36 -0800 (PST)
MIME-Version: 1.0
References: <20230112214015.1014857-1-namhyung@kernel.org> <20230112214015.1014857-2-namhyung@kernel.org>
In-Reply-To: <20230112214015.1014857-2-namhyung@kernel.org>
From:   Song Liu <song@kernel.org>
Date:   Fri, 13 Jan 2023 12:44:23 -0800
X-Gmail-Original-Message-ID: <CAPhsuW4s1dz0nAgqLABB4rHY140GwoTQNst78Sye+VVqgfHhyw@mail.gmail.com>
Message-ID: <CAPhsuW4s1dz0nAgqLABB4rHY140GwoTQNst78Sye+VVqgfHhyw@mail.gmail.com>
Subject: Re: [PATCH 1/8] perf/core: Save the dynamic parts of sample data size
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
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
> The perf sample data can be divided into parts.  The event->header_size
> and event->id_header_size keep the static part of the sample data which
> is determined by the sample_type flags.
>
> But other parts like CALLCHAIN and BRANCH_STACK are changing dynamically
> so it needs to see the actual data.  In preparation of handling repeated
> calls for perf_prepare_sample(), it can save the dynamic size to the
> perf sample data to avoid the duplicate work.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Song Liu <song@kernel.org>
