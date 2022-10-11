Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC7C25FB3F1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 15:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbiJKNzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 09:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbiJKNzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 09:55:02 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDAA130574;
        Tue, 11 Oct 2022 06:55:00 -0700 (PDT)
Received: from fraeml708-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Mmy206D3Rz67KQL;
        Tue, 11 Oct 2022 21:54:16 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml708-chm.china.huawei.com (10.206.15.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 11 Oct 2022 15:54:58 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 11 Oct
 2022 14:54:58 +0100
Date:   Tue, 11 Oct 2022 14:54:57 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <ira.weiny@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [RFC V2 PATCH 07/11] cxl/mem: Trace Memory Module Event Record
Message-ID: <20221011145457.00001e20@huawei.com>
In-Reply-To: <20221010224131.1866246-8-ira.weiny@intel.com>
References: <20221010224131.1866246-1-ira.weiny@intel.com>
        <20221010224131.1866246-8-ira.weiny@intel.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
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

On Mon, 10 Oct 2022 15:41:27 -0700
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
A few trivial comments inline. I'm happy either way
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


> +#define show_add_status(as) __print_symbolic(as,	   \
> +	{ CXL_DHI_AS_NORMAL,		"Normal"	}, \
> +	{ CXL_DHI_AS_WARNING,		"Warning"	}, \
> +	{ CXL_DHI_AS_CRITICAL,		"Critical"	}  \
> +)
> +
> +#define CXL_DHI_AS_LIFE_USED(as)			(as & 0x3)
> +#define CXL_DHI_AS_DEV_TEMP(as)				((as & 0xC) >> 2)
> +#define CXL_DHI_AS_COR_VOL_ERR_CNT(as)			((as & 0x10) >> 4)
> +#define CXL_DHI_AS_COR_PER_ERR_CNT(as)			((as & 0x20) >> 5)
>

> +	),
> +
> +	CXL_EVT_TP_printk("evt_type='%s' health_status='%s' media_status='%s' " \
> +		"as_life_used=%s as_dev_temp=%s as_cor_vol_err_cnt=%s " \
> +		"as_cor_per_err_cnt=%s life_used=%u dev_temp=%d " \
> +		"dirty_shutdown_cnt=%u cor_vol_err_cnt=%u cor_per_err_cnt=%u " \
> +		"reserved=%s",
> +		show_dev_evt_type(__entry->event_type),
> +		show_health_status_flags(__entry->health_status),
> +		show_media_status(__entry->media_status),
> +		show_add_status(CXL_DHI_AS_LIFE_USED(__entry->add_status)),
> +		show_add_status(CXL_DHI_AS_DEV_TEMP(__entry->add_status)),
> +		show_add_status(CXL_DHI_AS_COR_VOL_ERR_CNT(__entry->add_status)),
> +		show_add_status(CXL_DHI_AS_COR_PER_ERR_CNT(__entry->add_status)),
A little nasty to use same show_add_status() for the 2 bit and 1 bit versions.
Obviously it works, but maybe it's worth two macros for the 1 and 2 bit version?

> +		__entry->life_used, __entry->device_temp,
> +		__entry->dirty_shutdown_cnt, __entry->cor_vol_err_cnt,
> +		__entry->cor_per_err_cnt,
> +		__print_hex(__entry->reserved, CXL_EVENT_MEM_MOD_RES_SIZE)
> +		)
Aligned one tab too far?
