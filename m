Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFCE3683652
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 20:20:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231895AbjAaTUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 14:20:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231388AbjAaTUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 14:20:44 -0500
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 885F159B53;
        Tue, 31 Jan 2023 11:20:39 -0800 (PST)
Received: by mail-ed1-f52.google.com with SMTP id k4so4703890edo.12;
        Tue, 31 Jan 2023 11:20:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y9Y3rd8N1l2GXRIbzxx3hyWv/IYyZijcmJlQtBVvwqw=;
        b=dDAl3yDMyqSDxeEEdTBftczUEDqZJyTwBO/kjaHPEL4Uyu+WitovrFtimkJxQEWvYL
         XBn7KKAofzpmlKBZXHfBgKCX2gVRFdAg5o63O4ZL/7gdhG/mW8pCBnMq0gzYp3qMzsfM
         2ckBHhQrPcWY3isGtqLotJA6VsUwoFQYQ6vpgFwkAeV6ryT5YZmiYQifbL0hiUL8fNqe
         +2uCgSaDoW+3QVb9zOfFU1AcdJmfro0/lpS2HiD8AgIbpETV67BXDDs32H0DPaJW1bIs
         lSJGXNUwHmALcb6H9N8tt5T34eondpBlGVNZCS3u09ewSgDf8rS+gAO3He1xqlK+F5RI
         ZrYQ==
X-Gm-Message-State: AO0yUKV6PQfzvPNhsebu6PKx4IxPH2yyT0aB59vXgFY1LdZhV2iXBG2M
        jWkmdXY5IazeqxkkFk58U9s6na40h9/QO/xHAMn2OOE0qoo=
X-Google-Smtp-Source: AK7set915NSePsR0Olqkqiu8CNDk75eBKRAuaD7Ko8O305vkAam6scnB0J2UwlrNnD3E9LMToD9jpR8njhq+kCJzUT0=
X-Received: by 2002:a05:6402:845:b0:4a2:56e7:178 with SMTP id
 b5-20020a056402084500b004a256e70178mr2179594edz.58.1675192837874; Tue, 31 Jan
 2023 11:20:37 -0800 (PST)
MIME-Version: 1.0
References: <1751684.VLH7GnMWUR@kreacher> <837557782.0ifERbkFSE@kreacher> <03b7e4ae-04b6-42ca-cad0-7828797f7bf9@linaro.org>
In-Reply-To: <03b7e4ae-04b6-42ca-cad0-7828797f7bf9@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 31 Jan 2023 20:20:26 +0100
Message-ID: <CAJZ5v0hgAsh9FQBb_X+1sSqAwjt-E6rKYO8Y8ue_6GmjwLy-Qw@mail.gmail.com>
Subject: Re: [PATCH v1 8/8] thermal: intel: intel_pch: Refer to thermal zone
 name directly
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Box <david.e.box@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2023 at 5:02 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 30/01/2023 20:07, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Make intel_pch_thermal_probe() use a const char pointer instead of
> > a struct board_info one for accessing the thermal zone name.
> >
> > No intentional functional impact.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >
> > BTW, Srinivas, I'm wondering if user space would be terribly confused by
> > changing this driver to use "Intel PCH" as the thermal zone name of all
> > of the supported platforms?
> >
> > ---
> >   drivers/thermal/intel/intel_pch_thermal.c |    6 +++---
> >   1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > Index: linux-pm/drivers/thermal/intel/intel_pch_thermal.c
> > ===================================================================
> > --- linux-pm.orig/drivers/thermal/intel/intel_pch_thermal.c
> > +++ linux-pm/drivers/thermal/intel/intel_pch_thermal.c
> > @@ -175,7 +175,7 @@ static int intel_pch_thermal_probe(struc
> >                                  const struct pci_device_id *id)
> >   {
> >       enum pch_board_ids board_id = id->driver_data;
> > -     const struct board_info *bi = &board_info[board_id];
> > +     const char *zone_name = board_info[board_id].name;
>
> Assuming you will change 'board_info[board_id].name' by
> 'board_info[board_id]'

Hmm, why would that be required?

> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Anyway, though, I'm planning to use this replacement patch instead of
the $subject one:

https://lore.kernel.org/linux-pm/12166249.O9o76ZdvQC@kreacher/
