Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3AB364738D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 16:51:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbiLHPvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 10:51:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiLHPvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 10:51:33 -0500
Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0B2870B9A
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 07:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        Content-ID:Content-Description;
        bh=WqNv4tTpaYh4KzG5gg2YG+zdkA2FUCBC5yatizYS8Yw=; b=urr7usUl3uRGmeZW4FVRO+3un8
        Gn8NX7uY6rAKOKf5EYN2J+4sHgp8rNRwoij6maPFMaXmFLaniCT/Hkox/qmqqQDtF9D28O2dLiPPv
        RPNSFrWGaVwd7zzcxnDUKSbQwWFAVBEGpddB9BJFkyDXE3nRjdI8cWU6aQV/FHzWvOlCbns3mPRGd
        CzgdGBTg4oshuU0H7C/m6ozy12xEP9Nc+T56ELIyKPPrN/NweE8w2RZPdjzzbCdzLUydUMw2FwaxV
        oWNGA1ZAd2UHOyk8jNn4uBZMadtAOwtd5xYD24pl51hEKEb/J+BeBiUcxRGiZtqaFqE1TX0PwlCkx
        VIHJ/sZrZkDx8axJKez1tY7RQnNUdj7o+rq2aSVlnNcdi3P5GodqtHA31MyqT3DjZonSKxuEKds+z
        b7+4ZwPLBPpFWXM/5mCIuW38DYZtoiWDrm6lN9Sy51LIeU6RK1L3T4nHfOLNkr1KfHS+zF1r2RDAl
        488JuJeCYrIDTYuSCimTkiLcUluWlIiMSYY0hhAD7LKKU5gqp1kSPGGWHIQFq5nAlDqeIUzTNc6Fm
        a2TMqgc46KRJjE4Du9ABQEw0uINDa0n4Trf3YQmb4PJu73500mAa5ToKBKRaPTdGEAmZxF7qvbaCE
        jRLrycmY+2KuQ8IpDNiEvGgxWbtNoNCqGC1XYUV7k=;
From:   Christian Schoenebeck <linux_oss@crudebyte.com>
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Marco Elver <elver@google.com>
Subject: Re: [PATCH] 9p/client: fix data race on req->status
Date:   Thu, 08 Dec 2022 16:51:27 +0100
Message-ID: <167052961.MU3OA6Uzks@silver>
In-Reply-To: <Y45wZEvO8gOanV85@codewreck.org>
References: <20221205124756.426350-1-asmadeus@codewreck.org> <3368929.hG1Ktuj5m1@silver>
 <Y45wZEvO8gOanV85@codewreck.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, December 5, 2022 11:27:48 PM CET Dominique Martinet wrote:
> Christian Schoenebeck wrote on Mon, Dec 05, 2022 at 04:19:01PM +0100:
> > I must have missed the prior discussion, but looking at the suggested
> 
> Good point, I'll add a link to the report as well...
> It's this thread:
> https://lkml.kernel.org/r/CA+G9fYsK5WUxs6p9NaE4e3p7ew_+s0SdW0+FnBgiLWdYYOvoMg@mail.gmail.com
> 
> > solution: if there is no lock, then adding READ_ONCE() and WRITE_ONCE() would
> > not fix cross-CPU issues, as those would not have a memory barrier in that
> > case.
> > 
> > Shouldn't that therefore rather be at least smp_load_acquire() and
> > smp_store_release() at such places instead?
> 
> The barrier is here -- 

Right, looks like most of it should be fine. Maybe p9_client_zc_rpc() needs a
barrier as well?

> I think we're just protecting against compiler
> reordering or if on some arch the store isn't actually atomic.

And access order within the same thread.

> This code path actually was broken before I added the barrier a while
> ago (2b6e72ed747f68a03), as I was observing some rare but very real
> errors on a big server so I'm fairly confident that for at least x86_64
> the generated code isn't too bad, but if KCSAN helps catching stuff I
> won't complain.

What about p9_tag_alloc()?



