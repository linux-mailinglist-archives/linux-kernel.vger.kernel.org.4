Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDD975F4E07
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 05:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbiJEDOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 23:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiJEDOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 23:14:06 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C4165696D7;
        Tue,  4 Oct 2022 20:14:02 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 2953DaIv003171;
        Wed, 5 Oct 2022 05:13:36 +0200
Date:   Wed, 5 Oct 2022 05:13:36 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Stephen Zhang <starzhangzsd@gmail.com>,
        Dave Chinner <david@fromorbit.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-xfs@vger.kernel.org, Shida Zhang <zhangshida@kylinos.cn>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the xfs tree
Message-ID: <20221005031336.GA3161@1wt.eu>
References: <20221004072302.345bfd4a@canb.auug.org.au>
 <20221003222103.GM3600936@dread.disaster.area>
 <20221004225012.501e11ed@canb.auug.org.au>
 <YzxX7ks+YD7U1dcl@magnolia>
 <20221004210400.GO3600936@dread.disaster.area>
 <CANubcdV462CTQQsmkaPG-dP1Cgy6BqHKj-gXZzh=U=pH+i7dfg@mail.gmail.com>
 <YzzzhsZQ4qlDrcFW@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzzzhsZQ4qlDrcFW@magnolia>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 04, 2022 at 08:01:26PM -0700, Darrick J. Wong wrote:
> I think Dave means something like this patch of mine:
> https://lore.kernel.org/linux-xfs/166473478893.1083155.2555785331844801316.stgit@magnolia/T/#u
> 
> From:   "Darrick J. Wong" <djwong@kernel.org>
> To:     djwong@kernel.org
> Cc:     linux-xfs@vger.kernel.org
> Date:   Sun, 02 Oct 2022 11:19:48 -0700
> Subject: [PATCH 3/4] xfs: set the buffer type after holding the AG[IF] across trans_roll
> 
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Currently, the only way to lock an allocation group is to hold the AGI
> and AGF buffers.  If repair needs to roll the transaction while
> repairing some AG metadata, it maintains that lock by holding the two
> buffers across the transaction roll and joins them afterwards.
> 
> However, repair is not the same as the other parts of XFS that employ
> this bhold/bjoin sequence, because it's possible that the AGI or AGF
> buffers are not actually dirty before the roll.  In this case, the
> buffer log item can detach from the buffer, which means that we have to
> re-set the buffer type in the bli after joining the buffer to the new
> transaction so that log recovery will know what to do if the fs fails.
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---
> 
> Notice how after the Subject: there is a blank line (which terminates
> the headers) followed by a new From: line in the body?  And the
> name/email in that second From: line matches the SOB later on?

Or maybe we could have a new option to git-am to always use the first
SOB as the From when there's no other explicit From in the message, so
that we never care about the From used to send the e-mail ? That would
also implicitly perform a requirement that an SOB necessarily exists.

Willy
