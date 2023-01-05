Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69C5065E39E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 04:39:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbjAEDjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 22:39:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbjAEDiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 22:38:52 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89EB14435D;
        Wed,  4 Jan 2023 19:38:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YqPisRF28grnN/sJc4GxvrRkcWqbtbmvHuhEku3fmYo=; b=RZ70p08k3wsvLIF6z2Joj+XcQA
        tD5ChVuEkzksHah9jGFh+GDOfKSTc0yixT5TF52UqmFeQ4cIM1EM0icLpb0RzichaaRjH+shg9FH2
        WS0kBvh+dqEPFyHDIcSZ+LJCd6JKgMAZBGhPSr08XACr/mC2Wh/kDVLIhXJ48Sb9g8nRZnpzCjViA
        BIaO8VdjHbn1i/1lyCCJcnhw1yLtfY0f6uLwP4mn/S/dzWJEGeUpF+izxvxy9U5qnEXaerPfgPj0d
        uDnBDtcnyBDqZRMTnUJhk1WuJq7W3q2/V4nhKNrMIWCc8XxRtoSiWF/UZIoEItXEvk+af8thsGXL9
        kT18wDaA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pDH5b-00HPZf-1H;
        Thu, 05 Jan 2023 03:38:47 +0000
Date:   Thu, 5 Jan 2023 03:38:47 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Pengfei Xu <pengfei.xu@intel.com>
Cc:     heng.su@intel.com, linux-kernel@vger.kernel.org,
        davem@davemloft.net, jmaloy@redhat.com, kuba@kernel.org,
        linux-scsi@vger.kernel.org, linux-block@vger.kernel.org
Subject: [Q] is the amount of residual bytes still not guaranteed for to be
 available for some old SCSI drivers? (was Re: Update bisect info and new
 repro code for "[syzbot] WARNING in _copy_from_iter")
Message-ID: <Y7ZGRy4C4MMeWIwA@ZenIV>
References: <Y65N3pgLMsxZ99lo@xpf.sh.intel.com>
 <Y7YsWvQaDPm2+pS3@xpf.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7YsWvQaDPm2+pS3@xpf.sh.intel.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2023 at 09:48:10AM +0800, Pengfei Xu wrote:
> Hi Viro,
> 
> It's a soft remind: "_copy_from_iter" WARNING issue was still reproduced
> in v6.2-rc2 mainline kernel in guest.

sorry, had been sick ;-/

I see what's going on there; it's this bit:

        if ((iov_iter_rw(iter) == WRITE &&
             (!map_data || !map_data->null_mapped)) ||  
            (map_data && map_data->from_user)) {
                ret = bio_copy_from_iter(bio, iter);   
                if (ret)
                        goto cleanup;

The "map_data && map_data->from_user" part is what I'd missed.
Mea culpa.

That code really is reading from destination here; in a lot of
respects that's broken (consider the case when destination is
mapped write-only), but it's a deliberate behaviour.

Origin is in commit ecb554a846f8 "block: fix sg SG_DXFER_TO_FROM_DEV
regression".  Before trying to kludge around that, how much of the
original problem is still there?

Are there still low-level drivers that don't bother with scsi_set_resid()
for passthrough requests?  IOW, do we need to play with
	copy the entire destination into kernel buffer
	handle REQ_OP_DRV_IN request, overwriting the copy
	copy the entire buffer back to destination
all because we can't tell how much data had been copied in?
Because if we had the length of that sucker in sg_rq_end_io(),
we could just arrange for bio->bmd->iter truncated to actual
amount read and that would be it.

NOTE: no other users of blk_rq_map_user_io() go anywhere near that
weirdness; it's really just /dev/sg*.

If we that's approach is not feasible, we can always deal with
that in bio_copy_from_iter() - forcibly flip ->data_source for the
duration, which is OK for all kinds of iov_iter that can reach that
thing; it would work, but that's really ugly ;-/  If there's really
no way to get the amount of data actually transferred, that's what
we'll have to do, but it would be much saner to avoid the entire
song and dance and just copy the right amount out...
