Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 399FC6CEBE6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 16:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbjC2OmM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 29 Mar 2023 10:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbjC2Ols (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 10:41:48 -0400
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B1E4EC1;
        Wed, 29 Mar 2023 07:39:08 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id ew6so64215487edb.7;
        Wed, 29 Mar 2023 07:39:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680100747;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mNiF0TAEnjTwFsCRZZ5me++D62yLeN4frM4I1Vw9ZcM=;
        b=i85Qg4yXfOunE2MWtPAiJuMfi5zrjmDUiHo9+OgENCui5hZqe5CvGMw1eO2u6iljuY
         3eCxEJRuTAUmoAdKXQHV1kJXd6tJslKr9K2w5SkrHhIVU0B0FS/JTgLR1grm0IOKSJCW
         kudMh+cPZUU195N5JIYQtqTFO2O2LTxNXO2wxZx6yZUj1C5MLrKQZtHgEpoxhowayGOi
         WGzL5fs/ddPHdecCWYlfMY99aB1DBlIEpm06i2zrn7Veyr1AZiXrhI5zFKjtQPKvRAu+
         b+2frm56PcLmFYDm2gRtq/u/9w6EahdNYdYVIjpJBDH4jHQU91QJJZZivSUmEcfrsrI4
         Q1NQ==
X-Gm-Message-State: AAQBX9ecKDpJrIw57O7X8ZAUrbdpwPfVoqPPYUOsQRhy3zc72V0hnXIL
        LoVtsv29yOzZgDpL5ZIOdsJhE+uoQv7AfaOm66c=
X-Google-Smtp-Source: AKy350Z4UhJSWCT5bD/fUslVkJW5Yvj8kRFX+8v23g/h+Nt8vEYj4Tv0j89x/ULIv19eY/u/rrCGvYsJNWA3mVZOe4o=
X-Received: by 2002:a50:cbc1:0:b0:4fb:e069:77ac with SMTP id
 l1-20020a50cbc1000000b004fbe06977acmr1547826edi.0.1680100746930; Wed, 29 Mar
 2023 07:39:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230329090055.7537-1-rui.zhang@intel.com> <08aee7fe-eddc-7841-2539-16ae43fd8d66@linaro.org>
 <CAJZ5v0hGnoEhYadoK-KPTvMtvviOrGqbY9jrmOUzTjOGe_rB_A@mail.gmail.com> <016dc073-c9a3-4b96-6c58-7b21e0f998a5@linaro.org>
In-Reply-To: <016dc073-c9a3-4b96-6c58-7b21e0f998a5@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 29 Mar 2023 16:38:55 +0200
Message-ID: <CAJZ5v0jmo_bj4iMVe9ARei4-oyP3TdD+FXiiu+-g55FqJxLJsg@mail.gmail.com>
Subject: Re: [PATCH -next] thermal/drivers/thermal_hwmon: Fix a kernel NULL
 pointer dereference
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        rafael.j.wysocki@intel.com, linux-kernel@vger.kernel.org
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

On Wed, Mar 29, 2023 at 4:16 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 29/03/2023 14:06, Rafael J. Wysocki wrote:
> > On Wed, Mar 29, 2023 at 11:57 AM Daniel Lezcano
> > <daniel.lezcano@linaro.org> wrote:
> >>
> >> On 29/03/2023 11:00, Zhang Rui wrote:
> >>> When the hwmon device node of a thermal zone device is not found,
> >>> using hwmon->device causes a kernel NULL pointer dereference.
> >>>
> >>> Reported-by: Preble Adam C <adam.c.preble@intel.com>
> >>> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> >>> ---
> >>> Fixes: dec07d399cc8 ("thermal: Don't use 'device' internal thermal zone structure field")
> >>> dec07d399cc8 is a commit in the linux-next branch of linux-pm repo.
> >>> I'm not sure if the Fix tag applies to such commit or not.
> >>
> >> Actually it reverts the work done to encapsulate the thermal zone device
> >> structure.
> >
> > So maybe instead of the wholesale switch to using "driver-specific"
> > device pointers for printing messages, something like
> > thermal_zone_debug/info/warn/error() taking a thermal zone pointer as
> > the first argument can be defined?
> >
> > At least this particular bug could be avoided this way.
>
> Actually we previously said the thermal_hwmon can be considered as part
> of the thermal core code, so we can keep using tz->device.
>
> I'll drop this change from the series.

But it's there in my thermal branch already.

Do you want to revert the thermal_hwmon.c part of commit dec07d399cc8?

> On the other side, adding more thermal_zone_debug/info.. gives
> opportunities to external components of the core thermal framework to
> write thermal zone device related message. I'm not sure that is a good
> thing, each writer should stay in its namespace, no ?

IMV whoever is allowed to use a thermal zone pointer should also be
allowed to print messages related to its use, especially debug ones.

"Encapsulation" means that the members of a thermal zone device object
should not be accessed directly by its users other than the core, not
that it cannot be used as a message tag.
