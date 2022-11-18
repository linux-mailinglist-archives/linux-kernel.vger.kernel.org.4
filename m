Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC9D62FE46
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 20:49:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234216AbiKRTt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 14:49:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235177AbiKRTtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 14:49:14 -0500
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62826920BD;
        Fri, 18 Nov 2022 11:49:13 -0800 (PST)
Received: by mail-io1-f43.google.com with SMTP id y6so4594418iof.9;
        Fri, 18 Nov 2022 11:49:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GYEzjkvptIJXg6Az/jNKrJS5GvlgDJBwQDVsC1xvASw=;
        b=DWgFKMI//s232NIRkczgwk/x4GjZGPBGXe2gjOSVChTE/0QA96HKCh143zIbpwvKVq
         MhuRCykreo1fMyKtjAfesxd4wIbQ/IcUaa/tb72vhvbo4lXRbiSGi5glisQ7HGmoEyJd
         N5AI1v0TZrhtgDMBU7UGpGbWMiFJQIoKmoO89HrVxp+Cfphr4kecAayTcVVZiRFhOoOt
         Au0dhgyg516AuVh0afNUNB0l/iEn8+RZ0MmhqpXKQN8nuiqR9/L2VqbwQ6aHVMHhyu4A
         S9FaoMcgMfIYsFd8OcW0o8+oj8XyYdpO9Q9RwN4p/MzxHlWg5GwzTAFbUYuTiolYt4/b
         xZLg==
X-Gm-Message-State: ANoB5pmdle4RMsdtliW/a3vVRSEhZOyIcH49pUfoM/LJTRTVJclYT3Pp
        tstkL2xXdkX+KRq64tjv+b3rv46D3WUrQSxSX9Y=
X-Google-Smtp-Source: AA0mqf4EY2Jj3zWui/2JFwdCSGDqirXDby1g97gJDpXvX/amS/Xgq3Dc+4OxzVfHFXffPl9Hl2bNkrLPlk+5fgaMZ78=
X-Received: by 2002:a05:6638:4910:b0:375:a56b:aedf with SMTP id
 cx16-20020a056638491000b00375a56baedfmr3800688jab.276.1668800952626; Fri, 18
 Nov 2022 11:49:12 -0800 (PST)
MIME-Version: 1.0
References: <20221116025417.2590275-1-srinivas.pandruvada@linux.intel.com>
 <CAJZ5v0hQkZ=jprMc5MNaCudKNATtjs_5Z+N7+a7eeaXRjGpaDQ@mail.gmail.com> <4b168fc1cad6a57e0f20b9050c86174a57b34989.camel@linux.intel.com>
In-Reply-To: <4b168fc1cad6a57e0f20b9050c86174a57b34989.camel@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 18 Nov 2022 20:49:01 +0100
Message-ID: <CAJZ5v0gD+d=9DhpjD80qJWkvp4pro3gqf2cFLEjsGk9jSx+XGQ@mail.gmail.com>
Subject: Re: [PATCH RESEND 1/2] thermal: intel: Prevent accidental clearing of
 HFI status
To:     srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, daniel.lezcano@linaro.org,
        amitk@kernel.org, rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2022 at 8:38 PM srinivas pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> On Fri, 2022-11-18 at 18:54 +0100, Rafael J. Wysocki wrote:
> > On Wed, Nov 16, 2022 at 3:54 AM Srinivas Pandruvada
> > <srinivas.pandruvada@linux.intel.com> wrote:
> > >
> > > When there is a package thermal interrupt with PROCHOT log, it will
> > > be
> > > processed and cleared. It is possible that there is an active HFI
> > > event
> > > status, which is about to get processed or getting processed. While
> > > clearing PROCHOT log bit, it will also clear HFI status bit. This
> > > means
> > > that hardware is free to update HFI memory.
> > >
> > > When clearing a package thermal interrupt, some processors will
> > > generate
> > > a "general protection fault" when any of the read only bit is set
> > > to 1.
> > > The driver maintains a mask of all read-write bits which can be
> > > set.
> > > This mask doesn't include HFI status bit. This bit will also be
> > > cleared,
> > > as it will be assumed read-only bit. So, add HFI status bit 26 to
> > > the
> > > mask.
> > >
> > > Signed-off-by: Srinivas Pandruvada
> > > <srinivas.pandruvada@linux.intel.com>
> > > Reviewed-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> >
> > Is a Fixes tag missing here?
> While adding the following change, this should have been take care of:
> ab09b0744a99 ("thermal: intel: hfi: Enable notification interrupt")
>
> But the above change didn't add this line, which this patch is
> changing. We can add:
>
> Fixes: ab09b0744a99 ("thermal: intel: hfi: Enable notification
> interrupt")

OK

> Do you want me to send another PATCH with fixes.

No, I can take care of this.

> >
> > Also, do you want it in 6.1-rc7 or would 6.2 suffice?
> Not urgent. 6.2 should be fine.

OK, thanks!
