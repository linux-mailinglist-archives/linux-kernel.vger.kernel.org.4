Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54F7C5FF9D2
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 13:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbiJOLdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Oct 2022 07:33:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbiJOLdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Oct 2022 07:33:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92EFB5508F;
        Sat, 15 Oct 2022 04:33:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F27CAB80818;
        Sat, 15 Oct 2022 11:33:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27358C433D6;
        Sat, 15 Oct 2022 11:33:00 +0000 (UTC)
Date:   Sat, 15 Oct 2022 07:32:57 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     ira.weiny@intel.com
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
Subject: Re: [RFC V2 PATCH 07/11] cxl/mem: Trace Memory Module Event Record
Message-ID: <20221015073257.0fc057ee@rorschach.local.home>
In-Reply-To: <20221010224131.1866246-8-ira.weiny@intel.com>
References: <20221010224131.1866246-1-ira.weiny@intel.com>
        <20221010224131.1866246-8-ira.weiny@intel.com>
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

On Mon, 10 Oct 2022 15:41:27 -0700
ira.weiny@intel.com wrote:

> +TRACE_EVENT(memory_module,

Make sure all your new events have the "cxl_" prefix. "cxl_memory_module".

This goes for all events in this series.

Thanks,

-- Steve

> +
> +	TP_PROTO(const char *dev_name, enum cxl_event_log_type log,
> +		 struct cxl_event_mem_module *rec),
> +
> +	TP_ARGS(dev_name, log, rec),
> +
> +	TP_STRUCT__entry(
> +		CXL_EVT_TP_entry
> +
> +		/* Memory Module Event */
> +		__field(u8, event_type)
> +
> +		/* Device Health Info */
> +		__field(u8, health_status)
> +		__field(u8, media_status)
> +		__field(u8, life_used)
> +		__field(u32, dirty_shutdown_cnt)
> +		__field(u32, cor_vol_err_cnt)
> +		__field(u32, cor_per_err_cnt)
> +		__field(s16, device_temp)
> +		__field(u8, add_status)
> +
> +		__array(u8, reserved, CXL_EVENT_MEM_MOD_RES_SIZE)
> +	),
> +
> +	TP_fast_assign(
> +		CXL_EVT_TP_fast_assign(dev_name, log, rec->hdr);
> +
> +		/* Memory Module Event */
> +		__entry->event_type = rec->event_type;
> +
> +		/* Device Health Info */
> +		__entry->health_status = rec->info.health_status;
> +		__entry->media_status = rec->info.media_status;
> +		__entry->life_used = rec->info.life_used;
> +		__entry->dirty_shutdown_cnt = get_unaligned_le32(rec->info.dirty_shutdown_cnt);
> +		__entry->cor_vol_err_cnt = get_unaligned_le32(rec->info.cor_vol_err_cnt);
> +		__entry->cor_per_err_cnt = get_unaligned_le32(rec->info.cor_per_err_cnt);
> +		__entry->device_temp = get_unaligned_le16(rec->info.device_temp);
> +		__entry->add_status = rec->info.add_status;
> +		memcpy(__entry->reserved, &rec->reserved,
> +			CXL_EVENT_MEM_MOD_RES_SIZE);
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
> +		__entry->life_used, __entry->device_temp,
> +		__entry->dirty_shutdown_cnt, __entry->cor_vol_err_cnt,
> +		__entry->cor_per_err_cnt,
> +		__print_hex(__entry->reserved, CXL_EVENT_MEM_MOD_RES_SIZE)
> +		)
> +);
> +
> +
