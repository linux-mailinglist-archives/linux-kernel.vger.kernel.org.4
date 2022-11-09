Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19F2B623753
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 00:12:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232018AbiKIXME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 18:12:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231786AbiKIXLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 18:11:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38A5B30F5B;
        Wed,  9 Nov 2022 15:11:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DD240B8203E;
        Wed,  9 Nov 2022 23:11:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B15DC433C1;
        Wed,  9 Nov 2022 23:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668035486;
        bh=gTQxZ1egZZFdLRU5hjINvNkzMgHAG+RtZvuMob2tT+Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=tqp2zijGCjx3e4LT1ETg9ytMhBiwUXmObb7RMccEFfWgPld6SmHjyXCkNGpr2hxnZ
         lUiRLwEmN7sHGdtxqfDFPR9+XUtyKUhSpszIx13n8USwk/9KXP9fdxW3RhzKFh/IDz
         DSUWAWXG5WSdDOIHi6wESaYN+FRNs8Bm9IBOwsSVkPokWV4j8DpU6W+iUfU2Wux3cO
         t2mHxjL+XydD8mus/sUQ+8mj21cz//Uy0gIO+tsyf6wxMpPpni6BWwCxC4EB6+UyVU
         jVDAH1wJUgW548yPkLhhQWdNSBVGyps755sr8zU2cMiR7rQxVS73TZf+TI2tWZJA1I
         aBsOlPl4IzHEQ==
Date:   Wed, 9 Nov 2022 17:11:24 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Robert Richter <rrichter@amd.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>
Subject: Re: [PATCH v3 1/9] cxl/acpi: Register CXL host ports by bridge device
Message-ID: <20221109231124.GA581464@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221109104059.766720-2-rrichter@amd.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2022 at 11:40:51AM +0100, Robert Richter wrote:
> A port of a CXL host bridge links to the bridge's acpi device

s/acpi/ACPI/ to match usage below.

> (&adev->dev) with its corresponding uport/dport device (uport_dev and
> dport_dev respectively). The device is not a direct parent device in
> the PCI topology as pdev->dev.parent points to a PCI bridge's (struct
> pci_host_bridge) device. The following CXL memory device hierarchy
> would be valid for an endpoint once an RCD EP would be enabled (note
> this will be done in a later patch):
> 
> VH mode:
> 
>  cxlmd->dev.parent->parent
>         ^^^\^^^^^^\ ^^^^^^\
>             \      \       pci_dev (Type 1, Downstream Port)
>              \      pci_dev (Type 0, PCI Express Endpoint)
>               cxl mem device
> 
> RCD mode:
> 
>  cxlmd->dev.parent->parent
>         ^^^\^^^^^^\ ^^^^^^\
>             \      \       pci_host_bridge
>              \      pci_dev (Type 0, RCiEP)
>               cxl mem device
> 
> In VH mode a downstream port is created by port enumeration and thus
> always exists.
> 
> Now, in RCD mode the host bridge also already exists but it references
> to an ACPI device. A port lookup by the PCI device's parent device
> will fail as a direct link to the registered port is missing. The ACPI
> device of the bridge must be determined first.
> 
> To prevent this, change port registration of a CXL host to use the
> bridge device instead. Do this also for the VH case as port topology
> will better reflect the PCI topology then.
> 
> If a mock device is registered by a test driver, the bridge pointer
> can be NULL. Keep using the matching ACPI device (&adev->dev) as a
> fallback in this case.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
