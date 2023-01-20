Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01F7B675C78
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 19:11:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbjATSLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 13:11:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjATSLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 13:11:05 -0500
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0A957B2DF;
        Fri, 20 Jan 2023 10:11:04 -0800 (PST)
Received: by mail-ed1-f43.google.com with SMTP id x10so7706044edd.10;
        Fri, 20 Jan 2023 10:11:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5t9C2zVNrqE3Ky7/satHgNnh/Bdqj/w8iXbeyqpGIXo=;
        b=IegcUXzbTQW5KRKrykx/Y5drHcLtIkTUvY+Eg8g1KWIlPT4beVJU8QKkRQgfahijgs
         j3OcDjiZ9OOz2KXTDI+KekRlGtK8svp+lazJFLqtWfsHJBGHNEuutgU56xBHVCe7j+ol
         zWl+ANEKLHQWRHvIHAs9IqfwMC+lygQ2mTPvlVtikXcv6ZvNnNxu3xX7EMphQc/N73m2
         82wDX/rP0Opn6BCWXFzhqeZN62yH1o+KVSUIjO4H2hqXnc+LudK/RA1WO52HudbcaCyn
         MxR09Y+6RS4W+41gCOHAvLr7xYH/fq6PeFUTun7YG9uaZoNLCk5jiypBYSHRU2ax2Fv7
         zy3w==
X-Gm-Message-State: AFqh2kpM35edOs4vHkOmwCAwDnVYqutfOjoOdMmM2UPZ7I5fEI4kLezW
        +Ss7oYSKr+6a5CiOsXmoUxsUC0flaMpnFjLPUBU=
X-Google-Smtp-Source: AMrXdXsWe7JvMho9i9DVptno02FIGXKQMDST+FTnEgxoDexs6Xr1ZIRoEeUF1oCHMo3NcEREY8GYnm9Pv5NamONUt2A=
X-Received: by 2002:a05:6402:1c1d:b0:48c:93ce:2b15 with SMTP id
 ck29-20020a0564021c1d00b0048c93ce2b15mr1624666edb.110.1674238263321; Fri, 20
 Jan 2023 10:11:03 -0800 (PST)
MIME-Version: 1.0
References: <20221118181538.never.225-kees@kernel.org> <202301151037.20CC3F0@keescook>
In-Reply-To: <202301151037.20CC3F0@keescook>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 20 Jan 2023 19:10:52 +0100
Message-ID: <CAJZ5v0hvoAD1WLXzpMobTRSasBqy5dypHTysBU3=ionGgWR6nQ@mail.gmail.com>
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
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 15, 2023 at 7:38 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Fri, Nov 18, 2022 at 10:15:51AM -0800, Kees Cook wrote:
> > Functionally identical to ACPICA upstream pull request 813:
> > https://github.com/acpica/acpica/pull/813
>
> Any update on this? Upstream is currently unbuildable since October.
>
> > One-element arrays (and multi-element arrays being treated as
> > dynamically sized) are deprecated[1] and are being replaced with
> > flexible array members in support of the ongoing efforts to tighten the
> > FORTIFY_SOURCE routines on memcpy(), correctly instrument array indexing
> > with UBSAN_BOUNDS, and to globally enable -fstrict-flex-arrays=3.
> >
> > Replace one-element array with flexible-array member in struct
> > acpi_resource_extended_irq. Replace 4-byte fixed-size array with 4-byte
> > padding in a union with a flexible-array member in struct
> > acpi_pci_routing_table.
> >
> > This results in no differences in binary output.
>
> In the meantime, can you take this patch for Linux, and we can wait for
> ACPICA to catch up?

Applied now (as 6.3 material), sorry for the delay.

Thanks!

> >
> > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > Cc: Len Brown <lenb@kernel.org>
> > Cc: Robert Moore <robert.moore@intel.com>
> > Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> > Cc: linux-acpi@vger.kernel.org
> > Cc: devel@acpica.org
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  include/acpi/acrestyp.h | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/acpi/acrestyp.h b/include/acpi/acrestyp.h
> > index a7fb8ddb3dc6..ee945084d46e 100644
> > --- a/include/acpi/acrestyp.h
> > +++ b/include/acpi/acrestyp.h
> > @@ -332,7 +332,7 @@ struct acpi_resource_extended_irq {
> >       u8 wake_capable;
> >       u8 interrupt_count;
> >       struct acpi_resource_source resource_source;
> > -     u32 interrupts[1];
> > +     u32 interrupts[];
> >  };
> >
> >  struct acpi_resource_generic_register {
> > @@ -679,7 +679,10 @@ struct acpi_pci_routing_table {
> >       u32 pin;
> >       u64 address;            /* here for 64-bit alignment */
> >       u32 source_index;
> > -     char source[4];         /* pad to 64 bits so sizeof() works in all cases */
> > +     union {
> > +             char pad[4];    /* pad to 64 bits so sizeof() works in all cases */
> > +             DECLARE_FLEX_ARRAY(char, source);
> > +     };
> >  };
> >
> >  #endif                               /* __ACRESTYP_H__ */
> > --
> > 2.34.1
> >
>
> --
> Kees Cook
