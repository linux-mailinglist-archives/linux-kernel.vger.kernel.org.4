Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 260926DD5FD
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 10:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbjDKIzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 04:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjDKIzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 04:55:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1492A1BD8
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 01:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681203272;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fXO0dCDv6zh0FlvPxvbQji5MhBlSwKK3xGEsZBZfCGU=;
        b=SVg7uH4nzG6O49pMtf2jZ59a9o3SHSpxThUxGE51IDoVHtRmGRNR/e26SaaC8Jwom/mPvx
        G39nYN0syn8NqddgBQ5tKb/Lxbrx1X5+/7CMrT8HqeaDJDSxyWqXG97ruoK+6ZlJWn+IH4
        sO+Mnxs6Wa6OV5MdLtePRgDXFPg7X4o=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-341-3xjTA_ItPcS6ytDxAidDYA-1; Tue, 11 Apr 2023 04:54:31 -0400
X-MC-Unique: 3xjTA_ItPcS6ytDxAidDYA-1
Received: by mail-wm1-f71.google.com with SMTP id bh18-20020a05600c3d1200b003f05a99b571so7052567wmb.8
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 01:54:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681203270; x=1683795270;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fXO0dCDv6zh0FlvPxvbQji5MhBlSwKK3xGEsZBZfCGU=;
        b=1C/9bjulz4w4YGHo1OCelkcNkJS8I0/lEpnQtdqiC4w98MavZuApMnmpgSu/v5kyO7
         L9jDC6BqQxC0eRmcXLMn/Kjr3V38zZZd1Dya7o+LwJIlxD5w3JPVhEzxDtiKeIjIo2Ad
         JR24lBvFbl0twhEoZJGOcijmyQGuzrQD3O+BOQ1grbV51KkjQQnbKtNFFYXJssffnJmB
         w3tmVOgv5AAOQ/w5gxKp01m/Cadt9EodhEqJ7A0iuoLozyuIkphMZArUDSkVwDsgz3Zp
         Nmv8vHZEsFgLIAPQXTrSez6+Roe7Y7JL4Jsn6Me6sRBWqLjwfFscoHULHNpHPdCJBhIk
         pb8w==
X-Gm-Message-State: AAQBX9eW31HPSQzxWJBMVM7OE/u3Iyd2pRJxnxQjdikuFPYKGoWVtlN3
        lbhow52O4GXh8MYg3FHd1MxLLpnMGfgXjWB80k0pTpxL2i6dwf8GTyp/E9scOGdUANSUmpVnGlq
        ZujkUWElc4Exi787RZ0rPV6aH
X-Received: by 2002:a7b:cd0b:0:b0:3ed:2b49:1571 with SMTP id f11-20020a7bcd0b000000b003ed2b491571mr1413891wmj.20.1681203268585;
        Tue, 11 Apr 2023 01:54:28 -0700 (PDT)
X-Google-Smtp-Source: AKy350a0RVaM8f9wvDtq1CVFNtCQpX8tA3BlUIBH9g84G/r9Ow0VuvRAyeY7G0NDlPw7WF/BcbmYnA==
X-Received: by 2002:a7b:cd0b:0:b0:3ed:2b49:1571 with SMTP id f11-20020a7bcd0b000000b003ed2b491571mr1413820wmj.20.1681203266790;
        Tue, 11 Apr 2023 01:54:26 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:1300:6f08:1748:eba7:b2a9? (p200300cbc70613006f081748eba7b2a9.dip0.t-ipconnect.de. [2003:cb:c706:1300:6f08:1748:eba7:b2a9])
        by smtp.gmail.com with ESMTPSA id l13-20020a1c790d000000b003f071466229sm15871490wme.17.2023.04.11.01.54.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Apr 2023 01:54:26 -0700 (PDT)
Message-ID: <5e010945-3603-d0ab-52c1-12cce3c85c3d@redhat.com>
Date:   Tue, 11 Apr 2023 10:54:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [RFC PATCHv2] mm: introduce defer free for cma
Content-Language: en-US
To:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Zhaoyang Huang <huangzhaoyang@gmail.com>, ke.wang@unisoc.com
References: <1681116395-18633-1-git-send-email-zhaoyang.huang@unisoc.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <1681116395-18633-1-git-send-email-zhaoyang.huang@unisoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.04.23 10:46, zhaoyang.huang wrote:
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> 
> Continues page blocks are expensive for the system. Introducing defer free
> mechanism to buffer some which make the allocation easier. The shrinker will
> ensure the page block can be reclaimed when there is memory pressure.

This looks unnecessarily complicated without any good motivation and 
performance numbers why we should even care.

-- 
Thanks,

David / dhildenb

