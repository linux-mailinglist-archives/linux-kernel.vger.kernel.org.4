Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17826645231
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 03:44:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbiLGCoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 21:44:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiLGCoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 21:44:09 -0500
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9570C54767
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 18:44:08 -0800 (PST)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-3b10392c064so172689357b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 18:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KbXxDs8qKafWAR7bqMoI00ZpTS2+CW/S/4T/0IodwXQ=;
        b=FzBv8eonOeeQZyfeURr9aLopxT7FxdLDbDtjyt7834bRLjztrdyk7RY71F91+2l+81
         eQlarU87dp3oo39ZemUgu6mxVoqK4m9b7o2xWVYga1nnzgjDqIDmtZ/BjrDDtSjzXqF6
         DHpBi5+La4ZijX2hpvpN7zHEf0mcepIXJVoZHDG5FI5ujCgsq/79szOiNEim5qrm9Be+
         kRfTpHT6LLpQgS9xD4/HNINLlwMtC0HShoMHIf0IzLe/c7tjA0BID+C7jOjD5eWna+TJ
         qJdmYX6S34JJhGGif3AGmQ+n2y+1A+o7U5IQr2R3xxRH1eHladqu6EudTtyS/sSZQOpZ
         ZPjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KbXxDs8qKafWAR7bqMoI00ZpTS2+CW/S/4T/0IodwXQ=;
        b=ZGC5d/B8kMe2Lu53W+lV7hYgYEJ/7wgdueit6iUSHfQtdgAdnm3HPCGGyI2zuC6+tI
         uGjzSME3jqaIuD4b4DY9TJJVUfZQVyk3a6pEPfz+dlscIDSiwYQaLp8Pjre1HTaOC5vB
         zxjxD74thN5GcfbdFw8gNKj2xJiDs92tRAyQz7egzclEQblhMSTxniXA0qGB5zmmNUNh
         kuymj896UP0Iy4BrleI4cbG4SrDQAVGOYMq9s5u8uLR6LubUUGqXDGuXVb74kj4c/nlb
         UrSokyDhkNCvo8MpDXxNWFgO3lNuVX4lTDHaM4JD9l5tjlcRjwjqOr0nG+sL2ff8OawB
         /B+w==
X-Gm-Message-State: ANoB5pnbWMFWAsj0pIxNywYes2hfHgwBbPkxVl0svJnrsvfAcWoQTtGQ
        BpAuenKQt1SP2La42nzOcni7ylWdofyp75Qo5FgxGVcx
X-Google-Smtp-Source: AA0mqf4nu3gyaTzemasNgoy5PmsN4M8Y7wPhavQsBkWj7i7B2+81sTF+qDRAcFC1mOjutUIGU53ODw9WfmNgSMaQIDU=
X-Received: by 2002:a0d:cb93:0:b0:3e4:5d25:d33f with SMTP id
 n141-20020a0dcb93000000b003e45d25d33fmr17233968ywd.190.1670381047765; Tue, 06
 Dec 2022 18:44:07 -0800 (PST)
MIME-Version: 1.0
References: <20221207002158.418789-3-vishal.moola@gmail.com> <20221207005624.146281-1-sj@kernel.org>
In-Reply-To: <20221207005624.146281-1-sj@kernel.org>
From:   Vishal Moola <vishal.moola@gmail.com>
Date:   Tue, 6 Dec 2022 18:43:57 -0800
Message-ID: <CAOzc2pwexH7Phhg_Dx0_9dg5_3n=uKSwbpWDKBbNQdY0N97U-Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] damon: Convert damon_pa_mark_accessed_or_deactivate()
 to use folios
To:     SeongJae Park <sj@kernel.org>
Cc:     linux-mm@kvack.org, damon@lists.linux.dev,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 6, 2022 at 4:56 PM SeongJae Park <sj@kernel.org> wrote:
>
> Hi Vishal,
>
>
> Thank you for this patch.
>
> Nit pick.  Could we please replace 'damon:' on the subject with 'mm/damon:' to
> look more consistent with other DAMON patches?

Thanks for looking over this patch! I'll make the subject mm/damon in a v2.

> On Tue, 6 Dec 2022 16:21:57 -0800 "Vishal Moola (Oracle)" <vishal.moola@gmail.com> wrote:
>
> > This change replaces 2 calls to compound_head() with one.
>
> I guess you mean _compound_head() calls in page_folio() that called from
> mark_page_accessed() and folio_mark_accessed().  However, deactivate_page()
> calls page_folio() anyway, so this patch doesn't reduce the number of calls to
> one but keep the number, correct?  Am I missing something?  If I'm not, I'd
> like to clean up the wording.

The 2 calls I was referring to were from mark_page_accessed() and put_page().
As you've noticed, deactivate_page() still calls page_folio() here :).

> > This is in preparation for the conversion of deactivate_page() to
> > deactivate_folio().
>
> I think folio_deactivate() might be a more consistent naming.  What do you
> think?

I do like the name folio_deactivate() better than deactivate_folio(), I'll
change that in v2 as well.
