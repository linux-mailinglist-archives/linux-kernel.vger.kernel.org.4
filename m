Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2090567D36D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 18:42:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232054AbjAZRmm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 12:42:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231905AbjAZRml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 12:42:41 -0500
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 380E16F238;
        Thu, 26 Jan 2023 09:42:40 -0800 (PST)
Received: by mail-ej1-f51.google.com with SMTP id kt14so7162930ejc.3;
        Thu, 26 Jan 2023 09:42:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P6V7ncPnxJBEuBCN7F/c3tMBlXX2E3XQnP/lz++oPxI=;
        b=52KVzZ5fbxoEqolVvDhP06X59XEt2eM6D3CctCoS4iy7XTOpHDobTQ/JwUDvRHGVXH
         J16BY5WthPA+fq6zvvA+mRZ8zqGzC06EZ7bffqviBOTvFO9zkZpOwRhXNt5hTGyG4yQr
         hLs+xvpH1HnoqaQ/LR7PaKWLwzn3LoyIwEYjVclJfC/c8G9E+NlKXGVKRyZNhoDhnTIl
         T0QhJg82yJ11womEl8zi3mERlhQ3qthsqvtA2KdGUBXQKTS4Hvi9saesdwTXUtHFtauc
         7nJfw9xrgz8o+4avSWOM+2PclNwbIT3we6Gqon4r9rTrESVh7B7qwBN2vmtMziSfdiyE
         Aztg==
X-Gm-Message-State: AFqh2krmZXh6d7ed3lgUnO+x0KQhN8uLUVj26C2KxAiisucpL9EyRZiB
        sy+VyWxJN9SPWETt8cu90Wsq7sgDJUXhHLFzjvU=
X-Google-Smtp-Source: AMrXdXtCWpxohPqZO/BhPp5vN+gQA3+ofCgeCWKQyPQRAOjmOW4+BOwjE0j7g51+N3tfJrb20ZvSeP8uOLg8Qw5DQpk=
X-Received: by 2002:a17:906:f6cb:b0:870:fef9:9001 with SMTP id
 jo11-20020a170906f6cb00b00870fef99001mr6319463ejb.25.1674754958785; Thu, 26
 Jan 2023 09:42:38 -0800 (PST)
MIME-Version: 1.0
References: <5665899.DvuYhMxLoT@kreacher> <CAJZ5v0iVqGoVq1TVvYoQLxRWnP1nTPe7seeQvbVPancxH_6J1g@mail.gmail.com>
 <10ad845597c47b8b7d1ba1aa9fe93825d249f56e.camel@linux.intel.com>
 <5926007.lOV4Wx5bFT@kreacher> <3c45463d2dc546b4198272107738cc073b3d23c0.camel@linux.intel.com>
In-Reply-To: <3c45463d2dc546b4198272107738cc073b3d23c0.camel@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 26 Jan 2023 18:42:27 +0100
Message-ID: <CAJZ5v0gNZJcomUv5-xw8oswHn0j7DNXmneuempQuhCrHsWHeRA@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] thermal: intel: int340x: Use generic trip points table
To:     srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Srinivas,

On Thu, Jan 26, 2023 at 6:17 PM srinivas pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> Hi Rafael,
>
> On Thu, 2023-01-26 at 14:13 +0100, Rafael J. Wysocki wrote:
> > On Thursday, January 26, 2023 1:02:59 AM CET srinivas pandruvada
> > wrote:
> > > Hi Rafael,
> > >
> > >
> >
>
> [...]
>
> > I've added the appended patch to the thermal-intel-test branch.  Can
> > you please
> > check if it makes that difference in behavior go away?
> I synced the tree again and your patch in thermal-intel-test fixes the
> issue.

Thanks a lot for testing and the confirmation!

In the meantime, I've merged the thermal-intel-test into the
bleeding-edge branch and if 0-day reports success with building it,
I'll move the patches to linux-next.

Cheers!
