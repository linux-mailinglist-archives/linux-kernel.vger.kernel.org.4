Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F4F1723598
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 05:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234118AbjFFDJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 23:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbjFFDJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 23:09:07 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C9DE118
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 20:09:06 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-565cfe4ece7so61240217b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 20:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686020945; x=1688612945;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OjqI31NkpFx9CfEMAQJxeYtBfX0HZisyfgoaNSZlHGA=;
        b=4gRz5Quzb7W4Y0ohbTRy17TEueH3F+5yDFcuIl3AlrxvMHsEzpappeNUsPAKUwnFzs
         OmTNGjwodSSx/raMyShcIiG8KPCmAfbmv2pK05qWeUXa0mkDVBJHOSmRwzvxBazT2pWE
         MpIbEr7/L+2/bA7Dw8XxwuAdVq19re77NVyabeF6IW0xilMJoo/gd8/JB7kAVKnzeLxB
         cYEi8aMB2x66jPhV8XaeACqfIZx3/WS6GcPzWAuHe7kHa6vXDI+yG/g3RdZjGgb8NxuF
         bjLRt3eJ+lA7a45GqBY1QXdbicWhAgCYuR/YPHYEhNBTRN2G1s+qxcac4YCWy1mt3nX7
         u9zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686020945; x=1688612945;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OjqI31NkpFx9CfEMAQJxeYtBfX0HZisyfgoaNSZlHGA=;
        b=Fiqge+VYgZGtl2x2j/y78HfqfNAvqNV2UUCYQq8qkHai+jZa2oRZiz1gHJ3p1eE3aq
         xg82ozlNYU6CLrC23I17Wmv6DoWyMgs0hetBrxUQRiOile1ZcwIawBMCyN+SdHaGRaDx
         nMrF9iF7plPq1AJvqfii9zp9SUKrAi4MZClDS3oUQHTW+ZzYSW35qwQ0BBBmVmOMwRUg
         NxjXS/oAilgQGV8EbHIa9lhJkCL+nmGS2lKh/BWvfbpudSLPNHOXq4Vdmfi7KS6+Kzv/
         fGBOeA2Mpbj3B4QtTh1xQy0/QYpwmtIsALn2TcN+zvqmumTUpxNMRqV/PWuzwO/OEmGX
         +MCQ==
X-Gm-Message-State: AC+VfDyQtMYSPciUgoDxIJ2UHqDPEdaJKAhw/YREgksm2M4hXA13Co4o
        ECzfok7R346o7i1KQNvLCqkYFA==
X-Google-Smtp-Source: ACHHUZ7fl1TIWrSqhfF7ZA7RzIKqFqBO/bq3nPilUkLRkK/BM7Q78vGFckRW+mnRf8n6rA9w3Hw4Xw==
X-Received: by 2002:a0d:e68d:0:b0:569:74f4:ffa with SMTP id p135-20020a0de68d000000b0056974f40ffamr707263ywe.11.1686020945636;
        Mon, 05 Jun 2023 20:09:05 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id v16-20020a814810000000b005688deeefc2sm3734453ywa.20.2023.06.05.20.09.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 20:09:05 -0700 (PDT)
Date:   Mon, 5 Jun 2023 20:08:56 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     "Yin, Fengwei" <fengwei.yin@intel.com>
cc:     Hugh Dickins <hughd@google.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, "Liu, Yujie" <yujie.liu@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 00/14] Reduce preallocations for maple tree
In-Reply-To: <d4d7157d-1e5b-fc7e-34de-66def46a344c@intel.com>
Message-ID: <ff754a68-4f94-e818-a31f-c8a1fd11b4b5@google.com>
References: <20230601021605.2823123-1-Liam.Howlett@oracle.com> <7a5dc9ce-b58f-e1b3-db1a-d00a8a556ae5@intel.com> <fad3c833-1ab3-2d34-aa85-dcc7c40c3587@bytedance.com> <a9d2ab1b-23a5-8c06-9f7a-6872c726db03@intel.com> <b5f2d527-8887-eb0b-d3f2-4e7cd8f3c022@intel.com>
 <4fb5f66d-c8c2-f857-7461-b974154dbc2b@bytedance.com> <20230605140344.66pwpdg5zgb6rfa7@revolver> <9f4c10bb-ee7c-cd41-f1b9-c1a7a1a562fd@google.com> <d4d7157d-1e5b-fc7e-34de-66def46a344c@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Jun 2023, Yin, Fengwei wrote:
> On 6/6/2023 10:41 AM, Hugh Dickins wrote:
> > On Mon, 5 Jun 2023, Liam R. Howlett wrote:
> >>
> >> You mean "mm: update validate_mm() to use vma iterator" here I guess.  I
> >> have it as a different commit id in my branch.
> >>
> >> I 'restored' some of the checking because I was able to work around not
> >> having the mt_dump() definition with the vma iterator.  I'm now
> >> wondering how wide spread CONFIG_DEBUG_VM is used and if I should not
> >> have added these extra checks.
> > 
> > Most CONFIG_DEBUG_VM checks are quite cheap, mostly VM_BUG_ONs for
> Indeed. I had CONFIG_DEBUG_VM enabled and didn't see surprise perf report.
> 
> 
> > easily checked conditions.  If validate_mm() is still the kind of thing
> > it used to be, checking through every vma on every mmap operation, please
> > don't bring that into CONFIG_DEBUG_VM - it distorts performance too much,
> > so always used to be under a separate CONFIG_DEBUG_VM_RB instead.
> So does this mean CONFIG_DEBUG_VM is allowed to be enabled for performance
> testing? Thanks.

I was going to say:
No, I did not mean that: I just meant that even developers not doing
strict performance testing still like to keep a rough eye on performance
changes; and historically CONFIG_DEBUG_VM has not distorted very much.

But then I wonder about certain distros which (wrongly or rightly) turn
CONFIG_DEBUG_VM on: I expect they do performance testing on their kernels.

Hugh
