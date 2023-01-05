Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3074165E74E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 10:06:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231937AbjAEJGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 04:06:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232084AbjAEJFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 04:05:07 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9FB15007F
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 01:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672909461;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Gex+QnT4hwAgx1h+eIu+UAUxgiKZCLZj1HYsXCJOojw=;
        b=cgC0nni0XH772NNNUeYmGTKP64KSxj3RZRNqgJXjthVi5ZMefx9RI+bcgAi9kUDUAXNI7E
        EFVGZCc1qxcrWt5jPtA9Yf77fT4x7jBiCtR4rTaFQjKz8I/p6HZUUH/SnTmd/nyRC0n9Jm
        xuAj1WBofAW5BNkMa0HaQZ/S5j8KR9Y=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-530-X3jpMMtzMU6iX1HPFCRUNg-1; Thu, 05 Jan 2023 04:04:17 -0500
X-MC-Unique: X3jpMMtzMU6iX1HPFCRUNg-1
Received: by mail-wm1-f70.google.com with SMTP id c7-20020a1c3507000000b003d355c13ba8so19425763wma.6
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 01:04:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gex+QnT4hwAgx1h+eIu+UAUxgiKZCLZj1HYsXCJOojw=;
        b=EJvtgH0BmVL8SodLpAPg5dRKc4WZz2mj64d55sb/MxWcN+/oy+6mZUh8MC5MMcAGlo
         CTPG4hUuy1+XHrtgWUNUiiwiJxkulMgimtCjEE6gba3SmtxyJym7D1oYlS+6qcv9nHCL
         iDEJWhOuYY6lVDhMPoAiwNcwiAfzWDxLN+F11O6PrXQ0/6DkQuU96vhdcVyATj3zEosF
         7nwp+dt/93PD+USDo5fBgx8YfacHQrgHT8ueuvNybri/rd/0LrULU2iScLMlWZcd7LRj
         0LIw3885Ivl8lV6OWYHbA+JAA/8zYEjurdLKrw7NKx61SbW4l9P/xaNPdPH0Igi77mFV
         Kb7A==
X-Gm-Message-State: AFqh2kqr8ZU6vdS4HRlFXSKR8ZnNZ8ojD7+WYT6ahQl2tajePvlMGjKZ
        7I05hzEoVxP3kPzaNHsEbxNEeubxLA68KWzcRJniWfOjfbWZ3QOgpSaEhm/gHmi1tnZ8EwAnWxN
        q1x/iFGY47gOhiefLtL3QwuKl
X-Received: by 2002:a05:600c:3d11:b0:3cf:8b22:76b3 with SMTP id bh17-20020a05600c3d1100b003cf8b2276b3mr36164745wmb.0.1672909456589;
        Thu, 05 Jan 2023 01:04:16 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvE4YV6gmwoMdYh7/YQCeNZ3S6PGe2qC4e43M/dqNDy8OkC6hj8sgg2g/J5YgDEpskNAkF9hw==
X-Received: by 2002:a05:600c:3d11:b0:3cf:8b22:76b3 with SMTP id bh17-20020a05600c3d1100b003cf8b2276b3mr36164714wmb.0.1672909456272;
        Thu, 05 Jan 2023 01:04:16 -0800 (PST)
Received: from ?IPV6:2003:cb:c707:6e00:ff02:ec7a:ded5:ec1e? (p200300cbc7076e00ff02ec7aded5ec1e.dip0.t-ipconnect.de. [2003:cb:c707:6e00:ff02:ec7a:ded5:ec1e])
        by smtp.gmail.com with ESMTPSA id n126-20020a1ca484000000b003d21759db42sm1717113wme.5.2023.01.05.01.04.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jan 2023 01:04:15 -0800 (PST)
Message-ID: <ccbd7330-b7d7-9048-b49a-80f904353c21@redhat.com>
Date:   Thu, 5 Jan 2023 10:04:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 1/1] mm: fix vma->anon_name memory leak for anonymous
 shmem VMAs
Content-Language: en-US
To:     Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org
Cc:     hughd@google.com, hannes@cmpxchg.org, vincent.whitchurch@axis.com,
        seanjc@google.com, rppt@kernel.org, shy828301@gmail.com,
        pasha.tatashin@soleen.com, paul.gortmaker@windriver.com,
        peterx@redhat.com, vbabka@suse.cz, Liam.Howlett@Oracle.com,
        ccross@google.com, willy@infradead.org, arnd@arndb.de,
        cgel.zte@gmail.com, yuzhao@google.com, bagasdotme@gmail.com,
        suleiman@google.com, steven@liquorix.net, heftig@archlinux.org,
        cuigaosheng1@huawei.com, kirill@shutemov.name,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org,
        syzbot+91edf9178386a07d06a7@syzkaller.appspotmail.com
References: <20230105000241.1450843-1-surenb@google.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230105000241.1450843-1-surenb@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.01.23 01:02, Suren Baghdasaryan wrote:
> free_anon_vma_name() is missing a check for anonymous shmem VMA which
> leads to a memory leak due to refcount not being dropped.  Fix this by
> calling anon_vma_name_put() unconditionally. It will free vma->anon_name
> whenever it's non-NULL.
> 
> Fixes: d09e8ca6cb93 ("mm: anonymous shared memory naming")
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Suggested-by: David Hildenbrand <david@redhat.com>
> Reported-by: syzbot+91edf9178386a07d06a7@syzkaller.appspotmail.com
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Pasha Tatashin <pasha.tatashin@soleen.com>


Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

