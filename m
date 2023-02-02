Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B3C668804F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 15:44:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232450AbjBBOn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 09:43:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjBBOn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 09:43:56 -0500
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A1728626E;
        Thu,  2 Feb 2023 06:43:55 -0800 (PST)
Received: by mail-ed1-f53.google.com with SMTP id be12so2229563edb.4;
        Thu, 02 Feb 2023 06:43:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h0Uvs+EgprBTmQ0jVYkQK7pz/LZJDEiugwmDCmQcPKg=;
        b=d3+SjSDk5udxvdirVlfJh4PTiNubbg90sXvQFTo5R6QaBzmaH00x49aVzqjSwuKSuU
         4V6+5Ync+362RmNXCQ6TXPuE0nL5FTUybjFnSzWjXSc9nCJXboM1Vc1ZmOog6/VhWjvD
         nfs7nJ5muSlPPq2wk/GgHz2IMR7zopBgacV8eBwk4FAwRBvcnKTv9L2N7pWqLGZr3uzv
         4To70VgaHkLJyZ7Zh4YXreDF54hyR7FZZFYBhgO5LkqvguAmZUdJ9ff+mXbrC9ZgYVMh
         CzWhCdiFyGsLb1L1hwvqyCcEk3nMeXGLqGhh6tuM7LBDTL4mGQLU88xtg/retk+34896
         NKEA==
X-Gm-Message-State: AO0yUKUc8LXWn/pMkCKp/6yxwtJi4hoxzVLttkkIF4yIr/CRVW4MEd1M
        SeiBupKtCaafyi6m097mvWn5hFC5HAii5XpeH5dUFYgG
X-Google-Smtp-Source: AK7set8zXcku0FdlawfFg+hMPW0Pgx+DcdQPYQmJrlkn5C8kI3sGrRL/zulzapQslpt2wsc31bgjDky7O3Pe43xtOrs=
X-Received: by 2002:a05:6402:40ce:b0:490:47c3:3d71 with SMTP id
 z14-20020a05640240ce00b0049047c33d71mr2046481edb.31.1675349034088; Thu, 02
 Feb 2023 06:43:54 -0800 (PST)
MIME-Version: 1.0
References: <20230118181622.33335-1-daniel.lezcano@linaro.org>
 <20230118181622.33335-3-daniel.lezcano@linaro.org> <CAJZ5v0jbHR03UyJBMmBBYnSsZmGG0OXqLJvMfXxXKVn4Np4Egw@mail.gmail.com>
 <beb367d8-dad7-87d9-7872-b81a4d3492ae@linaro.org> <CAJZ5v0hFG1VjzKubWkLYPXeGHN9sMt4SDdC_f-dLseaXpsAOKg@mail.gmail.com>
 <c7c7d71d-28e1-310e-2c8f-e5ae53a09f78@linaro.org>
In-Reply-To: <c7c7d71d-28e1-310e-2c8f-e5ae53a09f78@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 2 Feb 2023 15:43:42 +0100
Message-ID: <CAJZ5v0hP_5kOG7kE13fTLRgdiQrz7fskeAWBNW48MSD5t7FnvA@mail.gmail.com>
Subject: Re: [PATCH 3/3] thermal/drivers/intel: Use generic trip points for intel_soc_dts_iosf
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        srinivas.pandruvada@linux.intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, rui.zhang@intel.com,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Amit Kucheria <amitk@kernel.org>
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

On Thu, Feb 2, 2023 at 3:36 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
>
> Hi Rafael,
>
> On 31/01/2023 20:17, Rafael J. Wysocki wrote:
>
> [ ... ]
>
> >>> Why should temp be overwritten here?
> >>
> >> You are correct. This is wrong.
> >>
> >> I think we should call get_trip_temp() before calling update_trip_temp()
> >> instead of passing a zero temperature parameter
> >
> > update_trip_temp() is sort of a misnomer, because it is used for
> > initializing a trip point for example in
> > intel_soc_dts_iosf_add_read_only_critical_trip() and in this
> > particular case get_trip_temp() need not be called before it.
> >
> > This driver seems to be in need of a cleanup.
>
> Will you take care of this cleanup ?

I think I can do that, but I'm not sure how much time I will be able
to allocate for that.  Let me try though.
