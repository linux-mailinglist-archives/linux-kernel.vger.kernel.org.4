Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9AC2682E4D
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 14:47:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232277AbjAaNrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 08:47:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231891AbjAaNrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 08:47:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB332269F
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 05:47:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 806B6B81CD8
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 13:47:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11E33C433D2;
        Tue, 31 Jan 2023 13:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675172837;
        bh=bVqXna5WxCsAHx/u/2x8IFda69mGhWNfyQf/4SSeqFo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aLwUUOWzunX5b0iNH/5uYpBQudZqjaFb+2mf1Ru3dqDsNAz0NOHpCMRBsw6S9TK8E
         itS0ih2Yvy91YSkgtOlKPXaxPrHbIljz7H1tYZdFb5UTS8cChG4zr7knEDmrv4gTDh
         Yeq9YTSaxes/J1zV3nub/Q5DNnbbisNF0JcfJLtQ2dgNAsI1okA6QEcxLm9CYcqJZt
         ncm3oCg9LhYogbUz1kmm5kr2t2Ze9d+EOyGNtAowSM7nGS0wYFeLnr2cUcrz/aQuoU
         aZLr7TNlJRop61r8G9swwqUhHsXjoNSy06mmFMbIEp0L4jbkjMfsZunsSPxAaZbZj/
         6tZPpBFVa5NTg==
Date:   Tue, 31 Jan 2023 15:47:05 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Hyunmin Lee <hn.min.lee@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Christoph Hellwig <hch@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
        Jeungwoo Yoo <casionwoo@gmail.com>,
        Sangyun Kim <sangyun.kim@snu.ac.kr>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Subject: Re: [PATCH] replace BUG_ON to WARN_ON
Message-ID: <Y9kb2XUunZlgsu2z@kernel.org>
References: <20230127115844.GA1124261@min-iamroot>
 <Y9eYbPuq5Nw9Njxf@kernel.org>
 <20230131105629.GA1195431@min-iamroot>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230131105629.GA1195431@min-iamroot>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2023 at 07:56:29PM +0900, Hyunmin Lee wrote:
> On Mon, Jan 30, 2023 at 12:14:04PM +0200, Mike Rapoport wrote:
> > Hi,
> > 
> > On Fri, Jan 27, 2023 at 08:58:44PM +0900, Hyunmin Lee wrote:
> > > Replace unnacessary BUG_ON to WARN_ON. These BUG_ONs verify aruguments of a function. Thus, the WARN_ONs return an EINVAL error when their condition is true.
> > 
> > Some users enable panic_on_warn, so for them WARN_ON will still crash a
> > machine.
> > 
> > I think a simple if() will be sufficient.
> >  
> Hi Mike,
> 
> Thank you for your advice.
> Would you please give feedback about the below opinion?
> - Printing warning messages is helpful to inform what happened in the system to the users.
> - When a simple if() is used instead of WARN_ON, the if() should print a warning message.
> - The condition of the simple if() should also have unlikely() for optimization of system performance.
> - WARN_ON is a macro doing like thoes easily. It has a notifying function and unlikely optimization.
> - Eventhough WARN_ON will still crash like BUG_ON by some users who enable panic_on_warn, it is their intention. They should accept the crash by WARN_ON.
> - Therefore, using WARN_ON looks like natural and efficient.

As this is a validation of the function parameters, there is no need in
warning messages and if(unlikely()) will do. There is really no point in
WARN_ON() for something that's totally recoverable and very unlikely to
happen.
 
> Best,
> Hyunmin

-- 
Sincerely yours,
Mike.
