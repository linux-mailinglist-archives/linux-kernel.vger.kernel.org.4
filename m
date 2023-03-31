Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1403D6D1CB2
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 11:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232128AbjCaJlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 05:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230505AbjCaJlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 05:41:04 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 455A5A6;
        Fri, 31 Mar 2023 02:41:03 -0700 (PDT)
Received: from [192.168.0.192] (unknown [194.146.248.75])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: andrzej.p)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 480DF6603130;
        Fri, 31 Mar 2023 10:41:01 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1680255661;
        bh=5/vUvHtI483hEvXzPFjmdM6/v042ox+SyVhBgPweyfc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=IA2jSXiD9Eg2q7EqsltfuzR7o8zucquaK7dqov/Bwn+/7znsoAAgHEtq0V+qw8Agp
         eFeXdCAFoJBi1qQxbFQ9x0VM9ahpwftaBV2xQ5KdrEDad6aCnaZ0/AIgbacMfwidah
         UCeSlR1vyfPuw1ssQjzIJNIbAUgSug848qdbPWF4PicQDHegHfbW5RSNbRi1jni0Px
         XvHKHNwuNijFnssPm05PCGDycybOjNIQR9Wwt1b71Whm9hZfsHKLjmzGTap1qRXNvI
         xRq0v+jdw7MV1XbnL0nZLjGOWsm8/AKpoeQ05Yd5xn2SuN2uB9S7+JxuwvQQ93o+xB
         74x2xGtsCHmew==
Message-ID: <c6ce737d-25cc-7f22-7c0f-c0ba1420e57d@collabora.com>
Date:   Fri, 31 Mar 2023 11:40:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 0/3] usb: gadget: functionfs: DMABUF import interface
To:     Paul Cercueil <paul@crapouillou.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Cc:     michael.hennerich@analog.com, nuno.sa@analog.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org
References: <20230322092118.9213-1-paul@crapouillou.net>
Content-Language: en-US
From:   Andrzej Pietrasiewicz <andrzej.p@collabora.com>
In-Reply-To: <20230322092118.9213-1-paul@crapouillou.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

W dniu 22.03.2023 o 10:21, Paul Cercueil pisze:
> Hi,
> 
> This small patchset adds three new IOCTLs that can be used to attach,
> detach, or transfer from/to a DMABUF object.
> 
> Changes since v1:
> - patch [2/3] is new. I had to reuse a piece of code that was already
>    duplicated in the driver, so I factorized the code.
> - Make ffs_dma_resv_lock() static
> - Add MODULE_IMPORT_NS(DMA_BUF);
> - The attach/detach functions are now performed without locking the
>    eps_lock spinlock. The transfer function starts with the spinlock
>    unlocked, then locks it before allocating and queueing the USB
>    transfer.
> 

Can you share an example use case for these new features?
Is there a userspace that excercises the new ioctls?

Regards,

Andrzej
