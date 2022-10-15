Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEAC65FF9CE
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 13:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbiJOLar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Oct 2022 07:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiJOLaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Oct 2022 07:30:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A20554CB0;
        Sat, 15 Oct 2022 04:30:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D3B77B80916;
        Sat, 15 Oct 2022 11:30:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65B1FC433D6;
        Sat, 15 Oct 2022 11:30:40 +0000 (UTC)
Date:   Sat, 15 Oct 2022 07:30:36 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     ira.weiny@intel.com
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
Subject: Re: [RFC V2 PATCH 05/11] cxl/mem: Trace General Media Event Record
Message-ID: <20221015073036.529f7650@rorschach.local.home>
In-Reply-To: <20221010224131.1866246-6-ira.weiny@intel.com>
References: <20221010224131.1866246-1-ira.weiny@intel.com>
        <20221010224131.1866246-6-ira.weiny@intel.com>
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

On Mon, 10 Oct 2022 15:41:25 -0700
ira.weiny@intel.com wrote:

> +static void cxl_trace_event_record(const char *dev_name,
> +				   enum cxl_event_log_type type,
> +				   struct cxl_get_event_payload *payload)
> +{
> +	uuid_t *id = &payload->record.hdr.id;
> +

Perhaps you want to add here:

	if (!trace_cxl_general_media_enabled() && !trace_clx_generic_event_enabled())
		return;

This way the below logic is only executed if either event is enabled.
The above uses static_branches, so if the architecture supports them,
they are not compare and branch, but jumps and/or nops.

-- Steve


> +	if (uuid_equal(id, &gen_media_event_uuid)) {
> +		struct cxl_event_gen_media *rec =
> +				(struct cxl_event_gen_media *)&payload->record;
> +
> +		trace_general_media(dev_name, type, rec);
> +		return;
> +	}
> +
> +	/* For unknown record types print just the header */
> +	trace_generic_event(dev_name, type, &payload->record);
> +}
