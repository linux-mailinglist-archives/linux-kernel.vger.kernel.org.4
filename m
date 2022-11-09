Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 010D56225B9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 09:46:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbiKIIqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 03:46:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiKIIqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 03:46:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95FE210E
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 00:46:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E08F6B81D4D
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 08:46:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB391C43470;
        Wed,  9 Nov 2022 08:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1667983591;
        bh=ciFUE2A5SyJbz1rDEg/kblM1kCJdRWaX9rxA3/fm38g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mis3qDuuJuYP681W+nKGqNj25tHWhv3PrXqdSW0o5LvP6bpECCvrrLNiwiNbT8/a/
         QvwBkwQIlIatN4k2V3ZrPt8nhoYi1iqASUmjask/QREVBk4QlJrXosPEKH+ZtcC5FR
         4UZYyMhmD/xR4NiyKbK3teFnilDipx0zPx7gHx0Q=
Date:   Wed, 9 Nov 2022 09:46:27 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zheng Wang <zyytlz.wz@163.com>
Cc:     zhengyejian1@huawei.com, dimitri.sivanich@hpe.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org, hackerzheng666@gmail.com,
        alex000young@gmail.com, security@kernel.org, sivanich@hpe.com,
        lkp@intel.com
Subject: Re: [PATCH v6 RESEND] misc: sgi-gru: fix use-after-free error in
 gru_set_context_option, gru_fault and gru_handle_user_call_os
Message-ID: <Y2to4/kH6Gu+ykpk@kroah.com>
References: <20221109084142.226960-1-zyytlz.wz@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221109084142.226960-1-zyytlz.wz@163.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2022 at 04:41:42PM +0800, Zheng Wang wrote:
> Gts may be freed in gru_check_chiplet_assignment.
> The caller still use it after that, UAF happens.
> 
> Fix it by introducing a return value to see if it's in error path or not.
> Free the gts in caller if gru_check_chiplet_assignment check failed.
> 
> Fixes: 55484c45dbec ("gru: allow users to specify gru chiplet 2")
> Reported-by: Zheng Wang <hackerzheng666@gmail.com>
> Reported-by: kernel test robot <lkp@intel.com>
> 

Why the blank line?

And the kernel test robot didn't find this issue, right?

> Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
> Acked-by: Dimitri Sivanich <sivanich@hpe.com>

You can not have a reported-by and a signed-off-by for the same person
with different email addresses.  You do not need both if it is you, just
use the signed-off-by line.

thanks,

greg k-h
