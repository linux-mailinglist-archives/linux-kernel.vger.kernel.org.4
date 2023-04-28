Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A85B66F1C2D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 18:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344351AbjD1QDn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 12:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbjD1QDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 12:03:41 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 734802D51
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 09:03:40 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-552a6357d02so331927b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 09:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682697819; x=1685289819;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8QgP7oOPrCOMv4LzWX+EiazStwQFUH2wo4nGqGDOHAQ=;
        b=nvfKOytggc0TV2KC1oVi0eO9jK45GWpComHTEdKXS38DLXUAecZItgJp+zOL9O7ixs
         KRj5Ar99YcAM3NoA9WfWL63497jD7/7bITxxlATu2hbqRcj0JLhiIICwEqXHI9FdaL2I
         lqP/EXLTekjFh/xxnxZxYmQXbrVl7xQxOAYWqd7eDG6ntWNahsHR18+td5mj1D2fgUfy
         /jXGx1oPlomoWllZH4MNfPjphGCRMcOupm3Y5Vx1HkOVnOfDi96Q6zYOqkq0aUIhXwPc
         Ky0BAvwBDzrztRJ1E/wFcPq/b8C8sK9ibvtRYh138C4vdgydQ5E/HdfEsHec5NyAGESN
         IX+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682697819; x=1685289819;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8QgP7oOPrCOMv4LzWX+EiazStwQFUH2wo4nGqGDOHAQ=;
        b=h0q45+xoUbifxBJ7V2QGbnLW+dvJU1stfmBzF5atyD0Vt4o6xbaYCTUKR8oeVFjxkY
         nbiT9iVo6dKQ07KkyQh3tgsPj+06GEb/1vEIJZy0ZZYCHVrcXd6vXRUuVG4FFlXjRG8M
         uxqwjAgjTPt+xOSNwWpbQLokSt6aGXUjB/avb0iQihzwrvHWNXcylDkiJQ9Bwa4Lw1M+
         wb0aRQDuCip+6/d+mAhW0zKrq0fB8K5lfLaxm7fFb5OjRVK+wBlEqBA+ubaETrSPalbt
         BfVkKYwrWZKE+mkcv6Xd3qyxwuuzkJyotZy9jnnjBtcsu3IfTidehDWYFg/gmDsXZAWc
         OGpQ==
X-Gm-Message-State: AC+VfDxf4mZ4/OZN6mijj+DIKwH8YuUJrQ57OL1637cRjUCaSTEaRVCq
        k2/JOyRDErAZUoDpXa/D64obsi5c+CLdk39GqsFYXQ==
X-Google-Smtp-Source: ACHHUZ64tMS0gUi6CNL1GsL8dHEGzJsUS2Ahoys8Q+1dLz3B4rmbWKE4ji0jyrWetULT4u121cXCnOjs+4mItf3RNCA=
X-Received: by 2002:a81:6087:0:b0:54f:bb49:c3a2 with SMTP id
 u129-20020a816087000000b0054fbb49c3a2mr3750188ywb.28.1682697819401; Fri, 28
 Apr 2023 09:03:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230427153345.451d86681f9c6775ea579e5a@linux-foundation.org> <CAHk-=wi5=LfeCMv5ZPAtzWhJyW=y1rVJFTRBfgcqzoUNk5NRDA@mail.gmail.com>
In-Reply-To: <CAHk-=wi5=LfeCMv5ZPAtzWhJyW=y1rVJFTRBfgcqzoUNk5NRDA@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 28 Apr 2023 09:03:27 -0700
Message-ID: <CAJuCfpHZSEjG2nti5iWbPQjWgXcHZ95hFS2FKwaPC-sZPdSznw@mail.gmail.com>
Subject: Re: [GIT PULL] MM updates for 6.4-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        mm-commits@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Lorenzo Stoakes <lstoakes@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>
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

On Thu, Apr 27, 2023 at 8:03=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, Apr 27, 2023 at 3:33=E2=80=AFPM Andrew Morton <akpm@linux-foundat=
ion.org> wrote:
> >
> > - Suren Baghdasaryan has improved mmap_lock scalability by switching to
> >   per-VMA locking.
>
> .. related to this, we have that new PER_VMA_LOCK_STATS config entry,
> which is 'default y' and has basically no help test.
>
> Please don't do that.
>
> I don't think any of the VM debugging stuff should likely be 'default
> y' in the first place, but if they are, they should most definitely
> have a good *explanation* for why they should be on for a normal user.

Understood.
I wanted these stats enabled by default to be able to identify
possible pathological cases and to also let users disable them if they
can't tolerate even a small overhead in the pagefault path. Should I
document this reasoning for the config option?

>
>                       Linus
