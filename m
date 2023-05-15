Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6C8C70372E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 19:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243898AbjEORRr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 13:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243672AbjEORRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 13:17:31 -0400
Received: from smtp.smtpout.orange.fr (smtp-21.smtpout.orange.fr [80.12.242.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D4E11D95
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 10:15:57 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id ybnepdN4B4Eobybnepjxfr; Mon, 15 May 2023 19:15:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1684170956;
        bh=tjbWYtWJTtOAaFL/DfgU+hQjnAxrNeVxu1yjJPXsji8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=tdjxYzeKEs5N49Wh/DT0gtNIgwI3NoV4rB9kOjf/rcT5TtCzIUHJ3Z7CB5dQzmSy6
         Stfu7Vvg6/aDOKuEC7/jnjDx5pQdwYcsx37HAZEL4rPmfDEX+xu0B+cv578OLynGOL
         Le3H6q9w0WpgcMcIDhpBgU7tfT0nGc/xh9xQ2Y0IBMRrPvrF4ekv5hhmpD9te2u0uD
         ZbFbKGvnJt/uZZyoFsEjkmi5ygj5eEXqbGQsBsd15MvWDRga65qKpkPoiXfPwJrZHa
         3D37SKLTYhUZyzPYOhzUnrfyIQztZgtepG+q/J8ax6VmCjS24LItxLOSO/ky7zLL5G
         8QHL6oBWp7eIA==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 15 May 2023 19:15:56 +0200
X-ME-IP: 86.243.2.178
Message-ID: <5359488e-2b37-b328-3dbc-00bedd1726d5@wanadoo.fr>
Date:   Mon, 15 May 2023 19:15:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] coda: return -EFAULT if copy fails
To:     Su Hui <suhui@nfschina.com>, Jan Harkes <jaharkes@cs.cmu.edu>,
        coda@cs.cmu.edu
Cc:     codalist@coda.cs.cmu.edu, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <20230515061923.767680-1-suhui@nfschina.com>
Content-Language: fr
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20230515061923.767680-1-suhui@nfschina.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 15/05/2023 à 08:19, Su Hui a écrit :
> The copy_to/from_user() functions should return -EFAULT instead of -EINVAL.

Hi,

just for my understanding, why?

Even if not perfect:
    git grep -A1 copy_from_user | grep EINV | wc -l
    15

    git grep -A1 copy_to_user | grep EINV | wc -l
    12

CJ

> 
> Signed-off-by: Su Hui <suhui@nfschina.com>
> ---
>   fs/coda/upcall.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/coda/upcall.c b/fs/coda/upcall.c
> index cd6a3721f6f6..1517dc3bd592 100644
> --- a/fs/coda/upcall.c
> +++ b/fs/coda/upcall.c
> @@ -510,7 +510,7 @@ int venus_pioctl(struct super_block *sb, struct CodaFid *fid,
>           /* get the data out of user space */
>   	if (copy_from_user((char *)inp + (long)inp->coda_ioctl.data,
>   			   data->vi.in, data->vi.in_size)) {
> -		error = -EINVAL;
> +		error = -EFAULT;
>   	        goto exit;
>   	}
>   


