Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A64D70778B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 03:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbjERBnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 21:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbjERBnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 21:43:49 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D30E2681
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 18:43:47 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1ae64580e9fso55945ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 18:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684374227; x=1686966227;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0PO3eq+1UMnnMiki2DRBn6QhtFhDNQwR095O3RPt+vk=;
        b=Xyb4IV2yKjuyhUFulVfh1VhwAYVwEXQinkiQqGn8wFptaWJo1BWiSJKj9OoD4r719t
         HDp1HdJDXJP3f4Idq2CdJSZ6NpqhBqyza5VbiO8uL7qjOGDkgPh1JZkXhvWqrhTGhBCH
         kl4EjebJWT4evqzEVpg0SlSXBaf1aqNngGuK+reeotEiJLtIhW+3w2phujs0ygIebN6p
         erXfuM/BBYtCq854TvjGS3i3vf29y3Bae+9mhjYG32vGR1t8xZZFuvJxHtbwnYp1fCYF
         vCl55tMNz4sV+l17USlBnbBT7hy6FZhOFBlBfl+E//etH0VW93bj5XvoYvcWeDDyrC7c
         WW+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684374227; x=1686966227;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0PO3eq+1UMnnMiki2DRBn6QhtFhDNQwR095O3RPt+vk=;
        b=SCo/Es6bmSUs8h4EOmrcYuGizOqxRF2AubjxU6U4B9lTUWfAcEJ9/R74PvnDjc2lwi
         tIUThUfv6AlG2AV//L8qeELkI1EAeyAFDlNurwm17fSpTpt0z4GKp1+R/AVhc2yr7h1L
         51bYmiQ1es5GKGorpUZHgvehr88mYq1jIiKax39NXxl67J+uyhgKDVmZ8zL7C0RQx9wr
         iJu6Oi4M6mrzYImJoR/7Ma2d3N4P4mq48upA3f+mz0jccEztZLw0LWgvXkIA0uvUyJjE
         qF+WmMUG6wo75XpI/XlOdYMAPgxGsyX4gI1bP8J2u1Ay7sO46AkQywrKVSt1r6X+c54A
         XPgA==
X-Gm-Message-State: AC+VfDxrpaZZfuxXf6q1RxDGMLsbi6EgnvJnKMsXVaFwQCFY0hAraGlU
        izlJxAgxKzPeE+4DF69no+670g==
X-Google-Smtp-Source: ACHHUZ7WrXIOfi7pj20d8229kwsHD0XmSF6t0UxpkiubnJvSpHmsolgFW3CTTquOxk9F5x2iiCPhcg==
X-Received: by 2002:a17:902:f352:b0:1ae:4008:5404 with SMTP id q18-20020a170902f35200b001ae40085404mr80291ple.0.1684374226600;
        Wed, 17 May 2023 18:43:46 -0700 (PDT)
Received: from google.com (25.11.145.34.bc.googleusercontent.com. [34.145.11.25])
        by smtp.gmail.com with ESMTPSA id d14-20020a17090ae28e00b00247601ce2aesm2280427pjz.20.2023.05.17.18.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 18:43:46 -0700 (PDT)
Date:   Thu, 18 May 2023 01:43:43 +0000
From:   Fangrui Song <maskray@google.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     kasan-dev@googlegroups.com, Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Mukesh Ojha <quic_mojha@quicinc.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ubsan: add prototypes for internal functions
Message-ID: <20230518014343.32kht5dmthjuly34@google.com>
References: <20230517125102.930491-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230517125102.930491-1-arnd@kernel.org>
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

On 2023-05-17, Arnd Bergmann wrote:
>From: Arnd Bergmann <arnd@arndb.de>
>
>Most of the functions in ubsan that are only called from generated
>code don't have a prototype, which W=1 builds warn about:
>
>lib/ubsan.c:226:6: error: no previous prototype for '__ubsan_handle_divrem_overflow' [-Werror=missing-prototypes]
>lib/ubsan.c:307:6: error: no previous prototype for '__ubsan_handle_type_mismatch' [-Werror=missing-prototypes]
>lib/ubsan.c:321:6: error: no previous prototype for '__ubsan_handle_type_mismatch_v1' [-Werror=missing-prototypes]
>lib/ubsan.c:335:6: error: no previous prototype for '__ubsan_handle_out_of_bounds' [-Werror=missing-prototypes]
>lib/ubsan.c:352:6: error: no previous prototype for '__ubsan_handle_shift_out_of_bounds' [-Werror=missing-prototypes]
>lib/ubsan.c:394:6: error: no previous prototype for '__ubsan_handle_builtin_unreachable' [-Werror=missing-prototypes]
>lib/ubsan.c:404:6: error: no previous prototype for '__ubsan_handle_load_invalid_value' [-Werror=missing-prototypes]
>
>Add prototypes for all of these to lib/ubsan.h, and remove the
>one that was already present in ubsan.c.
>
>Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>---
> lib/ubsan.c |  3 ---
> lib/ubsan.h | 11 +++++++++++
> 2 files changed, 11 insertions(+), 3 deletions(-)
>
>diff --git a/lib/ubsan.c b/lib/ubsan.c
>index e2cc4a799312..3f90810f9f42 100644
>--- a/lib/ubsan.c
>+++ b/lib/ubsan.c
>@@ -423,9 +423,6 @@ void __ubsan_handle_load_invalid_value(void *_data, void *val)
> }
> EXPORT_SYMBOL(__ubsan_handle_load_invalid_value);
>
>-void __ubsan_handle_alignment_assumption(void *_data, unsigned long ptr,
>-					 unsigned long align,
>-					 unsigned long offset);
> void __ubsan_handle_alignment_assumption(void *_data, unsigned long ptr,
> 					 unsigned long align,
> 					 unsigned long offset)
>diff --git a/lib/ubsan.h b/lib/ubsan.h
>index cc5cb94895a6..5d99ab81913b 100644
>--- a/lib/ubsan.h
>+++ b/lib/ubsan.h
>@@ -124,4 +124,15 @@ typedef s64 s_max;
> typedef u64 u_max;
> #endif
>
>+void __ubsan_handle_divrem_overflow(void *_data, void *lhs, void *rhs);
>+void __ubsan_handle_type_mismatch(struct type_mismatch_data *data, void *ptr);
>+void __ubsan_handle_type_mismatch_v1(void *_data, void *ptr);
>+void __ubsan_handle_out_of_bounds(void *_data, void *index);
>+void __ubsan_handle_shift_out_of_bounds(void *_data, void *lhs, void *rhs);
>+void __ubsan_handle_builtin_unreachable(void *_data);
>+void __ubsan_handle_load_invalid_value(void *_data, void *val);
>+void __ubsan_handle_alignment_assumption(void *_data, unsigned long ptr,
>+					 unsigned long align,
>+					 unsigned long offset);
>+
> #endif
>-- 
>2.39.2

Thanks. I've checked that these signatures match the definitions in
lib/ubsan.c and the order matches as well.

Reviewed-by: Fangrui Song <maskray@google.com>
