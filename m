Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28DF272FC54
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 13:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243829AbjFNL1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 07:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234949AbjFNL1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 07:27:12 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 462F59C;
        Wed, 14 Jun 2023 04:27:11 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 560E11FDE8;
        Wed, 14 Jun 2023 11:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1686742029; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3zCkFcuH5V3+ixyNrEx+x4s202aKT5K0biw4wgrkN7c=;
        b=A1MGXFq6nMXpnW2Nosaw5wN6bmzdHfG2kqIoTnAL9ONeTvIMtfvmM90TI+ZW+POI86mRTr
        8ZzPhbfVueeIfKb096QSKytI+sTW4nL9EUJRrwdtWCCNA/pFma4OwcXJdF6CEjSytCXzvS
        P+uGCD2i9KXeLDJ5MG2N9n8OA4jlhTw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1686742029;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3zCkFcuH5V3+ixyNrEx+x4s202aKT5K0biw4wgrkN7c=;
        b=KO36a14+CsniCI/P9YQL2GDK52el3+x98Bduq6FFp8m9GYeBrNHYZ7r26C7zjYF58Zgdaw
        zvRsgyYDu2UVptBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 47CEF1357F;
        Wed, 14 Jun 2023 11:27:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id RJbOEA2kiWRXGgAAMHmgww
        (envelope-from <dwagner@suse.de>); Wed, 14 Jun 2023 11:27:09 +0000
Date:   Wed, 14 Jun 2023 13:27:08 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests v1] nvme/040: Free loop back resources
Message-ID: <pzgf2abc2piophrwt3m3elaeb3vrrgrvxyq437ytpmah6rnxf5@m4gfyw4bcmxo>
References: <20230612142945.10969-1-dwagner@suse.de>
 <bsbx3i3ut32zbatwrpn3t2vjbjdmttqul2jt7opd3s4mipo6pj@5ojtsv7aunbn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bsbx3i3ut32zbatwrpn3t2vjbjdmttqul2jt7opd3s4mipo6pj@5ojtsv7aunbn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2023 at 11:13:18AM +0000, Shinichiro Kawasaki wrote:
> On Jun 12, 2023 / 16:29, Daniel Wagner wrote:
> > The tests does not cleanup all resources after it has finished. This
> > leads to rm not being able to remove the TMPDIR cleanly:
> > 
> >   + rm -rf blktests/results/tmpdir.nvme.040.m2J
> >   rm: cannot remove 'blktests/results/tmpdir.nvme.040.m2J': Directory not empty
> > 
> > Signed-off-by: Daniel Wagner <dwagner@suse.de>
> 
> Hi Daniel, thanks for the patch. It looks good to me. Now the test case leaves a
> loop device. This patch avoids it. Good.
> 
> Question, I do not observe the rm command failure in my test environments. Do
> you have insight why you were able to find the failure?

I am running the tests inside a VM and I am sharing a part of my host filesystem
via NFS which contain the blktests. If I understood it correctly, the NFS server
is behaving slightly differently here. I can't observe it either with xfs or
btrfs.
