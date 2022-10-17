Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A17016008FC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 10:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbiJQIo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 04:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiJQIoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 04:44:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C7E72BB26
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 01:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665996252;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A0G/s7FFc6fRx4eiRxxpQWaSRa2q0znsD4DR8qga7U0=;
        b=jUjGxM2ae/bzeUJQ5AGCHUPbIyxORIFMXzuLEXVsNzCYeOTcyYtNsrCauziswp5560oLUY
        aVTPQTJL8hVEDnvnNl9IIvYpMFuf8eXQ1zUGvjmVc9PEQRZCxn9j+jnPxa/aMa7o4ngJ6y
        tfNvYJi7SxuKD/vAU1pfuIfw07jPvLQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-99-aS48CcZ1NVeQAbXW71In6Q-1; Mon, 17 Oct 2022 04:44:10 -0400
X-MC-Unique: aS48CcZ1NVeQAbXW71In6Q-1
Received: by mail-wm1-f72.google.com with SMTP id l1-20020a7bc341000000b003bfe1273d6cso5241823wmj.4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 01:44:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A0G/s7FFc6fRx4eiRxxpQWaSRa2q0znsD4DR8qga7U0=;
        b=7puVGRvmREh3ZeCdnGdXcM5yGflE/E0kGbR79OWoW5P3w3uhiV9kyyvsbnWNpLn361
         MsuXZt6OJvM15PE9m3fj++XXcigfBWIG5RpRqDzMENjwOo2c2A2EXGtup6umofkIyXVC
         Ert9ueqdpqSiTZfVu6vsUiyNOEqaI1jDrUAVsRfCL1uYR5xCI6ycwmeQZlvmtychV8z9
         StWZupple168iawyfv0ZoArjXmTMg397gJYmPgFg3BrelwBlgENti7eHOkl90OXvEljD
         Ll2a8C23cJZkAGBYbKzCKMJjc29mOW9HhNxa4EdFPq5PBns3tETPGwUsOLJczDA5SKrH
         1Y6A==
X-Gm-Message-State: ACrzQf1Ha+hfpDKkOPOyh4z99JUAfKO/aysDm0RDh+H3Qw2/vY/Gmw6L
        eIBnkFtvjUe9nP8qArGJNpJdr10vWSsaWlQxgzqPOJyyE3inKpFc062Q9MMHz6VUyCfvtsWqui0
        kQO3E4aPIaf2bbgYsZvz7v6kY
X-Received: by 2002:a5d:4a4e:0:b0:22e:64a6:7a52 with SMTP id v14-20020a5d4a4e000000b0022e64a67a52mr5472547wrs.333.1665996249427;
        Mon, 17 Oct 2022 01:44:09 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM61xdkOYp/u8H5U4i9P8jb5eYC8/ZeaBJJSV+HbkCVx665ScinUC4TK7sZT/C3i79ODpATzSA==
X-Received: by 2002:a5d:4a4e:0:b0:22e:64a6:7a52 with SMTP id v14-20020a5d4a4e000000b0022e64a67a52mr5472528wrs.333.1665996249163;
        Mon, 17 Oct 2022 01:44:09 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:2300:e5ce:21ba:1d93:4323? (p200300cbc7072300e5ce21ba1d934323.dip0.t-ipconnect.de. [2003:cb:c707:2300:e5ce:21ba:1d93:4323])
        by smtp.gmail.com with ESMTPSA id z10-20020a05600c0a0a00b003a2f2bb72d5sm20496939wmp.45.2022.10.17.01.44.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Oct 2022 01:44:08 -0700 (PDT)
Message-ID: <2aaf2c3a-6e49-abb9-b9c8-19ce87404982@redhat.com>
Date:   Mon, 17 Oct 2022 10:44:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] mm: hugetlb: support get/set_policy for hugetlb_vm_ops
Content-Language: en-US
To:     Albert Huang <huangjie.albert@bytedance.com>,
        songmuchun@bytedance.com
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20221012081526.73067-1-huangjie.albert@bytedance.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20221012081526.73067-1-huangjie.albert@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.10.22 10:15, Albert Huang wrote:
> From: "huangjie.albert" <huangjie.albert@bytedance.com>
> 
> implement these two functions so that we can set the mempolicy to
> the inode of the hugetlb file. This ensures that the mempolicy of
> all processes sharing this huge page file is consistent.
> 
> In some scenarios where huge pages are shared:
> if we need to limit the memory usage of vm within node0, so I set qemu's
> mempilciy bind to node0, but if there is a process (such as virtiofsd)
> shared memory with the vm, in this case. If the page fault is triggered
> by virtiofsd, the allocated memory may go to node1 which  depends on
> virtiofsd.
> 

Any VM that uses hugetlb should be preallocating memory. For example, 
this is the expected default under QEMU when using huge pages.

Once preallocation does the right thing regarding NUMA policy, there is 
no need to worry about it in other sub-processes.

-- 
Thanks,

David / dhildenb

