Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D1CB6F5192
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 09:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbjECHbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 03:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjECHbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 03:31:01 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8ABF4C0B;
        Wed,  3 May 2023 00:29:54 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7E760223CE;
        Wed,  3 May 2023 07:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1683098986; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=P7KFfZgfUOGCrZjJOU3dZ6YY+ZZX/Sqbf17UCyuAZPA=;
        b=pDL9w7lL01OOZBiHOzlVkR+tqWpgSXZzyxQQU52B08+zukoCgwIlOZtFwYltYfCXR85jr1
        8sl1afPq5eGEAfbCF8R+IjklsQwbtnEJ8JZTAFQ2XEcVRDFfdjzmJfDQMhHR+91u9bp6v7
        MTmqZPrAQvgATsqPC48ucKbcubYeQ8U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1683098986;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=P7KFfZgfUOGCrZjJOU3dZ6YY+ZZX/Sqbf17UCyuAZPA=;
        b=oTuyHFxgFqQu/dkYaNqPqKL156YfwEo6K2Ca0Phs3du/8EOmuY2i5jDFGizBU+yi5R9/rF
        BvcKKMlPYFpXqFBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 706091331F;
        Wed,  3 May 2023 07:29:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8OZiG2oNUmQ8TwAAMHmgww
        (envelope-from <dwagner@suse.de>); Wed, 03 May 2023 07:29:46 +0000
Date:   Wed, 3 May 2023 09:29:45 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>
Subject: Re: [PATCH REPOST blktests v2 3/9] common-xfs: Make size argument
 optional for _xfs_run_fio_verify_io
Message-ID: <rjzhz2pa5cjdeeubeo36d7lskhwcyfla6dszrhlwlmlxrek7vl@hsctyaj6ko4f>
References: <20230421060505.10132-1-dwagner@suse.de>
 <20230421060505.10132-4-dwagner@suse.de>
 <le6qqxhkbdaacsifz4b3mody53gllg4rzhowm2j62y56y56y6k@pmlukhvwjw24>
 <clh6gmnivvi5e4o7pzr3mxfale3vlymgepdntkjtvub4cazyvk@myovldb6bcnx>
 <i426otrfqbck2q5cwgzre52zsiaqviqz4jchszqmvbvgc64cue@a7d3frn6b64x>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <i426otrfqbck2q5cwgzre52zsiaqviqz4jchszqmvbvgc64cue@a7d3frn6b64x>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 03, 2023 at 04:04:50AM +0000, Shinichiro Kawasaki wrote:
> On May 02, 2023 / 15:23, Daniel Wagner wrote:
> >  > --- a/tests/nvme/035
> > > > +++ b/tests/nvme/035
> > > > @@ -32,7 +32,7 @@ test_device() {
> > > >  	port=$(_nvmet_passthru_target_setup "${subsys}")
> > > >  	nsdev=$(_nvmet_passthru_target_connect "${nvme_trtype}" "${subsys}")
> > > >  
> > > > -	_xfs_run_fio_verify_io "${nsdev}" "900m"
> > > > +	_xfs_run_fio_verify_io "${nsdev}"
> > > 
> > > On the other hand, this change for nvme/035 does not look good. It runs the
> > > test on TEST_DEV, which may take very long time without TIMEOUT config.
> > 
> > I'll add the nvme_img_size argument here instead (nvme: Make test image size
> > configurable)
> 
> If TEST_DEV has the size same as nvme_img_size, xfs log data will consume some
> part of the TEST_DEV, then _xfs_run_fio_verify_io with nvme_img_size will fail.
> 
> I think the size argument of _xfs_run_fio_verify_io should be,
> 
>    min(size of TEST_DEV, nvm_img_size) - log data size of xfs
> 
> But I'm not sure if we can do this calculation correctly.
> 
> If the calculation is not possible, it would be the better to leave the hard
> coded constants (1GB for TEST_DEV size and 900mb as fio I/O size) in this test
> case, because nvme/035 is rather unique in the nvme group, which uses TEST_DEV.

I've solved this by extending _xfs_run_fio_verify_io() to limit the max size of
the io job:

_xfs_run_fio_verify_io() {
	local mount_dir="/mnt/blktests"
	local bdev=$1
	local sz=$2
	local sz_mb
	local avail
	local avail_mb

	_xfs_mkfs_and_mount "${bdev}" "${mount_dir}" >> "${FULL}" 2>&1

	avail="$(df --output=avail "${mount_dir}" | tail -1)"
	avail_mb="$((avail / 1024))"

	if [[ -z "${sz}" ]]; then
		sz_mb="${avail_mb}"
	else
		sz_mb="$(convert_to_mb "${sz}")"
		if [[ "${sz_mb}" -gt "${avail_mb}" ]]; then
			sz_mb="${avail_mb}"
		fi
	fi

	_run_fio_verify_io --size="${sz_mb}m" --directory="${mount_dir}/"

	umount "${mount_dir}" >> "${FULL}" 2>&1
	rm -fr "${mount_dir}"
}

Anyway, I'll send out the updated series shortly
