Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66E9A6F9D12
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 02:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231779AbjEHAqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 20:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbjEHAqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 20:46:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A5F8A26C
        for <linux-kernel@vger.kernel.org>; Sun,  7 May 2023 17:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683506716;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=okFAsHxyJchjNrk0KoWMUmCZd1ga74s7ApU5O8osyqA=;
        b=GlbaACkHsuGwlg2+OBB5RpU5eM8iW3Pz06m8H3IZ5PEvokXeLAYw1JB5qL/R/T6nPfpbni
        Xi0Q4iH+fNnIoWKxXgbPWTdtOxjBqenZ8ySlIlpPip3VByM3n5XfR1YS0bAQTarRGHkolk
        qb3TgqNDQz+dpyhQmWux1ZJYurG0y6k=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-79-ZFu81I1xN_qF3b5SSqgGeg-1; Sun, 07 May 2023 20:45:14 -0400
X-MC-Unique: ZFu81I1xN_qF3b5SSqgGeg-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-24e205905d4so3751124a91.0
        for <linux-kernel@vger.kernel.org>; Sun, 07 May 2023 17:45:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683506713; x=1686098713;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :content-language:references:cc:to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=okFAsHxyJchjNrk0KoWMUmCZd1ga74s7ApU5O8osyqA=;
        b=NapjCIDbnaluVmQfBO04ZRmhpzncezTZugfP58Sj4Ers6ntNZCuIYjehxCHJwY20nh
         zQ2NvpNRkqo7GKFRc5xOeInL0HUQXdIohnKl7LXXvNuM2S2Bvn2ChJaq75kjQ7H8YJcd
         TVg0q3YmQeGJf8CLh5GmATm0L4rHb37yZs5vxMuKhg6pIH8xHfrP0SxY0iXWS4wOMBWd
         K137jMsRoh61JA+uFueV01Dm6zlwh9GZx4P8JCC9OPIJIQjK0MA62HT54pNcqkj9fLxu
         X11CW/3wD3DnMMOdULbAN3arPC+koFTSXiG5K0LL4X+ksyjBQjq2L9DHUG58nohCyYEb
         Dvug==
X-Gm-Message-State: AC+VfDyNkmwAoL3uSS377eohVYUV3Owvz4W95Qg/A8EyVM6ZMcLGqQw5
        iGFA5vuyqtpDlaUHRPavSFfVmGga9Lzx0oTJtNYJS8GqEWU0ejNafH0UkaX623JrP7IDP88SRAS
        h8DvewxocsBbXMjNO0O7U0qTw/6qi0ofO7/vVnQ==
X-Received: by 2002:a17:902:e881:b0:1ac:83d1:9269 with SMTP id w1-20020a170902e88100b001ac83d19269mr173378plg.16.1683506713406;
        Sun, 07 May 2023 17:45:13 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6ilOeSF24ChjvijrcWynnSsR3umEj3DjlM86i7bewgAZM9hCT70b/UXz1MUwFbUTzSHnnrIg==
X-Received: by 2002:a17:902:e881:b0:1ac:83d1:9269 with SMTP id w1-20020a170902e88100b001ac83d19269mr173361plg.16.1683506712996;
        Sun, 07 May 2023 17:45:12 -0700 (PDT)
Received: from [192.168.35.160] ([64.114.255.114])
        by smtp.gmail.com with ESMTPSA id e9-20020a17090301c900b001ac7af57fd4sm567699plh.86.2023.05.07.17.45.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 May 2023 17:45:12 -0700 (PDT)
Message-ID: <2dbc82e9-30dc-5187-cdd6-166fa53213c4@redhat.com>
Date:   Mon, 8 May 2023 02:45:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
To:     Andrew Morton <akpm@linux-foundation.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cb971ac8dd315df97058ea69442ecc007b9a364a.1683381545.git.lstoakes@gmail.com>
 <20230507173022.96c9d24cb1aa6f57ed50f5fa@linux-foundation.org>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH] mm/gup: add missing gup_must_unshare() check to
 gup_huge_pgd()
In-Reply-To: <20230507173022.96c9d24cb1aa6f57ed50f5fa@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.05.23 02:30, Andrew Morton wrote:
> On Sat,  6 May 2023 15:05:25 +0100 Lorenzo Stoakes <lstoakes@gmail.com> wrote:
> 
>> All other instances of gup_huge_pXd() perform the unshare check, so update
>> the PGD-specific function to do so as well.
>>
>> While checking pgd_write() might seem unusual, this function already
>> performs such a check via pgd_access_permitted() so this is in line with
>> the existing implementation.
> 
> Rationale seems strange.  "Other sites do it so this should also".  Why
> is this a desirable change?  Maybe the "other instances" shouldn't be
> performing this check either?

This change makes unshare handling across all GUP-fast variants consistent,
which is desirable as GUP-fast is complicated enough already even when
consistent :)

This function was the only one I seemed to have missed (or left out and forgot
why -- maybe because it's really dead code for now). The COW selftest would
identify the problem, so far there was no report. Either the selftest wasn't
run on corresponding architectures with that hugetlb size, or that code is still
dead code and unused by architectures.

I suspect the latter.


It might be worth to add a reference to the original commit(s) that added unsharing,
because they also explain why we care about these checks:

commit a7f226604170acd6b142b76472c1a49c12ebb83d
Author: David Hildenbrand <david@redhat.com>
Date:   Mon May 9 18:20:45 2022 -0700

     mm/gup: trigger FAULT_FLAG_UNSHARE when R/O-pinning a possibly shared anonymous page


commit 84209e87c6963f928194a890399e24e8ad299db1
Author: David Hildenbrand <david@redhat.com>
Date:   Wed Nov 16 11:26:48 2022 +0100

     mm/gup: reliable R/O long-term pinning in COW mappings


Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

