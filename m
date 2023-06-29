Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4059742F8A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 23:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232138AbjF2VdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 17:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232096AbjF2VdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 17:33:13 -0400
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E3E72D78;
        Thu, 29 Jun 2023 14:33:12 -0700 (PDT)
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-313f5f5c6c3so358907f8f.1;
        Thu, 29 Jun 2023 14:33:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688074391; x=1690666391;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5sXNz3T27fieAIRTR48zTnONuZ1yBFOaZf/CPHZQ27c=;
        b=fqYdEP12B3fwfPvXsRSCE+l32vUYydG66glkLJquBagDGbkgFeOzcbsSQ96NI1Dk/m
         j47cWTTUEYVThMSdiOkiOkGVSW8mgruiAhUs9aceolA4kim7VB8Vi+kOInBRY8kSTtLy
         R+G6iHoOBLQAdwiMpXn3CWb9Manm+ziTItkM0nJy79z+KRE6+CDCd2yULRHw+i7WntgD
         T4ce11mNYx6+pCMSqqNPURZou72lQUIEiUVIpw/f9/3J7BU7DoagL2vWz1ZxcCYRYqUi
         XhEGIop1QOfQTgR6i1gUIfalmqt8+Uwjh6UDO4g9EGakZ21Gida3iCFhifuWcDi8jNMx
         FzDQ==
X-Gm-Message-State: ABy/qLZNPRQGtnWU1+XZOQKjOZ8k09a18v/RPZBVUIX7whcWdPIBFKsZ
        oiU4v4BbLlhUIpn2EJ2Da04=
X-Google-Smtp-Source: APBJJlHhxv+5GV3Rjo7juNC1oow8yS4xjV2IiwQgUGk5HHlOOrfmZLq+H5OaYbuw+s8Py7L4F8UYoQ==
X-Received: by 2002:adf:e5c1:0:b0:314:1e8:40ca with SMTP id a1-20020adfe5c1000000b0031401e840camr598464wrn.3.1688074390598;
        Thu, 29 Jun 2023 14:33:10 -0700 (PDT)
Received: from [10.100.102.14] (46-116-229-137.bb.netvision.net.il. [46.116.229.137])
        by smtp.gmail.com with ESMTPSA id b3-20020a05600010c300b00313f9367844sm9301920wrx.88.2023.06.29.14.33.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jun 2023 14:33:09 -0700 (PDT)
Message-ID: <6021d82d-ac0f-cc03-d9b2-19dcf20e48ee@grimberg.me>
Date:   Fri, 30 Jun 2023 00:33:07 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH net-next v3 10/18] nvme/host: Use
 sendmsg(MSG_SPLICE_PAGES) rather then sendpage
Content-Language: en-US
To:     David Howells <dhowells@redhat.com>
Cc:     Aurelien Aptel <aaptel@nvidia.com>, netdev@vger.kernel.org,
        Alexander Duyck <alexander.duyck@gmail.com>,
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
References: <a1b7984a-d0a0-087c-2db9-6dbb6400a2bb@grimberg.me>
 <20230620145338.1300897-1-dhowells@redhat.com>
 <20230620145338.1300897-11-dhowells@redhat.com>
 <253mt0il43o.fsf@mtr-vdi-124.i-did-not-set--mail-host-address--so-tickle-me>
 <55023.1688073781@warthog.procyon.org.uk>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <55023.1688073781@warthog.procyon.org.uk>
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


> Sagi Grimberg <sagi@grimberg.me> wrote:
> 
>> simple way to check is to run:
>> nvme_trtype=tcp ./check nvme
> 
> It says a lot of:
> 
> nvme/002 (create many subsystems and test discovery)         [not run]
>      nvme is not available
>      nvme_trtype=tcp is not supported in this test
> nvme/003 (test if we're sending keep-alives to a discovery controller) [not run]
>      nvme is not available
> nvme/004 (test nvme and nvmet UUID NS descriptors)           [not run]
>      nvme is not available
> nvme/005 (reset local loopback target)                       [not run]
>      nvme is not available
> ...
> 
> I have the following NVMe config:
> 
> # NVME Support
> CONFIG_NVME_COMMON=y
> CONFIG_NVME_CORE=y
> CONFIG_BLK_DEV_NVME=y
> CONFIG_NVME_MULTIPATH=y
> # CONFIG_NVME_VERBOSE_ERRORS is not set
> # CONFIG_NVME_HWMON is not set
> CONFIG_NVME_FABRICS=y
> # CONFIG_NVME_RDMA is not set
> # CONFIG_NVME_FC is not set
> CONFIG_NVME_TCP=y
> CONFIG_NVME_AUTH=y
> CONFIG_NVME_TARGET=y
> CONFIG_NVME_TARGET_PASSTHRU=y
> CONFIG_NVME_TARGET_LOOP=y
> # CONFIG_NVME_TARGET_RDMA is not set
> # CONFIG_NVME_TARGET_FC is not set
> CONFIG_NVME_TARGET_TCP=y
> CONFIG_NVME_TARGET_AUTH=y
> # end of NVME Support
> CONFIG_RTC_NVMEM=y
> CONFIG_NVMEM=y
> # CONFIG_NVMEM_SYSFS is not set
> # CONFIG_NVMEM_LAYOUT_SL28_VPD is not set
> # CONFIG_NVMEM_LAYOUT_ONIE_TLV is not set
> # CONFIG_NVMEM_RMEM is not set
> 
> Can you tell me what I'm missing?

install nvme-cli.

nvme/010 is enough to reproduce I think:
nvme_trtype=tcp ./check nvme/010
