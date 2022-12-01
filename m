Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3698263F1A9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 14:30:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbiLANap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 08:30:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbiLANai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 08:30:38 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ABABAB006;
        Thu,  1 Dec 2022 05:30:36 -0800 (PST)
Received: from frapeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NNH1X1gN1z682sK;
        Thu,  1 Dec 2022 21:27:28 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 frapeml500005.china.huawei.com (7.182.85.13) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 1 Dec 2022 14:30:34 +0100
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 1 Dec
 2022 13:30:34 +0000
Date:   Thu, 1 Dec 2022 13:30:33 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     <ira.weiny@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        "Vishal Verma" <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH V2 04/11] cxl/mem: Clear events on driver load
Message-ID: <20221201133033.0000090f@Huawei.com>
In-Reply-To: <20221201002719.2596558-5-ira.weiny@intel.com>
References: <20221201002719.2596558-1-ira.weiny@intel.com>
        <20221201002719.2596558-5-ira.weiny@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Nov 2022 16:27:12 -0800
ira.weiny@intel.com wrote:

> From: Ira Weiny <ira.weiny@intel.com>
> 
> The information contained in the events prior to the driver loading can
> be queried at any time through other mailbox commands.
> 
> Ensure a clean slate of events by reading and clearing the events.  The
> events are sent to the trace buffer but it is not anticipated to have
> anyone listening to it at driver load time.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Probably not worth addressing but there is a corner case where this might fail
if some broken software already messed with reading out the events.

Imagine it read the first mailbox sized chunk, but didn't clear them...

If that happens, then we'd end up seeing the whole list, but in non
temporal order and hence trying to clear them out of order with predictable
fails.

Maybe this is the category of things we 'fix' if we ever hear of it actually
happening.

So with that caveat called out so I can say 'I told you so' :), fine to keep my tag on this.

Thanks,

Jonathan


> ---
>  drivers/cxl/pci.c            | 2 ++
>  tools/testing/cxl/test/mem.c | 2 ++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 8f86f85d89c7..11e95a95195a 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -521,6 +521,8 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	if (IS_ERR(cxlmd))
>  		return PTR_ERR(cxlmd);
>  
> +	cxl_mem_get_event_records(cxlds);
> +
>  	if (resource_size(&cxlds->pmem_res) && IS_ENABLED(CONFIG_CXL_PMEM))
>  		rc = devm_cxl_add_nvdimm(&pdev->dev, cxlmd);
>  
> diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
> index aa2df3a15051..e2f5445d24ff 100644
> --- a/tools/testing/cxl/test/mem.c
> +++ b/tools/testing/cxl/test/mem.c
> @@ -285,6 +285,8 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
>  	if (IS_ERR(cxlmd))
>  		return PTR_ERR(cxlmd);
>  
> +	cxl_mem_get_event_records(cxlds);
> +
>  	if (resource_size(&cxlds->pmem_res) && IS_ENABLED(CONFIG_CXL_PMEM))
>  		rc = devm_cxl_add_nvdimm(dev, cxlmd);
>  

