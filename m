Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B71BB67951F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 11:25:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233412AbjAXKZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 05:25:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233438AbjAXKZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 05:25:00 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22FC03EFFE
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 02:24:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674555851;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aN9Czgm5CvGAuhzMkEVI/TT2p7pAyYcgvgmwqZIYz7k=;
        b=YCjy4xJy7zuNfkMyrWt8qTgBSseh3GQIqR2/cfS7Pcao08VXSzrTSNI2XxpyuMZ5g83lLJ
        gXzOykwTW7PQFPClGcjiIWZ5RU3ZefLut3Ji7AGILDHu50AJ44BxXu9aVNM95mofYkSuu8
        +4iAfsSx/MHatxSWwLk2Czr2HbUKVUk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-633-wWeTkrv2Pte58j_1QfOKGg-1; Tue, 24 Jan 2023 05:24:09 -0500
X-MC-Unique: wWeTkrv2Pte58j_1QfOKGg-1
Received: by mail-wr1-f69.google.com with SMTP id v3-20020adfa1c3000000b002bdd6ce1358so2518525wrv.23
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 02:24:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aN9Czgm5CvGAuhzMkEVI/TT2p7pAyYcgvgmwqZIYz7k=;
        b=3OJiDues53pJD8vL0KHwL/9wHSgPCTwCqIOG1Nhat2PLEC1/CY+mO6yqxdCrWg3Mqd
         U1dNV5kwitc/TdMia1ZAWAMlbD7l/c0jDrvCGxShuMhNosfYp/x7d8MlM4HqqrRS6puR
         Ee9BFvk8YOy6GJt0inB2OeWhUkruom/+Hg5uzc5u+vk9sA7jYGGwSSWBkypboJH31zd7
         qdKBK4rHh4gs+h7y3aKp1gq894oms9i9lf6mRU6fzwp0cF1Dvv3VOI1ElfavVfXWptNE
         EtPw8xrIS6BUerZ17Eell02Xae8+etyrvziRpKWmTJ9WvQjW5YmT0NppuJwoc+wyYusp
         D2Cw==
X-Gm-Message-State: AFqh2kpxxqZn0JLxsX/0rcTLzXBeG4xrpWQODFv73vdBJ9uiYmgDO3T7
        CKdO3GRUzjLHHmRs1mIMYcqjaI28g/O4X2R4xgUYthlk/SfoT6fQT0kMGZcgksYvmFmnoKgtxMv
        4b0BHE8ocAwEXIJkdBERpAXaH
X-Received: by 2002:adf:cd83:0:b0:2bd:d839:9918 with SMTP id q3-20020adfcd83000000b002bdd8399918mr24886322wrj.64.1674555848060;
        Tue, 24 Jan 2023 02:24:08 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvXXP7Tc/e17pSmW1GpJFeCPP5/mQ+K8WAe0128IKdfjGI9rBrCOa1/WAOJCs/1tWe8RBEGig==
X-Received: by 2002:adf:cd83:0:b0:2bd:d839:9918 with SMTP id q3-20020adfcd83000000b002bdd8399918mr24886301wrj.64.1674555847781;
        Tue, 24 Jan 2023 02:24:07 -0800 (PST)
Received: from ?IPV6:2003:cb:c707:9d00:9303:90ce:6dcb:2bc9? (p200300cbc7079d00930390ce6dcb2bc9.dip0.t-ipconnect.de. [2003:cb:c707:9d00:9303:90ce:6dcb:2bc9])
        by smtp.gmail.com with ESMTPSA id y15-20020adfdf0f000000b00236883f2f5csm1532407wrl.94.2023.01.24.02.24.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 02:24:07 -0800 (PST)
Message-ID: <e5eb9d67-dbbe-a0d9-1973-d6e6bee4db3a@redhat.com>
Date:   Tue, 24 Jan 2023 11:24:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v7 0/8] iov_iter: Improve page extraction (ref, pin or
 just list)
Content-Language: en-US
To:     Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>
Cc:     David Howells <dhowells@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <Y862ZL5umO30Vu/D@casper.infradead.org>
 <20230120175556.3556978-1-dhowells@redhat.com>
 <318138.1674491927@warthog.procyon.org.uk>
 <Y865EIsHv3oyz+8U@casper.infradead.org>
 <20230123172529.woo34hnycrn7xhwk@quack3>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230123172529.woo34hnycrn7xhwk@quack3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.01.23 18:25, Jan Kara wrote:
> On Mon 23-01-23 16:42:56, Matthew Wilcox wrote:
>> On Mon, Jan 23, 2023 at 04:38:47PM +0000, David Howells wrote:
>>> Matthew Wilcox <willy@infradead.org> wrote:
>>> Also you only mention DIO read - but what about "start DIO write; fork(); touch
>>> buffer" in the parent - now the write buffer belongs to the child and they can
>>> affect the parent's write.
>>
>> I'm struggling to see the problem here.  If the child hasn't exec'd, the
>> parent and child are still in the same security domain.  The parent
>> could have modified the buffer before calling fork().
> 
> Sadly they are not. Android in particular starts applications by forking
> one big binary (zygote) that has multiple apps linked together and relies
> on the fact the child cannot influence the parent after the fork. We've
> already had CVEs with GUP & COW & fork due to this. David Hildebrand has a
> lot of memories regarding this I believe ;)

:)

Once FOLL_PIN is used most of the issues go away and we don't have to 
play any games with VM flags or similar ...

With FOLL_PIN, I consider anon a solved problem and not worth any new 
fancy ideas.

-- 
Thanks,

David / dhildenb

