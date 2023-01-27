Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB4F267ED0D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 19:08:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234367AbjA0SIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 13:08:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232597AbjA0SIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 13:08:52 -0500
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC249193EE;
        Fri, 27 Jan 2023 10:08:51 -0800 (PST)
Received: by mail-ed1-f41.google.com with SMTP id m12so5459895edq.5;
        Fri, 27 Jan 2023 10:08:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=goKDA2J7B1QU2njDX5Y8T5sfNT6QXWU55+6YO1fdFco=;
        b=nvWe6KzkHw5AXbQZZIfiUYhTHYc/4JeCldmSjmYUtpS9MeyAYz5u60lSD78dQORj8R
         /VYpocdIhOzoYXuGb/KeBjeJPmgVLVOTZ8Sy+m+yue111LTLnBZe0Sn0nrp8UxGSksqS
         3lvmzdpHQiWUXQh6slIKEJI5YEuAEqavbLxwRSsQ16SwCT1026OvgYkInsgHMwKdQyo6
         kpSK9I2/Kr8X5qPDdywc5LmUYgSSFeWp649sVENUMFdcXg/KBqIq6ippKu+rsyaKXCgy
         AnQ353bfre+CrZXYElR1DEtnN2zwwhewG86bKiMVAUkT0kGZitTGlvgqhYvOnmjpX0mS
         s5MA==
X-Gm-Message-State: AFqh2krWhN1z8x+eyGfyYFBaxaYRghZibRlUJGA5Q3a4x6PVIQ7cwgpf
        U6tyfAIl8GEkyCUnWjg1xsPNzn/mNsGQuNdSIF4=
X-Google-Smtp-Source: AMrXdXtSjmx3IO/nMTosU6o+RLNNgqeNtZ15DaXFdIUBZVecl7iGPqMLzUupCrS9qDjroXN0jvw0PCYzLAV2s8WuN0A=
X-Received: by 2002:a05:6402:e03:b0:490:47c3:3d71 with SMTP id
 h3-20020a0564020e0300b0049047c33d71mr6416494edh.31.1674842930450; Fri, 27 Jan
 2023 10:08:50 -0800 (PST)
MIME-Version: 1.0
References: <20221118181538.never.225-kees@kernel.org> <202301151037.20CC3F0@keescook>
 <CAJZ5v0hvoAD1WLXzpMobTRSasBqy5dypHTysBU3=ionGgWR6nQ@mail.gmail.com> <202301201116.6ED85A70@keescook>
In-Reply-To: <202301201116.6ED85A70@keescook>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 27 Jan 2023 19:08:39 +0100
Message-ID: <CAJZ5v0hQypNonoqr1V1xqN5bX+pKBF3AR=F-mRynN5yvcS9kyA@mail.gmail.com>
Subject: Re: [PATCH] ACPICA: Replace fake flexible arrays with flexible array members
To:     Kees Cook <keescook@chromium.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        acpica-devel@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2023 at 8:16 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Fri, Jan 20, 2023 at 07:10:52PM +0100, Rafael J. Wysocki wrote:
> > On Sun, Jan 15, 2023 at 7:38 PM Kees Cook <keescook@chromium.org> wrote:
> > >
> > > On Fri, Nov 18, 2022 at 10:15:51AM -0800, Kees Cook wrote:
> > > > Functionally identical to ACPICA upstream pull request 813:
> > > > https://github.com/acpica/acpica/pull/813
> > >
> > > Any update on this? Upstream is currently unbuildable since October.
> > >
> > > > One-element arrays (and multi-element arrays being treated as
> > > > dynamically sized) are deprecated[1] and are being replaced with
> > > > flexible array members in support of the ongoing efforts to tighten the
> > > > FORTIFY_SOURCE routines on memcpy(), correctly instrument array indexing
> > > > with UBSAN_BOUNDS, and to globally enable -fstrict-flex-arrays=3.
> > > >
> > > > Replace one-element array with flexible-array member in struct
> > > > acpi_resource_extended_irq. Replace 4-byte fixed-size array with 4-byte
> > > > padding in a union with a flexible-array member in struct
> > > > acpi_pci_routing_table.
> > > >
> > > > This results in no differences in binary output.
> > >
> > > In the meantime, can you take this patch for Linux, and we can wait for
> > > ACPICA to catch up?
> >
> > Applied now (as 6.3 material), sorry for the delay.
>
> Thanks!

Unfortunately, this breaks compilation for the ACPI tools in tools/power/acpi/.

Apparently, the problem is that DECLARE_FLEX_ARRAY() is not defined
when the tools are built, because kernel headers are not used then.

I guess the changes from your upstream PR need to be backported
literally for this to work, so I'll drop this one for the time being.
Or please let me know if you have a better idea.
