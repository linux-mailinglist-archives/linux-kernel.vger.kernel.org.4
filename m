Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5B016F54F9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 11:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbjECJmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 05:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbjECJma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 05:42:30 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDC7244B2;
        Wed,  3 May 2023 02:42:28 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 61AC0201CB;
        Wed,  3 May 2023 09:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1683106947; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Wuc1vTQ8wQRR6tjkgMtetfqYzZutfpJcCtXQCNyxPaE=;
        b=onzzM/v1oyKFB4FXmhHjMFCMfyCMsRPoN8kNryQXhOdlgGhF+7N7l93bcEVNHsoDxefF9t
        7lhSxjb+agVtwS0b+PBPmQNxbun2z2IzZu4y1LvLwHFf9qf8TW0n6sfpcUE+WtyTSMNG+G
        gs6QJhk4Grrkztl4tS0n8NiLwWIl1Q0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1683106947;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Wuc1vTQ8wQRR6tjkgMtetfqYzZutfpJcCtXQCNyxPaE=;
        b=BlObSjVxACe5A1daCOXZ1F33pExCCXIO/Pa5F8XFQ6vTAq64KzieqEx9wywLowDfSiLzW+
        c8gKFw4Fjt5kW/Bg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 53B021331F;
        Wed,  3 May 2023 09:42:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id hEARFIMsUmSaHAAAMHmgww
        (envelope-from <dwagner@suse.de>); Wed, 03 May 2023 09:42:27 +0000
Date:   Wed, 3 May 2023 11:42:26 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests v3 04/12] common/xfs: Limit fio size job to fit
 into xfs fs
Message-ID: <qv4br55wggqf46jomv7r7ern6e6s7kprqh65wtqvmcnvrlqvl2@kahiiqhulyan>
References: <20230503080258.14525-1-dwagner@suse.de>
 <20230503080258.14525-5-dwagner@suse.de>
 <74e9c631-23cd-705c-7043-88f345598ad1@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74e9c631-23cd-705c-7043-88f345598ad1@nvidia.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 03, 2023 at 09:29:04AM +0000, Chaitanya Kulkarni wrote:
> On 5/3/23 01:02, Daniel Wagner wrote:
> > The usable capacity of the filesystem is less than the raw
> > partition/device size due to the additional meta/log data.
> >
> > Ensure that the job size for fio is not exceeding the limits.
> >
> > Because we have hard coded the path where we mount the filesystem
> > and don't want to expose this, we just update max size inside
> > _xfs_run_fio_verify_io(). No need to leak this into the caller.
> >
> > Signed-off-by: Daniel Wagner <dwagner@suse.de>
> > ---
> >   common/xfs | 3 +++
> >   1 file changed, 3 insertions(+)
> >
> > diff --git a/common/xfs b/common/xfs
> > index 413c2820ffaf..37ce85878df2 100644
> > --- a/common/xfs
> > +++ b/common/xfs
> > @@ -37,6 +37,9 @@ _xfs_run_fio_verify_io() {
> >   		sz_mb="${avail_mb}"
> >   	else
> >   		sz_mb="$(convert_to_mb "${sz}")"
> > +		if [[ "${sz_mb}" -gt "${avail_mb}" ]]; then
> > +			sz_mb="${avail_mb}"
> > +		fi
> >   	fi
> >   
> >   	_run_fio_verify_io --size="${sz_mb}m" --directory="${mount_dir}/"
> 
> 
> this is exactly how it should to start with, the only
> is now we are silently reducing the fio job size maybe that is okay ?
> 
> or we should error out here instead of being smart ?

The problem I try to solve here is that on the caller side (nvme/035) we don't
know yet the usable filesystem size. We only the size of the nvme_img_size.

If we want to move this logic to the caller side we need split
_xfs_run_fio_verify_io() into steps. The first step which creates the fileystem
and the second one which runs fio.

I don't know if this is worth doing it though.
