Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 377397428D4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 16:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232000AbjF2OuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 10:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232371AbjF2Otx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 10:49:53 -0400
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDCFC1FC1;
        Thu, 29 Jun 2023 07:49:51 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-4f14e14dc00so209083e87.1;
        Thu, 29 Jun 2023 07:49:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688050190; x=1690642190;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2+V2QoP1g+tUtgNa3Zg1YUxv30ED+AV1SxmDuok5KeI=;
        b=JDZStez5PKlC3FpshYjQz+hLy8Pzak6gseFnGS1kTqKMqCUBxUBafP5NemXuSvGDhn
         sdfG3xGlXaHMSxjyEGezZKJ9uhDROd5xoGrfIBf6kGdSNbZie0PF6/cNTt2qu4qmxYly
         6X28ojwOV71RWWQ68Vv3NsUOJGQ0zvAahh+kCSkvd5D7rlez+8doHiSuyVvBxs96t+0L
         0wvD7dE09TiIjaoEOrpqwSrQg/BxNmfvq9juV4f8dibvOr2UBYBiGVRzbtpJC90sXuig
         49w0bhXEuXAajC5UtX/w3eJfkTPq6Sq0qXYbR7n9uASj/we9BF6PAMkzR55b6RSldNwe
         vF3w==
X-Gm-Message-State: ABy/qLYH1K3JiRzT6T4MYSBouAg4wXr7O0tJ085zncVeCabeU0I/fZkR
        s4KAW5hcOaMHa+Hm4Nc3A5M=
X-Google-Smtp-Source: APBJJlHFD7hzN7Y6/gs5D8g7Wgnjk2WzxoDiPG1+WoxbmItuuVfbd1xLD5VmbMR/3dURiDtF7IasRQ==
X-Received: by 2002:ac2:5499:0:b0:4fb:8cb9:7ad8 with SMTP id t25-20020ac25499000000b004fb8cb97ad8mr120263lfk.2.1688050189484;
        Thu, 29 Jun 2023 07:49:49 -0700 (PDT)
Received: from [10.100.102.14] (46-116-229-137.bb.netvision.net.il. [46.116.229.137])
        by smtp.gmail.com with ESMTPSA id c6-20020a05600c0ac600b003f9c0a7c6bcsm16709186wmr.0.2023.06.29.07.49.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jun 2023 07:49:48 -0700 (PDT)
Message-ID: <a1b7984a-d0a0-087c-2db9-6dbb6400a2bb@grimberg.me>
Date:   Thu, 29 Jun 2023 17:49:46 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH net-next v3 10/18] nvme/host: Use
 sendmsg(MSG_SPLICE_PAGES) rather then sendpage
Content-Language: en-US
To:     Aurelien Aptel <aaptel@nvidia.com>,
        David Howells <dhowells@redhat.com>, netdev@vger.kernel.org
Cc:     Alexander Duyck <alexander.duyck@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Willem de Bruijn <willemb@google.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        linux-nvme@lists.infradead.org
References: <20230620145338.1300897-1-dhowells@redhat.com>
 <20230620145338.1300897-11-dhowells@redhat.com>
 <253mt0il43o.fsf@mtr-vdi-124.i-did-not-set--mail-host-address--so-tickle-me>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <253mt0il43o.fsf@mtr-vdi-124.i-did-not-set--mail-host-address--so-tickle-me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Hi David,
> 
> David Howells <dhowells@redhat.com> writes:
>> When transmitting data, call down into TCP using a single sendmsg with
>> MSG_SPLICE_PAGES to indicate that content should be spliced rather than
>> performing several sendmsg and sendpage calls to transmit header, data
>> pages and trailer.
> 
> This series makes my kernel crash.
> 
>  From the current net-next main branch:
> 
> commit 9ae440b8fdd6772b6c007fa3d3766530a09c9045 (HEAD)
> Merge: b545a13ca9b2 b848b26c6672
> Author: Jakub Kicinski <kuba@kernel.org>
> Date:   Sat Jun 24 15:50:21 2023 -0700
> 
>      Merge branch 'splice-net-switch-over-users-of-sendpage-and-remove-it'
> 
> 
> Steps to reproduce:
> 
> * connect a remote nvme null block device (nvmet) with 1 IO queue to keep
>    things simple
> * open /dev/nvme0n1 with O_RDWR|O_DIRECT|O_SYNC
> * write() a 8k buffer or 4k buffer

Most likely this also reproduces with blktests?
https://github.com/osandov/blktests

simple way to check is to run:
nvme_trtype=tcp ./check nvme

This runs nvme tests over nvme-tcp.

No need for network, disk or anything. It runs
both nvme and nvmet over the lo device..
