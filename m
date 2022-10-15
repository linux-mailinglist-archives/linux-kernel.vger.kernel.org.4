Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4DF65FF9CF
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 13:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbiJOLb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Oct 2022 07:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiJOLbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Oct 2022 07:31:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72DE154CB0;
        Sat, 15 Oct 2022 04:31:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1E561B8085D;
        Sat, 15 Oct 2022 11:31:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1C47C433C1;
        Sat, 15 Oct 2022 11:31:49 +0000 (UTC)
Date:   Sat, 15 Oct 2022 07:31:45 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     ira.weiny@intel.com
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
Subject: Re: [RFC V2 PATCH 06/11] cxl/mem: Trace DRAM Event Record
Message-ID: <20221015073145.4068019d@rorschach.local.home>
In-Reply-To: <20221010224131.1866246-7-ira.weiny@intel.com>
References: <20221010224131.1866246-1-ira.weiny@intel.com>
        <20221010224131.1866246-7-ira.weiny@intel.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Oct 2022 15:41:26 -0700
ira.weiny@intel.com wrote:

> +TRACE_EVENT(dram,

Call this "cxl_dram"

-- Steve

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
> +);
> +
