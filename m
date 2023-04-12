Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C13456DFDA0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 20:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbjDLSgE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 12 Apr 2023 14:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjDLSgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 14:36:01 -0400
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5EFA2D77;
        Wed, 12 Apr 2023 11:35:29 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id q23so21751773ejz.3;
        Wed, 12 Apr 2023 11:35:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681324528; x=1683916528;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IT1P4dXeA0tf8CXzbQiysNKJY0hmov5O9TWOsfyQMAg=;
        b=ZFBHSKWrUMbj1d9DUeuTpiTQqubDwKTeokHeNei8BQc5LkA8U1hKQaWoAkSDkV/cSn
         PvkVZEtxsNzCvSBhJMf2MqDMQHdpa0N+xc3sablf1h9P110MKVYCOWzvpWPohAuZtFRq
         5z4CFSou5k+SytUXuDHrHq1fpqJmJELv/oljeI2PVMz4ORAbmvltyDQMAUu8NNY2tD9T
         b8oIOzKDZhnvhAn3nkaIXdMD0miu5EclSfo5Fb6TAQfgj3xjFKasPs2tV6HfPCG73Pwk
         B7W9fEl8byljq9Wj0TUFm2RTbMUes8JmvdtHLnfllXkoZyY/mwcoeQgrAkkcVwo/rXOt
         iKxQ==
X-Gm-Message-State: AAQBX9fMswzoEOzmEH2gMT9yRJDU/wmyTbGH43I3K3+u12ANP7kgAkn1
        idMrMuPuCRIgcxgAuUrRTDfbP0fWU8T5zBhfhi4zLkjC
X-Google-Smtp-Source: AKy350bAq+eCWqrllLkRBpmxO+Lj6BypQ+Dz1zqWP3V54uCi/Z1do7u2aFP7A4+1r3iy1yGivamDjR35keDgFbmqgL0=
X-Received: by 2002:a17:907:789:b0:946:a095:b314 with SMTP id
 xd9-20020a170907078900b00946a095b314mr7330202ejb.2.1681324528071; Wed, 12 Apr
 2023 11:35:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230410205305.1649678-1-daniel.lezcano@linaro.org>
 <20230410205305.1649678-2-daniel.lezcano@linaro.org> <CAJZ5v0gA2-WBOs6-N4iaaypdq4-P0JH+jLfOsaYi4GpdqorAcQ@mail.gmail.com>
 <87119ec6-43e1-6062-93dc-be133fdeb88a@linaro.org>
In-Reply-To: <87119ec6-43e1-6062-93dc-be133fdeb88a@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 12 Apr 2023 20:35:16 +0200
Message-ID: <CAJZ5v0iZrNE9Ez0aOUsD3rTbq0k5x_71TAkExG7Psuq0JW597A@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] thermal/drivers/intel_pch_thermal: Use thermal
 driver device to write a trace
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, rui.zhang@intel.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Tim Zimmermann <tim@linux4.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11, 2023 at 10:10 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 11/04/2023 20:16, Rafael J. Wysocki wrote:
> > On Mon, Apr 10, 2023 at 10:53 PM Daniel Lezcano
> > <daniel.lezcano@linaro.org> wrote:
> >>
> >> The pch_critical() callback accesses the thermal zone device structure
> >> internals, it dereferences the thermal zone struct device and the 'type'.
> >>
> >> For the former, the driver related device should be use instead and
> >> for the latter an accessor already exists. Use them instead of
> >> accessing the internals.
> >>
> >> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> >> ---
> >>   drivers/thermal/intel/intel_pch_thermal.c | 5 ++++-
> >>   1 file changed, 4 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/thermal/intel/intel_pch_thermal.c b/drivers/thermal/intel/intel_pch_thermal.c
> >> index dce50d239357..0de46057db2a 100644
> >> --- a/drivers/thermal/intel/intel_pch_thermal.c
> >> +++ b/drivers/thermal/intel/intel_pch_thermal.c
> >> @@ -127,7 +127,10 @@ static int pch_thermal_get_temp(struct thermal_zone_device *tzd, int *temp)
> >>
> >>   static void pch_critical(struct thermal_zone_device *tzd)
> >>   {
> >> -       dev_dbg(&tzd->device, "%s: critical temperature reached\n", tzd->type);
> >> +       struct pch_thermal_device *ptd = thermal_zone_device_priv(tzd);
> >> +
> >> +       dev_dbg(&ptd->pdev->dev, "%s: critical temperature reached\n",
> >> +               thermal_zone_device_type(tzd));
> >
> > No, this just makes the code more complex than it is and the only
> > reason seems to be "cleanliness".
> >
> > Something like
> >
> > thermal_zone_dbg(tzd, "critical temperature reached\n");
> >
> > would work, the above doesn't.  Sorry.
>
> Why not add a trace directly in handle_critical_trips() in
> thermal_core.c and remove this one ?

That would work too.
