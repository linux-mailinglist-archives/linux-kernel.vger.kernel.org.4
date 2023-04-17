Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 259076E45E5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 12:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbjDQK66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 06:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbjDQK6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 06:58:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79FFA59E4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 03:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681728951;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1wWR6LdExfwjEsSRDi6jXKipEXf+Q0zIDWbRNdZy7RQ=;
        b=LA7zYhjDS/oQF9/rcDrkkGntGnW+ebwCriv90C318xtI/qdBAgW48yfFHvMaNsJa0cXmKw
        VuFtSvKwg10Ms/xsUD3mVzfhViwl4tQ3AVKvtGiNKC+S90cjOY3FA2+6pBZrEoDbOILuCW
        PLrob+WU0Y7cjc7zVx21XkJ7fRoTmDw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-524-jyELjMauP9es9lWScPsP5w-1; Mon, 17 Apr 2023 06:55:50 -0400
X-MC-Unique: jyELjMauP9es9lWScPsP5w-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-2f55f0626a6so387333f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 03:55:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681728949; x=1684320949;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1wWR6LdExfwjEsSRDi6jXKipEXf+Q0zIDWbRNdZy7RQ=;
        b=Z6MHU2p+m+sazsirQXOxQKxgD4FZ8JZoTVcVVjBUdUTrs0Cwf67XNMiyDChuTiykbW
         2HySdb9aFy3AdvLUPdvdbBhivGMgCHxPTQIq1dxpmEAXNPgS514DGO4z3uTPDbB1I7tr
         ugK++bpk7g/i4UVaIeieK+n3TEfnJHtTOlqmgBJ0xIr0pLFVPDxUKKIER2IhF/R7i2zS
         DWGEl+V3z1PENx7bTEpWocc5kTxoG18hL+DE5kmT/mVWA/u8tEZaB3wcrqTP7V+Yem6x
         NEEuSjyqQ2gaMEAJs9WIn6BHKGiHa2VlsA2I+HykZNFYCSiu53H81J72qwKuBVBlo6Cr
         qi9Q==
X-Gm-Message-State: AAQBX9fkhXGM4/pKLvNOA2MbI0djkouo2RTGCuMxBhK4gIV4b9xHd5FZ
        MOoLkpIFMRxDbRd/F8/Ceio5N7jV4RSHPLSF2ilNcZym6Nqcza20m1I9hou3RpwD1LhusTSvZT+
        ImXSjF04p8PtTYqrNT9RaBqBd
X-Received: by 2002:a5d:564a:0:b0:2ee:fc1b:b7ba with SMTP id j10-20020a5d564a000000b002eefc1bb7bamr5554685wrw.39.1681728949288;
        Mon, 17 Apr 2023 03:55:49 -0700 (PDT)
X-Google-Smtp-Source: AKy350b4mqRWHxHUhRiKtx3CxYgUioujgL380Qdaxi7z1qv8uqaf0xsSOnV1ktQrpGXmyp9r8e6DcA==
X-Received: by 2002:a5d:564a:0:b0:2ee:fc1b:b7ba with SMTP id j10-20020a5d564a000000b002eefc1bb7bamr5554664wrw.39.1681728948942;
        Mon, 17 Apr 2023 03:55:48 -0700 (PDT)
Received: from ?IPV6:2003:cb:c700:fc00:db07:68a9:6af5:ecdf? (p200300cbc700fc00db0768a96af5ecdf.dip0.t-ipconnect.de. [2003:cb:c700:fc00:db07:68a9:6af5:ecdf])
        by smtp.gmail.com with ESMTPSA id c22-20020a05600c0ad600b003f16fc33fbesm5319894wmr.17.2023.04.17.03.55.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Apr 2023 03:55:48 -0700 (PDT)
Message-ID: <887ad211-b63e-5f04-9a55-66027a8dc1cc@redhat.com>
Date:   Mon, 17 Apr 2023 12:55:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v3 2/7] mm/gup: remove unused vmas parameter from
 pin_user_pages_remote()
Content-Language: en-US
To:     Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        iommu@lists.linux.dev
Cc:     Matthew Wilcox <willy@infradead.org>, kvm@vger.kernel.org,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Kevin Tian <kevin.tian@intel.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Alex Williamson <alex.williamson@redhat.com>
References: <cover.1681558407.git.lstoakes@gmail.com>
 <59022490ef05da7310e6abd7f42df933bebdda2a.1681558407.git.lstoakes@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <59022490ef05da7310e6abd7f42df933bebdda2a.1681558407.git.lstoakes@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.04.23 14:09, Lorenzo Stoakes wrote:
> No invocation of pin_user_pages_remote() uses the vmas parameter, so remove
> it. This forms part of a larger patch set eliminating the use of the vmas
> parameters altogether.
> 
> Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

