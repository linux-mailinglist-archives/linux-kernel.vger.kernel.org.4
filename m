Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 840A562709F
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 17:35:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235354AbiKMQf3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 11:35:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233029AbiKMQf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 11:35:26 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A13195A7;
        Sun, 13 Nov 2022 08:35:26 -0800 (PST)
Received: from [192.168.2.125] (109-252-117-140.nat.spd-mgts.ru [109.252.117.140])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E774366022FA;
        Sun, 13 Nov 2022 16:35:23 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1668357324;
        bh=j9qUvJJp/X2OPgESZeNiGJ13HdOpsuZE/t5C9EOgn60=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Ebnk7x7WD+IAH7GwiTF4ZSDyeIVD58Reg5mAKWo/fnoy+gMY7V+jclZpRY1qDficD
         pSgjHK097TZP7s7QChi/ksj65ak0gf1TuSTBBnzLMYQr2qpXePth7QsDpV68dimgfC
         4IBS8MotxvmUB9rqqKi+/OOwxxpPuaaaWgNTY5xTKMkQ5MuFHeREpQINB1SmUSvV+H
         oYx8bQLzayLrj235JY+Bm9J2H77WkDCCZA4J860YY5yOFW5ctQqQhOgPskljYAeW3r
         oIpTX3FjkGka81pG0yKbEvboulAw5ITN6aKfC4zjrI4Ov8ZkOg4NraWwm1MccN5Ir2
         9s6lpcq03HDew==
Message-ID: <50cece73-a499-eba3-7018-9e92e0791c88@collabora.com>
Date:   Sun, 13 Nov 2022 19:35:20 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v2] udmabuf: add vmap method to udmabuf_ops
Content-Language: en-US
To:     Lukasz Wiecaszek <lukasz.wiecaszek@googlemail.com>,
        Gerd Hoffmann <kraxel@redhat.com>
Cc:     Lukasz Wiecaszek <lukasz.wiecaszek@gmail.com>,
        kernel test robot <lkp@intel.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
References: <20221113150511.8878-1-lukasz.wiecaszek@gmail.com>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20221113150511.8878-1-lukasz.wiecaszek@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/13/22 18:05, Lukasz Wiecaszek wrote:
> +static int vmap_udmabuf(struct dma_buf *buf, struct iosys_map *map)
> +{
> +	struct udmabuf *ubuf = buf->priv;
> +
> +	if (!ubuf->vaddr) {
> +		ubuf->vaddr = vm_map_ram(ubuf->pages, ubuf->pagecount, -1);
> +		if (!ubuf->vaddr)
> +			return -EINVAL;
> +	}

Create a new mapping on each vmap_udmabuf() and add the corresponding
vunmap.

Otherwise persistent vmapping shall be released together with udmabuf.
It doesn't look that persistent vmapping is needed for udmabufs.

-- 
Best regards,
Dmitry

