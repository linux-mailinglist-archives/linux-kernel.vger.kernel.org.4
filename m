Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 761826C4D0C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 15:08:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbjCVOIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 10:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231332AbjCVOIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 10:08:18 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE37351C83
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 07:08:11 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id jl13so12185372qvb.10
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 07:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679494090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lvCFOq9fKW00r1IpstANHOSKK4Phqzk0S4NhhOp89zc=;
        b=mu4jN/jQH85RkPCRcT6hRxvGoiz0PFJHwP1g/VQgtDQkTk5wUBxBkXYS3FEDPkjPRB
         /487N3pC5jXT9Vz42AwictF4U9E0Ek3sVAhM6NiXYnObOR2EzEkda4YTucyO18pa8KYr
         A82QZOK8rNYF5UW7MoPRg4KqV4xLsMFDzE6w9JEV94iWE43WUp0WNcrlBuM1HZoinmrY
         ISj3SQFDtbdI1OdxwxMbnJGE3UPpqSjQUQFgL7aL7IYPwDnkDGZs9cKki2DfA0MMEkjL
         WrHFvkxfcWbnDeRWcFsdkTzAx9qW8kXfhlYXPctOJu+q1XR3jPrTcYjE+UZAklpjl09B
         8tzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679494090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lvCFOq9fKW00r1IpstANHOSKK4Phqzk0S4NhhOp89zc=;
        b=CAveqrIwa+MYg4B6m7E+hgCwCqvt50Zihyf5+0hc9XT8aY7Ge6xooR9anMpJmCbzfs
         Or7tIsS3EwtjfLbzzbYi5eSA7XGn5CoWe4imV+TgzCJd3Vb2Rxd3PxDghzCNvueamtAY
         m/L0dw2pH9nEypPbEXCCKj+ublV+Mi/AAmQk99SXB5YVZ9zzYdIMI+XM8ouT54S3b5zW
         xws/X4wST+k0BHezh2MC00gG/NO/UbRQ6KJgA8e4PLUlvTcmjHDI/N96y1JZ0HZQ8FBi
         k5xeAVXzLz/EKo7KftOkCAROCf5LU4ihtj+oXioHX3x9lsAmLFtKXvyJ961iSeWbd7NA
         RhZQ==
X-Gm-Message-State: AO0yUKUvwsR6kWdCIxLtxsHw9RWZd96AFb344d+syM6VI4fGv81KCrwH
        UaeQTcNM7oxsI4uPK2hVCIBumvtgS3GMd+1AvYoy8w==
X-Google-Smtp-Source: AK7set94uO8JOul1kgpX5ATBARFVd9wAjqSi2jIBiBUNgq4sOu1g2uq9mq41BCGoQwQ+YIG4wDLjzjmdW4YAEJNIZJA=
X-Received: by 2002:a05:6214:5650:b0:56e:ac29:dc16 with SMTP id
 mh16-20020a056214565000b0056eac29dc16mr739779qvb.9.1679494090188; Wed, 22 Mar
 2023 07:08:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230320172620.18254-1-james.morse@arm.com> <20230320172620.18254-10-james.morse@arm.com>
In-Reply-To: <20230320172620.18254-10-james.morse@arm.com>
From:   Peter Newman <peternewman@google.com>
Date:   Wed, 22 Mar 2023 15:07:59 +0100
Message-ID: <CALPaoCgXYBphe+toVBmF6eGKz8sCHYsaTvvd5ZnrJBf07tjbzg@mail.gmail.com>
Subject: Re: [PATCH v3 09/19] x86/resctrl: Queue mon_event_read() instead of
 sending an IPI
To:     James Morse <james.morse@arm.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        shameerali.kolothum.thodi@huawei.com,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        carl@os.amperecomputing.com, lcherian@marvell.com,
        bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
        xingxin.hx@openanolis.org, baolin.wang@linux.alibaba.com,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On Mon, Mar 20, 2023 at 6:27=E2=80=AFPM James Morse <james.morse@arm.com> w=
rote:
>
> x86 is blessed with an abundance of monitors, one per RMID, that can be

As I explained earlier, this is not the case on AMD.

> read from any CPU in the domain. MPAMs monitors reside in the MMIO MSC,
> the number implemented is up to the manufacturer. This means when there a=
re
> fewer monitors than needed, they need to be allocated and freed.
>
> Worse, the domain may be broken up into slices, and the MMIO accesses
> for each slice may need performing from different CPUs.
>
> These two details mean MPAMs monitor code needs to be able to sleep, and
> IPI another CPU in the domain to read from a resource that has been slice=
d.

This doesn't sound very convincing. Could mon_event_read() IPI all the
CPUs in the domain? (after waiting to allocate and install monitors
when necessary?)


>
> mon_event_read() already invokes mon_event_count() via IPI, which means
> this isn't possible. On systems using nohz-full, some CPUs need to be
> interrupted to run kernel work as they otherwise stay in user-space
> running realtime workloads. Interrupting these CPUs should be avoided,
> and scheduling work on them may never complete.
>
> Change mon_event_read() to pick a housekeeping CPU, (one that is not usin=
g
> nohz_full) and schedule mon_event_count() and wait. If all the CPUs
> in a domain are using nohz-full, then an IPI is used as the fallback.
>
> This function is only used in response to a user-space filesystem request
> (not the timing sensitive overflow code).
>
> This allows MPAM to hide the slice behaviour from resctrl, and to keep
> the monitor-allocation in monitor.c.

This goal sounds more likely.

If it makes the initial enablement smoother, then I'm all for it.

Reviewed-By: Peter Newman <peternewman@google.com>

These changes worked fine for me on tip/master, though there were merge
conflicts to resolve.

Tested-By: Peter Newman <peternewman@google.com>

Thanks!

-Peter
