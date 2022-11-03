Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78A2C6178A7
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 09:26:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbiKCI0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 04:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbiKCI0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 04:26:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB62657E
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 01:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667463957;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ESwUy2eq+4xGlz2gugPeoCeYS+tEl3uNRsE/pkcv4uU=;
        b=hRPiGh8g1xFkbcaOhevBZe/wv6jlx9eslU6SsG5Lr+srIFrTrqJtRz6hcS/V0C7kN4mNEo
        dL+dq3dt0a3mzTY/Oi2j4nOrv2iKMC3w3SyN7dYIG3pnZIu+7K5cAH0VBNz5kDfjH+Xk8l
        3L019I11T2Fqeeokd86l6Mrnz55vbRQ=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-45-JrNvKezyPfaBf4jDOruD-A-1; Thu, 03 Nov 2022 04:25:54 -0400
X-MC-Unique: JrNvKezyPfaBf4jDOruD-A-1
Received: by mail-qk1-f199.google.com with SMTP id w4-20020a05620a444400b006fa24b2f394so1405065qkp.15
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 01:25:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ESwUy2eq+4xGlz2gugPeoCeYS+tEl3uNRsE/pkcv4uU=;
        b=Cv9iBKreLswsZ3ULghKMB3YygSrrXcUxa7EbRmDO29s8j8idqDniaS1yhyiS56CTYW
         XKCy5P11ixxUBF9Vt69hVrk6f9vGLYJK2WxC1+E+EBLEMF5dTNFUeO+NkadXzePGCGKd
         WqoJasvmJYYyF7WhA5xGU+OCa7BeRbd1A2ltKh4IhaN0VdULcsi5lZbpxBHoBzR8vVuA
         4DEdHaLKAlkUd+D8LF4XRAyqlTXrUsorugyOQWq1K6sQFfn98A16j3j9Ri8CiiNqz5MN
         ZXWf1l4MHsAAN9i9hNYAOTuQ2dXho10Om0t9bNxChLC2HHZVmoWsSt/q5H6K2dHKM6N6
         Kb1g==
X-Gm-Message-State: ACrzQf2DHP2XUBy0QLDfIN8WgtIJogkzifuOFVIKoLvrx9JPek+PnGV6
        60g4Xyx6A/BCaTxHHCf2AiVS3EwdZnussOVDu9SweNOS6njyPo0ARi9lKbgvH2oOWPjLKhJacM4
        TYXNejKI/7yriiHqzDZUnzEB6
X-Received: by 2002:ad4:5dee:0:b0:4b4:b8a:78db with SMTP id jn14-20020ad45dee000000b004b40b8a78dbmr25706647qvb.12.1667463954006;
        Thu, 03 Nov 2022 01:25:54 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5lfV1vi64B14zB3N7D3MkOiVDGIgQ3osl+x4gB5yM3fepRQCIsPO64MdGMmDacIaHFZ9iXbg==
X-Received: by 2002:ad4:5dee:0:b0:4b4:b8a:78db with SMTP id jn14-20020ad45dee000000b004b40b8a78dbmr25706639qvb.12.1667463953770;
        Thu, 03 Nov 2022 01:25:53 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-100-54.dyn.eolo.it. [146.241.100.54])
        by smtp.gmail.com with ESMTPSA id o23-20020ac85557000000b0035badb499c7sm133825qtr.21.2022.11.03.01.25.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 01:25:53 -0700 (PDT)
Message-ID: <477a37b80b01d5eaa895effa20df29bcf02f65b6.camel@redhat.com>
Subject: Re: [PATCH] uapi: Add missing linux/stddef.h header file to in.h
From:   Paolo Abeni <pabeni@redhat.com>
To:     Yang Jihong <yangjihong1@huawei.com>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, keescook@chromium.org,
        gustavoars@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org, acme@kernel.org
Date:   Thu, 03 Nov 2022 09:25:49 +0100
In-Reply-To: <20221031095517.100297-1-yangjihong1@huawei.com>
References: <20221031095517.100297-1-yangjihong1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-10-31 at 17:55 +0800, Yang Jihong wrote:
> commit 5854a09b4957 ("net/ipv4: Use __DECLARE_FLEX_ARRAY() helper") does not
> include "linux/stddef.h" header file, and tools headers update linux/in.h copy,
> BPF prog fails to be compiled:
> 
>     CLNG-BPF [test_maps] bpf_flow.bpf.o
>     CLNG-BPF [test_maps] cgroup_skb_sk_lookup_kern.bpf.o
>   In file included from progs/cgroup_skb_sk_lookup_kern.c:9:
>   /root/linux/tools/include/uapi/linux/in.h:199:3: error: type name requires a specifier or qualifier
>                   __DECLARE_FLEX_ARRAY(__be32, imsf_slist_flex);
>                   ^
>   /root/linux/tools/include/uapi/linux/in.h:199:32: error: type specifier missing, defaults to 'int' [-Werror,-Wimplicit-int]
>                   __DECLARE_FLEX_ARRAY(__be32, imsf_slist_flex);
>                                                ^
>   2 errors generated.
> 
> To maintain consistency, add missing header file to kernel.
> Fixes: 5854a09b4957 ("net/ipv4: Use __DECLARE_FLEX_ARRAY() helper")
> 
> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>

The 'Fixes' tag must be separated by the commit message by a blank
line, and you need to remove the empty line between 'Fixes' and SoB.

Additionally, on repost, please specify the target tree in the patch
subj, and wrap the commit message text to 75 chars per line (that does
not apply to the build output).

Thanks,

Paolo

