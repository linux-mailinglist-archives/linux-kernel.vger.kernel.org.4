Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C98E74BD56
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 13:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbjGHLRb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 07:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjGHLRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 07:17:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 045421BD;
        Sat,  8 Jul 2023 04:17:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8865C60B77;
        Sat,  8 Jul 2023 11:17:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 873DBC433C8;
        Sat,  8 Jul 2023 11:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688815047;
        bh=foX/d1WQch9ePYxJTVcxz1Bu9RJKqsQXlWtMZpGLvVw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VXyax0e5hnKV2fts2wPOsxD8sIaAt2mJ29ivTMfR1GJp74UnAYVfT3tBl4OJ1x2PG
         ldO5+PV5e5rWNknUU1qeiCsrXZQYeYU6TumBcsXsfm/N4jTmUQcwWX/YP1VVdW5ui9
         hnBlh4Z+P7Uo0F+4RdKuyoGffFCpdcaYBXiSoWyg=
Date:   Sat, 8 Jul 2023 13:17:25 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] kobject: Reorder fields in 'struct kobject'
Message-ID: <2023070840-backyard-outgrow-e4e7@gregkh>
References: <6c7d1e3005dbec5483bdb9b7b60071175bf7bf70.1688811201.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c7d1e3005dbec5483bdb9b7b60071175bf7bf70.1688811201.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 08, 2023 at 12:13:45PM +0200, Christophe JAILLET wrote:
> Group some variables based on their sizes to reduce hole and avoid padding.
> On x86_64, this shrinks the size of 'struct kobject' from 256 to 244 bytes.
> 
> This structure is often included in some other structures. So these other
> structures will also benefit from this 8 bytes saving.
> 
> This is especially nice for structure like 'cma_kobject' or 'class_dir'
> that are now 256 bytes long. When they are kzalloc()'ed, 256 bytes are
> allocated, instead of 512.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Try to see how often this is included in another struct. Certainly not
> perfect, but gives an idea.
>    git grep -P \\tstruct\ kobj[^*]*$ | wc -l
>    163
> 
> 
> Using pahole
> 
> Before:
> ======
> struct kobject {
> 	const char  *              name;                 /*     0     8 */
> 	struct list_head           entry;                /*     8    16 */
> 	struct kobject *           parent;               /*    24     8 */
> 	struct kset *              kset;                 /*    32     8 */
> 	const struct kobj_type  *  ktype;                /*    40     8 */
> 	struct kernfs_node *       sd;                   /*    48     8 */
> 	struct kref                kref;                 /*    56     4 */
> 
> 	/* XXX 4 bytes hole, try to pack */
> 
> 	/* --- cacheline 1 boundary (64 bytes) --- */
> 	struct delayed_work        release;              /*    64   184 */
> 
> 	/* XXX last struct has 4 bytes of padding */
> 
> 	/* --- cacheline 3 boundary (192 bytes) was 56 bytes ago --- */
> 	unsigned int               state_initialized:1;  /*   248: 0  4 */
> 	unsigned int               state_in_sysfs:1;     /*   248: 1  4 */
> 	unsigned int               state_add_uevent_sent:1; /*   248: 2  4 */
> 	unsigned int               state_remove_uevent_sent:1; /*   248: 3  4 */
> 	unsigned int               uevent_suppress:1;    /*   248: 4  4 */
> 
> 	/* size: 256, cachelines: 4, members: 13 */
> 	/* sum members: 244, holes: 1, sum holes: 4 */
> 	/* sum bitfield members: 5 bits (0 bytes) */
> 	/* padding: 4 */
> 	/* paddings: 1, sum paddings: 4 */
> 	/* bit_padding: 27 bits */
> };
> 
> 
> After:
> =====
> struct kobject {
> 	const char  *              name;                 /*     0     8 */
> 	struct list_head           entry;                /*     8    16 */
> 	struct kobject *           parent;               /*    24     8 */
> 	struct kset *              kset;                 /*    32     8 */
> 	const struct kobj_type  *  ktype;                /*    40     8 */
> 	struct kernfs_node *       sd;                   /*    48     8 */
> 	struct kref                kref;                 /*    56     4 */
> 	unsigned int               state_initialized:1;  /*    60: 0  4 */
> 	unsigned int               state_in_sysfs:1;     /*    60: 1  4 */
> 	unsigned int               state_add_uevent_sent:1; /*    60: 2  4 */
> 	unsigned int               state_remove_uevent_sent:1; /*    60: 3  4 */
> 	unsigned int               uevent_suppress:1;    /*    60: 4  4 */
> 
> 	/* XXX 27 bits hole, try to pack */
> 
> 	/* --- cacheline 1 boundary (64 bytes) --- */
> 	struct delayed_work        release;              /*    64   184 */
> 
> 	/* XXX last struct has 4 bytes of padding */
> 
> 	/* size: 248, cachelines: 4, members: 13 */
> 	/* sum members: 244 */
> 	/* sum bitfield members: 5 bits, bit holes: 1, sum bit holes: 27 bits */
> 	/* paddings: 1, sum paddings: 4 */
> 	/* last cacheline: 56 bytes */
> };
> ---
>  include/linux/kobject.h | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/kobject.h b/include/linux/kobject.h
> index c392c811d9ad..c30affcc43b4 100644
> --- a/include/linux/kobject.h
> +++ b/include/linux/kobject.h
> @@ -69,14 +69,16 @@ struct kobject {
>  	const struct kobj_type	*ktype;
>  	struct kernfs_node	*sd; /* sysfs directory entry */
>  	struct kref		kref;
> -#ifdef CONFIG_DEBUG_KOBJECT_RELEASE
> -	struct delayed_work	release;
> -#endif
> +
>  	unsigned int state_initialized:1;
>  	unsigned int state_in_sysfs:1;
>  	unsigned int state_add_uevent_sent:1;
>  	unsigned int state_remove_uevent_sent:1;
>  	unsigned int uevent_suppress:1;
> +
> +#ifdef CONFIG_DEBUG_KOBJECT_RELEASE
> +	struct delayed_work	release;
> +#endif
>  };

Very nice, thanks for doing this!

For some reason I thought I did this already, but it turned out to be in
an old branch of mine that never saw the light of day as I went down
some other path trying to do something else.  So many thanks for this,
I'll queue it up after 6.5-rc1 is out.

greg k-h
