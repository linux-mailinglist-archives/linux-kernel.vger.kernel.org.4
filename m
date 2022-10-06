Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 783B05F6DBD
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 20:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbiJFSyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 14:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbiJFSyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 14:54:15 -0400
X-Greylist: delayed 322 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 06 Oct 2022 11:54:12 PDT
Received: from mail.postadigitale.org (mail.postadigitale.org [IPv6:2a01:4f8:200:34ed::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E0ADC6940
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 11:54:12 -0700 (PDT)
Received: from hostpad (p200300E4eF14Bb00Cd44aE579e46a63E.dip0.t-ipconnect.de [IPv6:2003:e4:ef14:bb00:cd44:ae57:9e46:a63e])
        by mail.postadigitale.org (Postfix) with ESMTPSA id 4277D19CDA
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 20:48:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postadigitale.de;
        s=20180517; t=1665082127;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=M7sAER942m6X30CtkI1UU4lRPxRm6N9uYVQbrMaQFe0=;
        b=XRKGDDRn5y5rzPLno37AxZFfq9jWcU6dyQtIpIXgmr7w7oNgJZ5RFcztthl+NZCke9QqW8
        2uwPYqqyrYpZkuXIXv8ACkQJOHc+/qdbhQ7Sa55GDDUrcv2Q8XZnZNkrL6uSc4Mwq0ye2T
        eTy5e95gc9wN4a3iRdQPlxbG/3Oe+gs=
Date:   Thu, 6 Oct 2022 18:48:45 +0000
From:   Simon Brand <simon.brand@postadigitale.de>
To:     linux-kernel@vger.kernel.org
Subject: Possibility to disable icotl TIOCSTI
Message-ID: <Yz8jDbLap91dRVyH@hostpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

in the past there have been attempts to restrict the TIOCSTI ioctl. [0, 1]
None of them are present in the current kernel.
Since those tries there have been some security issues (sandbox
escapes in flatpak (CVE-2019-10063) [2] and snap (CVE 2019-7303) [3],
runuser [4], su [5]).

I ask to merge the patches from linux-hardening [6, 7] so users can
opt out of this behavior. These patches provide the
`SECURITY_TIOCSTI_RESTRICT` Kconfig (default no) and a
`tiocsti_restrict` sysctl.

Escapes can be reproduced easiliy (on archlinux) via a python script:
```
import fcntl
import termios
with open("/dev/tty", "w") as fd:
    for c in "id\n":
        fcntl.ioctl(fd, termios.TIOCSTI, c)
```
Now run as root:
# su user
$ python3 /path/to/script.py ; exit
uid=0(root) ...

At least to me, this result was not expected.

I asked it before on kernelnewbies mailing list. [8]
Please set me in CC, because I have not subscribed to this list.

Best and thank you,
Simon

[0] https://lkml.kernel.org/lkml/CAG48ez1NBnrsPnHN6D9nbOJP6+Q6zEV9vfx9q7ME4Eti-vRmhQ@mail.gmail.com/T/
[1] https://lkml.kernel.org/lkml/20170420174100.GA16822@mail.hallyn.com/T/
[2] https://github.com/flatpak/flatpak/issues/2782
[3] https://wiki.ubuntu.com/SecurityTeam/KnowledgeBase/SnapIoctlTIOCSTI
[4] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=815922
[5] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=628843
[6] https://github.com/anthraxx/linux-hardened/commit/d0e49deb1a39dc64e7c7db3340579
[7] https://github.com/anthraxx/linux-hardened/commit/ea8f20602a993c90125bf08da3989
[8] https://www.spinics.net/lists/newbies/msg64019.html
