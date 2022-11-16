Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE6062C2B4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 16:35:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233216AbiKPPfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 10:35:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232190AbiKPPfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 10:35:31 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FB0914D0C;
        Wed, 16 Nov 2022 07:35:31 -0800 (PST)
Received: from frapeml100004.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NC6Sn4FSgz67KSc;
        Wed, 16 Nov 2022 23:30:49 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 frapeml100004.china.huawei.com (7.182.85.167) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 16 Nov 2022 16:35:29 +0100
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 16 Nov
 2022 15:35:28 +0000
Date:   Wed, 16 Nov 2022 15:35:28 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     <ira.weiny@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 07/11] cxl/mem: Trace Memory Module Event Record
Message-ID: <20221116153528.00005af7@Huawei.com>
In-Reply-To: <20221110185758.879472-8-ira.weiny@intel.com>
References: <20221110185758.879472-1-ira.weiny@intel.com>
        <20221110185758.879472-8-ira.weiny@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
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

On Thu, 10 Nov 2022 10:57:54 -0800
ira.weiny@intel.com wrote:

> From: Ira Weiny <ira.weiny@intel.com>
> 
> CXL rev 3.0 section 8.2.9.2.1.3 defines the Memory Module Event Record.
> 
> Determine if the event read is memory module record and if so trace the
> record.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
Noticed that we have a mixture of fully capitalized and not for flags.
With that either explained or tidied up:

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> +/*
> + * Device Health Information - DHI
> + *
> + * CXL res 3.0 section 8.2.9.8.3.1; Table 8-100
> + */
> +#define CXL_DHI_HS_MAINTENANCE_NEEDED				BIT(0)
> +#define CXL_DHI_HS_PERFORMANCE_DEGRADED				BIT(1)
> +#define CXL_DHI_HS_HW_REPLACEMENT_NEEDED			BIT(2)
> +#define show_health_status_flags(flags)	__print_flags(flags, "|",	   \
> +	{ CXL_DHI_HS_MAINTENANCE_NEEDED,	"Maintenance Needed"	}, \
> +	{ CXL_DHI_HS_PERFORMANCE_DEGRADED,	"Performance Degraded"	}, \
> +	{ CXL_DHI_HS_HW_REPLACEMENT_NEEDED,	"Replacement Needed"	}  \

Why are we sometime using capitals for flags (e.g patch 5) and not other times?

> +)

