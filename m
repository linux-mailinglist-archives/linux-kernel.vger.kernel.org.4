Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17D916A94DF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 11:10:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbjCCKKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 05:10:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCCKKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 05:10:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19C4310413;
        Fri,  3 Mar 2023 02:10:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CEF3AB81609;
        Fri,  3 Mar 2023 10:10:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BA4CC433EF;
        Fri,  3 Mar 2023 10:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677838233;
        bh=FRwC8MxYEXSaBs+LyEZqaL4MtL0zA/qyOGc7isT+9bQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b/V1m6N8NjwIiJzV3gK2iah8r/sb0vKPojyRor2g4r1tG1x4S3M3T2au8dgxQYoyK
         am2udlEVnuvBqZWMLGkXjFXrbgTHnOlug+5rNJEtn2GoKtVVDoaG/wrjziwGptH6V+
         mmvUEKjirr8Q7nt/nv1v4ZuUQ9jFTo8NmTyWUHBBm7pDcDNQ0vS+bXwu6gyBcd9WjJ
         3/+Rk0ObtN4um7RmWboZFXFsDmoCBTHjtulVZMw9IMr+6NBsdow+KWiIq/uTcISqwF
         +KysLcFECci4BrwprspEIiOX3wEHzrL2VuIeVONyitMsXVvRD5ysTEAazsfnvX42u/
         r4Hhn3Vyrqa3w==
Date:   Fri, 3 Mar 2023 10:10:29 +0000
From:   Lee Jones <lee@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] mfd: core: Reorder fields in 'struct mfd_cell' to save
 some memory
Message-ID: <20230303101029.GM2303077@google.com>
References: <bb631974888dfe1af593b6280cf30fb913d2d1a4.1676365116.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bb631974888dfe1af593b6280cf30fb913d2d1a4.1676365116.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Feb 2023, Christophe JAILLET wrote:

> Group some variables based on their sizes to reduce hole and avoid padding.
> On x86_64, this shrinks the size from 144 to 128 bytes.
> 
> As an example:
> 
> $ size drivers/mfd/as3722.o (Before)
>    text	   data	    bss	    dec	    hex	filename
>    9441	    680	     16	  10137	   2799	drivers/mfd/as3722.o
> 
> $ size drivers/mfd/as3722.o (After)
>    text	   data	    bss	    dec	    hex	filename
>    9345	    680	     16	  10041	   2739	drivers/mfd/as3722.o
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Using pahole
> 
> Before:
> ======
> struct mfd_cell {
> 	const char  *              name;                 /*     0     8 */
> 	int                        id;                   /*     8     4 */
> 	int                        level;                /*    12     4 */
> 	int                        (*enable)(struct platform_device *); /*    16     8 */
> 	int                        (*disable)(struct platform_device *); /*    24     8 */
> 	int                        (*suspend)(struct platform_device *); /*    32     8 */
> 	int                        (*resume)(struct platform_device *); /*    40     8 */
> 	void *                     platform_data;        /*    48     8 */
> 	size_t                     pdata_size;           /*    56     8 */
> 	/* --- cacheline 1 boundary (64 bytes) --- */
> 	const struct software_node  * swnode;            /*    64     8 */
> 	const char  *              of_compatible;        /*    72     8 */
> 	const u64                  of_reg;               /*    80     8 */
> 	bool                       use_of_reg;           /*    88     1 */
> 
> 	/* XXX 7 bytes hole, try to pack */
> 
> 	const struct mfd_cell_acpi_match  * acpi_match;  /*    96     8 */
> 	int                        num_resources;        /*   104     4 */
> 
> 	/* XXX 4 bytes hole, try to pack */
> 
> 	const struct resource  *   resources;            /*   112     8 */
> 	bool                       ignore_resource_conflicts; /*   120     1 */
> 	bool                       pm_runtime_no_callbacks; /*   121     1 */
> 
> 	/* XXX 6 bytes hole, try to pack */
> 
> 	/* --- cacheline 2 boundary (128 bytes) --- */
> 	const char  * const *      parent_supplies;      /*   128     8 */
> 	int                        num_parent_supplies;  /*   136     4 */
> 
> 	/* size: 144, cachelines: 3, members: 20 */
> 	/* sum members: 123, holes: 3, sum holes: 17 */
> 	/* padding: 4 */
> 	/* last cacheline: 16 bytes */
> };
> 
> 
> After:
> =====
> struct mfd_cell {
> 	const char  *              name;                 /*     0     8 */
> 	int                        id;                   /*     8     4 */
> 	int                        level;                /*    12     4 */
> 	int                        (*enable)(struct platform_device *); /*    16     8 */
> 	int                        (*disable)(struct platform_device *); /*    24     8 */
> 	int                        (*suspend)(struct platform_device *); /*    32     8 */
> 	int                        (*resume)(struct platform_device *); /*    40     8 */
> 	void *                     platform_data;        /*    48     8 */
> 	size_t                     pdata_size;           /*    56     8 */
> 	/* --- cacheline 1 boundary (64 bytes) --- */
> 	const struct mfd_cell_acpi_match  * acpi_match;  /*    64     8 */
> 	const struct software_node  * swnode;            /*    72     8 */
> 	const char  *              of_compatible;        /*    80     8 */
> 	const u64                  of_reg;               /*    88     8 */
> 	bool                       use_of_reg;           /*    96     1 */
> 
> 	/* XXX 3 bytes hole, try to pack */
> 
> 	int                        num_resources;        /*   100     4 */
> 	const struct resource  *   resources;            /*   104     8 */
> 	bool                       ignore_resource_conflicts; /*   112     1 */
> 	bool                       pm_runtime_no_callbacks; /*   113     1 */
> 
> 	/* XXX 2 bytes hole, try to pack */
> 
> 	int                        num_parent_supplies;  /*   116     4 */
> 	const char  * const *      parent_supplies;      /*   120     8 */
> 
> 	/* size: 128, cachelines: 2, members: 20 */
> 	/* sum members: 123, holes: 2, sum holes: 5 */
> };
> ---
>  include/linux/mfd/core.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Applied, thanks

-- 
Lee Jones [李琼斯]
