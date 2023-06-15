Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2B4C7318D4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 14:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240158AbjFOMVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 08:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245029AbjFOMTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 08:19:43 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AEAA3C01
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 05:17:55 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A05051FE0D;
        Thu, 15 Jun 2023 12:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1686831411; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=86pO/5pX8I+6NSA3fZs+/KcyWC6lgb7caHW7+qPc8ko=;
        b=mTBdbL6oQEScJdyCDi72UHa9I2GLbRNJ5ZjBPYHndoipUG71Z4Xxu63EC27CX6SqH+vo9X
        FY6pdkkt8YRTcB27ib4YCNhwkeC/1pM5HqDnfft8LjxWV887AzC6Q1dGJNX59BghoFDaUU
        YdVK15054ieCTAdkL/LC09lbkfUFbLM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8F73013A47;
        Thu, 15 Jun 2023 12:16:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id xmtlIjMBi2ScLQAAMHmgww
        (envelope-from <mhocko@suse.com>); Thu, 15 Jun 2023 12:16:51 +0000
Date:   Thu, 15 Jun 2023 14:16:51 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     =?utf-8?B?6LS65Lit5Z2k?= <hezhongkun.hzk@bytedance.com>
Cc:     minchan@kernel.org, senozhatsky@chromium.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [External] Re: [RFC PATCH 1/3] zram: charge the compressed RAM
 to the page's memcgroup
Message-ID: <ZIsBM06ZJSbB+bXz@dhcp22.suse.cz>
References: <20230615034830.1361853-1-hezhongkun.hzk@bytedance.com>
 <ZIrbar9yQ6EZ217t@dhcp22.suse.cz>
 <CACSyD1Pz0SHOZ-aMr6NQ7vX5iNuhUUEnH=iysR49uxo=mbfN=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACSyD1Pz0SHOZ-aMr6NQ7vX5iNuhUUEnH=iysR49uxo=mbfN=Q@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 15-06-23 19:58:37, 贺中坤 wrote:
> Hi michal,  glad to hear from you.
> 
> > I am not really deeply familiar with zram implementation nor usage but
> > how is the above allocation going to be charged without __GFP_ACCOUNT in
> > the gfp mask?
> 
> Yes，zs_malloc() did not charge compressed memory, even if we add this gfp.
> so we need to implement this function in this patchset. But this flag should be
> used to enable this feature.

Let me check I understand. This patch on its own doesn't really do
anything. You need the zs_malloc support implemented in patch 3 for this
to have any effect. Even with that in place the zs_malloc doesn't follow
the __GFP_ACCOUNT scheme we use for allocation tracking. Correct?

> > Also what exactly is going to happen for the swap backed by the zram
> > device? Your memcg might be hitting the hard limit and therefore
> > swapping out. Wouldn't zs_malloc fail very likely under that condition
> > making the swap effectively unusable?
> 
> This is the key point, as i said above, zs_malloc() did not charge
> compressed memory,
> so zs_malloc will not fail under that condition. if the zram swap is
> large enough, zs_malloc
> never fails unless system OOM.   so memory.max will be invalidated.

I do not think this is answering my question. Or maybe I just
misunderstand. Let me try again. Say you have a memcg under hard limit
pressure so any further charge is going to fail. How can you reasonably
implement zram back swapout if the memory is charged?

-- 
Michal Hocko
SUSE Labs
