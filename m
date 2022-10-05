Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABD1A5F5B25
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 22:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbiJEUlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 16:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231148AbiJEUlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 16:41:08 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CACF65674
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 13:41:07 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id u21so129144edi.9
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 13:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wezMY0HcT+UXrF/Kp1mqgrelTmjrv48aVuFmQkT0QkM=;
        b=pMRkqZuA0XwgD1ltGokKvQ/xSa9jAL8/1q6ZYlVAdIz48r82ogNpa+9g+ARAOTz0xm
         QVsTbAqCecamtq6Rn1+jQJE8fdQklZzaJOTkX+iMZ0l2y0N5cRRTLNIUlzJU+BjwgRVZ
         SjKPpaDirLtUtwnJQg/PfqJvzasGa04p8Wcs7WnG3ItKuWX3RA4HkWBlxGBUkCkZok+k
         ENITADfYS53EvKj3Loc0kSfkkcv8K3YQs8ucD89brYvI0mieIzei8S6fnBBdCbsgmqEi
         oyrLqPZ0WzOmh0zLajlgbUTVdlV+UHtIPCaNKmtqoz9QFkR55ma6PrmspEgT78kUuhPq
         y5dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wezMY0HcT+UXrF/Kp1mqgrelTmjrv48aVuFmQkT0QkM=;
        b=gQaw+QN6CdEOYxUs8J6qNuEM0DV/GT+h7/dDkbd8xZP2yOG0i/qfEDcy5Pk7QDnlsB
         UlyyQ4eYRuHeQGJL8521+HNIYFYbekVOBzYRcIG9BnW0BserJiJcpxK6fKBAGfKy/lJG
         dSM83///K55l33e7S0iBR86rSWzG+s+84R/HS5wGfTpkG7ErQp5HE6Hh/azHaYv6tXse
         yiTjhGbMHBHSXONKppmIIwVhzEJcd0r6DmEIAxgvHGzOPf8t8OHdawEoybobvbHq5BVp
         yD3z+Z2Mgmgl/kipFP552kz/xGhfiRIqp8yJnbcAEKoqPAyXb5WyanbCGejBZxlk5tsZ
         vV4g==
X-Gm-Message-State: ACrzQf1/XRBJkO579Ea2Nxiax4rESed63am/lgMkL2gE9fBErMSmlpXp
        g4Gfi2H3raiojzj5eYJLnTEb4tKfYbf3y+HpoAx70cPQQzrDkg==
X-Google-Smtp-Source: AMsMyM5ZqR/Q+hN0/JlujBTlWbuTUIYpAXZac8OwJLMYeXl9GqBRApH2XD/qoCRHNW3cxtqfK2j8RjRm9ES4wJFR788=
X-Received: by 2002:a05:6402:4310:b0:459:7806:8ee6 with SMTP id
 m16-20020a056402431000b0045978068ee6mr1504103edc.198.1665002465512; Wed, 05
 Oct 2022 13:41:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220722171534.3576419-1-dlatypov@google.com> <20220722171534.3576419-5-dlatypov@google.com>
In-Reply-To: <20220722171534.3576419-5-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 5 Oct 2022 16:40:54 -0400
Message-ID: <CAFd5g47oBwrxFeKHKrppxaLCAPqLa=r-zNvs0QJEXiqu8ZYhYg@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] kunit: make kunit_kfree(NULL) a no-op to match kfree()
To:     Daniel Latypov <dlatypov@google.com>
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
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

On Fri, Jul 22, 2022 at 1:15 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> The real kfree() function will silently return when given a NULL.
> So a user might reasonably think they can write the following code:
>   char *buffer = NULL;
>   if (param->use_buffer) buffer = kunit_kzalloc(test, 10, GFP_KERNEL);
>   ...
>   kunit_kfree(test, buffer);
>
> As-is, kunit_kfree() will mark the test as FAILED when buffer is NULL.
> (And in earlier times, it would segfault).
>
> Let's match the semantics of kfree().
>
> Suggested-by: David Gow <davidgow@google.com>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
