Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12AF86F7E1A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 09:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbjEEHoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 03:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbjEEHoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 03:44:24 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D83815693
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 00:44:23 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id e9e14a558f8ab-3318961b385so17167775ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 00:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683272663; x=1685864663;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lPZVtfp6t3Y0W83bt9VDuQwkydTNBKwgjyEPJPSY9oo=;
        b=3CTGLUNi41774qWN2MdvThPefR+2JWAFFB3SDr72C708dur/f93EMMFzAxRNyK5Ekv
         LIh/Lcfrzmg8Y0JkqH/TP00YbU0LHeEL1FIXunqiWpa/BHRx1Ii+By20gB8tRnqqmxWJ
         7rA2p5REb5sQET6rksFE2VvtWG6saxcb04bES43ic9H+OvnU+FnYTxvEMRhnrsEpzEN4
         +d4ZYueujsNWDQ3FLG9XEtBnnqnhAVfJfQ+Y7acMxW4pEE/2cQiZQhAHohyKuuVvc9Zp
         rMEJng5UAwkEoqOjj0mEMPToPiltEc53F3QJiz88LavqXUJqI0b3h2RCjbQN982JfBij
         F5jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683272663; x=1685864663;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lPZVtfp6t3Y0W83bt9VDuQwkydTNBKwgjyEPJPSY9oo=;
        b=KHX6/J+FGml1ZPLcjS92BzSEKJq/Q1ouZ/6m9F4h0hywG8ORkHWZp8DouWamZtqC11
         Goe+5JMjd0bV6B6zMKDJmz9N6Akhf0u2HIGOcXwN8TxyAx9gTKrq+iBokkHyTYjv4E+s
         6hc/SWVq+GP28ust2VfdMhkmhSYxSlNCAYdAUMhjPVRVeHsbqQeMI5i5dj27A7SdQBxg
         lc1QtDV94lmJcYYgZtK1IE3HTBm6NgAko0oWDvxGR6Xc0O9x4EVp3SlzRLzO8RtBQz7r
         yekXHCJhPqGzFh/5GzVqRs42hlQQF3FEx5T+v6ot1eV5fFNIJt5JTz/uV4eIe+nMflJj
         PmZA==
X-Gm-Message-State: AC+VfDzFznwuyG2uA3v+lRsqRVewa4587EqGJV6zzNFkqjSLl9PBTykC
        LkQwu4xrkXXxIL+L9lMtz8at7VuCeEZWym0IYrvMXA==
X-Google-Smtp-Source: ACHHUZ4epH5CJTOlram+1GD8qTmDW8HjKYhj0AillBoub3xAs1nJF7QedWwGl/arLZNXCFh6UVEOeuHiI5Hr+RGxzi0=
X-Received: by 2002:a5e:9244:0:b0:760:af65:4787 with SMTP id
 z4-20020a5e9244000000b00760af654787mr500379iop.6.1683272662794; Fri, 05 May
 2023 00:44:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230505035127.195387-1-mpe@ellerman.id.au>
In-Reply-To: <20230505035127.195387-1-mpe@ellerman.id.au>
From:   Marco Elver <elver@google.com>
Date:   Fri, 5 May 2023 09:43:46 +0200
Message-ID: <CANpmjNOmtTU=__W7=pKVibVZ3OnfgSsXeSsqHA7y=e3D-G026Q@mail.gmail.com>
Subject: Re: [PATCH] mm: kfence: Fix false positives on big endian
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     glider@google.com, akpm@linux-foundation.org,
        zhangpeng.00@bytedance.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 May 2023 at 05:51, Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> Since commit 1ba3cbf3ec3b ("mm: kfence: improve the performance of
> __kfence_alloc() and __kfence_free()"), kfence reports failures in
> random places at boot on big endian machines.
>
> The problem is that the new KFENCE_CANARY_PATTERN_U64 encodes the
> address of each byte in its value, so it needs to be byte swapped on big
> endian machines.
>
> The compiler is smart enough to do the le64_to_cpu() at compile time, so
> there is no runtime overhead.
>
> Fixes: 1ba3cbf3ec3b ("mm: kfence: improve the performance of __kfence_alloc() and __kfence_free()")
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Reviewed-by: Marco Elver <elver@google.com>

Andrew, is the Fixes enough to make it to stable as well or do we also
need Cc: stable?

Thanks,
-- Marco

> ---
>  mm/kfence/kfence.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/kfence/kfence.h b/mm/kfence/kfence.h
> index 2aafc46a4aaf..392fb273e7bd 100644
> --- a/mm/kfence/kfence.h
> +++ b/mm/kfence/kfence.h
> @@ -29,7 +29,7 @@
>   * canary of every 8 bytes is the same. 64-bit memory can be filled and checked
>   * at a time instead of byte by byte to improve performance.
>   */
> -#define KFENCE_CANARY_PATTERN_U64 ((u64)0xaaaaaaaaaaaaaaaa ^ (u64)(0x0706050403020100))
> +#define KFENCE_CANARY_PATTERN_U64 ((u64)0xaaaaaaaaaaaaaaaa ^ (u64)(le64_to_cpu(0x0706050403020100)))
>
>  /* Maximum stack depth for reports. */
>  #define KFENCE_STACK_DEPTH 64
> --
> 2.40.1
>
