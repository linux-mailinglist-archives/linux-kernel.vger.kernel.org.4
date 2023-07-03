Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE447456BA
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 10:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbjGCICk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 04:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbjGCICW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 04:02:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF35D10EA
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 01:01:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5830060C57
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 08:01:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B203C433C8;
        Mon,  3 Jul 2023 08:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688371302;
        bh=xhiKOGFBIK3GyZ81/swuDdPj2WZczptt4L3dD836b4s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b52litQ3xVEDGETfQ7h4zPXNeOk8CnDDA9P3xsxfhjuaiOU3gw53b8aTMFWJvme0J
         5Nu3McSDvLPMcsVc1igMAaP0td31nKrhkpXSpbWvsQJqiscTJErvsqHOSMycBLfjEr
         B2wseAiqRXh9ZKmE0kmvY5vNR0YTYXokbI2HC12a4ypmvLkrW2TnBy9Gs0H6J8TJ4H
         qVTmD8NpmRZ0fwbxwOYD6hCvEhqFV89EQRGBZtvCw3s4UP41J9khyTq9YkzF6ngoQV
         vDDMmF6EzRrzCwlzxyrszHpDekolHxkEjNoaV7BUEMX54dHOdxogF1JdalA5hGbL75
         enwBa9Nhuh2bA==
Date:   Mon, 3 Jul 2023 10:01:38 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     syzbot <syzbot+3945b679bf589be87530@syzkaller.appspotmail.com>
Cc:     davem@davemloft.net, kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [kernel?] net test error: UBSAN:
 array-index-out-of-bounds in alloc_pid
Message-ID: <20230703-unpassend-bedauerlich-492e62f1a429@brauner>
References: <000000000000a6a01c05ff8f2745@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <000000000000a6a01c05ff8f2745@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 02, 2023 at 11:19:54PM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    97791d3c6d0a Merge branch 'octeontx2-af-fixes'
> git tree:       net
> console output: https://syzkaller.appspot.com/x/log.txt?x=11b1a6d7280000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=924167e3666ff54c
> dashboard link: https://syzkaller.appspot.com/bug?extid=3945b679bf589be87530
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/2bd5d64db6b8/disk-97791d3c.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/cd31502424f2/vmlinux-97791d3c.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/33c6f22e34ab/bzImage-97791d3c.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+3945b679bf589be87530@syzkaller.appspotmail.com

#syz dup: [syzbot] [kernel?] net-next test error: UBSAN: array-index-out-of-bounds in alloc_pid
