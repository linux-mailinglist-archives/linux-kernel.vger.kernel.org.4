Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC036A2D45
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 04:27:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbjBZD1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 22:27:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjBZD1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 22:27:41 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AAA4113F7
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 19:27:40 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id d30so12726857eda.4
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 19:27:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K4LG6eymnVogwOKViXhHE1/PB/p0T/rjRJiCGRuQ7pc=;
        b=hje52BCvFJGjhtqKJ28w+Gj04eqoFbgZ1+idWrtOfIghYvxWYZ4to7CPGzRKBbY41x
         fQdBfHwAmsf+Q+7Y1Q9Hp/GUGQrmU1xP5TeFJROES/xtfL4CSl0VoBXEVxtgd2MrpbpH
         9JfrUd5O0jmbzLgN3zd022AYlbGZzc6X3UuAQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K4LG6eymnVogwOKViXhHE1/PB/p0T/rjRJiCGRuQ7pc=;
        b=aLK67TEhxFOWWicYDgtHUCSHr+ofLG8GD5dhERl9IdcHEDL3FpgohWmD+nOKDHj6UZ
         I0A5PGo1Mb3LNW7w+zGke8ahBDLDlnRPMiz0W63cBiLJtfPWmdX49+KmTxv5HdRYHJKn
         R5GkyAvqgxN9a4OKJzjyrA3ee0mwYZU7ykwk6EBbHyksVv2tN6RyMHCScqVb5vDqDFxk
         ciraNAjJGjrsNHfXJ3v/xylzUb2bwpBh4q5wSuUEdak5JYrJEl8LnpxbaE4lKVEvjFi3
         hBPbPTWtq0AmR7LdOLarH36852ayq3ejG8YBkPsXLzKeiZI/q0dCI1ZGWk8KqKVWHAnD
         Yo9Q==
X-Gm-Message-State: AO0yUKWmnisu+iBqjv840I0j6Rum74sERrWw2alzU9Zv0CWO5qazucyM
        HFeijrexkOtkKnpR1mm79vgAUEebXFSgp3GxWWq1SA==
X-Google-Smtp-Source: AK7set8oowlpTlukwUOWC4F+wQx9rNJPC4kkSa1QkvHHbqDLgJMni0VUM30kxBlIz3IcBrvynsU0yA==
X-Received: by 2002:aa7:dbd4:0:b0:4ac:bd08:f7ce with SMTP id v20-20020aa7dbd4000000b004acbd08f7cemr20733485edt.35.1677382058438;
        Sat, 25 Feb 2023 19:27:38 -0800 (PST)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id c14-20020a509f8e000000b004873927780bsm1480854edf.20.2023.02.25.19.27.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Feb 2023 19:27:37 -0800 (PST)
Received: by mail-ed1-f43.google.com with SMTP id cq23so12804717edb.1
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 19:27:37 -0800 (PST)
X-Received: by 2002:a17:906:1707:b0:8f1:4c6a:e72 with SMTP id
 c7-20020a170906170700b008f14c6a0e72mr4103996eje.0.1677382057309; Sat, 25 Feb
 2023 19:27:37 -0800 (PST)
MIME-Version: 1.0
References: <20230220135225.91b0f28344c01d5306c31230@linux-foundation.org> <CAHk-=whVN2gKO_7UvMqgG8cetrVs3BCTxQovJvhC5x7AcJDJgQ@mail.gmail.com>
In-Reply-To: <CAHk-=whVN2gKO_7UvMqgG8cetrVs3BCTxQovJvhC5x7AcJDJgQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 25 Feb 2023 19:27:20 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgxWDgLJ-e3uDiYQvmMEqTNYFvDxtHbu4inR=zgBEP11Q@mail.gmail.com>
Message-ID: <CAHk-=wgxWDgLJ-e3uDiYQvmMEqTNYFvDxtHbu4inR=zgBEP11Q@mail.gmail.com>
Subject: Re: [GIT PULL] MM updates for 6.3-rc1
To:     Andrew Morton <akpm@linux-foundation.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc:     linux-mm@kvack.org, mm-commits@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Sat, Feb 25, 2023 at 6:43=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Hmm. Just a note to let you know that I'm bisecting google-chrome
> dumping core, and it seems to be due to something in this pull.
>
> I've got a couple of hundred commits to go, so let's see what it
> bisects to, but right now all the bad state came from this pull,
> afaik.
>
> Maybe it's a false alarm, but it seems to be consistent so far.
>
> Will update when I've bisected closer.

It's solidly in the "change XYZ to use vma iterator" chunk now.

Commit 0378c0a0e9e4 ("mm/mmap: remove preallocation from
do_mas_align_munmap()") is good, and commit 37598f5a9d8b ("mlock:
convert mlock to vma iterator") is bad.

Will bisect further, but adding Liam to the participants because it's
now narrowed down to his changes.

               Linus
