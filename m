Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 317E65FABD0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 07:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbiJKFLB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 01:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiJKFK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 01:10:58 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4B8A74343;
        Mon, 10 Oct 2022 22:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665465057; x=1697001057;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aQNzDfDp8mqNrkx7T0F2ckS2QsSrK11O/2zsjxMan80=;
  b=KbozFVUYSs+j3cG6Q8KzrnjxuamqV3sMhB873plqbHaHJAp2a6XgryTd
   E90sXHDUx5SlueomUuJeYA2vP9ewO0d38kyUt9yC8fVeXavp5bubYwtma
   lqoe3x2aaHtSZ6k/aB7pRBeedJ9Nj89bHqZMDLLcT88Y+2/5o5U6lqw+H
   o79VlWk37QYTWHARKVfj/rZDZgkqhbq3Rn0VZTJlo+n9g51bSmk3PFsiY
   7/xBzsrybzy0ItOSwP8bu77SuoTci+/gr7pQMHs/L25kx4YdccGH6SKGm
   d98XY1bR8PV8zd+ppTFHwpkzSk/Wg5rAA+ijxFA9OWRcsta1S62F0wEUS
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="390717257"
X-IronPort-AV: E=Sophos;i="5.95,175,1661842800"; 
   d="scan'208";a="390717257"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2022 22:10:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="751606915"
X-IronPort-AV: E=Sophos;i="5.95,175,1661842800"; 
   d="scan'208";a="751606915"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 10 Oct 2022 22:10:54 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id DC5231C8; Tue, 11 Oct 2022 08:11:14 +0300 (EEST)
Date:   Tue, 11 Oct 2022 08:11:14 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Mehta Sanju <Sanju.Mehta@amd.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] xhci-pci: Set runtime PM as default policy on all xHC
 1.2 or later devices
Message-ID: <Y0T68lC6bUY7dg7D@black.fi.intel.com>
References: <20221010160022.647-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221010160022.647-1-mario.limonciello@amd.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 10, 2022 at 11:00:21AM -0500, Mario Limonciello wrote:
> For optimal power consumption of USB4 routers the XHCI PCIe endpoint
> used for tunneling must be in D3.  Historically this is accomplished
> by a long list of PCIe IDs that correspond to these endpoints because
> the xhci_hcd driver will not default to allowing runtime PM for all
> devices.
> 
> As both AMD and Intel have released new products with new XHCI controllers
> this list continues to grow. In reviewing the XHCI specification v1.2 on
> page 607 there is already a requirement that the PCI power management
> states D3hot and D3cold must be supported.
> 
> In the quirk list, use this to indicate that runtime PM should be allowed
> on XHCI controllers. The following controllers are known to be xHC 1.2 and
> dropped explicitly:
> * AMD Yellow Carp
> * Intel Alder Lake
> * Intel Meteor Lake
> * Intel Raptor Lake
> 
> Suggested-by: Mathias Nyman <mathias.nyman@linux.intel.com>
> Link: https://www.intel.com/content/dam/www/public/us/en/documents/technical-specifications/extensible-host-controler-interface-usb-xhci.pdf
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
