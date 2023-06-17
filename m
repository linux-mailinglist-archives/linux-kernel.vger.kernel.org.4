Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F91C733E6F
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 07:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbjFQFoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 01:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjFQFoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 01:44:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F1A51FDD
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 22:44:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 194C0608CC
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 05:44:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB18DC433C8;
        Sat, 17 Jun 2023 05:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1686980648;
        bh=BVMmEiv915B72MWDh+k4N5DRLAHb8wLn4DnfeaejgGg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EQjtHBOfTgfTDp/m2Uzyztq4D5TIdXayeQK9pmNbeTCSDfAw4gYr3nAviXfOhDcbQ
         lLRRHXUNKxVyx2w2mbYludCh2mmtiPBSyMxgoAOVYnW8AjZJhp1d36jTJYhHEXeHyS
         6SnMfoXOswvJPZmseK6puk9Zc7QnVB1efFPICqJM=
Date:   Fri, 16 Jun 2023 22:44:07 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Liam Ni <zhiguangni01@gmail.com>
Cc:     dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, rppt@kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] mm/sparse:avoid null pointer access in memory_present()
Message-Id: <20230616224407.863c74a3dc9d4f1427802f91@linux-foundation.org>
In-Reply-To: <20230617044036.3985524-1-zhiguangni01@gmail.com>
References: <20230617044036.3985524-1-zhiguangni01@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Jun 2023 14:40:36 +1000 Liam Ni <zhiguangni01@gmail.com> wrote:

> __nr_to_section() may return a null pointer,
> before accessing the member variable section_mem_map,
> we should first determine whether it is a null pointer.
> 
> ...
>
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -258,7 +258,7 @@ static void __init memory_present(int nid, unsigned long start, unsigned long en
>  		set_section_nid(section, nid);
>  
>  		ms = __nr_to_section(section);
> -		if (!ms->section_mem_map) {
> +		if (ms && !ms->section_mem_map) {
>  			ms->section_mem_map = sparse_encode_early_nid(nid) |
>  							SECTION_IS_ONLINE;
>  			__section_mark_present(ms, section);

I'm suspecting that if __nr_to_section() returns NULL here, we should
just panic.  But a null-deref gives the same information, so why change
things?

