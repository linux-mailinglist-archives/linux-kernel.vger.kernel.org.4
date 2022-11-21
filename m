Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97AD5632759
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 16:08:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232031AbiKUPIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 10:08:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232020AbiKUPIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 10:08:34 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A659CC8465
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 06:57:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669042630;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YKhtto51BkO/qqsyDgdGypNLsOVsCRpQ1auwp3TLJ1I=;
        b=MOleCP0v2BjFqaIxiEDywm6QRlMIWf3eXzCV6mxrhPk/aC/m+xga0BMrTvuFp4Qu2LdFqX
        MjfiWPW+4roXfpLLuY9m8758zWeKalTt6/oYUuRJoheB0KR7BEc9sOkyxv6+U8TXMrdGFm
        4NA4Q+AsIvqu4tIHM/hNVtx0Nifzalg=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-435-s8d5F0z8O3Squyq_bugRxw-1; Mon, 21 Nov 2022 09:57:09 -0500
X-MC-Unique: s8d5F0z8O3Squyq_bugRxw-1
Received: by mail-qk1-f198.google.com with SMTP id i17-20020a05620a249100b006fa2e10a2ecso15892140qkn.16
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 06:57:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YKhtto51BkO/qqsyDgdGypNLsOVsCRpQ1auwp3TLJ1I=;
        b=HqN+971LZmiXJtpTn2iayy7wre/mHpHcwkc3sWOWokIknLnIpbca2Y6yIhfCDIRXc4
         qIXaWJxs/xUgegDMdPu9JY/7T0sohbttbFGdTItRFzc/YQ5NA5/B0le6jL8XfJYVXI9X
         OVhYOBgOryY6O25EcMMUDskBL7QGz1D6MH1LOD0mB2x3OxgkwmCVrW3e6TrcyJu0BSK6
         LT542iq85LxOHqrb2FkFdg41o+kXglxBDiKZN5QxM1CWtgkxRnW21lrzlFQiOHKzHdep
         eMQtiFl6MnK46JN02A+wQvQZdFJzVnz0RjtRL7HkMIFB+exyUUeJsbd/WK3nLKfw65Bu
         iMsA==
X-Gm-Message-State: ANoB5pmQUWJJYnNB5TNSbXWm4DUTL2MSZejMi1PhzUlEGlijkOZPAHsV
        riTrFJNXncMvcrCU4ve/MQcVDTvbYeWq8YhT3P6bzvtyW9frBnU3xuyXiDPxi9EYARDgqiHsPYc
        K7P8BCxjCG38vGRiGIX9Fz2WX
X-Received: by 2002:a05:620a:8c9:b0:6ec:6d36:74f7 with SMTP id z9-20020a05620a08c900b006ec6d3674f7mr2323625qkz.718.1669042628462;
        Mon, 21 Nov 2022 06:57:08 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6ObOJL+UEY7TEBcrrgffzRGgOse6/llgNXLuMrf9tRXu7qJt16HUSKgBMtuO6xSU7iHdjjqA==
X-Received: by 2002:a05:620a:8c9:b0:6ec:6d36:74f7 with SMTP id z9-20020a05620a08c900b006ec6d3674f7mr2323594qkz.718.1669042628197;
        Mon, 21 Nov 2022 06:57:08 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id j6-20020a05620a410600b006fa2dde9db8sm8402000qko.95.2022.11.21.06.57.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 06:57:07 -0800 (PST)
Date:   Mon, 21 Nov 2022 09:57:06 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Raghavendra K T <raghavendra.kt@amd.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Hugh Dickins <hughd@google.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Alistair Popple <apopple@nvidia.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Andi Kleen <andi.kleen@intel.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Huang Ying <ying.huang@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v4 0/7] mm: Remember a/d bits for migration entries
Message-ID: <Y3uRYhJn82+VbX2y@x1n>
References: <20220811161331.37055-1-peterx@redhat.com>
 <dfc6bdde-7e5d-44e8-8549-7d61a0f18bb5@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dfc6bdde-7e5d-44e8-8549-7d61a0f18bb5@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Raghavendra,

On Mon, Nov 21, 2022 at 10:45:45AM +0530, Raghavendra K T wrote:
> I was able to test on AMD EPYC 64 core 2 numa node (Milan) 3.72 GHz clocked
> system
> 
> am seeing the similar improvement for the test mentioned above (swap-young)
> 
> base: (6.0)
> --------------
> Write (node 0) took 562202 (us)
> Read (node 0) took 7790 (us)
> Move to node 1 took 474876(us)
> Move to node 0 took 642805(us)
> Read (node 0) took 81364 (us)
> Write (node 0) took 12887 (us)
> Read (node 0) took 5202 (us)
> Write (node 0) took 4533 (us)
> Read (node 0) took 5229 (us)
> Write (node 0) took 4558 (us)
> Read (node 0) took 5198 (us)
> Write (node 0) took 4551 (us)
> Read (node 0) took 5218 (us)
> Write (node 0) took 4534 (us)
> 
> patched
> -------------
> Write (node 0) took 250232 (us)
> Read (node 0) took 3262 (us)
> Move to node 1 took 640636(us)
> Move to node 0 took 449051(us)
> Read (node 0) took 2966 (us)
> Write (node 0) took 2720 (us)
> Read (node 0) took 2891 (us)
> Write (node 0) took 2560 (us)
> Read (node 0) took 2899 (us)
> Write (node 0) took 2568 (us)
> Read (node 0) took 2890 (us)
> Write (node 0) took 2568 (us)
> Read (node 0) took 2897 (us)
> Write (node 0) took 2563 (us)
> 
> Please feel free to add FWIW
> Tested-by: Raghavendra K T <raghavendra.kt@amd.com>

The series has already landed v6.1-rc1 so it should be a bit late to apply
the tested-by tag, but still thanks a lot for your tests and upate!

It seems the mem size is different for the two rounds of test as even the
initial write differs in time, but I think that still explains the
difference because what matters is the first read/write after migration,
and that can be compared with the 2nd/3rd/... reads/writes afterwards.

Side note: there's actually one tiny thing got removed from the series on
handling dirty bit of thp split (434e3d15d92b), but it seems there's hope
we cound have found the root issue of the issues on sparc64 and loongarch
so we may have chance to re-apply them.

-- 
Peter Xu

