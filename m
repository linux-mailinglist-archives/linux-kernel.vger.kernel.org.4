Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F4B3633146
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 01:22:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231909AbiKVAWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 19:22:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231262AbiKVAWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 19:22:02 -0500
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D6889E09F
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 16:22:01 -0800 (PST)
Received: by mail-oo1-xc2c.google.com with SMTP id j6-20020a4ab1c6000000b004809a59818cso2045619ooo.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 16:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8ioT5HWkxXrDzWROXcjL6RfDxD0eZFMTpXcJlr218K8=;
        b=iYjmeDp35xqIzxQZueXI5DTZPLBzYLZ5PAM/AQvCGEF1SjrTAhxQ6zziaTWWvV5ylD
         gm9NdiH5PB24JSy6RsceIWUrOZkmtw1Yn8f+tLuh5EqgCZvzvNDQb4LcyMdSMx85yr42
         aPkH2xlJPnvcO8lJA6xc3okcK5790tK9JWuOU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8ioT5HWkxXrDzWROXcjL6RfDxD0eZFMTpXcJlr218K8=;
        b=YA/0frB2+jwah2gskXgyz1+ebe7wi6p1PifgWf1P7BnGX1X0XIkwDLQ38hLdAw8eGH
         mzcLIx/K1oG9CWLBEUfayMcpt5QtIV4I++oQHmhJW80uuAndJJVO9IHASOO4ok8mi7+a
         lY197Wx0BD+lKhUq5cyI1/wgeHoKHasy5qbz9plW/NbqCKON2G8z491qt16R3cBTsU89
         NwkEfnhsTC1OyD5XuMGimKrI9Z4yijIrtY8swx+38057NalwKXYdnDvUA7blk90bnur+
         q31aksZ1xGnl4/2vY8l8Qx1S0UWcQ1btZV1xDFrVRHirCCWVi9noKBo0Dg5hv+IYK3F/
         wuEg==
X-Gm-Message-State: ANoB5pm10vR9cAHHm4O8BU+eZFVXlZeqJGFxOZq38PXxtqdWNPiWiU6Q
        5UbPRXiE7FGpGAGsV7sHUxuJyKkZHIF+V3ehGtGy
X-Google-Smtp-Source: AA0mqf69iXsrfeMApN6Ed6GVXofzCFLsgz2m/ukM8nkoRc34SK82vu0kCeRUJLZFgn6GaFZOJI/wj/Sa/2LuzKCMrVI=
X-Received: by 2002:a4a:c58a:0:b0:49f:4297:5612 with SMTP id
 x10-20020a4ac58a000000b0049f42975612mr1713954oop.13.1669076520677; Mon, 21
 Nov 2022 16:22:00 -0800 (PST)
MIME-Version: 1.0
References: <20220718170205.2972215-1-atishp@rivosinc.com> <20220718170205.2972215-5-atishp@rivosinc.com>
 <Y2uuQ4wH4dU98K2b@curiosity>
In-Reply-To: <Y2uuQ4wH4dU98K2b@curiosity>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Mon, 21 Nov 2022 16:21:49 -0800
Message-ID: <CAOnJCUJogprsp+D2ZH7yEEPr-LOp801LrYTwjg0EEoKaYfPV-Q@mail.gmail.com>
Subject: Re: [RFC 4/9] RISC-V: KVM: Improve privilege mode filtering for perf
To:     Sergey Matyukevich <geomatsi@gmail.com>
Cc:     Atish Patra <atishp@rivosinc.com>, linux-kernel@vger.kernel.org,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>, Guo Ren <guoren@kernel.org>,
        kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 9, 2022 at 5:42 AM Sergey Matyukevich <geomatsi@gmail.com> wrote:
>
> Hi Atish,
>
> > Currently, the host driver doesn't have any method to identify if the
> > requested perf event is from kvm or bare metal. As KVM runs in HS
> > mode, there are no separate hypervisor privilege mode to distinguish
> > between the attributes for guest/host.
> >
> > Improve the privilege mode filtering by using the event specific
> > config1 field.
>
> ... [snip]
>
> > +static unsigned long pmu_sbi_get_filter_flags(struct perf_event *event)
> > +{
> > +     unsigned long cflags = 0;
> > +     bool guest_events = false;
> > +
> > +     if (event->attr.config1 & RISCV_KVM_PMU_CONFIG1_GUEST_EVENTS)
> > +             guest_events = true;
> > +     if (event->attr.exclude_kernel)
> > +             cflags |= guest_events ? SBI_PMU_CFG_FLAG_SET_VSINH : SBI_PMU_CFG_FLAG_SET_SINH;
>
> IIUC we should inhibit host counting if we want guest events:
>                 cflags |= guest_events ? SBI_PMU_CFG_FLAG_SET_SINH : SBI_PMU_CFG_FLAG_SET_VSINH;
>

guest_events indicate that the user in the guest VM is configured to
exclude the kernel i.e. the guest kernel which
is running in VS mode.
That's why, we have to set  SBI_PMU_CFG_FLAG_SET_VSINH

To inhibit host counting, the user needs to specify exclude_host
and/or exclude_hv which happens below as well.

> > +     if (event->attr.exclude_user)
> > +             cflags |= guest_events ? SBI_PMU_CFG_FLAG_SET_VUINH : SBI_PMU_CFG_FLAG_SET_UINH;
>
> Same here.
>

Same explanation as above.

> > +     if (guest_events && event->attr.exclude_hv)
> > +             cflags |= SBI_PMU_CFG_FLAG_SET_SINH;
> > +     if (event->attr.exclude_host)
> > +             cflags |= SBI_PMU_CFG_FLAG_SET_UINH | SBI_PMU_CFG_FLAG_SET_SINH;
> > +     if (event->attr.exclude_guest)
> > +             cflags |= SBI_PMU_CFG_FLAG_SET_VSINH | SBI_PMU_CFG_FLAG_SET_VUINH;
> > +
> > +     return cflags;
> > +}
>
> Regards,
> Sergey



-- 
Regards,
Atish
