Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6FF65E706
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 09:48:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231681AbjAEIr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 03:47:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231453AbjAEIr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 03:47:57 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99731F5BF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 00:47:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672908434;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d0pb/l6wUPA9Lvyg5DU403nY3WheN9H/3GxRQ8TDJaY=;
        b=g0P9DxV2uI64VOuAx85a1r5KO+SIHe85bXVjCYLeNieyyLryQhL0373LaF+6Np7o7oHPYE
        grTFfrKnVoDvA4TG6U6ZZuMX6BMemOldhGOp4vrUa+rPmKwpW3LHWalMU8Q6AS5csKSQ+M
        RC9vOx+NVqlyxMqcWrp01bDNdpmYG2o=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-618-E2i_5R0pP9GbvBFuSiAOPw-1; Thu, 05 Jan 2023 03:47:13 -0500
X-MC-Unique: E2i_5R0pP9GbvBFuSiAOPw-1
Received: by mail-wm1-f71.google.com with SMTP id ay32-20020a05600c1e2000b003d9730391b5so16880346wmb.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 00:47:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d0pb/l6wUPA9Lvyg5DU403nY3WheN9H/3GxRQ8TDJaY=;
        b=NEAaaMe0iEztCC7l3OTO/AYpM45gfSPKOwav0Dz77ZUzqSRd7wqlu0SeubruKMFeU6
         6whMjHjTtTOgyP4LGHXRjdRVnQa+fnqi1n2UEY0g9iiVUi0Sby3MRTF1x2PiFqbnXvpb
         uNYHQ3grYl7UiY6BmsRgqhjBcn97fDwy+HS6hygGWRZfSV1UsnaHMu/6L8V7H5bW53XR
         3e4i1xtk1fLE2JUlbNtxqjZlb7L2BCbZAcdCfEG5FEXLrJaedBKBl6Q4xT3cIROMt7h6
         f4hEiSp+f1fYV5rfWXjSAnIb0TSkxDJLSdYEgXp5zqUSlSU/K5rVbVPbajsD7ltpnOfT
         u9Hg==
X-Gm-Message-State: AFqh2krD5Xc3eW7X0DWaJaPb00JHFBhRG5MMbj+WUEyVIV81tWLewMXx
        kFrJeMJbdAYmkwiU4Ny+frSVUJz6h8BSdLiq0tLmhROJs+6MWJj4YYYOBI32CJNvD05LmU/yVMV
        T5Uo2Rfk35R6j8/MBLsPfdYoo
X-Received: by 2002:a05:600c:539b:b0:3d9:6bc3:b8b9 with SMTP id hg27-20020a05600c539b00b003d96bc3b8b9mr31503981wmb.9.1672908432572;
        Thu, 05 Jan 2023 00:47:12 -0800 (PST)
X-Google-Smtp-Source: AMrXdXthx1efCMNbfXqehraE4FVXPSTjwE6XiVS6xL1ltm0cDZ04pu55NbShNr6/9laE8O0Ei8E4Pw==
X-Received: by 2002:a05:600c:539b:b0:3d9:6bc3:b8b9 with SMTP id hg27-20020a05600c539b00b003d96bc3b8b9mr31503965wmb.9.1672908432331;
        Thu, 05 Jan 2023 00:47:12 -0800 (PST)
Received: from ?IPV6:2003:cb:c707:6e00:ff02:ec7a:ded5:ec1e? (p200300cbc7076e00ff02ec7aded5ec1e.dip0.t-ipconnect.de. [2003:cb:c707:6e00:ff02:ec7a:ded5:ec1e])
        by smtp.gmail.com with ESMTPSA id u18-20020a05600c4d1200b003c21ba7d7d6sm1493548wmp.44.2023.01.05.00.47.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jan 2023 00:47:11 -0800 (PST)
Message-ID: <1f934203-5220-01f6-42d1-65cc984a0201@redhat.com>
Date:   Thu, 5 Jan 2023 09:47:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 3/3] mm/uffd: Detect pgtable allocation failures
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        James Houghton <jthoughton@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20230104225207.1066932-1-peterx@redhat.com>
 <20230104225207.1066932-4-peterx@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230104225207.1066932-4-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.01.23 23:52, Peter Xu wrote:
> Before this patch, when there's any pgtable allocation issues happened
> during change_protection(), the error will be ignored from the syscall.
> For shmem, there will be an error dumped into the host dmesg.  Two issues
> with that:
> 
>    (1) Doing a trace dump when allocation fails is not anything close to
>        grace..

s/..//

> 
>    (2) The user should be notified with any kind of such error, so the user
>        can trap it and decide what to do next, either by retrying, or stop
>        the process properly, or anything else.
> 
> For userfault users, this will change the API of UFFDIO_WRITEPROTECT when
> pgtable allocation failure happened.  It should not normally break anyone,
> though.  If it breaks, then in good ways.
> 
> One man-page update will be on the way to introduce the new -ENOMEM for
> UFFDIO_WRITEPROTECT.  Not marking stable so we keep the old behavior on the
> 5.19-till-now kernels.

We'd now fail after already having modified some state (protected some 
PTEs). I assume that can already happen when protecting across multiple 
VMAs and is expected, right?

-- 
Thanks,

David / dhildenb

