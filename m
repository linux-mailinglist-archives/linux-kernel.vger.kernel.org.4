Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC4565FB3A2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 15:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbiJKNrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 09:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiJKNrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 09:47:21 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 738F97437E;
        Tue, 11 Oct 2022 06:47:17 -0700 (PDT)
Received: from fraeml743-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Mmxr573rsz67yJQ;
        Tue, 11 Oct 2022 21:45:41 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml743-chm.china.huawei.com (10.206.15.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 11 Oct 2022 15:47:14 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 11 Oct
 2022 14:47:14 +0100
Date:   Tue, 11 Oct 2022 14:47:12 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <ira.weiny@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [RFC V2 PATCH 06/11] cxl/mem: Trace DRAM Event Record
Message-ID: <20221011144712.00004a05@huawei.com>
In-Reply-To: <20221010224131.1866246-7-ira.weiny@intel.com>
References: <20221010224131.1866246-1-ira.weiny@intel.com>
        <20221010224131.1866246-7-ira.weiny@intel.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
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

On Mon, 10 Oct 2022 15:41:26 -0700
ira.weiny@intel.com wrote:

> From: Ira Weiny <ira.weiny@intel.com>
> 
> CXL rev 3.0 section 8.2.9.2.1.2 defines the DRAM Event Record.
> 
> Determine if the event read is a DRAM event record and if so trace the
> record.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 

Trivial comments inline

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> diff --git a/include/trace/events/cxl.h b/include/trace/events/cxl.h
> index 82a8d3b750a2..7a90cfea348b 100644
> --- a/include/trace/events/cxl.h
> +++ b/include/trace/events/cxl.h
> @@ -230,6 +230,100 @@ TRACE_EVENT(general_media,
>  		)
>  );
>  

> +
> +TRACE_EVENT(dram,
> +
> +	TP_PROTO(const char *dev_name, enum cxl_event_log_type log,
> +		 struct cxl_event_dram *rec),
> +
> +	TP_ARGS(dev_name, log, rec),
> +
> +	TP_STRUCT__entry(
> +		CXL_EVT_TP_entry
> +		/* DRAM */
> +		__field(u64, phys_addr)
> +		__field(u8, descriptor)
> +		__field(u8, type)
> +		__field(u8, transaction_type)
> +		__field(u8, channel)
> +		__field(u16, validity_flags)
> +		__field(u16, column)	/* Out of order to pack trace record */
> +		__field(u32, nibble_mask)
> +		__field(u32, row)
> +		__array(u8, cor_mask, CXL_EVENT_DER_CORRECTION_MASK_SIZE)
> +		__array(u8, reserved, CXL_EVENT_DER_RES_SIZE)

If we are going to have this, why not put it at the end?  Will that affect the
packing badly?

> +		__field(u8, rank)	/* Out of order to pack trace record */
> +		__field(u8, bank_group)	/* Out of order to pack trace record */
> +		__field(u8, bank)	/* Out of order to pack trace record */
> +	),
> +
> +	TP_fast_assign(
> +		CXL_EVT_TP_fast_assign(dev_name, log, rec->hdr);
> +
> +		/* DRAM */
> +		__entry->phys_addr = le64_to_cpu(rec->phys_addr);
> +		__entry->descriptor = rec->descriptor;
> +		__entry->type = rec->type;
> +		__entry->transaction_type = rec->transaction_type;
> +		__entry->validity_flags = get_unaligned_le16(rec->validity_flags);
> +		__entry->channel = rec->channel;
> +		__entry->rank = rec->rank;
> +		__entry->nibble_mask = get_unaligned_le24(rec->nibble_mask);
> +		__entry->bank_group = rec->bank_group;
> +		__entry->bank = rec->bank;
> +		__entry->row = get_unaligned_le24(rec->row);
> +		__entry->column = get_unaligned_le16(rec->column);
> +		memcpy(__entry->cor_mask, &rec->correction_mask,
> +			CXL_EVENT_DER_CORRECTION_MASK_SIZE);
> +		memcpy(__entry->reserved, &rec->reserved,
> +			CXL_EVENT_DER_RES_SIZE);
> +	),
> +
> +	CXL_EVT_TP_printk("phys_addr=%llx volatile=%s desc='%s' type='%s' " \
> +		"trans_type='%s' channel=%u rank=%u nibble_mask=%x " \
> +		"bank_group=%u bank=%u row=%u column=%u cor_mask=%s " \
> +		"valid_flags='%s' reserved=%s",
> +		__entry->phys_addr & CXL_GMER_PHYS_ADDR_MASK,
> +		(__entry->phys_addr & CXL_GMER_PHYS_ADDR_VOLATILE) ? "TRUE" : "FALSE",
> +		show_event_desc_flags(__entry->descriptor),
> +		show_mem_event_type(__entry->type),
> +		show_trans_type(__entry->transaction_type),
> +		__entry->channel, __entry->rank, __entry->nibble_mask,
> +		__entry->bank_group, __entry->bank,
> +		__entry->row, __entry->column,
> +		__print_hex(__entry->cor_mask, CXL_EVENT_DER_CORRECTION_MASK_SIZE),
> +		show_dram_valid_flags(__entry->validity_flags),
> +		__print_hex(__entry->reserved, CXL_EVENT_DER_RES_SIZE)
> +		)
Probably one less tab on that trailing )?

> +);
> +
>  #endif /* _CXL_TRACE_EVENTS_H */
>  
>  /* This part must be outside protection */

