Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E07286E4DAB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 17:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbjDQPvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 11:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbjDQPvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 11:51:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC9C6A276
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 08:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681746535;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7wxMSQuAkXI9cFCvxCKTnw1/xApBRZipM9gJxQ7MGaY=;
        b=EIk0Oy1y5ZAPXJU9xM8ul+mDND+4BQ6FPIMxC6LUP8BMcOfly414yKJSn+OJqY7G074JPU
        d8oNLdXzuzkexz5xf60N0Ibb2s/1152/QDgh5o58L8AM6T+vBXNw1w78I3iSqUDN17qoVQ
        kVZjK94+1p5CMlbJB9KNRDO30lc1OOo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-91-gl_ManS5MZ2ZF49zelnFyA-1; Mon, 17 Apr 2023 11:48:53 -0400
X-MC-Unique: gl_ManS5MZ2ZF49zelnFyA-1
Received: by mail-wm1-f71.google.com with SMTP id bg10-20020a05600c3c8a00b003ef7b61e2fdso5356354wmb.4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 08:48:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681746533; x=1684338533;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7wxMSQuAkXI9cFCvxCKTnw1/xApBRZipM9gJxQ7MGaY=;
        b=P0Wu7amOqKgg45Hy2DMvskjtM5cCQwtJAF8+2FB7KAxHO+epDV1HySMvE09FNcpp27
         EzruC3RkeDuCz/O8L3rcCeCOl0xoWtYX9ptYS1GeyuiBbI+9ZB2b6gmIB+Q4DoZ6qwIa
         Eg48c61jazl7kwMGwZbRGqoPZt2UUvUW/TuvBaldfYvft35Xs7dfHNchRqYEpOF0UlOB
         NwgixXH4D1af4nYy+J2/bv0+8993aB6zyLlkKVZLh99TfG+veg3Eloy1a3zFTMuKyCNH
         1VA1Zka34NoCJmeJvY/Yx2nF/FZPGbAx/rGEAP5AbwzwZxi7SUszaEZeQtoP9oVwVVpT
         luQA==
X-Gm-Message-State: AAQBX9ceUXeHpdLQxFgw39nx29R/7dNNlT2Z+/2Ef7NvZJNrJ8Q9MQqj
        71oYUFHSrOYL0ug/zX/NOsUcjxkb+wKhWkI5RwDqA4UpU9JmhiySaRWHGk3H3pDOrv1VWjvYHkN
        V/+QQl14x3FRQ6b9xYIjs629J
X-Received: by 2002:a7b:ce91:0:b0:3ed:e4ac:d532 with SMTP id q17-20020a7bce91000000b003ede4acd532mr12094998wmj.36.1681746532745;
        Mon, 17 Apr 2023 08:48:52 -0700 (PDT)
X-Google-Smtp-Source: AKy350Z/kkuZ9k8vVAAV0sPAD+AAjEjwEWGBQNBxSnsCQt10m6JGA4msRSWOX0jSx9DH/y5hdc5Shw==
X-Received: by 2002:a7b:ce91:0:b0:3ed:e4ac:d532 with SMTP id q17-20020a7bce91000000b003ede4acd532mr12094976wmj.36.1681746532424;
        Mon, 17 Apr 2023 08:48:52 -0700 (PDT)
Received: from [192.168.3.108] (p5b0c6d51.dip0.t-ipconnect.de. [91.12.109.81])
        by smtp.gmail.com with ESMTPSA id s16-20020a05600c319000b003f17122587bsm5278743wmp.36.2023.04.17.08.48.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Apr 2023 08:48:51 -0700 (PDT)
Message-ID: <658018f9-581c-7786-795a-85227c712be0@redhat.com>
Date:   Mon, 17 Apr 2023 17:48:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: Rename restrictedmem => guardedmem? (was: Re: [PATCH v10 0/9]
 KVM: mm: fd-based approach for supporting KVM)
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>,
        Chao Peng <chao.p.peng@linux.intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        dhildenb@redhat.com, Quentin Perret <qperret@google.com>,
        tabba@google.com, Michael Roth <michael.roth@amd.com>,
        wei.w.wang@intel.com, Mike Rapoport <rppt@kernel.org>,
        Liam Merwick <liam.merwick@oracle.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Ackerley Tng <ackerleytng@google.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221202061347.1070246-1-chao.p.peng@linux.intel.com>
 <ZD1oevE8iHsi66T2@google.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <ZD1oevE8iHsi66T2@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.04.23 17:40, Sean Christopherson wrote:
> What do y'all think about renaming "restrictedmem" to "guardedmem"?

Yeay, let's add more confusion :D

If we're at renaming, I'd appreciate if we could find a terminology that 
does look/sound less horrible.

> 
> I want to start referring to the code/patches by its syscall/implementation name
> instead of "UPM", as "UPM" is (a) very KVM centric, (b) refers to the broader effort
> and not just the non-KVM code, and (c) will likely be confusing for future reviewers
> since there's nothing in the code that mentions "UPM" in any way.
> 
> But typing out restrictedmem is quite tedious, and git grep shows that "rmem" is
> already used to refer to "reserved memory".
> 
> Renaming the syscall to "guardedmem"...

restrictedmem, guardedmem, ... all fairly "suboptimal" if you'd ask me ...

-- 
Thanks,

David / dhildenb

