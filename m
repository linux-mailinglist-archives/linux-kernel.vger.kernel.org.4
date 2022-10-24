Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6341460B312
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 18:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236177AbiJXQzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 12:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235172AbiJXQup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 12:50:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC522F39E
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 08:34:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E4A8A6142A
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 15:16:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AAC6C433C1;
        Mon, 24 Oct 2022 15:16:11 +0000 (UTC)
Date:   Mon, 24 Oct 2022 11:16:21 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Gautam Menghani <gautammenghani201@gmail.com>
Cc:     akpm@linux-foundation.org, mhiramat@kernel.org, zokeefe@google.com,
        shy828301@gmail.com, vbabka@suse.cz, david@redhat.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/khugepaged: add tracepoint to collapse_file()
Message-ID: <20221024111621.3ba17e2c@gandalf.local.home>
In-Reply-To: <20221024150922.129814-1-gautammenghani201@gmail.com>
References: <20221024150922.129814-1-gautammenghani201@gmail.com>
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

On Mon, 24 Oct 2022 20:39:22 +0530
Gautam Menghani <gautammenghani201@gmail.com> wrote:

> +TRACE_EVENT(mm_khugepaged_collapse_file,
> +	TP_PROTO(struct mm_struct *mm, struct page *hpage,
> +			unsigned long addr, const char *filename, int nr,
> +			int result),
> +	TP_ARGS(mm, hpage, addr, filename, nr, result),
> +	TP_STRUCT__entry(
> +		__field(struct mm_struct *, mm)
> +		__field(unsigned long, hpfn)
> +		__field(unsigned long, addr)
> +		__string(filename, filename)
> +		__field(int, nr)
> +		__field(int, result)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->mm = mm;
> +		__entry->hpfn = hpage ? page_to_pfn(hpage) : -1;
> +		__entry->addr = addr;
> +		__assign_str(filename, filename);
> +		__entry->nr = nr;
> +		__entry->result = result;
> +	),
> +
> +	TP_printk("mm=%p, hpage_pfn=0x%lx, addr=%ld, filename=%s, nr=%d, result=%s",
> +		__entry->mm,
> +		__entry->hpfn,
> +		__entry->addr,
> +		__get_str(filename),
> +		__entry->nr,
> +		__print_symbolic(__entry->result, SCAN_STATUS))
> +);
> +
>  #endif /* __HUGE_MEMORY_H */
>  #include <trace/define_trace.h>
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 4734315f7940..14db90e2f2ec 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -2059,7 +2059,9 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
>  		mem_cgroup_uncharge(page_folio(hpage));
>  		put_page(hpage);
>  	}
> -	/* TODO: tracepoints */
> +
> +	trace_mm_khugepaged_collapse_file(mm, hpage, addr, file->f_path.dentry->d_iname,

I try to keep dereferences out of the calling path as much as possible
(adds to I$ at the call site).

Could you just pass in file, and then have:

	__string(filename, file->f_path.dentry->d_iname)

	[..]

	__assign_string(filename, file->f_path.dentry->d_iname);


If you are paranoid, you can have the above also be:

			file ? file->f_path.dentry ? file->f_path.dentry->d_iname : "(null)" : "(null)")


-- Steve


> +				      nr, result);
>  	return result;
