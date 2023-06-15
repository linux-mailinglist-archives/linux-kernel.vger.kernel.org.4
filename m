Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AED3E731B27
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 16:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344347AbjFOOU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 10:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344145AbjFOOUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 10:20:52 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0747026A6
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 07:20:51 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B6F4D22419;
        Thu, 15 Jun 2023 14:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1686838849; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iYNb+3lcXJf+tmIIl6IAONhkS2Go6YZm3aE1o17Tx0A=;
        b=i6Q6AyW6froqh6nSV3dqpjOES93TieOrn6KNautrpznUQXQknQJXaBvo52jnrGscCDZcQd
        By/QcC1Qht88TU464BUEvMDSVMN0gcA6j+0rYH0Ztjd0+9qlVUi2r4BdZkl6hpA9T3E4lR
        k/BcVw+6IDMNQBL96wJiGXclpPkqmXU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AA1A713A32;
        Thu, 15 Jun 2023 14:20:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id hODMKEEei2QpcQAAMHmgww
        (envelope-from <mhocko@suse.com>); Thu, 15 Jun 2023 14:20:49 +0000
Date:   Thu, 15 Jun 2023 16:20:49 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     =?utf-8?B?6LS65Lit5Z2k?= <hezhongkun.hzk@bytedance.com>
Cc:     minchan@kernel.org, senozhatsky@chromium.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [External] Re: [RFC PATCH 1/3] zram: charge the compressed RAM
 to the page's memcgroup
Message-ID: <ZIseQdSx9GAiyYDm@dhcp22.suse.cz>
References: <20230615034830.1361853-1-hezhongkun.hzk@bytedance.com>
 <ZIrbar9yQ6EZ217t@dhcp22.suse.cz>
 <CACSyD1Pz0SHOZ-aMr6NQ7vX5iNuhUUEnH=iysR49uxo=mbfN=Q@mail.gmail.com>
 <ZIsBM06ZJSbB+bXz@dhcp22.suse.cz>
 <CACSyD1O5FZs5H7EFb58n=-MhiXPpOXXPP_+zVVo5nj1cm5ccoA@mail.gmail.com>
 <ZIsR09IkLquV72dj@dhcp22.suse.cz>
 <CACSyD1P19kxERKPUAVChjy7AzV6h6RKTV8252ntoK5EUy8uC2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACSyD1P19kxERKPUAVChjy7AzV6h6RKTV8252ntoK5EUy8uC2A@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 15-06-23 22:13:09, 贺中坤 wrote:
> > This is not really answering my question though. memcg under hard limit
> > is not really my concern. This is a simpler case. I am not saying it
> > doesn't need to get addresses but it is the memcg hard limited case that
> > is much more interested. Because your charges are going to fail very
> > likely and that would mean that swapout would fail AFAIU. If my
> > understanding is wrong then it would really help to describe that case
> > much more in the changelog.
> >
> 
> OK, Got it. In many cases I have tested, it  will not fail because we did
> not charge the page directly，but the objects(like  slab,compressed page),
> for the zspage may be shared by any memcg.

That sounds like a broken design to me.
-- 
Michal Hocko
SUSE Labs
