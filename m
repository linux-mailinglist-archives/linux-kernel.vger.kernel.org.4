Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 022726FBD6D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 05:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232562AbjEIDAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 23:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjEIDAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 23:00:39 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B4165269
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 20:00:37 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-517bfdf55c3so2697871a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 20:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1683601237; x=1686193237;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3phbqPGzhNPYYPhsWx7YPm9EYaracy7lqNtqwFBF8dk=;
        b=fsVVedA2apC3Zwx4eC3AIpOOxsOGHvoknhNN70P/GS7Q3peLiOzmbn0GS0fUPnxzNb
         Jz/+OOpzreMBDFQJ9rk9R0+QIe5zOjI+vy1RthktXwi017Rva+uorTv/659QgdcmEeju
         dlxQF1y87bc3bfCoXxx0q4s2e3nJeu9dX7doc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683601237; x=1686193237;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3phbqPGzhNPYYPhsWx7YPm9EYaracy7lqNtqwFBF8dk=;
        b=FZyXY4QWin6wv/ZF7Zf9GjJ0k8erJgOY4+hWXXba195eQeke/995Um0l7NcqgMC8OZ
         aj4DRxCNzmeEuM+qqO6ge6ptwwj5w+gesyHm5B2up306LqiRktqp15OxtK/8gr0L4LgI
         BlN0AD7GQQYKI/SpqT4SiUQamH7O2Mu6l8gK+ZFaVCvMQcttprwivB07UbREuaNdztaa
         axyEcirfIFlwMRt+5lJbOArUfzn+TrqnCNpS41jiZsT4FKC6KTfuEKUShhc5bv5OTPzy
         C1RtFgGKOPW8ST2TNAZfQmIP2LdZq1whWv4DMQKi3tFI8OpGOp6Z9A9WM/oZdmnNGStX
         W0Yg==
X-Gm-Message-State: AC+VfDy5W3Z0NF0AndceOxUPEui6jpKq28Q169B95Xe1gKGi3KAlgaCR
        3rrqgSPdxUBn7fcsQdpnnfNYdQ==
X-Google-Smtp-Source: ACHHUZ7VO14EfGnAsrK/2SWhtKCwybMTOQUZPsLY2bmoy1RQjJM4E/eqUXIVbTgnvm0i9LeUdkW4Zw==
X-Received: by 2002:a17:902:7d98:b0:1ac:7b13:de71 with SMTP id a24-20020a1709027d9800b001ac7b13de71mr5748984plm.37.1683601236934;
        Mon, 08 May 2023 20:00:36 -0700 (PDT)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id fh11-20020a17090b034b00b00246aba3ebabsm5112610pjb.45.2023.05.08.20.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 20:00:36 -0700 (PDT)
Date:   Tue, 9 May 2023 12:00:30 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Nhat Pham <nphamcs@gmail.com>, Minchan Kim <minchan@kernel.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ngupta@vflare.org,
        sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com,
        kernel-team@meta.com
Subject: Re: [PATCH] zsmalloc: move LRU update from zs_map_object() to
 zs_malloc()
Message-ID: <20230509030030.GD11511@google.com>
References: <20230505185054.2417128-1-nphamcs@gmail.com>
 <20230506030140.GC3281499@google.com>
 <20230508140658.GA3421@cmpxchg.org>
 <CAKEwX=MtunOe6A--SG3ud-gUFg3bXFJgG4csgwHeZFAEqjCgHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKEwX=MtunOe6A--SG3ud-gUFg3bXFJgG4csgwHeZFAEqjCgHg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/05/08 09:00), Nhat Pham wrote:
> > The deeper bug here is that zs_map_object() tries to add the page to
> > the LRU list while the shrinker has it isolated for reclaim. This is
> > way too sutble and error prone. Even if it worked now, it'll cause
> > corruption issues down the line.
> >
> > For example, Nhat is adding a secondary entry point to reclaim.
> > Reclaim expects that a page that's on the LRU is also on the fullness
> > list, so this would lead to a double remove_zspage() and BUG_ON().
> >
> > This patch doesn't just fix the crash, it eliminates the deeper LRU
> > isolation issue and makes the code more robust and simple.
> 
> I agree. IMO, less unnecessary concurrent interaction is always a
> win for developers' and maintainers' cognitive load.

Thanks for all the explanations.

> As a side benefit - this also gets rid of the inelegant check
> (mm == ZS_MM_WO). The fact that we had to include a
> a multi-paragraph explanation for a 3-line piece of code
> should have been a red flag.

Minchan had some strong opinion on that, so we need to hear from him
before we decide how do we fix it.
