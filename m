Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 602646E464F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 13:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbjDQLXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 07:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbjDQLXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 07:23:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E7977EEA
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 04:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681730410;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lQP0jhHOILHGUYqqiFPFEP0oFPfgZ69ufmXe3pOVD4k=;
        b=RHqVlsikhEYxyVC3R0XgzNatwZpHl6aG0HqcA6aF/wnFqk2JAlViGJFhXMdPDWKJ0sBwrd
        fX11XbZzalVLIz3kQXg4Me33Xj9laAub+ALunJ8crrgd8ny/56U+4Em2+ZD402zaGPMYD0
        6xrxo/TXFh5xpQF0xGLcbQvGUC8PsxI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-426-que7vcAjOm6niXe58mbpYQ-1; Mon, 17 Apr 2023 06:55:33 -0400
X-MC-Unique: que7vcAjOm6niXe58mbpYQ-1
Received: by mail-wm1-f70.google.com with SMTP id ay3-20020a05600c1e0300b003f1728ce786so2028350wmb.7
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 03:55:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681728932; x=1684320932;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lQP0jhHOILHGUYqqiFPFEP0oFPfgZ69ufmXe3pOVD4k=;
        b=HL/x6tUtI7XZzIE+rdAwbjpxEf3BjflyGVMs+qXn4MJaiXmDEPSkPK4xF+9SEzBoOL
         /8Qyxx0VnMeFpHon5R3+HTbxyfR8jArI4zSrLSWRsXByyIlSaRoOJQoZGh/uJ/GDFRzQ
         Krg5D0sZWPVOBl/jKWCraTqiYaJg9X9RYifrdhHBu+wcx5T6rAY4XC+r31zUDzWmpQYM
         eZ9MSI2QqBRIkzo7HBwk93mGHHjU5BDf2NWiRT8ce956mn7fMj6HIq2mOf9G+gV/CHvv
         VgtL0R8LZu0qf6fQiJJIz8RJ3JWKMb9DGApEjZTA8SU3a0h/hYWdcX/rBI6rRIllXmB/
         ieMw==
X-Gm-Message-State: AAQBX9e3F8vJBlxz0IcP86n961G/0rOeyiG7+aqiEAkkJOP06gfhYBR/
        7i+rANeCfC0kcTZkpiOfyL4deWZVabiHUD8nBeluj2Wc4pHLwn6CIBJy+rqAGOZmjs2p1F8Oe/b
        jRiqXYQHJtjV+qBWyhxZWdqn1
X-Received: by 2002:a05:600c:3793:b0:3f1:71b3:c6b5 with SMTP id o19-20020a05600c379300b003f171b3c6b5mr3472236wmr.26.1681728932430;
        Mon, 17 Apr 2023 03:55:32 -0700 (PDT)
X-Google-Smtp-Source: AKy350YH/86qIG88Tj0beqaD/3sOrt9ZF/SdVSy4Z1Oma4C+GIauFs3qJA38myjmhj9zrBrycpWLBQ==
X-Received: by 2002:a05:600c:3793:b0:3f1:71b3:c6b5 with SMTP id o19-20020a05600c379300b003f171b3c6b5mr3472203wmr.26.1681728932040;
        Mon, 17 Apr 2023 03:55:32 -0700 (PDT)
Received: from ?IPV6:2003:cb:c700:fc00:db07:68a9:6af5:ecdf? (p200300cbc700fc00db0768a96af5ecdf.dip0.t-ipconnect.de. [2003:cb:c700:fc00:db07:68a9:6af5:ecdf])
        by smtp.gmail.com with ESMTPSA id c10-20020a7bc2aa000000b003f0ad8d1c69sm10484005wmk.25.2023.04.17.03.55.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Apr 2023 03:55:31 -0700 (PDT)
Message-ID: <6ad9509c-11b6-9ada-0ee8-26cf40b3ac14@redhat.com>
Date:   Mon, 17 Apr 2023 12:55:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v3 1/7] mm/gup: remove unused vmas parameter from
 get_user_pages()
Content-Language: en-US
To:     Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>, x86@kernel.org,
        linux-sgx@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, kvm@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Xinhui Pan <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Paolo Bonzini <pbonzini@redhat.com>
References: <cover.1681558407.git.lstoakes@gmail.com>
 <28967f170eceeebf2591a5e4370d0642e0516f9b.1681558407.git.lstoakes@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <28967f170eceeebf2591a5e4370d0642e0516f9b.1681558407.git.lstoakes@gmail.com>
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

On 15.04.23 14:09, Lorenzo Stoakes wrote:
> No invocation of get_user_pages() uses the vmas parameter, so remove
> it.
> 
> The GUP API is confusing and caveated. Recent changes have done much to
> improve that, however there is more we can do. Exporting vmas is a prime
> target as the caller has to be extremely careful to preclude their use
> after the mmap_lock has expired or otherwise be left with dangling
> pointers.
> 
> Removing the vmas parameter focuses the GUP functions upon their primary
> purpose - pinning (and outputting) pages as well as performing the actions
> implied by the input flags.
> 
> This is part of a patch series aiming to remove the vmas parameter
> altogether.
> 
> Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
> Suggested-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

