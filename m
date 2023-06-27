Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0350D73F652
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 10:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbjF0ICZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 04:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjF0ICU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 04:02:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E59221BEF
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 01:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687852887;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oZVrQ3elX4XCNFCp5FYtuzZCCkQ+mBaJA/Ngz6/9n5g=;
        b=Ktop0jHvHSlBtMNgVmQjBL2s+o/Zun+USmnmHYiS8sRgMQVPeJyUxxENnNtxXH/2oOshfq
        1b5P9v1X1lb/wmcuNUqB9t9hHvcSqJqhFgSN19USfqYmb6bGVpOFHEQQsiyEfa+a27dMWi
        mvzxW0mK8Wn9I8beAQos7wdE4CABEe0=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-P0kdtyvAM1-9GEeviLWtiQ-1; Tue, 27 Jun 2023 04:01:25 -0400
X-MC-Unique: P0kdtyvAM1-9GEeviLWtiQ-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-98277fac2a1so312679566b.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 01:01:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687852883; x=1690444883;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oZVrQ3elX4XCNFCp5FYtuzZCCkQ+mBaJA/Ngz6/9n5g=;
        b=YhOcLvPo6hGRmz4m/bnHjmJ69VTyZjWXW6whnEvd3VC/jWkKH6RrUoLglUXhWZcVCp
         W3q6qLsQg5w8k4QdqePMXciNLyksDVy4yxj8LunU89KoPM/91SsGIxvBsi2y8uFVLsF6
         wGfUFe/QJgsGySeRIJVm6U95A6SNV9tufVK7Z14WyaoHJ704tvn99DffbMf0cPVOZY2H
         AfIFrcY3yMr0ZPYkb+6u/4WrPk0vh6QcHw+TKujt4rq2my+zn4+AXRoi8yTWI92a+DIz
         5rINHDaZPtuwClTP9lq8NwEcS1stQGtMCibtuunmKTSEXEddFTN0aNT0o4+RYoxAm0Vf
         oO2w==
X-Gm-Message-State: AC+VfDy6w1rBCDFETAbkD1pu009fdS34cgAmJaJX61XstVddQxKgYExm
        wQe75UbnSYld/b8liZ+lC6A9HJga87zoiVy6V6n4P2UiqVMopJN5RikLdDde3RT2tMs7+J4UMKC
        6xRpfyspMVUetiN/DEMRog3t8
X-Received: by 2002:a17:907:16a1:b0:988:d1d5:cd5b with SMTP id hc33-20020a17090716a100b00988d1d5cd5bmr22462638ejc.75.1687852883133;
        Tue, 27 Jun 2023 01:01:23 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7Z0J/vWmfnxp6OJSKZUcEDuPdK0byEs7sKI3sU5hfyvYS5pWlrPir4/Xy8z0GyEbfTC147Zw==
X-Received: by 2002:a17:907:16a1:b0:988:d1d5:cd5b with SMTP id hc33-20020a17090716a100b00988d1d5cd5bmr22462601ejc.75.1687852882783;
        Tue, 27 Jun 2023 01:01:22 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-160.retail.telecomitalia.it. [87.11.6.160])
        by smtp.gmail.com with ESMTPSA id re3-20020a170906d8c300b00977ca5de275sm4307511ejb.13.2023.06.27.01.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 01:01:22 -0700 (PDT)
Date:   Tue, 27 Jun 2023 10:01:11 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Arseniy Krasnov <avkrasnov@sberdevices.ru>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Bobby Eshleman <bobby.eshleman@bytedance.com>,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@sberdevices.ru, oxffffaa@gmail.com
Subject: Re: [RFC PATCH v4 00/17] vsock: MSG_ZEROCOPY flag support
Message-ID: <vqh472etosyyht53hd3bafvtuaedwhqsuqwdbmfkd6lyvxkkgq@mnp42ujut5ox>
References: <20230603204939.1598818-1-AVKrasnov@sberdevices.ru>
 <kilgxopbdguge4bd6pfdjb3oqzemttwzf4na54xurwl62hi7uc@2njjwuhox3al>
 <352508dd-1ea2-5d2d-9ccf-dfcfbd2bb911@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <352508dd-1ea2-5d2d-9ccf-dfcfbd2bb911@sberdevices.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2023 at 07:55:58AM +0300, Arseniy Krasnov wrote:
>
>
>On 26.06.2023 19:15, Stefano Garzarella wrote:
>> On Sat, Jun 03, 2023 at 11:49:22PM +0300, Arseniy Krasnov wrote:

[...]

>>>
>>>           LET'S SPLIT PATCHSET TO MAKE REVIEW EASIER
>>>
>>> In v3 Stefano Garzarella <sgarzare@redhat.com> asked to split this patchset
>>> for several parts, because it looks too big for review. I think in this
>>> version (v4) we can do it in the following way:
>>>
>>> [0001 - 0005] - this is preparation for virtio/vhost part.
>>> [0006 - 0009] - this is preparation for AF_VSOCK part.
>>> [0010 - 0013] - these patches allows to trigger logic from the previous
>>>                two parts.
>>> [0014 - rest] - updates for doc, tests, utils. This part doesn't touch
>>>                kernel code and looks not critical.
>>
>> Yeah, I like this split, but I'd include 14 in the (10, 13) group.
>>
>> I have reviewed most of them and I think we are well on our way :-)
>> I've already seen that Bobby suggested changes for v5, so I'll review
>> that version better.
>>
>> Great work so far!
>
>Hello Stefano!

Hi Arseniy :-)

>
>Thanks for review! I left some questions, but most of comments are clear
>for me. So I guess that idea of split is that I still keep all patches in
>a big single patchset, but preserve structure described above and we will
>do review process step by step according split?
>
>Or I should split this patchset for 3 separated sets? I guess this will be
>more complex to review...

If the next is still RFC, a single series is fine.

Thanks,
Stefano

