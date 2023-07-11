Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9294A74F21C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 16:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233799AbjGKOYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 10:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233979AbjGKOXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 10:23:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F011FD3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 07:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689085308;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JBoxNuRKO8Odbj9dJum9thOQusIAmG6oQ4aiWp/kYHY=;
        b=cZBdRbCca/3SoVY9DvcuEhHoPftjCh5HchDsKQkTTd1FBZyMlodQFdxRETA2H9cY9R+216
        XlzbewjxCvpuPjILvl+BIkq/kFkJ1vaCxFW/19BrjXVjQvJHI051q+ZflQFnJgopxgzKQ2
        qyeVENvQ9/8z/vs2BptibKVnYNfTGjY=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-QFSvxafaMkuMVTQyS7eOLg-1; Tue, 11 Jul 2023 10:21:45 -0400
X-MC-Unique: QFSvxafaMkuMVTQyS7eOLg-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-506b21104faso3867912a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 07:21:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689085303; x=1691677303;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JBoxNuRKO8Odbj9dJum9thOQusIAmG6oQ4aiWp/kYHY=;
        b=e9s0bYFPwJRA0aR/BEWhF5eX4kmbyhhbt4T8gat4+eb78ZDR0uj3HKSqXwzm7o8fkq
         dCfSYHr6Lb0kZAM7g6BvbnC/aV+002O3C255aYHnvUiM/9t4PHfhvkqybFt+ObuYszju
         8v9eHLNp5otVqCu9Ym45XZvcg5Ng9ZvcF+TFf0V2mx/FQP8EIfBBqvZLlvuzdLPKqwv2
         miUFhj2cmoQCjrEHuBo1tSX3holAp0KawDyxf/O6jdzrl8e843/gusUmtxhGChMN4vbR
         byeiUQIHlxIh9PSFBSHWMdU5pQE/5EONN9qX+gywiHOni2ALlxhpH1wtIcdtVujQMQxZ
         dMTQ==
X-Gm-Message-State: ABy/qLZuvTA+9cPwCDK7IydW5ErUaDaxPuRc9i9C+RMei/Ybh+JoRGBq
        3QiqWI4y8rWvYgXC8YT3n4JDEK1f3Gfv4Iz2s1j4Nv/ZZJ0dNZ3PUg5ry8ZvTHaJh8v0hEht8oF
        Sbd8rH+Kwf+ZVaxO65yWu8+ZJ
X-Received: by 2002:a05:6402:5170:b0:51d:e20c:59e4 with SMTP id d16-20020a056402517000b0051de20c59e4mr15160891ede.29.1689085303776;
        Tue, 11 Jul 2023 07:21:43 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHQzjFQLgODxnlwxJH2X5hdNDnii+BX1zti/bW0srr3Gg9oD8DJpENBl8r9f/T+qWzknzkv2Q==
X-Received: by 2002:a05:6402:5170:b0:51d:e20c:59e4 with SMTP id d16-20020a056402517000b0051de20c59e4mr15160856ede.29.1689085303439;
        Tue, 11 Jul 2023 07:21:43 -0700 (PDT)
Received: from [192.168.42.100] (194-45-78-10.static.kviknet.net. [194.45.78.10])
        by smtp.gmail.com with ESMTPSA id by26-20020a0564021b1a00b0050488d1d376sm1356785edb.0.2023.07.11.07.21.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jul 2023 07:21:42 -0700 (PDT)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <a05a4ac2-40c8-da67-6727-b9844930386e@redhat.com>
Date:   Tue, 11 Jul 2023 16:21:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Cc:     brouer@redhat.com, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf] xdp: use trusted arguments in XDP hints kfuncs
Content-Language: en-US
To:     Larysa Zaremba <larysa.zaremba@intel.com>, bpf@vger.kernel.org,
        Stanislav Fomichev <sdf@google.com>
References: <20230711105930.29170-1-larysa.zaremba@intel.com>
In-Reply-To: <20230711105930.29170-1-larysa.zaremba@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/07/2023 12.59, Larysa Zaremba wrote:
> Currently, verifier does not reject XDP programs that pass NULL pointer to
> hints functions. At the same time, this case is not handled in any driver
> implementation (including veth). For example, changing
> 
> bpf_xdp_metadata_rx_timestamp(ctx, &timestamp);
> 
> to
> 
> bpf_xdp_metadata_rx_timestamp(ctx, NULL);
> 
> in xdp_metadata test successfully crashes the system.
> 
> Add KF_TRUSTED_ARGS flag to hints kfunc definitions, so driver code
> does not have to worry about getting invalid pointers.
> 

Looks good to me, assuming this means verifier will reject BPF-prog's 
supplying NULL.

Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>

> Fixes: 3d76a4d3d4e5 ("bpf: XDP metadata RX kfuncs")
> Reported-by: Stanislav Fomichev <sdf@google.com>
> Closes: https://lore.kernel.org/bpf/ZKWo0BbpLfkZHbyE@google.com/
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> ---
>   net/core/xdp.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/core/xdp.c b/net/core/xdp.c
> index 41e5ca8643ec..8362130bf085 100644
> --- a/net/core/xdp.c
> +++ b/net/core/xdp.c
> @@ -741,7 +741,7 @@ __bpf_kfunc int bpf_xdp_metadata_rx_hash(const struct xdp_md *ctx, u32 *hash,
>   __diag_pop();
>   
>   BTF_SET8_START(xdp_metadata_kfunc_ids)
> -#define XDP_METADATA_KFUNC(_, name) BTF_ID_FLAGS(func, name, 0)
> +#define XDP_METADATA_KFUNC(_, name) BTF_ID_FLAGS(func, name, KF_TRUSTED_ARGS)
>   XDP_METADATA_KFUNC_xxx
>   #undef XDP_METADATA_KFUNC
>   BTF_SET8_END(xdp_metadata_kfunc_ids)

