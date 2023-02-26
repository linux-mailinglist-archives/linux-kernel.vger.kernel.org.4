Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1294F6A2E12
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 05:13:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbjBZENS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 23:13:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjBZENO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 23:13:14 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E6326E9E
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 20:13:13 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id d30so12907029eda.4
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 20:13:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nPj9sJVzmTzKFB9cxNvS+JRlaKods9oYWgBQku2a2L8=;
        b=CafQUTlsPDHDc2CFQJxnO1AlvGQiJGYr0Ppa+3TBpisRU4X3unCfXutJ4NeYoal0jC
         DL6H/+0M89/cgSPhR6FHIO7yuFnpQ7JdnjTE8FRYszvWOvIKlKIiyi0lDvOzv35A379h
         /V/g4WFFUm7XvEbClTJc35on2eiNeGcswApbc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nPj9sJVzmTzKFB9cxNvS+JRlaKods9oYWgBQku2a2L8=;
        b=SDqsz85bINtBd9PxF+udPsI5kiF10kxtf4FMkhNR1ge3O4JwySq80Ewdwb+wKJ/8ZY
         yCBRwbH6J59+P0OZug66Nmhk7UjUaLxYOsHFIzzTfuGUn7JorAU1wQMhJakPhJ80UhrU
         DcaAtP/LY8kppP0dMqpS4BJ0zEN00eCRpDCq8hHy2PYMpY+M5p9C0q3WTg/p7gQnfJC9
         feLQKLqmpYpAPrt+XtfiWch2mDlffW4UIWBhA1VoWsO5BWn/sJsdVwV7HhqfdriJE69l
         p8uCmM44PFbKxMkTFmra/kgYGH4Wr0d8vAGmDvlJiqIr8p+GlkPZCpuuTzWDBfEDplUZ
         kZfg==
X-Gm-Message-State: AO0yUKUnC3kmGxlLNcy3+KjLEYbNBAWscn7DfXmeEQLeRcMAborwRNzL
        cWWavcrVPao1O3bU1uV5gMPyKzzUa0IYsBVEQk7LKg==
X-Google-Smtp-Source: AK7set+GnabQvdpfpXvvdiVwOE60ByaOa+3fQVHmPo+wQLXaEpHGTdTQG4vcT5pBxrdwa+6EFrkNAw==
X-Received: by 2002:a17:907:9849:b0:8b2:37b5:cc9 with SMTP id jj9-20020a170907984900b008b237b50cc9mr30842722ejc.17.1677384791404;
        Sat, 25 Feb 2023 20:13:11 -0800 (PST)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id a98-20020a509eeb000000b004ad601533a3sm1512584edf.55.2023.02.25.20.13.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Feb 2023 20:13:10 -0800 (PST)
Received: by mail-ed1-f42.google.com with SMTP id cq23so12984754edb.1
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 20:13:10 -0800 (PST)
X-Received: by 2002:a17:906:8508:b0:8d0:2c55:1aa with SMTP id
 i8-20020a170906850800b008d02c5501aamr10538324ejx.0.1677384790526; Sat, 25 Feb
 2023 20:13:10 -0800 (PST)
MIME-Version: 1.0
References: <20230220135225.91b0f28344c01d5306c31230@linux-foundation.org>
 <CAHk-=whVN2gKO_7UvMqgG8cetrVs3BCTxQovJvhC5x7AcJDJgQ@mail.gmail.com>
 <CAHk-=wgxWDgLJ-e3uDiYQvmMEqTNYFvDxtHbu4inR=zgBEP11Q@mail.gmail.com>
 <CAHk-=wjFmVL7NiuxL54qLkoabni_yD-oF9=dpDgETtdsiCbhUg@mail.gmail.com>
 <20230225195727.1b73a356f4f1a79833a31885@linux-foundation.org> <CAHk-=whpy3yHt0X5Vb97kdvtryj93KVTJs07zLZVJ8zEXH=Q-A@mail.gmail.com>
In-Reply-To: <CAHk-=whpy3yHt0X5Vb97kdvtryj93KVTJs07zLZVJ8zEXH=Q-A@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 25 Feb 2023 20:12:53 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjo3-YZfsG4qJEjMBPxoCC57uWVtyez9LQQu+JTCNtfgg@mail.gmail.com>
Message-ID: <CAHk-=wjo3-YZfsG4qJEjMBPxoCC57uWVtyez9LQQu+JTCNtfgg@mail.gmail.com>
Subject: Re: [GIT PULL] MM updates for 6.3-rc1
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Liam R. Howlett" <Liam.Howlett@oracle.com>, linux-mm@kvack.org,
        mm-commits@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Sat, Feb 25, 2023 at 8:03=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Will test right away. It's certainly right in that suspicious area.

Yup. That fixes it for me.

I'll just apply it directly.

              Linus
