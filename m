Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F50360B7EC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 21:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233389AbiJXThK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 15:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233290AbiJXTgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 15:36:48 -0400
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B97B725F1FA
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 11:07:12 -0700 (PDT)
Received: by mail-vs1-f51.google.com with SMTP id o5so7148111vsc.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 11:07:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VmgpA6OkYsLwdfzsxv2INipi2Xj6qCgSNWdLB1yHrm8=;
        b=GzQbmmihBzDcDxjXSiTOOF1YCmxuBN0aXArUTu1eQqoT5TD2HuIXsr+aRpJYa6dQsM
         pfNITA0qoNrLvaVN/15avPKampqKLz1namQI6A8J3W2pFxY63L8mutjEw5smKO1nSGz2
         FUXcg3HqqSALB3Efp2E5ftyETaQwEa/XPKE8YJMuYijN3ejUnzKQd5SqvaUtVBS3eLua
         5r7TT5/dujQs1/U620Gs0HV5q0RkwOYUQDz0HJvQamnwv/0aXVmIW732yBvcAL/YTvj8
         g7nvPQgnS+iPm2bYh3rn62joujKhoiZpeFUfqHbuogwZ7Gzf6Yzf2k2pTUkuMFINUKJn
         GPsQ==
X-Gm-Message-State: ACrzQf3sw/5ySgz9AJ3JhNMsTjShI5bfCmFdjNJBUFnBIPMjC811gzt3
        WejxWf8COn9u88zfBhhaLD791FG6Z0w=
X-Google-Smtp-Source: AMsMyM6bW4DnZPqZV9F/kwL3i4LeBiBpwKE8ZEGcxsLa53770ie/31U4fbgiZMsM56Gv5HK/2Kzz/w==
X-Received: by 2002:a17:903:230b:b0:186:6041:51bf with SMTP id d11-20020a170903230b00b00186604151bfmr23671890plh.24.1666630382267;
        Mon, 24 Oct 2022 09:53:02 -0700 (PDT)
Received: from fedora (136-24-99-118.cab.webpass.net. [136.24.99.118])
        by smtp.gmail.com with ESMTPSA id ix21-20020a170902f81500b00186aaf1644asm1251plb.87.2022.10.24.09.53.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 09:53:01 -0700 (PDT)
Date:   Mon, 24 Oct 2022 09:52:59 -0700
From:   Dennis Zhou <dennis@kernel.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Subject: Re: [PATCH 2/8] mm/percpu: use list_first_entry_or_null in
 pcpu_reclaim_populated()
Message-ID: <Y1bC6zkpmEx+XzRo@fedora>
References: <20221024081435.204970-1-bhe@redhat.com>
 <20221024081435.204970-3-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221024081435.204970-3-bhe@redhat.com>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 04:14:29PM +0800, Baoquan He wrote:
> To replace list_empty()/list_first_entry() pair to simplify code.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  mm/percpu.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/percpu.c b/mm/percpu.c
> index 26d8cd2ca323..a3fde4ac03a4 100644
> --- a/mm/percpu.c
> +++ b/mm/percpu.c
> @@ -2143,9 +2143,9 @@ static void pcpu_reclaim_populated(void)
>  	 * other accessor is the free path which only returns area back to the
>  	 * allocator not touching the populated bitmap.
>  	 */
> -	while (!list_empty(&pcpu_chunk_lists[pcpu_to_depopulate_slot])) {
> -		chunk = list_first_entry(&pcpu_chunk_lists[pcpu_to_depopulate_slot],
> -					 struct pcpu_chunk, list);
> +	while (chunk = list_first_entry_or_null(
> +			&pcpu_chunk_lists[pcpu_to_depopulate_slot],
> +			struct pcpu_chunk, list)) {
>  		WARN_ON(chunk->immutable);
>  
>  		/*
> -- 
> 2.34.1
> 

With added parenthesis,

Acked-by: Dennis Zhou <dennis@kernel.org>

Thanks,
Dennis
