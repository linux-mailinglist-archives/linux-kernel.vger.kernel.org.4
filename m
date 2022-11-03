Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A90906177A4
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 08:26:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbiKCH0P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 03:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbiKCH0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 03:26:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 693F6389F;
        Thu,  3 Nov 2022 00:26:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EF93DB82680;
        Thu,  3 Nov 2022 07:26:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EC15C433C1;
        Thu,  3 Nov 2022 07:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667460361;
        bh=6gSn24RE5tSW2tjjID0EiJ3LSBai5yjV2gtQ5QL4GTE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JNvrJYnoHKTLj4chzreMntUuJ17kljGcge9mZdoSALAARQVJxwb2OxV4ql631y4Oq
         JHsOWAQrQ7dnHfNlt3SDtjK0ju9fGiON8EwhoxXXIcI946Te1ghxsmkQPgBgbdW3iU
         bQFW1A2FlEaXr02YFcA+7AJdWvXDfo2gGbdAepIlCOEjhdAj3pwA5FD9bhkng4wVHi
         0DL2OLPWt3ecE0Zpd95qcZm1z3cxj0oa4WyOMom2TaWiFC3v5jNuhtLtzx9OR4/aPe
         IEjV2NVT14XDZLDRB2/SsNdIJ/7QlsKNqzjAx8pavjz3yY5xtenfxM0/IpXZt8FV2Z
         BCEW/LFN0Bj5w==
Date:   Thu, 3 Nov 2022 08:25:57 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     syzbot <syzbot+3f6ef1c4586bb6fd1f61@syzkaller.appspotmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        miklos@szeredi.hu, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] BUG: unable to handle kernel paging request in
 ovl_set_acl
Message-ID: <20221103072557.qc2hsowoaatstrbh@wittgenstein>
References: <000000000000cb639605ec7f6e10@google.com>
 <000000000000452ed505ec87d0ad@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <000000000000452ed505ec87d0ad@google.com>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2022 at 07:35:42PM -0700, syzbot wrote:
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    61c3426aca2c Add linux-next specific files for 20221102
> git tree:       linux-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=118e21de880000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=acb529cc910d907c
> dashboard link: https://syzkaller.appspot.com/bug?extid=3f6ef1c4586bb6fd1f61
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1620a689880000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=153fb2a9880000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/cc56d88dd6a3/disk-61c3426a.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/5921b65b080f/vmlinux-61c3426a.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/39cbd355fedd/bzImage-61c3426a.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+3f6ef1c4586bb6fd1f61@syzkaller.appspotmail.com

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/vfs/idmapping.git/ 5b52aebef8954cadff29918bb61d7fdc7be07837
