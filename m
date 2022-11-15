Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11EF4629414
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 10:16:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbiKOJP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 04:15:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232235AbiKOJPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 04:15:53 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A00AF6401
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 01:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668503690;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QUlmfWvjqj8dNincCeQoVu54aDrOsJgpiyJRviE7Jqg=;
        b=QuF4ctenZfM8SwjS7Nkb61HPEjjv5UqSmh0/tZAOLVSbOXwsJKnhx5Gx4+uK7DyeicQyr5
        ewirjAuXkOwDLlH/t6fWt0lVmxlZyjkPuUKDSLUTedFVRdLfc27+/7ZHp20aY00MsPKnwJ
        TDHtSU6nWwSDdCBjRqZ9lyBfa5hBm2E=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-591-r6XmX4H3O76Die8FRkW_VQ-1; Tue, 15 Nov 2022 04:14:49 -0500
X-MC-Unique: r6XmX4H3O76Die8FRkW_VQ-1
Received: by mail-qk1-f197.google.com with SMTP id q14-20020a05620a0d8e00b006ef0350dae1so13117706qkl.12
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 01:14:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QUlmfWvjqj8dNincCeQoVu54aDrOsJgpiyJRviE7Jqg=;
        b=tyv7A8w3bCEwqH+zn324jxsp/e99I6Uq18gqV/n3Iv0ucpnm5XOAjYOXPyOV5Y+7/G
         JzszPgg+zQicNsdB5/0wxQ6TJM5C2tvyZ9+sxcllw1dsDyR8RVDsv/yblVYvdeCx1tFB
         jLBoRPwp/yLFs6NYUD8n5bIsZpn8qCX0pFGlMAGaNv3DbRnCDRxZcU1fLP519OyPr0O+
         7HmuFStYzMn4c87SHw7F8SWyWX5QY4CIeWyJGoLcu6YMbZZAbktd5c0T1U/vBV5G8Xee
         l3LcX2jPLglX/Wki+eHnz/gSE1uDqTtxU8GYgOD4AaSUZoWSw9QzOh5z0mRNF0Hax9Xf
         vEvg==
X-Gm-Message-State: ANoB5pnieGV1cYBJ+XojSfVAt88+JV0c6IFP5f5mA0GLObYu2/TgS843
        1fqUPPUTrIgZBJbhcgjiD6yCy/TzWtXwbjq9/iyZucpnNz6hu6mUNiUZxp18V2MAcmxWQOZqXBR
        i8n/K59uM1aBZ0hF7wOJ9qcBo
X-Received: by 2002:ac8:4753:0:b0:3a5:2967:f8b6 with SMTP id k19-20020ac84753000000b003a52967f8b6mr16136304qtp.86.1668503688911;
        Tue, 15 Nov 2022 01:14:48 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5kPGzH6TAYidTWhoRRNJZnO12+Iz2KB2TJB9oSggbmRGNx8qM+cPaPCGkx0WO11mTIWU8ztA==
X-Received: by 2002:ac8:4753:0:b0:3a5:2967:f8b6 with SMTP id k19-20020ac84753000000b003a52967f8b6mr16136287qtp.86.1668503688705;
        Tue, 15 Nov 2022 01:14:48 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-120-203.dyn.eolo.it. [146.241.120.203])
        by smtp.gmail.com with ESMTPSA id h12-20020a05620a400c00b006b949afa980sm7880319qko.56.2022.11.15.01.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 01:14:47 -0800 (PST)
Message-ID: <9317e4d90174f7158e5e2856edc193a4bcefc04e.camel@redhat.com>
Subject: Re: [PATCH net-next v6] net/sock: Introduce trace_sk_data_ready()
From:   Paolo Abeni <pabeni@redhat.com>
To:     Peilin Ye <yepeilin.cs@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     Peilin Ye <peilin.ye@bytedance.com>,
        Cong Wang <cong.wang@bytedance.com>,
        Leon Romanovsky <leon@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 15 Nov 2022 10:14:44 +0100
In-Reply-To: <20221110023458.2726-1-yepeilin.cs@gmail.com>
References: <20221110023458.2726-1-yepeilin.cs@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
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

On Wed, 2022-11-09 at 18:34 -0800, Peilin Ye wrote:
> As suggested by Cong, introduce a tracepoint for all ->sk_data_ready()
> callback implementations.  For example:
> 
> <...>
>   ksoftirqd/0-16  [000] ..s..  99.784482: sk_data_ready: family=10 protocol=58 func=sock_def_readable
>   ksoftirqd/0-16  [000] ..s..  99.784819: sk_data_ready: family=10 protocol=58 func=sock_def_readable
> <...>

It looks like this does not touch/include sk_psock_strp_data_ready(),
why?

thanks!

Paolo

