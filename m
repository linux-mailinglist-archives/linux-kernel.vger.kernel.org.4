Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE4B26D02A4
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 13:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbjC3LK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 07:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231384AbjC3LKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 07:10:25 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92D7AB8;
        Thu, 30 Mar 2023 04:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680174624; x=1711710624;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=NxNlRxKsoJQSH8kENdw2Ulaik6LeFrNEZuyYeIOnY98=;
  b=I70KK4B+f8lhlY2/TumsFNKT1n0fPYpjztHF5k32nXAPspgaC4BPo9Fi
   uScjPjn0RqtHiuzfQEu9QS7BNZ1RtoNlcgx9/8MPZHTaUZolYREPmITYH
   b3LaIGxOB/CDEB4bnC+y2+q1RvDgtTfnLclQKXs0tjF2ZJ0LsbkaqDlxu
   GaYGpYWjGuy1VWUd/hMVNRCWD8SmqqH09UV/hf6XDChRlqAeuHqZIf24H
   bZtwfy3tjUW/ZW7jPNzQ/5Fr8VPPf3YEJA4j2OYyfeeXzgBnLIFzFvX80
   9A6tpJ4AmH3TzV4e2wqTZ0iW6RQDsEn03wzHBislw2k1oOymbZnRtrF2T
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="427413972"
X-IronPort-AV: E=Sophos;i="5.98,303,1673942400"; 
   d="scan'208";a="427413972"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 04:10:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="749150470"
X-IronPort-AV: E=Sophos;i="5.98,303,1673942400"; 
   d="scan'208";a="749150470"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by fmsmga008.fm.intel.com with ESMTP; 30 Mar 2023 04:10:22 -0700
Message-ID: <2e727403-a566-8c48-9367-5daa7c87def7@linux.intel.com>
Date:   Thu, 30 Mar 2023 14:11:44 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.7.1
Subject: Re: [PATCH] xhci: use pm_ptr() instead of #ifdef for CONFIG_PM
 conditionals
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Josue David Hernandez Gutierrez 
        <josue.d.hernandez.gutierrez@intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Alan Stern <stern@rowland.harvard.edu>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230328131114.1296430-1-arnd@kernel.org>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <20230328131114.1296430-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.3.2023 16.10, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> A recent patch caused an unused-function warning in builds with
> CONFIG_PM disabled, after the function became marked 'static':
> 
> drivers/usb/host/xhci-pci.c:91:13: error: 'xhci_msix_sync_irqs' defined but not used [-Werror=unused-function]
>     91 | static void xhci_msix_sync_irqs(struct xhci_hcd *xhci)
>        |             ^~~~~~~~~~~~~~~~~~~
> 
> This could be solved by adding another #ifdef, but as there is
> a trend towards removing CONFIG_PM checks in favor of helper
> macros, do the same conversion here and use pm_ptr() to get
> either a function pointer or NULL but avoid the warning.
> 
> As the hidden functions reference some other symbols, make
> sure those are visible at compile time, at the minimal cost of
> a few extra bytes for 'struct usb_device'.
> 
> Fixes: 9abe15d55dcc ("xhci: Move xhci MSI sync function to to xhci-pci")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks for this.
Looks like Greg already picked it.

-Mathias

