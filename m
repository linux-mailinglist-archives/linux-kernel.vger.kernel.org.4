Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7398873738E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 20:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbjFTSMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 14:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjFTSMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 14:12:48 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A8E0E42
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 11:12:47 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-666fb8b1bc8so3605364b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 11:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20221208.gappssmtp.com; s=20221208; t=1687284767; x=1689876767;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=M7mp7Hge7BhFhWbl2wLz2TaTpzbhGO9QtHjC8KJQMyg=;
        b=JE2LeOwTUmNq80eog+sdQEzgtuu36cY12N5HjxpjmD6ZcygMyYDX6aPaAsdwqxSlfA
         LayA8Vhi/2Ohbywu2kbHHSqoC+4X3esKWxQOEQ48H0kpNxizjVYajmVEtKqe9oUm5guc
         ALNDfNCeN1qitkQWycFlVSKjcJfIcVPSnAzePYXae3kgFIw7+yTLrtZoXKdUXCUBA1Jd
         OTa99XAGGkoZy1Wn8pFK+uJ/SUqrDKzRh4O60fcKMgevC5YzUEwqJwlSnE0DZNAaCBrQ
         X+8DM+CLZAhAMzDU3oC/n6RRCE/V4kXTZkt3mcBpPsDuS1Qk+ZhACd4sf2NtWvBwCDCV
         4zVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687284767; x=1689876767;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M7mp7Hge7BhFhWbl2wLz2TaTpzbhGO9QtHjC8KJQMyg=;
        b=TecioZ7JSIZhtPaJ0K3EopRQijn72wGRKR7lWoPUXoghW3R/wHTqjMYDWmHm3g4rkw
         Tea6kCGWEx0JXILBwZpoY2YsNHzUb/bltMvOpylmocvxyW2hfSyTVv8+xAvPk2RtblS2
         F5YHEoZrWv6bsaViM5hlnjhZNBR3imbghW1D27v/8vLm5MzpSruD1657T6GP3k+irt4T
         og8f3Bv0XR0HX0RZgGGouoWywcpWf/CrIShhpUEoFtYm83ozL9htvjHdsO/iWHpC2jNh
         G8T3oRRHoSjimImtsb/dbCxRbIzR7es3/+9XL/N8nee+HHCHxNG9kd4kZnGr542IwIbx
         VJoA==
X-Gm-Message-State: AC+VfDycPItsqiZfksa4Hx8eGATM9W1GQT1rftTcyEKL9Usf1AKJCbhk
        MLAPCsD1N1SKukRzEOqjqCjU2NAqxjYJnVCsQeU=
X-Google-Smtp-Source: ACHHUZ45DmcrzOxwl7EBr8vFeje5ooUFH86vKLP5QIxK7qIpcWCKuUQbD+Hoo8lGa8XjSb3ymP1yNQ==
X-Received: by 2002:a05:6a00:3983:b0:66a:2ff1:deec with SMTP id fi3-20020a056a00398300b0066a2ff1deecmr1117305pfb.10.1687284766546;
        Tue, 20 Jun 2023 11:12:46 -0700 (PDT)
Received: from telecaster ([2620:10d:c090:400::5:ea8e])
        by smtp.gmail.com with ESMTPSA id x10-20020aa793aa000000b0065c8c5b3a7dsm1664910pff.13.2023.06.20.11.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 11:12:45 -0700 (PDT)
Date:   Tue, 20 Jun 2023 11:12:44 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     "Shenhar, Talel" <talel@amazon.com>
Cc:     linux-debuggers@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Inquiring about Debugging Platform Drivers using Crash Utility
 for Kernel Coredump
Message-ID: <ZJHsHBQOWtvwZXlz@telecaster>
References: <f8f62216-ffaa-2f4e-ac5f-7dcd86e80a84@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f8f62216-ffaa-2f4e-ac5f-7dcd86e80a84@amazon.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2023 at 01:47:10PM +0300, Shenhar, Talel wrote:
> Dear Linux Kernel Community,
> 
> I hope this message finds you well.
> 
> I'd like to use crash utility for postmortem of my kernel coredump analysis.
> 
> I was able to collect coredump and able to use various operation from within
> the crash utility such as irq -s,  log, files and others.
> 
> I am using: crash-arm64 version: 7.3.0, gdb version: 7.6, kernel version
> 4.19.
> 
> My specific interest lies in debugging drivers internal state, e.g. platform
> drivers.
> 
> For some hands-on experience with crash utility I'd like to start by
> iterating over all the platform drivers and print their names,
> 
> However, I am finding it challenging to get started with this process and I
> am uncertain of the best approach to achieve this. I have scoured various
> resources for insights, but the information related to this specific usage
> seems to be scattered and not exhaustive.
> 
> Given the collective expertise on this mailing list, I thought it would be
> the best place to seek guidance. Specifically, I would appreciate it if you
> could provide:
> 
> Any relevant documentation, guides, or tutorials to debug platform drivers
> using the crash utility for kernel coredump analysis.
> Some simple examples of using the crash utility to debug platform drivers,
> if possible.
> Any important points or common pitfalls to keep in mind while performing
> this kind of analysis.
> Any other tips, best practices, or recommendations to effectively debug
> platform drivers using the crash utility would also be greatly appreciated.
> 
> Thank you for your time and assistance. I look forward to hearing from you.

Hi, Talel,

The only thing I have to add to Stephen's excellent answer is my attempt
at getting the information you requested with drgn. I'm not very
familiar with platform drivers, so I basically read the code for
platform_driver_register() and translated the relevant parts to drgn.
Something like this should get you started:

------------------------------------------------------------------------
from drgn import NULL, container_of
from drgn.helpers.linux.list import list_for_each_entry


# This was directly translated from the bus_to_subsys() function in
# drivers/base/bus.c of the Linux kernel. We should probably add it as a
# drgn helper.
def bus_to_subsys(bus):
    for sp in list_for_each_entry(
        "struct subsys_private",
        prog["bus_kset"].list.address_of_(),
        "subsys.kobj.entry",
    ):
        if sp.bus == bus:
            return sp
    return NULL(bus.prog_, "struct subsys_private *")


# Platform drivers are registered to the struct bus_type
# platform_bus_type in drivers/base/platform.c. The struct
# subsys_private has a kset containing a list of drivers.
sp = bus_to_subsys(prog["platform_bus_type"].address_of_())
for priv in list_for_each_entry(
    "struct driver_private", sp.drivers_kset.list.address_of_(), "kobj.entry"
):
    # This is a struct device_driver *.
    driver = priv.driver
    # To get the struct platform_driver *, do:
    # platform_driver = container_of(driver, "struct platform_driver", "driver")
    print(driver.name.string_().decode())
------------------------------------------------------------------------

(I also pushed this script to the contrib directory of the drgn
repository:
https://github.com/osandov/drgn/blob/main/contrib/platform_drivers.py)

On my ARM64 QEMU VM, this prints:

------------------------------------------------------------------------
sbsa-uart
alarmtimer
simple-pm-bus
pci-host-generic
of_fixed_factor_clk
of_fixed_clk
gpio-clk
------------------------------------------------------------------------

Hopefully this helps!
