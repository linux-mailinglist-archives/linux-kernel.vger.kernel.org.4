Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A63A860C4BA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 09:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbiJYHH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 03:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbiJYHHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 03:07:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4708BC6970
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 00:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666681674;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e274vUxvlMRl4b9EVFADkQ7OakHDt5CbdSA7wcE3hgk=;
        b=KAq4Lnflfo127ahBd6D3zfKVPiJFdCGoUIPgsWDaNlfwWVgE7gK7EOkFCy+q+r7DNvLiVR
        TKi50bH01tE51LoDhfxZKvJYhjhPnwh688XRl9Okj6LZgF3tNkEZQXoecBp+mVLBwomiOt
        wx37jvVuVP8utkCE1Wl/TZ38iL6Ykvs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-306-I6L2AGKUPuC1utWUE88Sfw-1; Tue, 25 Oct 2022 03:07:53 -0400
X-MC-Unique: I6L2AGKUPuC1utWUE88Sfw-1
Received: by mail-wr1-f71.google.com with SMTP id w23-20020adf8bd7000000b002358f733307so4270396wra.17
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 00:07:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e274vUxvlMRl4b9EVFADkQ7OakHDt5CbdSA7wcE3hgk=;
        b=GZ+HS90t8ky0X3Rz9iIOv/cKWgG55LmqWz/X+/KQek4cygE4CmhuqZgMA13I8Sa3iV
         6sh+a94MVL+eSMjDkVVYV6zvEfsJRdIDtE8pyqYmJvfih2DEQd/hpReFWAmDd9SiZkzy
         hgXDk0Km+dEF9MLTGVACBgMFuDn+FZxNybQI4K/QH5wt0tt5/Ycnp53lN3PANyWk+L66
         S9NXNwTWGzMVQ6G6GJm6xLjBmqv7CPtQrOgRfxSoGKtApPbdOkZKKEzGc4l5KFjwZ/5O
         FpeGWaTFwd+zWYGYa+y/LLVsXiIUZYVFlkvl05N+Bte/Uo8Bf4arek0WnTp7HfDBcCjU
         iwtQ==
X-Gm-Message-State: ACrzQf0zqZsc6hwFTjh9I8dJoRnVPhCHL0PvrkfShQLQ2+zVPyoGPxly
        ulZqY2e0jQbQdC6JmQYQFuV0KQi+bSIY04t2IPOvso1Ks4WzlvVVKvRsdQZOasJjGY8ZzWYX/Kg
        KzbjvsMCOwyy7pY6nFr+3VvcPN+n1G+0HEwKGcAPjahHuD6/94bfNiYN3eqn4ocifFwocGajp
X-Received: by 2002:a1c:7215:0:b0:3c7:130c:a77f with SMTP id n21-20020a1c7215000000b003c7130ca77fmr17230970wmc.151.1666681672108;
        Tue, 25 Oct 2022 00:07:52 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5wfwAz04p4u+4LaRLlYASuFAO4jGFX1iOyzpJF3Rl6HqJmrYTDgzqRMdCAl5kVrCw2aGPoEg==
X-Received: by 2002:a1c:7215:0:b0:3c7:130c:a77f with SMTP id n21-20020a1c7215000000b003c7130ca77fmr17230933wmc.151.1666681671734;
        Tue, 25 Oct 2022 00:07:51 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70b:4e00:3efc:1c60:bc60:f557? (p200300cbc70b4e003efc1c60bc60f557.dip0.t-ipconnect.de. [2003:cb:c70b:4e00:3efc:1c60:bc60:f557])
        by smtp.gmail.com with ESMTPSA id a15-20020adffacf000000b002366e3f1497sm1702551wrs.6.2022.10.25.00.07.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Oct 2022 00:07:51 -0700 (PDT)
Message-ID: <51302b9e-dc69-d709-3214-f23868028555@redhat.com>
Date:   Tue, 25 Oct 2022 09:07:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v1 1/7] selftests/vm: anon_cow: test COW handling of
 anonymous memory
Content-Language: en-US
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Nadav Amit <namit@vmware.com>, Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@kernel.org>,
        Christoph von Recklinghausen <crecklin@redhat.com>,
        Don Dutile <ddutile@redhat.com>
References: <20220927110120.106906-1-david@redhat.com>
 <20220927110120.106906-2-david@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220927110120.106906-2-david@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.09.22 13:01, David Hildenbrand wrote:
> Let's start adding tests for our COW handling of anonymous memory. We'll
> focus on basic tests that we can achieve without additional libraries or
> gup_test extensions.
> 
> We'll add THP and hugetlb tests separately.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---

The following fixup on top:

diff --git a/tools/testing/selftests/vm/anon_cow.c b/tools/testing/selftests/vm/anon_cow.c
index 9d2b15c829e6..4613294af758 100644
--- a/tools/testing/selftests/vm/anon_cow.c
+++ b/tools/testing/selftests/vm/anon_cow.c
@@ -76,7 +76,7 @@ static int child_vmsplice_memcmp_fn(char *mem, size_t size,
                 .iov_base = mem,
                 .iov_len = size,
         };
-       size_t cur, total, transferred;
+       ssize_t cur, total, transferred;
         char *old, *new;
         int fds[2];
         char buf;
@@ -172,7 +172,7 @@ static void do_test_vmsplice_in_parent(char *mem, size_t size,
                 .iov_base = mem,
                 .iov_len = size,
         };
-       size_t cur, total, transferred;
+       ssize_t cur, total, transferred;
         struct comm_pipes comm_pipes;
         char *old, *new;
         int ret, fds[2];


-- 
Thanks,

David / dhildenb

