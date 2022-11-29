Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D26A563CBE6
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 00:31:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbiK2Xbb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 18:31:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbiK2XbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 18:31:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD4BC71F02
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 15:30:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5C38EB8196F
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 23:30:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3089C433D7;
        Tue, 29 Nov 2022 23:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1669764638;
        bh=plS0fO6DpU4Mp4Q+v9ZvaoaZgSkofrLY55uoEMFtSBo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=0Tc+bYvngDX3Fi3SVbnY/ks9yewfhcMlvydxiqHPsc0LO+ERE00J9OqUMY1ATbXe8
         /ZGHd60YFFngeenv9rAYvSxfGcLl/Horm06MtWyKKzKbDFaTCJWwu4/I1YtVSfgK8L
         6emiLV+yrVkVWs6Bzb33KB869MPVrolVro0cDYn4=
Date:   Tue, 29 Nov 2022 15:30:37 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
Cc:     Colin Ian King <colin.i.king@gmail.com>,
        wuchi <wuchi.zero@gmail.com>, Jens Axboe <axboe@kernel.dk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
Subject: Re: [PATCH] relay: Fix type mismatch when allocating memory in
 relay_create_buf()
Message-Id: <20221129153037.d9c9496c291e5cefa4aec762@linux-foundation.org>
In-Reply-To: <20221129092002.3538384-1-Ilia.Gavrilov@infotecs.ru>
References: <20221129092002.3538384-1-Ilia.Gavrilov@infotecs.ru>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Nov 2022 09:23:38 +0000 Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru> wrote:

> The 'padding' field of the 'rchan_buf' structure is an array of 'size_t'
> elements, but the memory is allocated for an array of 'size_t *' elements.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> --- a/kernel/relay.c
> +++ b/kernel/relay.c
> @@ -148,13 +148,13 @@ static struct rchan_buf *relay_create_buf(struct rchan *chan)
>  {
>  	struct rchan_buf *buf;
>  
> -	if (chan->n_subbufs > KMALLOC_MAX_SIZE / sizeof(size_t *))
> +	if (chan->n_subbufs > KMALLOC_MAX_SIZE / sizeof(size_t))
>  		return NULL;
>  
>  	buf = kzalloc(sizeof(struct rchan_buf), GFP_KERNEL);
>  	if (!buf)
>  		return NULL;
> -	buf->padding = kmalloc_array(chan->n_subbufs, sizeof(size_t *),
> +	buf->padding = kmalloc_array(chan->n_subbufs, sizeof(size_t),
>  				     GFP_KERNEL);

This is why I prefer kmalloc_array(N, sizeof(*(buf->padding)), ...)

Because the reviewer doesn't have to go check that the types match up,
and because the code doesn't need changing if the type of
*(buf->padding) is changed.

Others don't like this practice, but I forget why.
