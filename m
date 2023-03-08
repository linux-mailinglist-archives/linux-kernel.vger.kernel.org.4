Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19C686B0FBE
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 18:05:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbjCHRFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 12:05:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbjCHRF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 12:05:26 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B62559801
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 09:04:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678295068;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DnkH5ADX44lRNBllOH1xgHWgRf45waeRxvhVHvRyBWM=;
        b=OJS8wN/8UMrcOh+ZotIUXOlWnRDDETSTs6GJSw5KfHEqtildMfx/WyiBegl72RrR+LThrO
        TEFEB4fYJUMICZFeWzfoKuNJuOCzN8SqX0UnOdT8psKAlBSDg9OhBf+Ya5+DMRyZafYJvD
        wSGMkj79SAx/WZaFbpJrRNZbKdw1mK8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-9Vo1eT9UMfegiMn954BUrw-1; Wed, 08 Mar 2023 12:04:25 -0500
X-MC-Unique: 9Vo1eT9UMfegiMn954BUrw-1
Received: by mail-wm1-f72.google.com with SMTP id y16-20020a1c4b10000000b003dd1b5d2a36so1037438wma.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 09:04:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678295064;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DnkH5ADX44lRNBllOH1xgHWgRf45waeRxvhVHvRyBWM=;
        b=7+NnZmSBXuJcPG7WVhbWjXe/vfq12CR5KNB+CtQxBdZIcFuLVwHncdD8sq2RYtB4Kp
         5gsw8Q9ua/r5QznyeQn6ze39eQao5fROJTyfCAdOEG7A1q8R/yLCq00DSYnfEePH1nVh
         I7JKpaSnqgNVRjKhXzqvJtHNVShLaC4hARWoevo8Mji2DdSShOgFNjurcXfkSl0poO4E
         gLyTs+MKGuxXjMbAYpRd3ZP1ZzCQruKr6HD4gy6ezkLxJARwvOYil2xwUmDyYDXLVdR+
         HU99XPHW5q8C5sCVSvv0PTJ+ri6nnJJQeg2vvcctnb2pLCaIVy3rbMSZgtU9sUXPOfDO
         zReA==
X-Gm-Message-State: AO0yUKWvwx5DErUyt86OaB6MLStzUHq2uI9J/nQqJVyOAaFqyYGcmzLr
        I26QSvSqVIfw9ABH82GfcjApf1jDNRgINm9Wwwfr4RQzKtQW6NmuAE3WtkT2zKDdS7dbMGyus8A
        QhYZGNTW9sre2JKrP2TyC4q2M
X-Received: by 2002:adf:e44c:0:b0:2c7:148c:b04f with SMTP id t12-20020adfe44c000000b002c7148cb04fmr12210094wrm.37.1678295063939;
        Wed, 08 Mar 2023 09:04:23 -0800 (PST)
X-Google-Smtp-Source: AK7set+tqdpCsvnoW/yKYmJ+7gwlKHxP0XuvlCRW9szRHvBnyfoCzE8pt4NlUOXqqOt4/pkWf77N+Q==
X-Received: by 2002:adf:e44c:0:b0:2c7:148c:b04f with SMTP id t12-20020adfe44c000000b002c7148cb04fmr12210074wrm.37.1678295063621;
        Wed, 08 Mar 2023 09:04:23 -0800 (PST)
Received: from ?IPV6:2003:cb:c71b:cb00:d372:1da8:9e9e:422d? (p200300cbc71bcb00d3721da89e9e422d.dip0.t-ipconnect.de. [2003:cb:c71b:cb00:d372:1da8:9e9e:422d])
        by smtp.gmail.com with ESMTPSA id w12-20020a5d608c000000b002c552c6c8c2sm15822655wrt.87.2023.03.08.09.04.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 09:04:23 -0800 (PST)
Message-ID: <fd206791-aa8a-5cd8-2606-58d395f2c995@redhat.com>
Date:   Wed, 8 Mar 2023 18:04:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 1/2] mm/uffd: UFFD_FEATURE_WP_UNPOPULATED
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20230306213925.617814-1-peterx@redhat.com>
 <20230306213925.617814-2-peterx@redhat.com>
 <94be7b9f-c33e-c6dc-4132-6cb78f7c0624@redhat.com> <ZAiqPU0RX3JfDFRP@x1n>
 <83b3f3ad-19a2-3737-77dd-3c3f9db82194@redhat.com> <ZAi8+PCsIzExWPQN@x1n>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <ZAi8+PCsIzExWPQN@x1n>
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

On 08.03.23 17:51, Peter Xu wrote:
> On Wed, Mar 08, 2023 at 04:57:55PM +0100, David Hildenbrand wrote:
>> Oh, my thinking was that with markers you postpone placing the shared
>> zeropage. So the next read access will require a pagefault to map the shared
>> zeropage. Your v1 would have performed best in that case I guess.
> 
> Ah, so I misunderstood because the sentence being quote was in another
> context I think..

Sorry, I might have messed up the quoting.

> 
> Pagemap may bring overhead constantly though, not sure when vs page faults.
> May relevant to num of missing pages.

Right, one idea (raised by Dave G. IIRC) was to to the pagemap scanning 
concurrently from another thread and avoid most of the shared-zeropage 
dance.

-- 
Thanks,

David / dhildenb

