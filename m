Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 224CB65F343
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 19:02:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235437AbjAESCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 13:02:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbjAESCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 13:02:00 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 878C0564C9
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 10:01:59 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id j8-20020a17090a3e0800b00225fdd5007fso2775785pjc.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 10:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vHWW7d/4nqIg9XiaDgLSDFBBLIaN1Qv+J6JoH4V8xI0=;
        b=ehw+5NEfopQ51aIgxvnYdxIqE7BXm0GnFy5XaoDN5Yo3F2NxAP0e/Rb6R5LHRPXkCT
         E6Qx4l1M3VSpwmdFXhdQTxuMiUNGJJZ59F1Hmop1hF3ZFd4aoQrctvt/mmyMb8XY/OYf
         gqGGskp8O7dsjo+U6og9Auo9Rzk8MPVpTD1KanPZDjtfcNmIOFc0HEPTnezO0bcZD91D
         ebrCa8IlkfL6bRYpFtsotZrcmokDrExIyc0keCqk0IWNHb8iw4bIhdIldYZ4doX+b/Im
         1M+MvgPm7GlNEycWC2EzBmS79n+ixQpLfnsrXJUpIKM6Tm7lp/CNCfgkDayEdlSd0K8g
         iW1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vHWW7d/4nqIg9XiaDgLSDFBBLIaN1Qv+J6JoH4V8xI0=;
        b=Ou4hLKdpOJgloaf/7Q8+Tp6Igxxn7RYgQZ765J+eLzsh9CoyHJbk7vI10UG6uVg712
         ynws2hRT/dv5JccpnmAN/sErWLenqECT1vJsZuYfUGqiBL+dOTIZO9dMkPG8E1Qf9H/n
         ybvzNolXdCoKT6pBJ2LobqEQMArvn/wjsIKG96k30G5mPFwH9/rE7XkcR+y6jrWLYpGz
         uRb+Y9bywHxCGIAUGvly3dw5XCytgiTqZgkkjjpZ9BCOgyExSxuUhVCCxSG2TQJQxXc4
         eXDTxWW8nz9G370OzLYNw94g7Ijre7f1qF/LNOqvyRgQP5eVlek17u9ZRbdoou75XdFf
         kwoA==
X-Gm-Message-State: AFqh2kofVw37fwF9Ey8wkwLawJqj7fZpNTS3s8kYYNnjHllbxHMotfDF
        E+dexSNp41xiFzEUC/KPVK8=
X-Google-Smtp-Source: AMrXdXsbKedjpEK50cNVsdWSFaM53QBXKTEA0m1PziGD3cm+l0oqn0g/2lhfInkIx1RbGWVu2Gihuw==
X-Received: by 2002:a17:902:d4ce:b0:191:770:328d with SMTP id o14-20020a170902d4ce00b001910770328dmr97098018plg.46.1672941718815;
        Thu, 05 Jan 2023 10:01:58 -0800 (PST)
Received: from smtpclient.apple (c-24-6-216-183.hsd1.ca.comcast.net. [24.6.216.183])
        by smtp.gmail.com with ESMTPSA id u6-20020a170902e5c600b00172fad607b3sm26371773plf.207.2023.01.05.10.01.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Jan 2023 10:01:58 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.300.101.1.3\))
Subject: Re: [PATCH 3/3] mm/uffd: Detect pgtable allocation failures
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <cc6e17ad-1afd-5c52-a06e-1d89d1978368@redhat.com>
Date:   Thu, 5 Jan 2023 10:01:46 -0800
Cc:     Peter Xu <peterx@redhat.com>, Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        James Houghton <jthoughton@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <B38AB79D-51D7-4F1A-A5CB-A60A46A3E27F@gmail.com>
References: <20230104225207.1066932-1-peterx@redhat.com>
 <20230104225207.1066932-4-peterx@redhat.com>
 <AF984D5D-DC66-4FD3-A749-5AF6B7289E0D@gmail.com>
 <cc6e17ad-1afd-5c52-a06e-1d89d1978368@redhat.com>
To:     David Hildenbrand <david@redhat.com>
X-Mailer: Apple Mail (2.3731.300.101.1.3)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 5, 2023, at 12:59 AM, David Hildenbrand <david@redhat.com> =
wrote:
>=20
> On 05.01.23 04:10, Nadav Amit wrote:
>>> On Jan 4, 2023, at 2:52 PM, Peter Xu <peterx@redhat.com> wrote:
>>>=20
>>> Before this patch, when there's any pgtable allocation issues =
happened
>>> during change_protection(), the error will be ignored from the =
syscall.
>>> For shmem, there will be an error dumped into the host dmesg.  Two =
issues
>>> with that:
>>>=20
>>>  (1) Doing a trace dump when allocation fails is not anything close =
to
>>>      grace..
>>>=20
>>>  (2) The user should be notified with any kind of such error, so the =
user
>>>      can trap it and decide what to do next, either by retrying, or =
stop
>>>      the process properly, or anything else.
>>>=20
>>> For userfault users, this will change the API of UFFDIO_WRITEPROTECT =
when
>>> pgtable allocation failure happened.  It should not normally break =
anyone,
>>> though.  If it breaks, then in good ways.
>>>=20
>>> One man-page update will be on the way to introduce the new -ENOMEM =
for
>>> UFFDIO_WRITEPROTECT.  Not marking stable so we keep the old behavior =
on the
>>> 5.19-till-now kernels.
>> I understand that the current assumption is that change_protection() =
should
>> fully succeed or fail, and I guess this is the current behavior.
>> However, to be more =E2=80=9Cfuture-proof=E2=80=9D perhaps this needs =
to be revisited.
>> For instance, UFFDIO_WRITEPROTECT can benefit from the ability to =
(based on
>> userspace request) prevent write-protection of pages that are pinned. =
This is
>> necessary to allow userspace uffd monitor to avoid write-protection =
of
>> O_DIRECT=E2=80=99d memory, for instance, that might change even if a =
uffd monitor
>> considers it write-protected.
>=20
> Just a note that this is pretty tricky IMHO, because:
>=20
> a) We cannot distinguished "pinned readable" from "pinned writable"
> b) We can have false positives ("pinned") even for compound pages due =
to
>   concurrent GUP-fast.
> c) Synchronizing against GUP-fast is pretty tricky ... as we learned.
>   Concurrent pinning is usually problematic.
> d) O_DIRECT still uses FOLL_GET and we cannot identify that. (at least
>   that should be figured out at one point)

My prototype used the page-count IIRC, so it had false-positives (but
addressed O_DIRECT). And yes, precise refinement is complicated. =
However,
if you need to uffd-wp memory, then without such a mechanism you need to
ensure no kerenl/DMA write to these pages is possible. The only other
option I can think of is interposing/seccomp on a variety of syscalls,
to prevent uffd-wp of such memory.

>=20
> I have a patch lying around for a very long time that removes that =
special-pinned handling from softdirty code, because of the above =
reasons (and because it forgets THP). For now I didn't send it because =
for softdirty, it's acceptable to over-indicate and it hasn't been =
reported to be an actual problem so far.
>=20
> For existing UFFDIO_WRITEPROTECT users, however, it might be very =
harmful (especially for existing users) to get false protection errors. =
Failing due to ENOMEM is different to failing due to some temporary =
concurrency issues.

Yes, I propose it as an optional flag for UFFD-WP. Anyhow, I believe
the UFFD-WP as implemented now is not efficient and should=E2=80=99ve =
been
vectored to allow one TLB shootdown for many non-consecutive pages.=20

>=20
> Having that said, I started thinking about alternative ways of =
detecting that in that past, without much outcome so far: that latest =
idea was indicating "this MM has had pinned pages at one point, be =
careful because any techniques that use write-protection (softdirty, =
mprotect, uffd-wp) won't be able to catch writes via pinned pages =
reliably".

I am not sure what the best way to detect that a page is write-pinned
reliably. My point was that if a change is already carried to
write-protect mechanisms, then this issue should be considered. Because
otherwise, many use-cases of uffd-wp would encounter implementation
issues.

I will not =E2=80=9Ckill=E2=80=9D myself over it now, but I think it =
worth consideration.

