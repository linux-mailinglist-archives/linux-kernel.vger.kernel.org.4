Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CECB6F4846
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 18:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233987AbjEBQ0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 12:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233992AbjEBQ0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 12:26:01 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7F49E45;
        Tue,  2 May 2023 09:25:59 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 651991FD81;
        Tue,  2 May 2023 16:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1683044758; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Vb0KgKixe92s8BQWHemnh1NGhiatOTvEhvbYfP3HRkQ=;
        b=MXrHN+ce07FTeyxXglGyD//OK1qa1dBWw51d02TISaosK3NzQGXwiOzCr58kQ7R0pQ7iOo
        wXspw/vZGdkdImkA9gZOZvPX4DYvH0VQyvO+kip/KyRuuOaLNnMzG9kjyjY4JpEvnl1up/
        bgGcpARDwBd+kCG+la0010xN2xnasbU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1683044758;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Vb0KgKixe92s8BQWHemnh1NGhiatOTvEhvbYfP3HRkQ=;
        b=X8xiyT4DM4Fd3D2yMTjRY+IMI/To176f3KySmAywuLccMV9+k9HkeoVuNDsFxgAgTF6Cgf
        fjWqnZJM7Mx4ejDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 57055139C3;
        Tue,  2 May 2023 16:25:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8qcNFZY5UWReQAAAMHmgww
        (envelope-from <dwagner@suse.de>); Tue, 02 May 2023 16:25:58 +0000
Date:   Tue, 2 May 2023 18:25:57 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>
Subject: Re: [PATCH REPOST blktests v2 7/9] nvme-rc: Calculate IO size for
 fio jobs
Message-ID: <tl2sdficjgijtdqojuvqz4rwv6afelne6nndycqggob33vsejl@7saidsxqclfv>
References: <20230421060505.10132-1-dwagner@suse.de>
 <20230421060505.10132-8-dwagner@suse.de>
 <sbkboyc3tcad4g5zjdtko6ardhythnaotwp3njchbotnabhlun@mhhvxut6q2av>
 <k54c3p47ot3aj7srqyx5ayrjawmdqj47hvtwcxyps67gfq533b@ftj2ugr4lalm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <k54c3p47ot3aj7srqyx5ayrjawmdqj47hvtwcxyps67gfq533b@ftj2ugr4lalm>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 02, 2023 at 05:45:46PM +0200, Daniel Wagner wrote:
> On Fri, Apr 28, 2023 at 04:00:54AM +0000, Shinichiro Kawasaki wrote:
> > On Apr 21, 2023 / 08:05, Daniel Wagner wrote:
> > > Introduce two new function to calculate the IO size for fio jobs.
> > > 
> > > _nvme_calc_io_size() returns the jobs size for _run_fio_verify_io()
> > > function. Reduce the max size of the job by one megabyte to make the
> > > test more robust not to run out of space by accident. Note these fio
> > > calls run with just one jobs.
> > 
> > It is not clear for me what kind of issue happens without the 1MB decrement.
> > Could you share failure symptoms you observed?
> 
> As I said, this is just to make the test more robust as this the size limits
> are not the main objective of these tests. I don't care about this too
> much, I'll just drop it then.

BTW, this is how it would look like if the disk is too small:

nvme/035 => nvme0n1 (run mkfs and data verification fio job on an NVMeOF passthru controller) [failed]
    runtime  2.383s  ...  51.954s
    --- tests/nvme/035.out      2023-04-18 17:43:18.163745956 +0200
    +++ /home/wagi/work/blktests/results/nvme0n1/nvme/035.out.bad       2023-05-02 18:21:09.442382196 +0200
    @@ -1,3 +1,20 @@
     Running nvme/035
    +fio: io_u error on file /mnt/blktests//verify.0.0: No space left on device: write offset=925274112, buflen=4096
    +fio: io_u error on file /mnt/blktests//verify.0.0: No space left on device: write offset=406040576, buflen=4096
    +fio: io_u error on file /mnt/blktests//verify.0.0: No space left on device: write offset=498868224, buflen=4096
    +fio: io_u error on file /mnt/blktests//verify.0.0: No space left on device: write offset=217063424, buflen=4096
    +fio: io_u error on file /mnt/blktests//verify.0.0: No space left on device: write offset=1049411584, buflen=4096
    +fio: io_u error on file /mnt/blktests//verify.0.0: No space left on device: write offset=348282880, buflen=4096
    ...
    (Run 'diff -u tests/nvme/035.out /home/wagi/work/blktests/results/nvme0n1/nvme/035.out.bad' to see the entire diff)
