Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3ED6D365B
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 10:45:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbjDBIpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 04:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjDBIph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 04:45:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CC4B65BC
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 01:45:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F917610AA
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 08:45:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A865C433EF;
        Sun,  2 Apr 2023 08:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1680425135;
        bh=tckU6xp93K5qFKC4UgCNUB4eQC8kIBs4amnFi56JE5Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kBLzA62sTHAO9FrvaSX4nzKfeAs3pmILEROxBQZ7Zyz1r+9wR79FTP6ehTPHn+IDL
         C9OcDp30awqW89VrfB9c1d8AXHbc9Y4AQOl8pjouHM8Nx4SHKMdxbCnoj59QKnH4xi
         tgvahI/Qj+9HGy1QF4SPneB/F15/2wyQsxAMEsZM=
Date:   Sun, 2 Apr 2023 10:45:32 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     syzbot <syzbot+ca3d9f693dfa69f61371@syzkaller.appspotmail.com>
Cc:     linux-kernel@vger.kernel.org, rafael@kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [kernel?] WARNING in class_register
Message-ID: <2023040205-apostle-retention-cebd@gregkh>
References: <00000000000055cd8405f84c5386@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000055cd8405f84c5386@google.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 01, 2023 at 01:39:42PM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    a6d9e3034536 Add linux-next specific files for 20230330
> git tree:       linux-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=1496edcdc80000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=aceb117f7924508e
> dashboard link: https://syzkaller.appspot.com/bug?extid=ca3d9f693dfa69f61371
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14f57859c80000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=167cc501c80000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/ec1f900ea929/disk-a6d9e303.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/fabbf89c0d22/vmlinux-a6d9e303.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/1ed05d6192fa/bzImage-a6d9e303.xz
> 
> The issue was bisected to:
> 
> commit dcfbb67e48a2becfce7990386e985b9c45098ee5
> Author: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Date:   Fri Mar 24 10:01:31 2023 +0000
> 
>     driver core: class: use lock_class_key already present in struct subsys_private
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10190b49c80000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=12190b49c80000
> console output: https://syzkaller.appspot.com/x/log.txt?x=14190b49c80000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+ca3d9f693dfa69f61371@syzkaller.appspotmail.com
> Fixes: dcfbb67e48a2 ("driver core: class: use lock_class_key already present in struct subsys_private")

Should already be fixed by:
	https://lore.kernel.org/all/2023040126-blandness-duckling-bd55@gregkh/
which was a different syzbot-reported issue with this same commit.

thanks,

greg k-h
