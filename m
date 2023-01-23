Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63AA26789D5
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 22:43:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231994AbjAWVnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 16:43:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231789AbjAWVns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 16:43:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1BE24ED3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 13:43:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 47439B80DD4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 21:43:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A647FC433D2;
        Mon, 23 Jan 2023 21:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1674510222;
        bh=s9OQmsSE6hF3mWRQ1LHeoX+JrnuEq95UKv7kN6OTMsA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qfzS6werlmRKcsJzQWqnprzjD5nFyrhGlZl2H4WlRVwAuxeJjNNo8txRX87kBLqLO
         fd8Vnww8Nk+47SC0jEwMTOEWGh6dGaV7ifj1JtY11kH96CgksoRrXE/rZDbKxEpMp3
         Ld7Pk0y6gPkLkbgsJDKNdMpzKdkdhe1/Sh4+iDWM=
Date:   Mon, 23 Jan 2023 13:43:41 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     Liam.Howlett@oracle.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R . Howlett" <Liam.Howlett@Oracle.com>
Subject: Re: [PATCH] maple_tree: should get pivots boundary by type
Message-Id: <20230123134341.2514c269a07ad9e7989921c6@linux-foundation.org>
In-Reply-To: <20221112234308.23823-1-richard.weiyang@gmail.com>
References: <20221112234308.23823-1-richard.weiyang@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Nov 2022 23:43:08 +0000 Wei Yang <richard.weiyang@gmail.com> wrote:

> We should get pivots boundary by type.
> 

When fixing a bug, please always fully describe the runtime effects of
that bug.

I see from earlier review that the bug could result in overindexing
mt_pivots[], but Liam says this code isn't presently used, but
mas_alloc() calls mte_pivot(), so I'm all confused.


> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -669,12 +669,13 @@ static inline unsigned long mte_pivot(const struct maple_enode *mn,
>  				 unsigned char piv)
>  {
>  	struct maple_node *node = mte_to_node(mn);
> +	enum maple_type type = mte_node_type(mn);
>  
> -	if (piv >= mt_pivots[piv]) {
> +	if (piv >= mt_pivots[type]) {
>  		WARN_ON(1);
>  		return 0;
>  	}
> -	switch (mte_node_type(mn)) {
> +	switch (type) {
>  	case maple_arange_64:
>  		return node->ma64.pivot[piv];
>  	case maple_range_64:
> -- 
> 2.33.1
> 
