Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3701712378
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 11:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243080AbjEZJZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 05:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbjEZJZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 05:25:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 101BE135
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 02:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685093063;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0hvsOWsTxhCAtK9wZGl3ItbtOHeNAmtLYxozsBT60tM=;
        b=LOmgj6iW1lawQF5OJWYlTbC/irysm1be0LK7tY5gZA9YPMI+cw7tBhchsPXE5N9hKGOabd
        lCx2OoI/bsxWPHG1pj5DufY1GJrGyF/IGauJUZPKI6GatPAcLHe+QVwxZnefhBgmuQX+WQ
        qTzotwqQHlHSFSntSkd7r1cwPZUTCSc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-FcaMM6bfPVGnW7cas30heA-1; Fri, 26 May 2023 05:24:21 -0400
X-MC-Unique: FcaMM6bfPVGnW7cas30heA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-307897bc279so313715f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 02:24:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685093060; x=1687685060;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0hvsOWsTxhCAtK9wZGl3ItbtOHeNAmtLYxozsBT60tM=;
        b=IhmQAeAdhz+m2CrRbFXB/w4RDy82bYQoE+1l6fsj3DdaOWHG6vz7IRrbf8L0uA3dtw
         t8ieWXUdILH56Bz4jVjL/85nxE3cH4t2/McqLFnqIXk7P43xZJNbBWfddppglpwdhCwE
         9sGoRJMfpn5dBwsJtvU1BXKZ/Ae76PxvuPGLWzPPxy8mvUwC5elwvz8Tg6gAycPnfDVS
         vgQfmAjFUUTbiQnueRr2dEtvpZlecur8H9gKMuvEyMJOWkIATi7H5cvP8cOVrcwzk+cB
         RLr92+5EP814yJSDU/st0xMbsozXZI2JbKso1Ydo5vc/SSDHu4S71fcBNREa7Mh9KLn1
         bp/g==
X-Gm-Message-State: AC+VfDzSlT0PNxzA7YVHFtkXU9FHa73XC78qJRj2IlrjTwU178Wq5MJp
        W8AiJQB+6faMYRrHBc2HQac8Q4cn6jOgpAzubRrZmhKEHEdBvUN3hdDo+c9DwAGNUH5UHrdATj7
        WL9HBmGNHduusAs1takEWTmCq
X-Received: by 2002:adf:e704:0:b0:306:459b:f575 with SMTP id c4-20020adfe704000000b00306459bf575mr994695wrm.12.1685093060457;
        Fri, 26 May 2023 02:24:20 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7/DN4isxucuKpWnb3968aE5fezzmDpKs9YwOs8B5KHM5/+Y68dG7HuVKtISlXTfNhMp11ttA==
X-Received: by 2002:adf:e704:0:b0:306:459b:f575 with SMTP id c4-20020adfe704000000b00306459bf575mr994681wrm.12.1685093060096;
        Fri, 26 May 2023 02:24:20 -0700 (PDT)
Received: from ?IPV6:2003:cb:c710:9700:7003:7e4d:43dd:7bfd? (p200300cbc710970070037e4d43dd7bfd.dip0.t-ipconnect.de. [2003:cb:c710:9700:7003:7e4d:43dd:7bfd])
        by smtp.gmail.com with ESMTPSA id v10-20020adfe28a000000b003063a1cdaf2sm4390604wri.48.2023.05.26.02.24.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 May 2023 02:24:19 -0700 (PDT)
Message-ID: <950f095f-5182-6f14-cdc3-ce5eb35884ca@redhat.com>
Date:   Fri, 26 May 2023 11:24:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC PATCH v2 1/3] mm: Don't pin ZERO_PAGE in pin_user_pages()
Content-Language: en-US
To:     David Howells <dhowells@redhat.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Christian Brauner <brauner@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>
References: <4f479af6-2865-4bb3-98b9-78bba9d2065f@lucifer.local>
 <89c7f535-8fc5-4480-845f-de94f335d332@lucifer.local>
 <20230525223953.225496-1-dhowells@redhat.com>
 <20230525223953.225496-2-dhowells@redhat.com>
 <520730.1685090615@warthog.procyon.org.uk>
 <522654.1685092526@warthog.procyon.org.uk>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <522654.1685092526@warthog.procyon.org.uk>
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

On 26.05.23 11:15, David Howells wrote:
> Lorenzo Stoakes <lstoakes@gmail.com> wrote:
> 
>>> iov_iter_extract_pages(), on the other hand, is only used in two places
>>> with these patches and the pins are always released with
>>> unpin_user_page*() so it's a lot easier to audit.
>>
>> Thanks for the clarification. I guess these are the cases where you're
>> likely to see zero page usage, but since this is changing all PUP*() callers
>> don't you need to audit all of those too?
> 
> I don't think it should be necessary.  This only affects pages obtained from
> gup with FOLL_PIN - and, so far as I know, those always have to be released
> with unpin_user_page*() which is part of the gup API and thus it should be
> transparent to the users.

Right, and even code like like 873aefb376bb ("vfio/type1: Unpin zero 
pages") would handle it transparently, because they also call 
unpin_user_page().

[we can remove 873aefb376bb even without this change way because it uses 
FOLL_LONGTERM that shouldn't return the shared zeropage anymore ]

-- 
Thanks,

David / dhildenb

