Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D95B46C0EDE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 11:32:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbjCTKcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 06:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbjCTKcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 06:32:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D116118AAB
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 03:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679308265;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sUppWufn6NEkhpOupgoS1aEsmbxe8TC/zmcoaPavfgU=;
        b=B3nZVASd78c/EK4ti7NwEvyADvRX8VUSEWd4bkXedm4CCHL1ACkeGwL8/LpFNMqXF0AKpx
        ExyBnwZm1RY7a3E7V8DwoBnjZ4ZFn3lhTFVWu+C9fEoPXqwws3DE2gwJ7n4F8LTQBqW9UR
        NrcNwzdXj/g7btvHxw0FesvDqWqxhOY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-673-Z5tuC-tsOD-RZtITi2OhrQ-1; Mon, 20 Mar 2023 06:31:03 -0400
X-MC-Unique: Z5tuC-tsOD-RZtITi2OhrQ-1
Received: by mail-wr1-f72.google.com with SMTP id d5-20020adfa345000000b002d716fc080fso194144wrb.22
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 03:31:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679308262;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sUppWufn6NEkhpOupgoS1aEsmbxe8TC/zmcoaPavfgU=;
        b=UbGu2l0efroJkEpkPGsMRSF6wsJ0R2zYLPSDg4Ya+c4RnSRkQ6bKDu7spM5pW4Xhl7
         1wGE0HoHxBcz95HNc/djMoHefIlVn1zwEJIpA7JwzOn4GJk9Wh0aSaof9wsn03gEyF2Z
         Q3hQ/lGQDx+C6kDrGNTLkD98VmsGQkB5SWirKO1H9CbdbxIPORc+EhhBRgj914B2EA1n
         RNCRbn0wtYEY6TBs9lgDU2XTUEoxdQfczRtDiATDAZxvgDMa+wTuyLimQx4Vpmzi4TEB
         eXNs1qQRabQImOnkFJ4BDUHme2+WiAJF3OCaO+wz1d0Gj3iB0j1OEzeGZTYcst5l3urw
         0CVw==
X-Gm-Message-State: AO0yUKVyOBwY14gdJjYyxME03qPu39l1gyO82WqZ/zuKNUP0d7OwdsIz
        DkjE1OJ01hHHcdnRvd+4wxONo56p8lhSZg92PJq5vmdzO/YUeCGuJDyfrk8fzlyXY8j9b4Kwu2b
        WccqUuFhFOoJvhUXKtJrEqTZy
X-Received: by 2002:a1c:c904:0:b0:3ed:abb9:7515 with SMTP id f4-20020a1cc904000000b003edabb97515mr6223759wmb.11.1679308262581;
        Mon, 20 Mar 2023 03:31:02 -0700 (PDT)
X-Google-Smtp-Source: AK7set9Vm9wmUVx7d/f29weV5tfp82oCrHblvxQ1wE4JkyLVUFS0o9uiYmDCsEH1KygC18ykIKtqYw==
X-Received: by 2002:a1c:c904:0:b0:3ed:abb9:7515 with SMTP id f4-20020a1cc904000000b003edabb97515mr6223733wmb.11.1679308262155;
        Mon, 20 Mar 2023 03:31:02 -0700 (PDT)
Received: from ?IPV6:2003:cb:c702:4100:a064:1ded:25ec:cf2f? (p200300cbc7024100a0641ded25eccf2f.dip0.t-ipconnect.de. [2003:cb:c702:4100:a064:1ded:25ec:cf2f])
        by smtp.gmail.com with ESMTPSA id h20-20020a1ccc14000000b003dc522dd25esm10054546wmb.30.2023.03.20.03.31.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 03:31:01 -0700 (PDT)
Message-ID: <7cdadb90-57bb-38bc-e711-96f2fe917d17@redhat.com>
Date:   Mon, 20 Mar 2023 11:31:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 03/15] mm/page_alloc: add helper for checking if
 check_pages_enabled
Content-Language: en-US
To:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>, Mel Gorman <mgorman@suse.de>,
        Michal Hocko <mhocko@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-mm@kvack.org
References: <20230319220008.2138576-1-rppt@kernel.org>
 <20230319220008.2138576-4-rppt@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230319220008.2138576-4-rppt@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.03.23 22:59, Mike Rapoport wrote:
> From: "Mike Rapoport (IBM)" <rppt@kernel.org>
> 
> Instead of duplicating long static_branch_enabled(&check_pages_enabled)
> wrap it in a helper function is_check_pages_enabled()
> 
> Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

