Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15F5D70D48E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 09:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234752AbjEWHKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 03:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbjEWHKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 03:10:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F6E1AD
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 00:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684825728;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LOz9tVG9x8wjs/mkyWBOZ9NlyDU6uZrwJP+l+b0a7Mw=;
        b=CfPi5/sbSPNnqbInJLY0Lsf4MWMowZMn8q2z4IFm9VgUryg0TZ+x2ci/4p4rYX/zdG9IGc
        QP8S4P0JX8t/65M8+Tot3OMnAARlK6BY4rKuWsbLBi0cBUShnJfEt36+Bhc5moSJgVT8xx
        a7Lm+HU+Qt+4XaEVkCKkK1DiHJRefyE=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-47-rUrqqJGtMTi-zcaYZyvtvA-1; Tue, 23 May 2023 03:08:46 -0400
X-MC-Unique: rUrqqJGtMTi-zcaYZyvtvA-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-513fd7d56c8so647155a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 00:08:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684825725; x=1687417725;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LOz9tVG9x8wjs/mkyWBOZ9NlyDU6uZrwJP+l+b0a7Mw=;
        b=AW6EvK5FWmRjnmn6uGTD8PN6Q1bCxtLLD4V7ZtCIs+gItgmYVdeidX7h4MA+Up9olH
         kmIOtvk/bwu0aOGzN+QV0nHMFBOzMjOMwgDqIM3a2Xkt4nLxOHZDdraRbb5h4l3OFLvU
         wKjmoJRc0Mu9lwN+vAlNN8npwufbsmUPFxltqHognfYIYOr1dYvG409Dfdwb4NIjWdAt
         lHZXYDFBcEEpNi3z2rEUKv0IuUo6zRdcSaKg4el80rHGujnvquyFlRXtoZszpfOyLCRR
         m11/7usL8sC7s1V8Vodqf8S1fnRcsNkFNZVJtGC4Ud0DcYz25LU2ReSsM3o5j/fbngFX
         l/kw==
X-Gm-Message-State: AC+VfDzC1vi9eUjGMPF635kFR3i26ZI7i+TBLsnviIL136R/ErC/rV7I
        Q7/OX/4g6x2QKxvJB0oeyB4cl9+o7W/uCAjKjBnfd2PTXQI0pFKDvEkU0KdJmXqGK8lMTs2ZX0K
        sVkBhYiY1gigKBC8JvwK62CQp
X-Received: by 2002:a50:ee1a:0:b0:50b:c6c9:2146 with SMTP id g26-20020a50ee1a000000b0050bc6c92146mr9723039eds.24.1684825725404;
        Tue, 23 May 2023 00:08:45 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7r0KyZvF1P8bIJjcAyAEYuwFSDbk1QeSc8w7+b44a2OSQmNXDLpyl4LSdCVvXDn7j7nE3cTQ==
X-Received: by 2002:a50:ee1a:0:b0:50b:c6c9:2146 with SMTP id g26-20020a50ee1a000000b0050bc6c92146mr9723018eds.24.1684825725091;
        Tue, 23 May 2023 00:08:45 -0700 (PDT)
Received: from [192.168.42.222] (194-45-78-10.static.kviknet.net. [194.45.78.10])
        by smtp.gmail.com with ESMTPSA id by28-20020a0564021b1c00b00508804f3b1dsm3783199edb.57.2023.05.23.00.08.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 May 2023 00:08:44 -0700 (PDT)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <c6c44d10-d283-7a26-8597-6be6e29bc832@redhat.com>
Date:   Tue, 23 May 2023 09:08:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Cc:     brouer@redhat.com, davem@davemloft.net, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>
Subject: Re: [PATCH net] page_pool: fix inconsistency for
 page_pool_ring_[un]lock()
Content-Language: en-US
To:     Yunsheng Lin <linyunsheng@huawei.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Jesper Dangaard Brouer <jbrouer@redhat.com>
References: <20230522031714.5089-1-linyunsheng@huawei.com>
 <1fc46094-a72a-f7e4-ef18-15edb0d56233@redhat.com>
 <CAC_iWjJaNuDFZuv1Rv4Yr5Kaj1Wq69txAoLGepvnJT=pY1gaRw@mail.gmail.com>
 <cc64a349-aaf4-9d80-3653-75eeb3032baf@huawei.com>
In-Reply-To: <cc64a349-aaf4-9d80-3653-75eeb3032baf@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23/05/2023 04.13, Yunsheng Lin wrote:
> Do you still working on optimizing the page_pool destroy
> process? If not, do you mind if I carry it on based on
> that?

I'm still working on improving the page_pool destroy process.
I prefer to do the implementation myself.

I've not submitted another version, because I'm currently using the
workqueue to detect/track a memory leak in mlx5.

The mlx5 driver combined with XDP redirect is leaking memory, and will
eventually lead to OOM.  The workqueue warning doesn't point to the
actual problem, but it makes is easier to notice that there is a problem.

--Jesper

