Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03B7F6D6A43
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 19:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235944AbjDDRSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 13:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235938AbjDDRSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 13:18:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89CEF55B4;
        Tue,  4 Apr 2023 10:17:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D5A562F91;
        Tue,  4 Apr 2023 17:17:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 719E9C433EF;
        Tue,  4 Apr 2023 17:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680628665;
        bh=eqt/zmYCbn2kFXik0OsgUhoKuAHicxdBlyJ5ELcn8vo=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Slz0tHmziz69qlyOEtwy3H/V3QGvdxA3PmC4xGyip4A0InXQuXoqDHV32qM7oyCpl
         DhIo3oZ4OoA8HlbqYmgngJGAoKRoa/SOk3SBgGHx+GBLb3ZqzLuFjmO/jNeciY+ajI
         UoJH5I0jbyfZSLY4/FQzIX22sXVcbUqNrxHpTBIvwBfAgDwRl0gzUXxaFL8X9Q+2VH
         wEes0e3jUcMIPaPR0xIMP6OJec6mfD0fpMypu4qETilukDDLNhYOaWxZrnJE31YY6R
         s67u1CfzwwHxmu3laaBPMJ7OEzYP4PZ/sFtFNQGol2YPGL+ALCeonZ7BMUmS9YbClH
         KAaLQn5ygpYjA==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 0FF5415404B4; Tue,  4 Apr 2023 10:17:45 -0700 (PDT)
Date:   Tue, 4 Apr 2023 10:17:45 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, rostedt@goodmis.org, hch@lst.de
Subject: Re: [PATCH rcu 0/20] Further shrink srcu_struct to promote cache
 locality
Message-ID: <8cf50db4-1c0a-45d1-a6dc-0d197f8c7e12@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <f1b6cd5f-f0b7-4748-abd5-0dcfef0ce126@paulmck-laptop>
 <20230404135741.GB471948@google.com>
 <f2ae6531-1443-47e0-8897-0a47ca61ffec@paulmck-laptop>
 <CAEXW_YSSSFrRpb8bM0=ebBkJHQdFGuEWRAUqGesdonk9bNohTg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEXW_YSSSFrRpb8bM0=ebBkJHQdFGuEWRAUqGesdonk9bNohTg@mail.gmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 04, 2023 at 01:01:50PM -0400, Joel Fernandes wrote:
> [..]
> > > The "improperly set" thingies are perhaps Kconfig on ARM64 setting some KVM
> > > options slightly differently. I have seen that before as well on this board.
> >
> > Agreed, and one of the things on the long list is to allow arch-specific
> > settings for those options.
> >
> > The CONFIG_SMP warnings are interesting, though.  Does arm64 disallow
> > !SMP builds?  ;-)
> 
> Yes, it looks like it. As per arch/arm64/Kconfig, CONFIG_SMP is always
> 'y' and cannot be set.
> 
> config SMP
>         def_bool y

That would do it!  And of course this also explains the CONFIG_TINY_SRCU
complaints.

							Thanx, Paul
