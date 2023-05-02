Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0736F478C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 17:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234520AbjEBPpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 11:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234478AbjEBPpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 11:45:49 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB1361FDE;
        Tue,  2 May 2023 08:45:47 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 83EF821E93;
        Tue,  2 May 2023 15:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1683042346; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zzvrkLFUqS2KJrgKqehrc7ERzU4TMOgKTj4HGDnNT6c=;
        b=UmPhlf/6SiPXX+aNo/xbG/8SpZllfgqTXCJtpILFaLqVwUCURgsuikh7kqBkl9PMKK6rAp
        RhEF6m+UgU9o1HpN9h1qhB30OqUKzPLJHsGxwB83EYdlmA1STRQBxAZTup5ph1j2GOrCCt
        KsOLOKNYB9R2qTkN5MJp+4s7KedkoG0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1683042346;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zzvrkLFUqS2KJrgKqehrc7ERzU4TMOgKTj4HGDnNT6c=;
        b=/CJf0S3GhgGqiIpNTqHVMxH7v3jQnPM5+WZ4Sa4tmUm2aYy1NTte5D0593rMCkn8YYXfvF
        ce5/Ae/fpR5+v+CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 77097134FB;
        Tue,  2 May 2023 15:45:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Y1jmHCowUWSvKgAAMHmgww
        (envelope-from <dwagner@suse.de>); Tue, 02 May 2023 15:45:46 +0000
Date:   Tue, 2 May 2023 17:45:45 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>
Subject: Re: [PATCH REPOST blktests v2 7/9] nvme-rc: Calculate IO size for
 fio jobs
Message-ID: <k54c3p47ot3aj7srqyx5ayrjawmdqj47hvtwcxyps67gfq533b@ftj2ugr4lalm>
References: <20230421060505.10132-1-dwagner@suse.de>
 <20230421060505.10132-8-dwagner@suse.de>
 <sbkboyc3tcad4g5zjdtko6ardhythnaotwp3njchbotnabhlun@mhhvxut6q2av>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <sbkboyc3tcad4g5zjdtko6ardhythnaotwp3njchbotnabhlun@mhhvxut6q2av>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 28, 2023 at 04:00:54AM +0000, Shinichiro Kawasaki wrote:
> On Apr 21, 2023 / 08:05, Daniel Wagner wrote:
> > Introduce two new function to calculate the IO size for fio jobs.
> > 
> > _nvme_calc_io_size() returns the jobs size for _run_fio_verify_io()
> > function. Reduce the max size of the job by one megabyte to make the
> > test more robust not to run out of space by accident. Note these fio
> > calls run with just one jobs.
> 
> It is not clear for me what kind of issue happens without the 1MB decrement.
> Could you share failure symptoms you observed?

As I said, this is just to make the test more robust as this the size limits
are not the main objective of these tests. I don't care about this too
much, I'll just drop it then.
