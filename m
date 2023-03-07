Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 546C06ADDDD
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 12:45:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbjCGLpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 06:45:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231599AbjCGLpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 06:45:20 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F393D2ED50
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 03:43:05 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id k199so11068699ybf.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 03:43:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678189362;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W0Pg/5go5okMOd8kzLpnIadugYtaUbM7sSSdCILMJbA=;
        b=PZzwQiyUsm+OelT9posUdixTHFgvGtfVWeJuRqXA4TiNXqrrR31AtdCb6Oq7VSZyv0
         RQ5gWik383Dy5PFfulCm11qs3amFSCEZM4/Nzd7Pt9mElfhvIkr6gs27by3aSWQ+IeXf
         r+irHBbTGxIrSazYY5d5k3ObiMf7lji8dJvGWPNX1WA7GZIApEVqL+m+1LGm5WbX42SK
         68LT0wHLgdrp1oScW/JagcrR+fDN+HrohMLUXmP5W8p8MIaq6UWgFya3M2FbqIWuYkE/
         tGH9FuOGmdqlTLNSqjUlKudBTl3ipTrjsz1O8xhzYilWj1TrRA3CjHcYhHNm0A8fNpDe
         LCsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678189362;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W0Pg/5go5okMOd8kzLpnIadugYtaUbM7sSSdCILMJbA=;
        b=FpjZVpVRECRG57ek3VYEWNVwjfHCfUD+sfWT0aTw+YULgVFmK+gzOTaJPRkVxcowvN
         noLgIJDjEkl88xZ8O64fuqHBXT8fHIZ+cYUH9aPg7z6xDMOl/8GWho0eW8HellLUKStg
         pdgWy12Yhk5Joixg2lPa7bK+my89/dNHsjr8UGojbzkpmTJpkIV/pMzOIeFRRDm1cD2a
         9Je+NSXlA/I1aFYRUBU+MEONS363U1r1ijKSbSFYnPeJa8mC44z5S2kZ3L31EVU+cUdQ
         7M+3C5N8B+9nDcjaJ2xIYjFNImT5TBAy5xZA2ENIsrH63/MNozSqxPvXcjAyrpl1PxBL
         EFfg==
X-Gm-Message-State: AO0yUKVRP300MZeh2W6mbigZOl0fC2V7qEa8aDAHmIvhf/WDCObJ3Mzd
        /WNy8S/Ek+Kn/mmn0/wkGv7kGQn7Gby8F1SIGV0hv0DhNMw6ow==
X-Google-Smtp-Source: AK7set8storig3MmF0kJHWCV9+wOH8QIHS7JYIfte9OuP8C6W6QkB3Uln28mbHrF4iwqRwDpJFQEQWc3nbiUZGoVKOs=
X-Received: by 2002:a5b:191:0:b0:a6f:b921:cded with SMTP id
 r17-20020a5b0191000000b00a6fb921cdedmr6637988ybl.2.1678189362569; Tue, 07 Mar
 2023 03:42:42 -0800 (PST)
MIME-Version: 1.0
References: <20230306220947.1982272-1-trix@redhat.com> <CAKwvOdkd7pUu_oxt4=CW3fxXz2y7evtU9J5Gd7oQuyi1MkDMCw@mail.gmail.com>
 <C01C39FE-E776-48DA-84F2-402B49A705A8@kernel.org> <899b639b-3c93-b96d-863d-9e25d1824dc3@redhat.com>
In-Reply-To: <899b639b-3c93-b96d-863d-9e25d1824dc3@redhat.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 7 Mar 2023 12:42:31 +0100
Message-ID: <CANiq72kKmVzQYU7aOy4k0GsrgV=jfi_fLk2TvtWVGV_sXc8e2w@mail.gmail.com>
Subject: Re: [PATCH] init/Kconfig: extend -Wno-array-bounds to gcc 13
To:     Tom Rix <trix@redhat.com>
Cc:     Kees Cook <kees@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>, mhiramat@kernel.org,
        akpm@linux-foundation.org, masahiroy@kernel.org,
        paulmck@kernel.org, hannes@cmpxchg.org, ojeda@kernel.org,
        thunder.leizhen@huawei.com, christophe.leroy@csgroup.eu,
        vbabka@suse.cz, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 7, 2023 at 2:07=E2=80=AFAM Tom Rix <trix@redhat.com> wrote:
>
> The build with fail generally with gcc 13.
>
> The warnings could be cleaned without having an error, but I looked at
> multiple errors, none of them were real.
>
> imo this is a broken compiler option.

I am not sure I understand -- my reading of Kees' message is that he
would prefer to get the warning (rather than the kernel) fixed before
GCC 13 releases.

Are you asking to have the option disabled until GCC 13 releases and
reevaluate then? How many warnings are you getting? Are those actual
errors or `-Werror`?

Cheers,
Miguel
