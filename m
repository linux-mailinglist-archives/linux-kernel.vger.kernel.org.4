Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F23335E5F9A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 12:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbiIVKQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 06:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbiIVKP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 06:15:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76FF7D98F6
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 03:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663841751;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0IBlKeW71HMXuF+YzjFtnzV4lezEgDBlZ/o2Kj16/Nk=;
        b=S1wqWFHLhB61dbw7FkBZEtQYxtuebTGOjAC5Tb33iu7zb4iEyTEshm1wav969lQfpJXUI3
        2Rj0agGG1CcaO9EKK0SlzE5lsUugIWwcp1GZH06LX5EFtagdncggKUFhbZDV06R6kDIGBQ
        0CXnkrRWvgjTojPgNCXicXZSpKoYqvk=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-3-UnKmOVp8PPiAHqzl3f2cKw-1; Thu, 22 Sep 2022 06:15:50 -0400
X-MC-Unique: UnKmOVp8PPiAHqzl3f2cKw-1
Received: by mail-qv1-f72.google.com with SMTP id k10-20020ad4450a000000b004aa116eebe8so6080005qvu.5
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 03:15:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date;
        bh=0IBlKeW71HMXuF+YzjFtnzV4lezEgDBlZ/o2Kj16/Nk=;
        b=HAvxj38c40Wnx6oBQUXFXck5Kw6k5K0lCZ2H7oQfeEIAkRrhC4gKLG6dr34pEcGCTR
         /6Td2Kv93TjMpd1J0c6amvrVCFCUf9Vkb17aKQQYVHtiWjeiXZtCLbskYsPyrMQ8cEM7
         3jDGOrva50tmz736Hb8YGf5P6txeApc3A1jHDkxJSGVghJUTJzJGlYxlNRC+5p5RGQSy
         6yAgzpPkMTh5tLb8+J8J0uYJ9qkM334msDC0a/0NtJ80q+zFpwtrAicxzpwFzR5lbMvp
         WSQJDOaOEPvxQi5pIIJCFlHe851XQmdp4SoubADq1Xe3D5Bxadtu8IeQuN98FANUlLDB
         zMSw==
X-Gm-Message-State: ACrzQf0HUKqZAQ75Lg0Hs5/7H1M6cNV3Xc893Tne4bYn8ghso4AArZju
        syINZ1esQeh2XgDps8f6Nb4qx6MmmjBj97buYzuPQLBjOhbNSvUL4IRGd+EVDiLvh7QJ4f1DxYx
        vpcwh9GSnOLyAbNv8zpUp/aNW
X-Received: by 2002:ac8:5895:0:b0:35c:bd1e:aed2 with SMTP id t21-20020ac85895000000b0035cbd1eaed2mr1995641qta.618.1663841749781;
        Thu, 22 Sep 2022 03:15:49 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM52Oz53vtzGd/Vzjg197H7upjHjrJaSUwH51Rbp+Rs47nfUJNiSpr/NtY/ELM28OiTN4HwqDg==
X-Received: by 2002:ac8:5895:0:b0:35c:bd1e:aed2 with SMTP id t21-20020ac85895000000b0035cbd1eaed2mr1995623qta.618.1663841749515;
        Thu, 22 Sep 2022 03:15:49 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-104-76.dyn.eolo.it. [146.241.104.76])
        by smtp.gmail.com with ESMTPSA id u15-20020a05620a0c4f00b006cf19068261sm3786530qki.116.2022.09.22.03.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 03:15:49 -0700 (PDT)
Message-ID: <9f972fe0364707e09732b086a8d31ef510cb7133.camel@redhat.com>
Subject: Re: [PATCH net-next v6 2/9] net: marvell: prestera: Add cleanup of
 allocated fib_nodes
From:   Paolo Abeni <pabeni@redhat.com>
To:     Yevhen Orlov <yevhen.orlov@plvision.eu>, netdev@vger.kernel.org
Cc:     Volodymyr Mytnyk <volodymyr.mytnyk@plvision.eu>,
        Taras Chornyi <taras.chornyi@plvision.eu>,
        Mickey Rachamim <mickeyr@marvell.com>,
        Serhiy Pshyk <serhiy.pshyk@plvision.eu>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Stephen Hemminger <stephen@networkplumber.org>,
        linux-kernel@vger.kernel.org, Taras Chornyi <tchornyi@marvell.com>,
        Oleksandr Mazur <oleksandr.mazur@plvision.eu>
Date:   Thu, 22 Sep 2022 12:15:45 +0200
In-Reply-To: <20220918194700.19905-3-yevhen.orlov@plvision.eu>
References: <20220918194700.19905-1-yevhen.orlov@plvision.eu>
         <20220918194700.19905-3-yevhen.orlov@plvision.eu>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
On Sun, 2022-09-18 at 22:46 +0300, Yevhen Orlov wrote:
> Do explicity cleanup on router_hw_fini, to ensure, that all allocated
> objects cleaned. This will be used in cases,
> when upper layer (cache) is not mapped to router_hw layer.
> 
> Co-developed-by: Taras Chornyi <tchornyi@marvell.com>
> Signed-off-by: Taras Chornyi <tchornyi@marvell.com>
> Co-developed-by: Oleksandr Mazur <oleksandr.mazur@plvision.eu>
> Signed-off-by: Oleksandr Mazur <oleksandr.mazur@plvision.eu>
> Signed-off-by: Yevhen Orlov <yevhen.orlov@plvision.eu>
> ---
>  .../marvell/prestera/prestera_router_hw.c     | 23 +++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/drivers/net/ethernet/marvell/prestera/prestera_router_hw.c b/drivers/net/ethernet/marvell/prestera/prestera_router_hw.c
> index db9d2e9d9904..1b9feb396811 100644
> --- a/drivers/net/ethernet/marvell/prestera/prestera_router_hw.c
> +++ b/drivers/net/ethernet/marvell/prestera/prestera_router_hw.c
> @@ -56,6 +56,7 @@ static int prestera_nexthop_group_set(struct prestera_switch *sw,
>  static bool
>  prestera_nexthop_group_util_hw_state(struct prestera_switch *sw,
>  				     struct prestera_nexthop_group *nh_grp);
> +static void prestera_fib_node_destroy_ht(struct prestera_switch *sw);
>  
>  /* TODO: move to router.h as macros */
>  static bool prestera_nh_neigh_key_is_valid(struct prestera_nh_neigh_key *key)
> @@ -97,6 +98,7 @@ int prestera_router_hw_init(struct prestera_switch *sw)
>  
>  void prestera_router_hw_fini(struct prestera_switch *sw)
>  {
> +	prestera_fib_node_destroy_ht(sw);
>  	WARN_ON(!list_empty(&sw->router->vr_list));
>  	WARN_ON(!list_empty(&sw->router->rif_entry_list));
>  	rhashtable_destroy(&sw->router->fib_ht);
> @@ -605,6 +607,27 @@ void prestera_fib_node_destroy(struct prestera_switch *sw,
>  	kfree(fib_node);
>  }
>  
> +static void prestera_fib_node_destroy_ht(struct prestera_switch *sw)
> +{
> +	struct prestera_fib_node *node;
> +	struct rhashtable_iter iter;
> +
> +	while (1) {
> +		rhashtable_walk_enter(&sw->router->fib_ht, &iter);
> +		rhashtable_walk_start(&iter);
> +		node = rhashtable_walk_next(&iter);
> +		rhashtable_walk_stop(&iter);
> +		rhashtable_walk_exit(&iter);
> +
> +		if (!node)
> +			break;
> +		else if (IS_ERR(node))
> +			continue;
> +		else if (node)
> +			prestera_fib_node_destroy(sw, node);
> +	}
> +}
> +
>  struct prestera_fib_node *
>  prestera_fib_node_create(struct prestera_switch *sw,
>  			 struct prestera_fib_key *key,

I commented on v5 due to PEBKAC here, but the comment applies here,
too:

You could use rhashtable_free_and_destroy() with a suitable callback
freeing the node without removing it from the hash table. The same in
the next patch.

Thanks!

Paolo

