Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06CAE74D138
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 11:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbjGJJSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 05:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbjGJJSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 05:18:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 795258E
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 02:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688980670;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xLw+AO5WmDxQ3csKYjLPHy6exsc/2+oE8SjJWQaEdus=;
        b=K5q81tWQtIiGW0RWv+SkyH1sPkScIQ/3oQlr28O8Mr1C2sdWZRQvoUHiUTmNBfTXRqg7e/
        XO6hLTLZ+a/J1+9+be8cK0t/xviBqg2btfezQ6ESBAh8oONPgH1orJJFBDEXXS+gB4WtHv
        Oj5JcFiVEQEmzLaDKxT9BKpe7fXPZS0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-5-_7M_rGSbM6OXmBKGFGSICw-1; Mon, 10 Jul 2023 05:17:49 -0400
X-MC-Unique: _7M_rGSbM6OXmBKGFGSICw-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3142665f122so2441012f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 02:17:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688980668; x=1691572668;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xLw+AO5WmDxQ3csKYjLPHy6exsc/2+oE8SjJWQaEdus=;
        b=JXlQKfzUC4YejkHtAETLhSzDmYxB/THppSbYgwYo5wrF8I8vn+AfBPGm6Z3v2L5S7G
         KwFdbOQU+XmpJaHGsdX5Na0jI83fy2cXzGZ43xiZ+tVi1x6KR4sko1mH22QtpJc+PbWg
         XJ8myzf6KIOuIVJVKoXos01a2tM4L4FcEiXCaNx4F+65EgVpWbd00fe6LCKr9uG9ibAm
         tErlWeMcXNm9fHRho8OSSoJmklOa+fFp8XvixHL/WY87odCnwtX07dSlx2LbbefV+0KN
         0rMBTsH4n00mIJ1EK+fQ+h7rQP4TBNYl7xEIlpWqffnm7R1i1LHvV4AZE/VLDDYPGZ+u
         uFbQ==
X-Gm-Message-State: ABy/qLZdwlLky/Qk4HTZIEOmscXEGjMq13Uw4o2dW8IFGj98kuKWrL/F
        amAl5qAv9vuqouuYpPPLWqwEHYnoNWC/TL16ql7RMPLr+sBNGtJi3rrWEbO+0pJ6iM7Fy6lwnBG
        fsNszCwLHPatKuwPrKSG5TLPY
X-Received: by 2002:adf:ef0e:0:b0:314:1e47:8bc2 with SMTP id e14-20020adfef0e000000b003141e478bc2mr12119045wro.0.1688980667911;
        Mon, 10 Jul 2023 02:17:47 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHTFJ4PQPXaxRY5On96/da4yfNKA43m9lQ9LRs+zzyTXuxkHBt1raaEcxgqmC0aE2VzceMCOQ==
X-Received: by 2002:adf:ef0e:0:b0:314:1e47:8bc2 with SMTP id e14-20020adfef0e000000b003141e478bc2mr12119020wro.0.1688980667594;
        Mon, 10 Jul 2023 02:17:47 -0700 (PDT)
Received: from ?IPV6:2003:cb:c738:7500:b60f:a446:46f6:5acf? (p200300cbc7387500b60fa44646f65acf.dip0.t-ipconnect.de. [2003:cb:c738:7500:b60f:a446:46f6:5acf])
        by smtp.gmail.com with ESMTPSA id l12-20020adfe58c000000b0031590317c26sm5545593wrm.61.2023.07.10.02.17.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jul 2023 02:17:47 -0700 (PDT)
Message-ID: <3a66672b-6378-a8e6-a329-16f65201fe92@redhat.com>
Date:   Mon, 10 Jul 2023 11:17:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [RFC 0/4] arm64/mm: Clean up pte_dirty() state management
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
 <b8bf72f4-f590-a159-ca94-526153b73216@redhat.com>
 <60732ee3-f1c5-3534-29fc-783ec48f2c92@arm.com>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <60732ee3-f1c5-3534-29fc-783ec48f2c92@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.07.23 04:20, Anshuman Khandual wrote:
> 
> 
> On 7/7/23 17:41, David Hildenbrand wrote:
>> On 07.07.23 07:33, Anshuman Khandual wrote:
>>> These pte_dirty() changes make things explicitly clear, while improving the
>>> code readability. This optimizes HW dirty state transfer into SW dirty bit.
>>> This also adds a new arm64 documentation explaining overall pte dirty state
>>> management in detail. This series applies on the latest mainline kernel.
>>>
>>>
>>
>> I skimmed over most of the series, and I am not convinced that this is actually a cleanup. If we cannot really always differentiate between sw/hw clearing, why have separate primitives that give one the illusion that it could be done and that they are two different concepts?
> 
> These are indeed two different concepts working together, the current code just
> obscures that. Without these primitives it's even hard to follow how the SW and
> HW dirty parts are intertwined in implementing the generic pte_dirty() state.
> 
> The current code acknowledges these two different concepts in identifying them
> i.e via pte_hw_dirty() and pte_sw_dirty().
> 
> #define pte_hw_dirty(pte)       (pte_write(pte) && !(pte_val(pte) & PTE_RDONLY))
> #define pte_sw_dirty(pte)       (!!(pte_val(pte) & PTE_DIRTY))
> 

^ these primitives make sense to me, but not the clearing part.

If there is only one way to clear both, then only have one primitive to 
clear both and state there, that separate clearing is impossible because 
both are intertwined.

-- 
Cheers,

David / dhildenb

