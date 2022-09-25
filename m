Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC6335E9378
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 15:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231389AbiIYNk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 09:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiIYNk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 09:40:56 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AC3322BF9
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 06:40:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D2AC4CE0E0B
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 13:40:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A465C433C1;
        Sun, 25 Sep 2022 13:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1664113250;
        bh=xKtKRzURGjJuqG0yMhXUwvYFPApsFgss21P4sOLHiao=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NHqjNgXrzzjEvCJJ2oxK4r7v/dj6LboSyQi8e6NSgFo5AOuiLkwM/Q2bztNNW+d+S
         t7Z2agyf9qDH7cHCN9qXj+JnKWZgQzr4Uvc79ZnrA/BlOpBUwxiCZ0pDewHQN5o95I
         TN4rIvTsEbXxJKg10o3L+cB6piOCl2rnqBLx3Sc0=
Date:   Sun, 25 Sep 2022 15:40:48 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Tejun Heo <tj@kernel.org>,
        syzbot <syzbot+8bee3285b9e190f1509e@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org,
        Hillf Danton <hdanton@sina.com>
Subject: Re: [PATCH] kernfs: fix UAF race condition in __kernfs_remove()
Message-ID: <YzBaYHqldB39zD17@kroah.com>
References: <000000000000646c9605e714ec6e@google.com>
 <7f489b14-2fdc-3d91-c87e-6a802bd8592d@I-love.SAKURA.ne.jp>
 <YzBT+hJ/fmp75j1P@kroah.com>
 <83be5776-4038-90d5-f202-9a6e97b6d551@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83be5776-4038-90d5-f202-9a6e97b6d551@I-love.SAKURA.ne.jp>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 25, 2022 at 10:20:27PM +0900, Tetsuo Handa wrote:
> On 2022/09/25 22:13, Greg Kroah-Hartman wrote:
> > Isn't this already handled by:
> > 	https://lore.kernel.org/r/20220913121723.691454-1-lk@c--e.de
> > 
> > that will show up in the next linux-next tree.
> 
> Oh, I didn't know that patch.
> 
> But is that patch complete, for there are three __kernfs_remove() callers?
> 

syzbot seems to think it works :)
