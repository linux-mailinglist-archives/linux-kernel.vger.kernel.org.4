Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0D76702C25
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 14:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241469AbjEOMB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 08:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241699AbjEOMBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 08:01:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C5784481
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 04:59:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E24F962316
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 11:57:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFCE6C433EF;
        Mon, 15 May 2023 11:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684151843;
        bh=zoj3PgUksPw4I6rDRt8SiyezBZU8BmXRDL7E8ZnxRoc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fwcL5RNTJnP6O7dE4Hr6fn/xSFahLalML1Vrlq3ThfVXdLQwSX3Eh07ti3iX0AQtG
         FLjNquGT2pU4w/cnbYwgVJlQ0ndIF6zJMvrzKO91fsFonKUS22MlhBJCikUIepo8bJ
         9Y890mRR6SpUohqpIaNb0+0CPMdBUfAHfKIUH3lQ=
Date:   Mon, 15 May 2023 13:57:20 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Qiumiao Zhang <zhangqiumiao1@huawei.com>
Cc:     andriy.shevchenko@linux.intel.com, fengtao40@huawei.com,
        jirislaby@kernel.org, linux-kernel@vger.kernel.org,
        yanan@huawei.com, ilpo.jarvinen@linux.intel.com
Subject: Re: Re: KASAN: soft lockup in paste_selection
Message-ID: <2023051550-monotone-obliged-c1fb@gregkh>
References: <2023051248-captivity-primary-b3c6@gregkh>
 <20230515072629.1938-1-zhangqiumiao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515072629.1938-1-zhangqiumiao1@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 15, 2023 at 03:26:29PM +0800, Qiumiao Zhang wrote:
> On Fri, May 12, 2023 at 11:33:26AM +0000, gregkh wrote:
> >> Hello,
> >> 
> >> We found the following issue using syzkaller on Linux v5.10.0.
> > 
> > 5.10.0 is very old and obsolete and over 20 thousand patches old.
> > Please, if you are testing LTS kernels, use the latest one.
> > 
> >> A similar issue was found in function `paste_selection` before and I 
> >> believe they are the same.
> >> (https://lore.kernel.org/all/000000000000fe769905d315a1b7@google.com/)
> >> 
> >> Unfortunately, no one seems to be paying attention to this issue.
> > 
> > Do you have a proposed patch for this fix now that you have a way to reproduce this?  Do you see this in real situations or only in > fault-injection systems running syzbot?
> > 
> > And can you reproduce this on 6.4-rc1?  Do you have a reproducer?
> > 
> > thanks,
> > 
> > greg k-h
> 
> I see this issue only in fault-injection systems running syzbot. And I can reproduce this on 6.4-rc1.

fault-injection systems are "fake" and for many issues in the
tty/console layer, we really do not care about them as they the failures
can never be triggered in real life.

Are you sure this is not such a issue?

Try to fix this up by adding the needed "error handling" to the place
where the fault injection was causing the failure, and see if that
really is realistic or not.

good luck!

greg k-h
