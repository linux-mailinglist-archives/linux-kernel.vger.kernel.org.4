Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 549BD6994FD
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 13:56:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjBPM4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 07:56:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjBPM4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 07:56:34 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B4B93B842
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 04:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676552147;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YQju69BiqsaDeQRQ67eE8xOTlMpUfeTc3HdbBLvKdtI=;
        b=PBURyO56yfGpgv+rVaRaGZwrs9ZPQo4h9XZ2P2Zn6bGK7ZFPg432ngCIH8SjasACchWssD
        Hmvhlq9b9h/M3mpt5NQ5ye+Xyru43pBP4va3n1YHi4SHLaEtBb5v96GIgEOyZPmxZ+OUU+
        22X3ITtNH6jAqn8qyFh6RwkeEISvgcA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-651-Trq2EljXNoS0GPK8EosGFw-1; Thu, 16 Feb 2023 07:55:46 -0500
X-MC-Unique: Trq2EljXNoS0GPK8EosGFw-1
Received: by mail-wm1-f72.google.com with SMTP id fl9-20020a05600c0b8900b003dfe4bae099so1107037wmb.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 04:55:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YQju69BiqsaDeQRQ67eE8xOTlMpUfeTc3HdbBLvKdtI=;
        b=NiciloosGDip4YNa+Msum8c6Q4HqKfTzmfvL1z9l2y01BAymn5bc9cSzSldrU0ZBwy
         +0bY6L5npHEU7Fw98liBHum1Srq4v8rECHX/w1tndBMOjyGHNqk7unrI5gJuxF2tGygA
         hFupoT6eV9Odj4nYEOHl5OeC7qw6Li/ixg51t2DBKhQ4XLJkyQ0/fA2A1Hb6Vl4kfujr
         cEipdxEixEBtod74IgPWGHIABmOUWjYUTutFQ9Njy4d6BmeIFZcDvVYGoKqyM/qwFUd2
         oZmA5KxjftaCHwscNbQIMVHMzEThZw40jI7bfp9iB//QG8QbntUfH9YvNugBgvX4fKpK
         Sg7w==
X-Gm-Message-State: AO0yUKVaCHXK3q9DRf7OhlU2hKdgdQYn4YH4RgSSd0GpaAfE/2/yLBjL
        QZoYfhQpGDodiOG218c+6qSzQ3qAIlZ+PvW0Z0L5u8HuNkZzqZhOu3FMo6LO0ctYyzJi/Nlu5oH
        X/uRWPzVzBG7m59rH5du8Hpvy
X-Received: by 2002:a05:600c:3095:b0:3e0:270f:dc88 with SMTP id g21-20020a05600c309500b003e0270fdc88mr4727008wmn.33.1676552145109;
        Thu, 16 Feb 2023 04:55:45 -0800 (PST)
X-Google-Smtp-Source: AK7set+7vAUFLmGpK/uGMNwqyeDbGIKjmd05FOFkQfPnLLLkNoDCGfYC4U+JHMip2ipd/4/xZ0D3Eg==
X-Received: by 2002:a05:600c:3095:b0:3e0:270f:dc88 with SMTP id g21-20020a05600c309500b003e0270fdc88mr4726994wmn.33.1676552144813;
        Thu, 16 Feb 2023 04:55:44 -0800 (PST)
Received: from ?IPV6:2003:cb:c708:bc00:2acb:9e46:1412:686a? (p200300cbc708bc002acb9e461412686a.dip0.t-ipconnect.de. [2003:cb:c708:bc00:2acb:9e46:1412:686a])
        by smtp.gmail.com with ESMTPSA id i28-20020a1c541c000000b003dd1c45a7b0sm1803896wmb.23.2023.02.16.04.55.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Feb 2023 04:55:44 -0800 (PST)
Message-ID: <36284094-b8b7-abe2-3ac9-f504a7c8010f@redhat.com>
Date:   Thu, 16 Feb 2023 13:55:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 1/2] m68k/nommu: add missing definition of ARCH_PFN_OFFSET
Content-Language: en-US
To:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mm@kvack.org, linux-sh@vger.kernel.org
References: <20230214140729.1649961-1-rppt@kernel.org>
 <20230214140729.1649961-2-rppt@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230214140729.1649961-2-rppt@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.02.23 15:07, Mike Rapoport wrote:
> From: "Mike Rapoport (IBM)" <rppt@kernel.org>
> 
> On m68k/nommu RAM does not necessarily start at 0x0 and when it does not
> pfn_valid() uses a wrong offset into the memory map which causes silent
> boot failures.
> 
> Define ARCH_PFN_OFFSET to make pfn_valid() use the correct offset.
> 
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Fixes: d82f07f06cf8 ("m68k: use asm-generic/memory_model.h for both MMU and !MMU")
> Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
> ---

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

