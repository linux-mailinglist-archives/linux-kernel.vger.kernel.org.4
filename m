Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB0470EA79
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 02:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234485AbjEXAyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 20:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjEXAyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 20:54:46 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38EA7C2
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 17:54:45 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1ac65ab7432so10515ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 17:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684889685; x=1687481685;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=67McTrZYHlUYTkrkjMKzLJM2fylAkOevMd/PAdSKUW8=;
        b=b+Cf6K+6GzILfBq78GL5a77e4JPfZM8I551nq2kJl/FNwYwktgaPLTOi6cj8OrjXcQ
         Kc30wdu/X8rkDOEl4Y3dXZS2Ps+JQmXwbUmPQRvWTLko+Nmjh6RhcbrFsGsfNhpRgwNp
         a7fxqfZHXY9vPP/7kJieitSA4TQmay5eruKaqFbZ9xnfDMG9Q5qnnyNLTKpEhXMJFXr1
         /txr92SgZ6T7x/JmjAII3CnVQZSF68tCE8WhbczmhLzPcmboOtZggfCFWqFQmCBWazyY
         jPL9S/S2YCc7rHAJUMWynupHpZPs3FbBA6jp0U8yOtadve4Qli4F8rGISF/BU0T5Wl3C
         g0QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684889685; x=1687481685;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=67McTrZYHlUYTkrkjMKzLJM2fylAkOevMd/PAdSKUW8=;
        b=codZOvZ3xb181xtOIihhovCUEaxPbcXECk25VUqKv97DwULS2qG/lSvZnTfGtHDxxp
         HjZJlUgcdOaGMkSCRJy9HP4GzmqwO+2xvKqAQORJrf6wiiJb1iICBQsbJvKzJi5WGfrM
         DfoVJB2zdt+NU01LQZLzTkn0kVMZWJp19RJT1i1m6tL9kmIfYzBxery7zZ311nyfIBSU
         eai8e56eC0/ovpWa6AR+TI/QRJ4Zys6B8+0iWnVVLCGVTGogYANm4NRTdn4laMlDS4V5
         +29H6T1TEnBqCQ4j4mBTxFqnwg7jT/IzNogmdbTtwJAK42nx6mjbdpDT6dHonfa6hXgg
         cMWQ==
X-Gm-Message-State: AC+VfDw2RnIlQyh6PcKQfPCLf6AghzOuvuOgmK0XJYbHjFDIoehhSS7a
        3T36BLOtj1GVZ1Layg9cJP1a0g==
X-Google-Smtp-Source: ACHHUZ4mqnM95BjMoKuzKG9ITbJRKiz0luhjMSAWnLF+siwepzzokXQloiUTIAw7DD6xfgnpVrnXzQ==
X-Received: by 2002:a17:902:d48a:b0:1a9:7cbf:a7c1 with SMTP id c10-20020a170902d48a00b001a97cbfa7c1mr38473plg.13.1684889684574;
        Tue, 23 May 2023 17:54:44 -0700 (PDT)
Received: from [2620:0:1008:11:c789:c1fb:6667:1766] ([2620:0:1008:11:c789:c1fb:6667:1766])
        by smtp.gmail.com with ESMTPSA id m15-20020a17090a3f8f00b0024b79a69361sm142407pjc.32.2023.05.23.17.54.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 17:54:44 -0700 (PDT)
Date:   Tue, 23 May 2023 17:54:43 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
To:     Matthew Wilcox <willy@infradead.org>
cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>, Alex Shi <alexs@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Alexander Duyck <alexanderduyck@fb.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [patch] mm, debug: allow suppressing panic on CONFIG_DEBUG_VM
 checks
In-Reply-To: <ZGw2eJxxQl4DrfWi@casper.infradead.org>
Message-ID: <703a3995-75cf-b575-deff-fe2b78bd1354@google.com>
References: <c9abf109-80f2-88f5-4aae-d6fd4a30bcd3@google.com> <b4dce681-e53c-a6fd-2dab-62a82ebc6dff@redhat.com> <53dd9df8-e88f-f466-89f9-3fa141a10267@google.com> <ZGw2eJxxQl4DrfWi@casper.infradead.org>
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

On Tue, 23 May 2023, Matthew Wilcox wrote:

> On Mon, May 22, 2023 at 11:39:27AM -0700, David Rientjes wrote:
> > I think VM_BUG_ON*() and friends are used to crash the kernel for 
> > debugging so that we get a crash dump and because some variants don't 
> > exist for VM_WARN_ON().  There's no VM_WARN_ON_PAGE(), for example, unless 
> > implicitly converted with this patch.
> 
> It could be added, but there's already a VM_WARN_ON_FOLIO() and
> VM_WARN_ON_ONCE_PAGE(), so hopefully we just keep converting code
> to folios until nobody notices that we might need such a thing.
> 

Yeah, the lack of VM_WARN variants for VM_BUG_ON_MM or VM_BUG_ON_VMA are 
probably better examples.  But it looks like we're converging toward 
eliminating VM_BUG_ON* variants entirely and relying on 
kernel.panic_on_warn to do the BUG_ON() behavior if we want to opt into 
that.  So this will be a useful cleanup.
