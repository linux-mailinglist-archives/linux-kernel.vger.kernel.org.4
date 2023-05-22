Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C52A70B2F4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 03:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbjEVByj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 21:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231511AbjEVByh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 21:54:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE94EE0
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 18:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684720429;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LjpVYliWYmLsp+7DmHIQ6WIiz69+8hAntxXwMv/K+0o=;
        b=OM6pt4AGyJiCf8dByX7LveLvGYDLw6SU+2REsA9x1C6gr+oNlIr6Bw+4dIxXIqWYc12ZLQ
        Rwill0HsndOZa/saewr898U2DGzNcv6TE1xm3F7jXguWLLJNchizq1q2Q9MgY12G2fQWAE
        eZmJYXYXX6O/zfvv5yIu4LpzIy9PE/A=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-354-q4s1fymvOm2I0WH1I1bqTw-1; Sun, 21 May 2023 21:53:40 -0400
X-MC-Unique: q4s1fymvOm2I0WH1I1bqTw-1
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-64d413b27a1so1063001b3a.2
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 18:53:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684720419; x=1687312419;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LjpVYliWYmLsp+7DmHIQ6WIiz69+8hAntxXwMv/K+0o=;
        b=Kb66uV0UA+79AneEtIkOBhaX5spiljudbL9/GnvEIYydeB3/k+LyeJ5hWUl9rt/7lq
         DbStkZIaFmS+zUe5CeBIs2Fuw6n5FdvKEIFFUee6qkkZVtO/CMbkWZcoitcbtzftFIt3
         mK2WBxt2JSxIk6YEWfVcKC2l1f35pAW91fBPW1TDuPS8vb1jg4qzHAypAgJrCmB65bqu
         UYdK8EsViYia4BjfDFe8B9uuZwVtHL5VqSciaMfTfYKeoP0s6A0tY+1zbH/tEBrzRWdp
         oREZe4DPF60UMcGGcnWGrsAX4uRKFrsSq+oIzHWrSjwW0MmYban03FZ8GefReQOS38Qb
         Z4aQ==
X-Gm-Message-State: AC+VfDxDFILDNVF2k0Wx/0sOTXQZyukM71UV8nCgZkJpPkieo2N2iiHk
        rr0VirLUZvRrSL6o4dgGbDVsuyWDbUVztDrnCUGZTnRZ792AirQ+txqKs8XYUEWYAwXwlGi0TT9
        aBrWVdCC75hz7C/saG8agkZPY
X-Received: by 2002:a05:6a00:2314:b0:63b:6149:7ad6 with SMTP id h20-20020a056a00231400b0063b61497ad6mr11651217pfh.34.1684720419702;
        Sun, 21 May 2023 18:53:39 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7Mn7xT7CCI+yBGqvco+AvK/IKOxX++Ib2iwxBd4veVXnB4vaLlF/dnAev/HMla5PSUAUk2RQ==
X-Received: by 2002:a05:6a00:2314:b0:63b:6149:7ad6 with SMTP id h20-20020a056a00231400b0063b61497ad6mr11651198pfh.34.1684720419429;
        Sun, 21 May 2023 18:53:39 -0700 (PDT)
Received: from [10.72.12.68] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id s9-20020aa78289000000b0063f2e729127sm3121905pfm.144.2023.05.21.18.53.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 May 2023 18:53:38 -0700 (PDT)
Message-ID: <ef4cc431-4cc4-eb39-735d-0b3b3759abed@redhat.com>
Date:   Mon, 22 May 2023 09:53:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v20 13/32] ceph: Provide a splice-read stub
Content-Language: en-US
To:     David Howells <dhowells@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Christian Brauner <brauner@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Christoph Hellwig <hch@lst.de>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org
References: <c1fd63b9-42ea-fa83-ecb1-9af715e37ffa@redhat.com>
 <20230519074047.1739879-1-dhowells@redhat.com>
 <20230519074047.1739879-14-dhowells@redhat.com>
 <1743656.1684488288@warthog.procyon.org.uk>
From:   Xiubo Li <xiubli@redhat.com>
In-Reply-To: <1743656.1684488288@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/19/23 17:24, David Howells wrote:
> Xiubo Li <xiubli@redhat.com> wrote:
>
>>> +	ret = ceph_get_caps(in, CEPH_CAP_FILE_RD, want, -1, &got);
>>> +	if (ret < 0) {
>>> +		ceph_end_io_read(inode);
>>> +		return ret;
>>> +	}
>>> +
>>> +	if ((got & (CEPH_CAP_FILE_CACHE | CEPH_CAP_FILE_LAZYIO)) == 0) {
>>> +		dout("splice_read/sync %p %llx.%llx %llu~%zu got cap refs on %s\n",
>>> +		     inode, ceph_vinop(inode), *ppos, len,
>>> +		     ceph_cap_string(got));
>>> +
>>> +		ceph_end_io_read(inode);
>>> +		return direct_splice_read(in, ppos, pipe, len, flags);
>> Shouldn't we release cap ref before returning here ?
> Ummm...  Even if we got no caps?

No, at least we have got the 'need' caps: CEPH_CAP_FILE_RD once here.

I saw you have updated this and will check it.

Thanks

- Xiubo

>
> David
>

