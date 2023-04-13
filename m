Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 499626E0DA6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 14:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjDMMsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 08:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjDMMsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 08:48:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A0F88A74
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 05:48:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2708D63906
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 12:48:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EF60C433EF;
        Thu, 13 Apr 2023 12:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1681390081;
        bh=Pe5uMNkQGXHvLTcEYPm3B5O3mU81jY6Z+wmWp5Fn52M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BxU01KBW2dz0eHNO8dz3BP30VjT2oL54cWZ24vnOeT2hJzl8ygGwq0qtW5S2SnGqv
         NK6l3GFl2JC5Ybb17x2FwqmOWhjZ7TJzS670pVYkDmRTuZqOHeDDmWuVil+uauN5Qv
         zFJnNH1pD/SWxzpm0IxGAVUzs0eZfL6VYApiKZJ0=
Date:   Thu, 13 Apr 2023 14:47:58 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zheng Hacker <hackerzheng666@gmail.com>
Cc:     Yongqin Liu <yongqin.liu@linaro.org>,
        John Stultz <jstultz@google.com>,
        Zheng Wang <zyytlz.wz@163.com>,
        Sumit Semwal <sumit.semwal@linaro.org>, arnd@arndb.de,
        linux-kernel@vger.kernel.org, 1395428693sheep@gmail.com,
        alex000young@gmail.com, Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH] misc: hisi_hikey_usb: Fix use after free bug in
 hisi_hikey_usb_remove due to race condition
Message-ID: <2023041308-nerd-dry-98a6@gregkh>
References: <20230312145305.1908607-1-zyytlz.wz@163.com>
 <CANDhNCr=hdhKS4c+U=+W1ONHDWv6BrwL5TovGjs0G2G+Reqc9g@mail.gmail.com>
 <CAJedcCyJnV+KnFF5h+2-0W1R4uaUxUxXFUH3Q9HGYh-5F5LmBQ@mail.gmail.com>
 <CAJedcCyERP0-9DNgeKmS3C9Soqq590PteEorr_bxKzNanht=TQ@mail.gmail.com>
 <CAMSo37Vfr0DOqN+1XjH0o3pOY=BaHnSFkUbnZPOdMQ3TbfoAKg@mail.gmail.com>
 <CAJedcCzm3MqYe3QGT7V4sMmDsVHbjVSnEc2NXWPMGVZL=a_cBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJedcCzm3MqYe3QGT7V4sMmDsVHbjVSnEc2NXWPMGVZL=a_cBA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13, 2023 at 07:12:07PM +0800, Zheng Hacker wrote:
> Yongqin Liu <yongqin.liu@linaro.org> 于2023年4月13日周四 18:55写道：
> >
> > Hi, Zheng
> >
> > On Thu, 13 Apr 2023 at 16:08, Zheng Hacker <hackerzheng666@gmail.com> wrote:
> > >
> > > Friendly ping about the bug.
> >
> > Sorry, wasn't aware of this message before,
> >
> > Could you please help share the instructions to reproduce the problem
> > this change fixes?
> >
> 
> Hi Yongqin,
> 
> Thanks for your reply. This bug is found by static analysis. There is no PoC.
> 
> >From my personal experience, triggering race condition bugs stably in
> the kernel needs some tricks.
> For example, you can insert some sleep-time code to slow down the
> thread until the related object is freed.
> Besides, you can use gdb to control the time window. Also, there are
> some other tricks as [1] said.
> 
> As for the reproduction, this attack vector requires that the attacker
> can physically access the device.
> When he/she unplugs the usb, the remove function is triggered, and if
> the set callback is invoked, there might be a race condition.

How does the removal of the USB device trigger a platform device
removal?

Are you sure this can be triggered by some other way other than manually
unloading the driver?

thanks,

greg k-h
