Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0020743885
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 11:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232479AbjF3JmM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 30 Jun 2023 05:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231455AbjF3JmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 05:42:10 -0400
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C72102;
        Fri, 30 Jun 2023 02:42:08 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-98de322d11fso46925066b.1;
        Fri, 30 Jun 2023 02:42:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688118127; x=1690710127;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jZpg7j29IcHevI8isRdjcHQ2oRleGwDUzQEzfJdoDFY=;
        b=j2hnoZC9lPMqsWDWi0ncqcVPm0/P6m31HqXybmxRnMuRwKTpKoKIdul3+W6on4Ncg0
         B/sYfTVuqI43BNKfb2qw/zyMXepHKpLZx4UEep2c+3nvsA6YGyBM6ORTBF6fJw1HcQZO
         3xBK6kH/KEtwSHL6DIVMofyxpTpf0BUo30YgzY1GFQE5za7M4JrB1YTPBcbKh1mz44bU
         lDVD8oIgrXvJUT8BSfybV6LRvo1J0ksLfOWJOUOkKHXfeWBpxbDQ0fjqAojTIJX25wmY
         cmPMbWonr9tCTdhpR1Ny4aG1KQbAVnpDYRG/EUQOrReJHJyvc/XFBthMFNklEvrJ2tAu
         wSOA==
X-Gm-Message-State: ABy/qLZBBUoDK8u9tnkeZDrkY81H1KT6yn2Z2LQxG4IVxmMTMTPexbsm
        9NNCdh9vrPy3P+Q1cw+Da20yTOndg3aDtVxq2yY=
X-Google-Smtp-Source: APBJJlEXmTXglnxuJIbSAEFuDI2+6cXTmvC5sVmuqo7iRowBLSGO8SvISOeYEiE7ZKu52nF0x+BIrKoePPzvTvF1+mg=
X-Received: by 2002:a17:906:29ce:b0:987:115d:ba05 with SMTP id
 y14-20020a17090629ce00b00987115dba05mr1523902eje.3.1688118126723; Fri, 30 Jun
 2023 02:42:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230616165034.3630141-1-michal.wilczynski@intel.com>
 <20230616165034.3630141-4-michal.wilczynski@intel.com> <CAJZ5v0ippMo1Haa-YFszyWZNgUE_pPUtkFngQWjUyjJe4tm94g@mail.gmail.com>
 <ff596664-1062-92ff-a1fe-3b644925aeae@intel.com>
In-Reply-To: <ff596664-1062-92ff-a1fe-3b644925aeae@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 30 Jun 2023 11:41:55 +0200
Message-ID: <CAJZ5v0gj5Pf_Ut0v+gTd34ubpGOs7okitFEXV3eFJxPPHYFrgw@mail.gmail.com>
Subject: Re: [PATCH v5 03/10] acpi/ac: Move handler installing logic to driver
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
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 30, 2023 at 11:39 AM Wilczynski, Michal
<michal.wilczynski@intel.com> wrote:
>
>
>
> On 6/29/2023 5:55 PM, Rafael J. Wysocki wrote:
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
> >>  drivers/acpi/ac.c | 33 ++++++++++++++++++++++++---------
> >>  1 file changed, 24 insertions(+), 9 deletions(-)
> >>
> >> diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
> >> index 1ace70b831cd..207ee3c85bad 100644
> >> --- a/drivers/acpi/ac.c
> >> +++ b/drivers/acpi/ac.c
> >> @@ -34,7 +34,7 @@ MODULE_LICENSE("GPL");
> >>
> >>  static int acpi_ac_add(struct acpi_device *device);
> >>  static void acpi_ac_remove(struct acpi_device *device);
> >> -static void acpi_ac_notify(struct acpi_device *device, u32 event);
> >> +static void acpi_ac_notify(acpi_handle handle, u32 event, void *data);
> >>
> >>  static const struct acpi_device_id ac_device_ids[] = {
> >>         {"ACPI0003", 0},
> >> @@ -54,11 +54,9 @@ static struct acpi_driver acpi_ac_driver = {
> >>         .name = "ac",
> >>         .class = ACPI_AC_CLASS,
> >>         .ids = ac_device_ids,
> >> -       .flags = ACPI_DRIVER_ALL_NOTIFY_EVENTS,
> >>         .ops = {
> >>                 .add = acpi_ac_add,
> >>                 .remove = acpi_ac_remove,
> >> -               .notify = acpi_ac_notify,
> >>                 },
> >>         .drv.pm = &acpi_ac_pm,
> >>  };
> >> @@ -128,9 +126,12 @@ static enum power_supply_property ac_props[] = {
> >>  };
> >>
> >>  /* Driver Model */
> >> -static void acpi_ac_notify(struct acpi_device *device, u32 event)
> >> +static void acpi_ac_notify(acpi_handle handle, u32 event, void *data)
> >>  {
> >> -       struct acpi_ac *ac = acpi_driver_data(device);
> > This line doesn't need to be changed.  Just add the device variable
> > definition above it.
> >
> > And the same pattern is present in the other patches in the series.
>
> I like the Reverse Christmas Tree, but sure will change that

I do too, but in the cases when it costs 3 extra lines of code I'd
rather have something simpler.
