Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD616EA42F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 08:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbjDUG5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 02:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbjDUG5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 02:57:48 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E507DAF;
        Thu, 20 Apr 2023 23:57:45 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1688C1FDDC;
        Fri, 21 Apr 2023 06:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1682060264; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HxUKKIOGPl7o2Ksj+0VHAq6dun13rkhfrfvtHYNmQtc=;
        b=v6mz9MMie9djBV+bbusRwLIygoiB9KDAuM6Vr21UKpDrD+UMRSU9YcU/dNv52ZH0SrYG8c
        l/9n/KW6Z2al/j4HSxnhWAJ12bE3JGnpT4riMxBha/J4axcz1S0AlBzsyduM5pyhuuWuJp
        C/S5pQaDH7nbVzL+A0bdZHEfu9xVX+Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1682060264;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HxUKKIOGPl7o2Ksj+0VHAq6dun13rkhfrfvtHYNmQtc=;
        b=MqlTArYI6WN3lWuaDC+wZK1XuorzAqvJEvg0cUbM/MXxH3KZBbZ1N7iFzRacJMg2thU/LM
        6OleX8aXj2mjU8DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0792313456;
        Fri, 21 Apr 2023 06:57:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5v3lAegzQmQTfgAAMHmgww
        (envelope-from <dwagner@suse.de>); Fri, 21 Apr 2023 06:57:44 +0000
Date:   Fri, 21 Apr 2023 08:57:43 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Hannes Reinecke <hare@suse.de>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>
Subject: Re: [PATCH REPOST blktests v2 4/9] nvme: Use runtime fio background
 jobs
Message-ID: <4ckg7ymu73lfs7zlsby3com6k24qgovkaqky5jmgeoubs7azhh@jtvovyjluekv>
References: <20230421060505.10132-1-dwagner@suse.de>
 <20230421060505.10132-5-dwagner@suse.de>
 <72ecc5fc-0ff4-5592-3293-f4204633fc8e@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72ecc5fc-0ff4-5592-3293-f4204633fc8e@suse.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 21, 2023 at 08:29:22AM +0200, Hannes Reinecke wrote:
 > --- a/tests/nvme/040
> > +++ b/tests/nvme/040
> > @@ -38,7 +38,8 @@ test() {
> >   	# start fio job
> >   	echo "starting background fio"
> >   	_run_fio_rand_io --filename="/dev/${nvmedev}n1" --size=1g \
> > -		--group_reporting --ramp_time=5  &> /dev/null &
> > +		--group_reporting --ramp_time=5 \
> > +		--time_based --runtime=1m &> /dev/null &
> >   	sleep 5
> >   	# do reset/remove operation
> 
> Wouldn't it be better to let _run_fio_rand_io pick the correct size?

Yes, makes sense.
