Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38694742D81
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 21:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232262AbjF2TXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 15:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231918AbjF2TWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 15:22:43 -0400
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BFF435BC;
        Thu, 29 Jun 2023 12:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=7UucWkKLD79zbdKV1BdFvtfiPEZX683r6IsM3mY+FF8=; b=crkKI53riIFva2BgNi4Isqh06n
        /sh6DI7zoG4wiw0KGagyUeZdB1/hwnHz6O+R6XJ6geKECjkLUL27syY3okqonq0AZFzeQ5PmJZYXE
        PqJGMAL4nH+YhxZPOGUkHZMjaLyzUQmLrgWdbfnYt8xgfrkrA3BnZC5Adib9PBP75jQB3i2lGQODE
        Bp3xLpWU24GU9JF45OcS1fgu9AuJ/OjCUiUMPaXtxfqG0PhDsbIX6zHjR+8R1JfGwXcfSQXILenKA
        euhHGGqY2iFZUod1CLkz9kJfxXD59282vciONCLmV/BZ744wfQn53MSnvok01AxqRK3+K2VHiFfA0
        s5gyW+7Q==;
Received: from [179.232.147.2] (helo=[192.168.0.5])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1qExDQ-005vxG-E7; Thu, 29 Jun 2023 21:22:05 +0200
Message-ID: <80bf6cef-7824-124f-fe69-d820ae3416f3@igalia.com>
Date:   Thu, 29 Jun 2023 16:22:40 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] pstore: ramoops: support pmsg size larger than kmalloc
 limitation
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>
Cc:     Yuxiao Zhang <yuxiaozhang@google.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Tony Luck <tony.luck@intel.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        wak@google.com
References: <2023062832-barrier-strenuous-9499@gregkh>
 <20230628171055.1312737-1-yuxiaozhang@google.com>
 <28718037-ccf1-c36b-4eb6-716c518ca98f@igalia.com>
 <202306281615.360B12EFC@keescook>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <202306281615.360B12EFC@keescook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/06/2023 20:24, Kees Cook wrote:
> On Wed, Jun 28, 2023 at 03:12:10PM -0300, Guilherme G. Piccoli wrote:
>> Also - Kees certainly knows that way better, but - are we 100% sure that
>> the region for pstore can be non-contiguous? For some reason, I always
>> thought this was a requirement - grepping the code, I found this
>> (wrong?) comment:
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/pstore/zone.c#n3
> 
> The contiguous requirements are entirely for the RAM backend's storage,
> so these intermediate memory regions can use non-contiguous physical
> backing memory (i.e. vmalloc).
> 
> Even the special case of crash-dumping should be fine for the large
> buffer used to hold the crash before doing compression.
> 
> There are effectively 4 types of allocations in pstore:
> 
> 1- a physical -> virtual mapping for the RAM backend
> 2- the allocations (if any) for non-RAM backends to hold a copy of pstore
>    records when extracted from the backend storage (e.g NVRAM, EFI vars,
>    etc).
> 3- incoming allocations that are used temporarily to hand data to the
>    backend (e.g. the write_compat used in this patch)
> 4- the allocation used for holding the pstorefs data contents (which I
>    need to double-check, but is entirely defined by the backends)
> 
> Changes aren't needed for (1), it's fine on its own. This patch changes
> allocations for (2) and (3) for pmsg and the RAM backend, if I'm reading
> it correctly. I think (4) is included as part of (2), but I need to
> check. As long as all paths use kvfree() for the record buffers,
> everything should Just Work for RAM. Switching the other backends to
> also use kvalloc() would allow for greater flexibility, though.
> 
> Anyway, it's on my list to review and test. I'm still working through
> other things related to the merge window opening, so I may be a bit slow
> for the next week. :)
> 
> -Kees
> 

Thanks a bunch for the clarification Kees, much appreciated!
Now I understand it way better =)
