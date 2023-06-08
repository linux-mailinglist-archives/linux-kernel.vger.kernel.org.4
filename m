Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDC8D7286C1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 19:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236074AbjFHR7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 13:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235116AbjFHR7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 13:59:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C747C2D6B
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 10:58:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2464065010
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 17:58:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80501C433D2;
        Thu,  8 Jun 2023 17:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686247128;
        bh=H9vqqvqGv5gqr9XhvSYtAft9XyQ3waxGL9wQkTYdZSM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YGadLPHWvUuYpZJzVtNKteHBmHXberFWobCwJzXC9V+hm7og0zVsBB3NougAt4YgA
         W8e9YTf0FM5IAJWYglyDBjnFXWcVkxUuQ9u4tLtS9XuVQ03MPfSsQgbLvoOz5e8Z+b
         4N4WUDAJQKaJ5zh1Es8bXVv2Ao9RjALoM7YUT1BWLo1xAwKL0jnYOtJNziaXaSwZxx
         45XwgjGenK1LwtoX85Gl7AvQ1ZXI+bAMAcHpvSCtIGC1Aqf9cKnaMyaKVWJ6C38V2c
         efczC+CmQNTL3Si87fcPWj9r79IhmYct0m2su4t0bdgjH1/zA/TAA2HFDEmboRu03r
         tVoOuoCCy+oWw==
Date:   Thu, 8 Jun 2023 18:58:43 +0100
From:   Lee Jones <lee@kernel.org>
To:     Jamal Hadi Salim <jhs@mojatatu.com>
Cc:     Eric Dumazet <edumazet@google.com>, xiyou.wangcong@gmail.com,
        jiri@resnulli.us, davem@davemloft.net, kuba@kernel.org,
        pabeni@redhat.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, stable@kernel.org
Subject: Re: [PATCH v2 1/1] net/sched: cls_u32: Fix reference counter leak
 leading to overflow
Message-ID: <20230608175843.GA3635807@google.com>
References: <20230608072903.3404438-1-lee@kernel.org>
 <CANn89iKtkzTKhmeK15BO4uZOBQJhQWgQkaUgT+cxo+BwxE6Ofw@mail.gmail.com>
 <20230608074701.GD1930705@google.com>
 <CAM0EoM=osXFK7FLzF2QB3PvZ+W4sr=pnPD5jG1FjrzSbw-emWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM0EoM=osXFK7FLzF2QB3PvZ+W4sr=pnPD5jG1FjrzSbw-emWQ@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 08 Jun 2023, Jamal Hadi Salim wrote:

> On Thu, Jun 8, 2023 at 3:47 AM Lee Jones <lee@kernel.org> wrote:
> >
> > On Thu, 08 Jun 2023, Eric Dumazet wrote:
> >
> > > On Thu, Jun 8, 2023 at 9:29 AM Lee Jones <lee@kernel.org> wrote:
> > > >
> > > > In the event of a failure in tcf_change_indev(), u32_set_parms() will
> > > > immediately return without decrementing the recently incremented
> > > > reference counter.  If this happens enough times, the counter will
> > > > rollover and the reference freed, leading to a double free which can be
> > > > used to do 'bad things'.
> > > >
> > > > In order to prevent this, move the point of possible failure above the
> > > > point where the reference counter is incremented.  Also save any
> > > > meaningful return values to be applied to the return data at the
> > > > appropriate point in time.
> > > >
> > > > This issue was caught with KASAN.
> > > >
> > > > Fixes: 705c7091262d ("net: sched: cls_u32: no need to call tcf_exts_change for newly allocated struct")
> > > > Suggested-by: Eric Dumazet <edumazet@google.com>
> > > > Signed-off-by: Lee Jones <lee@kernel.org>
> > > > ---
> > >
> > > Thanks Lee !
> >
> > No problem.  Thanks for your help.
> >
> > > Reviewed-by: Eric Dumazet <edumazet@google.com>
> 
> Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>

Thanks Jamal.

-- 
Lee Jones [李琼斯]
