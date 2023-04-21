Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E62276EA427
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 08:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbjDUGyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 02:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjDUGyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 02:54:45 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F578EA;
        Thu, 20 Apr 2023 23:54:44 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1AFA721A32;
        Fri, 21 Apr 2023 06:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1682060083; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3hdtJCdV4hUpc6gHqFh0/2IfdOW4eHyRTAp7Qb3jl5k=;
        b=EGV+wfOgweTtILWDEVpszyk0KAX2oVgcuANPxAQv/kPcHsakeWVMVfsRJzSYCHs/S4mef/
        x4wEE8DemnwzYTyzRovVlyvmjvc9VJG/7CosIy1PEateonPzvsF9FjoNLFBm8QAPFfOjBv
        5i6VFSqcQat2+v7K7aVLKtY0MrtIlnc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1682060083;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3hdtJCdV4hUpc6gHqFh0/2IfdOW4eHyRTAp7Qb3jl5k=;
        b=qsAcG2m6qDbLpy7hyoK8ri5Sv0mekZr93Xmyhn4tln3Oc3L1Zxkras32rPKr8tKS9bqkzX
        vxxXjvxj2fWkKtAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0BC7813456;
        Fri, 21 Apr 2023 06:54:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Uzy1AjMzQmSifAAAMHmgww
        (envelope-from <dwagner@suse.de>); Fri, 21 Apr 2023 06:54:43 +0000
Date:   Fri, 21 Apr 2023 08:54:42 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Hannes Reinecke <hare@suse.de>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>
Subject: Re: [PATCH REPOST blktests v2 3/9] common-xfs: Make size argument
 optional for _xfs_run_fio_verify_io
Message-ID: <s4xicrnevbwapdwvw5wl2z4bpm6vv6q62lcgimy6wcqnbf6tbo@u7alfvt4bmen>
References: <20230421060505.10132-1-dwagner@suse.de>
 <20230421060505.10132-4-dwagner@suse.de>
 <1089a043-a40c-6b49-f0a0-38ca3bcd8f91@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1089a043-a40c-6b49-f0a0-38ca3bcd8f91@suse.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 21, 2023 at 08:27:35AM +0200, Hannes Reinecke wrote:
> On 4/21/23 08:04, Daniel Wagner wrote:
> > Make the size argument optional by reading the filesystem info. The
> > caller doesn't have to guess (or calculate) how big the max IO size.
> > The log data structure of XFS is reducing the capacity.
> > 
> > Signed-off-by: Daniel Wagner <dwagner@suse.de>
> > ---
> >   common/xfs     | 6 ++++++
> >   tests/nvme/012 | 2 +-
> >   tests/nvme/013 | 2 +-
> >   tests/nvme/035 | 2 +-
> >   4 files changed, 9 insertions(+), 3 deletions(-)
> > 
> > diff --git a/common/xfs b/common/xfs
> > index 2c5d96164ac1..ec35599e017b 100644
> > --- a/common/xfs
> > +++ b/common/xfs
> > @@ -27,6 +27,12 @@ _xfs_run_fio_verify_io() {
> >   	_xfs_mkfs_and_mount "${bdev}" "${mount_dir}" >> "${FULL}" 2>&1
> > +	if [[ -z "${sz}" ]]; then
> > +		local avail
> > +		avail="$(df --output=avail "${mount_dir}" | awk 'NR==2 {print $1}')"
> 
> df --output=avail "${mount_dir}" | tail -1

Sure, don't think it matters.

> > +		sz="$(printf "%d" $((avail / 1024 - 1 )))m"
> 
> sz=$((avail / 1024 - 1))

I tried this but the devision is likely to return a floating point which fio
doesn't like. Is there a way to tell bash to do a pure integer devision?
