Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 754DE6E8CCA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 10:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbjDTIbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 04:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233914AbjDTIbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 04:31:36 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E37653A9B;
        Thu, 20 Apr 2023 01:31:32 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 73805219E7;
        Thu, 20 Apr 2023 08:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1681979491; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Yd855QufpSTndikkrlPcwAwqjiD7xx7jVIQwBoEWpJs=;
        b=1APtTs9B9/M72KN0K8QiDSwnotsp81/ODC431BLOoGUmvAL29PhNqeM1jlXC+RMrKPMDKg
        PTgBeRxWhbKuPVR8NfntkHbmyC6QUUeOWq0lzYY7bEnKRxk+EuP5qm0V/rO4yhjX7zoUvq
        b4/ynx0zTWNTjY80f1tbgWxSn4XjpbY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1681979491;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Yd855QufpSTndikkrlPcwAwqjiD7xx7jVIQwBoEWpJs=;
        b=ED6M1Uv2SyEnsPleNx2Aopaqz886wN/ApXoQVa5+0q9WNIuXpIQjyAfHFPOwfknJEs3dyw
        j32eGem0814HKACQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 60C3F1333C;
        Thu, 20 Apr 2023 08:31:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 16KWF2P4QGSIcAAAMHmgww
        (envelope-from <dwagner@suse.de>); Thu, 20 Apr 2023 08:31:31 +0000
Date:   Thu, 20 Apr 2023 10:31:30 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc:     Sagi Grimberg <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>
Subject: Re: [RFC v1 0/1] nvme testsuite runtime optimization
Message-ID: <xhnr5dhpjqh5ynhqkcwn5ohfjvzlaw7chmuqicp7oqdd76ixxz@uzsozlvenedd>
References: <20230419085643.25714-1-dwagner@suse.de>
 <f0d2ddd5-37d6-8fba-a5e3-965fb9f41474@nvidia.com>
 <9a1f1709-baaf-5661-2cbf-c34e2da9e42e@grimberg.me>
 <27235520-2e63-2891-fd0a-ff758f18032e@nvidia.com>
 <qflkb4gu5lz5wx2oka5ceclj7ez5ic5oyofd3tzyjapjyrorlk@e7kkpa6bxwun>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <qflkb4gu5lz5wx2oka5ceclj7ez5ic5oyofd3tzyjapjyrorlk@e7kkpa6bxwun>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 20, 2023 at 10:24:15AM +0200, Daniel Wagner wrote:
> On Wed, Apr 19, 2023 at 09:11:33PM +0000, Chaitanya Kulkarni wrote:
> > >> Those jobs are meant to be run for at least 1G to establish
> > >> confidence on the data set and the system under test since SSDs
> > >> are in TBs nowadays and we don't even get anywhere close to that,
> > >> with your suggestion we are going even lower ...
> > >
> > > Where does the 1G boundary coming from?
> > >
> >
> > I wrote these testcases 3 times, initially they were the part of
> > nvme-cli tests7-8 years ago, then nvmftests 7-6 years ago, then they
> > moved to blktests.
> > 
> > In that time some of the testcases would not fail on with small size
> > such as less than 512MB especially with verification but they were
> > in the errors with 1G Hence I kept to be 1G.
> > 
> > Now I don't remember why I didn't use bigger size than 1G
> > should have documented that somewhere ...
> 
> Can you remember why you chosed to set the image size to 1G and the io size for
> fio to 950m in nvme/012 and nvme/013?

forget it, found a commit message which explains it

e5bd71872b3b ("nvme/012,013,035: change fio I/O size and move size definition place")
  [...]
  Change fio I/O size of nvme/012,013,035 from 950m to 900m, since recent change
  increased the xfs log size and it caused fio failure with I/O size 950m.
