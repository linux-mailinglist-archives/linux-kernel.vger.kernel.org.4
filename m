Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86871648C5E
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 02:27:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbiLJB0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 20:26:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbiLJB0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 20:26:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24FB892A36
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 17:26:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BEE34B82A03
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 01:26:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B45CC433D2;
        Sat, 10 Dec 2022 01:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670635604;
        bh=l1DbbMphKLiLv6pmx0f5anOTvcA2j/cBITwgBGszWm4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=p3FG8Y3RgSGMXEamU6M8gxQnijgtwfXS7vTvqlTtpWRlwB9rpAR2TEKOKZRakMtnB
         mEbHq/PwGmZMqo/maVjEiB334qztT6XeP9ckvrWn5uKy2KrgvC5z4F8EIc7nfOhXbi
         QBYl2So1dTfJuGFqGxOeQYU33eAG6doLdBmiJ0WWbHAMNvFs5lbY+PcM2wWMwEywDH
         hihviT35caNTIX/vX4lfj7PYh9+Uh9eelLO85/g3LWkxMh6GaNylfOjEsg4JMETyjM
         jf0ZbfrTirPr/if9XIZ+aBVwRQLmtjbg+6D+qszGdKTiF+9u2yTZhBaKHRvm5bubUU
         CeeGUpieHxhcw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 03A485C0AE9; Fri,  9 Dec 2022 17:26:44 -0800 (PST)
Date:   Fri, 9 Dec 2022 17:26:43 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Sven Schnelle <svens@linux.ibm.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] add s390 support to nolibc and rcutorture
Message-ID: <20221210012643.GB4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221209141939.3634586-1-svens@linux.ibm.com>
 <20221209150325.GX4001@paulmck-ThinkPad-P17-Gen-1>
 <20221209152835.GC19965@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221209152835.GC19965@1wt.eu>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 09, 2022 at 04:28:35PM +0100, Willy Tarreau wrote:
> On Fri, Dec 09, 2022 at 07:03:25AM -0800, Paul E. McKenney wrote:
> > On Fri, Dec 09, 2022 at 03:19:34PM +0100, Sven Schnelle wrote:
> > > Hi,
> > > 
> > > these patches add support for the s390 architecture both to nolibc
> > > and rcutorture. Note that this only adds support for the 64 bit
> > > version, no support for 31 bit (compat) is added. For nolibc it
> > > includes one bugfix to make the fd_set datatype match the kernel
> > > type.
> > 
> > Nice!!!
> 
> indeed :-)
> 
> > The rcutorture patches look plausible to me, but I must defer to Willy
> > Tarreau on the nolibc changes.
> 
> I had a very quick glance over them and nothing shocked me. I just want
> to double-check the u32->long conversion with a careful eye but I'm happy
> to see that your rcutorture binary continues its diet on more and more
> architectures ;-)

Very good, and I will await your review.

							Thanx, Paul
