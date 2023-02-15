Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47A8769829C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 18:47:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbjBORrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 12:47:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjBORrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 12:47:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA11B3C283
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 09:47:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7CD1A61CE1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 17:47:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C21BCC433EF;
        Wed, 15 Feb 2023 17:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676483219;
        bh=lJ13sfplKi9wVIbjK9iTUN/dZmrxheytiIyXNADUn+M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tLCm5calblgP6bIiv0xKzWrdZQoK0KViVHN4fe+W3z6MtQ9NcAdSiP6/ilDmr0BFi
         cKU8+vWInxpVVJSMzdJWFKw2uyvl6P8aqVVDVwnBmybMsyOXZKFB/bfXJJGys9KM+R
         av73wr7ZdWNMgGwFWljrKxDFVOG2WM7cMRUCCQIC9/D5RygM8i/oCJbOmzOVD+d81y
         aNRMTIW1liJrwwB2uT0Vg1G3ME383ECRY5iTQzjwnJgJWc65IKe9yn8HvXI2TKlIN8
         jZOwwfP4rAG8+DNpyvLqEEfnW8OdrWKA6KLyhYHVsp8QaG0b9PHCY7TjrggXwXsds0
         bsmuesZlbI2sw==
Date:   Wed, 15 Feb 2023 09:46:58 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] f2fs: make kobj_type structures constant
Message-ID: <Y+0aklEpswHoxlF2@google.com>
References: <20230209-kobj_type-f2fs-v1-1-b6feedbdd4a8@weissschuh.net>
 <cc338b66-f0f5-d9b7-81d3-b15bccc9d463@kernel.org>
 <Y+p4jezz5asWoPhu@google.com>
 <abb12474-f338-dedf-115b-da70e4946cec@kernel.org>
 <Y+vN18flpTqWwvll@google.com>
 <10a80557-50f6-f563-56ca-eb3df7e4ea93@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <10a80557-50f6-f563-56ca-eb3df7e4ea93@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/15, Chao Yu wrote:
> On 2023/2/15 2:07, Jaegeuk Kim wrote:
> > On 02/14, Chao Yu wrote:
> > > On 2023/2/14 1:51, Jaegeuk Kim wrote:
> > > > On 02/13, Chao Yu wrote:
> > > > > On 2023/2/9 11:20, Thomas Weiﬂschuh wrote:
> > > > > > Since commit ee6d3dd4ed48 ("driver core: make kobj_type constant.")
> > > > > > the driver core allows the usage of const struct kobj_type.
> > > > > > 
> > > > > > Take advantage of this to constify the structure definitions to prevent
> > > > > > modification at runtime.
> > > > > > 
> > > > > > Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> > > > > 
> > > > > Reviewed-by: Chao Yu <chao@kernel.org>
> > > > 
> > > > Hi Chao,
> > > > 
> > > > Note that, next time, I won't apply/modify any patches merged in -dev,
> > > > unless it has a problem.
> > > 
> > > Hi Jaegeuk,
> > > 
> > > Oh, any particular reason, to avoid unneeded commit id change when the time is
> > > close to merge window?
> > 
> > Hi Chao,
> > 
> > I'm trying to avoid breaking the -next branch.
> 
> Jaegeuk, so why do we need to avoid breaking -next branch? I didn't get it. :-(

That's not for linux-next, but my -next work.

> 
> > 
> > > 
> > > Is there any period of grace before merging patches from dev-test branch into dev
> > > branch? Maybe a week is reasonable? so I may have time to catch up in time.
> > 
> > No rule, but I'm trying to wait for several days while running my local tests.
> > If the patch looks okay, sometimes I'll queue it right away.
> 
> Sure, not problem.
> 
> Thanks,
> 
> > 
> > Thanks,
> > 
> > > 
> > > Thanks,
> > > 
> > > > 
> > > > Thanks,
> > > > 
> > > > > 
> > > > > Thanks,
