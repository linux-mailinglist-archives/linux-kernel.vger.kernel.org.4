Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 851F66C6524
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 11:33:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbjCWKdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 06:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbjCWKc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 06:32:28 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD1431BAF9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 03:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679567395; x=1711103395;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gOXFFZe79WcM896xEk4DmyKX6AYQIZBrt1Fiv+yvES0=;
  b=mwB+ct02prEOB0QLNh1O3fkRvDukBQyOKURzIBnuSwQ9HiY9fywuFPsr
   XVl8+NPK0KwezcO5h3hgMy+BOAMFEB4eYr6jtiVGz5/Av0j2SGnWYY8L8
   49tFhM38BTyQq41XYpsvk8aSZYg4voAH0vbwLoSsUYpdhdYpHAl7isztU
   U1+dqFq+QvN3e8JmIK9JBLJgBWoQTlEv3aobGCD/LpyD3oJb93w51VbZf
   lHqiml2fuB6Xeg7an8U/63SIwD7l2QaL8I5uicve5/TNuKqjBZPnv5p4l
   kMi4JFyun+oPq4OB89Xi+zCDv0pxA/nqdqBtn7536G8bDkMV/yK3v/jJZ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="339482252"
X-IronPort-AV: E=Sophos;i="5.98,283,1673942400"; 
   d="scan'208";a="339482252"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2023 03:29:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="825769546"
X-IronPort-AV: E=Sophos;i="5.98,283,1673942400"; 
   d="scan'208";a="825769546"
Received: from joe-255.igk.intel.com (HELO localhost) ([10.91.220.57])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2023 03:29:54 -0700
Date:   Thu, 23 Mar 2023 11:29:52 +0100
From:   Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
To:     Cai Huoqing <cai.huoqing@linux.dev>
Cc:     Oded Gabbay <ogabbay@kernel.org>, Tomer Tayar <ttayar@habana.ai>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] accel/habanalabs: Remove redundant pci_clear_master
Message-ID: <20230323102952.GD2130371@linux.intel.com>
References: <20230323083553.16864-1-cai.huoqing@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230323083553.16864-1-cai.huoqing@linux.dev>
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2023 at 04:35:49PM +0800, Cai Huoqing wrote:
> Remove pci_clear_master to simplify the code,
> the bus-mastering is also cleared in do_pci_disable_device,
> like this:
> ./drivers/pci/pci.c:2197
> static void do_pci_disable_device(struct pci_dev *dev)
> {
> 	u16 pci_command;
> 
> 	pci_read_config_word(dev, PCI_COMMAND, &pci_command);
> 	if (pci_command & PCI_COMMAND_MASTER) {
> 		pci_command &= ~PCI_COMMAND_MASTER;
> 		pci_write_config_word(dev, PCI_COMMAND, pci_command);
> 	}
> 
> 	pcibios_disable_device(dev);
> }.
> And dev->is_busmaster is set to 0 in pci_disable_device.
> 
> Signed-off-by: Cai Huoqing <cai.huoqing@linux.dev>
LGTM

Reviewed-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>

