Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39F3B6F45F7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 16:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234399AbjEBOWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 10:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234105AbjEBOWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 10:22:46 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9887E10E9;
        Tue,  2 May 2023 07:22:45 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 390E51F8A6;
        Tue,  2 May 2023 14:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1683037364; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y6T6GuDQfJbO43/1w1VH6Uivf7Fp4Qwl962Lj1m6+Lo=;
        b=zgCrmh7GvS0UCf3/prJ/RboMX2Ki4PzsGnEyDNmlTehNdNLon7THEZKq5ISDaYttXVdHvn
        LSOzCGzD61p5zdqaDXeCQhaJNbVxKk+iiCTe10KcEQnHDXlYm4pRgHEnZnm2i7B6BFdbag
        tuJQLV7vBxGs3mDQXtCRIelkksRaA+U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1683037364;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y6T6GuDQfJbO43/1w1VH6Uivf7Fp4Qwl962Lj1m6+Lo=;
        b=Y6is8m8YF1YqTPPmsh9/sRZt7MNTOyZw+M4CQkHbxAjyznZhS70hG0YJfNYvBGP5ybSEj9
        7KR7fQ+ANb6bouBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2A935139C3;
        Tue,  2 May 2023 14:22:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Mk9eCrQcUWT6ewAAMHmgww
        (envelope-from <dwagner@suse.de>); Tue, 02 May 2023 14:22:44 +0000
Date:   Tue, 2 May 2023 16:22:43 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     Hannes Reinecke <hare@suse.de>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>
Subject: Re: [PATCH REPOST blktests v2 4/9] nvme: Use runtime fio background
 jobs
Message-ID: <cds6ccjotmwbwckpuhefedr3vizx4gkuqor5z4hhfodbj5hbwe@wb4tp2p7lk3b>
References: <20230421060505.10132-1-dwagner@suse.de>
 <20230421060505.10132-5-dwagner@suse.de>
 <72ecc5fc-0ff4-5592-3293-f4204633fc8e@suse.de>
 <4ckg7ymu73lfs7zlsby3com6k24qgovkaqky5jmgeoubs7azhh@jtvovyjluekv>
 <bnr5gwlxyfixvajlpzm75mfmizgvq4uibb2b4t5tqij3jmkqrl@ialjk5an7nla>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bnr5gwlxyfixvajlpzm75mfmizgvq4uibb2b4t5tqij3jmkqrl@ialjk5an7nla>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 28, 2023 at 04:29:57AM +0000, Shinichiro Kawasaki wrote:
> On Apr 21, 2023 / 08:57, Daniel Wagner wrote:
> > On Fri, Apr 21, 2023 at 08:29:22AM +0200, Hannes Reinecke wrote:
> >  > --- a/tests/nvme/040
> > > > +++ b/tests/nvme/040
> > > > @@ -38,7 +38,8 @@ test() {
> > > >   	# start fio job
> > > >   	echo "starting background fio"
> > > >   	_run_fio_rand_io --filename="/dev/${nvmedev}n1" --size=1g \
> > > > -		--group_reporting --ramp_time=5  &> /dev/null &
> > > > +		--group_reporting --ramp_time=5 \
> > > > +		--time_based --runtime=1m &> /dev/null &
> > > >   	sleep 5
> > > >   	# do reset/remove operation
> > > 
> > > Wouldn't it be better to let _run_fio_rand_io pick the correct size?
> > 
> > Yes, makes sense.
> 
> If you do I/O size change for the test cases nvme/032 and nvme/040, could you
> confirm the runtime reduction of the test cases? IIUC, the fio process stops
> due to process kill or an I/O error, then I/O size reduction will not change
> runtime of the test cases, I guess.

The fio process doesn't survive the reset and the deletion of the controller.

> IMO, --time_based --runtime=1m is good to ensure that fio runs long enough,
> even when nvme device size is configured with small size.

I've updated the time to 'infinity' and added a 'kill $pid' after reset and
delete. Though the process should be gone till then but making the test a bit
more robust should hurt.
