Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A0AC5F768D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 11:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbiJGJy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 05:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbiJGJyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 05:54:55 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E61722BF8;
        Fri,  7 Oct 2022 02:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665136491; x=1696672491;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vRkZognn5ucEvouezxqb24E7/FQq/pAx1jk5/zfszA4=;
  b=Hff7y4LTn2RCgSoTTQIJBARKYs6KsqHIUHyhu8ktNo5Prl6wlSwNmllJ
   CWm0puOl9f0pjX6ZEYp6xyclL8LkbEH8N5uGPimfrqy+aGXKEGJCr4Fiw
   WDGKMyVcUTn0YCPKNTdfUA/Sdff4rZRPGSv97LCYY8EQUElmbkMXOZCSi
   FxZjWCkvOODA9pg5/RmyhzJ4agIQY57FHGQNEKPrrNyHXZnAciLwHYuV/
   fOB8udAmW97t87F8PRQOpty2krad/SlItGbLR6u6kmoIBM/4Ww+lG1qA4
   7mMob9c9iH9l+pUF2Jt++DHWDh7feFVRxU0C8wWY/dsqcITBlWUWfscy/
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10492"; a="283417868"
X-IronPort-AV: E=Sophos;i="5.95,166,1661842800"; 
   d="scan'208";a="283417868"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2022 02:54:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10492"; a="714222389"
X-IronPort-AV: E=Sophos;i="5.95,166,1661842800"; 
   d="scan'208";a="714222389"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 07 Oct 2022 02:54:45 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id B96AE199; Fri,  7 Oct 2022 12:55:05 +0300 (EEST)
Date:   Fri, 7 Oct 2022 12:55:05 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Mehta Sanju <Sanju.Mehta@amd.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] xhci-pci: Set runtime PM as default policy on all
 xHC 1.2 or later devices
Message-ID: <Yz/3eeVjx8v6/MJe@black.fi.intel.com>
References: <20221006211529.1858-1-mario.limonciello@amd.com>
 <20221006211529.1858-2-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221006211529.1858-2-mario.limonciello@amd.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 06, 2022 at 04:15:28PM -0500, Mario Limonciello wrote:
> -	if (pdev->vendor == PCI_VENDOR_ID_AMD &&
> -	    (pdev->device == PCI_DEVICE_ID_AMD_YELLOW_CARP_XHCI_1 ||
> -	    pdev->device == PCI_DEVICE_ID_AMD_YELLOW_CARP_XHCI_2 ||
> -	    pdev->device == PCI_DEVICE_ID_AMD_YELLOW_CARP_XHCI_3 ||
> -	    pdev->device == PCI_DEVICE_ID_AMD_YELLOW_CARP_XHCI_4 ||
> -	    pdev->device == PCI_DEVICE_ID_AMD_YELLOW_CARP_XHCI_5 ||
> -	    pdev->device == PCI_DEVICE_ID_AMD_YELLOW_CARP_XHCI_6 ||
> -	    pdev->device == PCI_DEVICE_ID_AMD_YELLOW_CARP_XHCI_7 ||
> -	    pdev->device == PCI_DEVICE_ID_AMD_YELLOW_CARP_XHCI_8))

Can you add a comment here explaining why this is OK? I think it is
easier that way to find out why this is here in the future instead of
going through the git blame history.

> +	if (xhci->hci_version >= 0x102)
>  		xhci->quirks |= XHCI_DEFAULT_PM_RUNTIME_ALLOW;
