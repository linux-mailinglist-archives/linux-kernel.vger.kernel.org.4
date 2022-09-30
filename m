Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 860645F04D5
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 08:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbiI3Gcr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 02:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbiI3Gcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 02:32:42 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0FFA1F7EF0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 23:32:38 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id bh13so3379273pgb.4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 23:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=3/r9sEUFsrXGDfR2A939Zx+57F6Hk0ETCIfd1KtmpRg=;
        b=rmmTyeDlrcMvucl2X8jk6lyNFKDDEWmaR1R4JCIcG898/vY5v/QeVWWbr7ND97HZXm
         jjLvF6wZNjMY29QFrhV+SvySRh5+x87c6qfpna+BvQkNsSVfc+gMOpL896GSnQCdD+ek
         ARz9Ah2SCAXym3K6YdRXhYuMFrEfU0d7HWvRmgxLanc/WwRPzE8JZrTMyiaczojlMQMA
         t6jsQAtYH2Prs8btPOienzHK6sKYqrnzWmlj0K9klmUYm/TYAkUf9tYEFlH5ZGQdTiaJ
         NxTnaNZBMdy5cNDXoo3fYw5Pt6JDEOD6oyf9mAVaQX/yGNdxADrTvLNSZoABBhn0aVwj
         EjmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=3/r9sEUFsrXGDfR2A939Zx+57F6Hk0ETCIfd1KtmpRg=;
        b=dgE3PNBSlRHgH2lNH5XIjhF1yq8VdlKfjzz6L7gzu/K+VJoqyt3qs+0oGnRMULyKE2
         JDh8xmgM8SUYpUAZjy6M+fq0i2mA66JEgZXtDXMsWDLX2OFtd1jSyFcpoSMA3lZJAWQN
         UKBkujyh7TQRkL2XzTXIWbeqxJAQwUXIyGrxIUq5vXrgbMYg9fu+rA/F7+5IqK1uI020
         QaIbLkswJhYamUKsAhzTnD4dN+GpfXaPntiBqZ1xosLK8NjIvOyeSRYYoQHRT1hvYKLT
         1h9LxDwkSg23Des8uPeLgwm1/qeZusv0BX1EhNu/hgsViSf7QhPBsmRxTXE4hqeyH3zM
         IzaQ==
X-Gm-Message-State: ACrzQf1nqpv3XQ5jnR3ZjePk1kqEAuGLtXK9z9nVpYJ/W0Xbv9dFwp7w
        L7rundlTPwjRLGqs6h6+GShhq1yPn1Dow4O7
X-Google-Smtp-Source: AMsMyM75BgOGM6enaUG+dcjqUPmj+21zjwkjTEJhxTbztGdX3rV1Ju/EWf7NfE5uXStduInthENftw==
X-Received: by 2002:a63:f014:0:b0:43c:2ad9:ae9 with SMTP id k20-20020a63f014000000b0043c2ad90ae9mr6385345pgh.8.1664519556735;
        Thu, 29 Sep 2022 23:32:36 -0700 (PDT)
Received: from [10.76.53.66] ([61.120.150.74])
        by smtp.gmail.com with ESMTPSA id o1-20020a17090ab88100b00203059fc75bsm865642pjr.5.2022.09.29.23.32.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Sep 2022 23:32:36 -0700 (PDT)
Message-ID: <e8a49353-8ade-79c3-474d-90b5079f38ca@bytedance.com>
Date:   Fri, 30 Sep 2022 14:31:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: Re: [PATCH v2 RESEND] virtio-crypto: fix memory-leak
Content-Language: en-US
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     mst@redhat.com, arei.gonglei@huawei.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220919075158.3625-1-helei.sig11@bytedance.com>
 <YzaJPuXVrB97ixvI@gondor.apana.org.au>
From:   zhenwei pi <pizhenwei@bytedance.com>
In-Reply-To: <YzaJPuXVrB97ixvI@gondor.apana.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/30/22 14:14, Herbert Xu wrote:
> On Mon, Sep 19, 2022 at 03:51:58PM +0800, Lei He wrote:
>> From: lei he <helei.sig11@bytedance.com>
>>
>> Fix memory-leak for virtio-crypto akcipher request, this problem is
>> introduced by 59ca6c93387d3(virtio-crypto: implement RSA algorithm).
>> The leak can be reproduced and tested with the following script
>> inside virtual machine:
>>
>> #!/bin/bash
>>
>> LOOP_TIMES=10000
>>
>> # required module: pkcs8_key_parser, virtio_crypto
>> modprobe pkcs8_key_parser # if CONFIG_PKCS8_PRIVATE_KEY_PARSER=m
>> modprobe virtio_crypto # if CONFIG_CRYPTO_DEV_VIRTIO=m
>> rm -rf /tmp/data
>> dd if=/dev/random of=/tmp/data count=1 bs=230
>>
>> # generate private key and self-signed cert
>> openssl req -nodes -x509 -newkey rsa:2048 -keyout key.pem \
>> 		-outform der -out cert.der  \
>> 		-subj "/C=CN/ST=GD/L=SZ/O=vihoo/OU=dev/CN=always.com/emailAddress=yy@always.com"
>> # convert private key from pem to der
>> openssl pkcs8 -in key.pem -topk8 -nocrypt -outform DER -out key.der
>>
>> # add key
>> PRIV_KEY_ID=`cat key.der | keyctl padd asymmetric test_priv_key @s`
>> echo "priv key id = "$PRIV_KEY_ID
>> PUB_KEY_ID=`cat cert.der | keyctl padd asymmetric test_pub_key @s`
>> echo "pub key id = "$PUB_KEY_ID
>>
>> # query key
>> keyctl pkey_query $PRIV_KEY_ID 0
>> keyctl pkey_query $PUB_KEY_ID 0
>>
>> # here we only run pkey_encrypt becasuse it is the fastest interface
>> function bench_pub() {
>> 	keyctl pkey_encrypt $PUB_KEY_ID 0 /tmp/data enc=pkcs1 >/tmp/enc.pub
>> }
>>
>> # do bench_pub in loop to obtain the memory leak
>> for (( i = 0; i < ${LOOP_TIMES}; ++i )); do
>> 	bench_pub
>> done
>>
>> Signed-off-by: lei he <helei.sig11@bytedance.com>
>> Acked-by: Michael S. Tsirkin <mst@redhat.com>
>> Reviewed-by: Gonglei <arei.gonglei@huawei.com>
>> ---
>>   drivers/crypto/virtio/virtio_crypto_akcipher_algs.c | 4 ++++
>>   1 file changed, 4 insertions(+)
> 
> Patch applied.  Thanks.

Hi,

I noticed that MST has already applied on vhost branch.
https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git/commit/?h=vhost&id=1bedcf22c081a6e9943f09937b2da8d3ef52d20d

Thanks.

-- 
zhenwei pi
