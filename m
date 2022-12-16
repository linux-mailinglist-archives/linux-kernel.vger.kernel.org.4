Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E33264EE8E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 17:08:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232601AbiLPQHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 11:07:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231277AbiLPQHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 11:07:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4167B102F
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 08:04:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671206651;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qQVNpA1uebmeJDop3AawgUtcYkrEx880mhk59ps+M7g=;
        b=Q7Pa2dYmCQ4J6KzXbLRpRQBfgSqWxrTGP4r67SS4LpDemWyaI0D1u7+7c4ZUA2wTqZZOUj
        rxO58f4/44OiiNdp+1VgE13dfHaJa3Ra2PeE0NOB4d5aDp5/iobgPcEvsBECG8j2isLh8o
        6gAozYdqwNX1g+cdQS346MDx9X3VfMk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-232-9i42XGBuPCO_v7JKZFyOfw-1; Fri, 16 Dec 2022 11:04:10 -0500
X-MC-Unique: 9i42XGBuPCO_v7JKZFyOfw-1
Received: by mail-wm1-f69.google.com with SMTP id r129-20020a1c4487000000b003d153a83d27so1401053wma.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 08:04:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qQVNpA1uebmeJDop3AawgUtcYkrEx880mhk59ps+M7g=;
        b=KxeVNxzH98R/8cZXIEEgxCegry9a5hPXdfU9f1uNSJuebdy7E5SmGxbIWohQpGEH3H
         5O6zO6YPEt9tJsfgwYyGTJmwrJuRZygJCgCoJ4cfykRzDsHcpxHItZ2Yf6dYQmxBSAuW
         uxYDPBYBV0C/qK1DO2gdIAozoXN8ctduyOgOAFpbSNB47Kcudhdkh95hhwkEL5ILPHtV
         NDYMWd6XZN/G3buemVHfULsEP8IzFTXaJVtjlxH2Q4v5kD0JWhC36p7+Z2hYpcAlxGQO
         vWZewhe01n4J8eYSs66jGGipqJtytO5JQm5AsmevYFTt9XTT5oTRPV1XStsUHNc2cFs/
         T5HA==
X-Gm-Message-State: ANoB5pnjPTm8BVWWNdXtXdDnMqUFE3R36gz43hrYa6PPrABzdqyMSJ6n
        vd9Wm2jeJouBXJTpkBzBhSkemgrCdHAFGIzTjkIw9tgVY9FLWXjQxe0N52MTs+15p8+lFd1LkV9
        kDA3rQZ8c7GXWw7SUhHpH1oJi
X-Received: by 2002:a05:600c:1da9:b0:3c7:a5:610e with SMTP id p41-20020a05600c1da900b003c700a5610emr26397879wms.27.1671206648940;
        Fri, 16 Dec 2022 08:04:08 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5FXoyyoojkPA8DSBV7JMHnDUCdo6rCxiGpo8VsADBIE2hqSMxjc7E22yI7uL5rmmTlLo5q6w==
X-Received: by 2002:a05:600c:1da9:b0:3c7:a5:610e with SMTP id p41-20020a05600c1da900b003c700a5610emr26397851wms.27.1671206648647;
        Fri, 16 Dec 2022 08:04:08 -0800 (PST)
Received: from ?IPV6:2003:cb:c71c:3900:7211:d436:8d8b:531c? (p200300cbc71c39007211d4368d8b531c.dip0.t-ipconnect.de. [2003:cb:c71c:3900:7211:d436:8d8b:531c])
        by smtp.gmail.com with ESMTPSA id u9-20020a05600c00c900b003cf37c5ddc0sm2914316wmm.22.2022.12.16.08.04.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Dec 2022 08:04:08 -0800 (PST)
Message-ID: <2eb1cc61-01ec-10c2-e81f-f4325ca7b03f@redhat.com>
Date:   Fri, 16 Dec 2022 17:04:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 2/2] mm: Fix a few rare cases of using swapin error pte
 marker
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Huang Ying <ying.huang@intel.com>
References: <20221214200453.1772655-1-peterx@redhat.com>
 <20221214200453.1772655-3-peterx@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20221214200453.1772655-3-peterx@redhat.com>
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

On 14.12.22 21:04, Peter Xu wrote:
> This patch should harden commit 15520a3f0469 ("mm: use pte markers for swap
> errors") on using pte markers for swapin errors on a few corner cases.
> 
> 1. Propagate swapin errors across fork()s: if there're swapin errors in
>     the parent mm, after fork()s the child should sigbus too when an error
>     page is accessed.
> 
> 2. Fix a rare condition race in pte_marker_clear() where a uffd-wp pte
>     marker can be quickly switched to a swapin error.
> 
> 3. Explicitly ignore swapin error pte markers in change_protection().
> 
> I mostly don't worry on (2) or (3) at all, but we should still have them.
> Case (1) is special because it can potentially cause silent data corrupt on
> child when parent has swapin error triggered with swapoff, but since swapin
> error is rare itself already it's probably not easy to trigger either.
> 
> Currently there is a priority difference between the uffd-wp bit and the
> swapin error entry, in which the swapin error always has higher
> priority (e.g. we don't need to wr-protect a swapin error pte marker).
> 
> If there will be a 3rd bit introduced, we'll probably need to consider a
> more involved approach so we may need to start operate on the bits.  Let's
> leave that for later.
> 
> This patch is tested with case (1) explicitly where we'll get corrupted
> data before in the child if there's existing swapin error pte markers, and
> after patch applied the child can be rightfully killed.
> 
> We don't need to copy stable for this one since 15520a3f0469 just landed as
> part of v6.2-rc1, only "Fixes" applied.
> 
> Fixes: 15520a3f0469 ("mm: use pte markers for swap errors")
> Signed-off-by: Peter Xu <peterx@redhat.com>

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

