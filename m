Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA0C6C7F0E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 14:48:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbjCXNsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 09:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjCXNsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 09:48:19 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C459E5FC5
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 06:48:17 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id b18so2220315ybp.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 06:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1679665697;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tlxb7IQ6LLDgiORswv/qEWs9yBORD5ICbT5uFlhAdGc=;
        b=x0oemtBhzoiFQ9zWda8YdE4IseDam7CaY18ctp1AXcP7ra3LrMO9tKKr6KhxKPJd3l
         Cd4Z0SmWjI/+wnilZq7SchK5j4Geff5pvWrC1M9EzgYU4o+rTapdmUI4Rdg0R3lVd1AB
         Bn8dcgzZzsCVo1yd+pk9fPJEcPkXRPe/qqqjI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679665697;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tlxb7IQ6LLDgiORswv/qEWs9yBORD5ICbT5uFlhAdGc=;
        b=BuiB+xXp70LoFeD1Nks02j4YhupEuEB0J0tMUwyPWgIpisPq+vHJk7xn6KM3cTYmJU
         SomMYzwFrrGUsNlOkRR10S5mkfSWM5FzMKh9JHH7+5y3t8g8B3wSpjwgpKgadhWAXvuP
         aeBL6atRTrQp0G5WzHC//UY6vsLpYVMMUwvn+S3fcjhn8fTPWuYHicCUoidyWFL0R6j7
         XwpOAMdx5d5xMWBmX7ARZ+YFioh0X0Qz+OvfOpmiDCsHK6AGkOVPTsukg8RJowshSP3Z
         vRgb23r/6ksr4fPMZHEy8GpgIBpR7hWGFljbsYumGxr8rvilq1Orec2sK7jo4P4rtdVm
         EfQw==
X-Gm-Message-State: AAQBX9dnXDbBl37liXMYxO0Q8VKMldyNpbO2UdAiWFpYt7/o/uRCgeea
        uQNOq+/zRpiyI98jPVChdNybe8MxtoX/Hj1QJwBygQ==
X-Google-Smtp-Source: AKy350Y0Y+FOxa8FFx0ofJUqnL7e/TUq2l89UkZwjYNXRAkKDtrTBjVg9R6nGI2v46q4NjZOHtHAq+zXAL1AkTFMdCA=
X-Received: by 2002:a25:680e:0:b0:b78:3a15:e6fe with SMTP id
 d14-20020a25680e000000b00b783a15e6femr343682ybc.2.1679665696958; Fri, 24 Mar
 2023 06:48:16 -0700 (PDT)
MIME-Version: 1.0
References: <ZB2GTBD/LWTrkOiO@dhcp22.suse.cz> <20230324130530.xsmqcxapy4j2aaik@box.shutemov.name>
 <CAEXW_YQj_Wg0Xx2cHT9hTrDjEtrAV-bRjgL79=76d=D5f8GnEA@mail.gmail.com>
In-Reply-To: <CAEXW_YQj_Wg0Xx2cHT9hTrDjEtrAV-bRjgL79=76d=D5f8GnEA@mail.gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Fri, 24 Mar 2023 09:48:05 -0400
Message-ID: <CAEXW_YQuzSPm6wwfKuU-7riOsXyoCJK8+pwCmGdvWsJoaiT3mg@mail.gmail.com>
Subject: Re: WARN_ON in move_normal_pmd
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Michal Hocko <mhocko@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=1.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLACK autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2023 at 9:43=E2=80=AFAM Joel Fernandes <joel@joelfernandes.=
org> wrote:
>
> On Fri, Mar 24, 2023 at 9:05=E2=80=AFAM Kirill A. Shutemov <kirill@shutem=
ov.name> wrote:
> >
> > On Fri, Mar 24, 2023 at 12:15:24PM +0100, Michal Hocko wrote:
> > > Hi,
> > > our QA is regularly hitting
> > > [  544.198822][T20518] WARNING: CPU: 1 PID: 20518 at ../mm/mremap.c:2=
55 move_pgt_entry+0x4c6/0x510
> > > triggered by thp01 LTP test. This has been brought up in the past and
> > > resulted in f81fdd0c4ab7 ("mm: document warning in move_normal_pmd() =
and
> > > make it warn only once"). While it is good that the underlying proble=
m
> > > is understood, it doesn't seem there is enough interest to fix it
> > > properly. Which is fair but I am wondering whether the WARN_ON gives
> > > us anything here.
> > >
> > > Our QA process collects all unexpected side effects of tests and a WA=
RN*
> > > in the log is certainly one of those. This trigger bugs which are mos=
tly
> > > ignored as there is no upstream fix for them. This alone is nothing
> > > really critical but there are workloads which do run with panic on wa=
rn
> > > configured and this issue would put the system down which is unnecess=
ary
> > > IMHO. Would it be sufficient to replace the WARN_ON_ONCE by
> > > pr_warn_once?
> >
> > What about relaxing the check to exclude temporary stack from the WARN
> > condition:
> >
> > diff --git a/mm/mremap.c b/mm/mremap.c
> > index 411a85682b58..eb0778b9d645 100644
> > --- a/mm/mremap.c
> > +++ b/mm/mremap.c
> > @@ -247,15 +247,12 @@ static bool move_normal_pmd(struct vm_area_struct=
 *vma, unsigned long old_addr,
> >          * of any 4kB pages, but still there) PMD in the page table
> >          * tree.
> >          *
> > -        * Warn on it once - because we really should try to figure
> > -        * out how to do this better - but then say "I won't move
> > -        * this pmd".
> > -        *
> > -        * One alternative might be to just unmap the target pmd at
> > -        * this point, and verify that it really is empty. We'll see.
> > +        * Warn on it once unless it is initial (temporary) stack.
> >          */
> > -       if (WARN_ON_ONCE(!pmd_none(*new_pmd)))
> > +       if (!pmd_none(*new_pmd)) {
> > +               WARN_ON_ONCE(!vma_is_temporary_stack(vma));
> >                 return false;
> > +       }
>
> Wouldn't it be better to instead fix it from the caller side? Like
> making it non-overlapping.
>
> Reading some old threads, I had tried to fix it [1] along these lines
> but Linus was rightfully concerned about that fix [2]. Maybe we can
> revisit and fix it properly this time.
>
> Personally I feel the safest thing to do is to not do a
> non-overlapping mremap and get rid of the warning. Or is there a [..]

Aargh, I meant "not do an overlapping mremap", instead of "not do a
non-overlapping mremap". :-)

Thanks.
