Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 691C66C169C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 16:07:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232265AbjCTPHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 11:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232222AbjCTPHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 11:07:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F383EC7E
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 08:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679324506;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RRLo27GlsnaXOlM604FxZs8z99IITo0Vh+vZehLWrQY=;
        b=dTPIJZAJvAgsrDkugdn/Gb5GqNuFtgJLZLbVczL0NPeN1IEQ7DZaWduxUfWYXRWG0ssrGI
        u/GfTvEIpxedF6OprSClQ8o5M3YDr5pb+LgQ92jFg3sEFjWsv7B1PpPfVjJm4mY+avmuyh
        E7JnhPgCHcjaTE2W8gdpQ5KYquAMEzM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-558sAMGXPMqpTyBMA-vAXw-1; Mon, 20 Mar 2023 11:01:43 -0400
X-MC-Unique: 558sAMGXPMqpTyBMA-vAXw-1
Received: by mail-wr1-f72.google.com with SMTP id u27-20020adfa19b000000b002d3b9266941so918838wru.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 08:01:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679324501;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RRLo27GlsnaXOlM604FxZs8z99IITo0Vh+vZehLWrQY=;
        b=TUWvmNaCN9Pg9h26WMiApghD8b2dGj+ZSEjgiNTJzjIkblLIsoZuqEjTcIh6XuVju/
         crdEM79m4dDvcRZrNzZDY9DTRZ/Tki58I0vGYnmN7/ZK6nwmM9zV8qc4OXY7oI5QcwAy
         a1xgSAn37EKoGK/KzP9Ec2xAuhBzyAjOII4nYYlT6y5FwEnEc4sztAcOoFEFQgOaysC8
         TaoMqKzDgGTNpeKwpi0ApH4cypkjJsbGfiv7rHOKI50/vWo10T5vYACwa426JBja81hM
         vxh7xzd6ieeqeLCWt+vt7q2kt0JgkgoysH2yM6HOfYq8/4j/qoZ8vuOC1mJw34gkwYlf
         +JYQ==
X-Gm-Message-State: AO0yUKV4pZj7zMEGSEXnyXAos4mFwONMKroHkt0WwJpo644LtTugyljK
        /6BP3VinNTg+QLMmwNREJMQyyWsuQFOrZG8z2wU7Xwk/H5Yn8pJkX2dL8xVpr/jDYMZ+F6ZW7N5
        jURuOkGgvI4uPES1q9j2Lw71u
X-Received: by 2002:a05:600c:a4c:b0:3dc:d5c:76d9 with SMTP id c12-20020a05600c0a4c00b003dc0d5c76d9mr35551091wmq.0.1679324501086;
        Mon, 20 Mar 2023 08:01:41 -0700 (PDT)
X-Google-Smtp-Source: AK7set+Rv9ADJ0RLrT3u7b/PN3mJMTqyoZ1JFg/0Z64iMZgTe0nU39Ivpjcl6439Qs4YPquJhUtMqw==
X-Received: by 2002:a05:600c:a4c:b0:3dc:d5c:76d9 with SMTP id c12-20020a05600c0a4c00b003dc0d5c76d9mr35551066wmq.0.1679324500767;
        Mon, 20 Mar 2023 08:01:40 -0700 (PDT)
Received: from ?IPV6:2003:cb:c702:4100:a064:1ded:25ec:cf2f? (p200300cbc7024100a0641ded25eccf2f.dip0.t-ipconnect.de. [2003:cb:c702:4100:a064:1ded:25ec:cf2f])
        by smtp.gmail.com with ESMTPSA id f1-20020a1c6a01000000b003edcc2223c6sm5981913wmc.28.2023.03.20.08.01.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 08:01:40 -0700 (PDT)
Message-ID: <460b50d3-579c-5dfa-7c1b-531cc9b1c2d5@redhat.com>
Date:   Mon, 20 Mar 2023 16:01:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v4 2/2] selftests/mm: Smoke test
 UFFD_FEATURE_WP_UNPOPULATED
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Nadav Amit <nadav.amit@gmail.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20230309223711.823547-1-peterx@redhat.com>
 <20230309223711.823547-3-peterx@redhat.com>
 <4ab36009-51c0-6583-4948-b267f8fbf32a@redhat.com> <ZBhxLOBocC7mCYDG@x1n>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <ZBhxLOBocC7mCYDG@x1n>
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

On 20.03.23 15:43, Peter Xu wrote:
> On Mon, Mar 20, 2023 at 11:25:43AM +0100, David Hildenbrand wrote:
>> On 09.03.23 23:37, Peter Xu wrote:
>>> Enable it by default on the stress test, and add some smoke tests for the
>>> pte markers on anonymous.
>>
>> Would it make sense to make kernel support optional and test both paths --
>> once with the feature enabled (if available on the kernel we're testing) and
>> once with the feature disabled?
> 
> Yeah, I think the current uffd selftest is not friendly to old kernels so I
> made it simple - IOW the test should fail already on old kernels AFAIK.
> Maybe I can prepare some patches this week or next to cleanup some parts of
> it.

Some people to tend to run upstream selftests on older kernels, but I 
guess this is not high priority. Can always be added on top.

-- 
Thanks,

David / dhildenb

