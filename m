Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E17E63AF28
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 18:39:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232195AbiK1RjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 12:39:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233140AbiK1Rim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 12:38:42 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80A3863EB
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 09:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669657072;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jT1tAFSnCzDikHJ9CZbuhgF0BEJlLq1HTdxSmwB6uss=;
        b=DjCOTsXSHVVUhI0TBsmnF+5xXd7L1OoG7Jnh0uMlTJURCsBP1c7Rc8J99E/1TNFvLFNKft
        3SQ/DxlHk2I6YhVkhRLXLFxO5b3T1tmSTRK/zj+B5tJkWg/QTSxAkwy731uJseA1rtyfkh
        TCV2AnGjsSoKOVBQE0TOcIvwZV0+aCo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-650-BuPJS_PZOXKkC8SDdWGvrw-1; Mon, 28 Nov 2022 12:37:50 -0500
X-MC-Unique: BuPJS_PZOXKkC8SDdWGvrw-1
Received: by mail-wr1-f71.google.com with SMTP id l8-20020adfc788000000b00241ef50e89eso2204302wrg.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 09:37:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jT1tAFSnCzDikHJ9CZbuhgF0BEJlLq1HTdxSmwB6uss=;
        b=ZVxeG0zsqnU0Oy3868IJ0LtbHVrhrK3620SnMrzQC3ez7vYYGIpG3VdN6abfSUHhpi
         yBavD2oXEUfj/bHDdvHkcefFlQ7NQj3ipW2unmrKi6fg1yJjTK9QQc9mJah3h2+xrTRK
         2kNnIhubrHNO6P9dCNvUIGoZZDwgUfiK6ghjIpZ0mb3BALK/UkfTbCYR95jcNTHtkjA3
         7Rr+/iLCkgyOKSr75u6npFuyklkfrYTDRSb3oFZ33QfkOxtq287S5xwfylP1YQAgO6f1
         xOLkeSkf6O3kO3oEt34d6P9Y9WDuXle6CH+2SnkpA7G608sC2XFf+4yWX0TK952bRu9s
         qC0Q==
X-Gm-Message-State: ANoB5pnikjQJL2rIb/psJag5/6728tobiAQX7kuo6tzAVV+GN8/P/MGG
        bzzvIRYZdmnUQCPtqJzfNRdT+zco1Swdbv5fEPeNCOhv4ONV5v2rWKhZdM+0BEhkuNkW8pdZuxN
        zK7UACd9kOXl4WNvmLYBCrkRB
X-Received: by 2002:adf:dfc6:0:b0:236:cfcf:8e36 with SMTP id q6-20020adfdfc6000000b00236cfcf8e36mr13266267wrn.323.1669657069635;
        Mon, 28 Nov 2022 09:37:49 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4NRDE4KSKVbvKhfw0HqtwrYf6Q16tqvRFjZ+vgiV5khr056Aket6ozHmJR0JGcmfHZkX8vwA==
X-Received: by 2002:adf:dfc6:0:b0:236:cfcf:8e36 with SMTP id q6-20020adfdfc6000000b00236cfcf8e36mr13266246wrn.323.1669657069343;
        Mon, 28 Nov 2022 09:37:49 -0800 (PST)
Received: from ?IPV6:2003:cb:c702:9000:3d6:e434:f8b4:80cf? (p200300cbc702900003d6e434f8b480cf.dip0.t-ipconnect.de. [2003:cb:c702:9000:3d6:e434:f8b4:80cf])
        by smtp.gmail.com with ESMTPSA id j15-20020a5d452f000000b002416e383e1csm11584060wra.25.2022.11.28.09.37.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Nov 2022 09:37:48 -0800 (PST)
Message-ID: <66cfc9ba-868c-9620-fbfc-38931c76ff50@redhat.com>
Date:   Mon, 28 Nov 2022 18:37:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v3 3/3] mm/khugepaged: Invoke MMU notifiers in shmem/file
 collapse paths
Content-Language: en-US
To:     Jann Horn <jannh@google.com>, security@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Yang Shi <shy828301@gmail.com>, Peter Xu <peterx@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20221125213714.4115729-1-jannh@google.com>
 <20221125213714.4115729-3-jannh@google.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20221125213714.4115729-3-jannh@google.com>
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

On 25.11.22 22:37, Jann Horn wrote:
> Any codepath that zaps page table entries must invoke MMU notifiers to
> ensure that secondary MMUs (like KVM) don't keep accessing pages which
> aren't mapped anymore. Secondary MMUs don't hold their own references to
> pages that are mirrored over, so failing to notify them can lead to page
> use-after-free.
> 
> I'm marking this as addressing an issue introduced in commit f3f0e1d2150b
> ("khugepaged: add support of collapse for tmpfs/shmem pages"), but most of
> the security impact of this only came in commit 27e1f8273113 ("khugepaged:
> enable collapse pmd for pte-mapped THP"), which actually omitted flushes
> for the removal of present PTEs, not just for the removal of empty page
> tables.
> 
> Cc: stable@kernel.org
> Fixes: f3f0e1d2150b ("khugepaged: add support of collapse for tmpfs/shmem pages")

I'm curious, do you have a working reproducer for this?

Change looks sane on quick glimpse.

-- 
Thanks,

David / dhildenb

