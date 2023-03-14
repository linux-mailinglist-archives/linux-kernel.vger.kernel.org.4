Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27B716B9ABE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 17:10:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjCNQKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 12:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbjCNQKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 12:10:31 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71676A2F09
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 09:10:18 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id jl13so7846527qvb.10
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 09:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112; t=1678810217;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=swF9reNuKGvQlpHTaU1zvpVj42ldUq26y6vhH0wRnJM=;
        b=Njpdpu857DRf5XH5IWnjrOSMDrwfUkeADMyzc2yqikDTvr0V8v/tPk8Y0emoyyvtgq
         sDofUc2jncrxBfKt0mAOwLhDVDx6L4ejkgD/lgTj1jCNyazmE94U++kox4PrLs/gOCgO
         Od5ZnITBwPMHWVEnCPF/O5YfGmr5nfAQ7FldRFigMgBiMbYywPouz0eLMDO6YXlhk4vZ
         tPb6SzKcAaRXveagJbuEVsbrPnNa6UFmSwbKvQBQtdwd1xhXzuQX2ZtKqlKVocv79uUH
         JUnH79Vmw0Gpqnl6ngswvA+ZvLa3fAkQNHFGj38WKKjVNGxCuzW9mzLYjIJDgUrEtx3+
         LTAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678810217;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=swF9reNuKGvQlpHTaU1zvpVj42ldUq26y6vhH0wRnJM=;
        b=hOqZ4FAQ3LNaP6wiU59fEc81wZswMpGHn6t6fUNkV9S33SFcj8u1WzoXOF6JtCYT1u
         LxYcual2UXqVv7MrDP3NhXAlCc9VdrzbjpWMNMbimIdXX8CzIYQAJ39MNx6TFVYEoCTj
         I2uWYFAReC/QOi1u7+/TxbSuzNvkcUbMtYGsVkhJws2dY5Eh+5hnn2zpgRwU6OKMA5qj
         u7p851Rlx0z4jr32+PDvbeYOdSIhEPwwqoD5ooi432QFQiW/I31BGPWsYJ0uwkenRTPY
         SxyP9NaFNOW8pMX+r2l/3s3lx+6CFgAQ0IcoPlokcdchkVArbdQwKip+w753egghILjk
         IdRg==
X-Gm-Message-State: AO0yUKXnc1bOMlK6YBnf6+S6cxn7iGarlJQu1kjyMqmuipItbCxQWqqm
        H1TzHFFaVgvD2tePmUdkAz6I5Q==
X-Google-Smtp-Source: AK7set/JFciJ91x3mcXmcllVskHNA7+J4VSs63iG7Hs1gUFVXHSTpvGL+51eelfHbVutEQceydlhZw==
X-Received: by 2002:a05:622a:28a:b0:3bf:da89:1946 with SMTP id z10-20020a05622a028a00b003bfda891946mr63135622qtw.1.1678810217134;
        Tue, 14 Mar 2023 09:10:17 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:1fe3])
        by smtp.gmail.com with ESMTPSA id l16-20020a05622a175000b003bfa932525dsm2143969qtk.51.2023.03.14.09.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 09:10:16 -0700 (PDT)
Date:   Tue, 14 Mar 2023 12:10:16 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        brauner@kernel.org, chris@chrisdown.name
Subject: Re: [PATCH 0/4] sched/psi: Allow unprivileged PSI polling
Message-ID: <20230314161016.GA12250@cmpxchg.org>
References: <20230309170756.52927-1-cerasuolodomenico@gmail.com>
 <CAJuCfpGYrnCoAn+bUdcEZ3OS+5ujDp2iUNXBMRacxNGbJvCY-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpGYrnCoAn+bUdcEZ3OS+5ujDp2iUNXBMRacxNGbJvCY-w@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2023 at 08:29:37AM -0700, Suren Baghdasaryan wrote:
> On Thu, Mar 9, 2023 at 9:08 AM Domenico Cerasuolo
> <cerasuolodomenico@gmail.com> wrote:
> >
> > PSI offers 2 mechanisms to get information about a specific resource
> > pressure. One is reading from /proc/pressure/<resource>, which gives
> > average pressures aggregated every 2s. The other is creating a pollable
> > fd for a specific resource and cgroup.
> >
> > The trigger creation requires CAP_SYS_RESOURCE, and gives the
> > possibility to pick specific time window and threshold, spawing an RT
> > thread to aggregate the data.
> >
> > Systemd would like to provide containers the option to monitor pressure
> > on their own cgroup and sub-cgroups. For example, if systemd launches a
> > container that itself then launches services, the container should have
> > the ability to poll() for pressure in individual services. But neither
> > the container nor the services are privileged.
> 
> This sounds like an interesting usecase. I'll need to take a closer
> look once I'm back from vacation later this week.
> Thanks!

Thanks, Suren!

There is also the desktop monitoring usecase that Chris Down had
inquired about some while back:

https://lore.kernel.org/all/CAJuCfpGnJBEvQTUeJ_U6+rHmPcMjw_pPL+QFj7Sec5fHZPH67w@mail.gmail.com/T/

The patches should help with that as well.
