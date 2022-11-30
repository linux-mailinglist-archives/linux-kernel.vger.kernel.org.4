Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8731D63DA48
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 17:13:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbiK3QNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 11:13:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiK3QM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 11:12:56 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD5C2E9C5
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 08:11:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669824714;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+Vx3tqI0z8MBhtV+78AGz3/U6011aQy9sb2OvHcLUUU=;
        b=g4SCipabH4t36hip3HIx74z2802Zph1jvOxBrQDqpCcgBg+ZJ4pS6SFP4w5hvgIlWuIhjf
        9drz6sZXKEYkpChw1eNZUU+5qoCTLBw4uexR173NTfuwOUbjdhpYNzDEu39mrt1PVIIjZP
        rwn1vflfEFA31whBOqmO6DuN3iQW/3w=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-121-2XXXOJsrNyqzFiKY5uJRtQ-1; Wed, 30 Nov 2022 11:11:53 -0500
X-MC-Unique: 2XXXOJsrNyqzFiKY5uJRtQ-1
Received: by mail-wr1-f69.google.com with SMTP id w11-20020adfbacb000000b002418a90da01so3711499wrg.16
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 08:11:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Vx3tqI0z8MBhtV+78AGz3/U6011aQy9sb2OvHcLUUU=;
        b=bVw3am/1W5skAp6pFoxOtOZtcifSb/AuLDRQKOjj/TBCHi6Os6xL72zEG1sAImyQHD
         SQFEe2XZpULw/dccZNdLlkMc6jAwbWCmwX45zwP6tMIRDly3ifceL1hLCspm+qVQo0xG
         Etr/UVMCsO2QTS9TjSsu0mpHGa2WMIerIv0Pnv52UG5AXWT98Vp5tjpnKmPdyPdt5y9f
         DEq7P9aplxPN1IP3bKPkoDHVDL/DcQIE+vPa25jjTEvkGYzANjmVtFI7JtaP0R3YsTtU
         BHKulxyNUOQEgZgBzGcqRmi9qwFS4Ae3ZY2ugZXFRWaiMg2oGyHr4YyrzvmdEh5SLU8A
         KHPQ==
X-Gm-Message-State: ANoB5pkIboK8ciIYyGLU5jou3yrqi051/C2bpGuMfoCC9AwIjA61Zloq
        A5emoufNLo/w+nFU1UpRCqdDjs8UESs8jicdG+PPrHDytExncw1ZwENI7UuTHFWyLKa9rygj+gB
        rkrxCMFTRencjEqxkQH2PKgSM
X-Received: by 2002:a5d:6347:0:b0:242:3343:c493 with SMTP id b7-20020a5d6347000000b002423343c493mr166929wrw.547.1669824712242;
        Wed, 30 Nov 2022 08:11:52 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7oggx+Ui4jdQZwKIfu/UGPFHzm3yZq3CUiGArNk9pBCItuYGJn7FEMtWThXOE4shyOjg5Yhw==
X-Received: by 2002:a5d:6347:0:b0:242:3343:c493 with SMTP id b7-20020a5d6347000000b002423343c493mr166916wrw.547.1669824712005;
        Wed, 30 Nov 2022 08:11:52 -0800 (PST)
Received: from ?IPV6:2003:cb:c703:7600:a8ea:29ce:7ee3:dd41? (p200300cbc7037600a8ea29ce7ee3dd41.dip0.t-ipconnect.de. [2003:cb:c703:7600:a8ea:29ce:7ee3:dd41])
        by smtp.gmail.com with ESMTPSA id n14-20020a05600c4f8e00b003c6f3f6675bsm6803196wmq.26.2022.11.30.08.11.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Nov 2022 08:11:51 -0800 (PST)
Message-ID: <06f701fd-4e7a-cb8e-25bb-a39e22f5307d@redhat.com>
Date:   Wed, 30 Nov 2022 17:11:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 08/10] mm/hugetlb: Make walk_hugetlb_range() safe to pmd
 unshare
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     James Houghton <jthoughton@google.com>,
        Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
References: <20221129193526.3588187-1-peterx@redhat.com>
 <20221129193526.3588187-9-peterx@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20221129193526.3588187-9-peterx@redhat.com>
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

On 29.11.22 20:35, Peter Xu wrote:
> Since walk_hugetlb_range() walks the pgtable, it needs the vma lock
> to make sure the pgtable page will not be freed concurrently.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

