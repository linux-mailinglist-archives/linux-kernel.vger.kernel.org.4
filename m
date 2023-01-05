Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D22AF65EA58
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 13:04:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232404AbjAEMDy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 07:03:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232475AbjAEMDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 07:03:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6735357918
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 04:02:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672920178;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ibf9GZdDPhkI3jtaNrknERTEYTDccCkdl8H694RjOIU=;
        b=RvhAkBHREsb1Tub7Aeg015FCVhcE6sH98eiz6AhLuaf6M/Q9uiKHW1/aw5kkh/9Dxifu7F
        o0spwinT1XrtCvcozMBmB80m8bKS8zldlpgRABYbKAttuWZGZOlDgS9wfykfEYfL9vvLWK
        g7xzCoi6JY1jPmTs5qKVUk9/BhEGoL8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-320-T3MT43YoPCu2pkCTe5nBTA-1; Thu, 05 Jan 2023 07:02:57 -0500
X-MC-Unique: T3MT43YoPCu2pkCTe5nBTA-1
Received: by mail-wm1-f72.google.com with SMTP id fm25-20020a05600c0c1900b003d9702a11e5so17975168wmb.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 04:02:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ibf9GZdDPhkI3jtaNrknERTEYTDccCkdl8H694RjOIU=;
        b=qnd9WJ6mVPUzIOQKDai9dLw64z9SpJXwahShVlF7LsY/Nw/0s8Je/nybD/pZiqiyTA
         ySjQQC8h7Q/38+XHZ/J7RAaBJMFVPcrjOs89jzg5tQ1mYRMdd6pLSPrXpG+2tkkA27NS
         6Li4xfNYQekvgOZxK9s6zeUScLdLpVSWBS/R/+LfKacNPHQ/h/OXCSZQTZPEEGjaBtko
         tTlQFawt/UEa4TLTQVSplnV/wOAdAv3ba2/7t/Uu9XD4TLeiP8FNLRPERtYXOERf6G3k
         IUhOlaawp2v7Y27IyPyvlQbMaw+lhjIxV4t6st6/phXiyAQ/R/9dxXCE6G9wAhORtDnS
         gSbw==
X-Gm-Message-State: AFqh2kq96jX28jmveuf+vvZV51oWcLuzFcyJMqo+v2SXAVRnvGrHKw1p
        jrOtIURDX34rS/X6eTETR8FvbEweIpcw+uFoMDtKYLwK6yp9YamtyBAUd6Py/Z5Y79Uuf4FO9e6
        JN6gJiSYF26InMh5Aisxhc4zs
X-Received: by 2002:a5d:6049:0:b0:2a6:4dfb:80c8 with SMTP id j9-20020a5d6049000000b002a64dfb80c8mr3170978wrt.19.1672920176237;
        Thu, 05 Jan 2023 04:02:56 -0800 (PST)
X-Google-Smtp-Source: AMrXdXupEqgUE2fErAUl67ZowlprXL7LFVObbJvJUg0S8UgOgxyazUFwvvm3lz728p9Sr5H0r2kwpA==
X-Received: by 2002:a5d:6049:0:b0:2a6:4dfb:80c8 with SMTP id j9-20020a5d6049000000b002a64dfb80c8mr3170957wrt.19.1672920175976;
        Thu, 05 Jan 2023 04:02:55 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-105-31.dyn.eolo.it. [146.241.105.31])
        by smtp.gmail.com with ESMTPSA id b14-20020a05600010ce00b0023c8026841csm36155877wrx.23.2023.01.05.04.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 04:02:55 -0800 (PST)
Message-ID: <a8540626a36339bbac8603559b9200a08e4de9ed.camel@redhat.com>
Subject: Re: [PATCH v2] sock: add tracepoint for send recv length
From:   Paolo Abeni <pabeni@redhat.com>
To:     Yunhui Cui <cuiyunhui@bytedance.com>, rostedt@goodmis.org,
        mhiramat@kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, duanxiongchun@bytedance.com, kuniyu@amazon.com,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Date:   Thu, 05 Jan 2023 13:02:53 +0100
In-Reply-To: <20230105100014.1935-1-cuiyunhui@bytedance.com>
References: <20230105100014.1935-1-cuiyunhui@bytedance.com>
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

On Thu, 2023-01-05 at 18:00 +0800, Yunhui Cui wrote:
> Add 2 tracepoints to monitor the tcp/udp traffic
> of per process and per cgroup.
> 
> Regarding monitoring the tcp/udp traffic of each process, the existing
> implementation is https://www.atoptool.nl/netatop.php.
> This solution is implemented by registering the hook function at the hook
> point provided by the netfilter framework.
> 
> These hook functions may be in the soft interrupt context and cannot
> directly obtain the pid. Some data structures are added to bind packets
> and processes. For example, struct taskinfobucket, struct taskinfo ...
> 
> Every time the process sends and receives packets it needs multiple
> hashmaps,resulting in low performance and it has the problem fo inaccurate
> tcp/udp traffic statistics(for example: multiple threads share sockets).
> 
> Based on these 2 tracepoints, we have optimized and tested performance.
> Time Per Request as an indicator, without monitoring: 50.95ms,
> netatop: 63.27 ms, Hook on these tracepoints: 52.24ms.
> The performance has been improved 10 times. The tcp/udp traffic of each
> process has also been accurately counted.
> 
> We can obtain the information with kretprobe, but as we know, kprobe gets
> the result by trappig in an exception, which loses performance compared
> to tracepoint. We did a test for performance comparison. The results are
> as follows. Time per request, sock_sendmsg(k,kr):  12.382ms,
> tcp_send_length(tracepoint): 11.887ms，without hook：11.222ms

12 ms per packet? I hope there is a an error in the unit of
measurement.

I'm unsure the delta wrt kreprobe justifies this change.

In any case you need to include the netdev ML into the recipients list,
and even Cong Wang, as he provided feedback on v1.

Thanks,

Paolo

