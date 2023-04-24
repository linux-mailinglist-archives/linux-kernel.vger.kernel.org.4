Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC56C6D62AF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 15:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234908AbjDDNXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 09:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234887AbjDDNW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 09:22:59 -0400
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F4A115;
        Tue,  4 Apr 2023 06:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
        s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=KS/PAoriGWh0QOffAFISIzaXM+OMfc5TD47VKbQqGh4=; b=TUkvrOCa+EQWog7XwVqSljA8HD
        qs2uTEGpr2nmASxWKFA1vB2Poh7nyFNj9w113QvxnlY4tvxhsqQrxoawdCD+od0ySVNeXsqFy4n/2
        xN6eIdhOYuaq2NIb+WxMh7ji1niYAtbXtxi2rwSnmoJoX6zYA4tUeYPjTDsB4DAA2WqtTUsd7Z2V3
        RzKDrAnDsG9wF57PofWXZXvYGQlwAQpuNtcQY9AVARJSbzI+L7nCHVRvUSPqc1UzD/ruTSJGDJu8+
        7iUzG8xnoqjZxlDbVFmxCRzWhp85EjGK/W0E2LUhIlWifeS/8ATIx7/eW3GFWoN6562CF6JaPr/rp
        EVd7tMug==;
Received: from sslproxy04.your-server.de ([78.46.152.42])
        by www381.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <lars@metafoo.de>)
        id 1pjgch-0008PQ-BV; Tue, 04 Apr 2023 15:22:55 +0200
Received: from [2604:5500:c0e5:eb00:da5e:d3ff:feff:933b]
        by sslproxy04.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1pjgcg-0003TQ-Ou; Tue, 04 Apr 2023 15:22:54 +0200
Message-ID: <370bccc6-e418-a05f-2c3b-6a17b02392a2@metafoo.de>
Date:   Tue, 4 Apr 2023 06:22:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 07/11] iio: core: Add new DMABUF interface
 infrastructure
Content-Language: en-US
To:     Paul Cercueil <paul@crapouillou.net>,
        =?UTF-8?Q?Nuno_S=c3=a1?= <noname.nuno@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        dmaengine@vger.kernel.org, linux-media@vger.kernel.org
References: <20230403154800.215924-1-paul@crapouillou.net>
 <20230403154800.215924-8-paul@crapouillou.net>
 <798e1ff0651da8e4b113d30bf8cec2a7a0e6898f.camel@gmail.com>
 <2dac030470ffe74b6d21a1e6510afcefaf58cd6a.camel@crapouillou.net>
From:   Lars-Peter Clausen <lars@metafoo.de>
In-Reply-To: <2dac030470ffe74b6d21a1e6510afcefaf58cd6a.camel@crapouillou.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.8/26865/Tue Apr  4 09:24:56 2023)
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/4/23 00:55, Paul Cercueil wrote:
> [...]
>>> +       priv = attach->importer_priv;
>>> +       list_del_init(&priv->entry);
>>> +
>>> +       iio_buffer_dmabuf_put(attach);
>>> +       iio_buffer_dmabuf_put(attach);
>>> +
>> Is this intended? Looks suspicious...
> It is intended, yes. You want to release the dma_buf_attachment that's
> created in iio_buffer_attach_dmabuf(), and you need to call
> iio_buffer_find_attachment() to get a pointer to it, which also gets a
> second reference - so it needs to unref twice.
Let's add a comment documenting that.
