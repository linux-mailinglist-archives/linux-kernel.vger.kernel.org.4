Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 365AF6032E7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 20:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbiJRS5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 14:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbiJRS5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 14:57:15 -0400
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3974D2BF7;
        Tue, 18 Oct 2022 11:57:14 -0700 (PDT)
Received: by mail-qv1-f50.google.com with SMTP id mx8so9900918qvb.8;
        Tue, 18 Oct 2022 11:57:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xiQsRjGXuWnXqr7gb8d6177VY0t1MeeDA3Ggynp6mWo=;
        b=Ibn1XWMLzBAVS6+LcEO/Y9f+LQXlRnWsjCnaoj0dUlnhtOmKLUBkZ4GTo3l5oDd7dC
         w36sQm4hOV5cFrNdC3GEls8k1lpzdstjQJiDWqbBKO7qxW9iWZCobg4t8Oru2s+kMtTB
         LfLjcjqSxxYNnfpp6KkKUiFgYOopMQJ/UT0nIaMxhTGZ1kyUx4PyR1ezWS/jyBQZ5g/x
         0ZpM4/sraj6H5cWrSeSMd4gIfQ+ngbQB3bOhXBRuDW6CeRRaDoUauuFtnuiSsqDiTsjY
         ganVd53y8M/sz/D9Q04q0+olKR3QsoydSHw2+GK6mRhGluiBVsB2P6Dv/JmiOXlUsldG
         VfiQ==
X-Gm-Message-State: ACrzQf1mnpmGwqbJ/WX0yZMvrjk1TqX3AjGKDV/Ai/pyrbi17TeALOil
        0MA0ffrECNnF/CYTIyb7ffcXqbOccXnX/PWBysQ=
X-Google-Smtp-Source: AMsMyM7HW/NQx1boi0LOOXMeKA3ucyRmwPce1/RNiR7Xp4r6wzsdtpqgGj2VHWrXzIokgWw3pdgCMpYr8rsEUX6p7BY=
X-Received: by 2002:ad4:5d48:0:b0:4b4:12a4:8a2f with SMTP id
 jk8-20020ad45d48000000b004b412a48a2fmr3594352qvb.85.1666119433207; Tue, 18
 Oct 2022 11:57:13 -0700 (PDT)
MIME-Version: 1.0
References: <20221018132341.76259-1-rrichter@amd.com> <20221018132341.76259-7-rrichter@amd.com>
 <CAJZ5v0iweDu6imi_P3eRTTk0Xpzv-swB05fYxmTMAHAjCN2tiA@mail.gmail.com> <Y07wfi7XSxHWr7LD@rric.localdomain>
In-Reply-To: <Y07wfi7XSxHWr7LD@rric.localdomain>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 18 Oct 2022 20:57:02 +0200
Message-ID: <CAJZ5v0gtbzD9H9OEWS1X5OnFCntFTAnNbxwrU3FpZbnR5rQ6fQ@mail.gmail.com>
Subject: Re: [PATCH v2 06/12] cxl/acpi: Extract component registers of
 restricted hosts from RCRB
To:     Robert Richter <rrichter@amd.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Len Brown <lenb@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Terry Bowman <terry.bowman@amd.com>
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

On Tue, Oct 18, 2022 at 8:42 PM Robert Richter <rrichter@amd.com> wrote:
>
> On 18.10.22 15:31:16, Rafael J. Wysocki wrote:
> > On Tue, Oct 18, 2022 at 3:24 PM Robert Richter <rrichter@amd.com> wrote:
> > >
> > > A downstream port must be connected to a component register block.
> > > For restricted hosts the base address is determined from the RCRB. The
> > > RCRB is provided by the host's CEDT CHBS entry. Rework CEDT parser to
> > > get the RCRB and add code to extract the component register block from
> > > it.
> > >
> > > RCRB's BAR[0..1] point to the component block containing CXL subsystem
> > > component registers. MEMBAR extraction follows the PCI base spec here,
> > > esp. 64 bit extraction and memory range alignment (6.0, 7.5.1.2.1).
> > >
> > > Note: Right now the component register block is used for HDM decoder
> > > capability only which is optional for RCDs. If unsupported by the RCD,
> > > the HDM init will fail. It is future work to bypass it in this case.
> > >
> > > Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> >
> > What does this S-o-B mean?  If this person is your co-developer, you
> > need to add a Co-developed-by tag to clarify that.
> >
> > > Signed-off-by: Robert Richter <rrichter@amd.com>
>
> I picked up an early patch and modified it significantly, so I just
> left the S-o-B.

In that case the right thing to do is to mention the original author
in the changelog instead of retaining the S-o-b.

> I could change this to a Co-developed-by tag.

Co-developed-by should be used in addition to and not instead of S-o-b
when one of the authors is sending a patch.  However, all of the
authors need to be familiar with the patch in the form in which it is
being sent then.

> IMO, the S-o-B is ok, but could be wrong here.

It isn't, at least not without a Co-developed-by tag.

There are 3 cases in which S-o-b is OK AFAICS:

1. When it matches the From: address.
2. When there is a matching Co-developed-by.
3. When maintainers pick up patches and add their own S-o-b.

This case is none of the above.
