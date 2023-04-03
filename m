Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF4226D3E6F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 09:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbjDCHw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 03:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231757AbjDCHw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 03:52:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F32A14496
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 00:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680508328;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CfmV+wOFXKnns71ZOpClIvudOSxllLkZj/NQ9wc0uAk=;
        b=LN0NxH6ybla/RUE5J6xMJJ64jUi+gubOtVze1cdeC+kZxQW200oQB/n2m6ABLQMOsdhSLC
        wXpnUqXwmpnEEfxgeD2yVQlNE6s6GAy4Q1ybF4IOWGPo5QCqVW69JiA5k+AfwfWJlavOxn
        /vkSoHs0gPWND8bLxhWg1hpYCHH7JQ4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-V6t9re3VP_6DKft8iYAx_w-1; Mon, 03 Apr 2023 03:52:07 -0400
X-MC-Unique: V6t9re3VP_6DKft8iYAx_w-1
Received: by mail-wm1-f72.google.com with SMTP id bi27-20020a05600c3d9b00b003ef6ee937b8so10911037wmb.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 00:52:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680508326;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CfmV+wOFXKnns71ZOpClIvudOSxllLkZj/NQ9wc0uAk=;
        b=4H3XcXXrooSc/MNq8O39qKOe7rgDDA4Qsq/pnFXsVN3yVUhD7voJiNDPlBBH9Skq0H
         Csr6zfK1Hnn84g14GozsTQJi+20MgzpHA4t+mPSOpVBiX9fLuBbBMmG5KPTaby8NGGG9
         bIzLBhNRZ0t20+2BIfeHCO6Oc6D2GQl9+v51Pr35zmH41EEX5bx1/GCM1NzKzWjLBdGd
         tyAb25FNNhpHdrZTl7W0szpQdp3JvjwKbubx5jKjGhdSzkghzVo5QVjvf/ei5sYz4hbj
         3M86MKS0uMzF9IyAI9t/dv+qTidkk+ZmQ5WjoFMCuesRD9Yu+ybGV5XCpk0JAX62nO7Q
         cwKQ==
X-Gm-Message-State: AAQBX9cAdMNsJ0vzgJU8JDkT+fn6Muo6K3wSPVH5n4u6PxvPRxHKU3MK
        GKfMJyDGGQLqA4igQ+tb9YHfGWwurA7hL2rd/yPpCgBFJFIqe+2G2i4Lp4FdWjx1qKm0R92owXq
        O/P5sp7z5hORIZxi9sgI5jZWj
X-Received: by 2002:a5d:614f:0:b0:2e6:348:5fef with SMTP id y15-20020a5d614f000000b002e603485fefmr6981497wrt.55.1680508326251;
        Mon, 03 Apr 2023 00:52:06 -0700 (PDT)
X-Google-Smtp-Source: AKy350YqLcTh2LZs5/yGfLsZQWC9Iu45ir7MER2QuysXaRjXJoRZXf8xhePIp7+tIWoLGscvCbRR6g==
X-Received: by 2002:a5d:614f:0:b0:2e6:348:5fef with SMTP id y15-20020a5d614f000000b002e603485fefmr6981489wrt.55.1680508325978;
        Mon, 03 Apr 2023 00:52:05 -0700 (PDT)
Received: from ?IPV6:2003:cb:c702:5e00:8e78:71f3:6243:77f0? (p200300cbc7025e008e7871f3624377f0.dip0.t-ipconnect.de. [2003:cb:c702:5e00:8e78:71f3:6243:77f0])
        by smtp.gmail.com with ESMTPSA id d8-20020a5d6448000000b002c70d97af78sm8982549wrw.85.2023.04.03.00.52.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 00:52:05 -0700 (PDT)
Message-ID: <7e052a12-f3e6-9bce-0611-13a3944207d5@redhat.com>
Date:   Mon, 3 Apr 2023 09:52:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 05/29] selftests/mm: Use TEST_GEN_PROGS where proper
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Nadav Amit <nadav.amit@gmail.com>
References: <20230330155707.3106228-1-peterx@redhat.com>
 <20230330160654.3106929-1-peterx@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230330160654.3106929-1-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.03.23 18:06, Peter Xu wrote:
> TEST_GEN_PROGS and TEST_GEN_FILES are used randomly in the mm/Makefile to
> specify programs that need to build.  Logically all these binaries should
> all fall into TEST_GEN_PROGS.
> 
> Replace those TEST_GEN_FILES with TEST_GEN_PROGS, so that we can reference
> all the tests easily later.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---

Yes, makes sense

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

