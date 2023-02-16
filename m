Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7AE769989C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 16:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbjBPPTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 10:19:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjBPPTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 10:19:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E50535BA3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 07:19:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2925561852
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 15:19:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0519BC433D2;
        Thu, 16 Feb 2023 15:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676560760;
        bh=aUBobFomaZu++V/z3TN862RlF8Gpj5REZIykBITcL58=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NqBVA10AXCjsux3YIwa2fodrNJHeOuFYmSuNljY3SNd0nn7UPAMH7WXZmWN8rPgyh
         JKMBhblQLDcgQczf8qSepkGW7aAmEdyUDfCwLLAgYAbnaVF6eklPJgf/cZNK+StFJ+
         lcJZ8owTQC8FANEBXHMRE2A8Zv0hIX9+ACdTnoCzQNQ+N4KQ9DjYHOg1ZPOynkkDKV
         A0OBs0D3vaPCiU2iZCarZtMrdCKZ4/sdbGousJ+tbZfxfySpDh9Xo5v+o1Q3fq7cIL
         y1oMZBxYj7qSfDjSTAg9ICD7wWN9DzyUqg9Nnq1/6NaXysAVbjWYfDQCA0Ot8u8Cv8
         IW1C31J5vXr1g==
Date:   Thu, 16 Feb 2023 08:19:17 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, michallinuxstuff@gmail.com
Subject: Re: [regression] Bug 217037 - cmb attributes missing from the nvme
 class under sysfs
Message-ID: <Y+5JdR02tlzD/TFS@kbusch-mbp>
References: <52f9afe2-f621-77d8-9d10-449d539e901d@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52f9afe2-f621-77d8-9d10-449d539e901d@leemhuis.info>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2023 at 10:28:55AM +0100, Linux regression tracking (Thorsten Leemhuis) wrote:
> Hi, this is your Linux kernel regression tracker.
> 
> I noticed a regression report in bugzilla.kernel.org. As many (most?)
> kernel developer don't keep an eye on it, I decided to forward it by
> mail. Quoting from https://bugzilla.kernel.org/show_bug.cgi?id=217037 :
> 
> >  michallinuxstuff@gmail.com 2023-02-14 14:16:26 UTC
> > 
> > For the CMB-capable nvme ctrls, kernel was exposing couple of related attributes under the sysfs. E.g.
> > 
> > 
> > # grep . /sys/class/nvme/nvme0/cmb*
> > /sys/class/nvme/nvme0/cmb:cmbloc : x00000062
> > /sys/class/nvme/nvme0/cmb:cmbsz  : x0008021d
> > /sys/class/nvme/nvme0/cmbloc:98
> > /sys/class/nvme/nvme0/cmbsz:524829

The breakage is that the attributes are decided before we've setup the cmb
regions. I'll send a fix shortly.
