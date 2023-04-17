Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6C066E4EAC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 18:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbjDQQ5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 12:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjDQQ5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 12:57:01 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D34B1FDE;
        Mon, 17 Apr 2023 09:57:00 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Q0Y4h4QMVz67dxR;
        Tue, 18 Apr 2023 00:52:20 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 17 Apr
 2023 17:56:56 +0100
Date:   Mon, 17 Apr 2023 17:56:55 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Terry Bowman <Terry.Bowman@amd.com>
CC:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <linux-cxl@vger.kernel.org>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: Re: [PATCH v3 4/6] cxl/pci: Add RCH downstream port error logging
Message-ID: <20230417175655.00005d59@Huawei.com>
In-Reply-To: <1552ec3c-fa30-2f2b-c73b-5a9f4cd999be@amd.com>
References: <20230411180302.2678736-1-terry.bowman@amd.com>
        <20230411180302.2678736-5-terry.bowman@amd.com>
        <20230413175043.0000523e@Huawei.com>
        <1552ec3c-fa30-2f2b-c73b-5a9f4cd999be@amd.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> >> +
> >> +	writel(aer_regs->uncor_status, aer_base + PCI_ERR_UNCOR_STATUS);
> >> +	writel(aer_regs->cor_status, aer_base + PCI_ERR_COR_STATUS);
> >> +
> >> +	return true;
> >> +}  
> > =  
> >> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> >> index bde1fffab09e..dfa6fcfc428a 100644
> >> --- a/drivers/cxl/core/regs.c
> >> +++ b/drivers/cxl/core/regs.c
> >> @@ -198,6 +198,7 @@ void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
> >>  
> >>  	return ret_val;
> >>  }
> >> +EXPORT_SYMBOL_NS_GPL(devm_cxl_iomap_block, CXL);
> >>  
> >>  int cxl_map_component_regs(struct device *dev, struct cxl_component_regs *regs,
> >>  			   struct cxl_register_map *map, unsigned long map_mask)
> >> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> >> index df64c402e6e6..dae3f141ffcb 100644
> >> --- a/drivers/cxl/cxl.h
> >> +++ b/drivers/cxl/cxl.h
> >> @@ -66,6 +66,8 @@
> >>  #define CXL_DECODER_MIN_GRANULARITY 256
> >>  #define CXL_DECODER_MAX_ENCODED_IG 6
> >>  
> >> +#define PCI_AER_CAPABILITY_LENGTH 56  
> > 
> > Odd place to find a PCI specific define. Also a spec reference is
> > always good for these.  What's the the length of? PCI r6.0 has
> > cap going up to address 0x5c  so length 0x60.  This seems to be igoring
> > the header log register.
> >  
> 
> This was to avoid including the TLP log at 0x38+.
> 
> I can use sizeof(struct aer_capability_regs) or sizeof(*aer_regs) instead. 
> It's the same 38h(56) and will allow me to remove this #define in the 
> patchset revision.

That works better than a define that people might think is more generic.
Otherwise you get PCI_AER_CAP_WITHOUT_TLP_LOG_LENGTH or
something equally horrible. (or define the TLP_LOG length as another
define and subtract that?)

>  
