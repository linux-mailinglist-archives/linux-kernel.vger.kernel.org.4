Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97B046526BB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 20:03:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233319AbiLTTDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 14:03:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbiLTTDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 14:03:02 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB2EFCD7
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 11:02:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671562931;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eYc8wovIm/Vz9Gb0Hhxo/LT9d5qQ3FV3jFu1a7zreS8=;
        b=AJdQ7MqLV1arIaOnTdvVOsHMdq9g5cMrBwYL67upgt13Su1iIQ3AOBug2v8QQsLlGylo+0
        fhhTXn9gI5etMHHCrVTUCvb34d9Axdn/JQvgz74+uPiq1mxu51bjfXYPWOA29w1gp3zDmr
        tQjeq9fUO5kf+JVKizsMTLu4vyv0xnE=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-37-G3OTQpTBMrGvajOu6tPGaA-1; Tue, 20 Dec 2022 14:02:10 -0500
X-MC-Unique: G3OTQpTBMrGvajOu6tPGaA-1
Received: by mail-ot1-f70.google.com with SMTP id cr28-20020a056830671c00b006774d5923ddso5595651otb.4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 11:02:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eYc8wovIm/Vz9Gb0Hhxo/LT9d5qQ3FV3jFu1a7zreS8=;
        b=NPZVpofe//IdSkhTOW2Xn2mq2DHIxf324RVwTjrPaA6uB1Jq3Qm+N6NUpda0aIrjM8
         86xaLXqZ8msrqJllJ1Q7diUuM8IA6a6A0CBBZK3TOIllglTPIiq42PIGPKGawFu8LaFM
         b7/qVQJLocOwG8akE62dOFPOT3aE5J1UL30LqsKIMBZOurpY2h+o6Jm7tDH8YpaZI8gv
         uK7xV1yPADveS1344cpV5cdsC9yc0wJwPegPxPNL/WTTGsUeciHNXe+VGZKc3Gks1kyN
         Ik+6hIpyCWXJ0mXP+aaz2ZJKPHLAmfB0KIoSsYpLIxsAchlXofcl5Hp2u72o7yVV8pJZ
         0OTA==
X-Gm-Message-State: ANoB5pkGnevUh4sjKk1nm9iE25sFktdDsI8DO1aqWbjA/1R+aKCUO4jS
        i1QI/E+iRQwD1gCOB/9YDXHbWyx54uTqkH7pYwbXlfizQ+li+w5ft4/TjMWiztmHtqAjLYjUxvU
        fFuIsiRgPZYPmNNihlIi239f7
X-Received: by 2002:a9d:6452:0:b0:667:20b:b999 with SMTP id m18-20020a9d6452000000b00667020bb999mr21561177otl.2.1671562929426;
        Tue, 20 Dec 2022 11:02:09 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7c0LscNnTqJtKRJRf5z/nsLAeS+hrOjbcVw3CgrNe5NM2f03MX1SvAr8/P7qhJo8Ayf0ic1w==
X-Received: by 2002:a9d:6452:0:b0:667:20b:b999 with SMTP id m18-20020a9d6452000000b00667020bb999mr21561159otl.2.1671562929117;
        Tue, 20 Dec 2022 11:02:09 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-45-70-31-26-132.dsl.bell.ca. [70.31.26.132])
        by smtp.gmail.com with ESMTPSA id d136-20020ae9ef8e000000b006fef157c8aesm9228574qkg.36.2022.12.20.11.02.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 11:02:08 -0800 (PST)
Date:   Tue, 20 Dec 2022 14:02:07 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paul Gofman <pgofman@codeweavers.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kernel@collabora.com
Subject: Re: [PATCH v4 1/3] mm/mprotect: Fix soft-dirty check in
 can_change_pte_writable()
Message-ID: <Y6IGr2Y21GlLTSRl@x1n>
References: <20220725142048.30450-1-peterx@redhat.com>
 <20220725142048.30450-2-peterx@redhat.com>
 <b75653b8-5264-ca03-bf5c-671e07e7fdd8@collabora.com>
 <Y3gRy8pUiYWFGqcI@x1n>
 <a9984aa6-41bc-17c3-b564-87b997c0f2d0@collabora.com>
 <Y3vq18eTOE0e7I1+@x1n>
 <e3c26b56-5458-eb25-c753-fc4c058ba1b1@collabora.com>
 <Y6Hc2d+7eTKs7AiH@x1n>
 <0a3e3397-6ff3-1203-52cb-49636ef38247@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0a3e3397-6ff3-1203-52cb-49636ef38247@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 20, 2022 at 11:15:00PM +0500, Muhammad Usama Anjum wrote:
> Hi Peter,

Hi, Muhammad,

[...]

> Nothing has changed for the userspace. But when the default soft-dirty
> feature always updates the soft-dirty flag in the PTEs regardless of
> VM_SOFTDIRTY is set or not

But it was not?  I don't see why the pte flags must be considered at all if
VM_SOFTDIRTY is set in existing code base, or before this patch.

> why does other components of the mm stop caring for soft-dirty flag in
> the PTE when VM_SOFTDIRTY is set?
> 
> > 
> > Your approach introduced PAGEMAP_NO_REUSED_REGIONS but that special
> > information is not remembered in vma, IIUC that's why you find things
> > messed up.  Fundamentally, it's because you're trying to reuse soft-dirty
> > design but it's not completely soft-dirty anymore.
> Correct, that's why I'm trying to find a way to correct the soft-dirty
> support instead of using anything else. We should try and correct it. I've
> sent a RFC to track the soft-dirty flags for sub regions in the VMA.

Note that I'm not against the change if that's servicing the purpose of the
enhancement you're proposing.  But again I wouldn't use "correct" as the
word here because I still didn't see anything wrong with the old code.

so IMHO the extra complexity on handling VM_SOFTDIRTY (even if to drop it
and replace with other structures to maintain ranged soft-dirty) needs to
be justified along with the feature introduced, not be justified as a fix.

Thanks,

-- 
Peter Xu

