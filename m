Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B38546CDB32
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 15:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbjC2Nun convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 29 Mar 2023 09:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjC2Nul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 09:50:41 -0400
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC100C2;
        Wed, 29 Mar 2023 06:50:40 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id ek18so63606940edb.6;
        Wed, 29 Mar 2023 06:50:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680097839;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KSXMakJnjZQBLG/2PdmHswzR68mf+sNeD11KjDBCsa4=;
        b=niQMs2PjwJB1x1kYhWJYK0yDZxqBsYDN3WTBs9mDtIMvBRwLa8Sx48pNHU9zZg6+e2
         lV9oS7mTUiKe9bACShpl3Vm9jCFR5Qul4iyA/+FvmaCYF8iEUzmNTMzlp2y9om+tZm9M
         HNQr94wONSNWeCpgqz4y5qFJClLXhsBuH0J24wa4PtR04T1Sa/GJ7EZJ10ircwDKqjg9
         +9nXIrB54NDr0/+eGAxFusaWm9TZMk8sFnPbOcZBIP+mDL7iVYx26jnwlAGb/faeXz5M
         ADPvT49dL+SwppxHzgP7ltNfaHw8nhkR+WBim2HtKOq+SpzQxreZTg0Y9SQ+IeTB521K
         heYw==
X-Gm-Message-State: AAQBX9cMpa6MMgcAwgM/PZLSBrdmuKACb+crnXkIYDfXmeTYarAXVE+E
        WczsjIve6tNRRVkucwbZBORIAH+tyPoYjRjdI4M=
X-Google-Smtp-Source: AKy350bSnJZEuoyk0Wfv9avMiMtlhf9R8L27rBHg5TPKR2nvJOUEsiLG9AshtU2OXHyT6F+BsWsT/wB55QObYp3dmGc=
X-Received: by 2002:a17:907:d48d:b0:93e:c1ab:ae67 with SMTP id
 vj13-20020a170907d48d00b0093ec1abae67mr8837859ejc.2.1680097839114; Wed, 29
 Mar 2023 06:50:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230329090055.7537-1-rui.zhang@intel.com> <08aee7fe-eddc-7841-2539-16ae43fd8d66@linaro.org>
 <CAJZ5v0hGnoEhYadoK-KPTvMtvviOrGqbY9jrmOUzTjOGe_rB_A@mail.gmail.com> <669e0114830d6e70e6fbc877c94de7446a239055.camel@intel.com>
In-Reply-To: <669e0114830d6e70e6fbc877c94de7446a239055.camel@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 29 Mar 2023 15:50:27 +0200
Message-ID: <CAJZ5v0jQ4=N4Nq2+RnAowYgKXZxWDW35Nx-r+NCzLdoCWrf0XA@mail.gmail.com>
Subject: Re: [PATCH -next] thermal/drivers/thermal_hwmon: Fix a kernel NULL
 pointer dereference
To:     "Zhang, Rui" <rui.zhang@intel.com>
Cc:     "rafael@kernel.org" <rafael@kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
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

On Wed, Mar 29, 2023 at 2:33 PM Zhang, Rui <rui.zhang@intel.com> wrote:
>
> On Wed, 2023-03-29 at 14:06 +0200, Rafael J. Wysocki wrote:
> > On Wed, Mar 29, 2023 at 11:57 AM Daniel Lezcano
> > <daniel.lezcano@linaro.org> wrote:
> > > On 29/03/2023 11:00, Zhang Rui wrote:
> > > > When the hwmon device node of a thermal zone device is not found,
> > > > using hwmon->device causes a kernel NULL pointer dereference.
> > > >
> > > > Reported-by: Preble Adam C <adam.c.preble@intel.com>
> > > > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> > > > ---
> > > > Fixes: dec07d399cc8 ("thermal: Don't use 'device' internal
> > > > thermal zone structure field")
> > > > dec07d399cc8 is a commit in the linux-next branch of linux-pm
> > > > repo.
> > > > I'm not sure if the Fix tag applies to such commit or not.
> > >
> > > Actually it reverts the work done to encapsulate the thermal zone
> > > device
> > > structure.
> >
> > So maybe instead of the wholesale switch to using "driver-specific"
> > device pointers for printing messages, something like
> > thermal_zone_debug/info/warn/error() taking a thermal zone pointer as
> > the first argument can be defined?
> >
> > At least this particular bug could be avoided this way.
>
> I didn't see your email before sending patch v2.
>
> are we going to rework the previous series from Daniel thus patch v2 is
> no longer needed?

Well, let's see what Daniel says..

In any case, though, it is not very useful to carry an obvious NULL
pointer dereference in linux-next and the pr_debug() statement added
by the v2 can be replaced later, so I think I'll apply it.
