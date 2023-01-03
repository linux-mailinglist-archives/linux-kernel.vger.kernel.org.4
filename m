Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4B2E65C576
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 18:55:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238154AbjACRzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 12:55:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230441AbjACRzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 12:55:19 -0500
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B247BD2F8;
        Tue,  3 Jan 2023 09:55:18 -0800 (PST)
Received: by mail-ed1-f42.google.com with SMTP id l29so37888930edj.7;
        Tue, 03 Jan 2023 09:55:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RUpuSMDfOPVMA7Lhol2TGCGqnvjImReIZMnb3tupDO0=;
        b=132kTcoPagbLBvF+ycyV++P3VRH2s7TRCrQUwgA1TOtTusGpR8gaCg1BVvaOWVYtoW
         kvE6C5XTKgNQD3jV+Nh6dj5mGJs9uOPXbOv5bSqy0+a4lWY6N28IbSmmqPNcYS01Mrk4
         sRiAc87ftBgdhqQeME9Pm3i7xsA3ObAsvtCvgHF8V9OLjiyxYcLlJpBxlGkDB8GefFig
         fFBrK/N+/Bm2K+TiinHkucdFnKw+R4man1EmLH1NzVW+/g9qlTSfGfzosc4EUEbCKPo7
         DIjTIssW6rvrSz7A7Uh+yKXLpC7vNmDSxPxVzWPp3ad8EFHBzuF+T/NdXFC9M9IKcz0H
         lWFw==
X-Gm-Message-State: AFqh2kr9Z2X9v6SGfmQ3fYsZKROPB7YK6Pfk6ROdh9ZbUJN3opB8vtNp
        P2YaLpBxaab5dnDFJVPR4xerD3iL9VZGxV7dOtaTWdab
X-Google-Smtp-Source: AMrXdXuFEL2ZEbkBLv778V3DmoFPb+DI+v37vVO4pDA8Oi4xBWOX2M+nFyckvvm4rOhlyhU2rwyVLbRy8TFL/tNEwVY=
X-Received: by 2002:a50:eb49:0:b0:46d:731c:2baf with SMTP id
 z9-20020a50eb49000000b0046d731c2bafmr4325586edp.280.1672768517389; Tue, 03
 Jan 2023 09:55:17 -0800 (PST)
MIME-Version: 1.0
References: <20221205002804.21225-1-rick.p.edgecombe@intel.com>
 <CAJZ5v0iZ8QdCMca1F+z2NJ8+a-jUkGMSNp2KRovCB-aMjHF7qg@mail.gmail.com> <c4c95945df72fda7b7d6f333a4aea7e19d7e684c.camel@intel.com>
In-Reply-To: <c4c95945df72fda7b7d6f333a4aea7e19d7e684c.camel@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 3 Jan 2023 18:55:06 +0100
Message-ID: <CAJZ5v0j6qd930BKWWf-e+_Vod0Wv16LZChCOa0yf0_uLC=UMyw@mail.gmail.com>
Subject: Re: [PATCH] x86/hibernate: Use fixmap for saving unmapped pages
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "rafael@kernel.org" <rafael@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "x86@kernel.org" <x86@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "bp@alien8.de" <bp@alien8.de>, "Brown, Len" <len.brown@intel.com>
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

On Tue, Jan 3, 2023 at 6:23 PM Edgecombe, Rick P
<rick.p.edgecombe@intel.com> wrote:
>
> On Mon, 2022-12-05 at 13:46 +0100, Rafael J. Wysocki wrote:
> > >
> > > Hi,
> > >
> > > Since none of the module space allocation overhauls ever seem to go
> > > smoothly
> > > and it may be awhile before VM_FLUSH_RESET_PERMS in not needed, I
> > > thought I
> > > would try and fix up some of its deficiencies in the meantime. This
> > > is
> > > pre-work for that, but I thought it was useful enough on it's own.
> > >
> > > The testing was hacking up hibernate to load some data to a huge NP
> > > mapping
> > > and making sure the data was there when it came back.
> >
> > OK, so I don't feel like it is 6.2 material at this point.
> >
> > Please resend it when 6.2-rc1 is out so it gets some more significant
> > linux-next coverage before going into the mainline.
> >
> > Thanks!
>
> Hi,
>
> This still applies fine on both tip and Linus' tree. Is it a good time?

Sure.

Thanks!
