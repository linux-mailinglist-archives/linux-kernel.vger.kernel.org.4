Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8B3567A2A6
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 20:26:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233776AbjAXT0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 14:26:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233308AbjAXT0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 14:26:50 -0500
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E82A4474DD;
        Tue, 24 Jan 2023 11:26:45 -0800 (PST)
Received: by mail-ej1-f45.google.com with SMTP id qx13so41736240ejb.13;
        Tue, 24 Jan 2023 11:26:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WOWslbwf3k9B8XZFRmzHiqK02xWFY5DyqxsxPQnAw0c=;
        b=xW6ElFCT99c3Lvt6QoJKjZ4A0kcJoCIqTyuk5ablGrD1Zg7UlPJcv3zjyBQmr+sekl
         MqfZC98HgyJkNcK0aWaDmd1Hq5cH4v0ioLYo3k24gMDnsWEVtjw55MiznG+2N5U+H6t9
         IGFdgir7YDvcWHuDvIomINCUBR+yxAYolRtBcFtXBUA0TXyR0um03RarOM4JYM1UmYw6
         qyaz+YRIGUjNU/HQaSpU4Teo0RCy17AycaNsmkR68xxhXaP4J7Gx+f1hUWhaZb5pJVZD
         OxSrI8sDS+T+UUW93gTa1H04mHepvcKf5zg2qYOTd52Xl+AlmSkeAGN3C0JbUKoy02Rl
         ov4g==
X-Gm-Message-State: AFqh2koDg9D+IHMFr8eaj+nn/3SWn51eX70MuQb4cBZ9woKGEfJK+Hjw
        98/OykIC1BXlRUR5HFCN0maaO5acAv4KYNYbObQ=
X-Google-Smtp-Source: AMrXdXvMbcgPriO0PSlQSJI2+IgKj3AIolQx3WvVPxkJQApk56LuAH67n6oDSevEZFlHyhbH7L5yLbGSlsKPPaCkHo0=
X-Received: by 2002:a17:906:b041:b0:857:6395:3e2c with SMTP id
 bj1-20020a170906b04100b0085763953e2cmr3758010ejb.208.1674588404381; Tue, 24
 Jan 2023 11:26:44 -0800 (PST)
MIME-Version: 1.0
References: <cover.1674030722.git.viresh.kumar@linaro.org> <d6e5d4fcca5f66d290e907d10c45cb2e7bbb09e5.1674030722.git.viresh.kumar@linaro.org>
 <CAJZ5v0j5Rfw7pj05WsNka0BCNOszxsvPuMfNH8Kh88J+QZFHfA@mail.gmail.com>
 <20230119051625.bd4dtnriw6jys6nt@vireshk-i7> <CAJZ5v0jBhbWasCd0qdZb0Ah=5obLzOUxWQwz9J9=mZ+pVFfxRg@mail.gmail.com>
In-Reply-To: <CAJZ5v0jBhbWasCd0qdZb0Ah=5obLzOUxWQwz9J9=mZ+pVFfxRg@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 24 Jan 2023 20:26:33 +0100
Message-ID: <CAJZ5v0h0G+01ni6GK3eTMVarTCEazp_qPJSFpBzUZ7LhwHW=ww@mail.gmail.com>
Subject: Re: [PATCH V4 1/3] thermal: core: call put_device() only after
 device_register() fails
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
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
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 9:09 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Thu, Jan 19, 2023 at 6:16 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > On 18-01-23, 20:58, Rafael J. Wysocki wrote:
> > > On Wed, Jan 18, 2023 at 9:38 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > > >
> > > > put_device() shouldn't be called before a prior call to
> > > > device_register(). __thermal_cooling_device_register() doesn't follow
> > > > that properly and needs fixing. Also
> > > > thermal_cooling_device_destroy_sysfs() is getting called unnecessarily
> > > > on few error paths.
> > > >
> > > > Fix all this by placing the calls at the right place.
> > > >
> > > > Based on initial work done by Caleb Connolly.
> > > >
> > > > Fixes: 4748f9687caa ("thermal: core: fix some possible name leaks in error paths")
> > > > Fixes: c408b3d1d9bb ("thermal: Validate new state in cur_state_store()")
> > > > Reported-by: Caleb Connolly <caleb.connolly@linaro.org>
> > > > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > >
> > > OK, so I think that this patch is needed for 6.2 and the other two may
> > > be queued up for later (they do depend on this one, though, of
> > > course).  Is my understanding correct?
> >
> > Right.
>
> OK, applied as 6.2-rc material and I'll get to the other two when this goes in.

Patches [2-3/3] from this series have been applied as 6.3 material now, thanks!
