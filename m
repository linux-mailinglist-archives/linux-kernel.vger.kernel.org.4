Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A81A6241C9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 12:55:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiKJLzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 06:55:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbiKJLzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 06:55:19 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 080A45D6B6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 03:54:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668081261;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DBXYRpLp9moONU6VGCquLi5t9Eh718cfLlFyFi9l3CA=;
        b=fAbtH5bEpWweISKPfGk0FD6NungyyK+939ASZxNfUsDkZ1ifeTtC6OuqWCxk62W3A6upAm
        H0PwnJHVRdqHyTLHVDAx4JkdCIqSH8dpFoU+56879NI8qs1MznBH831gWE9N9IYfVVq2d6
        rMh7Xlsw5Z8Eq20Xrbzly069NOkRl0o=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-590-CBsAB1dVMK252uL5g39_wQ-1; Thu, 10 Nov 2022 06:54:18 -0500
X-MC-Unique: CBsAB1dVMK252uL5g39_wQ-1
Received: by mail-qv1-f69.google.com with SMTP id ob9-20020a0562142f8900b004bba5363ad9so1279626qvb.8
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 03:54:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DBXYRpLp9moONU6VGCquLi5t9Eh718cfLlFyFi9l3CA=;
        b=rUuR76u30Ycj3y1fcyWyBXpkqAX8SZ3hGg6ylPMsfcQsx319Hh54J9V76hN9rCcSpZ
         SSVKur1VgCiKtLI+wxILv/E6YJRsEuIS9C7fyPjQrEpS0/D9w24BvGjClRkEq24C2v3K
         CGw4iI5D2aYXkDHVz7aYxtT8x1rbSG3WQ717Y8WuToiPgnPUWjETmLmD3qN/nu3sEn7B
         a2rcPZgn8WTWLbUBv/mC7VbmO/C0dIMzPquBIuEgb2/V6WHWy5GIhDwZWPxiDcXY6zgx
         c4JS+8ty1xqemG8EzCsB5O24lhBQ07p1LBZrnFFPMamLh988zIsda4840UE8vnXVOEgW
         qEEw==
X-Gm-Message-State: ACrzQf2VPr5xUfYigQXxBRltcoTySHoU5UEPCztmeLPC5mW5L7+XQUPN
        8AkuhGJXpQt3+voX54noopoZeuCCItVFYQJW51ypcZczoocykSLcXd9dgdDj1Ej4rL/7aGtZO2n
        8iI9UvTU4mPIERIbN7jknz9Ct
X-Received: by 2002:ac8:4b5c:0:b0:3a5:3819:4f6c with SMTP id e28-20020ac84b5c000000b003a538194f6cmr38476103qts.115.1668081257433;
        Thu, 10 Nov 2022 03:54:17 -0800 (PST)
X-Google-Smtp-Source: AMsMyM5nK2/+RlTh1FXxmhK8+LIPkQeubcCUEzrXAdqnVRAT4J5njdAZps09YmsvbfRUfDGECJVtPQ==
X-Received: by 2002:ac8:4b5c:0:b0:3a5:3819:4f6c with SMTP id e28-20020ac84b5c000000b003a538194f6cmr38476094qts.115.1668081257203;
        Thu, 10 Nov 2022 03:54:17 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-120-203.dyn.eolo.it. [146.241.120.203])
        by smtp.gmail.com with ESMTPSA id o16-20020a05620a2a1000b006ce3f1af120sm13196566qkp.44.2022.11.10.03.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 03:54:16 -0800 (PST)
Message-ID: <4349bc93a5f2130a95305287141fde369245f921.camel@redhat.com>
Subject: Re: [PATCH v2 RESEND 1/1] net: fec: add xdp and page pool statistics
From:   Paolo Abeni <pabeni@redhat.com>
To:     Shenwei Wang <shenwei.wang@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        imx@lists.linux.dev
Date:   Thu, 10 Nov 2022 12:54:13 +0100
In-Reply-To: <20221109023147.242904-1-shenwei.wang@nxp.com>
References: <20221109023147.242904-1-shenwei.wang@nxp.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, 2022-11-08 at 20:31 -0600, Shenwei Wang wrote:
> @@ -2685,9 +2738,16 @@ static void fec_enet_get_strings(struct net_device *netdev,
>  	int i;
>  	switch (stringset) {
>  	case ETH_SS_STATS:
> -		for (i = 0; i < ARRAY_SIZE(fec_stats); i++)
> -			memcpy(data + i * ETH_GSTRING_LEN,
> -				fec_stats[i].name, ETH_GSTRING_LEN);
> +		for (i = 0; i < ARRAY_SIZE(fec_stats); i++) {
> +			memcpy(data, fec_stats[i].name, ETH_GSTRING_LEN);
> +			data += ETH_GSTRING_LEN;
> +		}
> +		for (i = 0; i < ARRAY_SIZE(fec_xdp_stat_strs); i++) {
> +			memcpy(data, fec_xdp_stat_strs[i], ETH_GSTRING_LEN);
> +			data += ETH_GSTRING_LEN;

The above triggers a warning:

In function ‘fortify_memcpy_chk’,
    inlined from ‘fec_enet_get_strings’ at ../drivers/net/ethernet/freescale/fec_main.c:2788:4:
../include/linux/fortify-string.h:413:25: warning: call to ‘__read_overflow2_field’ declared with attribute warning: detected read beyond size of field (2nd parameter); maybe use struct_group()? [-Wattribute-warning]
  413 |                         __read_overflow2_field(q_size_field, size);
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

I think you can address it changing fec_xdp_stat_strs definition to:

static const char fec_xdp_stat_strs[XDP_STATS_TOTAL][ETH_GSTRING_LEN] = { // ...

Cheers,

Paolo

