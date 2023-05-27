Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3F07132A6
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 07:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbjE0Fpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 01:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjE0Fpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 01:45:34 -0400
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com [IPv6:2607:f8b0:4864:20::a32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52799114;
        Fri, 26 May 2023 22:45:33 -0700 (PDT)
Received: by mail-vk1-xa32.google.com with SMTP id 71dfb90a1353d-45700c4b74dso975113e0c.0;
        Fri, 26 May 2023 22:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685166332; x=1687758332;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PHU0CrQxUv9XQ01EpFpr1GgtiXoO/B7NjDPGrH20JTQ=;
        b=fDez1bv3s5uhmZNuLiXHCHc5QY5B0HRbkIEsMtqx1j8JkSQeuU520jcybL8qT4RfaK
         LsQq5GFzj/jC2895yicg+250RCojIsQhM/UIeCrlD3jNBTkq3SxAatA1Lb0M6D3fo8Ej
         vcwk3oxqzOWX+4NwJIr1ED+6rJw2gC6JzKflX5wM64pb9Jws4M0v6K/8jpS+Ej/6ei9+
         mIvhHov8Rs3KWSrZbbhrJtSAuqy3xgLTLWnf3B3kC4yscDIqLSvXtGV94fv5tssZ3GPz
         JRkqm4BaRAyDif/I1M8B3srFzbk51E7dnRCDsBxwMY0EAZbkoWYG+rAQtG2ANQ1HgCfs
         0xww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685166332; x=1687758332;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PHU0CrQxUv9XQ01EpFpr1GgtiXoO/B7NjDPGrH20JTQ=;
        b=bLhVa8vEKyF0VL2WwegZlDDfOmQN5BI3dn1up4t/QbiAp+FHVLuGUqR0WNi/jjnCH3
         nny7QEe7O8190IEU9kSDwkYu0xMwNXbZpv/MH9OV/TvxVAcuKO7nz4T7er/EAb1xNO6B
         6nC5p7D7C6a7Luy5JwchdW28LiKnRqtAB7ouRT1Yf9EzELy8dzASpV8+yxHDphioG33F
         +mOGG0Eehu2hUYn+48K9rumD7ZGQXDAFLF/W+hl8ex5s/DDuB57q4Kgwtw+/W6BhSmr8
         aOQdsw4dsYbXb2n5aTyE0KBYJCzPhKb4vDGk0WUpeUx6kdEIO3H2O+tSSWRoQlfZis0r
         By1w==
X-Gm-Message-State: AC+VfDwP/JH2JYZsb3kPpKJlBHcwpmAkdbxsY7iouGgCXnfuhc0K2K88
        NHyMsuhdfYL1k887tDNenbfBRjpxP1Sg8PtPei8=
X-Google-Smtp-Source: ACHHUZ6bc/3YatIytTidxgERoKXrdCqaX7PxYV61a63fUCbC5DMt3+kghGZvVo+W4W3fwQ3rwLwGsDuYiWMt/aGFrLg=
X-Received: by 2002:a1f:c144:0:b0:44f:be41:267a with SMTP id
 r65-20020a1fc144000000b0044fbe41267amr444071vkf.13.1685166332147; Fri, 26 May
 2023 22:45:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230413142617.15995-1-Jonathan.Cameron@huawei.com>
 <20230413142617.15995-5-Jonathan.Cameron@huawei.com> <CAM9d7ciPW67QRRwRsY3-ouEM6wM0YdX+qnkkqYmTXRLwJcgqkA@mail.gmail.com>
 <CABPqkBQpXAq=uk5-vx-FkYJV1nrtugit_ExFqGgQCKGQC2no6w@mail.gmail.com> <20230526102428.00002b6a@Huawei.com>
In-Reply-To: <20230526102428.00002b6a@Huawei.com>
From:   Namhyung Kim <namhyung@gmail.com>
Date:   Fri, 26 May 2023 22:45:20 -0700
Message-ID: <CAM9d7cgG8KL=CoEM3E1dXSMsC8RbYnCYQEBQOw3jPLS9YdC5PQ@mail.gmail.com>
Subject: Re: [PATCH v6 4/5] perf: CXL Performance Monitoring Unit driver
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        peterz@infradead.org
Cc:     Stephane Eranian <eranian@google.com>,
        Liang Kan <kan.liang@linux.intel.com>,
        linux-cxl@vger.kernel.org, mark.rutland@arm.com, will@kernel.org,
        mingo@redhat.com, acme@kernel.org, dan.j.williams@intel.com,
        linuxarm@huawei.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 26, 2023 at 2:24=E2=80=AFAM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Thu, 25 May 2023 18:18:55 -0700
> Stephane Eranian <eranian@google.com> wrote:
>
> > On Thu, May 25, 2023 at 6:06=E2=80=AFPM Namhyung Kim <namhyung@gmail.co=
m> wrote:
> > >
> > > Add Stephane to CC.
> > >
> > > On Thu, Apr 13, 2023 at 7:35=E2=80=AFAM Jonathan Cameron
> > > <Jonathan.Cameron@huawei.com> wrote:
> > > >
> > > > CXL rev 3.0 introduces a standard performance monitoring hardware
> > > > block to CXL. Instances are discovered using CXL Register Locator D=
VSEC
> > > > entries. Each CXL component may have multiple PMUs.
> > > >
> > > > This initial driver supports a subset of types of counter.
> > > > It supports counters that are either fixed or configurable, but req=
uires
> > > > that they support the ability to freeze and write value whilst froz=
en.
> > > >
> > > > Development done with QEMU model which will be posted shortly.
> > > >
> > > > Example:
> > > >
> > > > $ perf stat -e cxl_pmu_mem0.0/h2d_req_snpcur/ -e cpmu0/h2d_req_snpd=
ata/ -e cpmu0/clock_ticks/ sleep 1
> > > >
> > > > Performance counter stats for 'system wide':
> > > >
> >
> > Unless I am mistaken, I don't think this output corresponds to the
> > cmdline above. I think the -a is missing.
> > I don't think you can measure CXL traffic per-thread. Please confirm.
> > Thanks.
>
> It doesn't seem to make any difference whether I include -a or not and

Hmm.. strange, I think it'd fail if you don't provide -a option
because the cxl_pmu doesn't allow to attach to a task.


> the perf man page says
>
>        -a, --all-cpus
>            system-wide collection from all CPUs (default if no target is
>            specified)
>
> However I'm not sure what target means in this case as there is no
> mention of it anywhere else in the perf-stat man page.  My guess is threa=
d
> or process provided by -p or -t.  So default applies in the above command=
 line.
> Doesn't hurt to be more explicit though, so I've added -a.

Sorry, the man page was not clear.  The target can be CPUs (-a or -C)
or tasks (-p or -t for existing tasks, command line argument for a
new task).  So in the above example, the target is the sleep process.

The command line argument also controls when to terminate the
profiling session.  So `perf stat -a sleep 1` will collect system-wide
profile (because of the -a option) for 1 second.

I think the default mentioned in the man page is when you run

  $ perf stat

and Ctrl-C to exit.

Thanks,
Namhyung
