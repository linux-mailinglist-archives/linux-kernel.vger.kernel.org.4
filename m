Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43AC8646EBB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 12:36:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbiLHLgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 06:36:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbiLHLgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 06:36:36 -0500
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 548D468C53;
        Thu,  8 Dec 2022 03:36:35 -0800 (PST)
Received: by mail-qk1-f179.google.com with SMTP id j13so574601qka.3;
        Thu, 08 Dec 2022 03:36:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bo6rK0xASqTgdx2ORUF4mEv4pkXrqAK6ToR/qIRXc6M=;
        b=qmRyuwvIRR62zkHjZrjM7vXcdIZ29yxJ8FH4/eWWp59s2l2l7fFxK4+sT2X/oxm5C4
         N0zzeHK0+uJNA2PrMyB3XoFJ2PhCYnRkGktYVhFCAPT9EZM9fOk/YKKQTodQ0Dr2sqYb
         gaJiMs1gME2fxI8cEyHV+vCMyAi2h8G07yhPSsFcTHYjO2b0CqXXF/jChieZfRzYWuAC
         QiwfMq7fTQ3RIUbv/WzY16WSvuqoqvQNLL9zQXKWOC0sRa38Vb57rXuklpxLEjZLvPAe
         TyyM01wzpSzP3ZuEYLL7lSWM1IR2QLCUFnLmUreW/Oq8/f+6MIiKNgUHybEqQAYEQa1e
         3F6Q==
X-Gm-Message-State: ANoB5pkYPTTY/PVGhkp7EQUVQsRb4/XOdIbBEUV4uVrVLiE+dilZlPoI
        9kfBxxejiDT5DzvFDiCdEa/QiGsO/FT6TH0dYrg=
X-Google-Smtp-Source: AA0mqf4Zpv+1jhQD44OkZOwyoENCyTkgbeBZ+uMfHY7GcKpoipA8TREoNm+biikEDXPLRGAOGRNaKW4Nmbkb29TCGTI=
X-Received: by 2002:a05:620a:4611:b0:6fa:af7e:927c with SMTP id
 br17-20020a05620a461100b006faaf7e927cmr80730264qkb.443.1670499394506; Thu, 08
 Dec 2022 03:36:34 -0800 (PST)
MIME-Version: 1.0
References: <20221208111852.386731-1-perry.yuan@amd.com>
In-Reply-To: <20221208111852.386731-1-perry.yuan@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 8 Dec 2022 12:36:23 +0100
Message-ID: <CAJZ5v0grDdCtWdKHEybb9kX_JWHsb_4x-7eA6mmiRbBaTmDSxg@mail.gmail.com>
Subject: Re: [PATCH v7 00/13] Implement AMD Pstate EPP Driver
To:     Perry Yuan <perry.yuan@amd.com>
Cc:     rafael.j.wysocki@intel.com, Mario.Limonciello@amd.com,
        ray.huang@amd.com, viresh.kumar@linaro.org, Deepak.Sharma@amd.com,
        Nathan.Fontenot@amd.com, Alexander.Deucher@amd.com,
        Shimmer.Huang@amd.com, Xiaojian.Du@amd.com, Li.Meng@amd.com,
        wyes.karny@amd.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

Hi,

On Thu, Dec 8, 2022 at 12:19 PM Perry Yuan <perry.yuan@amd.com> wrote:
>
> Hi all,
>
> This patchset implements one new AMD CPU frequency driver
> `amd-pstate-epp` instance for better performance and power control.
> CPPC has a parameter called energy preference performance (EPP).
> The EPP is used in the CCLK DPM controller to drive the frequency that a core
> is going to operate during short periods of activity.
> EPP values will be utilized for different OS profiles (balanced, performance, power savings).

I honestly don't think that this work is ready for 6.2.

The number of patches in the series seems to change frequently and
there are active discussions around specific patches.

Accordingly, I will not consider applying it until 6.2-rc1 is out.

Thanks!
