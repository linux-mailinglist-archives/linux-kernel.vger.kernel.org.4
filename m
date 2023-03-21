Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A6E66C3451
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 15:34:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231264AbjCUOeG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 10:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbjCUOeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 10:34:03 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 77FA02CFF7;
        Tue, 21 Mar 2023 07:34:01 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2734F2F4;
        Tue, 21 Mar 2023 07:34:45 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 018383F6C4;
        Tue, 21 Mar 2023 07:33:58 -0700 (PDT)
Date:   Tue, 21 Mar 2023 14:33:56 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Rob Herring <robh+dt@kernel.org>
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
Subject: Re: [PATCH 0/7] coresight: etm4x: Migrate AMBA devices to platform
 driver
Message-ID: <20230321143356.w5era7et6lzxpte3@bogus>
References: <20230317030501.1811905-1-anshuman.khandual@arm.com>
 <CAL_JsqKsnq0d-x3m3xQe8m0pnk_Jeh9J1oFBtPAn3LV8-MFH0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqKsnq0d-x3m3xQe8m0pnk_Jeh9J1oFBtPAn3LV8-MFH0w@mail.gmail.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 09:17:16AM -0500, Rob Herring wrote:
>
> This sounds like an issue for any amba driver. If this is an issue,
> solve it for everyone, not just work around it in one driver.
>

Well it is an issue in general for power management. ACPI has specific
methods that can be executed for entering specific states.

The way AMBA was glue into ACPI bus scan IMO was a hack and PM wasn't
considered at the time. It was just hack to get AMBA drivers to work
with ACPI without any consideration about runtime PM or any methods that
comes as part of ACPI device. There is even some dummy clock handler to
deal with AMBA requesting APB clocks. AMBA device is added as companion
to the ACPI device created as part of the normal bus scan in ACPI which
adds its own PM callbacks and rely on clocks and power domains independent
of the ACPI standard methods(_ON/_OFF).

The default enumeration adds platform devices which adds no extra PM
callbacks and allows normal acpi_device probe flow.

> When someone puts another primecell device into an ACPI system, are we
> going to go do the same one-off change in that driver too? (We kind of
> already did with SBSA UART...)
>

I would prefer to move all the existing users of ACPI + AMBA to move away
from it and just use platform device. This list is not big today, bunch
of coresight, PL061/GPIO and PL330/DMA. And all these are assumed to be
working or actually working if there is no need for any power management.
E.g. on juno coresight needs PM to turn on before probing and AMBA fails
as dummy clocks are added but no power domains attached as ACPI doesn't
need deal with power domains in the OSPM if it is all well abstracted in
methods like _ON/_OFF. They are dealt with explicit power domain in the
DT which needs to be turned on and AMBA relies on that.

One possible further hacky solution is to add dummy genpd to satisfy AMBA
but not sure if we can guarantee ordering between ACPI device calling ON
and its companion AMBA device probing so that the power domain is ON before
AMBA uses the dummy clock and power domains in its pm callback hooks.

Even the UART would fail if it needed any PM methods, we just don't happen
to need that for SBSA and may be we could have made it work as amba device
(can't recollect the exact reason for not doing so now).

--
Regards,
Sudeep
