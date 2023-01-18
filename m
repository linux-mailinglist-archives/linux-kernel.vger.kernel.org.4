Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 355B8672AE4
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 22:52:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbjARVwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 16:52:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231288AbjARVvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 16:51:47 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB64763080
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 13:51:43 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id 78so25575623pgb.8
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 13:51:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M600VK+Yiu4nd7HJ/UqqIXTrBc2sxX4QZyVOHBhaXRA=;
        b=Y4+8hZ5DDjqkJ26aK8BCB6UiclO4FhYJK0GsPfWQNSgnYcootRhOLV4O9sMJiUEHrN
         uwsYzDzzx15pgNj/O40ddXSq3mGJtofOCvlhzJRlu11tRQATHY6bcpcAQAlvUYoDqJLl
         Z48II8dKreJuvqbKESyfX9FjS4D79tO3vJUsLAsVDq0Jx9c17SSh6TkDxcfsONB10xee
         1eddHcDZf7qNpGhw/BllSNCEgGWjvuk2FSrtSvK/hXYEq3uBr3LcSDj2L68IGnOqSANS
         8WNO5u7sbErtrdfIWYhYZvV0cCVReXtz5X3HjhTj3JqtyzLRB50cLvNmVZ5qdeucK2nr
         DDhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M600VK+Yiu4nd7HJ/UqqIXTrBc2sxX4QZyVOHBhaXRA=;
        b=MxC4/lX6fI1aO0GaEFlH1so9P7GhtWrVE0SncSX/wkhVr5xHOebfIUJmqqcnXxwox4
         fSCyfYnhpuhT3vO4YyD94tT3yPI8+GHSwfK2oHxn6gcxQZi8J5DHL9MqEn1cODUI9biV
         Nnq70YC5AUSIRyaN4tdGgPnnS/e99uwGAiIza1f2vV+iZzLYF+czXNnPGqO1zqJyf4Ya
         dDlzNMF9vKOzx7c2RRnl5Ru6S72l9GmhHxens20ZyIjPKVpvwOeI/cqZrtkq3odh6ZbU
         5KPF3M5/k9RpdLHE85ZL+voXBwawzrMSh3bOR6ani4E8mVea37KhJcXIebloTfu3ue20
         FPQg==
X-Gm-Message-State: AFqh2krAhUkQ557R9ORkkHRek5+/NYZLL9EJvpdbXA8yo9gWGUxNErfe
        L86YsHcO9PCcZ/2B9OETlwY=
X-Google-Smtp-Source: AMrXdXtZtk1QSyhruZKqaJz90IJfqlYlEdJZxWLifUCgAhuKCTjfn9ah58L05E3hgtB3qonYXL3qTw==
X-Received: by 2002:a62:1556:0:b0:58b:c9db:c015 with SMTP id 83-20020a621556000000b0058bc9dbc015mr9937270pfv.30.1674078703262;
        Wed, 18 Jan 2023 13:51:43 -0800 (PST)
Received: from smtpclient.apple (c-24-6-216-183.hsd1.ca.comcast.net. [24.6.216.183])
        by smtp.gmail.com with ESMTPSA id w65-20020a623044000000b0056c349f5c70sm22529550pfw.79.2023.01.18.13.51.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jan 2023 13:51:42 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.300.101.1.3\))
Subject: Re: [PATCH 3/3] mm/uffd: Detect pgtable allocation failures
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <Y7cqMeTGSjsOPQ09@x1n>
Date:   Wed, 18 Jan 2023 13:51:30 -0800
Cc:     David Hildenbrand <david@redhat.com>,
        Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        James Houghton <jthoughton@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <832F027A-3778-4670-BED6-1222FA905F13@gmail.com>
References: <20230104225207.1066932-1-peterx@redhat.com>
 <20230104225207.1066932-4-peterx@redhat.com>
 <AF984D5D-DC66-4FD3-A749-5AF6B7289E0D@gmail.com>
 <cc6e17ad-1afd-5c52-a06e-1d89d1978368@redhat.com>
 <B38AB79D-51D7-4F1A-A5CB-A60A46A3E27F@gmail.com> <Y7cqMeTGSjsOPQ09@x1n>
To:     Peter Xu <peterx@redhat.com>
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

Sorry for the late response.

>> Yes, I propose it as an optional flag for UFFD-WP.
>> Anyhow, I believe the UFFD-WP as implemented now is not efficient and
>> should=E2=80=99ve been vectored to allow one TLB shootdown for many
>> non-consecutive pages.
>=20
> Agreed.  Would providing a vector of ranges help too for a few uffd =
ioctls?
>=20
> I'm also curious whether you're still actively developing (or running) =
your
> iouring series.

So I finished building a prototype some time ago, and one of the =
benefits
was in reducing memory reclamation time. Unfortunately, MGLRU then came =
and
took away a lot of the benefit.

A colleague of mine had a slightly different use-case, so I gave him the
code and he showed interest in upstreaming it. After some probing, it =
turns
out he decided he is not into the effort of upstreaming it. I can =
upstream
the vectored WP once I write some tests.
>>=20
>> I am not sure what the best way to detect that a page is write-pinned
>> reliably. My point was that if a change is already carried to
>> write-protect mechanisms, then this issue should be considered. =
Because
>> otherwise, many use-cases of uffd-wp would encounter implementation
>> issues.
>>=20
>> I will not =E2=80=9Ckill=E2=80=9D myself over it now, but I think it =
worth consideration.
>=20
> The current interface change is small and limited only to the extra =
-ENOMEM
> retval with memory pressures (personally I don't really know how to =
trigger
> this, as I never succeeded myself even with memory pressure..).  What =
you
> said does sound like a new area to explore, and I think it's fine to =
change
> the interface again.

Understood.

Thanks and sorry again for the late response,
Nadav=
