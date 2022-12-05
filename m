Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D1DB64252E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 09:57:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232277AbiLEI5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 03:57:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232289AbiLEI4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 03:56:24 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DA2718377
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 00:55:31 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id bp15so17417746lfb.13
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 00:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dLWzdPiDhqNrCWntC1/FUKJpulZ8HdtXHKh/ol869SA=;
        b=hjCxc3ezNh4mCmjQ8w7ZYRHweJpE8HnNlruc6kTLhdRUifGDAW/morztX0r4/rPlhe
         roz8gZaATRgK/ih62swWoHw+0k/Jlqqdphp2VHqz8wVWTcYsS75caY5+82XTXlArE/Jb
         7gIO/uer9U7JMswofvaJxCsz6Lmmia2AePIjtsnVIElnNdC9L36ata3SssDYTBnAHfQ6
         2xiZ9rK3/z9obmp+KK9U9okTJksMvJFt0VetJn+gqgVk/DXo0apE289c3+pBlJK/PoYo
         P1yuPyWSc7l7Lty1eK3D6AOGMFqimS9niyQpmPwYrdyeq0CR6l1SbQVsAtD9tt020O9y
         HicA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dLWzdPiDhqNrCWntC1/FUKJpulZ8HdtXHKh/ol869SA=;
        b=p1/yu6AaUAt1VGbzWQRz0qKEy1L54jrYJSddl2x12RlCDybAM6ehR3UPhRo6LpTErp
         rpI1V0OXOfc5Fdfv+mzF5vn79sJpbNRf0OVrpEa2gRfEU4myilugtBmiHfyjnHGtFydv
         GopLSZVPkB8IBon6fZMeUUAHVweehTBN28d4YuFhEsLoCCcfEzLSGShQXIJmlrEazrTR
         e0ROuL8pFUkcTtkPC5TOL9JbW36WFf17BA+Yy63PPLqhkhWmZVyPNS3QzB+vOI+fkyfV
         ZfS9bCylao4GxZKLxqW/iy58QmiMlVcY7Fm9e03FgmjGZp29lBoVeQDyPJ/mRxcwgZLz
         BqEg==
X-Gm-Message-State: ANoB5pnEv/iYxTBKR4M/5B5+ajdvd6MrgpL1aWg+Cxpn2OPwi4tfcueW
        ss1LS0poLskufgl9ONw/dXVjHZ9lVz+GF8cqBPfw8A==
X-Google-Smtp-Source: AA0mqf6GX+TnJ7Exv96fcy3Uo4snviPJbX7NeDqFYptUQiQXTe8Mb4VGt20HctmD6/lwKqfriXgvBRTU78d2fUWewto=
X-Received: by 2002:a05:6512:3413:b0:4aa:b3d1:9c83 with SMTP id
 i19-20020a056512341300b004aab3d19c83mr20227525lfr.260.1670230529349; Mon, 05
 Dec 2022 00:55:29 -0800 (PST)
MIME-Version: 1.0
References: <CABymUCOsVcpaS+uXqzB7-hm0FZwm2ZXD8J=6m0NKAh8WyrTiwA@mail.gmail.com>
In-Reply-To: <CABymUCOsVcpaS+uXqzB7-hm0FZwm2ZXD8J=6m0NKAh8WyrTiwA@mail.gmail.com>
From:   Jun Nie <jun.nie@linaro.org>
Date:   Mon, 5 Dec 2022 16:54:02 +0800
Message-ID: <CABymUCP32_95eTeEbfWCPEUBCj4XBMU5=2-hRBLw9SoTFt_6XQ@mail.gmail.com>
Subject: [BUG REPORT] kernel BUG in ext4_write_inline_data_end or ext4_writepages
To:     harshadshirwadkar@gmail.com, tytso@mit.edu,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ye Bin <yebin@huaweicloud.com>
Cc:     Lee Jones <joneslee@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
syzbot find a new bug[1] in ext4 that's similar with bug[0], that
leads to reboot.
While the bug[0] can be fixed with patch[2] from Bin. This new bug is still
triggered with the patch[2], and log[3] is collected. Both log[1] and
log[3] are
collected when testing bug[4] on the mainline.

[0] https://syzkaller.appspot.com/bug?id=5bafe4554067100b70f58a81268aa06ea3f9c345
[1] https://syzkaller.appspot.com/text?tag=CrashLog&x=16325fc3880000
[2] https://lore.kernel.org/lkml/CABymUCN+NSzkunRqFs8LgqjT6vXz-gyyZYn0hQWf8V9kmcO0Hw@mail.gmail.com/T/
[3] https://syzkaller.appspot.com/text?tag=CrashLog&x=155abe7b880000
[4] https://syzkaller.appspot.com/bug?id=899b37f20ce4072bcdfecfe1647b39602e956e36


[   38.932317][  T494] Call Trace:
[   38.935437][  T494]  <TASK>
[   38.938393][  T494]  ext4_write_inline_data_end+0xa39/0xdf0
[   38.943946][  T494]  ? put_page+0xa0/0xa0
[   38.947936][  T494]  ? ext4_da_write_begin+0x6f0/0x8d0
[   38.953055][  T494]  ? pipe_zero+0x240/0x240
[   38.957308][  T494]  ext4_da_write_end+0x1e2/0x950
[   38.962082][  T494]  ? ext4_da_write_begin+0x8d0/0x8d0
[   38.967204][  T494]  generic_perform_write+0x401/0x5f0
[   38.972326][  T494]  ? generic_file_direct_write+0x6c0/0x6c0
[   38.977994][  T494]  ? generic_write_checks_count+0x4b0/0x4b0
[   38.983694][  T494]  ext4_buffered_write_iter+0x35f/0x640
[   38.989074][  T494]  ext4_file_write_iter+0x198/0x1cd0
[   38.994194][  T494]  ? futex_unqueue+0x156/0x180
[   38.998795][  T494]  ? futex_wait+0x4c5/0x5c0
[   39.003307][  T494]  ? futex_wait_setup+0x320/0x320
[   39.008168][  T494]  ? avc_policy_seqno+0x1b/0x70
[   39.012862][  T494]  ? ext4_file_read_iter+0x470/0x470
[   39.017976][  T494]  vfs_write+0x8b5/0xef0
[   39.022056][  T494]  ? file_end_write+0x1b0/0x1b0
[   39.026739][  T494]  ? mutex_lock+0xb6/0x130
[   39.030994][  T494]  ? bit_wait_io_timeout+0x110/0x110
[   39.036117][  T494]  ? __fget_files+0x2d9/0x330
[   39.040630][  T494]  ? __fdget_pos+0x268/0x300
[   39.045054][  T494]  ? ksys_write+0x77/0x2c0
[   39.049307][  T494]  ksys_write+0x198/0x2c0
[   39.053472][  T494]  ? save_fpregs_to_fpstate+0x210/0x210
[   39.058855][  T494]  ? __ia32_sys_read+0x90/0x90
[   39.063465][  T494]  ? __kasan_check_write+0x14/0x20
[   39.068403][  T494]  ? switch_fpu_return+0x129/0x270
[   39.073348][  T494]  __x64_sys_write+0x7b/0x90
[   39.077783][  T494]  do_syscall_64+0x2f/0x50
[   39.082030][  T494]  entry_SYSCALL_64_after_hwframe+0x63/0xcd

Regards,
Jun
