Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8314A6CF8B2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 03:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbjC3B17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 21:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjC3B14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 21:27:56 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6223B559B
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 18:27:54 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id l9-20020a17090a3f0900b0023d32684e7fso4988016pjc.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 18:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112; t=1680139674;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7LG6zXCslOH9ykBZv6LzrhqoYBSGwMfp0vnybvkLtvU=;
        b=7cwCfUZihuwFWuyjGpryi3QxY+znpqBQL/fcVMbx9a9FMGQ758jNlvp6w23kygFdWg
         WfKMJ+K0Bd7CYIwZWELQ4zaddZsh34aZsKMiR7Joo0DvUg/1/wIWfgJ8llMUdq7/h/lB
         DYtokS+Hgms4LetTxbyetQItSWriDKNasjVILiBbMdzrCiSlIVJIIyWvBfAWyEIQZoFB
         ClMJgwSzbt6KvGVvRL1kH+T1Y20JiOMQjQMqzBMSCe7MrIXRgwzK1ImjDiZR2lv5AFEh
         JY3eE5wH0wxauurmVfUKeBPASYH3Bim3wntM1UnLnLoBgtZfWxs0p21/8pa2ppAbboyZ
         y4eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680139674;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7LG6zXCslOH9ykBZv6LzrhqoYBSGwMfp0vnybvkLtvU=;
        b=62QKlt9JSq/scniqOhen1otj1GmZnHPJbwL+O0+TrqTZVxYsFZ4qW30kA46aJIZI4J
         LThO8DRiPFF5BHrShLiHxDMbm9F6YNVqghsSpSlTeXen2PoNNxfUimIfFcamNSrspMBX
         v+m2Af+oEdX/gXoSZBnJ08qj5ShsCXvPrIZ3IauJJs2UNAx7L0K4Y7iyWXmCtJtrRwc4
         JjDMJAQoY559sb0jt7IATnWVX35jC7vZjQmw7hyBTp+NeXVVm1Z29UugQ8bhiHoQzGbe
         xHZobLNIoIt9SBBK0NugUq093Sc7oaSHez4knBqtit1qahr3QSBDzCSUlCcAmqiT6ZGu
         39GA==
X-Gm-Message-State: AAQBX9c7AjUjlzQ6gL1PZAGOYb//XWmbz3qDgHTLOWxetmvM+vlnuJol
        vbSmnkisb0RXVI7bzWrCUnjNrA==
X-Google-Smtp-Source: AKy350YNia8nunEpPiMYAsmXC+XRMQnuqnKoMOd3eQc8oJChyk2J10Q7EoYfJ/ROs/AL3g3Q1/AYpw==
X-Received: by 2002:a17:902:e743:b0:1a2:19c1:a96d with SMTP id p3-20020a170902e74300b001a219c1a96dmr4877567plf.23.1680139673792;
        Wed, 29 Mar 2023 18:27:53 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-91-157.pa.nsw.optusnet.com.au. [49.181.91.157])
        by smtp.gmail.com with ESMTPSA id q13-20020a170902bd8d00b0019e8c3cd3f4sm23541416pls.201.2023.03.29.18.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 18:27:53 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1phh4w-00EmYd-FB; Thu, 30 Mar 2023 12:27:50 +1100
Date:   Thu, 30 Mar 2023 12:27:50 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     syzbot <syzbot+0c383e46e9b4827b01b1@syzkaller.appspotmail.com>
Cc:     djwong@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [xfs?] WARNING in xfs_bmap_extents_to_btree
Message-ID: <20230330012750.GF3223426@dread.disaster.area>
References: <0000000000003da76805f8021fb5@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000003da76805f8021fb5@google.com>
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 09:08:01PM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    1e760fa3596e Merge tag 'gfs2-v6.3-rc3-fix' of git://git.ke..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=16f83651c80000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=acdb62bf488a8fe5
> dashboard link: https://syzkaller.appspot.com/bug?extid=0c383e46e9b4827b01b1
> compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/17229b6e6fe0/disk-1e760fa3.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/69b5d310fba0/vmlinux-1e760fa3.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/0c65624aace9/bzImage-1e760fa3.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+0c383e46e9b4827b01b1@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 24101 at fs/xfs/libxfs/xfs_bmap.c:660 xfs_bmap_extents_to_btree+0xe1b/0x1190

Allocation got an unexpected ENOSPC when it was supposed to have a
valid reservation for the space. Likely because of an inconsistency
that had been induced into the filesystem where superblock space
accounting doesn't exactly match the AG space accounting and/or the
tracked free space.

Given this is a maliciously corrupted filesystem image, this sort of
warning is expected and there's probably nothing we can do to avoid
it short of a full filesystem verification pass during mount.
That's not a viable solution, so I think we should just ignore
syzbot when it generates this sort of warning....

i.e. we actually want this warning to be issued if it happens in
normal production situations, but given that it's relatively trivial
to create an inconsistent filesystem image that can trigger this we
should just ignore it when it is generated by such means.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
