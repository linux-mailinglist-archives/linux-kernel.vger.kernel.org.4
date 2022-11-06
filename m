Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59DD761E34B
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 16:56:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbiKFP4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 10:56:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbiKFP42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 10:56:28 -0500
Received: from smtp.smtpout.orange.fr (smtp-25.smtpout.orange.fr [80.12.242.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3DC3DFAB
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 07:56:27 -0800 (PST)
Received: from [192.168.1.18] ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id ri0QodMHhvd84ri0QoTlm3; Sun, 06 Nov 2022 16:56:26 +0100
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 06 Nov 2022 16:56:26 +0100
X-ME-IP: 86.243.100.34
Message-ID: <a859e4c2-69b3-5531-2e96-4debe236e44a@wanadoo.fr>
Date:   Sun, 6 Nov 2022 16:56:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] recordmcount: Fix warning comparing pointer to 0
Content-Language: fr
To:     wangkailong@jari.cn, linux-kernel@vger.kernel.org
References: <10ee62bd.c2.1844d7ee28a.Coremail.wangkailong@jari.cn>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <10ee62bd.c2.1844d7ee28a.Coremail.wangkailong@jari.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 06/11/2022 à 16:11, wangkailong@jari.cn a écrit :
> Fix the following coccicheck warning:
> 
> scripts/recordmcount.c:142:13-14: WARNING comparing pointer to 0.
> 
> Signed-off-by: KaiLong Wang <wangkailong@jari.cn>
> ---
>   scripts/recordmcount.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/recordmcount.c b/scripts/recordmcount.c
> index cce12e1971d8..750f5196608c 100644
> --- a/scripts/recordmcount.c
> +++ b/scripts/recordmcount.c
> @@ -139,7 +139,7 @@ static ssize_t uwrite(void const *const buf, size_t const count)
>   static void * umalloc(size_t size)
>   {
>   	void *const addr = malloc(size);
> -	if (addr == 0) {
> +	if (addr) {

Hi,
this change looks incorrect.

	if (!addr)

maybe?

CJ

>   		fprintf(stderr, "malloc failed: %zu bytes\n", size);
>   		file_append_cleanup();
>   		mmap_cleanup();

