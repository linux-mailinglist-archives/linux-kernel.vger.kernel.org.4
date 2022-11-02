Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1F8615F6B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 10:20:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231473AbiKBJUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 05:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbiKBJUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 05:20:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2486B2A240
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 02:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667380577;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OU3/Jf159y9pxepl1ueY1aykPP8lnzdozH8CN27nur4=;
        b=A+H7hr3lfzaCOvO9A9NgSreUtcXIROG94B9Krszieik0grfBriB5ciGVZHFXXu7f2I0qM4
        t3kekjE9ghPyDiVqsfIb/seJDUGoJ4anOSdNiKNkAD8SlPvi8iVdDH4sjfMjtwA/inFng9
        XCVDkKwD2OhO8pWKT/GQ0tXFFGyJNxY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-631-P5Qi12thOOuuidvxeptR5w-1; Wed, 02 Nov 2022 05:16:16 -0400
X-MC-Unique: P5Qi12thOOuuidvxeptR5w-1
Received: by mail-wr1-f71.google.com with SMTP id r22-20020adfa156000000b0023660e969ddso4591577wrr.19
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 02:16:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OU3/Jf159y9pxepl1ueY1aykPP8lnzdozH8CN27nur4=;
        b=L5A/Y1YECp8Fz4eD2aEGv0EFuG1riUujsTpRN/a2u7/nt2M3of3K/h5NbQMrIzAM9B
         evgPef8uKO53L/5TYdmgUvxw27yt54My76XM2wGfJFfkgEm2Zoo2Ok8Ssjm9DpKu4qzS
         xAiDjJfHhPXL9r52fCd/DWl0suAN2H6H+WRp1t3YZUaMb77zTay/S/lCDiEc7NgVWD+a
         hWBDORtIb1pVhpcCnzGRghyoHCSoIrzLQYZD3wTMwG1XOkA5cZ3Eg0NKFirPoFFu7bgc
         Na4jugDoTIvPHxX1I9LZo5ZT+lIqHwvF1StVR37vYq+Z0CE/HMEont+BtvvQuSqifd98
         jHKA==
X-Gm-Message-State: ACrzQf2jPFVkKIKV5NZfaA8zfpQBzfc96gNDZepNr++nOijEVFDV3tCq
        d3X2qLuKp9wWqMkNoSXIoevRPJDrhcxEHrU4jvswM2WwuyPMzMt7Z0bmRRvBW8719GnzdXOssyu
        ms0V9sc/BjwG767tKL5zB/5ea
X-Received: by 2002:adf:e405:0:b0:236:6e0d:6ed2 with SMTP id g5-20020adfe405000000b002366e0d6ed2mr14662137wrm.338.1667380575178;
        Wed, 02 Nov 2022 02:16:15 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4sIteimN6epkIB/tZvlJsG7zIWZp7bk9NgF29Slu6DC5fw7jJDbqHpP+2ybLO2IHytCabcrw==
X-Received: by 2002:adf:e405:0:b0:236:6e0d:6ed2 with SMTP id g5-20020adfe405000000b002366e0d6ed2mr14662110wrm.338.1667380574833;
        Wed, 02 Nov 2022 02:16:14 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:f100:af38:1d1f:66f4:48c7? (p200300cbc705f100af381d1f66f448c7.dip0.t-ipconnect.de. [2003:cb:c705:f100:af38:1d1f:66f4:48c7])
        by smtp.gmail.com with ESMTPSA id w12-20020a5d404c000000b002365254ea42sm12493299wrp.1.2022.11.02.02.16.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Nov 2022 02:16:14 -0700 (PDT)
Message-ID: <cb273d26-df8e-7c68-c81d-4d9a440aa975@redhat.com>
Date:   Wed, 2 Nov 2022 10:16:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 2/2] mm: Use pte markers for swap errors
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Huang Ying <ying.huang@intel.com>,
        HORIGUCHI NAOYA <naoya.horiguchi@nec.com>,
        Andrea Arcangeli <aarcange@redhat.com>
References: <20221030214151.402274-1-peterx@redhat.com>
 <20221030214151.402274-3-peterx@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20221030214151.402274-3-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.10.22 22:41, Peter Xu wrote:
> PTE markers are ideal mechanism for things like SWP_SWAPIN_ERROR.  Using a
> whole swap entry type for this purpose can be an overkill, especially if we
> already have PTE markers.  Define a new bit for swapin error and replace it
> with pte markers.  Then we can safely drop SWP_SWAPIN_ERROR and give one
> device slot back to swap.
> 
> We used to have SWP_SWAPIN_ERROR taking the page pfn as part of the swap
> entry, but it's never used.  Neither do I see how it can be useful because
> normally the swapin failure should not be caused by a bad page but bad swap
> device.  Drop it alongside.
> 
> Reviewed-by: Huang Ying <ying.huang@intel.com>
> Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---


Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

