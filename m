Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FAA16C7CA4
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 11:31:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231918AbjCXKbT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 06:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231847AbjCXKbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 06:31:01 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B868211D9;
        Fri, 24 Mar 2023 03:30:43 -0700 (PDT)
Received: from [IPV6:2a01:e0a:120:3210:1cb3:11e4:5834:9d5a] (unknown [IPv6:2a01:e0a:120:3210:1cb3:11e4:5834:9d5a])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7580D6603110;
        Fri, 24 Mar 2023 10:30:42 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1679653842;
        bh=xd/0dAHKT72OpMeU2hON+p4v+8T8LdsuKMjq6DagS1k=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=JQlLyCcthqEwzNcD15fv0pDX+WL703hyw+3RuhIwDN8qzrg4T0LBy1dQu2T80Up0g
         HJAM156tB7QNeJtI7ZtRSVSlE9pVYPdd+vu/Pmek4llTWLUh/OgUVfws1+A/uFilQ+
         enoGcWO7OLBQbErZlFNAhEKGudHa0oL/DBPABRLTcp1agUYaiJJTbSuG9+rWQDFNDL
         ivOh1H9cjKcgdC9FbOaSMyXdOjxyE0fDbuPGVpPk6ZsY3A9h/My7igIGLKsddHAgJH
         hWlMtiNyjDKatzfkVy2RfyViBwYnQ5rQJvh3xJZhaQJ6WdBy+th2tiuVkNk6eMw4Bq
         8tDNjxIFGnJNQ==
Message-ID: <2e216574-71fa-bda5-e985-cbd1779caedc@collabora.com>
Date:   Fri, 24 Mar 2023 11:30:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: media: verisilicon: Simplify error handling in
 tile_buffer_reallocate()
Content-Language: en-US
To:     Markus Elfring <Markus.Elfring@web.de>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        kernel-janitors@vger.kernel.org
Cc:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
References: <20230323131704.414281-1-benjamin.gaignard@collabora.com>
 <69159492-dced-a082-5f7e-3d8d0e880f58@web.de>
 <bb638f1a-9d13-7331-9190-7470e98d05f7@collabora.com>
 <98f7a85c-e752-8f40-f658-198e42518343@web.de>
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
In-Reply-To: <98f7a85c-e752-8f40-f658-198e42518343@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Le 24/03/2023 à 10:55, Markus Elfring a écrit :
>>>> Rework allocation errors cases handling to simply it
>>>> by removing useless tests.
>>> How do you think about to use a wording like “Simplify handling of allocation
>>> error cases by removing useless tests.” for your change description?
> I would appreciate another bit of fine-tuning for such text.
>
>
>>>> Reported-by: …
>>>> ---
>>>>    .../media/platform/verisilicon/hantro_hevc.c  | 23 ++++++++-----------
>>> Would you like to add any links for corresponding information?
>> No, it was just to show that you have reported the possible clean up
> I imagine that a bit of background information will be helpful in a tag
> like “Link:” also for your patch.
>
> 2023-03-22
> [PATCH] media: hantro: HEVC: Fix exception handling in tile_buffer_reallocate()
>
> Examples:
> * https://lore.kernel.org/cocci/ea112fdd-7af0-d1f1-442c-306e6ec54a5b@web.de/
>    https://sympa.inria.fr/sympa/arc/cocci/2023-03/msg00037.html
>
> * https://lore.kernel.org/lkml/5d5c8c7b-b926-8397-7994-623ac9b37e83@collabora.com/

You are welcome to propose a v3 for this patch :-)

>
>
> Regards,
> Markus
>
