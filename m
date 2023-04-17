Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5DD16E54C1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 00:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjDQWsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 18:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjDQWsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 18:48:10 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 141C91BF6
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 15:48:09 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-54fbb713301so193639557b3.11
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 15:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681771688; x=1684363688;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ErxTGJUykViTqmt6WCCTleQjhu6oxiRybvh3f13WgdU=;
        b=xSNtcrKVSjj4TlFzMbctOBaE5nYolpJb0xN9M59zJn1Wd472mjAeT+csdZmQwwGHCe
         KeNgRF3Il8zjpOocP4lmAHXEYbpO0slHPlqdhV7s3VGPnC1MUMxPltkCGgyTvhafdw49
         xXfxJNdPODi22BsQoHbL3e3NAjoUsSZ36wbolu2GUWPQWuJ5o5zQnn3hZTSz1L6hP9ft
         RVcyRm2K3LaZ0qWMmJxG2H5v64Z6IS3gdxzcomkntNalKBjNbCqBhkOky8swC/sPkh7A
         ma9Wf0nxejXaQOUALaFbVLTJvNbWSVzjRKASZYq7tSrbIN93zmMJbFkrEzvOx+SPoJh9
         iBgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681771688; x=1684363688;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ErxTGJUykViTqmt6WCCTleQjhu6oxiRybvh3f13WgdU=;
        b=itxHJxt7rK39akaShweOjyOQiiUxbyj90Hd4HVtmM/Yz1aWCS6n5S0fx1V67O9Yng+
         mchBLyi8c5PP7La/i3ZCKYkIea+jhadut4ke4puHQdecHmvXsLKLn1bIwrlXMU4xKAA2
         mV7/o0nuFZunQauXV8W54+Nqk5MINXFcD1dMZVN4u+UqA73hDsZSEJiOJYX9j+j/PSsq
         jBtFsIX0VbVMY7woXGL9ULeKgP9ZK+WFF0QeqsYaMNAMx1HalZfqqO3kb2y6gevd+JNL
         n1wH3sEl1dnpcT7L73ccWvsc+a5AVx+SwaymFnhZFdBfIsFjbxbn+ZRhyljzUY7n9Kpj
         Rg2w==
X-Gm-Message-State: AAQBX9cpjxN5Swo2270bgcIQ9Z7lUBLfgis37C6RrpOgL0hSt/9gBQT4
        23A6vsnO6WmU0dz0Vy0dO0qHN0DfVeyouERHo0UhkA==
X-Google-Smtp-Source: AKy350YW7tdm3wiwjLGqPOWvRUjFlScErtyWkS5EL2jQGFe+jk8cVF6cNdOBXqnw50f86b24eatjzD9YrXc8zbqKSNo=
X-Received: by 2002:a81:d44c:0:b0:54e:d618:f86c with SMTP id
 g12-20020a81d44c000000b0054ed618f86cmr10170524ywl.1.1681771688111; Mon, 17
 Apr 2023 15:48:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230415000818.1955007-1-surenb@google.com> <ZD25bBPbZYSb7grA@x1n>
In-Reply-To: <ZD25bBPbZYSb7grA@x1n>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 17 Apr 2023 15:47:57 -0700
Message-ID: <CAJuCfpHf06cr2d277DXQUtBto_0bVgK3ykMHLYRgZXgnot=e4w@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] mm: do not increment pgfault stats when page fault
 handler retries
To:     Peter Xu <peterx@redhat.com>
Cc:     akpm@linux-foundation.org, willy@infradead.org, hannes@cmpxchg.org,
        mhocko@suse.com, josef@toxicpanda.com, jack@suse.cz,
        ldufour@linux.ibm.com, laurent.dufour@fr.ibm.com,
        michel@lespinasse.org, liam.howlett@oracle.com, jglisse@google.com,
        vbabka@suse.cz, minchan@google.com, dave@stgolabs.net,
        punit.agrawal@bytedance.com, lstoakes@gmail.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, Apr 17, 2023 at 2:26=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote:
>
> On Fri, Apr 14, 2023 at 05:08:18PM -0700, Suren Baghdasaryan wrote:
> > @@ -5223,8 +5230,8 @@ vm_fault_t handle_mm_fault(struct vm_area_struct =
*vma, unsigned long address,
> >               if (task_in_memcg_oom(current) && !(ret & VM_FAULT_OOM))
> >                       mem_cgroup_oom_synchronize(false);
> >       }
> > -
> > -     mm_account_fault(regs, address, flags, ret);
> > +out:
> > +     mm_account_fault(mm, regs, address, flags, ret);
>
> Ah, one more question.. can this cached mm race with a destroying mm (jus=
t
> like the vma race we wanted to avoid)?  Still a question only applies to
> COMPLETE case when mmap read lock can be released.  Thanks,

I believe that is impossible because whoever is calling the page fault
handler has stabilized the mm by getting a refcount.

>
> >
> >       return ret;
> >  }
>
> --
> Peter Xu
>
