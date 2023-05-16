Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4159F7047BE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 10:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbjEPI1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 04:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbjEPI1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 04:27:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B5A4EF9
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 01:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684225559;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U8pRuM5Q7Lxr05z3aZ6AYXk+Wr4qT28SznqmdXZL224=;
        b=GvZOq1Injm7fe9+1roQT0FVETyKTsfPOpzPKlrqrueq3Gvrt5lMepFOeGLkcVRNOHZXTIe
        SlylAn4w9k9x+3+nQzP6zYVD7hw3908wxJZ3D/8UhxugN9H98iGdSl8EipKGxrEPozHf4s
        fbd+SqqqqO9QyTFbvMHYX5wifTDM1LY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-M8uRUb6_PKeX5N0baPFaGg-1; Tue, 16 May 2023 04:25:58 -0400
X-MC-Unique: M8uRUb6_PKeX5N0baPFaGg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3f41ce0a69fso41022665e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 01:25:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684225557; x=1686817557;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U8pRuM5Q7Lxr05z3aZ6AYXk+Wr4qT28SznqmdXZL224=;
        b=knUDMrm4ZPGFe8Tt9Pc6SVzfLbEufyN6fy80h83s9k632lFigbE+HFSyPaPpjEpzAV
         MJ9z/3YxwvPqavEVHePL3G9s41ZgXkFFURmmHHRGxDAWqsibwthy9No0c9wLQo1EgXYR
         N58Q4fZtjzx1I4R0VGo7Mkzc36S2hT7eIxURSqlw2f9ZkNFB/l7K3S/7tBNFi1RJClCB
         LLCAXi83xjiX73ezG9vWxvUVob0IWRvxSkLxCHwkxk61NS/7hboBa+jyb3RIOk8hG6VT
         dh+6Z018wRXTMt2fe/B07cl6u1L0KRrMz99XwbJvLZ1MwUuBk34clfutiHZRbnC+5RbC
         mWmg==
X-Gm-Message-State: AC+VfDwumW3CJiaaiZ/waWYY3PlrPgnAJf9X2FGcmjl0OLHqDn0ZXF9B
        RM/Gf+/V1D+nvLOHjOh9/TSxlZYChdKnscx42sdWFTZJQMZwg42WvxM2SKctQPsYbBa+A39jyx3
        hRKjUgTu4uoUtmS7WMt1na24H
X-Received: by 2002:adf:f1c5:0:b0:2f2:4db4:1f5b with SMTP id z5-20020adff1c5000000b002f24db41f5bmr24865827wro.29.1684225557043;
        Tue, 16 May 2023 01:25:57 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5uilFM9G/lgvaS5x/xIDzNheqY2Mg0oL4HgHBPWCYzZPU4T1kgSXWmXjjD7GSWMcihTxLoCQ==
X-Received: by 2002:adf:f1c5:0:b0:2f2:4db4:1f5b with SMTP id z5-20020adff1c5000000b002f24db41f5bmr24865803wro.29.1684225556672;
        Tue, 16 May 2023 01:25:56 -0700 (PDT)
Received: from ?IPV6:2003:cb:c74f:2500:1e3a:9ee0:5180:cc13? (p200300cbc74f25001e3a9ee05180cc13.dip0.t-ipconnect.de. [2003:cb:c74f:2500:1e3a:9ee0:5180:cc13])
        by smtp.gmail.com with ESMTPSA id h2-20020a1ccc02000000b003f423a04016sm1483337wmb.18.2023.05.16.01.25.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 01:25:56 -0700 (PDT)
Message-ID: <40ed22bb-53e3-ddc2-45ca-f0e763f26242@redhat.com>
Date:   Tue, 16 May 2023 10:25:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 4/6] io_uring: rsrc: delegate VMA file-backed check to
 GUP
Content-Language: en-US
To:     Jens Axboe <axboe@kernel.dk>, Lorenzo Stoakes <lstoakes@gmail.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Pavel Begunkov <asml.silence@gmail.com>,
        io-uring@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>
References: <cover.1684097001.git.lstoakes@gmail.com>
 <642128d50f5423b3331e3108f8faf6b8ac0d957e.1684097002.git.lstoakes@gmail.com>
 <c44effe6-029e-4ccb-ce97-2ca5d5099c05@kernel.dk>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <c44effe6-029e-4ccb-ce97-2ca5d5099c05@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.05.23 21:55, Jens Axboe wrote:
> On 5/14/23 3:26 PM, Lorenzo Stoakes wrote:
>> Now that the GUP explicitly checks FOLL_LONGTERM pin_user_pages() for
>> broken file-backed mappings in "mm/gup: disallow FOLL_LONGTERM GUP-nonfast
>> writing to file-backed mappings", there is no need to explicitly check VMAs
>> for this condition, so simply remove this logic from io_uring altogether.
> 
> Don't have the prerequisite patch handy (not in mainline yet), but if it
> just moves the check, then:
> 
> Reviewed-by: Jens Axboe <axboe@kernel.dk>
> 

Jens, please see my note regarding iouring:

https://lore.kernel.org/bpf/6e96358e-bcb5-cc36-18c3-ec5153867b9a@redhat.com/

With this patch, MAP_PRIVATE will work as expected (2), but there will 
be a change in return code handling (1) that we might have to document
in the man page.

-- 
Thanks,

David / dhildenb

