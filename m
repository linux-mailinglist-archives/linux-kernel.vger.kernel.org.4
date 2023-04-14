Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4546E25D4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 16:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbjDNOe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 10:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjDNOe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 10:34:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A766BC
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 07:34:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7D2DC6420C
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 14:34:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E683C433D2;
        Fri, 14 Apr 2023 14:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681482861;
        bh=d0iC7roleDI04oHJIwtWDATxuxnM5ASBnX6PRX+duzY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tDqpVX6rIICqZGNhn3rMgK3VZbfqOkWwStqI7SukeZhca0g7UEY0KBY4pkYHechq+
         D4VVpG047EwsF4tUVcVo9NUQdyqoYI1Ft63c+ZFqRuR1XMavgFb0HTsc1R6N+P6zvk
         TW4AIUVfYed7fR8bHyNinoFWhx0SWUx21OiyhJyQSVLQHW+6kzP9p43EN5D46hUhcc
         /F74Ht+k1pGaOBciSviM0+TEYWnBsn/C2q2lSWc3H3fHeq/25xfbfUDCTYhXh0BEbW
         C4QrLEmYK1ZTzswpX4N9Wo11cHOH4WL2/6ezPivGm4qzJCH1ZezSnM0//LKdEzGFsc
         mPYrJlfbHE/9g==
Date:   Fri, 14 Apr 2023 15:34:16 +0100
From:   Will Deacon <will@kernel.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        horms@kernel.org, thunder.leizhen@huawei.com,
        John.p.donnelly@oracle.com, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5] arm64: kdump: simplify the reservation behaviour of
 crashkernel=,high
Message-ID: <20230414143413.GA27911@willie-the-truck>
References: <20230407022419.19412-1-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230407022419.19412-1-bhe@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Apr 07, 2023 at 10:24:19AM +0800, Baoquan He wrote:
> On arm64, reservation for 'crashkernel=xM,high' is taken by searching for
> suitable memory region top down. If the 'xM' of crashkernel high memory
> is reserved from high memory successfully, it will try to reserve
> crashkernel low memory later accoringly. Otherwise, it will try to search
> low memory area for the 'xM' suitable region. Please see the details in
> Documentation/admin-guide/kernel-parameters.txt.

[...]

>  arch/arm64/mm/init.c | 44 ++++++++++++++++++++++++++++++++++----------
>  1 file changed, 34 insertions(+), 10 deletions(-)

I tried to apply this, but smatch is unhappy with the result:

  | arch/arm64/mm/init.c:153 reserve_crashkernel() error: uninitialized symbol 'search_base'.

I _think_ this is a false positive, but I must say that the control flow
in reserve_crashkernel() is extremely hard to follow so I couldn't be
sure. If the static checker is struggling, then so will humans!

Ideally, this would all be restructured to make it easier to follow,
but in the short term we need something to squash the warning.

Cheers,

Will
