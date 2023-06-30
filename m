Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C021E743A2E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 13:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232593AbjF3LCh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 30 Jun 2023 07:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232583AbjF3LBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 07:01:53 -0400
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB8D43ABC;
        Fri, 30 Jun 2023 04:01:17 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-98dfd15aae1so49306766b.0;
        Fri, 30 Jun 2023 04:01:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688122859; x=1690714859;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SwNNfkXcsdEjK6snSksErOen+E6g37LU4cCW5pLNENE=;
        b=FV4YJjZdwOvpL9UrFa6pX9agAOWeBW6KqTDT/5XSVwPnJAOI09HqvShBXcZA03yi3t
         JPXt8+TjUGYYFHWB0nAYml/GWViUTvYUTIkj7N4Zvcdbsla7pKYJo2Qp/qL59m4H0eT9
         D1vju1lvarH5ss8TKWSuk+6OcZ7//HG/8agrNZwMQVflGeEOZgZNzghOvLAhSWJjqhfo
         Ah0wHLhdNUsxmRH38NTveE3WXI1W8cobHVEF/bCBXq1FpAcxNNaoCTA4pNbQmBNskhvM
         gYTFLOMAblJF8nZDetZJzFvDGbREqRUbQOpkRbspOUprdU+qPlg3u36BqiQOR7hrxXuj
         OFrw==
X-Gm-Message-State: ABy/qLYgLf5p/9HCB13iUZCbM3c4kmlLV1xXWkXtMgx/TtwtvO2FwQWt
        u1eofipkj+xG3XQbk1Hgd2JaDapuCVTep4e4mCE=
X-Google-Smtp-Source: APBJJlGK4UDcNmucxCHKV3pZgbCuIjN9vNC4LfEB1wY5GDUITfZC3itQ/WtMXIfcasxAJH0vSWVFHewGzBbf/wuenwk=
X-Received: by 2002:a17:906:594b:b0:987:f332:5329 with SMTP id
 g11-20020a170906594b00b00987f3325329mr1488661ejr.1.1688122859289; Fri, 30 Jun
 2023 04:00:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230616165034.3630141-1-michal.wilczynski@intel.com>
 <20230616165034.3630141-10-michal.wilczynski@intel.com> <CAJZ5v0gcokw72q5uX-3pbBEZtJdCaWHN1vat8yPNQ3SXMgeD4g@mail.gmail.com>
 <d4ebf8ba-6f95-d20c-d7fb-e97b6535f71f@intel.com>
In-Reply-To: <d4ebf8ba-6f95-d20c-d7fb-e97b6535f71f@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 30 Jun 2023 13:00:48 +0200
Message-ID: <CAJZ5v0hXCA3cdqRms2RaQtzH8PnBNsm++nakQS5sSa0EHboa-Q@mail.gmail.com>
Subject: Re: [PATCH v5 09/10] acpi/nfit: Move handler installing logic to driver
To:     "Wilczynski, Michal" <michal.wilczynski@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org, dan.j.williams@intel.com,
        vishal.l.verma@intel.com, lenb@kernel.org, dave.jiang@intel.com,
        ira.weiny@intel.com, rui.zhang@intel.com,
        linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
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

On Fri, Jun 30, 2023 at 11:55 AM Wilczynski, Michal
<michal.wilczynski@intel.com> wrote:
>
>
>
> On 6/29/2023 6:18 PM, Rafael J. Wysocki wrote:
> > On Fri, Jun 16, 2023 at 6:51 PM Michal Wilczynski
> > <michal.wilczynski@intel.com> wrote:
> >> Currently logic for installing notifications from ACPI devices is
> >> implemented using notify callback in struct acpi_driver. Preparations
> >> are being made to replace acpi_driver with more generic struct
> >> platform_driver, which doesn't contain notify callback. Furthermore
> >> as of now handlers are being called indirectly through
> >> acpi_notify_device(), which decreases performance.
> >>
> >> Call acpi_dev_install_notify_handler() at the end of .add() callback.
> >> Call acpi_dev_remove_notify_handler() at the beginning of .remove()
> >> callback. Change arguments passed to the notify function to match with
> >> what's required by acpi_install_notify_handler(). Remove .notify
> >> callback initialization in acpi_driver.
> >>
> >> Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >> Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
> >> ---
> >>  drivers/acpi/nfit/core.c | 24 ++++++++++++++++++------
> >>  1 file changed, 18 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
> >> index 95930e9d776c..a281bdfee8a0 100644
> >> --- a/drivers/acpi/nfit/core.c
> >> +++ b/drivers/acpi/nfit/core.c
> >> @@ -3312,11 +3312,13 @@ void acpi_nfit_shutdown(void *data)
> >>  }
> >>  EXPORT_SYMBOL_GPL(acpi_nfit_shutdown);
> >>
> >> -static void acpi_nfit_notify(struct acpi_device *adev, u32 event)
> >> +static void acpi_nfit_notify(acpi_handle handle, u32 event, void *data)
> >>  {
> >> -       device_lock(&adev->dev);
> >> -       __acpi_nfit_notify(&adev->dev, adev->handle, event);
> >> -       device_unlock(&adev->dev);
> > It's totally not necessary to rename the ACPI device variable here.
> >
> > Just add
> >
> > struct acpi_device *adev = data;
> >
> > to this function.
>
> Sure, is adev a preferred name for acpi_device ?

In new code, it is.

In the existing code, it depends.  If you do a one-line change, it is
better to retain the original naming (for the sake of clarity of the
change itself).  If you rearrange it completely, you may as well
change the names while at it.  And there is a spectrum in between.

>  I've seen a mix of different naming
> in drivers, some use device, adev, acpi_dev and so on. I suppose it's not a big deal, but
> it would be good to know.

Personally, I prefer adev, but this isn't a very strong preference.

Using "device" as a name of a struct acpi_device object (or a pointer
to one of these for that matter) is slightly misleading IMV, because
those things represent AML entities rather than actual hardware.
