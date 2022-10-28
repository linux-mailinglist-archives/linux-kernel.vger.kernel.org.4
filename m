Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F27E26115EC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 17:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbiJ1Pdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 11:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiJ1Pd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 11:33:29 -0400
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD7771D8191;
        Fri, 28 Oct 2022 08:33:28 -0700 (PDT)
Received: by mail-qt1-f172.google.com with SMTP id c23so3663856qtw.8;
        Fri, 28 Oct 2022 08:33:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=emG8YeAVqW+/ZAho2B0vb4ajWXxFNk2QbTHbh07XcYA=;
        b=QW9Jq5406mcvkjWW/C8CeUol1FjLXPNbUur5ri8KrsyBj7ffhCmPj3VnpSlMJk3no+
         eXTxX7cnaP2+7Pol4mJwP+Z8d7GCycILyGMOP72Jwqm12ne3zroUDKA3agC+0UYB5nD0
         oYVwhfmBAdJaukg/wqHh43q6Ih+Umf+UB84N2Z89qWhOQ7Btqk8QjcNIWugsjHEBlcKO
         +O3xqujbTzj9GBVitDlaa5G/YOl4hpBifEThgSIKB2gjlbSmLjaIsMLB609s9dOxcoE0
         8L8TxhcFkzFw9aKyhy/vy9v54zufbU7yXYDkJfppK+fXoeq8eTJPHV0VwjeXvhKnCGht
         nfvw==
X-Gm-Message-State: ACrzQf31CPCly+yb9S7xO+Ab72NGBH1N+bqM72z3AkiagXrRbWyMpwxB
        V81kKJxNh7SX0oSaeVr+gdlPNzsQo00wE4zAWzomPq0a
X-Google-Smtp-Source: AMsMyM58kxrSw/gRfhRSshGIQwBcIu3sakSET0mmEpMVXoYnCGNIZ5LillaWVZQdXDOf5Wk0yRWdlRW4CiO4L0ctHgg=
X-Received: by 2002:a05:622a:44d:b0:39c:f7a4:5ee0 with SMTP id
 o13-20020a05622a044d00b0039cf7a45ee0mr58309qtx.48.1666971208003; Fri, 28 Oct
 2022 08:33:28 -0700 (PDT)
MIME-Version: 1.0
References: <20221014121136.8677-1-mario.limonciello@amd.com> <1f80828d-4c8c-f98f-24e9-68f5c886dd40@amd.com>
In-Reply-To: <1f80828d-4c8c-f98f-24e9-68f5c886dd40@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 28 Oct 2022 17:33:17 +0200
Message-ID: <CAJZ5v0j6CunHQrSNQ24L-+jny9BFjBT=2VbJbihEV85AJYMUzQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI: x86: Add another system to quirk list for forcing StorageD3Enable
To:     "Limonciello, Mario" <mario.limonciello@amd.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Dell.Client.Kernel@dell.com,
        Julius Brockmann <mail@juliusbrockmann.com>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 2:13 AM Limonciello, Mario
<mario.limonciello@amd.com> wrote:
>
> On 10/14/2022 07:11, Mario Limonciello wrote:
> > commit 018d6711c26e4 ("ACPI: x86: Add a quirk for Dell Inspiron 14 2-in-1
> > for StorageD3Enable") introduced a quirk to allow a system with ambiguous
> > use of _ADR 0 to force StorageD3Enable.
> >
> > Julius Brockmann reports that Inspiron 16 5625 suffers that same symptoms.
> > Add this other system to the list as well.
> >
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=216440
> > Reported-and-tested-by: Julius Brockmann <mail@juliusbrockmann.com>
> > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > ---
> >   drivers/acpi/x86/utils.c | 6 ++++++
> >   1 file changed, 6 insertions(+)
> >
>
> Hi Rafael,
>
> This got sent near the merge window a few weeks ago.  It's a trivial fix
> so I just want to make sure it didn't get misplaced.

I had a plan to push it for -rc3, but then I didn't include it in the PR.

I'll queue it up for -rc4 now.

Thanks!
