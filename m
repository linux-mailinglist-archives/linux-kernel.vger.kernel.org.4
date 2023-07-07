Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 713FC74B082
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 14:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231492AbjGGMMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 08:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbjGGMMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 08:12:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B2CC2110
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 05:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688731877;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BVyqwSHAPLftzopmtaxC0lFHhRx6FuTQym8jgnJKosE=;
        b=C7v9qL8xscHUE70Cbwk/KNat6S5olCxoSlMVnwcPo+MFJ1jwLZrqvhJBQY6pJQYa6blED4
        1EcG2R2dnda6LhhyqTNULwahowoXtnFE6wjhYfbIpgWln97HZopfLiTMptTN2xLKwxVVyr
        WTmkA8A9sYPRWIj/t5AvpxLNsqGTI48=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-520-zpTWAHKOMSCu7g8PX-N3mg-1; Fri, 07 Jul 2023 08:11:14 -0400
X-MC-Unique: zpTWAHKOMSCu7g8PX-N3mg-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3143c941d0bso999895f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 05:11:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688731873; x=1691323873;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BVyqwSHAPLftzopmtaxC0lFHhRx6FuTQym8jgnJKosE=;
        b=ZltVstAMytRk4MnoyLUj7G6fkIS4o8AXkf9JcGvHf8XielNwAXOfRLXvjWCeK9VkYj
         vwm/5seOOw0j68fNZYV5lh91PZYoUh/uOct1U2FFmROzS9zV0JYh52wl8xHTM/IibqnY
         3wNTISGD2SMMQFHxryqCNEJ8vYJyPeADifo/HLvLrqPWXDTZujgiI9klnYs+TOXshN7t
         sLkjuSGiVahDHCBN612PG+uZlJF10gVfYrezbx/vcefD5622n+gSpzh/rVQYalM0r11l
         nF6lwoT9AGV4gwygOWCo/3Bgg3Ih145QcU6TF5rT9P7zglNW0ETXgRQqOIN765SDj5Xu
         MNxQ==
X-Gm-Message-State: ABy/qLa9ve3u8dsmmdfZFSV2md5bqaZesYUiYc9q/LGpCCqIWuQbpB4z
        CojJm4tERg6JGSLz206j269zbymL8b9zxy6yHh/3brRujBPTj0mDDHnSmT90vtPcwBbuwbmNFbl
        JhXJ67Kv+4tT8Fm5sNRWQjsvK
X-Received: by 2002:a5d:5450:0:b0:314:3503:15ac with SMTP id w16-20020a5d5450000000b00314350315acmr4071151wrv.10.1688731872960;
        Fri, 07 Jul 2023 05:11:12 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGQ+0CrqDvb4lVn+YlJy3j3lhmI2e5jJ3pz4I7kZYIBFwKLH8Ug0fJ0/CydpV5KGXWVfJemXw==
X-Received: by 2002:a5d:5450:0:b0:314:3503:15ac with SMTP id w16-20020a5d5450000000b00314350315acmr4071129wrv.10.1688731872601;
        Fri, 07 Jul 2023 05:11:12 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f04:3c00:248f:bf5b:b03e:aac7? (p200300d82f043c00248fbf5bb03eaac7.dip0.t-ipconnect.de. [2003:d8:2f04:3c00:248f:bf5b:b03e:aac7])
        by smtp.gmail.com with ESMTPSA id k6-20020adfd846000000b00314315071bbsm4324550wrl.38.2023.07.07.05.11.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jul 2023 05:11:12 -0700 (PDT)
Message-ID: <b8bf72f4-f590-a159-ca94-526153b73216@redhat.com>
Date:   Fri, 7 Jul 2023 14:11:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [RFC 0/4] arm64/mm: Clean up pte_dirty() state management
Content-Language: en-US
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20230707053331.510041-1-anshuman.khandual@arm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230707053331.510041-1-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.07.23 07:33, Anshuman Khandual wrote:
> These pte_dirty() changes make things explicitly clear, while improving the
> code readability. This optimizes HW dirty state transfer into SW dirty bit.
> This also adds a new arm64 documentation explaining overall pte dirty state
> management in detail. This series applies on the latest mainline kernel.
> 
>

I skimmed over most of the series, and I am not convinced that this is 
actually a cleanup. If we cannot really always differentiate between 
sw/hw clearing, why have separate primitives that give one the illusion 
that it could be done and that they are two different concepts?

Maybe there are other opinions, but at least for me this made the code 
harder to grasp.

I do appreciate a doc update, though :)

-- 
Cheers,

David / dhildenb

