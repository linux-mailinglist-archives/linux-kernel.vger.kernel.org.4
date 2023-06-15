Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 765E27319ED
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 15:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344053AbjFON2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 09:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244655AbjFON14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 09:27:56 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D1E62943
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 06:27:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A40632240D;
        Thu, 15 Jun 2023 13:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1686835667; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q6M/NGzKcM2Cg/a0sn3th6RfR3GtPwRmYrlgmNE+Q8A=;
        b=Y5h0z/hTNEHIiireJfIQl6qaCjSzs4HVZb7PQNpR//Jq9HqdYjzqravUV7pA+9wNDAiNy1
        JhIPKddR5ASYe7kXxoIpd+1Kz8+RsnesRz3iRZcOqDnH3rvSBXsldrkms02We7qgXKWt+l
        6fNVh9sG28oGfCYURizPEhLXtJ2AciA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8FB1113467;
        Thu, 15 Jun 2023 13:27:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0VTvIdMRi2R7VAAAMHmgww
        (envelope-from <mhocko@suse.com>); Thu, 15 Jun 2023 13:27:47 +0000
Date:   Thu, 15 Jun 2023 15:27:47 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     =?utf-8?B?6LS65Lit5Z2k?= <hezhongkun.hzk@bytedance.com>
Cc:     minchan@kernel.org, senozhatsky@chromium.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [External] Re: [RFC PATCH 1/3] zram: charge the compressed RAM
 to the page's memcgroup
Message-ID: <ZIsR09IkLquV72dj@dhcp22.suse.cz>
References: <20230615034830.1361853-1-hezhongkun.hzk@bytedance.com>
 <ZIrbar9yQ6EZ217t@dhcp22.suse.cz>
 <CACSyD1Pz0SHOZ-aMr6NQ7vX5iNuhUUEnH=iysR49uxo=mbfN=Q@mail.gmail.com>
 <ZIsBM06ZJSbB+bXz@dhcp22.suse.cz>
 <CACSyD1O5FZs5H7EFb58n=-MhiXPpOXXPP_+zVVo5nj1cm5ccoA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACSyD1O5FZs5H7EFb58n=-MhiXPpOXXPP_+zVVo5nj1cm5ccoA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 15-06-23 21:09:16, 贺中坤 wrote:
> > Let me check I understand. This patch on its own doesn't really do
> > anything. You need the zs_malloc support implemented in patch 3 for this
> > to have any effect. Even with that in place the zs_malloc doesn't follow
> > the __GFP_ACCOUNT scheme we use for allocation tracking. Correct?
> >
> 
> Yes， I will use it on next version.

OK, also make sure that the zsmalloc support is implemented before zram
depends on it.

> > I do not think this is answering my question. Or maybe I just
> > misunderstand. Let me try again. Say you have a memcg under hard limit
> > pressure so any further charge is going to fail. How can you reasonably
> > implement zram back swapout if the memory is charged?
> >
> 
> Sorry, let me try to explain again. I have a memcg under hard limit pressure.
> Any  further charge will  try to free memory and swapout to zram back which
> is compressed and stored data in memory.so any further charge is not going
> to fail. The charged memory is swapout to compressed memory step by
> step, but the compressed memory is not charged to the original memcgroup.
> So, Actual memory usage is already greater than the hard limit in some cases.
> This pachset will charge the compressed memory to the original memcg,
> limited by memory.max

This is not really answering my question though. memcg under hard limit
is not really my concern. This is a simpler case. I am not saying it
doesn't need to get addresses but it is the memcg hard limited case that
is much more interested. Because your charges are going to fail very
likely and that would mean that swapout would fail AFAIU. If my
understanding is wrong then it would really help to describe that case
much more in the changelog.

-- 
Michal Hocko
SUSE Labs
