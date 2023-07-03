Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5E7D7456A6
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 10:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbjGCIBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 04:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbjGCIAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 04:00:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71CFCE66
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 01:00:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D9B1C60DDD
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 08:00:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8CFEC433C9;
        Mon,  3 Jul 2023 08:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688371242;
        bh=LyrcbrSYDLZkyAf2WIC0OEEUokb2aRRylmvi6GVoe5M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TW/IvmlAoB1iKWleaa30VXKjm6GZlWs7MyPseTqXXgmTcAGh1RNnyUtG8NmQbQ4hh
         tWHW14y5R0TAUqpM9lKYL0iYb0neJhjY5Z+wzNdvPOQrFEI8svsf6X8MTbQKZqudUa
         IeR4wxAwdVQNWu3cmICOKFapX+eBGATHsl8N0j10xXz5UwBUKE2ZWe1FrfwfNBiYmE
         YRjFAIwQh0em0XLwlIGUM4LodP7k9jhNWnyWcnCqe6+wWxwjnlyNvrkdPzkETZ+QNN
         i9rdH6rIqBSCirrIytHDAaxAuteg1c7B3q/JbFmT0ShtucP2irLCsR4XQgoAjCA7TW
         LoljlHU+xgT0Q==
Date:   Mon, 3 Jul 2023 10:00:38 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     syzbot <syzbot+3945b679bf589be87530@syzkaller.appspotmail.com>
Cc:     davem@davemloft.net, kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [kernel?] net test error: UBSAN:
 array-index-out-of-bounds in alloc_pid
Message-ID: <20230703-sanieren-zwirn-0e1a12922ea6@brauner>
References: <000000000000a6a01c05ff8f2745@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <000000000000a6a01c05ff8f2745@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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

#syz fix: pid: Replace struct pid 1-element array with flex-array
