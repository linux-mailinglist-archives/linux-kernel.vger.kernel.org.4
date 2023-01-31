Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14C34682A4C
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 11:18:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbjAaKSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 05:18:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbjAaKS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 05:18:28 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BD3B44956D;
        Tue, 31 Jan 2023 02:18:21 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3A1BB1713;
        Tue, 31 Jan 2023 02:19:03 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CCFFD3F64C;
        Tue, 31 Jan 2023 02:18:15 -0800 (PST)
Date:   Tue, 31 Jan 2023 10:18:13 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>, abel.vesa@linaro.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        alexander.stein@ew.tq-group.com, andriy.shevchenko@linux.intel.com,
        bigunclemax@gmail.com, brgl@bgdev.pl,
        colin.foster@in-advantage.com, cristian.marussi@arm.com,
        devicetree@vger.kernel.org, dianders@chromium.org,
        djrscally@gmail.com, dmitry.baryshkov@linaro.org,
        festevam@gmail.com, fido_max@inbox.ru, frowand.list@gmail.com,
        geert+renesas@glider.be, geert@linux-m68k.org,
        gregkh@linuxfoundation.org, heikki.krogerus@linux.intel.com,
        jpb@kernel.org, jstultz@google.com, kernel-team@android.com,
        kernel@pengutronix.de, lenb@kernel.org, linus.walleij@linaro.org,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux@roeck-us.net, lkft@linaro.org, luca.weiss@fairphone.com,
        magnus.damm@gmail.com, martin.kepplinger@puri.sm, maz@kernel.org,
        miquel.raynal@bootlin.com, rafael@kernel.org, robh+dt@kernel.org,
        s.hauer@pengutronix.de, sakari.ailus@linux.intel.com,
        shawnguo@kernel.org, tglx@linutronix.de, tony@atomide.com
Subject: Re: [PATCH v2 00/11] fw_devlink improvements
Message-ID: <20230131101813.goaoy32qvrowvyyb@bogus>
References: <20230127001141.407071-1-saravanak@google.com>
 <20230130085542.38546-1-naresh.kamboju@linaro.org>
 <CAGETcx_411fVxsM-ZMK7j2Bvkmi2TKPbzSuD+03M3cb7WKHfJw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGETcx_411fVxsM-ZMK7j2Bvkmi2TKPbzSuD+03M3cb7WKHfJw@mail.gmail.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Saravana,

On Mon, Jan 30, 2023 at 03:03:01PM -0800, Saravana Kannan wrote:
> On Mon, Jan 30, 2023 at 12:56 AM Naresh Kamboju
> <naresh.kamboju@linaro.org> wrote:
> >
> > Build test pass on arm, arm64, i386, mips, parisc, powerpc, riscv, s390, sh,
> > sparc and x86_64.
> >
> > Boot and LTP smoke pass on qemu-arm64, qemu-armv7, qemu-i386 and qemu-x86_64.
> > Boot failed on FVP.
> >
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> >
> > Please refer following link for details of testing.
> > FVP boot log failed.
> > https://qa-reports.linaro.org/~anders.roxell/linux-mainline-patches/build/lore_kernel_org_linux-devicetree_20230127001141_407071-1-saravanak_google_com/testrun/14389034/suite/boot/test/gcc-12-lkftconfig-64k_page_size/details/
>
> Sudeep pointed me to what the issue might be. But it's strange that
> you are hitting an issue now. I'm pretty sure I haven't changed this
> part since v1. I'd also expect the limited assumptions I made to have
> not been affected between v1 and v2.
>

Sorry I hadn't seen or tested v1.

FYI The fwnode non-NULL check as in your nvmem diff/suggestion and the diff I
replied on the gpiolib patch thread fixes the issues.

> Anyway, I'll look at this and fix it in v3.
>

If you add that fwnode check, feel free to add my tested by.

--
Regards,
Sudeep
