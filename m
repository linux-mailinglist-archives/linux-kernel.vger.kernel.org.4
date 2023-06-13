Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B92972E1E4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 13:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239904AbjFMLpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 07:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235301AbjFMLpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 07:45:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF4FD122
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 04:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686656670;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=muOrkQ0RbXdbdOjxOGOSxQoru50xmWZYfqIPS4rtlo0=;
        b=UKM9B5U5/RwoO7ssnWsuirIJ66JElCYEDI1hY3EppDdu1FXrT3mrFR4505K4PK3+hYPQ4m
        fa0lUjJY76jTSQstUpluBZXdIOismewogVsOygZI1RueXh2iymzYyWQE8sc/l4tfXlNWsv
        41aLH5enDGNQlOiK5jPZ/t8Afx1SnSo=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-244-lsyT_FE8NXamPI_eFZeMKA-1; Tue, 13 Jun 2023 07:44:28 -0400
X-MC-Unique: lsyT_FE8NXamPI_eFZeMKA-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-9823e46db2bso68934966b.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 04:44:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686656666; x=1689248666;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=muOrkQ0RbXdbdOjxOGOSxQoru50xmWZYfqIPS4rtlo0=;
        b=AHqA4yJ9Mjm4fPX3q7gcc6hwwqGyxnluznYPv9bfLsGimnsaXE7aRY0hlq6lmNmjqF
         6grPcQaWLIOoSjKCWplDoycK+AVYPclj6RHOfIwGJxYJEOMPXl7+FkgJy6CsFDeuX8Mz
         2zMj6M0e0ujXUlt9AtM8/st+Y40tjQjcPktNOVaMc7SD/YBzrDCj0hwjT9pS7bORBuGS
         9VYyFk+4VrT0PZRn3AbF10xTapE1h3mPHyaHs4ccMI18Yt8FJxS6y+PQPoTfmVpl9LIR
         rSefzQT56cKFX6BKUV9OXZKfxXkzlAfaBtiR13zUHGaMFb4frEJuG4rZxJxY/LJ1J3Gj
         J/Uw==
X-Gm-Message-State: AC+VfDzefq7/hncONQbJOql6srCmsY5cLtBIsQ2Vgp8mOivucBliPpBS
        IJImCfcpw/jNyIag3OZAWanhGLPyHBLZMynTaBLL9JrelQmxETVG2qnrEL1ApYQlk/M53VaU+vW
        1Wh67sWok3JkB20euKXrF61ex
X-Received: by 2002:a17:907:96a0:b0:982:4b35:c0b6 with SMTP id hd32-20020a17090796a000b009824b35c0b6mr272182ejc.1.1686656666056;
        Tue, 13 Jun 2023 04:44:26 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ48aHOL0dPduaBBaezBCe329V35J0S/dnTzj9AOPQevY5O1CRbheFRzpaNtgNnJeKdlw1uEmA==
X-Received: by 2002:a17:907:96a0:b0:982:4b35:c0b6 with SMTP id hd32-20020a17090796a000b009824b35c0b6mr272152ejc.1.1686656665794;
        Tue, 13 Jun 2023 04:44:25 -0700 (PDT)
Received: from [192.168.42.222] (194-45-78-10.static.kviknet.net. [194.45.78.10])
        by smtp.gmail.com with ESMTPSA id h7-20020a17090634c700b00965d4b2bd4csm6655199ejb.141.2023.06.13.04.44.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jun 2023 04:44:25 -0700 (PDT)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <42972a52-81c0-1abb-68b8-b7609c8b2a5b@redhat.com>
Date:   Tue, 13 Jun 2023 13:44:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Cc:     brouer@redhat.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH] samples/bpf: Remove unneeded variable
Content-Language: en-US
To:     baomingtong001@208suo.com, ast@kernel.org, daniel@iogearbox.net,
        davem@davemloft.net, kuba@kernel.org, hawk@kernel.org,
        john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org
References: <20230613091309.40755-1-luojianhong@cdjrlc.com>
 <cf01ff5fafd7d95c604e6413fb590e65@208suo.com>
In-Reply-To: <cf01ff5fafd7d95c604e6413fb590e65@208suo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13/06/2023 11.18, baomingtong001@208suo.com wrote:
> Fix the following coccicheck warning:
> 
> samples/bpf/xdp1_kern.c:50: Unneeded variable: "rc".
> 
> Signed-off-by: Mingtong Bao <baomingtong001@208suo.com>
> ---
>   samples/bpf/xdp1_kern.c | 11 +++++------
>   1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/samples/bpf/xdp1_kern.c b/samples/bpf/xdp1_kern.c
> index d91f27cbcfa9..d426df4a9d6b 100644
> --- a/samples/bpf/xdp1_kern.c
> +++ b/samples/bpf/xdp1_kern.c
> @@ -47,18 +47,17 @@ int xdp_prog1(struct xdp_md *ctx)
>       void *data_end = &pkt[XDPBUFSIZE-1];
>       void *data = pkt;
>       struct ethhdr *eth = data;
> -    int rc = XDP_DROP;
>       long *value;
>       u16 h_proto;
>       u64 nh_off;
>       u32 ipproto;
> 
>       if (bpf_xdp_load_bytes(ctx, 0, pkt, sizeof(pkt)))
> -        return rc;
> +        return XDP_DROP;

IMHO for these error cases, we should return XDP_ABORTED instead.
This will make is easier to debug, e.g. with xdpdump[1] or xdp-monitor[2].

Reminder that drivers (usually) have a tracepoint for XDP_ABORTED
(code see trace_xdp_exception).

  [1] https://github.com/xdp-project/xdp-tools/tree/master/xdp-dump
  [2] https://github.com/xdp-project/xdp-tools/tree/master/xdp-monitor

> 
>       nh_off = sizeof(*eth);
>       if (data + nh_off > data_end)
> -        return rc;
> +        return XDP_DROP;
> 
>       h_proto = eth->h_proto;
> 
> @@ -69,7 +68,7 @@ int xdp_prog1(struct xdp_md *ctx)
>           vhdr = data + nh_off;
>           nh_off += sizeof(struct vlan_hdr);
>           if (data + nh_off > data_end)
> -            return rc;
> +            return XDP_DROP;

Use XDP_ABORTED

>           h_proto = vhdr->h_vlan_encapsulated_proto;
>       }
>       /* Handle double VLAN tagged packet */
> @@ -79,7 +78,7 @@ int xdp_prog1(struct xdp_md *ctx)
>           vhdr = data + nh_off;
>           nh_off += sizeof(struct vlan_hdr);
>           if (data + nh_off > data_end)
> -            return rc;
> +            return XDP_DROP;

Use XDP_ABORTED

>           h_proto = vhdr->h_vlan_encapsulated_proto;
>       }
> 
> @@ -94,7 +93,7 @@ int xdp_prog1(struct xdp_md *ctx)
>       if (value)
>           *value += 1;
> 
> -    return rc;
> +    return XDP_DROP;

This is correct.  Here use XDP_DROP.

>   }
> 
>   char _license[] SEC("license") = "GPL";

