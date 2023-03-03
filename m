Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 205376A95AD
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 11:58:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbjCCK6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 05:58:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbjCCK5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 05:57:55 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0121926A6;
        Fri,  3 Mar 2023 02:57:53 -0800 (PST)
Received: from [192.168.10.39] (unknown [182.179.171.187])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D53756602FAE;
        Fri,  3 Mar 2023 10:57:49 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1677841071;
        bh=aJ629f459T2/4SFJjB3CeXdAJ6xSaeA5567kn8eFpEo=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=Ii3psLcOlxb4lKa3kZfiO/8QGnW2AuZi5bscmtyNvq25x6TsODv2DHO5QPdJTR1W8
         Bx245Gw/BmL5agbvP09Qn7smJGUEvvymQnD8hBmxVgNav7GoE+y+dBzjv2tG5MB4A3
         c6/xDyMKnqqJUN14qru1QE2l5B9srM8e8GB2ANRciZjhq1TuR9MTqof44usR2PZJhU
         4RaPvhZ71uDwaWbqDBivSEnLH9rc/UffZh9a/4wPrSHKJJ31aAFGmHZnmgEXkm9gOE
         6MIEkPaJmj0qCooILSaU8r263DukFij+So6djJkj12JgLbaIqk2vwgwQBtnjaDmGAR
         IlLWAvbw4PyCQ==
Message-ID: <2481c947-b558-f536-d505-dffaf6a023a9@collabora.com>
Date:   Fri, 3 Mar 2023 15:57:45 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH] spi: Reorder fields in 'struct spi_message'
Content-Language: en-US
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Mark Brown <broonie@kernel.org>
References: <c112aad16eb47808e1ec10abd87b3d273c969a68.1677704283.git.christophe.jaillet@wanadoo.fr>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <c112aad16eb47808e1ec10abd87b3d273c969a68.1677704283.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/2/23 1:58 AM, Christophe JAILLET wrote:
> Group some variables based on their sizes to reduce hole and avoid padding.
> On x86_64, this shrinks the size from 112 to 96 bytes.
> 
> This should have no real impact on memory allocation because 'struct
> spi_message' is mostly used on stack, but it can save a few cycles
> when the structure is initialized with spi_message_init() and co.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Tested-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

> ---
> Using pahole
> 
> Before:
> ======
> struct spi_message {
> 	struct list_head           transfers;            /*     0    16 */
> 	struct spi_device *        spi;                  /*    16     8 */
> 	unsigned int               is_dma_mapped:1;      /*    24: 0  4 */
> 
> 	/* XXX 31 bits hole, try to pack */
> 	/* XXX 4 bytes hole, try to pack */
> 
> 	void                       (*complete)(void *);  /*    32     8 */
> 	void *                     context;              /*    40     8 */
> 	unsigned int               frame_length;         /*    48     4 */
> 	unsigned int               actual_length;        /*    52     4 */
> 	int                        status;               /*    56     4 */
> 
> 	/* XXX 4 bytes hole, try to pack */
> 
> 	/* --- cacheline 1 boundary (64 bytes) --- */
> 	struct list_head           queue;                /*    64    16 */
> 	void *                     state;                /*    80     8 */
> 	struct list_head           resources;            /*    88    16 */
> 	bool                       prepared;             /*   104     1 */
> 
> 	/* size: 112, cachelines: 2, members: 12 */
> 	/* sum members: 93, holes: 2, sum holes: 8 */
> 	/* sum bitfield members: 1 bits, bit holes: 1, sum bit holes: 31 bits */
> 	/* padding: 7 */
> 	/* last cacheline: 48 bytes */
> };
> 
> 
> After:
> =====
> struct spi_message {
> 	struct list_head           transfers;            /*     0    16 */
> 	struct spi_device *        spi;                  /*    16     8 */
> 	unsigned int               is_dma_mapped:1;      /*    24: 0  4 */
> 
> 	/* XXX 7 bits hole, try to pack */
> 	/* Bitfield combined with next fields */
> 
> 	bool                       prepared;             /*    25     1 */
> 
> 	/* XXX 2 bytes hole, try to pack */
> 
> 	int                        status;               /*    28     4 */
> 	void                       (*complete)(void *);  /*    32     8 */
> 	void *                     context;              /*    40     8 */
> 	unsigned int               frame_length;         /*    48     4 */
> 	unsigned int               actual_length;        /*    52     4 */
> 	struct list_head           queue;                /*    56    16 */
> 	/* --- cacheline 1 boundary (64 bytes) was 8 bytes ago --- */
> 	void *                     state;                /*    72     8 */
> 	struct list_head           resources;            /*    80    16 */
> 
> 	/* size: 96, cachelines: 2, members: 12 */
> 	/* sum members: 93, holes: 1, sum holes: 2 */
> 	/* sum bitfield members: 1 bits, bit holes: 1, sum bit holes: 7 bits */
> 	/* last cacheline: 32 bytes */
> };
> ---
>  include/linux/spi/spi.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
> index 4fa26b9a3572..bdb35a91b4bf 100644
> --- a/include/linux/spi/spi.h
> +++ b/include/linux/spi/spi.h
> @@ -1093,6 +1093,9 @@ struct spi_message {
>  
>  	unsigned		is_dma_mapped:1;
>  
> +	/* spi_prepare_message() was called for this message */
> +	bool			prepared;
> +
>  	/* REVISIT:  we might want a flag affecting the behavior of the
>  	 * last transfer ... allowing things like "read 16 bit length L"
>  	 * immediately followed by "read L bytes".  Basically imposing
> @@ -1105,11 +1108,11 @@ struct spi_message {
>  	 */
>  
>  	/* Completion is reported through a callback */
> +	int			status;
>  	void			(*complete)(void *context);
>  	void			*context;
>  	unsigned		frame_length;
>  	unsigned		actual_length;
> -	int			status;
>  
>  	/* For optional use by whatever driver currently owns the
>  	 * spi_message ...  between calls to spi_async and then later
> @@ -1120,9 +1123,6 @@ struct spi_message {
>  
>  	/* List of spi_res reources when the spi message is processed */
>  	struct list_head        resources;
> -
> -	/* spi_prepare_message() was called for this message */
> -	bool			prepared;
>  };
>  
>  static inline void spi_message_init_no_memset(struct spi_message *m)

-- 
BR,
Muhammad Usama Anjum
