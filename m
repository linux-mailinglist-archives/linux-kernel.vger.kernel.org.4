Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 198BE741C64
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 01:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbjF1XYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 19:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbjF1XYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 19:24:46 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1570E9
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 16:24:44 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id 5614622812f47-3a1d9b64837so78084b6e.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 16:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687994684; x=1690586684;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c+frzkmPtuGHmkYBEBylQsm3B7k7j/a5AOqV9ViqKmw=;
        b=O9p5UCnhkvZg2oak3WZ/beM8V7vO1HSsIfVIfXJWkmoa2zWpncWupzqGoCh+quwuIw
         eYYyc3pePyoePsAbtU+qWBwUYKcvrO/wVDctgrBl5NwF4ITfTWYlEQaFgQWKd6PoeST1
         QFj5pZnhR8iCRMCT2X8Olzz1vC5f1zU/jultw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687994684; x=1690586684;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c+frzkmPtuGHmkYBEBylQsm3B7k7j/a5AOqV9ViqKmw=;
        b=fdz8/NnOpdxj5w0asYnVa4i3kNqT83MIBOGReAfeU2OsUWmjZlci/SOMwtQX8wuwLJ
         AyMZ851dxLKUpEyt7u8nR/CzRf80LvUggb5vOd2JsqdXxrRdNQy99Q0PQurOYbeQ5k3M
         Ylr8yz8TPTjeWl4h9S3O45Ez/xgdpfoZRFTAAcaYdBMcaWQcaUW+t0C1294HTe5HbYwS
         0XuivlWLmV6WsincR5VHAF/1766y3FhYE+VHJ4zePTRXkLL0KVPS6ksBqw0uWlj3jEzp
         b1MUBmKTiLLpe4eTD1kt0xqzI1KFl0oaO1KYMn4GjO9Tn6bsOHpAR/SoAmlRQHJzp5lk
         j/WQ==
X-Gm-Message-State: AC+VfDzC15Pazb2G7+x+eOi5FS/y/GmGUNY4elSOXEIalRNCeyZiYUva
        NizUlcOjSgohfzD0pcKiDEa1Ow==
X-Google-Smtp-Source: ACHHUZ7HhfkP6W58+5+9ClYoNBGA81jUExDe/4f7+kl9C+BhJQdJF35IyU0QaJPazfnHmdZpMeeZaw==
X-Received: by 2002:a05:6808:1a0d:b0:3a1:dbf5:fdbd with SMTP id bk13-20020a0568081a0d00b003a1dbf5fdbdmr13360315oib.27.1687994684100;
        Wed, 28 Jun 2023 16:24:44 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id u22-20020aa78496000000b00640f1e4a811sm5845474pfn.22.2023.06.28.16.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 16:24:43 -0700 (PDT)
Date:   Wed, 28 Jun 2023 16:24:42 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     Yuxiao Zhang <yuxiaozhang@google.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Tony Luck <tony.luck@intel.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        wak@google.com
Subject: Re: [PATCH] pstore: ramoops: support pmsg size larger than kmalloc
 limitation
Message-ID: <202306281615.360B12EFC@keescook>
References: <2023062832-barrier-strenuous-9499@gregkh>
 <20230628171055.1312737-1-yuxiaozhang@google.com>
 <28718037-ccf1-c36b-4eb6-716c518ca98f@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28718037-ccf1-c36b-4eb6-716c518ca98f@igalia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 03:12:10PM -0300, Guilherme G. Piccoli wrote:
> Also - Kees certainly knows that way better, but - are we 100% sure that
> the region for pstore can be non-contiguous? For some reason, I always
> thought this was a requirement - grepping the code, I found this
> (wrong?) comment:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/pstore/zone.c#n3

The contiguous requirements are entirely for the RAM backend's storage,
so these intermediate memory regions can use non-contiguous physical
backing memory (i.e. vmalloc).

Even the special case of crash-dumping should be fine for the large
buffer used to hold the crash before doing compression.

There are effectively 4 types of allocations in pstore:

1- a physical -> virtual mapping for the RAM backend
2- the allocations (if any) for non-RAM backends to hold a copy of pstore
   records when extracted from the backend storage (e.g NVRAM, EFI vars,
   etc).
3- incoming allocations that are used temporarily to hand data to the
   backend (e.g. the write_compat used in this patch)
4- the allocation used for holding the pstorefs data contents (which I
   need to double-check, but is entirely defined by the backends)

Changes aren't needed for (1), it's fine on its own. This patch changes
allocations for (2) and (3) for pmsg and the RAM backend, if I'm reading
it correctly. I think (4) is included as part of (2), but I need to
check. As long as all paths use kvfree() for the record buffers,
everything should Just Work for RAM. Switching the other backends to
also use kvalloc() would allow for greater flexibility, though.

Anyway, it's on my list to review and test. I'm still working through
other things related to the merge window opening, so I may be a bit slow
for the next week. :)

-Kees

-- 
Kees Cook
