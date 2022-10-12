Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D286B5FCD78
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 23:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbiJLVqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 17:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiJLVq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 17:46:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE458FF208;
        Wed, 12 Oct 2022 14:46:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5B704615F2;
        Wed, 12 Oct 2022 21:46:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7649C43470;
        Wed, 12 Oct 2022 21:46:22 +0000 (UTC)
Date:   Wed, 12 Oct 2022 17:46:20 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     alison.schofield@intel.com
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, linux-cxl@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] trace, cxl: Introduce a TRACE_EVENT for CXL
 poison records
Message-ID: <20221012174620.7cd7d062@rorschach.local.home>
In-Reply-To: <17ee0f309e4287510e4e68f2cbcfc9d111a6e69d.1665606782.git.alison.schofield@intel.com>
References: <cover.1665606782.git.alison.schofield@intel.com>
        <17ee0f309e4287510e4e68f2cbcfc9d111a6e69d.1665606782.git.alison.schofield@intel.com>
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

On Wed, 12 Oct 2022 14:28:17 -0700
alison.schofield@intel.com wrote:

> +TRACE_EVENT(cxl_poison,
> +
> +	    TP_PROTO(pid_t pid, const char *region, const char *memdev,
> +		     const char *pcidev, u64 hpa, u64 dpa, u32 length,
> +		     u8 source, u8 flags, u64 overflow_t),
> +
> +	    TP_ARGS(pid, region, memdev, pcidev, hpa, dpa,
> +		    length, source, flags, overflow_t),
> +
> +	    TP_STRUCT__entry(
> +		__field(pid_t, pid)
> +		__string(region, region ? region : "")
> +		__string(memdev, memdev)
> +		__string(pcidev, pcidev)
> +		__field(u64, hpa)
> +		__field(u64, dpa)
> +		__field(u32, length)
> +		__field(u8, source)
> +		__field(u8, flags)
> +		__field(u64, overflow_t)

The above looks nice and compact.

> +	    ),
> +
> +	    TP_fast_assign(
> +		__entry->pid = pid;
> +		__assign_str(region, region ? region : "");
> +		__assign_str(memdev, memdev);
> +		__assign_str(pcidev, pcidev);
> +		__entry->hpa = hpa;
> +		__entry->dpa = dpa;
> +		__entry->length = length;
> +		__entry->source = source;
> +		__entry->flags = flags;
> +		__entry->overflow_t = overflow_t;

But I wonder if it would be better to move the computation of patch 2
here?

That is, this:

> +		for (i = 0; i < le16_to_cpu(po->count); i++) {
> +			u32 len = le32_to_cpu(po->record[i].length) *
> +					      CXL_POISON_LEN_MULT;
> +			u64 addr = le64_to_cpu(po->record[i].address);
> +			u8 source = addr & CXL_POISON_SOURCE_MASK;
> +			u64 dpa = addr & CXL_POISON_START_MASK;
> +			u64 hpa = 0;
> +
> +			trace_cxl_poison(current->pid, region_name,
> +					 dev_name(&cxlmd->dev),
> +					 dev_name(cxlds->dev), hpa, dpa, len,
> +					 source, po->flags, overflow_t);
> +		}

As:

// The trace_*_enabled() is a static branch which is true when the
// tracepoint is enabled, and a nop when not (skipping the for block)

		for (i = 0; trace_cxl_poison_enabled() && i < le16_to_cpu(po->count); i++)
			trace_cxl_poison(region_name, cxlmd, cxlds, &po->record[i]);

And then have:

	    TP_fast_assign(
		u32 len = le32_to_cpu(record->length) *
				      CXL_POISON_LEN_MULT;
		u64 addr = le64_to_cpu(record->address);
		u8 source = addr & CXL_POISON_SOURCE_MASK;
		u64 dpa = addr & CXL_POISON_START_MASK;
		u64 hpa = 0;

		__entry->pid = current->pid;

{ the above isn't needed as the trace event will have common_pid = current->pid }

		__assign_str(region, region ? region : "");
		__assign_str(memdev, dev_name(&cxlmd->dev));
		__assign_str(pcidev, dev_name(cxlds->dev));
		__entry->hpa = hpa;
		__entry->dpa = dpa;
		__entry->length = length;
		__entry->source = source;
		__entry->flags = flags;
		__entry->overflow_t = overflow_t;


Or something similar. This will keep the work out of the code path.

-- Steve


> +	    ),
> +
> +	    TP_printk("pid:%d region:%s memdev:%s pcidev:%s hpa:0x%llx dpa:0x%llx length:0x%x source:%s flags:%s overflow_time:%llu",
> +		__entry->pid,
> +		__get_str(region),
> +		__get_str(memdev),
> +		__get_str(pcidev),
> +		__entry->hpa,
> +		__entry->dpa,
> +		__entry->length,
> +		show_poison_source(__entry->source),
> +		show_poison_flags(__entry->flags),
> +		__entry->overflow_t)
> +);
> +#endif /* _CXL_TRACE_H */
