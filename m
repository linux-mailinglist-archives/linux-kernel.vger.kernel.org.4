Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7D863C6DC
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 18:54:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236554AbiK2Ryn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 12:54:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233312AbiK2Ryd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 12:54:33 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0888D27140
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 09:54:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669744473; x=1701280473;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eWmuqTFqNsAoet0OLkvih5/7bcZ+zSGLf0yM6dcoYG4=;
  b=QQa281WG+hzqaYQRO/sqRwZoXWZDu61ChX4WuwCpuGlm1XXQQZi1U2XR
   yAxhSlsb7djzk4HqD2030kBT3hJPmzKe+RhUPjc9qrpip0d+8wHUdlWLN
   XXtEhrgkqBYtWZ0/N5AQN5bx+DvspRqW3HxlG8Iy1Jb8ZlgYJwMaOWfPp
   lfga5U5ybzIA5hOEKpo9invWTDrGpi1HbZ1MceSAN8hCL5YfMNEUGh/SS
   6AXRWMxQl+RTS7ZVEVwSGnE1nO7WIycpdMCxXxVGQPGMxTT/ZUvWyd0EK
   wsw+9IpKbD/YezgFP1NSYXzGDq3gxKTKgYAa+qMIGr//1ysj2WmLLz/Hp
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="294879775"
X-IronPort-AV: E=Sophos;i="5.96,204,1665471600"; 
   d="scan'208";a="294879775"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2022 09:54:32 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="732650483"
X-IronPort-AV: E=Sophos;i="5.96,204,1665471600"; 
   d="scan'208";a="732650483"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2022 09:54:32 -0800
Date:   Tue, 29 Nov 2022 09:58:23 -0800
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Luo, Yuzhang" <yuzhang.luo@intel.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v2] iommu/vt-d: Add a fix for devices need extra dtlb
 flush
Message-ID: <20221129095823.3009552a@jacob-builder>
In-Reply-To: <BL1PR11MB52716203AF9CC7CADDAC0B4D8C129@BL1PR11MB5271.namprd11.prod.outlook.com>
References: <20221128170410.3830605-1-jacob.jun.pan@linux.intel.com>
        <BL1PR11MB52716203AF9CC7CADDAC0B4D8C129@BL1PR11MB5271.namprd11.prod.outlook.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kevin,

On Tue, 29 Nov 2022 02:37:45 +0000, "Tian, Kevin" <kevin.tian@intel.com>
wrote:

> > From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Sent: Tuesday, November 29, 2022 1:04 AM
> >
> > +void quirk_dev_tlb(struct device_domain_info *info, unsigned long
> > address,
> > +		   unsigned long mask, u32 pasid, u16 qdep)  
> 
> quirk_extra_dtlb_flush()
> 
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
will do in the next version!

Thanks,

Jacob
