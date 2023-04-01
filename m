Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD83E6D2D89
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 04:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234037AbjDACAV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 22:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234021AbjDAB7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 21:59:55 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCD3724404
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 18:58:50 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id h11so24217463lfu.8
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 18:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680314299; x=1682906299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vq3rSG2aoZXhHoIZpsTLA7CDeNmLWnFMK9f5Q3ElX6U=;
        b=cTMO764NVMfDQ02GmKYpwGW7uOyjMtRDGKwa69UXSukBmcjeHe9AlVqCgIM1W2mmNR
         zxTP4P4tyCpMy2GQ021fSPFRncsiv+E1CAfEXicYI5K/0TPUELO4gxS/WYJ+P7TtZtGx
         c2IToFU2gQV0xX8jb32yq9c9Z3L+sWD6x1CMCKxJEklErWPAmeZquTqGPpewiI9pHvPa
         cFNq8D1Q/o/3xs01WinP2ydg75sHOSYXghmrG++K3YSRtR42y4Ezkoe8jxR1XM7aDMOK
         3Usa2vJJngCWsZ36ADKfAC6RPFVYTjPnNxGDqh2RNIMKZLFQ4GUmWo//PRVnvbSmKunN
         MtWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680314299; x=1682906299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vq3rSG2aoZXhHoIZpsTLA7CDeNmLWnFMK9f5Q3ElX6U=;
        b=6m6r87CbfixLWRtMkdJQ+vBpbIxzRMMrpcDk2vNrN8oTEHS6pInvIAmSuWhVnM41it
         gl/oO0z/Qzg3MnX+ZAm8V7a3R3+yzgzhbqj5ii5egXE/bYQMY7tezdQ8fbOP7AGhBdRH
         MOJjfg5eq28W8shLKEwS6nyTEbulcB2yRmWohPeur+FJlwvB2ynwHXedZAsT9TJmNuTe
         QVymvvMgsJWhqUXWVVQMLbUZvPNtwEOXO1EFDnp64bLHh/JMG9aoJCTD6V3o0LomgE6w
         XDNe1Fwkg0JfJt0vdMgYzwNaekkqvS7xNipu/z4CdfnqLcDTRRN89kp+V6GdJ5kKGVXr
         Jvqg==
X-Gm-Message-State: AAQBX9cQCPY7UuwttpTTxn5Id2E2KzPa30qaUkUrdFUaC+MJZ2104RI9
        AfXEMwaAHHm/WkFTP+JtLoiS0I0AkgFya3En+LiwUPOG6aV+s83F1w4=
X-Google-Smtp-Source: AKy350axl64hB+NsJXRL/NGZ1OWlEZ7je83H8wof4NheuQHKtsQWreaDEyvoljdWcrxhAVbQEG9f9iONspCnq/gmV6s=
X-Received: by 2002:ac2:59c4:0:b0:4eb:d8d:6c17 with SMTP id
 x4-20020ac259c4000000b004eb0d8d6c17mr6349126lfn.10.1680314298620; Fri, 31 Mar
 2023 18:58:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230330155707.3106228-1-peterx@redhat.com> <20230330160714.3106999-1-peterx@redhat.com>
 <20230331183726.GD12460@monkey>
In-Reply-To: <20230331183726.GD12460@monkey>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Fri, 31 Mar 2023 18:57:41 -0700
Message-ID: <CAJHvVcjOqShPeu3mYk2Xu1ZyMfFLuPCUp8+8nQ+CUyCj4nZVqA@mail.gmail.com>
Subject: Re: [PATCH 10/29] selftests/mm: Test UFFDIO_ZEROPAGE only when !hugetlb
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Nadav Amit <nadav.amit@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 31, 2023 at 11:37=E2=80=AFAM Mike Kravetz <mike.kravetz@oracle.=
com> wrote:
>
> On 03/30/23 12:07, Peter Xu wrote:
> > Make the check as simple as "test_type =3D=3D TEST_HUGETLB" because tha=
t's the
> > only mem that doesn't support ZEROPAGE.
> >
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  tools/testing/selftests/mm/userfaultfd.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/testing/selftests/mm/userfaultfd.c b/tools/testing/s=
elftests/mm/userfaultfd.c
> > index 795fbc4d84f8..d724f1c78847 100644
> > --- a/tools/testing/selftests/mm/userfaultfd.c
> > +++ b/tools/testing/selftests/mm/userfaultfd.c
> > @@ -1118,7 +1118,7 @@ static int __uffdio_zeropage(int ufd, unsigned lo=
ng offset, bool retry)
> >  {
> >       struct uffdio_zeropage uffdio_zeropage;
> >       int ret;
> > -     bool has_zeropage =3D get_expected_ioctls(0) & (1 << _UFFDIO_ZERO=
PAGE);
> > +     bool has_zeropage =3D !(test_type =3D=3D TEST_HUGETLB);
>
> It is true that hugetlb is the only mem type that does not support zeropa=
ge.
> So, the change is correct.
>
> However, I actually prefer the explicit check that is there today.  It se=
ems
> more like a test of the API.  And, is more future proof is code changes.
>
> Just my opinion/thoughts, not a strong objection.

I agree. The existing code is more robust to future changes where we
might support or stop supporting this ioctl in some cases. It also
proves that the ioctl works, any time the API reports that it is
supported / ought to work, independent of when the *test* thinks it
should be supported.

Then again, I think this is unlikely to change in the future, so I
also agree with Mike that it's not the biggest deal.

> --
> Mike Kravetz
