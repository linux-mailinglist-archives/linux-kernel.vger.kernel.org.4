Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAA7F61781B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 08:56:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231328AbiKCH4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 03:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbiKCHzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 03:55:40 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFAD61057B
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 00:54:39 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 670351F9D9;
        Thu,  3 Nov 2022 07:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667462078; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZM9LhN3P2GxaaPs4LSOfA8xH8G9/wFb+4rPYKngHJ3Q=;
        b=Oqkj4/NswNgplx+SQ4vtZD2QboDgr1eI3hNWOXzocEBXUKG0iCAT7l/F8pi9iaEHnRqZut
        uurLdPFU1pifoykyt1MALef2CzmgrrRl2E6mRcgmcuvMM6RFEoL5uSCxGJNRj7L2KHN6ZW
        vrSp9OO3p10uv3Y7revg1iBWEU4PstA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3B5CB13AAF;
        Thu,  3 Nov 2022 07:54:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4SI0DL5zY2O5KQAAMHmgww
        (envelope-from <mhocko@suse.com>); Thu, 03 Nov 2022 07:54:38 +0000
Date:   Thu, 3 Nov 2022 08:54:37 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Yang Shi <shy828301@gmail.com>
Cc:     Zach O'Keefe <zokeefe@google.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Davidoff <davidoff@qedmf.net>,
        Bob Liu <lliubbo@gmail.com>
Subject: Re: [PATCH] mm: don't warn if the node is offlined
Message-ID: <Y2NzvfCjd0X4g4p4@dhcp22.suse.cz>
References: <CAHbLzkonsnr4yxUOpMpoch1eCVNgR5hC9YaMkPR=fSV2Uszc6g@mail.gmail.com>
 <CAAa6QmRe1zMp8P-gZjR63Fg6KhOw+fP-v7SQWLNKuc2Y9ZxvyA@mail.gmail.com>
 <Y2IerOXJ+ZoRTHcs@dhcp22.suse.cz>
 <CAHbLzkrBNzsorc9oCq1=ri0uq1xbQ+m+u2gQX5GYrb=Z7n4siA@mail.gmail.com>
 <Y2KXkVmRWOpPT/MI@dhcp22.suse.cz>
 <CAHbLzkosQf8OoL+u+gkfO5-fvCNUuDxEa08FUfks1M4AS7tmjw@mail.gmail.com>
 <Y2KtKVpR69P+E0xT@dhcp22.suse.cz>
 <CAHbLzkpirnzJSu0SHGRbhFMsH7ZzHtL5ZMXjrBoy8r=UywVhMg@mail.gmail.com>
 <CAAa6QmQ+4XndbtE_=mcaC5OaeK4g42dKYfY5FmYoRDTKGO-3nA@mail.gmail.com>
 <CAHbLzkouJkixT0X_uGTrFj_qCyYikpr2j3LOo50rsY_P9OS8Xw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHbLzkouJkixT0X_uGTrFj_qCyYikpr2j3LOo50rsY_P9OS8Xw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 02-11-22 13:08:08, Yang Shi wrote:
[...]
> So I think we narrowed down to two options:
> 1. Preserve the interleave behavior but bail out if the target node is
> not online (it is also racy, but doesn't hurt)

I do not think there is merit in the interleave patch is dubious to say
the least.

> 2. Remove the node balance code entirely

Yes, removing the balancing makes sense but I would still hope that we
do not fail too easily if the range is populated on multiple nodes
equally. In practice it will likely not matter much I guess but setting
up all nodes with top score is just easy to achieve.
-- 
Michal Hocko
SUSE Labs
