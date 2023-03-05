Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8C986AB1CD
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 20:00:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjCES7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 13:59:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjCES7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 13:59:41 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDB9793F0
        for <linux-kernel@vger.kernel.org>; Sun,  5 Mar 2023 10:59:39 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id g3so30191439eda.1
        for <linux-kernel@vger.kernel.org>; Sun, 05 Mar 2023 10:59:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1678042778;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AN0CzpsMcXbcM4GDtUWIdtCQSMN2+Da6rXDKr4ksjhc=;
        b=A2zOzcha32H0Aeeyhe005ISvqzpkegozp3ihFTbtyYPModxTRVG7JYPvDtK649DTAe
         FH0LUepTIvGU+GAsF0GEQxtRyd1iOK68gdUKIKsi6zk4LD0+4OqS+7cFjM2k7UquIXKr
         f2Qf082lx3hTiAdRcqmLZee6/pphVM0Df/66Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678042778;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AN0CzpsMcXbcM4GDtUWIdtCQSMN2+Da6rXDKr4ksjhc=;
        b=kC1OgRj4Bn8xr1+GBU8kPmn77IYvKvROIMyyDVXF52xaNcX1fMb/ruznDjkouQVBU+
         Iu3fNcP0r6vceCGZUO2FRApsTU8W9BUuCAjncRhr4rqMBh9GdWVFpQCVT7eWmhReRDjP
         1P/41tE6kQpjvCrEzl8tFswmjtlpmO7KUXhdIT32yCTNP5vZpOQkAodh/t8Tla7Uwmvo
         e8WzLQYifWjg7nE4jTemfSfZWHOorvbq6iy0VrCnuUnKc0D/kDRUZ2yq+TnRcePUrtKM
         ITMhzpIURWcmvIg09M9LwmG9GRXR/cCp7gAClj9Phw/UeynuR8w7053TB2J8OWfKFJM2
         M4tQ==
X-Gm-Message-State: AO0yUKVA7hpjB1QlKpkjTm2VMoxCnVProtvBnZQ3B88pe4hB6b5Dbm7n
        u9xhHcohVA9xz8ZXAy3y6VpcXNmbKDXjMTeCjiv+xA==
X-Google-Smtp-Source: AK7set8KrSgogqrNDlmmUJSJqzWI8/W8CrJxps+wdmNzmlW4q3mCNQZWfWCESnpCp25sboZh7ZA2Iw==
X-Received: by 2002:a17:906:db05:b0:8ec:4334:fe with SMTP id xj5-20020a170906db0500b008ec433400femr10888200ejb.26.1678042778175;
        Sun, 05 Mar 2023 10:59:38 -0800 (PST)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id 21-20020a170906309500b008b1779ba3c1sm3517105ejv.115.2023.03.05.10.59.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Mar 2023 10:59:37 -0800 (PST)
Received: by mail-ed1-f49.google.com with SMTP id u9so30187286edd.2
        for <linux-kernel@vger.kernel.org>; Sun, 05 Mar 2023 10:59:37 -0800 (PST)
X-Received: by 2002:a17:906:4997:b0:877:7480:c75d with SMTP id
 p23-20020a170906499700b008777480c75dmr3946134eju.0.1678042390949; Sun, 05 Mar
 2023 10:53:10 -0800 (PST)
MIME-Version: 1.0
References: <20221016182349.49308-1-masahiroy@kernel.org> <CAK7LNASQfrL2JnL2QDE_fBLV6KmMuJATpvRk2vaB0db49OysEA@mail.gmail.com>
In-Reply-To: <CAK7LNASQfrL2JnL2QDE_fBLV6KmMuJATpvRk2vaB0db49OysEA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 5 Mar 2023 10:52:54 -0800
X-Gmail-Original-Message-ID: <CAHk-=wibvZQoNu3VCuH+WfOHdWeVG_Zz6GWXQwQ4EmSAQd8Avg@mail.gmail.com>
Message-ID: <CAHk-=wibvZQoNu3VCuH+WfOHdWeVG_Zz6GWXQwQ4EmSAQd8Avg@mail.gmail.com>
Subject: Re: [PATCH v3] Remove Intel compiler support
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>, Len Brown <lenb@kernel.org>,
        Nick Terrell <terrelln@fb.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Tom Rix <trix@redhat.com>, devel@acpica.org,
        linux-acpi@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 5, 2023 at 4:19=E2=80=AFAM Masahiro Yamada <masahiroy@kernel.or=
g> wrote:
>
> Are you happy with picking this up?
> https://lore.kernel.org/lkml/20221016182349.49308-1-masahiroy@kernel.org/

Done.

              Linus
