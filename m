Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1177F6B3F04
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 13:18:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbjCJMSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 07:18:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbjCJMSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 07:18:46 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D319EF72
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 04:18:38 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id y15-20020a17090aa40f00b00237ad8ee3a0so5001798pjp.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 04:18:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678450717;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vXzuukFRVMovio/H3aM4dE+Si8J0yvt0rOz6R2R9CKg=;
        b=M30Xfkj+a324mELNqovWsFDTsENbmhTSc57FSCx4WpBzJQZuP8eO61JdxRDfp3WNGY
         mXOQTRXqcMO9o46asAlbrd6E8VzQc+xSYwPQa5JUiFQASgdCuxFRD3sAGhcdaXXctUvx
         bhMhY10+stjgtDppyxNtAuQdadzzhD1fNznjY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678450717;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vXzuukFRVMovio/H3aM4dE+Si8J0yvt0rOz6R2R9CKg=;
        b=r1B28pV8/mVQIyeJ21gBL+6C8sRt8KeMOaBIGgjRtYQ/PX3Jj4OLXIik+OicNKHR+0
         EinusT/v33miaap16wWo32HXDkIlvbZRX+ugzdP91f3ZY4/6TAnH0ph6CsGv6/ePV6IC
         98KEe0HUI8SiSRcvceX4M1MS0/2jMixmWforTLGCYMzYBb6VsMURio8RRvy3VAiCt9aI
         /bUhAEZZ7lA4an2fASyYGoWz3AXq2eRdZLYqfnxNhA7OEWIPNUS0tfz+mUQT5jlxhpuE
         Q/P4MkLpiRtMCrxyNB+OmdIKb+ntKEX381mfmwOMpnntErVuE0ftqSi6fFJL4UypiIkO
         c/YA==
X-Gm-Message-State: AO0yUKU0pGxEa2Eoyp26b7bTdVfD1YwiKJTUHnN3l9pH1PN+y217Z/J3
        Me9j+ndgcFUd1+QvMyfydBZYkQ==
X-Google-Smtp-Source: AK7set++a5L5b+p8TV4xXIOMM5kBqOr0Y0yGmljc9x+mgMyGtuoDF63I/RuQrHz1KA0bb68Cpvh+QQ==
X-Received: by 2002:a17:903:441:b0:19e:7d51:3a41 with SMTP id iw1-20020a170903044100b0019e7d513a41mr22173524plb.69.1678450717541;
        Fri, 10 Mar 2023 04:18:37 -0800 (PST)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id lg11-20020a170902fb8b00b0019f10c2de3bsm1137057plb.24.2023.03.10.04.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 04:18:36 -0800 (PST)
Date:   Fri, 10 Mar 2023 21:18:32 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        "hn.chen" <hn.chen@sunplusit.com>
Subject: Re: [PATCH v7 1/6] media: uvcvideo: Fix underflow addressing on hw
 timestamp
Message-ID: <20230310121832.GH1045797@google.com>
References: <20220920-resend-hwtimestamp-v7-0-cf1d78bb8821@chromium.org>
 <20220920-resend-hwtimestamp-v7-1-cf1d78bb8821@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220920-resend-hwtimestamp-v7-1-cf1d78bb8821@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/03/10 10:01), Ricardo Ribalda wrote:
> If head is 0, we will be addressing clock->samples[-1], which will
> result in undefined behaviour.

[..]

>  	first = &clock->samples[clock->head];
> -	last = &clock->samples[(clock->head - 1) % clock->size];
> +	last = &clock->samples[(clock->head - 1 + clock->size) % clock->size];

Just for visibility:

Per offline discussion with Ricardo, this should not cause a samples[-1]
access, as all arithmetic operations there `unsigned`

    75ef:       41 8d 46 ff             lea    -0x1(%r14),%eax
    75f3:       31 d2                   xor    %edx,%edx
    75f5:       f7 f1                   div    %ecx
    75f7:       41 89 d5                mov    %edx,%r13d

Regardless of that, Ricardo still has a point, there is a bug in the code.
