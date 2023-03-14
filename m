Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12EC66B8E70
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 10:19:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbjCNJTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 05:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjCNJTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 05:19:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF299AA25
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 02:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678785435;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fgK8jeijDMxB85rbRrmU9CTvwNcdx5i+gm9+kTFqBrw=;
        b=XROAhrJBCxzjggjXr5w1N3knQRBdr2WwJSS68LPdCcokhbjTz4HP6YqtW5o9pZ2nbgIilU
        Dj5svgG9knFCNbV1RRBteYuP3fg6L9hQP3MtWMGsYhnIabMM3tKifE447lok7QlOvWcrGh
        LtQT5AvqyDnoD+RmDEzM9+XvpNxTifg=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-332-6sT0LtStOFOnHVzi7rA-BA-1; Tue, 14 Mar 2023 05:17:12 -0400
X-MC-Unique: 6sT0LtStOFOnHVzi7rA-BA-1
Received: by mail-pf1-f199.google.com with SMTP id i15-20020aa78d8f000000b005edc307b103so8087160pfr.17
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 02:17:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678785430;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fgK8jeijDMxB85rbRrmU9CTvwNcdx5i+gm9+kTFqBrw=;
        b=lk7bfkXAtNW1mvSter4FStwOn5B72gRczNbw73wvnDNPJzX67+BG3TFL6i/9qXb+G+
         If02DpQG93HZZu/rHKU+CvKg1h9738J04pbEUFQrO6FUJXwXyJHUJ1ZfM1EgGA51M4ZU
         /bXc0PAawG26UDvyg0gb/s72OOYU6hM+I2lm2eARvgdF6L47vb5oj6L0LdcAMhB/dTn9
         kpsOhrhTOSWa9+W/CDW7iixoHmFqt1qvEa300jI6nEFJhbqFxz00yVCCSn2+hkEh2h24
         w6JDaHYKG/4nmqFlqazZv1rgxpIPfVVtclqYMCx+Eru+QYpLi6gk6behbnkp/Ut4aJgM
         +FaQ==
X-Gm-Message-State: AO0yUKWuhy1AyXIl5GDOfF/cWuWv1G5IGLaKQ0p+PpInJRfuHCiD39jt
        fKY3079XWU1EyuHSP+34wEizwVLOVh5t7ob+9JxUuNRdbnL54a8aRMSh9s0fl6p4o/qnNdd1kER
        qLpLBtqxNDX4bPMjpw5i9aU/vQ01rKisBU2+e5BC0
X-Received: by 2002:a63:385d:0:b0:50a:c011:19f2 with SMTP id h29-20020a63385d000000b0050ac01119f2mr2325456pgn.1.1678785430549;
        Tue, 14 Mar 2023 02:17:10 -0700 (PDT)
X-Google-Smtp-Source: AK7set+rm4R+bBfbjv6VaIdBvRAITSL4G8Fa2r0a8Pf400YlXM6B8mgRI9o1cuiJpmG4Nm6xXjQpR4zL8UaFvdSdbko=
X-Received: by 2002:a63:385d:0:b0:50a:c011:19f2 with SMTP id
 h29-20020a63385d000000b0050ac01119f2mr2325447pgn.1.1678785430233; Tue, 14 Mar
 2023 02:17:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230217162154.837549-1-omosnace@redhat.com> <20230313112923.340128142a92fe50140974db@linux-foundation.org>
In-Reply-To: <20230313112923.340128142a92fe50140974db@linux-foundation.org>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 14 Mar 2023 10:16:58 +0100
Message-ID: <CAFqZXNveSFuYDF+upR_6F3ipZe56Xok6FPBwDJn-gBw7n6A26A@mail.gmail.com>
Subject: Re: [PATCH v2] kernel/sys.c: fix and improve control flow in __sys_setres[ug]id()
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2023 at 7:29=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Fri, 17 Feb 2023 17:21:54 +0100 Ondrej Mosnacek <omosnace@redhat.com> =
wrote:
>
> > Linux Security Modules (LSMs) that implement the "capable" hook will
> > usually emit an access denial message to the audit log whenever they
> > "block" the current task from using the given capability based on their
> > security policy.
> >
> > The occurrence of a denial is used as an indication that the given task
> > has attempted an operation that requires the given access permission, s=
o
> > the callers of functions that perform LSM permission checks must take
> > care to avoid calling them too early (before it is decided if the
> > permission is actually needed to perform the requested operation).
> >
> > The __sys_setres[ug]id() functions violate this convention by first
> > calling ns_capable_setid() and only then checking if the operation
> > requires the capability or not. It means that any caller that has the
> > capability granted by DAC (task's capability set) but not by MAC (LSMs)
> > will generate a "denied" audit record, even if is doing an operation fo=
r
> > which the capability is not required.
> >
> > Fix this by reordering the checks such that ns_capable_setid() is
> > checked last and -EPERM is returned immediately if it returns false.
> >
> > While there, also do two small optimizations:
> > * move the capability check before prepare_creds() and
> > * bail out early in case of a no-op.
> >
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
>
> Looks and sounds good to me, so I queued it up for some testing.  I'd
> ask that someone more familiar with this code perform review, please.
>
> I assume that you believe that a -stable backport is desirable?  I'll
> add a cc:stable to the patch for now.

Yes, it's a minor bug, but we hit it while testing on Fedora and it's
better for us to have the fix in stable kernels than adding a
workaround elsewhere.

Thanks,

--=20
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

