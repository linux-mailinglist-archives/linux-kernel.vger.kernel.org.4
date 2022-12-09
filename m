Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF0456485A1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 16:32:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbiLIPcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 10:32:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbiLIPcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 10:32:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 773DA20F56;
        Fri,  9 Dec 2022 07:32:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B8DEAB82884;
        Fri,  9 Dec 2022 15:32:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18C5AC433F1;
        Fri,  9 Dec 2022 15:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1670599928;
        bh=qGtcBXEEZBuPDSehAEqy32jhuEWo98NeXnITy4+odyE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tNm/pSZ2rMybzF5yBMMvfhkmc2oHVEIxLi0pfYkF5htPVnGNiFxUQtRTVL26XP4sM
         s5GrP+Aa4XXRYHe6xQQ1F9Ux3Ez0CgON0N9QZkQfnOPJzd0ngo7o2+LgBjf5pPwQPR
         A0gGUgJDF+BYVKIT1cjuggNix4evuNRckz/cSEnA=
Date:   Fri, 9 Dec 2022 16:32:06 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "yekai (A)" <yekai13@huawei.com>
Cc:     herbert@gondor.apana.org.au, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, wangzhou1@hisilicon.com,
        liulongfang@huawei.com
Subject: Re: [PATCH v10 0/3] crypto: hisilicon - supports device isolation
 feature
Message-ID: <Y5NU9vLyEjekoWfj@kroah.com>
References: <20221119074817.12063-1-yekai13@huawei.com>
 <9b934709-2f74-7392-aab6-eb506ddcf708@huawei.com>
 <75ca78c7-1ca3-3e62-1175-5207ed9f5cf8@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <75ca78c7-1ca3-3e62-1175-5207ed9f5cf8@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 09, 2022 at 02:15:07PM +0800, yekai (A) wrote:
> 
> 
> On 2022/11/25 16:49, yekai (A) wrote:
> >
> > On 2022/11/19 15:48, Kai Ye wrote:
> >> 1、Add the uacce hardware error isolation interface. Hardware error 
> >>    thresholds can be configured by sysfs node. User can get the hardware
> >>    isolated state by sysfs node.
> >> 2、Defining the isolation strategy for uacce device by uacce sysfs node. 
> >>    If the number of hardware errors exceeds the configured value, the 
> >>    uacce device will not be available in user space.
> >> 3、The ACC VF device use the PF device isolation strategy.
> >>    
> >> changes v1->v2:
> >> 	- deleted dev_to_uacce api.
> >> 	- add vfs node doc. 
> >> 	- move uacce->ref to driver.
> >> changes v2->v3:
> >> 	- deleted some redundant code.
> >> 	- use qm state instead of reference count.
> >> 	- add null pointer check.
> >> 	- isolate_strategy_read() instead of a copy.
> >> changes v3->v4:
> >> 	- modify a comment
> >> changes v4->v5:
> >> 	- use bool instead of atomic.
> >> 	- isolation frequency instead of isolation command.
> >> changes v5->v6:
> >> 	- add is_visible in uacce.
> >> 	- add the description of the isolation strategy file node.
> >> changes v6->v7
> >> 	- add an example for isolate_strategy in Documentation.
> >> changes v7->v8
> >> 	- update the correct date.
> >> changes v8->v9
> >>     - move isolation strategy from qm to uacce.
> >> changes v9->v10
> >> 	- Go back to the v8 version of the solution.
> >> 	- Modify some code according to suggestions.
> >>
> >> Kai Ye (3):
> >>   uacce: supports device isolation feature
> >>   Documentation: add the device isolation feature sysfs nodes for uacce
> >>   crypto: hisilicon/qm - define the device isolation strategy
> >>
> >>  Documentation/ABI/testing/sysfs-driver-uacce |  18 ++
> >>  drivers/crypto/hisilicon/qm.c                | 169 +++++++++++++++++--
> >>  drivers/misc/uacce/uacce.c                   |  50 ++++++
> >>  include/linux/hisi_acc_qm.h                  |  15 ++
> >>  include/linux/uacce.h                        |  12 ++
> >>  5 files changed, 249 insertions(+), 15 deletions(-)
> >>
> > Hi Grek
> >
> > Just a friendly ping.
> >
> > Thanks
> > Kai
> 
> Hi Greg KH
> 
> Could you help me to apply this patchset v10?

Sorry, it needs review from the crypto maintainers before I can take it.

Also, it looks to be too late for 6.2-rc1 at this point in time.

thanks,

greg k-h
