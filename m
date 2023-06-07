Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21E32725B81
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 12:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235258AbjFGKWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 06:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233639AbjFGKWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 06:22:21 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E103B11D;
        Wed,  7 Jun 2023 03:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=HxMgllij4uafIlNlrZWmb5HzuuZkU9BY3yQ9zpW35VY=;
        t=1686133340; x=1687342940; b=kffk4N6DySYtVtARGaMOGIy/LOnMPcnla4zXro+tnkmy63H
        GHRKkVybilihZzafjB0QcGSq4JcJXtrrkDHg/MVtikwT3j0nNj1bWsLXKWpKYRlR5Ffe/yXUuwMef
        4pALIpqwC+GUWGunChAL2KXT6KPJMWBJgrnoGH6Gwb6KeDuQOC/EVlXVc2dXMDfXTGS/ytUd1pBzM
        Otr2UjEvVBlfuqJbNTyhoNrNg87DCCQnExV/hG26PdUGueCkzFROvtFCF5TMfpgocNbsSxaxD7BKs
        eE3oCICfRXEr2AIFsNovfYtEAUWrfPI//0b05e/FwbvcOh2KcJd8wOVDl5KTJjoQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1q6qIv-00GW35-1Y;
        Wed, 07 Jun 2023 12:22:13 +0200
Message-ID: <81ea9426dca43f7a74507b9fa70ab217359a3eb1.camel@sipsolutions.net>
Subject: Re: [syzbot] [wireless?] INFO: task hung in rfkill_unregister (3)
From:   Johannes Berg <johannes@sipsolutions.net>
To:     syzbot <syzbot+bb540a4bbfb4ae3b425d@syzkaller.appspotmail.com>,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bongsu Jeon <bongsu.jeon@samsung.com>
Date:   Wed, 07 Jun 2023 12:22:12 +0200
In-Reply-To: <00000000000052748d05fd872fb0@google.com>
References: <00000000000052748d05fd872fb0@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.2 (3.48.2-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-06-07 at 02:58 -0700, syzbot wrote:
> Hello,
>=20
> syzbot found the following issue on:
>=20
> HEAD commit:    eb0f1697d729 Merge branch 'for-next/core', remote-trackin=
g..
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux=
.git for-kernelci
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D17b656a528000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D8860074b9a9d6=
c45
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Dbb540a4bbfb4ae3=
b425d
> compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Deb=
ian) 2.35.2
> userspace arch: arm64
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D122665a3280=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D13dc1c5928000=
0
>=20
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/034232da7cff/dis=
k-eb0f1697.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/b11411bec33e/vmlinu=
x-eb0f1697.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/a53c52e170dd/I=
mage-eb0f1697.gz.xz
>=20
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+bb540a4bbfb4ae3b425d@syzkaller.appspotmail.com
>=20
> INFO: task syz-executor410:6034 blocked for more than 143 seconds.
>       Not tainted 6.4.0-rc3-syzkaller-geb0f1697d729 #0
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:syz-executor410 state:D stack:0     pid:6034  ppid:5996   flags:0x00=
00000c
> Call trace:
>  __switch_to+0x320/0x754 arch/arm64/kernel/process.c:556
>  context_switch kernel/sched/core.c:5343 [inline]
>  __schedule+0x1368/0x23b8 kernel/sched/core.c:6669
>  schedule+0xc4/0x170 kernel/sched/core.c:6745
>  schedule_preempt_disabled+0x18/0x2c kernel/sched/core.c:6804
>  __mutex_lock_common+0xbd8/0x21a0 kernel/locking/mutex.c:679
>  __mutex_lock kernel/locking/mutex.c:747 [inline]
>  mutex_lock_nested+0x2c/0x38 kernel/locking/mutex.c:799
>  rfkill_unregister+0xb8/0x210 net/rfkill/core.c:1130
>  nfc_unregister_device+0x98/0x290 net/nfc/core.c:1167
>  nci_unregister_device+0x1dc/0x21c net/nfc/nci/core.c:1303
>  virtual_ncidev_close+0x5c/0xa0 drivers/nfc/virtual_ncidev.c:163

This seems like an issue with the virtual NFC device. I feel we had this
before?

johannes
