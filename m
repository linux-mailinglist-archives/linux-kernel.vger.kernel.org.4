Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED1E69B0A8
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 17:21:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbjBQQUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 11:20:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbjBQQUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 11:20:19 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11AF8714BC
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 08:18:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676650737;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KGNvKVanzVRQGRVqRAA4tIqC9UQ9qVAYLdRdmeyMsg4=;
        b=NDPTax4BnwABJYPFxBucS2rz9XX88mPrDEqNHuoyfmIL4d5v5Dz2uF6GSsY8s42IKhlQUH
        xEpIBETEBggFeQMwUUF6JpSxfkmoGcZyM/tXRj6x6RwQFXq/xFUaxjzKFYV9a43AZHotu+
        bVawq2duhBnXzKLuaew+WM1rjOmcqTw=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-226-UrmJzHTOMvCMWMWkQTraOw-1; Fri, 17 Feb 2023 11:18:55 -0500
X-MC-Unique: UrmJzHTOMvCMWMWkQTraOw-1
Received: by mail-pf1-f200.google.com with SMTP id b2-20020a056a0002c200b005abc02c891cso212458pft.23
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 08:18:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KGNvKVanzVRQGRVqRAA4tIqC9UQ9qVAYLdRdmeyMsg4=;
        b=JFE95pu/mhRdXKJ2A4Hn7haWQNB48PZNKZ3vjgaY7FVYHFzRWAL7MbcxPrSBr58dum
         2vfhNWeo0vtRCM8qzhMXR1gdBDyIGY5qjzD+In7iGmlQasYWgU/SYCEHcCZ34xvD4pBX
         V3mnN8pk4UqHrHvPSSF+V2vkwksv59xeSq0UnkTSjdrHi8qxlW+khHV5qOFS9kEvjqV+
         um+zAMYAupoj4KuHnu7uxWhtXXWoIivTr7jeMe7CeYmiWAKHvIWGLD8n5jAytZQLcGLD
         tilk3+AEOqshinXFp7mRo0GoXxnYbeLqKT8e9Bcu9M6+XmFGFXLKoTgKmDESflW/W77o
         /QRA==
X-Gm-Message-State: AO0yUKUkPNf3bUG83STCncP9LKFY+era1raKyA8Lb6JrLYRAJpTPCies
        wR13iP1jk3IBsVAHZc1h0suAguxojDpvsuNyvMJchdGY2SaE8+o2otySYRf7HmuplYLvuEqSJA3
        m9i+8jL8v8ms8C1IsZkwatFYO53LNljXSDqlBwcSv
X-Received: by 2002:a17:90b:2d86:b0:231:20d9:2f7 with SMTP id sj6-20020a17090b2d8600b0023120d902f7mr1657346pjb.109.1676650734843;
        Fri, 17 Feb 2023 08:18:54 -0800 (PST)
X-Google-Smtp-Source: AK7set+B3fHtimDstl0RYgS+DqQZw/5C8OZXA2WsyEyzZMlNWcURkViXO7TbtDrHrdXbaDO75OBivKna0S8j+MhiBkY=
X-Received: by 2002:a17:90b:2d86:b0:231:20d9:2f7 with SMTP id
 sj6-20020a17090b2d8600b0023120d902f7mr1657338pjb.109.1676650734617; Fri, 17
 Feb 2023 08:18:54 -0800 (PST)
MIME-Version: 1.0
References: <20230215131807.293556-1-omosnace@redhat.com> <20230215124747.6f8df3c4675517eacf1e9a39@linux-foundation.org>
 <87a61d7fvq.fsf@email.froward.int.ebiederm.org>
In-Reply-To: <87a61d7fvq.fsf@email.froward.int.ebiederm.org>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 17 Feb 2023 17:18:42 +0100
Message-ID: <CAFqZXNuescrj3bY8FnK71f4JSXvnptvVoQhqH1eBrJ=PTYoAMQ@mail.gmail.com>
Subject: Re: [PATCH] kernel/sys.c: fix and improve control flow in __sys_setres[ug]id()
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2023 at 5:11 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Andrew Morton <akpm@linux-foundation.org> writes:
>
> > On Wed, 15 Feb 2023 14:18:07 +0100 Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> >> 1. First determine if CAP_SET[UG]ID is required and only then call
> >>    ns_capable_setid(), to avoid bogus LSM (SELinux) denials.
> >
> > Can we please have more details on the selinux failures?  Under what
> > circumstances?  What is the end-user impact?
>
> It is puzzling the structure with having the capability check first
> dates to 2.1.104 (when a hand coded test for root was replaced
> with capable(CAP_SETID).  Which means the basic structure and logic
> of the code is even older than that.

I don't find it that puzzling - either the code structure predates the
moment LSMs were plugged into capable() (and no one did an audit of
existing callers at that time) or it was written without awareness
that capable() may have side effects (which is not surprising, since
it is not documented properly).

--
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

