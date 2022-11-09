Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97386622721
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 10:36:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbiKIJgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 04:36:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbiKIJf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 04:35:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 633D01571E
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 01:35:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0093361985
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 09:35:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E31F2C433C1;
        Wed,  9 Nov 2022 09:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1667986557;
        bh=Q2ePys0L2trmHLtGIxaetKWDh4ERTjs1MzoOIr2C+Cw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=py7ff6vkrVsx4kNKCQgDt7xxVGDJTAgwyxz8f4ZO7i0iOy+PKcCJ5K5wJYrCqF/5d
         +aHUnUGgqZD1BYPcZh8zOTL2WeDX7bFjp7l/GH6opH6V/QNENwLephX9Yb6fTRTQDR
         VLu84S3ZJziXN4UHpd3IrqWeYF3Nw6apC/IMOq7c=
Date:   Wed, 9 Nov 2022 10:35:54 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zheng Hacker <hackerzheng666@gmail.com>
Cc:     Zheng Wang <zyytlz.wz@163.com>, zhengyejian1@huawei.com,
        dimitri.sivanich@hpe.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org, alex000young@gmail.com,
        security@kernel.org, sivanich@hpe.com, lkp@intel.com
Subject: Re: [PATCH v6 RESEND] misc: sgi-gru: fix use-after-free error in
 gru_set_context_option, gru_fault and gru_handle_user_call_os
Message-ID: <Y2t0euEvZYQoCW42@kroah.com>
References: <20221109084142.226960-1-zyytlz.wz@163.com>
 <Y2to4/kH6Gu+ykpk@kroah.com>
 <CAJedcCwzQj7pLzejX01PeuwL3a-DwRFmAEBLR-CR3_bAc0tx1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJedcCwzQj7pLzejX01PeuwL3a-DwRFmAEBLR-CR3_bAc0tx1g@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2022 at 05:24:05PM +0800, Zheng Hacker wrote:
> Greg KH <gregkh@linuxfoundation.org> 于2022年11月9日周三 16:46写道：
> >
> > On Wed, Nov 09, 2022 at 04:41:42PM +0800, Zheng Wang wrote:
> > > Gts may be freed in gru_check_chiplet_assignment.
> > > The caller still use it after that, UAF happens.
> > >
> > > Fix it by introducing a return value to see if it's in error path or not.
> > > Free the gts in caller if gru_check_chiplet_assignment check failed.
> > >
> > > Fixes: 55484c45dbec ("gru: allow users to specify gru chiplet 2")
> > > Reported-by: Zheng Wang <hackerzheng666@gmail.com>
> > > Reported-by: kernel test robot <lkp@intel.com>
> > >
> >
> > Why the blank line?
> 
> > Sorry for the spelling problem, fixed it next version
> 
> > And the kernel test robot didn't find this issue, right?
> >
> 
> Yes, it helped with the test and found an unused variable. I added
> this line as the mail suggested
> ("If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>").
> 
> Should I remove it?

If you submit a patch that just fixes the issue that the test robot
finds, yes, that needs to be there.  If you are fixing up a patch that
you submit based on the report, no, you do not.

thanks,

greg k-h
