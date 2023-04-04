Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4226D5FEB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 14:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234799AbjDDMKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 08:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234360AbjDDMJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 08:09:01 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9193040D7
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 05:03:50 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 3F4FE22A03;
        Tue,  4 Apr 2023 12:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1680609829; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Br0Z4alxU7wp3Rhk+RTaZgwypk6DPbZKhOnMSVJGT24=;
        b=QqjCuJgfjT1BWsndH125Lho+YjEk1oOumDbtnuy9/lGIQHFI/92h9SK+lz/3+9YQJSYh/1
        ZPhC+rRzQr5qcJjSuGWdjfbCd+gfPXLgHjS7wqgtESoRI23jCb7Vd1fr6q0xPeItTGrWU3
        WIJK8oOxV/wHkUEtUWIESj8RqC1AXpc=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 2B2A32C142;
        Tue,  4 Apr 2023 12:03:47 +0000 (UTC)
Date:   Tue, 4 Apr 2023 14:03:47 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Jaewon Kim <jaewon31.kim@samsung.com>
Cc:     David Laight <David.Laight@aculab.com>,
        'Jaewon Kim' <jaewon31.kim@gmail.com>,
        "senozhatsky@chromium.org" <senozhatsky@chromium.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        GyeongHwan Hong <gh21.hong@samsung.com>
Subject: Re: [RFC] vsprintf: compile error on %09pK
Message-ID: <ZCwSIy5Tm0jAe1Ww@alley>
References: <694722c9409b43808cfbc1fc9e495016@AcuMS.aculab.com>
 <20230403104617epcms1p383bacbca705c0d7e4fffca6833050e42@epcms1p3>
 <ZCrMMQt2xnnZIyz6@alley>
 <CAJrd-Uvzy18SfjjqbqZCPHjw+ujQXsBpvov4b=bfAwZrj=bCAA@mail.gmail.com>
 <CGME20230403104617epcms1p383bacbca705c0d7e4fffca6833050e42@epcms1p6>
 <20230404101201epcms1p615a6365e64fc6e0a0fa203d41404940c@epcms1p6>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230404101201epcms1p615a6365e64fc6e0a0fa203d41404940c@epcms1p6>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2023-04-04 19:12:01, Jaewon Kim wrote:
> >From: Jaewon Kim
> >> Sent: 03 April 2023 15:40
> >...
> >> I wanted to print phys_addr_t  type value only when kptr_restrict sysctl is
> >> allowed. So I thought I could use %pK for that purpose. And the physical
> >> address is not that long. I wanted to make that length short like 9 hex.
> >
> >Isn't that is the wrong format for physical addresses anyway?
> >They can be larger than virtual ones (eg x86 with PAE).
> 
> Yeah, correct. I just used %pK to hide physical address, I thought it could be
> leak in security perspective. Could you give me advice how I can hide the
> address by default and look the address if kptr_restrict allow it?

Could you please send a patch that would show what value you want to print?

The initial mail mentioned converting %09lx to %09pK in some driver.
Then it included a warning when compiling from mm/page_alloc.o

Honestly, I think that you could just use %pK or %p. IMHO, it does not
make sense to optimize it for the length.

Anyway, there is still the question if the address is really worth
printing. Will it really help to locate a potential problem?

Best Regards,
Petr
