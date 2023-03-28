Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A7376CB38D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 04:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232511AbjC1CDy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 22:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjC1CDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 22:03:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C50EC2706;
        Mon, 27 Mar 2023 19:03:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 93BCBB8172C;
        Tue, 28 Mar 2023 02:03:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C072C4339C;
        Tue, 28 Mar 2023 02:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679969023;
        bh=rDGD6nXzD31aEJ2frSrLKNBg7SisZInufjue0FyMu04=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=paZwrCfyISP0Ppx1W9FYJ/00UCK474Yg7feY1babWAjmhlTXlEqXC0F8q+GomVlBw
         gipCsKaCqun50XoccNJEGF94paMEkqdAl02MVtYzmfwne5lGKvNRxPQ4SzmsTWSMbX
         9AZXFedqhEte0rnloOgoDoB88JgAogAU5BMWePua1roYZ591ws2Lk2nM2dXuQozfX7
         Az3FaJj4bPeOWM54q564hM6Sg57pBaFKD0sJAyD5oDKgEnAfSspinx099T0iaFSCfc
         KVRlepkDvaCoryCH/rQA/0Qx53FMJRlQ8BdfQbMc9nghMniVa91HLqityAQZlzcZva
         O/CCxLAp8JO9g==
Date:   Mon, 27 Mar 2023 19:03:41 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "yebin (H)" <yebin10@huawei.com>, Ye Bin <yebin@huaweicloud.com>,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xfs: fix BUG_ON in xfs_getbmap()
Message-ID: <20230328020341.GH16180@frogsfrogsfrogs>
References: <20230327140218.4154709-1-yebin@huaweicloud.com>
 <20230327151524.GC16180@frogsfrogsfrogs>
 <64224406.5090106@huawei.com>
 <20230328014328.GG16180@frogsfrogsfrogs>
 <ZCJHSsqk4SJEDOTC@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCJHSsqk4SJEDOTC@infradead.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 06:47:54PM -0700, Christoph Hellwig wrote:
> On Mon, Mar 27, 2023 at 06:43:28PM -0700, Darrick J. Wong wrote:
> > <shrug> Seeing as the data fork mappings can change the instant the
> > ILOCK drops, I'm not /that/ worried about users seeing a delalloc
> > mapping even if the user requested a flush.  The results are already
> > obsolete when they get to userspace, unless the application software has
> > found another means to lock out access to the file.
> 
> That is true, but then again the users asked to not see delalloc
> mappings, so we really shouldn't report one, right?

Yeah, I suppose so.  I wonder how many programs there are out there that
don't pass in BMV_IF_DELALLOC /and/ can't handle that?  But I suppose
taking MMAP_EXCL is good enough to shut up the obvious assertion vector.

The COW implementation probably ought to be doing the flush too.

--D
