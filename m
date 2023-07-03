Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABE9D7456BF
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 10:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbjGCIDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 04:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231151AbjGCICr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 04:02:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 970BA19AE
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 01:02:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E9B0D60DDA
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 08:01:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2E5FC433C8;
        Mon,  3 Jul 2023 08:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688371317;
        bh=ZUKw7q8V4ay5pMR8wVbZ0SclAMMyJvKXf2173otiaSE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h4RYEHqcTxiC58If0FK8/DakXfjJf23COw47R7vWnRP5550RIH9FEFsydsNVDJ3u8
         ugmw+aeZXKWl1BVMeuVzom4PGicSxGPxfV+UTcjQ+TROBzBiDJFrsltmANop2tLgSq
         1ymoBw6WJAyoYQ/uzGEoCWfQo0D73OjAXnpseYxAsgWL+QA8VDkOqoqHLnU6BCZTSK
         fPQAKSx4pwCkoUsmGYZhz8hDmSt1PziFTDTjNbgP7vPMK/kzgWOk7rOVJrt24K0HT5
         iqczOCPwAdP/EjEPdJ012U8TXaJKPvd7I/S0MzeJAjwnNEC9NJjw/LE8G0BxZqqwyx
         EY4qOO2xq/O1w==
Date:   Mon, 3 Jul 2023 10:01:53 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     syzbot <syzbot+319a9b09e5de1ecae1e1@syzkaller.appspotmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [kernel?] bpf-next test error: UBSAN:
 array-index-out-of-bounds in alloc_pid
Message-ID: <20230703-richten-ehren-5a4c9b042a23@brauner>
References: <000000000000246c3f05ff8fea48@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <000000000000246c3f05ff8fea48@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 03, 2023 at 12:14:17AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    c20f9cef725b Merge branch 'libbpf: add netfilter link atta..
> git tree:       bpf-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=127adbfb280000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=924167e3666ff54c
> dashboard link: https://syzkaller.appspot.com/bug?extid=319a9b09e5de1ecae1e1
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/bf9c9608a1e0/disk-c20f9cef.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/3bde4e994bd0/vmlinux-c20f9cef.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/5d80f8634183/bzImage-c20f9cef.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+319a9b09e5de1ecae1e1@syzkaller.appspotmail.com

#syz dup: [syzbot] [kernel?] net-next test error: UBSAN: array-index-out-of-bounds in alloc_pid
