Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD30C6B78A8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 14:16:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbjCMNQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 09:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjCMNQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 09:16:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B923A29434
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 06:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678713368;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FKyM6Ht9zjiLJ40pzCKLDw3GXf9qFWWMut5Ela7p7gs=;
        b=aBHRtnuD9yGM8dkpXNfq2aIyHDxm/f0Pga1D3FfqQrAXA1jCQvsurKO8msooqpe9sp2yrr
        aGmtcHVkWZMDOVHOAsdohDaz8azNLKEb67r5K6iSOAth4CKWzlLm5B5eUa9OGf3ZV5QOtC
        UYPoYSVgC3H0qyP0FC69fi7fKvmQk3k=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-271-6Di6P3j7NYaDOfZi-CXTtg-1; Mon, 13 Mar 2023 09:16:06 -0400
X-MC-Unique: 6Di6P3j7NYaDOfZi-CXTtg-1
Received: by mail-pg1-f198.google.com with SMTP id s21-20020a632155000000b004fc1f5c8a4dso2632774pgm.11
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 06:16:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678713365;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FKyM6Ht9zjiLJ40pzCKLDw3GXf9qFWWMut5Ela7p7gs=;
        b=IDYnFq7yVkoe9Z9pjRyL7otgom3PRgyhwPudMzrHYtPAm78mpSGn9GPiyYPq/Mqiov
         OgcpOGEocUmPj2QEQxlPCdNME0JMG9wZBj1BBNQZ/J4eImXDmXGHpB/G0IbCzQYtLuFj
         2CDMfypWHvv4uwvyp8TUFmc/Rd0OXZkmNOOPtczKk+0RaNqeY6QZzQK8K8e4u07DzUOw
         oSqbq7SpX2cUWEaGpOlHV2dspA8VWFzdhSSosJ/1Bg6fzaMxfPXRsEsvdZfpejEyRpGf
         C4opzOgtYie7gobHaEo9bFje5MZi+xBih56IFj/XYr4fFgGa60OjD141nFOo8tjSmRr1
         flmw==
X-Gm-Message-State: AO0yUKXZQZWzOFOAmSFWSKlRv3weTxAxNx1uXELgcyIMk/Q29Fbwsx4E
        beNg7eDM23n6wvuJZQeOyzp0WUb6svsDAmJURCoXihq5Sx3z47kGZsene29EnhWk2dw8kbOoigb
        ebO4rfVF/XI+KTtq1uK0AKfzGL0H1m5f6AcX1PQKc+fMA/TfATyY=
X-Received: by 2002:a17:90a:985:b0:23d:27cd:f1dd with SMTP id 5-20020a17090a098500b0023d27cdf1ddmr241962pjo.9.1678713364979;
        Mon, 13 Mar 2023 06:16:04 -0700 (PDT)
X-Google-Smtp-Source: AK7set+SLBCllaY6lNZjLf2eCbIw673Z3tIbWDKAnR8hTQYgqNIrmqcuHi0dKPnJ+lnGCE2DZKJ+sn1hEuJzJdTDuDE=
X-Received: by 2002:a17:90a:985:b0:23d:27cd:f1dd with SMTP id
 5-20020a17090a098500b0023d27cdf1ddmr241952pjo.9.1678713364657; Mon, 13 Mar
 2023 06:16:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230217162154.837549-1-omosnace@redhat.com>
In-Reply-To: <20230217162154.837549-1-omosnace@redhat.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 13 Mar 2023 14:15:53 +0100
Message-ID: <CAFqZXNtjh5WqY-ShdbJr_0=wVhQs=X+-8C00_UzooP666SNnHg@mail.gmail.com>
Subject: Re: [PATCH v2] kernel/sys.c: fix and improve control flow in __sys_setres[ug]id()
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
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

On Fri, Feb 17, 2023 at 5:21=E2=80=AFPM Ondrej Mosnacek <omosnace@redhat.co=
m> wrote:
>
> Linux Security Modules (LSMs) that implement the "capable" hook will
> usually emit an access denial message to the audit log whenever they
> "block" the current task from using the given capability based on their
> security policy.
>
> The occurrence of a denial is used as an indication that the given task
> has attempted an operation that requires the given access permission, so
> the callers of functions that perform LSM permission checks must take
> care to avoid calling them too early (before it is decided if the
> permission is actually needed to perform the requested operation).
>
> The __sys_setres[ug]id() functions violate this convention by first
> calling ns_capable_setid() and only then checking if the operation
> requires the capability or not. It means that any caller that has the
> capability granted by DAC (task's capability set) but not by MAC (LSMs)
> will generate a "denied" audit record, even if is doing an operation for
> which the capability is not required.
>
> Fix this by reordering the checks such that ns_capable_setid() is
> checked last and -EPERM is returned immediately if it returns false.
>
> While there, also do two small optimizations:
> * move the capability check before prepare_creds() and
> * bail out early in case of a no-op.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>
> v2: improve commit message
>
>  kernel/sys.c | 69 ++++++++++++++++++++++++++++++----------------------
>  1 file changed, 40 insertions(+), 29 deletions(-)

Ping?

--=20
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

