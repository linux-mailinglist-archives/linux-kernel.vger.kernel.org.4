Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B10D77126F5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 14:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242898AbjEZMwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 08:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbjEZMwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 08:52:39 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99BC0114;
        Fri, 26 May 2023 05:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
        bh=0YpbsFnj98pgH6JWPBRZGLCBzaS6UiqQl2GQqkSIojU=; b=YQrbAT1HCmhf7UHcRaimTTu22Y
        4xCuK1vIyGpQDwALBNVSOkP24Cx0tTcqA6+EWp9hhXpc9KjePMR0Y42mc/mk/8X8Oa0pAsHFFMFHY
        L3n8O/TdHQHu6HANBep7c3hbBj38DCpb6DQfa+CEQ/kSkLVFlD4KbAxcMzcHLsOQDRaDIYE1T1v2z
        tG1A9NVcHwIBxLrOf3whKkb/Xcdls6tjdbSLqkLLF7e7ueeOZLU3J+oT1WMLNNL0UFNkid5YYf/es
        iIKFVsB+GncAvHOgmsjvA40py9ij9FJkHg8U/0C9RZGqS9ZVZG8AO/PHPyLKF17le3oGxWBpyj8Yq
        iOFNuTuw==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <daniel@iogearbox.net>)
        id 1q2Wvo-000IZx-N6; Fri, 26 May 2023 14:52:32 +0200
Received: from [178.197.248.23] (helo=linux.home)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1q2Wvn-000Gr1-Q5; Fri, 26 May 2023 14:52:31 +0200
Subject: Re: [syzbot] [bpf?] WARNING: bad unlock balance in bpf
To:     syzbot <syzbot+8982e75c2878b9ffeac5@syzkaller.appspotmail.com>,
        andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        davem@davemloft.net, haoluo@google.com, hawk@kernel.org,
        john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        martin.lau@linux.dev, netdev@vger.kernel.org, sdf@google.com,
        song@kernel.org, syzkaller-bugs@googlegroups.com, yhs@fb.com
References: <000000000000ea970305fc95f3c6@google.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <beb1ea86-4de2-f18f-99b0-f00e8ce40ae7@iogearbox.net>
Date:   Fri, 26 May 2023 14:52:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <000000000000ea970305fc95f3c6@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/26919/Fri May 26 09:23:54 2023)
X-Spam-Status: No, score=0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SORTED_RECIPS,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/26/23 12:10 PM, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    c4c84f6fb2c4 bpf: drop unnecessary bpf_capable() check in ..
> git tree:       bpf-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=119576a9280000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=8bc832f563d8bf38
> dashboard link: https://syzkaller.appspot.com/bug?extid=8982e75c2878b9ffeac5
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10391dde280000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=137da9c5280000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/3cb57feeb883/disk-c4c84f6f.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/7ccb6d78c42d/vmlinux-c4c84f6f.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/fb02c9cdb21c/bzImage-c4c84f6f.xz
> 
> The issue was bisected to:
> 
> commit c4c84f6fb2c4dc4c0f5fd927b3c3d3fd28b7030e
> Author: Andrii Nakryiko <andrii@kernel.org>
> Date:   Wed May 24 22:54:19 2023 +0000
> 
>      bpf: drop unnecessary bpf_capable() check in BPF_MAP_FREEZE command
> 
[...]

Fyi, fixed this up today in bpf-next tree.

#syz fix: bpf: Fix bad unlock balance on freeze_mutex
