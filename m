Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD0BC727920
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 09:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232918AbjFHHrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 03:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232908AbjFHHrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 03:47:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A949210C
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 00:47:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0A9406497B
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 07:47:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 638D5C433EF;
        Thu,  8 Jun 2023 07:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686210426;
        bh=hexUjmGVaD550ltGipYVsnItZsinP867PWCzA8Kpc6I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qseVyII1AFg/7sj+nnd00HB53hHnIme3H5bFgsuhy0G9mGUpfKTF9VdGHOpuYLiZu
         FFruR/60nIcknTgSmk84zRr7IpJsT1NQDYDJEWeT37fBXmwLVCkJrRretHv3ds11W3
         Iivdg9slVae27pRz+OwTpdwWFROTMiOm0VqD1eW7jMnyR0X5e++VbFtmtQyhf2XQd7
         jeE9LbK4eT3GefT6iec3QI5sWwAnDpFj6B559+Lv327JEZrKnsLMoJrDOY9tDT8Xg2
         0uDocHAqFpceECfllyqbdRa5xHF8FEXns4sWszrtREM7VWNplJNa/luUqJj0+Eciz7
         oqcCGmGEvNF/A==
Date:   Thu, 8 Jun 2023 08:47:01 +0100
From:   Lee Jones <lee@kernel.org>
To:     Eric Dumazet <edumazet@google.com>
Cc:     jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
        davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        stable@kernel.org
Subject: Re: [PATCH v2 1/1] net/sched: cls_u32: Fix reference counter leak
 leading to overflow
Message-ID: <20230608074701.GD1930705@google.com>
References: <20230608072903.3404438-1-lee@kernel.org>
 <CANn89iKtkzTKhmeK15BO4uZOBQJhQWgQkaUgT+cxo+BwxE6Ofw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iKtkzTKhmeK15BO4uZOBQJhQWgQkaUgT+cxo+BwxE6Ofw@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 08 Jun 2023, Eric Dumazet wrote:

> On Thu, Jun 8, 2023 at 9:29 AM Lee Jones <lee@kernel.org> wrote:
> >
> > In the event of a failure in tcf_change_indev(), u32_set_parms() will
> > immediately return without decrementing the recently incremented
> > reference counter.  If this happens enough times, the counter will
> > rollover and the reference freed, leading to a double free which can be
> > used to do 'bad things'.
> >
> > In order to prevent this, move the point of possible failure above the
> > point where the reference counter is incremented.  Also save any
> > meaningful return values to be applied to the return data at the
> > appropriate point in time.
> >
> > This issue was caught with KASAN.
> >
> > Fixes: 705c7091262d ("net: sched: cls_u32: no need to call tcf_exts_change for newly allocated struct")
> > Suggested-by: Eric Dumazet <edumazet@google.com>
> > Signed-off-by: Lee Jones <lee@kernel.org>
> > ---
> 
> Thanks Lee !

No problem.  Thanks for your help.

> Reviewed-by: Eric Dumazet <edumazet@google.com>

-- 
Lee Jones [李琼斯]
