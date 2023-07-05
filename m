Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F472748DC4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 21:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233762AbjGET3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 15:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232185AbjGET3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 15:29:23 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28B9A10F2;
        Wed,  5 Jul 2023 12:29:21 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id af79cd13be357-7656652da3cso602639185a.1;
        Wed, 05 Jul 2023 12:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688585360; x=1691177360;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aX9x7UocICoyKf+7dpuLhA5gusj7thE6eymrovOEi1Y=;
        b=OS4puIf3aHwVkCom7A3NU/1M+2pAzfOAwkAJqE44r80PeCkfJxdtGXY2zufhkQSBFi
         Wy0a9gsCbgIKr2OAA1VDZQPAHtbdkRFMqK7nrM/6PKcu7U/Z7lSi+eg0TR/tgdZLmaU+
         kN/TddZcO3tHKL6tAA5DZi/yW3p60ImHJWV84St9EYJPzeIe5zoF6QsCs1ghcjdDiP4H
         MMlSynDbfCJFSkxpWHzibsQYud9RqV0j40J0PaSqMQOQzqVEvNVBXXa1BMZHvhD6nBrf
         uT83kN0b9wf/2vdE2cTGk/b+k3J43cW6FE+XXn+nlLq1N8rwe6x2mGOxQJpLLhGd6er/
         s1Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688585360; x=1691177360;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aX9x7UocICoyKf+7dpuLhA5gusj7thE6eymrovOEi1Y=;
        b=dP2btGJHVqI1fH3MgXmMASVC89bUNWRDHzib6p/Va+6z4VfAlsgLY7HeS6aMNbw8w8
         yV9xcZJknkM/zE/jQXTdO9nIqliDXEd/tBt6vkwi91R4xtVHagL6bCO0GM3Ub5sDXwtv
         t9nCu6RMCVVAxsLp2gmti6c2780H3etoYmDQMBC/SN8PiBj+gvzUhoCUlJW4g0dTNxRW
         vfi1yfnvRHPlAz8ZymBBwnB/nzhh8/wr9sAiFN/oAYx0rgTUcj14W/W2To4ng8meTyXC
         +7y1I9SRmeNjZQYV7h+sM7r9U5pPJ5KSJlu4ce/fbilpr+kPW/+bN2F7MVtuLwOCsVli
         S5gQ==
X-Gm-Message-State: ABy/qLZOTi72s9qePQMgMb9vI7Ytd6whCXohHBgtwKwulRMWLf0gp8p7
        iBtOUBpyCnxsgFiidr3YhTU=
X-Google-Smtp-Source: ACHHUZ5CLNg08C/ff8nQYOuus6yDfKhh2rv7ePHk14UbrG5WD2+By7Xt/bnqOYrBoj9b22+UEmDJaQ==
X-Received: by 2002:a05:620a:17a0:b0:767:1d7e:ec40 with SMTP id ay32-20020a05620a17a000b007671d7eec40mr19716096qkb.1.1688585360166;
        Wed, 05 Jul 2023 12:29:20 -0700 (PDT)
Received: from localhost (modemcable065.128-200-24.mc.videotron.ca. [24.200.128.65])
        by smtp.gmail.com with ESMTPSA id m18-20020ae9e012000000b0075d49ce31c3sm11206136qkk.91.2023.07.05.12.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 12:29:19 -0700 (PDT)
Date:   Wed, 5 Jul 2023 15:29:19 -0400
From:   Benjamin Poirier <benjamin.poirier@gmail.com>
To:     Wang Ming <machel@vivo.com>
Cc:     Sunil Goutham <sgoutham@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
Subject: Re: [PATCH net v2] net:thunderx:Fix resource leaks in
 device_for_each_child_node() loops
Message-ID: <ZKXEj6p/xkA+1yM4@d3>
References: <20230705143507.4120-1-machel@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705143507.4120-1-machel@vivo.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-07-05 22:34 +0800, Wang Ming wrote:
> The device_for_each_child_node() loop in
> bgx_init_of_phy() function should have
> wnode_handle_put() before break
 ^
 fwnode_handle_put()

> which could avoid resource leaks.
> This patch could fix this bug.
> 
> Signed-off-by: Wang Ming <machel@vivo.com>
> ---
>  drivers/net/ethernet/cavium/thunder/thunder_bgx.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/cavium/thunder/thunder_bgx.c b/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
> index a317feb8decb..dad32d36a015 100644
> --- a/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
> +++ b/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
> @@ -1478,8 +1478,10 @@ static int bgx_init_of_phy(struct bgx *bgx)
>  		 * cannot handle it, so exit the loop.
>  		 */
>  		node = to_of_node(fwn);
> -		if (!node)
> +		if (!node) {
> +			fwnode_handle_put(fwn);
>  			break;
> +		}

Fixes: eee326fd8334 ("net: thunderx: bgx: Use standard firmware node infrastructure.")
?

>  
>  		of_get_mac_address(node, bgx->lmac[lmac].mac);
>  
> @@ -1503,6 +1505,7 @@ static int bgx_init_of_phy(struct bgx *bgx)
>  		lmac++;
>  		if (lmac == bgx->max_lmac) {
>  			of_node_put(node);
> +			fwnode_handle_put(fwn);

\ fwnode_handle_put
	\ of_fwnode_put
		of_node_put(to_of_node(fwnode));

With your patch, there are now two references released on 'node' (two
of_node_put(node) calls).
One reference is from device_for_each_child_node(), where was the other
reference taken?
