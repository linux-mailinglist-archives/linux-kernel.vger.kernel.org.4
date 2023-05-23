Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7808070E106
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 17:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237644AbjEWPwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 11:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235682AbjEWPwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 11:52:06 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3412A91;
        Tue, 23 May 2023 08:52:04 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3BE94139F;
        Tue, 23 May 2023 08:52:49 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C4AC13F840;
        Tue, 23 May 2023 08:52:01 -0700 (PDT)
Date:   Tue, 23 May 2023 16:51:59 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, suzuki.poulose@arm.com,
        Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>,
        Steve Clevenger <scclevenger@os.amperecomputing.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH V4 0/6] coresight: etm4x: Migrate ACPI AMBA devices to
 platform driver
Message-ID: <20230523155159.na2wfhuhb7fqr3cy@bogus>
References: <20230523044553.1525048-1-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230523044553.1525048-1-anshuman.khandual@arm.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 23, 2023 at 10:15:47AM +0530, Anshuman Khandual wrote:
> CoreSight ETM4x devices could be accessed either via MMIO (handled via
> amba_driver) or CPU system instructions (handled via platform driver). But
> this has the following issues :
> 
>   - Each new CPU comes up with its own PID and thus we need to keep on
>     adding the "known" PIDs to get it working with AMBA driver. While
>     the ETM4 architecture (and CoreSight architecture) defines way to
>     identify a device as ETM4. Thus older kernels  won't be able to
>     "discover" a newer CPU, unless we add the PIDs.
> 
>   - With ACPI, the ETM4x devices have the same HID to identify the device
>     irrespective of the mode of access. This creates a problem where two
>     different drivers (both AMBA based driver and platform driver) would
>     hook into the "HID" and could conflict. e.g., if AMBA driver gets
>     hold of a non-MMIO device, the probe fails. If we have single driver
>     hooked into the given "HID", we could handle them seamlessly,
>     irrespective of the mode of access.
> 
>   - CoreSight is heavily dependent on the runtime power management. With
>     ACPI, amba_driver doesn't get us anywhere with handling the power
>     and thus one need to always turn the power ON to use them. Moving to
>     platform driver gives us the power management for free.
> 
> Due to all of the above, we are moving ACPI MMIO based etm4x devices to be
> supported via tha platform driver. The series makes the existing platform
> driver generic to handle both type of the access modes. Although existing
> AMBA driver would still continue to support DT based etm4x MMIO devices.
> Although some problems still remain, such as manually adding PIDs for all
> new AMBA DT based devices.
> 
> The series applies on 6.4-rc3.
> 

Tested on Juno with some hacked up UEFI f/w.

Tested-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep
