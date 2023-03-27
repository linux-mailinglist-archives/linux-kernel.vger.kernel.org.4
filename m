Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A4A86CA8B9
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 17:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232144AbjC0PNa convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 27 Mar 2023 11:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232908AbjC0PNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 11:13:16 -0400
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA48140F1;
        Mon, 27 Mar 2023 08:13:15 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id x3so37514394edb.10;
        Mon, 27 Mar 2023 08:13:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679929994;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=geXDdhc3YH6KJ0J3KkTFe0Op5hGruTe62W+7at+t+fc=;
        b=3dP2/nwqmTro3qmpt/F2Gvw2RLL03nB7qQ+FLWqXkwpskSmQk475+d+QOsdMJQJIK1
         s7IDBTg1R5HFxtdT5gFog6LRMur87Gu8LD2QAkSrKWVBaSBqetv98PEUhdv3gmNyclPr
         G9Bq7nL5gjsdhNeh4AKnYG71fVW2fiR8Yde7NxLhNV3Gxt3V+EPEgS+lUyBCA6637zCn
         1rqjUzwzfXSwh7ioNyM2QaEb2KcAO8elDKuOueBmF3LmfMtFVA6w60k+kuZZxCi0K4j7
         wCMnEPvT4KxQKJlCOgl27oV8m0RH45QV5OIDAufDNp0hJAiN3QIZeNen4gbb9WGGOMRa
         OcOQ==
X-Gm-Message-State: AAQBX9cENcpa6Vvev0q2IG8w/5y41AdTHJ1rgfoiOi2Vk04+SCA55hOL
        Shnxvb7oB/78+97IScOClV09xiqO7jSXViZw09kicWzA
X-Google-Smtp-Source: AKy350aMeJLriUMyPzergybtrU94CNu/8FVjvHfwgyC7SQxOu8WV61dsG5MCg/BieBWOIS2z1ok0uxylYNJ/FDd7akc=
X-Received: by 2002:a17:906:37c8:b0:934:b5d6:14d0 with SMTP id
 o8-20020a17090637c800b00934b5d614d0mr6227368ejc.2.1679929994290; Mon, 27 Mar
 2023 08:13:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230324070807.6342-1-rui.zhang@intel.com> <20230324070807.6342-2-rui.zhang@intel.com>
 <CAJZ5v0gze1wBEMcuEu4Aa9343rh-3=Bu+pdSYuY3stMd8QGf0A@mail.gmail.com> <528f7e58507df4b6137856828e371bb8913b8b59.camel@intel.com>
In-Reply-To: <528f7e58507df4b6137856828e371bb8913b8b59.camel@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 27 Mar 2023 17:13:03 +0200
Message-ID: <CAJZ5v0gL_7VPdcgkmuTz=afYSbGsWZi5wW9vUvyAgverjxsNdw@mail.gmail.com>
Subject: Re: [PATCH 2/5] thermal/core: Reset cooling state during cooling
 device unregistration
To:     "Zhang, Rui" <rui.zhang@intel.com>
Cc:     "rafael@kernel.org" <rafael@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

On Mon, Mar 27, 2023 at 4:50 PM Zhang, Rui <rui.zhang@intel.com> wrote:
>
> On Fri, 2023-03-24 at 14:19 +0100, Rafael J. Wysocki wrote:
> > On Fri, Mar 24, 2023 at 8:08 AM Zhang Rui <rui.zhang@intel.com>
> > wrote:
> > > When unregistering a cooling device, it is possible that the
> > > cooling
> > > device has been activated. And once the cooling device is
> > > unregistered,
> > > no one will deactivate it anymore.
> > >
> > > Reset cooling state during cooling device unregistration.
> > >
> > > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> > > ---
> > > In theory, this problem that this patch fixes can be triggered on a
> > > platform with ACPI Active cooling, by
> > > 1. overheat the system to trigger ACPI active cooling
> > > 2. unload ACPI fan driver
> > > 3. check if the fan is still spinning
> > > But I don't have such a system so I didn't trigger then problem and
> > > I
> > > only did build & boot test.
> >
> > So I'm not sure if this change is actually safe.
> >
> > In the example above, the system will still need the fan to spin
> > after
> > the ACPI fan driver is unloaded in order to cool down, won't it?
>
> Then we can argue that the ACPI fan driver should not be unloaded in
> this case.

I don't think that whether or not the driver is expected to be
unloaded at a given time has any bearing on how it should behave when
actually unloaded.

Leaving the cooling device in its current state is "safe" from the
thermal control perspective, but it may affect the general user
experience (which may include performance too) going forward, so there
is a tradeoff.

You can argue that even if the cooling device is reset on the driver
removal, there should be another thermal control mechanism in place
that will take care of the overheat condition instead of it, but that
mechanism may be an emergency system shutdown.

What do the other cooling device drivers do in general when they get removed?

> Actually, this is the same situation as patch 1/5.
> Patch 1/5 fixes the problem that cooling state not restored to 0 when
> unloading the thermal driver, and this fixes the same problem when
> unloading the cooling device driver.

Right, it is analogous.
