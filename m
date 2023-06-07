Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D78D27264F9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 17:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241168AbjFGPqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 11:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240804AbjFGPqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 11:46:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A1611BE4
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 08:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686152732;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WmCSirP/uxnPSNlkT1l+fq1faJ8Vy9bVgc0QZjRILzA=;
        b=OiFEcgeMzhpx+R4h5Hp1GH0xe0focssJ2wxqY3tTKsfHKFhcX8g9gyQ1jcLKfaHZGKdx38
        qG3G0TdY+sHKNFCYhCMFHdUqvGz8U4A76i9DTKv3B+EI5o5p99/4iX6+JFo4UoCz5dSwZ3
        j8lrIJhC8x8t0uOeKFlgt+0okmtOlBk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-148-aagBEChmNUmaT2f9YS__aQ-1; Wed, 07 Jun 2023 11:45:31 -0400
X-MC-Unique: aagBEChmNUmaT2f9YS__aQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3f5fc8581a9so37805375e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 08:45:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686152730; x=1688744730;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WmCSirP/uxnPSNlkT1l+fq1faJ8Vy9bVgc0QZjRILzA=;
        b=JfuJQg1qUQMn30CpaM/qh1Zlxhyj+4Z31rXttAa0BghYMgWxjOdk10K0dFEzd8H4zH
         zhCNgSSj3oYJsD0EBGhBZY49X8Ws24cFynPLx7p+ZpqsuLJ08DrDWxfBd7+hOvgp12Ct
         c5i0MPV2yZBGLINxUqGDZ7WFqkDmq7IgGu3qoq1WGlCWH8iFH5Ob93hfKba2r4oGMysI
         763ylrmx7E1fABVkgy3OPuVHADd6Q89sj+0WI4LHcPYGWoKCzZ+UjKgeErdb76hhPewP
         oOxpz3RMhbMNnbhQIZbzgQJr8VqaBjxHfgHQlwJoz8f+ygTbKdjA0gl9M0iVKnfCbziI
         7J3w==
X-Gm-Message-State: AC+VfDyk36KaBwbvQpVXVnfMDYwZIVI4TEByGRJb/N0I6fWHQXFt/XDL
        SSQR428L1EXJCLJx62rR5rH5Wu9MAO4kSRlCauPJmUZyVkThGyi5HDjmKDp5XcigIizhjoaahki
        W67+gLs7GJUpILjbGhbEhuQqA
X-Received: by 2002:a1c:740b:0:b0:3f7:f5a4:1f95 with SMTP id p11-20020a1c740b000000b003f7f5a41f95mr142230wmc.18.1686152730301;
        Wed, 07 Jun 2023 08:45:30 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6FaFQN/GNNGZTokhRQWAHWMqnlDhi4xKe+gXZoDnfcpWheIr6e68L5//L7KFdheo7GePJQ9Q==
X-Received: by 2002:a1c:740b:0:b0:3f7:f5a4:1f95 with SMTP id p11-20020a1c740b000000b003f7f5a41f95mr142209wmc.18.1686152729932;
        Wed, 07 Jun 2023 08:45:29 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70e:9c00:8d26:3031:d131:455c? (p200300cbc70e9c008d263031d131455c.dip0.t-ipconnect.de. [2003:cb:c70e:9c00:8d26:3031:d131:455c])
        by smtp.gmail.com with ESMTPSA id fc14-20020a05600c524e00b003f61177faffsm8660506wmb.0.2023.06.07.08.45.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 08:45:29 -0700 (PDT)
Message-ID: <97b5657d-e09d-b3a9-c09d-eaff9fb7929d@redhat.com>
Date:   Wed, 7 Jun 2023 17:45:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 0/4] mm: Fix pmd_trans_unstable() call sites on retry
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Alistair Popple <apopple@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Johannes Weiner <hannes@cmpxchg.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Hugh Dickins <hughd@google.com>,
        Mike Rapoport <rppt@kernel.org>
References: <20230602230552.350731-1-peterx@redhat.com> <ZICK3uqTeUxeIlc9@x1n>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <ZICK3uqTeUxeIlc9@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.06.23 15:49, Peter Xu wrote:
> On Fri, Jun 02, 2023 at 07:05:48PM -0400, Peter Xu wrote:
>> Please have a look, thanks.
> 
> Hello, all,
> 
> This one seems to have more or less conflict with Hugh's rework on pmd
> collapse.  Please hold off review or merging until I prepare another one
> (probably based on Hugh's, after I have a closer read).
> 
> Sorry for the noise.
> 

[did not have time to look yet]

Are there any fixes buried in there that we'd like to have in earlier? I 
skimmed over the patches and all read like "cleanup" + "consistency", 
correct?

-- 
Cheers,

David / dhildenb

