Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 996BF667F37
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 20:29:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240128AbjALT31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 14:29:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240642AbjALT2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 14:28:46 -0500
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13D9965F3;
        Thu, 12 Jan 2023 11:23:28 -0800 (PST)
Received: by mail-ej1-f51.google.com with SMTP id u9so47258319ejo.0;
        Thu, 12 Jan 2023 11:23:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nKrf1dgum1SXnE9nilvyIY+Ubkbdg8+lqnAjJi8wIj8=;
        b=Cr9F3G70miWMcevRLId8ATPP34V50hLiZl5wswvvcJ91IWbpOO6z7xdUvwXiNsNHNi
         fv44BwcBCGrD20Co9ZqayQr9yaBXf5kg93fzSXrqcVG/eI51B2EAsMF/Fi6lYS/bkqMa
         JHpD59nOlakWkjLh1BraY0ZgU7UNVa/qckqcvg5JuJ6l0qeNP+YUhHKp5f7eSgZDPdpG
         5kGdTsNEJtgfHJNz0p4dUfuUa35QF62boU97UWsdDntxrNLMNCuF8JXhxjt4se7jmGdU
         4JOmuLMBrmnKZDQQc6RPrC1zQ+PKrgpE/f+MnC/1UyyT9GblD/JGAQjUkHZ1usIqCeY1
         /tIg==
X-Gm-Message-State: AFqh2kprK2CqpXQaEDZK5mowC3l8oJAIAJsPYyAqcLOMmkDmsoF+Bxui
        b8xHGhDw+nasVAoMGceUnVB6/dFoWbZ2ylaoqts=
X-Google-Smtp-Source: AMrXdXtL1rja7E90VH6eS1N2VoXUsMrVjlY9Cx5HI455VOxOrsfbpcBloLIrnlSYf7nWGf3tsZSlcNJSq247NSHStxA=
X-Received: by 2002:a17:907:8d0e:b0:7b2:7b45:2cd2 with SMTP id
 tc14-20020a1709078d0e00b007b27b452cd2mr6894663ejc.615.1673551406640; Thu, 12
 Jan 2023 11:23:26 -0800 (PST)
MIME-Version: 1.0
References: <20230106005951.100479-1-yang.lee@linux.alibaba.com> <057bd9fa05f1bfdf10858f23506856f6376c9f8f.camel@intel.com>
In-Reply-To: <057bd9fa05f1bfdf10858f23506856f6376c9f8f.camel@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 12 Jan 2023 20:23:15 +0100
Message-ID: <CAJZ5v0hjACvmP8fytYWMEa-p4F8aix4O3PZ_jxrEedz3etwKZA@mail.gmail.com>
Subject: Re: [PATCH -next] thermal: Fix unsigned comparison with less than zero
To:     "Zhang, Rui" <rui.zhang@intel.com>,
        "yang.lee@linux.alibaba.com" <yang.lee@linux.alibaba.com>
Cc:     "rafael@kernel.org" <rafael@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "amitk@kernel.org" <amitk@kernel.org>,
        "abaci@linux.alibaba.com" <abaci@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 6, 2023 at 8:03 AM Zhang, Rui <rui.zhang@intel.com> wrote:
>
> On Fri, 2023-01-06 at 08:59 +0800, Yang Li wrote:
> > The return value from the call to intel_tcc_get_tjmax() is int, which
> > can
> > be a negative error code. However, the return value is being assigned
> > to
> > an u32 variable 'tj_max', so making 'tj_max' an int.
> >
> > Eliminate the following warning:
> > ./drivers/thermal/intel/intel_soc_dts_iosf.c:394:5-11: WARNING:
> > Unsigned expression compared with zero: tj_max < 0
> >
> > Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=3637
> > Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> > Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
>
> Thanks for catching this issue.
>
> Acked-by: Zhang Rui <rui.zhang@intel.com>

Applied, thanks!

> > ---
> >  drivers/thermal/intel/intel_soc_dts_iosf.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/thermal/intel/intel_soc_dts_iosf.c
> > b/drivers/thermal/intel/intel_soc_dts_iosf.c
> > index 2138693d8afd..8c26f7b2316b 100644
> > --- a/drivers/thermal/intel/intel_soc_dts_iosf.c
> > +++ b/drivers/thermal/intel/intel_soc_dts_iosf.c
> > @@ -380,7 +380,7 @@ struct intel_soc_dts_sensors
> > *intel_soc_dts_iosf_init(
> >  {
> >       struct intel_soc_dts_sensors *sensors;
> >       bool notification;
> > -     u32 tj_max;
> > +     int tj_max;
> >       int ret;
> >       int i;
> >
