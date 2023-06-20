Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D678A736901
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 12:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231887AbjFTKTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 06:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjFTKTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 06:19:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C85E9A2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 03:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687256304;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ul8gzt2rqlqhcr1utmhEwWbBX32h2e3MNmkpVb/h7mU=;
        b=Ta8a04Q8v1TDsOGk4yl/3khEC7JKP4cEZestc0FCnNQm6nQVTONbViC7m64CqTkUPzXedm
        YL4RFn0YYqBqtrZwfIaTA+R4z5t7phDCoEGPNhzoTDw3HTkEWPpcUNDjzX/Io4Gp59qAG3
        P3h5G88Lz5Jf6jMNqOp0SB0Me4tIlyc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-_3WtNkV-OEunb5nbBqetAQ-1; Tue, 20 Jun 2023 06:18:23 -0400
X-MC-Unique: _3WtNkV-OEunb5nbBqetAQ-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-31283f4d22fso21244f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 03:18:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687256302; x=1689848302;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ul8gzt2rqlqhcr1utmhEwWbBX32h2e3MNmkpVb/h7mU=;
        b=UHqP02xbfjosQ0EwhLjvDldX3vFKJveFWMY1csc2wyzU10sUofiz4dgMrCOEPW4L1W
         brEna9Ase2J0dMwNVpEl69cNmdO7atpoMDv1FLgyceGTrr4cyaOsDAUBV0LG3G1G2Mjl
         NzR15d7OXIZLDC4Mc+1nY5D22RrlCNHsVJzGPSURjIIeFtoT2J4mFdW2H5ZnepN3iyO7
         iXQdoxsxm2RoTwjLOTK2UHN3dWmC8dL7C+XX0TdOernbeT0p2pjY1G73GgldZ6M3jCtp
         CZY4tpQuikzw4wytaXK+02laAHgbORyIsdAObyp0j7hNgZ1diam0LGemJ0HfH6hX87Fg
         ipaQ==
X-Gm-Message-State: AC+VfDwbYfCQgw+akMr+xJR9iSuhKd16MpICQDSQX0N1nalK0/uf5X71
        N7fURAUGoHk94QPuwjR3TA6xGiMlMZ7ebWyURuR42IpumUokpLni8i8S4Awz89PW0JD/arNlKXn
        fWswBYntmZ//QXONTCW9NetHm
X-Received: by 2002:adf:eb42:0:b0:30f:b7b4:3e55 with SMTP id u2-20020adfeb42000000b0030fb7b43e55mr7309576wrn.19.1687256301855;
        Tue, 20 Jun 2023 03:18:21 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7HRI2F0AQylpx3uL7mfns9KK5U8KdfYEgbExjOtghnkni4a1tLKu8LAGtMktVeV/7TXJgvpg==
X-Received: by 2002:adf:eb42:0:b0:30f:b7b4:3e55 with SMTP id u2-20020adfeb42000000b0030fb7b43e55mr7309562wrn.19.1687256301420;
        Tue, 20 Jun 2023 03:18:21 -0700 (PDT)
Received: from ?IPV6:2003:cb:c739:d200:8745:c520:8bf6:b587? (p200300cbc739d2008745c5208bf6b587.dip0.t-ipconnect.de. [2003:cb:c739:d200:8745:c520:8bf6:b587])
        by smtp.gmail.com with ESMTPSA id h9-20020a5d4fc9000000b0031134bcdacdsm1653936wrw.42.2023.06.20.03.18.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jun 2023 03:18:20 -0700 (PDT)
Message-ID: <a96f95e1-ad7e-1d23-191e-014d3befe5a3@redhat.com>
Date:   Tue, 20 Jun 2023 12:18:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 08/11] selftests/mm: fix uffd-unit-tests.c build
 failure due to missing MADV_COLLAPSE
Content-Language: en-US
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Oscar Salvador <osalvador@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Peter Xu <peterx@redhat.com>
References: <20230620011719.155379-1-jhubbard@nvidia.com>
 <20230620011719.155379-10-jhubbard@nvidia.com>
 <575a395c-0608-00da-3aa3-cbe4a5bd157e@collabora.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <575a395c-0608-00da-3aa3-cbe4a5bd157e@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.06.23 12:17, Muhammad Usama Anjum wrote:
> On 6/20/23 6:17 AM, John Hubbard wrote:
>> MADV_PAGEOUT, MADV_POPULATE_READ, MADV_COLLAPSE are conditionally
>> defined as necessary. However, that was being done in .c files, and a
>> new build failure came up that would have been automatically avoided had
>> these been in a common header file.
>>
>> So consolidate and move them all to vm_util.h, which fixes the build
>> failure.
>>
>> An alternative approach from Muhammad Usama Anjum was: rely on "make
>> headers" being required, and include asm-generic/mman-common.h. This
>> works in the sense that it builds, but it still generates warnings about
>> duplicate MADV_* symbols, and the goal here is to get a fully clean (no
>> warnings) build here.
> I've not looked in detail. But it seems like your first revision was merged
> and after that my cleanup has also been merged. My cleanup patch is adding
> correct header files and removing these duplicate defines: It is in
> mm-stable now.
> https://lore.kernel.org/all/20230619232244.81CB3C433C0@smtp.kernel.org

See

https://lkml.kernel.org/r/0379db8e-744d-2876-7304-2a6db8c9cac0@nvidia.com

-- 
Cheers,

David / dhildenb

