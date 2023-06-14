Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3EFF72FA1B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 12:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243717AbjFNKHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 06:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243715AbjFNKH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 06:07:28 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA25DE69
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 03:07:15 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id ca18e2360f4ac-777ac4344f9so245447939f.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 03:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686737235; x=1689329235;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tjCmMtFWwB2mu1iBP1u/gNAJuDezygzcIcRRdC5qhOg=;
        b=dN/RPc2uJVqQoBzUWFUPvSNTOsL2/6BzZ6XbMJgjSsggKGhxCoyZx4qahBrqo6G6V7
         T2ObtSt81xwHzWYxge+OyCriEfpqz7NbQzH3m0L+4LPF2NFBOv5ZQDZ+yn75c37Q0OLb
         L/+l5FJ1La6wE29gV1ga+6SAspEGZnPZkTJbr5Wc+YLa5iPF4VlTE2WfpRx10QfE4Iql
         wf4CzCh+9HAf2P52b5FKyrUhbGzTnpn9ywWLMahLwtuozndpPL27f6qfpq4KQ3X9+pEt
         giOtZ/zqhaMpPO7zl/6wJ8XCG4iwl22+36lQ4hLNg6rO4ZNMNivRbFYo1NTWXC7xwxxa
         eIzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686737235; x=1689329235;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tjCmMtFWwB2mu1iBP1u/gNAJuDezygzcIcRRdC5qhOg=;
        b=B4ifW+lmFn3lQbEVH8DveWC9sUuFwp1vdiCYTd7lctrW3WxZGLbrFgyKCWq61L/J9C
         Dy7+TEijjPR7rQAiOFZqXBbT4CSzZl5JZvnFzdjG519fKHPbt72czaYhGJ5UndmCHySF
         /cjP89epvARhZsqD+pnuGVsahaoyuM9KIWmlIIIuW2UitWwUsmeAff1F2rLdwTxJYtOa
         /JRI+dcnkRZAyVlGRVUj0VMc0AOMa827XcM/0PRNfo+0O1U+2RQ2PKJO2+IpfDIqEx6Z
         aiDAmt37e4HLo+ROtDOvc/J45c8o0B9MQ+5oib+c6CmK7cAcTH1QfzdtcrYb4hCG+Hkw
         jHNg==
X-Gm-Message-State: AC+VfDzNXKySZ6tW1DpI7RoB+xWg7XlQhTY3rWfJdqp/0A8r6t1WavFr
        9hRroR3SrcnoH2tyaEMyMQcjjt9hX/0fZrYaliqIPw==
X-Google-Smtp-Source: ACHHUZ5XSR6ZLiDY1jdrgyARjmxixyspigafx6IBJqMWkzbgMS9KLnPvgObJlj35gRYHDv3X9b7FA/PNHnA4mh3QJBA=
X-Received: by 2002:a6b:dc11:0:b0:77a:d2d3:fbfa with SMTP id
 s17-20020a6bdc11000000b0077ad2d3fbfamr12536786ioc.6.1686737234757; Wed, 14
 Jun 2023 03:07:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230614095158.1133673-1-elver@google.com>
In-Reply-To: <20230614095158.1133673-1-elver@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Wed, 14 Jun 2023 12:06:38 +0200
Message-ID: <CAG_fn=UDZFa3D4JwkEMFoy-d6n-sNB5ARh+3b4ymgtzZCUe8uA@mail.gmail.com>
Subject: Re: [PATCH] kasan: add support for kasan.fault=panic_on_write
To:     Marco Elver <elver@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Taras Madan <tarasmadan@google.com>,
        Aleksandr Nogikh <nogikh@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Jonathan Corbet <corbet@lwn.net>, kasan-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2023 at 11:52=E2=80=AFAM Marco Elver <elver@google.com> wro=
te:
>
> KASAN's boot time kernel parameter 'kasan.fault=3D' currently supports
> 'report' and 'panic', which results in either only reporting bugs or
> also panicking on reports.
>
> However, some users may wish to have more control over when KASAN
> reports result in a kernel panic: in particular, KASAN reported invalid
> _writes_ are of special interest, because they have greater potential to
> corrupt random kernel memory or be more easily exploited.
>
> To panic on invalid writes only, introduce 'kasan.fault=3Dpanic_on_write'=
,
> which allows users to choose to continue running on invalid reads, but
> panic only on invalid writes.
>
> Signed-off-by: Marco Elver <elver@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>

Thanks!
