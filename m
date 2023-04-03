Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3567E6D50AD
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 20:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233400AbjDCSeO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 3 Apr 2023 14:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233367AbjDCSd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 14:33:59 -0400
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B58664497;
        Mon,  3 Apr 2023 11:33:12 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id r11so121075565edd.5;
        Mon, 03 Apr 2023 11:33:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680546791;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HHSxBiNEVGSfoKkTfzSpIJ2j8jfRIFlenQRFaTgrtfo=;
        b=nTabTFSDiPbT8eOawGjgqm8RkCIVHvABKnKSsVuVaMOS6BpWpLRy+WfLUmhkxraEP0
         QR/QQR5gY1LwMVBmepr00CYEZXnSP139uJZDuVzbbdCnJoAgBiYkgRQ1toLbHEa38DiP
         lRvpV1I6a2XmPAWJUY66ovJqMfnO1HmVQ5gLSwaCLT2PrqFlVPJTtmIwgzvVklqnUZGG
         zUo92VYeXoU6MgF/8LT5GRl22wiWNX17wMR+jzsbxZyiY0KyBDW01ix5ME8PNAKnbK1/
         pWmWHYiZiv63zrHqp9usp3pNtuhYCj7QRDBIA8VZ9w1bGHN2RA4XPcOTqCDZ9w/tUBbS
         IRdw==
X-Gm-Message-State: AAQBX9d9TOqf5Gx9h+8vMkS6V2kyTx3h46QBAVnxYuGikFko3WSRUglW
        aMBWyWo6Kdiv9Ybywi/o4Vf6Ur3ifWx7sL+gd0k=
X-Google-Smtp-Source: AKy350a/AS5VcdtbJFgAKbHZ5DKldmsPaF87+HRSc3LxYfWddtkWqVOkuUbDNgo/30TeQy+ESTNuU5B6oekUoLHvdcc=
X-Received: by 2002:a50:8e15:0:b0:4fc:ebe2:2fc9 with SMTP id
 21-20020a508e15000000b004fcebe22fc9mr106443edw.3.1680546790806; Mon, 03 Apr
 2023 11:33:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230330194439.14361-1-mario.limonciello@amd.com>
 <20230330194439.14361-5-mario.limonciello@amd.com> <CAJZ5v0jabz27wk-g=iZRSnpUCmWimfjSUZO+iuNeRbuzPxW=DA@mail.gmail.com>
 <59127d2ac2e60d59b5711517eb049eee334a3cdd.camel@intel.com> <3f7ec97b-5fa6-9c54-b4b2-58ebf4f88449@amd.com>
In-Reply-To: <3f7ec97b-5fa6-9c54-b4b2-58ebf4f88449@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 3 Apr 2023 20:32:59 +0200
Message-ID: <CAJZ5v0iE-cikqtMFaJCs_2cMENh65KRJhZs3Z_voogJ4qZpTBA@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] platform/x86/intel/pmc: core: Report duration of
 time in HW sleep state
To:     "Limonciello, Mario" <mario.limonciello@amd.com>
Cc:     "Box, David E" <david.e.box@intel.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "jstultz@google.com" <jstultz@google.com>,
        "Shyam-sundar.S-k@amd.com" <Shyam-sundar.S-k@amd.com>,
        "markgross@kernel.org" <markgross@kernel.org>,
        "rrangel@chromium.org" <rrangel@chromium.org>,
        "Jain, Rajat" <rajatja@google.com>,
        "irenic.rajneesh@gmail.com" <irenic.rajneesh@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "svenva@chromium.org" <svenva@chromium.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 3, 2023 at 8:07 PM Limonciello, Mario
<mario.limonciello@amd.com> wrote:
>
> On 4/3/2023 13:00, Box, David E wrote:
> > On Fri, 2023-03-31 at 20:05 +0200, Rafael J. Wysocki wrote:
> >> On Thu, Mar 30, 2023 at 9:45 PM Mario Limonciello
> >> <mario.limonciello@amd.com> wrote:
> >>>
> >>> intel_pmc_core displays a warning when the module parameter
> >>> `warn_on_s0ix_failures` is set and a suspend didn't get to a HW sleep
> >>> state.
> >>>
> >>> Report this to the standard kernel reporting infrastructure so that
> >>> userspace software can query after the suspend cycle is done.
> >>>
> >>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> >>> ---
> >>> v4->v5:
> >>>   * Reword commit message
> >>> ---
> >>>   drivers/platform/x86/intel/pmc/core.c | 2 ++
> >>>   1 file changed, 2 insertions(+)
> >>>
> >>> diff --git a/drivers/platform/x86/intel/pmc/core.c
> >>> b/drivers/platform/x86/intel/pmc/core.c
> >>> index e2f171fac094..980af32dd48a 100644
> >>> --- a/drivers/platform/x86/intel/pmc/core.c
> >>> +++ b/drivers/platform/x86/intel/pmc/core.c
> >>> @@ -1203,6 +1203,8 @@ static inline bool pmc_core_is_s0ix_failed(struct
> >>> pmc_dev *pmcdev)
> >>>          if (pmc_core_dev_state_get(pmcdev, &s0ix_counter))
> >>>                  return false;
> >>>
> >>> +       pm_set_hw_sleep_time(s0ix_counter - pmcdev->s0ix_counter);
> >>> +
> >>
> >> Maybe check if this is really accumulating?  In case of a counter
> >> overflow, for instance?
> >
> > Overflow is likely on some systems. The counter is only 32-bit and at our
> > smallest granularity of 30.5us per tick it could overflow after a day and a half
> > of s0ix time, though most of our systems have a higher granularity that puts
> > them around 6 days.
> >
> > This brings up an issue that the attribute cannot be trusted if the system is
> > suspended for longer than the maximum hardware counter time. Should be noted in
> > the Documentation.
>
> I think it would be rather confusing for userspace having to account for
> this and it's better to abstract it in the kernel.
>
> How can you discover the granularity a system can support?
> How would you know overflow actually happened?  Is there a bit somewhere
> else that could tell you?

I'm not really sure if there is a generally usable overflow detection for this.

> In terms of ABI how about when we know overflow occurred and userspace
> reads the sysfs file we return -EOVERFLOW instead of a potentially bad
> value?

So if the new value is greater than the old one, you don't really know
whether or not an overflow has taken place.

And so I would just document the fact that the underlying HW/firmware
counter overflows as suggested by Dave.
