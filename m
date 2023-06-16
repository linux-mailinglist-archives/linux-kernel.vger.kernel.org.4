Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36A7E7327C6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 08:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241951AbjFPGkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 02:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241627AbjFPGka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 02:40:30 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A1C7273E
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 23:40:28 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4143921EA4;
        Fri, 16 Jun 2023 06:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1686897627; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GlSD6RWNsFHyZEr4GHh8TKFlv5WJ0i1ZYa1pBLlMowc=;
        b=Lwaq0oM9xcU4PNbk4U2Q1L4ultP5oN78NdmmwGPF5vI82UUCor/lBmAb2uuxDQbR6Joo13
        PGBl3wCAotw2hOrEqvgbKwQOFmNUBQ5Cz6Qze9QVD4WHJM5yB7c7OsK+4b1Ti//A+LaDeK
        Z8DdJ63vhDa82ZL+fYelXkZmQICtxzU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1EE2E138E8;
        Fri, 16 Jun 2023 06:40:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id lokcBdsDjGRFdAAAMHmgww
        (envelope-from <mhocko@suse.com>); Fri, 16 Jun 2023 06:40:27 +0000
Date:   Fri, 16 Jun 2023 08:40:26 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     =?utf-8?B?6LS65Lit5Z2k?= <hezhongkun.hzk@bytedance.com>
Cc:     minchan@kernel.org, senozhatsky@chromium.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [External] Re: [RFC PATCH 1/3] zram: charge the compressed RAM
 to the page's memcgroup
Message-ID: <ZIwD2ngXkXD9qHuB@dhcp22.suse.cz>
References: <20230615034830.1361853-1-hezhongkun.hzk@bytedance.com>
 <ZIrbar9yQ6EZ217t@dhcp22.suse.cz>
 <CACSyD1Pz0SHOZ-aMr6NQ7vX5iNuhUUEnH=iysR49uxo=mbfN=Q@mail.gmail.com>
 <ZIsBM06ZJSbB+bXz@dhcp22.suse.cz>
 <CACSyD1O5FZs5H7EFb58n=-MhiXPpOXXPP_+zVVo5nj1cm5ccoA@mail.gmail.com>
 <ZIsR09IkLquV72dj@dhcp22.suse.cz>
 <CACSyD1P19kxERKPUAVChjy7AzV6h6RKTV8252ntoK5EUy8uC2A@mail.gmail.com>
 <ZIseQdSx9GAiyYDm@dhcp22.suse.cz>
 <CACSyD1OA1kzD5tyJW7=uTj0V-uk8PmHKmU8XE8zTtK_eXEkG7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACSyD1OA1kzD5tyJW7=uTj0V-uk8PmHKmU8XE8zTtK_eXEkG7Q@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 16-06-23 11:31:18, 贺中坤 wrote:
> On Thu, Jun 15, 2023 at 10:21 PM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Thu 15-06-23 22:13:09, 贺中坤 wrote:
> > > > This is not really answering my question though. memcg under hard limit
> > > > is not really my concern. This is a simpler case. I am not saying it
> > > > doesn't need to get addresses but it is the memcg hard limited case that
> > > > is much more interested. Because your charges are going to fail very
> > > > likely and that would mean that swapout would fail AFAIU. If my
> > > > understanding is wrong then it would really help to describe that case
> > > > much more in the changelog.
> > > >
> > >
> > > OK, Got it. In many cases I have tested, it  will not fail because we did
> > > not charge the page directly，but the objects(like  slab,compressed page),
> > > for the zspage may be shared by any memcg.
> >
> > That sounds like a broken design to me.
> > --
> > Michal Hocko
> > SUSE Labs
> 
> I will try more cases in different compression ratios and make sure
> that swapout will not fail.

I do not think different compression methods will cut it. You
essentially need some form of memory reserves - in memcg world
pre-charged pool of memory readily available for the swapout. Another
way would be to allow the charge to bypass the limit with a guarantee
that this will be a temporal breach.

-- 
Michal Hocko
SUSE Labs
