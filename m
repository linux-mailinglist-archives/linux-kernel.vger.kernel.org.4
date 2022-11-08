Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A123620FDD
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 13:08:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233763AbiKHMIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 07:08:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233300AbiKHMIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 07:08:04 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7126E419BA
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 04:07:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667909231;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IMfMqd/NRcR1JqekXckZSgySkw+5cuSOOLne9X/Ks6Y=;
        b=CSqx/yLAuHBK+fLzn5wIZ1GdF0FCoept9XVaUbRPfrh8s7E4EO6et9kUQEA9bPd5gwtMB/
        w6urv7xyjheblgYdeUuArxj3zug05kt5EzRP/JlIuJiZSSbN7QaZL53JawcKHPtfjugtKU
        EBNWyA/Hsh8pCXxdOHSKRj6ttkLDEjE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-306-trU11BnmOOCpFiVSsTj9OA-1; Tue, 08 Nov 2022 07:07:10 -0500
X-MC-Unique: trU11BnmOOCpFiVSsTj9OA-1
Received: by mail-wm1-f71.google.com with SMTP id 186-20020a1c02c3000000b003cfab28cbe0so2203191wmc.9
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 04:07:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IMfMqd/NRcR1JqekXckZSgySkw+5cuSOOLne9X/Ks6Y=;
        b=dYhzFDkPzUH9SnhDQm2QuCnRz4Fb0D3gRWz91LYWFq4vazbr9akbaB+H8TCSMeSQBT
         qbWyykxV1l1TtjL4FL5r9MzsDyZ0TBVcDnNa5py1dvAu73hc68smvIGlvPF52Uy0Rp4K
         wxai15BbiWncWa2dIXb2yi5Bu5Q9IHC8RWk/XuRolf0nLo0/qzXfOkGh1db1LcN6TcT9
         mLW39R6lBI2cA5OKUzIvk3QVhmseclYC/74VMidm0FkfXvPRk2/uyWGBtl/7HoqQ2DiP
         QgPD0K8/Ka+OA8C5oPGpQh4ty0Tt5eiFliNxMGGxhekMJfybhcl+OFmceIagtVPiFrBm
         9iDQ==
X-Gm-Message-State: ACrzQf0huYCE3WXgRnVjSSw//7KC0O27r7GvEoT4Xkj8VvUl8JQ5utfz
        DhA0FsU/o+exGKyrugvLy9rwGKo4S39YsKFMxF1N7HlAn3IRLcTxt3iwWBR+ZANJraHLWq8IJoD
        r8S/arbJl9tsAtGdRelk1mKKZ
X-Received: by 2002:adf:f58e:0:b0:236:a8b2:373 with SMTP id f14-20020adff58e000000b00236a8b20373mr35753919wro.575.1667909229341;
        Tue, 08 Nov 2022 04:07:09 -0800 (PST)
X-Google-Smtp-Source: AMsMyM671SN4rKjOS4m0IXm1rydtBeGKPVnCuxp/5nq9PqKtGUO9t65vl23IJqhbdg2+p5gCuDL/pw==
X-Received: by 2002:adf:f58e:0:b0:236:a8b2:373 with SMTP id f14-20020adff58e000000b00236a8b20373mr35753898wro.575.1667909229147;
        Tue, 08 Nov 2022 04:07:09 -0800 (PST)
Received: from vschneid.remote.csb ([154.57.232.159])
        by smtp.gmail.com with ESMTPSA id m11-20020a5d4a0b000000b0022ca921dc67sm9877375wrq.88.2022.11.08.04.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 04:07:08 -0800 (PST)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Tariq Toukan <ttoukan.linux@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Tony Luck <tony.luck@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Gal Pressman <gal@nvidia.com>,
        Tariq Toukan <tariqt@nvidia.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>
Subject: Re: [PATCH v6 0/3] sched, net: NUMA-aware CPU spreading interface
In-Reply-To: <ca6a5aee-19c8-e0a9-60af-00e2e5abaed0@gmail.com>
References: <20221028164959.1367250-1-vschneid@redhat.com>
 <20221102195616.6f55c894@kernel.org>
 <ca6a5aee-19c8-e0a9-60af-00e2e5abaed0@gmail.com>
Date:   Tue, 08 Nov 2022 12:07:07 +0000
Message-ID: <xhsmhleolmyz8.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/11/22 13:25, Tariq Toukan wrote:
> On 11/3/2022 4:56 AM, Jakub Kicinski wrote:
>> On Fri, 28 Oct 2022 17:49:56 +0100 Valentin Schneider wrote:
>>> Tariq pointed out in [1] that drivers allocating IRQ vectors would benefit
>>> from having smarter NUMA-awareness (cpumask_local_spread() doesn't quite cut
>>> it).
>>>
>>> The proposed interface involved an array of CPUs and a temporary cpumask, and
>>> being my difficult self what I'm proposing here is an interface that doesn't
>>> require any temporary storage other than some stack variables (at the cost of
>>> one wild macro).
>>>
>>> [1]: https://lore.kernel.org/all/20220728191203.4055-1-tariqt@nvidia.com/
>>
>> Not sure who's expected to take these, no preference here so:
>>
>> Acked-by: Jakub Kicinski <kuba@kernel.org>
>>
>> Thanks for ironing it out!
>
> Thanks Jakub.
>
> Valentin, what do you think?
> Shouldn't it go through the sched branch?

So yeah the topology bits should go through tip/sched/core, and given it's
the only user of the new interface, the mlx5e one should probably be
bundled with them.

