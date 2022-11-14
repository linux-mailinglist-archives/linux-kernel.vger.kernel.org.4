Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 098C66283F8
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 16:33:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236700AbiKNPdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 10:33:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234803AbiKNPdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 10:33:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17E572CC91
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 07:33:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA9B561224
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 15:33:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 341DBC433D6;
        Mon, 14 Nov 2022 15:33:12 +0000 (UTC)
Date:   Mon, 14 Nov 2022 10:33:50 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Gautam Menghani <gautammenghani201@gmail.com>
Cc:     akpm@linux-foundation.org, mhiramat@kernel.org,
        shy828301@gmail.com, zokeefe@google.com, david@redhat.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mm/khugepaged: add tracepoint to collapse_file()
Message-ID: <20221114103350.4b8a2786@gandalf.local.home>
In-Reply-To: <20221026052218.148234-1-gautammenghani201@gmail.com>
References: <20221026052218.148234-1-gautammenghani201@gmail.com>
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

On Wed, 26 Oct 2022 10:52:18 +0530
Gautam Menghani <gautammenghani201@gmail.com> wrote:

Ideally we want the trace event structure to be as packed as possible to
not waste space on the ring buffer.

> +	TP_ARGS(mm, hpage, index, is_shmem, addr, file, nr, result),
> +	TP_STRUCT__entry(
> +		__field(struct mm_struct *, mm)  4 / 8 bytes (depending on 32 bit or 64 bit arch)
> +		__field(unsigned long, hpfn)     4 / 8 bytes

The two above is fine.

> +		__field(pgoff_t, index)         4 / 8 bytes
> +		__field(bool, is_shmem)         4 bytes (or less)

> +		__field(unsigned long, addr)    4 / 8 bytes

> +		__string(filename, file->f_path.dentry->d_iname)  4 bytes
> +		__field(int, nr)		4 bytes
> +		__field(int, result)		4 bytes

For best packing, it's best to keep long / pointers together, and ints and
bools together (or paired).

On 64 bit archs, there is likely to be a 4 byte hole between is_shmem and
addr.

> +	),
> +

Better to have it be:


	TP_STRUCT__entry(
		__field(struct mm_struct *, mm)
		__field(unsigned long, hpfn)
		__field(pgoff_t, index)
		__field(unsigned long, addr)
		__field(bool, is_shmem)
		__string(filename, file->f_path.dentry->d_iname)
		__field(int, nr)
		__field(int, result)
	),

Where I swapped is_shmem and addr.

-- Steve
