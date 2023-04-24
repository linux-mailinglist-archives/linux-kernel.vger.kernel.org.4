Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51EF36ED685
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 23:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232545AbjDXVGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 17:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbjDXVGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 17:06:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF6E66185;
        Mon, 24 Apr 2023 14:06:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 940C661D8E;
        Mon, 24 Apr 2023 21:06:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB47BC433EF;
        Mon, 24 Apr 2023 21:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682370389;
        bh=WoCEGXNV2msVa9t2ExRsULaVU0lvwGkdcTTlJ1EJc+o=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ZsfO8VEDPyh30WzOgNXwWpODZhVoaac11z6XqTLhffV3WyC8sgLWn8bIKuwc8QDXG
         cbvNGcZnffUL0Uf7z0o7iTRTgwLL/WQXrmwBzHrmNS7UwjAFYA397s+Nan/9b4+lBw
         219/aUmyf+sDQCITOUC5Kd9Yq/DOtv/+X2IaTsD8QYMYVDfNPw2KVF547JM1ukjIBd
         mxknX0xk8RQI7Gf3OiqmfloMnN/BlLr1CFZPnNw1EmflPrkT1EJPhtAnylj+BNEL6s
         ynJsE/dVN2l6Yx8JyRQsl3f5TNtSyK+b17i+w1ukve08vqN3yEdNKYaKEuRLsfNEHx
         MedFG1a5CriMQ==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 7D09615405A7; Mon, 24 Apr 2023 14:06:28 -0700 (PDT)
Date:   Mon, 24 Apr 2023 14:06:28 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, rostedt@goodmis.org,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>
Subject: Re: [PATCH RFC rcu 03/19] srcu: Begin offloading srcu_struct fields
 to srcu_update
Message-ID: <c68ad76d-49d3-421c-9928-f65bf4c126e1@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <3db82572-f156-4a5d-b711-841aa28bd996@paulmck-laptop>
 <20230324001938.3443499-3-paulmck@kernel.org>
 <80166ee7-4ee3-bb2d-c715-a8180dddee31@intel.com>
 <a0a2f6a7-b623-454c-ac65-69043a9f9f4d@paulmck-laptop>
 <20230326231858.GA19606@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230326231858.GA19606@lst.de>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 01:18:58AM +0200, Christoph Hellwig wrote:
> On Fri, Mar 24, 2023 at 01:11:47PM -0700, Paul E. McKenney wrote:
> > > Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > Thank you!  I will add this on my next rebase.
> > 
> > It is possible that this will be v6.5 rather than v6.4 material.
> 
> I was hoping the RCU bits could land in 6.4, so that the block
> layer work to take advantage of it can go into 6.5 without cross-tree
> dependencies.

And this is now in mainline.  Please let me know how it goes!

							Thanx, Paul
