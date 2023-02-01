Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4157068616B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 09:16:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232093AbjBAIQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 03:16:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbjBAIQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 03:16:48 -0500
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8E965D11D
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 00:16:46 -0800 (PST)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-4c131bede4bso235777647b3.5
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 00:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=w+WTgqSycW+YwdyyFHzyNDS1ahRVRlExnQu6jqzgcxA=;
        b=f/bYjzCozcQybMWzR7nGgOr7h+cRs8QusGTOsoqpbNgzYXYAiv2M0lVw1YeFT8QdTA
         m+ER3t091N1c7bjh3+h3bpSkSYnK0eIi5oW9LEQ9fwN0bDVEtNYBvzqm0RerlxhiBdft
         mqiZVyQXi8n/8pZ3oUhSD6JqcXvz3zlVOmYovJxfsVPlatsfHFl7kyo3W/eePfzW2/Xl
         Pkt9/zvqG6uYSjyJOQKU30VHObN2rAc8jQDMDBknpFCkB9/PRoJnhpnpKHu394yYtA8w
         oiT9cmDWCQVLu7OpJlDjiYUIp2WNYm91VfWxoZY0Skhoi69Nr0w8bVOyB+ext/awmQeu
         X22w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w+WTgqSycW+YwdyyFHzyNDS1ahRVRlExnQu6jqzgcxA=;
        b=tK3VrlXj0NeSgddmvf9r3XDKJT5eL3PxlWhap3nWieuXeSuYYBTAP1h8xQ68UBoMGv
         skxYX9bHebxlgndcnygw741uz8QyXOSFiDsxKw0K9XqJK8wXbsopznql4N6a9luql5+h
         1+mQDMJ7brdDkM2YskhovS3RrcQcS+TkrPzmtux6dLrZXwJHZlidcuCmC1lPj1OVcifx
         5YRhv1f2F19Mz2Tm6y2brXSlNr/CDBcIPySvP0vCDCzG3bvPFCw2W7SbBZM6SIaUUcp4
         E/bypZpr5VqOSkrEZPDAmGzkaz9lke7FmQc1hcBJpNWJfzsjZdKPOA6FUYFUVPuCvm/m
         3MAg==
X-Gm-Message-State: AO0yUKXq7wm1ZttfcyOCUDj3TrgIWutLlhqoLO64wC2s/WT6pWWZse1z
        1KcTuVCUAgz4SyFYOtEvpeDFEvtmwbSmxcPrdGkw
X-Google-Smtp-Source: AK7set+theTnwE00kW19ZCesKtYS1cSJ1m2dS3+7cdOsE0cPll/6nx2B7R4+nCNkvlrk9lzH2qEY6ESPEQ7v7TUserU=
X-Received: by 2002:a81:e405:0:b0:506:6e0b:7441 with SMTP id
 r5-20020a81e405000000b005066e0b7441mr176361ywl.208.1675239405679; Wed, 01 Feb
 2023 00:16:45 -0800 (PST)
MIME-Version: 1.0
References: <20221101222520.never.109-kees@kernel.org> <20221101223321.1326815-5-keescook@chromium.org>
 <CAMSo37W3gRkP02tSCxGX71ZDAt3WgPZrkTRTM6J1iQ4gvUS9vg@mail.gmail.com> <CANDhNCogJrvt=yEXFK-xVmGjkcRxSNGZUqUeNw2MV9bFRrwPdQ@mail.gmail.com>
In-Reply-To: <CANDhNCogJrvt=yEXFK-xVmGjkcRxSNGZUqUeNw2MV9bFRrwPdQ@mail.gmail.com>
From:   John Stultz <jstultz@google.com>
Date:   Wed, 1 Feb 2023 00:16:34 -0800
Message-ID: <CANDhNCqHDJyj4-t5iMH1zDw6VKNUu5Fk-AzjvfV=DgqGVrF3KA@mail.gmail.com>
Subject: Re: [PATCH 5/6] driver core: Add __alloc_size hint to devm allocators
To:     Yongqin Liu <yongqin.liu@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Nishanth Menon <nm@ti.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Won Chung <wonchung@google.com>,
        David Gow <davidgow@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-hardening@vger.kernel.org,
        llvm@lists.linux.dev, Sumit Semwal <sumit.semwal@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 1, 2023 at 12:11 AM John Stultz <jstultz@google.com> wrote:
> On Tue, Jan 31, 2023 at 11:36 PM Yongqin Liu <yongqin.liu@linaro.org> wrote:
> >
> > Hi, Kees
> >
> > This change causes "Kernel panic - not syncing: BRK handler: Fatal exception"
> > for the android-mainline based hikey960 build, with this commit reverted,
> > there is no problem for the build to boot to the homescreen.
> > Not sure if you have any idea about it and give some suggestions.
> >
> > Here is part of the kernel panic log:
> >
> >     [    9.479878][  T122] ueventd: Loading module
> > /vendor/lib/modules/spi-pl022.ko with args ''
> >     [    9.480276][  T115] apexd-bootstrap: Pre-allocated loop device 29
> >     [    9.480517][  T123] ueventd: LoadWithAliases was unable to load
> > of:Nhi3660_i2sT(null)Chisilicon,hi3660-i2s-1.0
> >     [    9.480632][  T121] Unexpected kernel BRK exception at EL1
> >     [    9.480637][  T121] Internal error: BRK handler:
> > 00000000f2000001 [#1] PREEMPT SMP
> >     [    9.480644][  T121] Modules linked in: cpufreq_dt(E+)
> > hisi_thermal(E+) phy_hi3660_usb3(E) btqca(E) hi6421_pmic_core(E)
> > btbcm(E) spi_pl022(E) hi3660_mailbox(E) i2c_designware_platform(E)
> > mali_kbase(OE) dw_mmc_k3(E) bluetooth(E) dw_mmc_pltfm(E) dw_mmc(E)
> > kirin_drm(E) rfkill(E) kirin_dsi(E) i2c_designware_core(E) k3dma(E)
> > drm_dma_helper(E) cma_heap(E) system_heap(E)
> >     [    9.480688][  T121] CPU: 4 PID: 121 Comm: ueventd Tainted: G
> >        OE      6.2.0-rc6-mainline-14196-g1d9f94ec75b9 #1
> >     [    9.480694][  T121] Hardware name: HiKey960 (DT)
> >     [    9.480697][  T121] pstate: 20400005 (nzCv daif +PAN -UAO -TCO
> > -DIT -SSBS BTYPE=--)
> >     [    9.480703][  T121] pc : hi3660_thermal_probe+0x6c/0x74 [hisi_thermal]
> >     [    9.480722][  T121] lr : hi3660_thermal_probe+0x38/0x74 [hisi_thermal]
> >     [    9.480733][  T121] sp : ffffffc00aa13700
> >     [    9.480735][  T121] x29: ffffffc00aa13700 x28: 0000007ff8ae8531
> > x27: 00000000000008c0
> >     [    9.480743][  T121] x26: ffffffc00aa2a300 x25: ffffffc00aa2ab40
> > x24: 000000000000001d
> >     [    9.480749][  T121] x23: ffffffc00a29d000 x22: 0000000000000000
> > x21: ffffff8001fa4a80
> >     [    9.480755][  T121] x20: 0000000000000001 x19: ffffff8001fa4a80
> > x18: ffffffc00a8810b0
> >     [    9.480761][  T121] x17: 000000007ab542f2 x16: 000000007ab542f2
> > x15: ffffffc00aa01000
> >     [    9.480767][  T121] x14: ffffffc00966f250 x13: ffffffc0b58f9000
> > x12: ffffffc00a055f10
> >     [    9.480771][  T123] ueventd: LoadWithAliases was unable to load
> > cpu:type:aarch64:feature:,0000,0001,0002,0003,0004,0005,0006,0007,000B
> >     [    9.480773][  T121]
> >     [    9.480774][  T121] x11: 0000000000000000 x10: 0000000000000001
> > x9 : 0000000100000000
> >     [    9.480780][  T123] ueventd:
> >     [    9.480780][  T121] x8 : ffffffc0044154cb x7 : 0000000000000000
> > x6 : 000000000000003f
> >     [    9.480786][  T121] x5 : 0000000000000020 x4 : ffffffc0098db323
> > x3 : ffffff801aeb62c0
> >     [    9.480792][  T121] x2 : ffffff801aeb62c0 x1 : 0000000000000000
> > x0 : ffffff8001fa4c80
> >     [    9.480798][  T121] Call trace:
> >     [    9.480801][  T121]  hi3660_thermal_probe+0x6c/0x74 [hisi_thermal]
> >     [    9.480813][  T121]  hisi_thermal_probe+0xbc/0x284 [hisi_thermal]
>
>
> Taking a look here, it looks pretty obvious:
>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/thermal/hisi_thermal.c#n414
>
> data->nr_sensors = 1;
> data->sensor = devm_kzalloc(dev, sizeof(*data->sensor) *
>    data->nr_sensors, GFP_KERNEL);
>
> Here as nr_sensors=1, we allocate only one structure for the array.
> But then below that, we modify two entries, writing past the valid
> array, and corrupting data when writing the second sensor values.
>
> data->sensor[0].id = HI3660_BIG_SENSOR;
> data->sensor[0].irq_name = "tsensor_a73";
> data->sensor[0].data = data;
>
> data->sensor[1].id = HI3660_LITTLE_SENSOR;
> data->sensor[1].irq_name = "tsensor_a53";
> data->sensor[1].data = data;
>
> I suspect nr_sensors needs to be set to 2.

Looks like the bug was introduced here:
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7d3a2a2bbadb4bf5856ed394ba09b8fbb7a80460

But that change seems to imply the dual zones weren't fully supported
at the time. I'm not sure if that's changed in the meantime, so
removing the second sensor writes may potentially be a better fix.

thanks
-john
