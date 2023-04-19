Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F365B6E784B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 13:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232305AbjDSLNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 07:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233004AbjDSLNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 07:13:13 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCD8A146C1;
        Wed, 19 Apr 2023 04:12:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1B7D821996;
        Wed, 19 Apr 2023 11:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1681902653; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H0TQZIlSiUIAMArLDTJtF4bmMqFaEz7hFLHtBMFTIAw=;
        b=RDrPZ7T7dltq32OA62C7S6zsfLvhiouuuIeL+yxO88jbUmgI0+gtkMUBhlVVvlecs8OqWI
        b8etUN3s4oCcZULFDO5NTvgEWmRiSTZnT97Z/7HfBMy7bEdKY+2x8gTV+D3fRDGWb2QIH3
        ydRRUdA2i1T4LL6m8wuI/URN49nIce4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1681902653;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H0TQZIlSiUIAMArLDTJtF4bmMqFaEz7hFLHtBMFTIAw=;
        b=7Xi/x7w1wqWQhdAskPhzqt9RZ/JdoGktzYrMkA2OMN6cMPNeJ/kwll1v2VC8deZ8vZhVGp
        SxEpnZr5aQECcbBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 06E911390E;
        Wed, 19 Apr 2023 11:10:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Yz9xAT3MP2RIRQAAMHmgww
        (envelope-from <dwagner@suse.de>); Wed, 19 Apr 2023 11:10:53 +0000
Date:   Wed, 19 Apr 2023 13:10:52 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>
Subject: Re: [RFC v1 0/1] nvme testsuite runtime optimization
Message-ID: <zlavgcdalmmtabiabu76m4s3oo5hyaehckmwcxvqrnu3j6q6xo@5ke6gv5h3j7i>
References: <20230419085643.25714-1-dwagner@suse.de>
 <f0d2ddd5-37d6-8fba-a5e3-965fb9f41474@nvidia.com>
 <9a1f1709-baaf-5661-2cbf-c34e2da9e42e@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a1f1709-baaf-5661-2cbf-c34e2da9e42e@grimberg.me>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 19, 2023 at 12:50:10PM +0300, Sagi Grimberg wrote:
> 
> > > While testing the fc transport I got a bit tired of wait for the I/O jobs to
> > > finish. Thus here some runtime optimization.
> > > 
> > > With a small/slow VM I got following values:
> > > 
> > > with 'optimizations'
> > >     loop:
> > >       real    4m43.981s
> > >       user    0m17.754s
> > >       sys     2m6.249s
> 
> How come loop is doubling the time with this patch?
> ratio is not the same before and after.

first run was with loop, second one with rdma:

nvme/002 (create many subsystems and test discovery)         [not run]
    runtime  82.089s  ...
    nvme_trtype=rdma is not supported in this test

nvme/016 (create/delete many NVMeOF block device-backed ns and test discovery) [not run]
    runtime  39.948s  ...
    nvme_trtype=rdma is not supported in this test
nvme/017 (create/delete many file-ns and test discovery)     [not run]
    runtime  40.237s  ...

nvme/047 (test different queue types for fabric transports)  [passed]
    runtime    ...  13.580s
nvme/048 (Test queue count changes on reconnect)             [passed]
    runtime    ...  6.287s

82 + 40 + 40 - 14 - 6 = 142. So loop runs additional tests. Hmm, though my
optimization didn't work there...

> > Those jobs are meant to be run for at least 1G to establish
> > confidence on the data set and the system under test since SSDs
> > are in TBs nowadays and we don't even get anywhere close to that,
> > with your suggestion we are going even lower ...
> 
> Where does the 1G boundary coming from?

No idea, it just the existing hard coded values. I guess it might be from
efa06fcf3c83 ("loop: test partition scanning") which was the first real test
case (according the logs).

> > we cannot change the dataset size for slow VMs, instead add
> > a command line argument and pass it to tests e.g.
> > nvme_verification_size=XXX similar to nvme_trtype but don't change
> > the default values which we have been testing for years now
> > 
> > Testing is supposed to be time consuming especially verification jobs..
> 
> I like the idea, but I think it may need to be the other way around.
> Have shortest possible runs by default.

Good point, I'll make it configurable. What is a good small default then? There
are some test cases in loop which allocated a 1M file. That's propably too
small.
