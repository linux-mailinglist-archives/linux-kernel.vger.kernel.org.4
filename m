Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EABA86D2789
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 20:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232642AbjCaSHT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 31 Mar 2023 14:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231273AbjCaSHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 14:07:17 -0400
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 856EB1207F;
        Fri, 31 Mar 2023 11:07:15 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id t10so92770904edd.12;
        Fri, 31 Mar 2023 11:07:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680286034;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jOn1S9dAKkyYTe62ni2NBuSexnnOc4tSxOCRbbZ+YgA=;
        b=4RC5bXMHcW7j+psVmO8e8G4Gx+HbNHveGcPW9AtwO40O5OMEUzTBcUXCc5kZ4lzW60
         TvXjI+2xfuXYwYEnKt4x8ugnO4nTv6etxa8Ewh8NWSWSQuTaj2WXAtNe3Y5T25M0YAIJ
         R1Q5nL9cJceXCYwSgqwRzsOeEv4uoDW8QumUNfVqTAuZKTNfFtUWWRh8Dqq/GLuKwqkH
         bR77r0h3eQp2zbLTFxBw42xtCBdV4qF2jTB98ersnXrDNNZhVfrzgYYj7vRT6dGUzlb1
         VK+eaVjCfvBiQr7z/u1nm3HxfHhtuyv8ZyjRAdTtP6SRxNGhCwqN0u4p51OhnAsshbL+
         NROQ==
X-Gm-Message-State: AAQBX9fn13MJCvjLwGUc1wSkbprL2tb+P6xPNQCvzCDnke2NHOyP2dow
        JEGNIzRUwdoprZD49mc7owj8LiSPUufAivsRcabB1lEO
X-Google-Smtp-Source: AKy350ai445782LCroklInXTNQsVrgq30rUFYN7oUAwVo12r8Hp/5g0IbDIASDdRPOomtK0lQUVrm9FQ6tzOFK+ca8I=
X-Received: by 2002:a17:907:d48d:b0:93e:c1ab:ae67 with SMTP id
 vj13-20020a170907d48d00b0093ec1abae67mr13069942ejc.2.1680286034047; Fri, 31
 Mar 2023 11:07:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230330194439.14361-1-mario.limonciello@amd.com>
 <20230330194439.14361-2-mario.limonciello@amd.com> <CAJZ5v0jbMXk5k_KG19bQnffhCkGnu=MQXjGrBPipZxA_Cg8O9w@mail.gmail.com>
 <2676888c-e93f-53aa-a4f7-e85b66f351c8@amd.com>
In-Reply-To: <2676888c-e93f-53aa-a4f7-e85b66f351c8@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 31 Mar 2023 20:07:03 +0200
Message-ID: <CAJZ5v0iia9__-jWmawvsxninoTM5ZRtqhyUJme=noZMZJdUBrA@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] PM: Add a sysfs file to represent time spent in
 hardware sleep state
To:     "Limonciello, Mario" <mario.limonciello@amd.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Sven van Ashbrook <svenva@chromium.org>,
        John Stultz <jstultz@google.com>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Raul Rangel <rrangel@chromium.org>,
        David E Box <david.e.box@intel.com>,
        Rajat Jain <rajatja@google.com>,
        S-k Shyam-sundar <Shyam-sundar.S-k@amd.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-pm@vger.kernel.org
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

On Fri, Mar 31, 2023 at 8:05 PM Limonciello, Mario
<mario.limonciello@amd.com> wrote:
>
> On 3/31/2023 13:01, Rafael J. Wysocki wrote:
> > On Thu, Mar 30, 2023 at 9:45 PM Mario Limonciello
> > <mario.limonciello@amd.com> wrote:
> >>
> >> Userspace can't easily discover how much of a sleep cycle was spent in a
> >> hardware sleep state without using kernel tracing and vendor specific sysfs
> >> or debugfs files.
> >>
> >> To make this information more discoverable, introduce a new sysfs file
> >> to represent the time spent in a sleep state.
> >
> > This is only in the most recent suspend-resume cycle, isn't it?
>
> Yes; that's correct.
>
> >
> > Wouldn't it be useful to have another attribute printing the
> > accumulated total HW sleep time?
> >
>
> I had considered this; but I didn't think it was actually very useful
> because userspace will get control at the end of every cycle and can
> accumulate those numbers if desirable.

Unless "user space" in question is actually a human, that is.
