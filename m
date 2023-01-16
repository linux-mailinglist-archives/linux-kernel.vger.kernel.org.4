Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 329B866B66A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 04:47:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231855AbjAPDrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 22:47:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231898AbjAPDrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 22:47:15 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 589B186B2
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 19:46:11 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id u1-20020a17090a450100b0022936a63a21so6150077pjg.4
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 19:46:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OLF9LDPywIH2CQhdt+WdpQ3H/KRGlA2mgi78cfBC+2E=;
        b=HIY+W0evMjl0ltmm5N+7Vono5/NQqKq7yvJyTJbsTWd5JFumfJ3iTzCbopTvUzOaMG
         BGCHA6zrjQI0g9FVvr/6n1SuRQDcmSdZJNTF0yyGAooatXY0GZxNVtV9BcoJNjr7FLE2
         W60TLtiOgP597YCj+liVCzKM4YQjsfG4RZmtU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OLF9LDPywIH2CQhdt+WdpQ3H/KRGlA2mgi78cfBC+2E=;
        b=G6OiE5utLRlVYyYV3LLbVqfabFdMHWAYNwbfalaZXWFQrlPtZc1vtu64ti53mcUUS/
         4vVsde80i9q6g1ZGT02Ads07ykNm7AYfESEqSDd8PlGVbzkDTfiNTpsLXoR7t3bBvl1n
         3iR202GqXe4tlGeN59NJLop+151xUs3xTAcWOq3Rsya5NVOXkABSMbRHMJzoT04AJ4s/
         Cac2JFsCcCznQgHqhCQOhvo9xbdIA2RD7aOy6KtEBEEnyBgAhn20bO79jmVQh+rp3pQK
         S67nC/4y+iOYisPAACdcu7JWCJmbxCMbqNyE5ec9Ur5dMeHcprYtevLm0NRMpz5UWgRI
         f8mA==
X-Gm-Message-State: AFqh2koLdrnu9LhrV+2d7V3BEg5LO6p6w89mfVYxyAlb7vbjgMhghVpI
        BdqLEaAhsn8zklgru72YsMjn76duEst7JCgU
X-Google-Smtp-Source: AMrXdXvPkrh8ktMjPshkyW5xQ8T/PSWD3MiZFo2ya2FGF5Egfo+VrQOMD8D9a5c8W2gkNg7ZCaLmMw==
X-Received: by 2002:a17:903:1d0:b0:192:4f32:3ba7 with SMTP id e16-20020a17090301d000b001924f323ba7mr113458205plh.18.1673840770853;
        Sun, 15 Jan 2023 19:46:10 -0800 (PST)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id t2-20020a170902e84200b001946a3f4d9csm5669226plg.38.2023.01.15.19.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Jan 2023 19:46:09 -0800 (PST)
Date:   Mon, 16 Jan 2023 12:46:05 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Minchan Kim <minchan@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCHv2 0/4] zsmalloc: make zspage chain size configurable
Message-ID: <Y8TIffsDImgENGpn@google.com>
References: <20230109033838.2779902-1-senozhatsky@chromium.org>
 <Y8G3nJ9+k2lB0kas@monkey>
 <Y8JU8iGlu5uLGdDt@google.com>
 <Y8Oo3+9UmZ4ac8sW@google.com>
 <Y8O3Cbj/QLBRtAJK@google.com>
 <87y1q3qneo.fsf@yhuang6-desk2.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y1q3qneo.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On (23/01/16 09:27), Huang, Ying wrote:
> >> [   59.546261] Call Trace:
> >> [   59.546833]  <TASK>
> >> [   59.547371]  ? lock_is_held_type+0xd9/0x130
> >> [   59.548331]  migrate_pages_batch+0x650/0xdc0
> >> [   59.549326]  ? move_freelist_tail+0xc0/0xc0
> >> [   59.550281]  ? isolate_freepages+0x290/0x290
> >> [   59.551289]  ? folio_flags.constprop.0+0x50/0x50
> >> [   59.552348]  migrate_pages+0x3fa/0x4d0
> >> [   59.553224]  ? isolate_freepages+0x290/0x290
> >> [   59.554214]  ? move_freelist_tail+0xc0/0xc0
> >> [   59.555173]  compact_zone+0x51b/0x6a0
> >> [   59.556031]  proactive_compact_node+0x8e/0xe0
> >> [   59.557033]  kcompactd+0x1c3/0x350
> >> [   59.557842]  ? swake_up_all+0xe0/0xe0
> >> [   59.558699]  ? kcompactd_do_work+0x260/0x260
> >> [   59.559703]  kthread+0xec/0x110
> >> [   59.560450]  ? kthread_complete_and_exit+0x20/0x20
> >> [   59.561582]  ret_from_fork+0x1f/0x30
> >> [   59.562427]  </TASK>
> >> [   59.562966] Modules linked in: deflate zlib_deflate zstd zstd_compress zram
> >> [   59.564591] ---[ end trace 0000000000000000 ]---
> >> [   59.565661] RIP: 0010:move_to_new_folio+0x362/0x3b0
> 
> Thanks for reporting.  We have just fixed a ZRAM related bug in
> migrate_pages() batching series with the help of Mike.

Oh, great. Yeah, I narroved it down to that series as well.

> https://lore.kernel.org/linux-mm/Y8DizzvFXBSEPzI4@monkey/

That fixes it!
