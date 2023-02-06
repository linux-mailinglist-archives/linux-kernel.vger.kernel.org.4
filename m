Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1D9168C380
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 17:41:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbjBFQll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 11:41:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbjBFQlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 11:41:39 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C29525968;
        Mon,  6 Feb 2023 08:41:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A83AFCE1B81;
        Mon,  6 Feb 2023 16:41:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3E46C433D2;
        Mon,  6 Feb 2023 16:41:11 +0000 (UTC)
Date:   Mon, 6 Feb 2023 11:40:53 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jithu Joseph <jithu.joseph@intel.com>
Cc:     hdegoede@redhat.com, markgross@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, gregkh@linuxfoundation.org,
        ashok.raj@intel.com, tony.luck@intel.com,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        patches@lists.linux.dev, ravi.v.shankar@intel.com,
        thiago.macieira@intel.com, athenas.jimenez.gonzalez@intel.com,
        sohil.mehta@intel.com
Subject: Re: [PATCH 5/5] platform/x86/intel/ifs: Trace support for array
 test
Message-ID: <20230206114053.1c46fddb@rorschach.local.home>
In-Reply-To: <20230131234302.3997223-6-jithu.joseph@intel.com>
References: <20230131234302.3997223-1-jithu.joseph@intel.com>
        <20230131234302.3997223-6-jithu.joseph@intel.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Jan 2023 15:43:02 -0800
Jithu Joseph <jithu.joseph@intel.com> wrote:

> diff --git a/include/trace/events/intel_ifs.h b/include/trace/events/intel_ifs.h
> index d7353024016c..db43df4139a2 100644
> --- a/include/trace/events/intel_ifs.h
> +++ b/include/trace/events/intel_ifs.h
> @@ -35,6 +35,33 @@ TRACE_EVENT(ifs_status,
>  		__entry->status)
>  );
>  
> +TRACE_EVENT(ifs_array,
> +
> +	TP_PROTO(int cpu, union ifs_array activate, union ifs_array status),
> +
> +	TP_ARGS(cpu, activate, status),
> +
> +	TP_STRUCT__entry(
> +		__field(	u64,	status	)
> +		__field(	int,	cpu	)
> +		__field(	u32,	arrays	)
> +		__field(	u16,	bank	)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->cpu	= cpu;
> +		__entry->arrays	= activate.array_bitmask;
> +		__entry->bank	= activate.array_bank;

Regardless of the "bitfield" discussion on the other patches, this part
is considered a fast path (although if where it is called, then it may
not be). I would just have:

		__field(	u64,	data	)

		__entry->data = status.data;


> +		__entry->status	= status.data;
> +	),
> +
> +	TP_printk("cpu: %d, array_list: %.8x, array_bank: %.4x, status: %.16llx",
> +		__entry->cpu,

> +		__entry->arrays,
> +		__entry->bank,

		__entry->data >> 32,
		(__entry->data >> 16) & 0xffff,

Or something similar. That is, move the parsing of the bits to the
output. libtraceevent should still be able to handle this.

-- Steve

> +		__entry->status)
> +);
> +
