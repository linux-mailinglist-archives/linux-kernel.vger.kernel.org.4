Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D04DD6D58FC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 08:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233586AbjDDGyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 02:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233263AbjDDGym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 02:54:42 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E6212110
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 23:54:41 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id lr16-20020a17090b4b9000b0023f187954acso32976034pjb.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 23:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1680591280;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=X8KDVnrh1hTXgmg9cUX613HBU/NpNhOGn+tvPjKzddU=;
        b=mXZSLWXYtv4n06LIlK6QFnQlklY/sKxaWTQU/vvO7qcfsgXLGGlGcwuCO19fKY6qQy
         efdh/b+0BcOjkIB2FxAoBZJ+N4ssU99ayNpww5SqKt7jOFgp5lClD7Ls81ZUiB3b5/Io
         s1QdUxXGmLS90t3QGktGbGlny60/DldtJ2R9m5GEfPJdo5b1RtLvsnDMEuI+bmuta/qW
         NjubZGOwRTbD/l4rfxV/adLRRcaGNHhIFZOKtewu25VMxkayhdNFMa32IxzRQ+d3k7AQ
         6lI26mcYjTEuZBZnichASEWZZ4Riyn9b6mh0dOzRN51KiyLfvoPGA0q3sr5Jlq2YiUrt
         oC2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680591280;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X8KDVnrh1hTXgmg9cUX613HBU/NpNhOGn+tvPjKzddU=;
        b=ptWqk9O5yGGbw0/RoYRjHhdqvhAEyB2Lzt5OJbo7z+/dQCzNqmlMDLO7HzASv7KdCj
         EdmCt+2E7bbYcfFUVYDD0CuE4Na6jhT7ZOid+xkVRc6qvJVdb8PZPXLhuY6tzyO+y6KE
         oC/DEMZ1NxGf2wub4yLq4TjOHPY3TqyxIXWEziHCCLuVahLZ/XmDakHcopPzyEemeC2o
         qjnvuV8RtLapmWKJFbJJ+0Jqrb4Qun8+hFY/RzJnmR0+c+c4AtavYVQGh2JSnCbDj769
         2OnV2z6wmL0ZHrDhQMUOK6X6bZwPciwrXV5XLVkaYuuIHkQlLEtCroewJzfPG/2XGUI4
         30Bw==
X-Gm-Message-State: AAQBX9d+aCAty6GwtnINfbwfuYLxQ+jnvHiBsDFnPSg3q/ftLUjrJckG
        m5XkbWTzBH8UMNaTTQ1+HQHk2w==
X-Google-Smtp-Source: AKy350YUeMS566kGavT5Mb5UZSOA1ZJfQBdGmEvc/mlk3U8V7ucrzM0EIRt/rKThA++zZN9GdXImaQ==
X-Received: by 2002:a17:902:e494:b0:1a2:952b:27e0 with SMTP id i20-20020a170902e49400b001a2952b27e0mr1572818ple.8.1680591280254;
        Mon, 03 Apr 2023 23:54:40 -0700 (PDT)
Received: from sunil-laptop ([106.51.184.50])
        by smtp.gmail.com with ESMTPSA id h7-20020a170902748700b0019f0ef910f7sm7626350pll.123.2023.04.03.23.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 23:54:39 -0700 (PDT)
Date:   Tue, 4 Apr 2023 12:24:30 +0530
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     Ley Foon Tan <lftan@kernel.org>
Cc:     Conor Dooley <conor@kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-acpi@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-doc@vger.kernel.org, Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Anup Patel <apatel@ventanamicro.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>, llvm@lists.linux.dev
Subject: Re: [PATCH V3 00/20] Add basic ACPI support for RISC-V
Message-ID: <ZCvJpnNZYzrIcfPe@sunil-laptop>
References: <20230303133647.845095-1-sunilvl@ventanamicro.com>
 <16007014-c5f2-4b07-baec-e19952236aa5@spud>
 <ZAbGSA6F0kfv9YYw@sunil-laptop>
 <E7FB4927-1FE6-435A-914E-9615C2AD9D34@kernel.org>
 <a9823561-2e32-49e8-b6c9-73e4b8f8cf8d@spud>
 <ZAfeaO52pnYhiyLN@sunil-laptop>
 <CAFiDJ58bRo6R1qOFaSSNgAdbQJZ3xDY6Wth-t8M8XKRFbig2hA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFiDJ58bRo6R1qOFaSSNgAdbQJZ3xDY6Wth-t8M8XKRFbig2hA@mail.gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 04, 2023 at 02:35:19PM +0800, Ley Foon Tan wrote:
> On Wed, Mar 8, 2023 at 9:08 AM Sunil V L <sunilvl@ventanamicro.com> wrote:
> >
> > On Tue, Mar 07, 2023 at 06:44:35PM +0000, Conor Dooley wrote:
> > > On Tue, Mar 07, 2023 at 06:13:22AM +0000, Conor Dooley wrote:
> > > >
> > > >
> > > > On 7 March 2023 05:06:16 GMT, Sunil V L <sunilvl@ventanamicro.com> wrote:
> > > > >On Mon, Mar 06, 2023 at 09:51:09PM +0000, Conor Dooley wrote:
> > > > >> Hey Sunil,
> > > > >>
> > > > >> On Fri, Mar 03, 2023 at 07:06:27PM +0530, Sunil V L wrote:
> > > > >> > This patch series enables the basic ACPI infrastructure for RISC-V.
> > > > >> > Supporting external interrupt controllers is in progress and hence it is
> > > > >> > tested using poll based HVC SBI console and RAM disk.
> > > > >> >
> > > > >> > The first patch in this series is one of the patch from Jisheng's
> > > > >> > series [1] which is not merged yet. This patch is required to support
> > > > >> > ACPI since efi_init() which gets called before sbi_init() can enable
> > > > >> > static branches and hits a panic.
> > > > >> >
> > > > >> > Patch 2 and 3 are ACPICA patches which are not merged into acpica yet
> > > > >> > but a PR is raised already.
> > > > >> >
> > > > >> > Below are two ECRs approved by ASWG.
> > > > >> > RINTC - https://drive.google.com/file/d/1R6k4MshhN3WTT-hwqAquu5nX6xSEqK2l/view
> > > > >> > RHCT - https://drive.google.com/file/d/1nP3nFiH4jkPMp6COOxP6123DCZKR-tia/view
> > > > >> >
> > > > >> > The series depends on Anup's IPI improvement series [2].
> > > > >> >
> > > > >> > [1] https://lore.kernel.org/all/20220821140918.3613-1-jszhang@kernel.org/
> > > > >> > [2] https://lore.kernel.org/lkml/20230103141221.772261-7-apatel@ventanamicro.com/T/
> > > > >>
> > > > >> Building a clang-15 allmodconfig (I didn't try gcc) with this series, and
> > > > >> Anup's IPI bits, results in a broken build, due to failings in cmpxchg:
> > > > >>
> > > > >> /stuff/linux/drivers/platform/surface/aggregator/controller.c:61:25: error: call to __compiletime_assert_335 declared with 'error' attribute: BUILD_BUG failed
> > > > >>         while (unlikely((ret = cmpxchg(&c->value, old, new)) != old)) {
> > > > >>                                ^
> > >
> > > > > I am able to build without any of these issues using clang-15. I am
> > > > > wondering whether the base is proper. I had rebased on top of the master
> > > > > and couple of patches from IPI series were already merged in the master.
> > > > >
> > > > > Do you mind verifying with my branch
> > > > > https://github.com/vlsunil/linux/commits/acpi_b1_us_review_ipi17_V3?
> > > >
> > > > I can check that later I suppose.
> > >
> > > That's broken too.
> > >
> > > > > Or if you could provide me your branch details, I can look further.
> > > >
> > > > 6.3-rc1, with both series applied, sans Anups applied patches.
> > >
> > > I've pushed my stuff here, but unlikely that it makes any odds since
> > > your branch experiences the same build issue.
> > > https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux.git/ borked-acpi-surface
> > >
> > > My build commands are wrapped in a script, but it's an LLVM=1
> > > allmodconfig run w/ clang-15(.0.7) etc.
> > >
> > Ahh allmodconfig. Thank you very much!. I can reproduce the failure. Let
> > me look further and fix in next revision.
> >
> > Thanks!
> > Sunil
> 
> Hi Sunil
> 
> One question regarding PMU in ACPI flow.
> 
> We use DT to decode the supported HPM counters/events for the
> different platforms now.
> How do we enable PMU (drivers/perf/riscv_pmu_sbi.c) when using ACPI method?
> Note, this might be in separate patch series.
> 
Hi Lay Foon,

This driver uses SBI calls and hence should work in case of ACPI also.

There is one minor change required in this driver for overflow
interrupt. I have a patch for that in future series.

Thanks,
Sunil
