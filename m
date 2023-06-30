Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEE99743A01
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 12:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232186AbjF3Kx3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 30 Jun 2023 06:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232288AbjF3KxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 06:53:06 -0400
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DBBD35B6;
        Fri, 30 Jun 2023 03:53:04 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-94ea38c90ccso47836466b.1;
        Fri, 30 Jun 2023 03:53:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688122383; x=1690714383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/A56lQbaSYx6f8A8Kd9myuvvjZF2IChmVUGzObphlZg=;
        b=I9+ZCk4HUfdY42bTSscxs1a/+YAhPUEpSY4wqOXX1XiS6V7OL0tLJW3xSyB/delA6m
         Jz5DY5N1u/S5fjvWDnlt9G63i/HT22gx0HNyB73vJy56df3P3TVGDFg7zVMI4y4M8opO
         410bchTm1yiGP+7pYdpxUugCJS1pfBQO71lI8Tndiy9fIalzrfWGnmB6NNlh0HuTWQ3v
         bQ77ZL+h+N/h36REnQxhpxRdFpjpzonNPmQgGktpOn/rNin/RLR4/3d5K4XfFrjebdAE
         ej2t7o9cVRSr8NOHfiVM3drM191uTl/6fGUGGEblyYlEZT7673LSjaR0Y3iIiwhYbzli
         SUeg==
X-Gm-Message-State: ABy/qLZfnxpeA66DCyyqZ6QxAnhrF4QLVjbaNsGLiYX+0yZ17r9UQG6C
        FmArxT1DhsZeujXMxOCMgueQ7IF9wK/hXdPKVDo=
X-Google-Smtp-Source: ACHHUZ4WgWkFA9uBFLQ4chY9yS0DrCbDHKg+qJki1rTD/526fTFWs9/rOjn0MfGzEAyJcN8v4XUfb+eUTcSmoaBkahQ=
X-Received: by 2002:a17:906:35c5:b0:988:8220:2af0 with SMTP id
 p5-20020a17090635c500b0098882202af0mr1588637ejb.5.1688122383089; Fri, 30 Jun
 2023 03:53:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230616165034.3630141-1-michal.wilczynski@intel.com>
 <20230616165034.3630141-8-michal.wilczynski@intel.com> <CAJZ5v0jjwk+jVsULD8nyguc7p00Sn3Hyxq7=PLNzpj-Fz6H6sg@mail.gmail.com>
 <aad9608b-34fa-1405-1fc4-5eb8d7d1647f@intel.com>
In-Reply-To: <aad9608b-34fa-1405-1fc4-5eb8d7d1647f@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 30 Jun 2023 12:52:52 +0200
Message-ID: <CAJZ5v0jVsWatCmnN9=H18CzhoekgZOgnEisDJYfb-F=M3cOX1A@mail.gmail.com>
Subject: Re: [PATCH v5 07/10] acpi/nfit: Move acpi_nfit_notify() before acpi_nfit_add()
To:     "Wilczynski, Michal" <michal.wilczynski@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org, dan.j.williams@intel.com,
        vishal.l.verma@intel.com, lenb@kernel.org, dave.jiang@intel.com,
        ira.weiny@intel.com, rui.zhang@intel.com,
        linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 30, 2023 at 11:48 AM Wilczynski, Michal
<michal.wilczynski@intel.com> wrote:
>
>
>
> On 6/29/2023 6:06 PM, Rafael J. Wysocki wrote:
> > On Fri, Jun 16, 2023 at 6:51 PM Michal Wilczynski
> > <michal.wilczynski@intel.com> wrote:
> >> To use new style of installing event handlers acpi_nfit_notify() needs
> >> to be known inside acpi_nfit_add(). Move acpi_nfit_notify() upwards in
> >> the file, so it can be used inside acpi_nfit_add().
> >>
> >> Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
> >> ---
> >>  drivers/acpi/nfit/core.c | 14 +++++++-------
> >>  1 file changed, 7 insertions(+), 7 deletions(-)
> >>
> >> diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
> >> index 07204d482968..aff79cbc2190 100644
> >> --- a/drivers/acpi/nfit/core.c
> >> +++ b/drivers/acpi/nfit/core.c
> >> @@ -3312,6 +3312,13 @@ void acpi_nfit_shutdown(void *data)
> >>  }
> >>  EXPORT_SYMBOL_GPL(acpi_nfit_shutdown);
> >>
> >> +static void acpi_nfit_notify(struct acpi_device *adev, u32 event)
> >> +{
> >> +       device_lock(&adev->dev);
> >> +       __acpi_nfit_notify(&adev->dev, adev->handle, event);
> >> +       device_unlock(&adev->dev);
> >> +}
> >> +
> >>  static int acpi_nfit_add(struct acpi_device *adev)
> >>  {
> >>         struct acpi_buffer buf = { ACPI_ALLOCATE_BUFFER, NULL };
> >> @@ -3446,13 +3453,6 @@ void __acpi_nfit_notify(struct device *dev, acpi_handle handle, u32 event)
> >>  }
> >>  EXPORT_SYMBOL_GPL(__acpi_nfit_notify);
> >>
> >> -static void acpi_nfit_notify(struct acpi_device *adev, u32 event)
> >> -{
> >> -       device_lock(&adev->dev);
> >> -       __acpi_nfit_notify(&adev->dev, adev->handle, event);
> >> -       device_unlock(&adev->dev);
> >> -}
> >> -
> >>  static const struct acpi_device_id acpi_nfit_ids[] = {
> >>         { "ACPI0012", 0 },
> >>         { "", 0 },
> >> --
> > Please fold this patch into the next one.  By itself, it is an
> > artificial change IMV.
>
> I agree with you, but I got told specifically to do that.
> https://lore.kernel.org/linux-acpi/e0f67199-9feb-432c-f0cb-7bdbdaf9ff63@linux.intel.com/

Whether or not this is easier to review is kind of subjective.

If there were more code to move, I would agree, but in this particular
case having to review two patches instead of just one is a bit of a
hassle IMV.
