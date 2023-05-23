Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BAF370E24A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 18:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237789AbjEWQqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 12:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237781AbjEWQqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 12:46:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEEF8C2
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 09:46:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 42DE7633D6
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 16:46:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 420CDC433D2;
        Tue, 23 May 2023 16:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684860367;
        bh=frZYjDQKin2OHTgUDD9pxdXKaV6vGksRhCcsFtba5x4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=H8SfP/1BV7zbPUtsX6lI0G0fNnb1MZitP4ubj+awDqBrFHMpMSz2TribsuvaMA3hM
         e/iuchNE906qqEzi12NJg2q2qNsjX/b9oB/CzvhmuFkTCMhoV/sY4zhTmq1tr866b9
         k/fRX88Huy3s20ikowigjysvgkzvtCyBUi6DVA+MjfdLnVM9nr1te2U5gk0fHRIDZH
         wOJS9i41FMYjizitrnHb1MsvjWX+53PagC6EKTJlVtfMyQe4w/0r6IuGwDiqGwsZPS
         fGI9khOKXUd6zxx1577oULe81ZEcIqCCM2kwErfPln4q+CbyTNrcZfEYy5reMNg69S
         8riVqD/CwqA0g==
Date:   Tue, 23 May 2023 09:46:06 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     edumazet@google.com,
        syzbot <syzbot+c2775460db0e1c70018e@syzkaller.appspotmail.com>,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        davem@davemloft.net, linux-kernel@vger.kernel.org,
        pabeni@redhat.com, wireguard@lists.zx2c4.com, jann@thejh.net
Subject: Re: [syzbot] [wireguard?] KASAN: slab-use-after-free Write in
 enqueue_timer
Message-ID: <20230523094606.6f4f8f4f@kernel.org>
In-Reply-To: <ZGzmWtd7itw6oFsI@zx2c4.com>
References: <000000000000c0b11d05fa917fe3@google.com>
        <ZGzfzEs-vJcZAySI@zx2c4.com>
        <20230523090512.19ca60b6@kernel.org>
        <ZGzmWtd7itw6oFsI@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 May 2023 18:14:18 +0200 Jason A. Donenfeld wrote:
> So, IOW, not a wireguard bug, right?

What's slightly concerning is that there aren't any other timers
leading to

  KASAN: slab-use-after-free Write in enqueue_timer

:( If WG was just an innocent bystander there should be, right?
