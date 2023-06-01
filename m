Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5EF7195F2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 10:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232392AbjFAIrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 04:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232408AbjFAIqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 04:46:32 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D13125;
        Thu,  1 Jun 2023 01:46:23 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 64F8021963;
        Thu,  1 Jun 2023 08:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1685609182; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vAUgWsWihuICZ0W/UHSMFcstti8PKzf4LJWc1QG6u2I=;
        b=Fa6Qp9M8zkX8d7ViVbC6opC2XtnbX39SZk/kNLTkrVEKBIvWzZuQHeeRTPijl8pZEp3fUl
        82xm7rAso6+apMtekNKKezo4WDOUXZhKSHIVZ16ZVQD82pkHk8iCP0gmorP2g59DwkzKej
        MPIYyh6uoP6qsDpQiFwl0QC3x59EIfg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1685609182;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vAUgWsWihuICZ0W/UHSMFcstti8PKzf4LJWc1QG6u2I=;
        b=uUDkFIs9oiv6jts0Ve9FGf6E+UQ0WotOeoShTGbXJZSLgTyrbnGJipM5JDj/pkVLnhRziQ
        r7cbmH8pvsaG7kCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5620613441;
        Thu,  1 Jun 2023 08:46:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 84nDFN5aeGThDgAAMHmgww
        (envelope-from <dwagner@suse.de>); Thu, 01 Jun 2023 08:46:22 +0000
Date:   Thu, 1 Jun 2023 10:46:21 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests v4 09/11] nvme{045,047}: Calculate IO size for
 random fio jobs
Message-ID: <wcbwh4ju5c5chtxyuekffwn3uvjnlqy2fanltr6d7x34lgbrfc@nluc3kfnwych>
References: <20230511140953.17609-1-dwagner@suse.de>
 <20230511140953.17609-10-dwagner@suse.de>
 <c5c2af7c-2b63-f30d-f568-c136dd6f6c5c@nvidia.com>
 <5duh22ydzwth2z2sd4oo22cuaqlazxq3u5m7vo5qfkp4fgec7w@elzdr6vbksgv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5duh22ydzwth2z2sd4oo22cuaqlazxq3u5m7vo5qfkp4fgec7w@elzdr6vbksgv>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for the late response, had to deal with a lot of high prio stuff...

On Fri, May 19, 2023 at 01:36:17AM +0000, Shinichiro Kawasaki wrote:
> On May 17, 2023 / 04:44, Chaitanya Kulkarni wrote:
> > On 5/11/23 07:09, Daniel Wagner wrote:
> > > _nvme_calc_run_io_size() returns the jobs size for _run_fio_rand_io()
> > > function. The jobs size is the size per job, thus we have to divide
> > > through the number of CPUs.
> > 
> > sorry I didn't understand why we have to divide through number of
> > CPUs ? isn't tht will change the current job size of the test ?
> > 
> > unless we are increasing somewhere which I missed it .
> 
> This change reduces the I/O size per job, but it keeps the total I/O size
> regardless of the number of CPUs. This will keep test case runtime reasonable
> on systems with hundreds of CPUs.

Yes, indeed.

> As for the test case nvme/045, it tests re-authentication. I don't think it
> requires total I/O size proportional to number of CPUs. As for the test case
> nvme/047, it exercises different queue types (write queue and poll queue). Does
> it require total I/O size proportional to number of CPUs? Daniel is the test
> case author, and I guessed he is ok with the change.

Yes :)

Thanks for applying these patches!
