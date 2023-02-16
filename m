Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19771699034
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 10:40:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbjBPJkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 04:40:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbjBPJkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 04:40:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF9C4DBFD
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 01:38:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676540260;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hPsU+xV8FXNcK3d+BKVHYP4xeqYYwzPxPUwaDz0NgCs=;
        b=XGdYAKe6XIuvCYGsKULdzzmxlEsFQYIrsXKg6BtJ9SF/cXGqjWYlYKhuKeBKNXWyetpiCU
        USNYLF5QAYYmY4wBlo7MJM+LuPV/61hscf99VZP5mtsoxJNqdvPJWhqRoOLZwyx76v6Cwi
        KXJz5XDokqDVYRtfKWeBfHOPyEVvfkM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-306-YcuN96gvMeu6T5_zxBnCCQ-1; Thu, 16 Feb 2023 04:37:39 -0500
X-MC-Unique: YcuN96gvMeu6T5_zxBnCCQ-1
Received: by mail-wm1-f71.google.com with SMTP id s11-20020a05600c384b00b003dffc7343c3so616855wmr.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 01:37:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hPsU+xV8FXNcK3d+BKVHYP4xeqYYwzPxPUwaDz0NgCs=;
        b=uhWgrPBlkPaqB2Lcx7p3m2w6oqdTUswPP6ewl+tfBXpFI7hyvBpGGI/Ef8nr/vAiax
         gwV/+fHiqbQcUnjvTUCPhBFLBhl1qhToE+4Jzjpn+0au3OD7dOz1GIBMXLjsjRwWQRzg
         3YWqRhWD54cqr+RdrA9R7B6q4rQX/myRO7+tJgpbZ+Dp1C01PgAEoirV1nAsVOCUtX0F
         zP95EmJcLu4Ta2RADz3i71PdbKKQ4Je5sEab0JfLpg0p0GAmQuAz4zI8oFMGhUBbr2jl
         do+UAGWXioAYRhVXRo1UYDzk+S5ZkdZ/pQoGg/t+dhGprRIntsFhF1TxE95HWHTrAWo/
         cgzw==
X-Gm-Message-State: AO0yUKU5phzrA4750bWcpz6OLPPqKgX3+stE4wLQd7fGzzjvex88Xdxs
        hK69jMfsLa2hmbwZrzIzxAxkLdo7dokAbx1jW4xoiUTO/avaG5wom3wlGWrJu56xKQNRC/+6Bx7
        mk+5tsgu8zGPlC5bpq3TkS9pA3BWVKA==
X-Received: by 2002:a05:600c:4487:b0:3e2:4ea:1582 with SMTP id e7-20020a05600c448700b003e204ea1582mr3503325wmo.26.1676540257907;
        Thu, 16 Feb 2023 01:37:37 -0800 (PST)
X-Google-Smtp-Source: AK7set/0tuipBQ65gwzK7UHSXOQtBfNmixIurNVZhKsp7usYYokiRGNjqp2NgMvRYwck8+yakjZ9UA==
X-Received: by 2002:a05:600c:4487:b0:3e2:4ea:1582 with SMTP id e7-20020a05600c448700b003e204ea1582mr3503306wmo.26.1676540257535;
        Thu, 16 Feb 2023 01:37:37 -0800 (PST)
Received: from ?IPV6:2003:cb:c708:bc00:2acb:9e46:1412:686a? (p200300cbc708bc002acb9e461412686a.dip0.t-ipconnect.de. [2003:cb:c708:bc00:2acb:9e46:1412:686a])
        by smtp.gmail.com with ESMTPSA id j1-20020a05600c410100b003dec22de1b1sm1096006wmi.10.2023.02.16.01.37.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Feb 2023 01:37:37 -0800 (PST)
Message-ID: <f4b6cd03-28d7-b041-6dd4-46ac0812fc9b@redhat.com>
Date:   Thu, 16 Feb 2023 10:37:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: en-US
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        peterx@redhat.com, Andrew Morton <akpm@linux-foundation.org>
Cc:     kernel@collabora.com, Paul Gofman <pgofman@codeweavers.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230216091656.2045471-1-usama.anjum@collabora.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v4 1/2] mm/userfaultfd: Support WP on multiple VMAs
In-Reply-To: <20230216091656.2045471-1-usama.anjum@collabora.com>
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

On 16.02.23 10:16, Muhammad Usama Anjum wrote:
> mwriteprotect_range() errors out if [start, end) doesn't fall in one
> VMA. We are facing a use case where multiple VMAs are present in one
> range of interest. For example, the following pseudocode reproduces the
> error which we are trying to fix:
> - Allocate memory of size 16 pages with PROT_NONE with mmap
> - Register userfaultfd
> - Change protection of the first half (1 to 8 pages) of memory to
>    PROT_READ | PROT_WRITE. This breaks the memory area in two VMAs.
> - Now UFFDIO_WRITEPROTECT_MODE_WP on the whole memory of 16 pages errors
>    out.

I think, in QEMU, with partial madvise()/mmap(MAP_FIXED) while handling 
memory remapping during reboot to discard pages with memory errors, it 
would be possible that we get multiple VMAs and could not enable uffd-wp 
for background snapshots anymore. So this change makes sense to me.

Especially, because userfaultfd_register() seems to already properly 
handle multi-VMA ranges correctly. It traverses the VMA list twice ... 
but also holds the mmap lock in write mode.

> 
> This is a simple use case where user may or may not know if the memory
> area has been divided into multiple VMAs.
> 
> We need an implementation which doesn't disrupt the already present
> users. So keeping things simple, stop going over all the VMAs if any one
> of the VMA hasn't been registered in WP mode. While at it, remove the
> un-needed error check as well.
> 
> Reported-by: Paul Gofman <pgofman@codeweavers.com>
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---


Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

