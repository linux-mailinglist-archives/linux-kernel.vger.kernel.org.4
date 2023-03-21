Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA44D6C367B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 17:02:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbjCUQCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 12:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231433AbjCUQCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 12:02:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ED0816893;
        Tue, 21 Mar 2023 09:02:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C59F1B817AC;
        Tue, 21 Mar 2023 16:02:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C845C4339E;
        Tue, 21 Mar 2023 16:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679414564;
        bh=StOHEPmor4jYKvr+q4St39xCQUBPMkifFyG37jrsrNQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=eGlPJEUGU8PKFGYQnnIQI/qsm78RQx68SkCCpD1yu44YkWdpakfLzyFV7I7oVuTti
         /m6UNU4xqtyZbr1qLENAv9Y6lz1Ht/t2VJkhQOYefW/ahTv5uwveDLzyPl9nTITD5q
         A/dlBXMGC3e9ckW3PP7NJq3t+PXI7YeBEQcYa02huNYj1Docp5NVAII4JsilVQiG19
         StQLVn0Xm5io2fbrGiSdzf5vGjN0Djt4+nOU6SiOk/Eo6rKiTj6PNIeXiKEFOTmDNC
         VJv7U4Ya3QJql6UWlPpkcexvKv4gTpVHfl3cc37eyKj6Tj/UsuaAcl8LDafpqBWwf4
         4m18toKCYJI3w==
Received: by mail-yb1-f169.google.com with SMTP id y5so17751019ybu.3;
        Tue, 21 Mar 2023 09:02:44 -0700 (PDT)
X-Gm-Message-State: AAQBX9cbGBmCbk8rlYhFnhMl1x/8SgWRHOaUoyKdRhLfH4/CIvnIik4h
        BnXEziKmcMm4Q7ZK86x9ZkCfiIJKpI/fmhxnlg==
X-Google-Smtp-Source: AKy350Znf5nfgXC5pAz/FzEgm8ixvOwGbBCNSV3kCkz2S7tE88NH6KVsczZv5n55zuXpUgoXBHA6SOIgtC3TZvoykbw=
X-Received: by 2002:a05:6902:1083:b0:98e:6280:74ca with SMTP id
 v3-20020a056902108300b0098e628074camr1884852ybu.1.1679414563294; Tue, 21 Mar
 2023 09:02:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230317030501.1811905-1-anshuman.khandual@arm.com>
 <CAL_JsqKsnq0d-x3m3xQe8m0pnk_Jeh9J1oFBtPAn3LV8-MFH0w@mail.gmail.com> <20230321143356.w5era7et6lzxpte3@bogus>
In-Reply-To: <20230321143356.w5era7et6lzxpte3@bogus>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 21 Mar 2023 11:02:31 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJJZC8AqjpUuK_Z0Nauc1Z-MAKH7ZbXCJrSguUvw70+7Q@mail.gmail.com>
Message-ID: <CAL_JsqJJZC8AqjpUuK_Z0Nauc1Z-MAKH7ZbXCJrSguUvw70+7Q@mail.gmail.com>
Subject: Re: [PATCH 0/7] coresight: etm4x: Migrate AMBA devices to platform driver
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        suzuki.poulose@arm.com, scclevenger@os.amperecomputing.com,
        Frank Rowand <frowand.list@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 9:34=E2=80=AFAM Sudeep Holla <sudeep.holla@arm.com>=
 wrote:
>
> On Mon, Mar 20, 2023 at 09:17:16AM -0500, Rob Herring wrote:
> >
> > This sounds like an issue for any amba driver. If this is an issue,
> > solve it for everyone, not just work around it in one driver.
> >
>
> Well it is an issue in general for power management. ACPI has specific
> methods that can be executed for entering specific states.
>
> The way AMBA was glue into ACPI bus scan IMO was a hack and PM wasn't
> considered at the time. It was just hack to get AMBA drivers to work
> with ACPI without any consideration about runtime PM or any methods that
> comes as part of ACPI device. There is even some dummy clock handler to
> deal with AMBA requesting APB clocks. AMBA device is added as companion
> to the ACPI device created as part of the normal bus scan in ACPI which
> adds its own PM callbacks and rely on clocks and power domains independen=
t
> of the ACPI standard methods(_ON/_OFF).

I thought only DT had hacks... ;)

> The default enumeration adds platform devices which adds no extra PM
> callbacks and allows normal acpi_device probe flow.
>
> > When someone puts another primecell device into an ACPI system, are we
> > going to go do the same one-off change in that driver too? (We kind of
> > already did with SBSA UART...)
> >
>
> I would prefer to move all the existing users of ACPI + AMBA to move away
> from it and just use platform device. This list is not big today, bunch
> of coresight, PL061/GPIO and PL330/DMA. And all these are assumed to be
> working or actually working if there is no need for any power management.
> E.g. on juno coresight needs PM to turn on before probing and AMBA fails
> as dummy clocks are added but no power domains attached as ACPI doesn't
> need deal with power domains in the OSPM if it is all well abstracted in
> methods like _ON/_OFF. They are dealt with explicit power domain in the
> DT which needs to be turned on and AMBA relies on that.
>
> One possible further hacky solution is to add dummy genpd to satisfy AMBA
> but not sure if we can guarantee ordering between ACPI device calling ON
> and its companion AMBA device probing so that the power domain is ON befo=
re
> AMBA uses the dummy clock and power domains in its pm callback hooks.

What if we made AMBA skip its usual matching by ID and only use
DT/ACPI style matching? We have specific compatibles, but they have
never been used by the kernel. The only reason the bus code needs to
do PM is reading the IDs which could be pushed into the drivers that
need to match on specific IDs (I suspect we have some where the
compatible is not specific enough (old ST stuff)).

Looks like we only have 2 platforms left not using DT:
arch/arm/mach-ep93xx/core.c:    amba_device_register(&uart1_device,
&iomem_resource);
arch/arm/mach-ep93xx/core.c:    amba_device_register(&uart2_device,
&iomem_resource);
arch/arm/mach-ep93xx/core.c:    amba_device_register(&uart3_device,
&iomem_resource);
arch/arm/mach-s3c/pl080.c:
amba_device_register(&s3c64xx_dma0_device, &iomem_resource);
arch/arm/mach-s3c/pl080.c:
amba_device_register(&s3c64xx_dma1_device, &iomem_resource);

Get rid of these cases and we don't have to worry about non-DT or ACPI matc=
hing.

> Even the UART would fail if it needed any PM methods, we just don't happe=
n
> to need that for SBSA and may be we could have made it work as amba devic=
e
> (can't recollect the exact reason for not doing so now).

SBSA doesn't require ID registers. SBSA UART is a "great" example of
none of the existing 2 standards work, so let's create a 3rd.

Rob
