Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA3B6D3E78
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 09:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbjDCHzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 03:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbjDCHzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 03:55:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A04B459EC
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 00:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680508464;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vu07E4mcGmsW/XdsH2pAjRkTwA9fv77SbnjHc1LdXt8=;
        b=SrjClkj3xrtBm51hSwZ0CbENiQeZMyQw5CUbUZhVnU6ZCjY1ZBAvNzEsQufgt2r76zVIqU
        3sRGPYZttZXbyamGMp0rXsbITkv/iDvs1+JmYDpD5DaD7p4cRTcMdBudF2tC6Y5ph0JPqk
        Y24gy0mEFjmVlCcjQA9RwwcEfs+SB6Q=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-kkFfK8-QM2imX51vEUfYIg-1; Mon, 03 Apr 2023 03:54:23 -0400
X-MC-Unique: kkFfK8-QM2imX51vEUfYIg-1
Received: by mail-wm1-f71.google.com with SMTP id k25-20020a05600c1c9900b003ef79f2c207so8588553wms.5
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 00:54:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680508462;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vu07E4mcGmsW/XdsH2pAjRkTwA9fv77SbnjHc1LdXt8=;
        b=3p9TfalpbHq95hvz4l1UzoQGV/1nwiYVjSE4tgN6893iMyySNahaUbbWOvtDQy5ouK
         KpQZhE1TStrmMksu/Jct8WgJVTgOFWZ2u2Om8t2ZF2H3oh0RKOV9GIDU0sTlv/v8CKC7
         uEe8L2RQXiCcLPlLXKMB7v5boFrfSM1x2hBugxhaOMRShbJjrkZCxPfrc861NFjTcK9C
         EIrRosIsIAeYRB7XkeRt2uEsJP+tM03XD6UmJAy8BS49X2GMckQXUqhT3XTgTyi0jqcq
         iPTXqkSMaGwkUB8QK9KgC32FPnbNE9mEgqTNUNEagybxMk885jwYiSHCeHRNJK3pio0A
         SIWA==
X-Gm-Message-State: AAQBX9dkcRS9Pj6c+EJKHIwhsHMETo4mZR96Z6SemvYcLWzNHg+V7yih
        cpagh+wLFFJebvVkM/JvJF2TrRdOotEnH/2qzDmuZG+vDW9iWSLSuLheF9Yk2Mf5Em5sRcd0rlh
        SEhYqp22OdQp6Jhy4ELxOlpq8
X-Received: by 2002:a5d:63d1:0:b0:2d5:b6a9:772a with SMTP id c17-20020a5d63d1000000b002d5b6a9772amr26189149wrw.17.1680508462488;
        Mon, 03 Apr 2023 00:54:22 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZP+t8Vrf8ilJRnxNkGOTK/VDCXZK94pfVth0lrmPAbrX8iwC5pZlpaaaG3TCLbqEk0btdzUA==
X-Received: by 2002:a5d:63d1:0:b0:2d5:b6a9:772a with SMTP id c17-20020a5d63d1000000b002d5b6a9772amr26189133wrw.17.1680508462177;
        Mon, 03 Apr 2023 00:54:22 -0700 (PDT)
Received: from ?IPV6:2003:cb:c702:5e00:8e78:71f3:6243:77f0? (p200300cbc7025e008e7871f3624377f0.dip0.t-ipconnect.de. [2003:cb:c702:5e00:8e78:71f3:6243:77f0])
        by smtp.gmail.com with ESMTPSA id s16-20020adfea90000000b002d21379bcabsm8962216wrm.110.2023.04.03.00.54.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 00:54:21 -0700 (PDT)
Message-ID: <c62e8d61-3665-2ecc-3f08-6e1bfd70a503@redhat.com>
Date:   Mon, 3 Apr 2023 09:54:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 09/29] selftests/mm: Reuse pagemap_get_entry() in
 vm_util.h
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
 <20230330160711.3106988-1-peterx@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230330160711.3106988-1-peterx@redhat.com>
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

On 30.03.23 18:07, Peter Xu wrote:
> Meanwhile drop pagemap_read_vaddr().
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

