Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7FB4675541
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 14:10:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbjATNKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 08:10:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjATNKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 08:10:49 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF6E3CDD3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 05:10:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674220199;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+C39jO85JsD3Q9eXxeCD+myyrJco13dFNHGsDI90u+4=;
        b=O2eHgFmRXeRaXOqUh1Qo3AZ3MsGrrH+MuvMwYH1UflahGglKrmvo2SccRky9O3BJenKoNJ
        X6StislLFNlujuMCKEWu+QhtJOPHpqG5WDwFqG0Z64eiaeP35Kfg4RtbLkD3iaGDCL4Yms
        WI/Ay+NWE5qkdRyMwEBf1jPkpMp8teU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-531-oH7x_3AlNlyV1P1LrFUjrQ-1; Fri, 20 Jan 2023 08:09:57 -0500
X-MC-Unique: oH7x_3AlNlyV1P1LrFUjrQ-1
Received: by mail-wm1-f71.google.com with SMTP id h9-20020a1ccc09000000b003db1c488826so3583653wmb.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 05:09:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+C39jO85JsD3Q9eXxeCD+myyrJco13dFNHGsDI90u+4=;
        b=UFy5ixlNbdCX+J9sMzmJFWC8/SdkB5BUcPP9DdjzdegC6RoXokzBIM1qmQ7mSUfPm+
         dcKIRMTrxnUZjLgiYOFYs9J8eSHGaVhb8HPOHTnm5eVoHXVLYI1/auWq2247/v1tgWH3
         RogYdDb9mkvnHZxeADQ8Bw2mavU1289GVz83RfnGMboyG0dpcQm/qZdEfL/tDtYNEtcL
         ZkLntsI5qfOYS/bUNrAD+qssnYvTSczgCWOGTdgQEwYWsLuzBFdiHt2AIbyaIjP5Gk9p
         v2l5iizFAMXi2TrlmNqEiL8dWyx6+xWIM5UAG8acKzJiDHpvCqw4YULwgyhAb1bI+78A
         G0Yw==
X-Gm-Message-State: AFqh2kowdjh/OUKTtjMVYWOqgSnUdhFUFsDS0AyKbWNvmfdfvD6BBSBn
        vLYfye4rjB2loofsoTFAkzqski9Ky84sVVL4zNUGf90AQyu1MTlKKXY3oKxu/AeeM4wa6a6vLSY
        Uu7EHM223hIjQhldiFZOGr3rw
X-Received: by 2002:a5d:46c2:0:b0:2bf:9465:64a with SMTP id g2-20020a5d46c2000000b002bf9465064amr959961wrs.27.1674220196775;
        Fri, 20 Jan 2023 05:09:56 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtB86EpI+Uk/QmIK169Ggv7pp6dT7DRIV8GGfKECy1ikbm5Z1YG5tWlTiPKL1/KOpaEV9azJw==
X-Received: by 2002:a5d:46c2:0:b0:2bf:9465:64a with SMTP id g2-20020a5d46c2000000b002bf9465064amr959939wrs.27.1674220196548;
        Fri, 20 Jan 2023 05:09:56 -0800 (PST)
Received: from redhat.com ([2.52.19.29])
        by smtp.gmail.com with ESMTPSA id m5-20020a056000024500b00267bcb1bbe5sm36968806wrz.56.2023.01.20.05.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 05:09:55 -0800 (PST)
Date:   Fri, 20 Jan 2023 08:09:51 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, elena.reshetova@intel.com,
        kirill.shutemov@linux.intel.com,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH v1 5/6] virtio_net: Guard against buffer length overflow
 in xdp_linearize_page()
Message-ID: <20230120080256-mutt-send-email-mst@kernel.org>
References: <20230119135721.83345-1-alexander.shishkin@linux.intel.com>
 <20230119135721.83345-6-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230119135721.83345-6-alexander.shishkin@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 03:57:20PM +0200, Alexander Shishkin wrote:
> When reassembling incoming buffers to an xdp_page, there is a potential
> integer overflow in the buffer size test and trigger and out of bounds
> memcpy().
> 
> Fix this by reordering the test so that both sides are of the same
> signedness.
> 
> Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Jesper Dangaard Brouer <hawk@kernel.org>
> Cc: John Fastabend <john.fastabend@gmail.com>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> ---
>  drivers/net/virtio_net.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 7723b2a49d8e..dfa51dd95f63 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -751,8 +751,10 @@ static struct page *xdp_linearize_page(struct receive_queue *rq,
>  
>  		/* guard against a misconfigured or uncooperative backend that
>  		 * is sending packet larger than the MTU.
> +		 * At the same time, make sure that an especially uncooperative
> +		 * backend can't overflow the test by supplying a large buflen.
>  		 */
> -		if ((page_off + buflen + tailroom) > PAGE_SIZE) {
> +		if (buflen > PAGE_SIZE - page_off - tailroom) {
>  			put_page(p);
>  			goto err_buf;
>  		}

I feel the issue should be addressed in virtqueue_get_buf.
In fact, when using DMA API, we already keep track of the
length in vring_desc_extra.

So, isn't this just the question of passing the length and
validating it e.g. in vring_unmap_one_split?
We can also use the index_nospec trick since otherwise
there could be speculation concerns.

> -- 
> 2.39.0

