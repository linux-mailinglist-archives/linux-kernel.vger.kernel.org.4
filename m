Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3F1E62B307
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 06:58:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbiKPF6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 00:58:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiKPF6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 00:58:19 -0500
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49E08220DD
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 21:58:18 -0800 (PST)
Received: by mail-io1-f69.google.com with SMTP id z139-20020a6bc991000000b006dac0d359edso8174161iof.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 21:58:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YWvo2jzqIvuQGsdWFUrnJDvcO8++2ictjA/IpetI45E=;
        b=EeqNlh0LbuKSgDNFmtilUzAkoiyjK41vOMQ7hNvs/CjKn88UjLSkaGoHLR2UyAGD9b
         RTBCfESKMEC8ULdK3m6tdRdDswJFECuJIllTTgC8QIdY87kKT6CA3LYX5etsv/GmKjC4
         Xo8ogzbX6gdOE6XyEp0fi6Bcqp9IVttMc1xTKbpuB6R1nG/BdA0cSVsXaUeb/2q1Ecu5
         hQqRdpnyZwVcWjE2utuOhdUralHSkzLYxN8/XJcL9ELl9H+AvJ5Tcg8mBC12Mo2Kfp63
         pRkHW9DBFwVPGoZX2m23yG1kdZTPw6X2pX/Yktx3ENv2kdvDmoSZG/UrdCMeUZjMsXKw
         2T/A==
X-Gm-Message-State: ANoB5pmdrTyrpemvwWZiQKOsQ2F9TrmOskddAOgQ/8u9SiKFNyco9H82
        oTgWXUXz+qxOfsksBSIRIApb0rnD6qg074C+VsTwTk3p56T2
X-Google-Smtp-Source: AA0mqf4eQ+jC+4kQp1fyoHwTeHCiA+2rGPTxKMj9hH+QL4+iJxL3kVD4fiZufqI/RC4CBO/Wqdo1BP9YRy3HaayfCg5kppIlBpH+
MIME-Version: 1.0
X-Received: by 2002:a02:3408:0:b0:373:d769:bc14 with SMTP id
 x8-20020a023408000000b00373d769bc14mr10172237jae.264.1668578297655; Tue, 15
 Nov 2022 21:58:17 -0800 (PST)
Date:   Tue, 15 Nov 2022 21:58:17 -0800
In-Reply-To: <000000000000cceef005ed659943@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b63a2805ed90289d@google.com>
Subject: Re: [syzbot] possible deadlock in virtual_nci_close
From:   syzbot <syzbot+8040d16d30c215f821de@syzkaller.appspotmail.com>
To:     bongsu.jeon@samsung.com, clement.perrochaud@nxp.com,
        davem@davemloft.net, dvyukov@google.com, hdanton@sina.com,
        krzysztof.kozlowski@linaro.org, kuba@kernel.org,
        linux-kernel@vger.kernel.org, michael.thalmeier@hale.at,
        netdev@vger.kernel.org, r.baldyga@samsung.com,
        robert.dolca@intel.com, sameo@linux.intel.com, shikha.singh@st.com,
        syzkaller-bugs@googlegroups.com, thierry.escande@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit e624e6c3e777fb3dfed036b9da4d433aee3608a5
Author: Bongsu Jeon <bongsu.jeon@samsung.com>
Date:   Wed Jan 27 13:08:28 2021 +0000

    nfc: Add a virtual nci device driver

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1093fb59880000
start commit:   094226ad94f4 Linux 6.1-rc5
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1293fb59880000
console output: https://syzkaller.appspot.com/x/log.txt?x=1493fb59880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7d516a992a8757b5
dashboard link: https://syzkaller.appspot.com/bug?extid=8040d16d30c215f821de
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1360e2f1880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14a95659880000

Reported-by: syzbot+8040d16d30c215f821de@syzkaller.appspotmail.com
Fixes: e624e6c3e777 ("nfc: Add a virtual nci device driver")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
