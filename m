Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB2167434E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 21:09:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbjASUJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 15:09:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjASUJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 15:09:26 -0500
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 239A69373F;
        Thu, 19 Jan 2023 12:09:25 -0800 (PST)
Received: by mail-ej1-f47.google.com with SMTP id qx13so8570485ejb.13;
        Thu, 19 Jan 2023 12:09:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ICucaelScFBp72R2uUWOJT+N8a5uz5WEAv6I/4JxUuk=;
        b=jK2NeiJo854AoGrsi4rBI6CsgqTo57Rj7k3Flb+3Y3rggNJ4obxdJQF7QLfSSjygtw
         c3kg4MCURwA1vGFCMiEo+IFo0f7STKpMB7T8KkisbEpRYkP5J/Iz9cDL/Al5D9kxmfFU
         SyfawoNrnwyp8RcodoCDxT/Ycl8LzmHFpR2zfgfBexmlCnI2pS4LFWEDuNw8tpShJJCZ
         0J02cjmMFHMtJ4MA9xmnm+mn/nMTo6tsVwqHPO/WasVJImdFEND2Op9jlkZzEzWvNnfQ
         WwBynWaN4LTHb8Z4WutS9E3d1Etti1rsCw/G6mchGlXYugT7zxISLuXOwSMJVy7prqN8
         gVww==
X-Gm-Message-State: AFqh2krz6+vYPxB5vYIK55y+i5E76wbbozpeUNOMUkHO+epCVxxcwOHN
        uuaeMEpTqUuLC7XCpH223KjEBb/oR7j0H0yRU3A=
X-Google-Smtp-Source: AMrXdXv6fX2i+S2TtdLghlFy/s9iCVkLfqeNqxedK50jvgkzbYaKWuoSuxSIsR/xYEbeYYMXk6rDtTfGx2efzkjlP14=
X-Received: by 2002:a17:906:eb1b:b0:86e:abe4:5acf with SMTP id
 mb27-20020a170906eb1b00b0086eabe45acfmr1265955ejb.615.1674158963797; Thu, 19
 Jan 2023 12:09:23 -0800 (PST)
MIME-Version: 1.0
References: <cover.1674030722.git.viresh.kumar@linaro.org> <d6e5d4fcca5f66d290e907d10c45cb2e7bbb09e5.1674030722.git.viresh.kumar@linaro.org>
 <CAJZ5v0j5Rfw7pj05WsNka0BCNOszxsvPuMfNH8Kh88J+QZFHfA@mail.gmail.com> <20230119051625.bd4dtnriw6jys6nt@vireshk-i7>
In-Reply-To: <20230119051625.bd4dtnriw6jys6nt@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 19 Jan 2023 21:09:12 +0100
Message-ID: <CAJZ5v0jBhbWasCd0qdZb0Ah=5obLzOUxWQwz9J9=mZ+pVFfxRg@mail.gmail.com>
Subject: Re: [PATCH V4 1/3] thermal: core: call put_device() only after
 device_register() fails
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
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

On Thu, Jan 19, 2023 at 6:16 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 18-01-23, 20:58, Rafael J. Wysocki wrote:
> > On Wed, Jan 18, 2023 at 9:38 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > >
> > > put_device() shouldn't be called before a prior call to
> > > device_register(). __thermal_cooling_device_register() doesn't follow
> > > that properly and needs fixing. Also
> > > thermal_cooling_device_destroy_sysfs() is getting called unnecessarily
> > > on few error paths.
> > >
> > > Fix all this by placing the calls at the right place.
> > >
> > > Based on initial work done by Caleb Connolly.
> > >
> > > Fixes: 4748f9687caa ("thermal: core: fix some possible name leaks in error paths")
> > > Fixes: c408b3d1d9bb ("thermal: Validate new state in cur_state_store()")
> > > Reported-by: Caleb Connolly <caleb.connolly@linaro.org>
> > > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> >
> > OK, so I think that this patch is needed for 6.2 and the other two may
> > be queued up for later (they do depend on this one, though, of
> > course).  Is my understanding correct?
>
> Right.

OK, applied as 6.2-rc material and I'll get to the other two when this goes in.
