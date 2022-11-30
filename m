Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 569C563DE47
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 19:35:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbiK3Sfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 13:35:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbiK3SfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 13:35:19 -0500
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5108094908;
        Wed, 30 Nov 2022 10:35:17 -0800 (PST)
Received: by mail-wr1-f46.google.com with SMTP id v1so28519254wrt.11;
        Wed, 30 Nov 2022 10:35:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vODMQMs9AFsDd392YJDnQtLYs2gL4oduDS+rooXoVmo=;
        b=EPNX6trFRYCJ6o/n+eQizWT42VaUaQe5kCWPyoRsi2Ff2vr/qegTYPjBDmXLqpiKoC
         vUIcWQevIsppIf1oICNwxcAY+s1PxPHmyVSE+W+e/g3b1v9MuWflfsmlgJYg4Ov6t7bW
         ZKR9jDVmEr04UUn+l7DRvs4cvIzi67tEdNZTM8hLCZMHeJMmo6sw7Kw45YeBdCvTe/Qv
         8kBtnQzaKrGGtmL7qqYP+aVL9EhONgy61YTKJ3QRDW/HMMmtBWI84mIfvyP3iK2vwc5C
         1HkB4HJ6CPdZqy1yzd3xIawZqR7L/TrHsvvP8ZMC9BPORGLV/gqO9PHKhxm9ffUOh3kL
         lIcw==
X-Gm-Message-State: ANoB5pkJGv4UlWVd2Bqci5MIH4HH/kkm/x61N2+q028Wlpeyei/AtI9/
        TazsqQOvAd3MbhCmsED1nHKZNH0UB/VNB6afJTU=
X-Google-Smtp-Source: AA0mqf6ABKES+9nS+Dn5EVZt/UNR8lE0tPKf/UqLfb0DvFVqMd1IvSh/Jnw+GIikfm6dXmVJ4cUmm5SWqXdzMbail+0=
X-Received: by 2002:adf:df05:0:b0:242:1783:5316 with SMTP id
 y5-20020adfdf05000000b0024217835316mr10336371wrl.701.1669833315512; Wed, 30
 Nov 2022 10:35:15 -0800 (PST)
MIME-Version: 1.0
References: <20221130165158.517385-1-james.clark@arm.com>
In-Reply-To: <20221130165158.517385-1-james.clark@arm.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 30 Nov 2022 10:35:03 -0800
Message-ID: <CAM9d7cg=nYY8PsjXZxui4YJQgwdiJUmwW5t5_0018R1yL61F=A@mail.gmail.com>
Subject: Re: [PATCH] perf: Fix interpretation of branch records
To:     James Clark <james.clark@arm.com>
Cc:     linux-perf-users@vger.kernel.org, acme@kernel.org,
        sandipan.das@amd.com, Anshuman.Khandual@arm.com,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 30, 2022 at 8:52 AM James Clark <james.clark@arm.com> wrote:
>
> Commit 93315e46b000 ("perf/core: Add speculation info to branch
> entries") added a new field in between type and new_type. Perf has
> its own copy of this struct so update it to match the kernel side.
>
> This doesn't currently cause any issues because new_type is only used
> by the Arm BRBE driver which isn't merged yet.
>
> Fixes: 93315e46b000 ("perf/core: Add speculation info to branch entries")
> Signed-off-by: James Clark <james.clark@arm.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


> ---
>  tools/perf/util/branch.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/branch.h b/tools/perf/util/branch.h
> index d6017c9b1872..3ed792db1125 100644
> --- a/tools/perf/util/branch.h
> +++ b/tools/perf/util/branch.h
> @@ -22,9 +22,10 @@ struct branch_flags {
>                         u64 abort:1;
>                         u64 cycles:16;
>                         u64 type:4;
> +                       u64 spec:2;
>                         u64 new_type:4;
>                         u64 priv:3;
> -                       u64 reserved:33;
> +                       u64 reserved:31;
>                 };
>         };
>  };
> --
> 2.25.1
>
