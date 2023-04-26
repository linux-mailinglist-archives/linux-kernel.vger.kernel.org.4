Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B50D96EF8D8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 18:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233482AbjDZQ6Y convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 26 Apr 2023 12:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbjDZQ6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 12:58:22 -0400
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D785B6181;
        Wed, 26 Apr 2023 09:58:21 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-94ea38c90ccso219813066b.1;
        Wed, 26 Apr 2023 09:58:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682528300; x=1685120300;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6tDRePBPqY1Z5GtQ693ASBarIdQRrHqj1TKI6s9dLP0=;
        b=HipPXBamGI2sTYLBoSjVKHR4qypjhFEWhcVgoLHL63IbgXpxxcnArtaV/d9iNVOoQd
         PDd7uF5TG41lP/V2Wt0Q/3JukAgaluYYhVAkBJFcQgnXb5QJNAVJJzSe6rq0gXRN6IWD
         8Hr26yeHKQhxVm5uhmz/nauwbFrqKmOA1RwzGfmtbxLKDQFyvN/O3QzUQIetcPKtBZi2
         oRe0sxDCJ5lrnphGaytUrYIm8W3KWFvzYmriJdq8kfd4R0H1RAty5oTEzisJsGvoZDuR
         FlP5rueuKxERTEPyL7BkWWH/z/4n2yrliSGfwXLfQufNTT28L2gVk5bQan/JadZC2xPm
         ekBw==
X-Gm-Message-State: AAQBX9c6kK4TLtCxsdBw6PZd+/PHXLGPU27YWrbEAftYr+5f3g/pdo1c
        BWk4d/caPF9Z+zFh+n0eiGTxc3ONTWLp1PEHNXwQw0At
X-Google-Smtp-Source: AKy350YTOiimuXUYsMoqDhYGHlS2mG/fipxzusk4yIMTYvxp6cBiIMmcTn7qjk4HzRf6VVnT6WT/KOkUQaavUxYmrWQ=
X-Received: by 2002:a17:906:c0cb:b0:94a:5f0d:d9d6 with SMTP id
 bn11-20020a170906c0cb00b0094a5f0dd9d6mr18198475ejb.4.1682528300094; Wed, 26
 Apr 2023 09:58:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230419083343.505780-1-daniel.lezcano@linaro.org>
 <20230419083343.505780-7-daniel.lezcano@linaro.org> <CAJZ5v0gi4j=kJBnXCotQ8_+t39CzOFSBie9Yc6x8BV=TYxsjPQ@mail.gmail.com>
 <bcc96406-3f74-b79b-3f75-0c3bd88c5eea@linaro.org>
In-Reply-To: <bcc96406-3f74-b79b-3f75-0c3bd88c5eea@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 26 Apr 2023 18:58:08 +0200
Message-ID: <CAJZ5v0jEGw_skrJ_rixnfHmUQ04VQiUjFP-UGsvp8Ta8JkyXsw@mail.gmail.com>
Subject: Re: [PATCH v4 6/6] thermal/drivers/intel_menlow: Make additionnal
 sysfs information optional
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, rui.zhang@intel.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Sujith Thomas <sujith.thomas@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
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

On Thu, Apr 20, 2023 at 11:40 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 20/04/2023 19:24, Rafael J. Wysocki wrote:
>
> [ ... ]
>
> > After looking at it once more, I think that this driver isn't really
> > functional without the additional sysfs attributes, so if
> > CONFIG_INTEL_MENLOW_SYSFS_ADDON is set, the driver effectively becomes
> > dead code.
> >
> > That's rather unfortunate and I'm not sure how to deal with it ATM.
> >
> > I can queue up the rest of the series for 6.4-rc1 (in which case it
> > will be pushed in the second half of the merge window), but this
> > particular patch requires more thought IMV.
>
> I'm fine if you drop this one from the series.
>
> Thanks for looking at it more deeply

No problem.

After some private conversation with Srinivas regarding this driver,
I've just posted a patch to get rid of it entirely and so I'm going to
skip all of the patches touching the Menlow driver in this series.
