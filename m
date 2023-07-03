Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5EF7456B6
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 10:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbjGCIBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 04:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbjGCIBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 04:01:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29FCFE43
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 01:01:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A5CAA60DDB
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 08:01:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEA67C433CA;
        Mon,  3 Jul 2023 08:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688371265;
        bh=agzuLGwMJnoQtsjjF+lM4RGUEzreGKDMB0+SK3+E2dw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nDhYQVpMiT85jIQKoUXuGF472rR33W+PW/sHjB5DocAzcEeLuQP70RZVV7H9oBVgn
         ufvAHUIA9najPFqYMerpqkw51QccC6fghwHNtMN2pyshFKnrndj3u0j/outTdRY9md
         QM1OKcjhdKtPhZzIH6ngfp2oOL3VizuCP1X2rQMf8tF92m4bUlZUO3WgtXBXdwqRTK
         J5/wkimdQaVbP7AEewXCRh4Wt53vkuagKM3dhhdT8EUoKXDBNcZoPebShf1G7efe4e
         ATxsEhVHY9Wkos2gPduAeCRlrCj+fvqVEIKk3GlddUZgKgiHQ/00/6AsGwJcm27wz2
         WF6vunKfVlTeQ==
Date:   Mon, 3 Jul 2023 10:01:01 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     syzbot <syzbot+f02ef87ef8bbb97026bd@syzkaller.appspotmail.com>
Cc:     davem@davemloft.net, kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [kernel?] net-next test error: UBSAN:
 array-index-out-of-bounds in alloc_pid
Message-ID: <20230703-finte-einundzwanzig-64713a7d6dda@brauner>
References: <00000000000018bd0d05ff8e8ab2@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <00000000000018bd0d05ff8e8ab2@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 02, 2023 at 10:35:50PM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    3a8a670eeeaa Merge tag 'net-next-6.5' of git://git.kernel...
> git tree:       net-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=1391a15f280000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=924167e3666ff54c
> dashboard link: https://syzkaller.appspot.com/bug?extid=f02ef87ef8bbb97026bd
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/580f71d6d107/disk-3a8a670e.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/7d94a5879cd1/vmlinux-3a8a670e.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/4ef3ba2a581e/bzImage-3a8a670e.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+f02ef87ef8bbb97026bd@syzkaller.appspotmail.com

#syz fix: pid: Replace struct pid 1-element array with flex-array
