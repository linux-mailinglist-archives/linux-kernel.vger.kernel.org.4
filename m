Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23C2D6C0247
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 15:12:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbjCSOL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 10:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbjCSOLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 10:11:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FBD01E9E4;
        Sun, 19 Mar 2023 07:11:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 01376B80B91;
        Sun, 19 Mar 2023 14:11:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FD5DC433EF;
        Sun, 19 Mar 2023 14:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679235109;
        bh=4Tn2Ss9phxopbxFgWMyA7uMu+W0oT/yoY9aVfnSNDaA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NMGREStkA3/9TXlwXEPTO8uO4UQBOtiRUE2xSxPulA02IVbv9hjf7q/JYEO7W2Yka
         OzgDsY6tVvKh5ZFco4r89eXsm/Ip6dogTNrpOad594tmLqdSs9FEu0YXqwSn98yifV
         A40ZeFjeZyZUt8rduS6/s9+AGj6KiwrgKqPWrZiWQwIXzFLJlV2wEbrhDFbtWc4v9E
         kCUq+KZfoTRMXVMD2gFWHtGOVeaQ7+gNjGL+0HQxRakeXtQVyjA/bFXLyzH5gWSz8R
         x/f0XXot9pD2Vm9BqegeaEz1ybj1agq9tGE3FmzV+fsiY06kwxgKFckMnwNuS5qed2
         ya090jvNppjUQ==
Date:   Sun, 19 Mar 2023 16:11:45 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     kernel-janitors@vger.kernel.org, linux-rdma@vger.kernel.org,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, cocci@inria.fr,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] RDMA/siw: Fix exception handling in siw_accept_newconn()
Message-ID: <20230319141145.GE36557@unreal>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <afe30fc6-04c9-528c-f84a-67902b5a6ed8@web.de>
 <20230319114048.GB36557@unreal>
 <1c06e86d-1468-c11a-8344-9563ad6047b5@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1c06e86d-1468-c11a-8344-9563ad6047b5@web.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 19, 2023 at 02:38:03PM +0100, Markus Elfring wrote:
> >> Date: Sat, 18 Mar 2023 20:30:12 +0100
> >>
> >> The label “error” was used to jump to another pointer check despite of
> >> the detail in the implementation of the function “siw_accept_newconn”
> >> that it was determined already that corresponding variables contained
> >> still null pointers.
> >>
> >> 1. Use more appropriate labels instead.
> >>
> >> 2. Delete two questionable checks.
> >>
> >> 3. Omit extra initialisations (for the variables “new_cep” and “new_s”)
> >>    which became unnecessary with this refactoring.
> >>
> >> This issue was detected by using the Coccinelle software.
> >>
> >> Fixes: 6c52fdc244b5ccc468006fd65a504d4ee33743c7 ("rdma/siw: connection management")
> >> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> >> ---
> >>  drivers/infiniband/sw/siw/siw_cm.c | 32 ++++++++++++++----------------
> >>  1 file changed, 15 insertions(+), 17 deletions(-)
> > Please read Documentation/process/submitting-patches.rst and resubmit.
> > Your patch is not valid.
> 
> 
> What do you find improvable here?

Did you read the guide above?

1. The patch is malformed and doesn't appear in lore and patchworks.
2. "Date ..." in the middle of patch
3. Wrong Fixes line.
4. Patch contains too much and too different things at the same time.

Thanks

> 
> Regards,
> Markus
> 
