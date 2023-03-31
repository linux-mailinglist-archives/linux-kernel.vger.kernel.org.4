Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 412F26D2121
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 15:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232725AbjCaNGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 09:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232712AbjCaNGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 09:06:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38B0ABBB4
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 06:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680267920;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hgW8cTlK+PJOT8RKw+ZUtnYCCPaowJ5bRdHT0sOdQqU=;
        b=GKAcC+rzVs1W5lZ8eR44P9KPI686kEUBsrNi4GXoHT7Aopd+thSYit76fQCkFJdRjpPR6W
        wwkOldCmk1kz2zfJF25QFsJSPyvSrs8kWlrbJh1609u9ATxQ+hjKEM0W+czda0PGsfkwxa
        al89+n5fFwfOKpPkLkY1CbYTQ9u7OJk=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-552-UfOJmdo_N4SPC7StJeuosg-1; Fri, 31 Mar 2023 09:05:19 -0400
X-MC-Unique: UfOJmdo_N4SPC7StJeuosg-1
Received: by mail-pj1-f70.google.com with SMTP id d5-20020a17090a7bc500b0023d3366e005so6320741pjl.6
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 06:05:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680267918;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hgW8cTlK+PJOT8RKw+ZUtnYCCPaowJ5bRdHT0sOdQqU=;
        b=3NoGumPB7Z/YtG5+gRRsM/RfNcJuOTLJmNj60oBvyW+4cnBEXkdIBlw6ZVqDqSW8AG
         +RYLarkpL3sDeQDWpcNp157dQLIQ02sMnjXBYAz5XAEXYbrKi9N5HwyGmRTvVq34HWam
         YFfttwtfbNYPlASa7OIQJn5ErJR4EnASJ24ETjl7posaAVmjRK37c9CFfqymA95JVSd0
         uKvQt8nuQmiHgMerx2xww+iuZn4pJmDwi6kSb1xxM2tHMy6vVFcD9Wt48PforB3BksBq
         Tp4TtV2kVrRfJHP690Tt4jGLtphFwM9uu7Abwd8kWiuLcG5p3shdTnlROVhtYpSIPFNF
         14KA==
X-Gm-Message-State: AAQBX9d7DgLncbjYQAAw6yxf9ggaLc2xoXPSUuiQIUULErpCKmT3wxJx
        wKwDLpELzqLn/zQyTPbZZzN6rxOX6/4NoDXt99UHmkJFUBVCC9ryTidv3Kb11HNtYUmDu6+M6Jj
        lwMM7zLbSrupoIL47NvOviAZRQ1NR3wEca+vQEw==
X-Received: by 2002:a17:90b:4a50:b0:240:59e8:6dad with SMTP id lb16-20020a17090b4a5000b0024059e86dadmr25379908pjb.25.1680267917838;
        Fri, 31 Mar 2023 06:05:17 -0700 (PDT)
X-Google-Smtp-Source: AKy350Y9PfdWxol+rufcZcwbvwQ1DYEPsLuXLElCIM70TdWdw8rbW3NRn8loQ1UIz8coXa9Ci2UCbA==
X-Received: by 2002:a17:90b:4a50:b0:240:59e8:6dad with SMTP id lb16-20020a17090b4a5000b0024059e86dadmr25379876pjb.25.1680267917496;
        Fri, 31 Mar 2023 06:05:17 -0700 (PDT)
Received: from [10.72.12.135] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id d4-20020a17090ac24400b002407750c3c3sm1409435pjx.37.2023.03.31.06.05.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Mar 2023 06:05:17 -0700 (PDT)
Message-ID: <94f0894d-f72c-daa3-10e2-e83e0e15a759@redhat.com>
Date:   Fri, 31 Mar 2023 09:05:01 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [RFC PATCH v2 37/48] ceph: Use sendmsg(MSG_SPLICE_PAGES) rather
 than sendpage()
To:     David Howells <dhowells@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jeff Layton <jlayton@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Chuck Lever III <chuck.lever@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org
References: <7f7947d6-2a03-688b-dc5e-3887553f0106@redhat.com>
 <20230329141354.516864-1-dhowells@redhat.com>
 <20230329141354.516864-38-dhowells@redhat.com>
 <709552.1680158901@warthog.procyon.org.uk>
Content-Language: en-US
From:   Xiubo Li <xiubli@redhat.com>
In-Reply-To: <709552.1680158901@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/30/23 02:48, David Howells wrote:
> Xiubo Li <xiubli@redhat.com> wrote:
>
>> BTW, will this two patch depend on the others in this patch series ?
> Yes.  You'll need patches that affect TCP at least so that TCP supports
> MSG_SPLICE_PAGES, so 04-08 and perhaps 09.  It's also on top of the patches
> that remove ITER_PIPE on my iov-extract branch, but I don't think that should
> affect you.

Okay, I will check that.

Thanks.


> David
>

