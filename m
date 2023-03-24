Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39D4D6C8792
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 22:42:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231896AbjCXVmE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 17:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbjCXVmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 17:42:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C88B1B57A;
        Fri, 24 Mar 2023 14:42:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1D4C762C87;
        Fri, 24 Mar 2023 21:42:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 439E3C433D2;
        Fri, 24 Mar 2023 21:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679694121;
        bh=xRa+m0mHGF8D1AxbZaKzDTDZQwY354virrBeCtIyB18=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Y1C0yqHVuhxPHdfidRKUzK0ojng5Vs33q9VzcX+HPooy6IwHpiLex6g5UrEn2/5BL
         ODkgGgWqXgkgXOUOgZg6QXyQk/07XcH+VVcZgM8XeuPsi0XFIEFTxIHINfPX6h3FCP
         mOx5MXWRdC83YI0uKf7h93RRXWndCD0XtiNr+dFg6RBRr7toDpqDDJPpsQcbBR3rg0
         1Z28B42EBITIaMObyiBfUaPz7Drpr+P0Ny29YxizRl4kSjvyEmhT7omtSOEPqTEkvw
         UlRJjxmyHSJlYSD7uImzOUxndnlkq9WhsN3CZOJJZBPjml5Y7sN3iRcs2kbwJ6SSON
         dPgXLxtdnhqfg==
Date:   Fri, 24 Mar 2023 16:41:59 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Terry Bowman <terry.bowman@amd.com>
Cc:     alison.schofield@intel.com, vishal.l.verma@intel.com,
        ira.weiny@intel.com, bwidawsk@kernel.org, dan.j.williams@intel.com,
        dave.jiang@intel.com, Jonathan.Cameron@huawei.com,
        linux-cxl@vger.kernel.org, rrichter@amd.com,
        linux-kernel@vger.kernel.org, bhelgaas@google.com
Subject: Re: [PATCH v2 3/5] pci/aer: Export cper_print_aer() for CXL driver
 logging
Message-ID: <20230324214159.GA2660001@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230323213808.398039-4-terry.bowman@amd.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2023 at 04:38:06PM -0500, Terry Bowman wrote:
> The CXL driver plans to use cper_print_aer() for restricted CXL host
> (RCH) logging. cper_print_aer() is not exported and as a result is not
> available to the CXL driver or other loadable modules. Export
> cper_print_aer() making it available to CXL and other loadable modules.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>
> Cc: "Oliver O'Halloran" <oohall@gmail.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-pci@vger.kernel.org

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

But please update the subject line to:

  PCI/AER: Export cper_print_aer() for use by modules

to match previous history.

> ---
>  drivers/pci/pcie/aer.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 625f7b2cafe4..7f0f52d094a4 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -809,6 +809,7 @@ void cper_print_aer(struct pci_dev *dev, int aer_severity,
>  	trace_aer_event(dev_name(&dev->dev), (status & ~mask),
>  			aer_severity, tlp_header_valid, &aer->header_log);
>  }
> +EXPORT_SYMBOL_GPL(cper_print_aer);
>  #endif
>  
>  /**
> -- 
> 2.34.1
> 
