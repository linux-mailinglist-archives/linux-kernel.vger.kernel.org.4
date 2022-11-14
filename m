Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8146B62771D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 09:08:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236206AbiKNIIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 03:08:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236203AbiKNIId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 03:08:33 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8409C19C39
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 00:07:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668413259;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Sc3OD/33LVOTPB4+NFeZBiaw904aPGsKctdDvYBcdUs=;
        b=FCHkR7pGP9fN7fq9xDVjRjnXh1tQBBmTWKhS6uZqqLdDGfbcVnI5wcjUDp9QpWFm3DX2Bj
        ZNfJ0M5XZKUtuUnh6UrNHwYsR5bUhkTWu3ws5Pr1Lyivu6LU1EZJohPLyQiK11ihCT7kZA
        2bRF6ibooq+BQHnIfxBApybI4j2rFOU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-156-IWW_ociuP2qiqBbA0Tv0rw-1; Mon, 14 Nov 2022 03:07:38 -0500
X-MC-Unique: IWW_ociuP2qiqBbA0Tv0rw-1
Received: by mail-wr1-f71.google.com with SMTP id l1-20020adfa381000000b0024184dfcb5eso402391wrb.21
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 00:07:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sc3OD/33LVOTPB4+NFeZBiaw904aPGsKctdDvYBcdUs=;
        b=gSfvRd6QbGrYcehlwdC1oOk6RMLd75WrK5LKtFKBO/820JqH7HyQnf1JGkJ6s8LUn1
         fTZOY2dAHUNjSCudZdivcRY0128b3UoHyCXLmhwejzvVqQSQYtIe0zfMyzXVjenDkM32
         owvd58Qr2wNFdzalqtjP8m5VGXAmexNxwvj/oiJZx6cZpjlSouadxQ3k2VR75asXlCuS
         ii8BayMM1eoO+o0FrC5TOOcPVUghtbihmc5JMgkNBLrqVyDVXMEPGg84pnOblpDGz0OH
         oBLoP+4A0qfXpc2qZsMukikHewSjTgeDx4GZBtlIQmiKp6QaOMLrYoYkqYrK9sIs9NgR
         fvyg==
X-Gm-Message-State: ANoB5pnQrmqc+Iqp4JsQI7a4eE9X9ogSaVRQdssgCY96dq9PxLuMlPqG
        a7UhpZ7Br4Jbzp/DphXt3Rz6Ee6L/MyMpQviD0s3fvGkm9BO2RrQJaAtZrjbpQ5PAixzihqhrr/
        OdxPt1lC6wKsudPwU9gFMN3kJ
X-Received: by 2002:a5d:4575:0:b0:236:6e4b:8c2 with SMTP id a21-20020a5d4575000000b002366e4b08c2mr6336373wrc.545.1668413257331;
        Mon, 14 Nov 2022 00:07:37 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7nVXgU/8Jv+xzckTpvD06sshk0g6lWh6ohMy1bXzH3vi7keYGWVfIARGixyNY+Rc8WvFWGhQ==
X-Received: by 2002:a5d:4575:0:b0:236:6e4b:8c2 with SMTP id a21-20020a5d4575000000b002366e4b08c2mr6336334wrc.545.1668413256954;
        Mon, 14 Nov 2022 00:07:36 -0800 (PST)
Received: from ?IPV6:2003:cb:c703:d300:8765:6ef2:3111:de53? (p200300cbc703d30087656ef23111de53.dip0.t-ipconnect.de. [2003:cb:c703:d300:8765:6ef2:3111:de53])
        by smtp.gmail.com with ESMTPSA id g11-20020a5d540b000000b0022cdeba3f83sm8798705wrv.84.2022.11.14.00.07.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 00:07:36 -0800 (PST)
Message-ID: <f233f77b-a065-37aa-e2fb-5b92899dd13b@redhat.com>
Date:   Mon, 14 Nov 2022 09:07:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH RFC 00/19] mm/gup: remove FOLL_FORCE usage from drivers
 (reliable R/O long-term pinning)
To:     Christoph Hellwig <hch@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-media@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>,
        Peter Xu <peterx@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>, Nadav Amit <namit@vmware.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Oded Gabbay <ogabbay@kernel.org>, Arnd Bergmann <arnd@arndb.de>
References: <20221107161740.144456-1-david@redhat.com>
 <CAHk-=wj51-dtxf8BQBYP+9Kc3ejq4Y0=-6hCbf_XAnkT3fsgDQ@mail.gmail.com>
 <Y3HaGbPcGfTxlLPZ@infradead.org>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <Y3HaGbPcGfTxlLPZ@infradead.org>
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

On 14.11.22 07:03, Christoph Hellwig wrote:
> On Mon, Nov 07, 2022 at 09:27:23AM -0800, Linus Torvalds wrote:
>> And I'd really love to just have this long saga ended, and FOLL_FORCE
>> finally relegated to purely ptrace accesses.
> 
> At that point we should also rename it to FOLL_PTRACE to make that
> very clear, and also break anything in-flight accidentally readding it,
> which I'd otherwise expect to happen.

Good idea; I'll include a patch in v1.

-- 
Thanks,

David / dhildenb

