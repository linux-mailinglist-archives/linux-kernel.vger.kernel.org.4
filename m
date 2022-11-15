Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F294862ADD7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 23:10:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231819AbiKOWKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 17:10:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiKOWKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 17:10:47 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BE4C30569;
        Tue, 15 Nov 2022 14:10:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668550245; x=1700086245;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=uc5sP24YBpavzKtyWJtoabUUBoa+hAu1OnMqFJhT2cI=;
  b=L3paLrCelRn0zqmSte58gXhosoitWYiZzKYrKqfDKc1UDZcECY0ywN6s
   SbZ/UzgR3SGQapzQmlgPRhUN+eFtjpZQKXb3SmkEsVqDMJIS7dLzcbLAb
   2jednWCbAIAPmBSfNNANCzGeC0Uy8297pNMq96iv50DTYl2oVS9yMXjme
   r6eLgtPXc53Z43tbDxk5V7yGzzE+NCsRk3XplGbeYjODTj2jGiEkrr96g
   vFmwF2wCNEqlaWrBBl3U5grEb7Iys77poBrHcR0aF3cmvVoes5A+QkLPP
   FGs2Q7dUPEd/Q2W9onBuuOdh42huMaCLIP2qDxDqJQtP+3vJJu39uaTMJ
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="299906683"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="299906683"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 14:10:44 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="589950332"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="589950332"
Received: from djiang5-mobl2.amr.corp.intel.com (HELO [10.212.7.249]) ([10.212.7.249])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 14:10:43 -0800
Message-ID: <bb0a274c-ef6a-fea2-3f3c-344898e6cc24@intel.com>
Date:   Tue, 15 Nov 2022 15:10:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.1
Subject: Re: [PATCH 04/11] cxl/mem: Clear events on driver load
Content-Language: en-US
To:     ira.weiny@intel.com, Dan Williams <dan.j.williams@intel.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
References: <20221110185758.879472-1-ira.weiny@intel.com>
 <20221110185758.879472-5-ira.weiny@intel.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20221110185758.879472-5-ira.weiny@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/10/2022 10:57 AM, ira.weiny@intel.com wrote:
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
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>   drivers/cxl/pci.c            | 2 ++
>   tools/testing/cxl/test/mem.c | 2 ++
>   2 files changed, 4 insertions(+)
> 
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 62e560063e50..e0d511575b45 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -530,6 +530,8 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>   	if (IS_ERR(cxlmd))
>   		return PTR_ERR(cxlmd);
>   
> +	cxl_mem_get_event_records(cxlds);
> +
>   	if (resource_size(&cxlds->pmem_res) && IS_ENABLED(CONFIG_CXL_PMEM))
>   		rc = devm_cxl_add_nvdimm(&pdev->dev, cxlmd);
>   
> diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
> index aa2df3a15051..e2f5445d24ff 100644
> --- a/tools/testing/cxl/test/mem.c
> +++ b/tools/testing/cxl/test/mem.c
> @@ -285,6 +285,8 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
>   	if (IS_ERR(cxlmd))
>   		return PTR_ERR(cxlmd);
>   
> +	cxl_mem_get_event_records(cxlds);
> +
>   	if (resource_size(&cxlds->pmem_res) && IS_ENABLED(CONFIG_CXL_PMEM))
>   		rc = devm_cxl_add_nvdimm(dev, cxlmd);
>   
