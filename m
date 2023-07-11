Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF3D74E9F1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 11:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbjGKJMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 05:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjGKJMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 05:12:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D305610A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 02:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689066720;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=85Q9XhFcEQ7sne3jFeH/4l00iIPgXZzgAd+ncDZiCAU=;
        b=YOK8RXXPFRMKsWNiZWDRJ2Pmprkwp6z2LydGFa0QwUJaLpV3rkmY2Q0WCT5yIBhQ0Xdqx0
        dnlWyWkSnLqlDTy3RGV8rj1GuxvZ6L8z5oh9p3sdAFQd0QiJPGIkFbgrhgKas8Jcn3OA5R
        Sy9FYzAyVYQCABmXBykQjfUSI07cNDQ=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-213-XZuwxPuBNzC3LcdHzNHw1w-1; Tue, 11 Jul 2023 05:11:58 -0400
X-MC-Unique: XZuwxPuBNzC3LcdHzNHw1w-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-518676b6d09so3241938a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 02:11:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689066716; x=1691658716;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=85Q9XhFcEQ7sne3jFeH/4l00iIPgXZzgAd+ncDZiCAU=;
        b=FPynfxRtCTfctvkpt6dSpPASA+K4XxtF25Gp9fdPCDrrtSpuffV0Exq0G6n+cioaXj
         bLcYdArp6M3Alxc9yl6OatmHMXCjZB+QIhhMUX2wMK0stXMLuWnUxBawjcFXEWx/MeQm
         3deN+wgugG+p72LWG8OlbLiEu3SZcUHO1IgZrtzHd4KCZiBKIp9xEYfv9XdM7z/wqZPI
         Pasm2qSpvDDkkn4DTXkfwBJ3i2VhMz1aFrvUXRLLjtNUtMcrQchr6QQ/iaMXDRJo3LXH
         6jODtbOpQjbkNqmjCnRcoq1x+vXho5hFjwU+pyfv5/+o0VDGuRjvvzb2zC0M7jlsNR0e
         xpbg==
X-Gm-Message-State: ABy/qLZV7H1ogqq/r9iEoL8LSZNbY+Tb710kp99QEmAx10A3DdlQIHHl
        4xWoQlq/EEAAunpC55JQw6dwy4zrvVkYDhVD7+Jha9TwVdoqKvlN6c084VuZV/xB91mcPlJCnh2
        srOghvA6fvjVMOrnlTGke/JAM5NExGf1FrZ0VB03AnIz96tIwQBU=
X-Received: by 2002:aa7:d28c:0:b0:51a:468c:b46c with SMTP id w12-20020aa7d28c000000b0051a468cb46cmr16205515edq.30.1689066716109;
        Tue, 11 Jul 2023 02:11:56 -0700 (PDT)
X-Google-Smtp-Source: APBJJlF3PvKuunGM43q6hOYibEJTfnUlJmZxT2a/FdHggQlhUVCHa7nQhIxzdVwaqUfeiLaLFiVuTFxQ8qZxstlsokQ=
X-Received: by 2002:aa7:d28c:0:b0:51a:468c:b46c with SMTP id
 w12-20020aa7d28c000000b0051a468cb46cmr16205492edq.30.1689066715712; Tue, 11
 Jul 2023 02:11:55 -0700 (PDT)
MIME-Version: 1.0
From:   Bruno Goncalves <bgoncalv@redhat.com>
Date:   Tue, 11 Jul 2023 11:11:44 +0200
Message-ID: <CA+QYu4qSBdhEgFURu+ouAf2d_JNPbZgCSUaxCLoGzMqDQOLWsQ@mail.gmail.com>
Subject: [6.5.0-rc1] unchecked MSR access error: RDMSR from 0xe2 at rIP:
 0xffffffff87090227 (native_read_msr+0x7/0x40) (intel_idle_init_cstates_icpu)
To:     arjan@linux.intel.com, rafael.j.wysocki@intel.com
Cc:     x86@kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Arjan and Rafael,

I'm not sure if you are the right person to contact about this, but
we've noticed the following call trace when booting on KVM machines
using kernel 6.5.0-rc1:

[    1.089740] io scheduler kyber registered
[    1.091080] io scheduler bfq registered
[    1.094696] atomic64_test: passed for x86-64 platform with CX8 and with =
SSE
[    1.097371] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    1.099559] unchecked MSR access error: RDMSR from 0xe2 at rIP:
0xffffffffa60912d7 (native_read_msr+0x7/0x40)
[    1.102725] Call Trace:
[    1.103547]  <TASK>
[    1.104236]  ? ex_handler_msr+0x121/0x130
[    1.105545]  ? fixup_exception+0x234/0x310
[    1.106858]  ? gp_try_fixup_and_notify+0x1d/0xb0
[    1.108342]  ? exc_general_protection+0x147/0x420
[    1.109838]  ? pcpu_block_refresh_hint+0x87/0xb0
[    1.111309]  ? asm_exc_general_protection+0x26/0x30
[    1.112866]  ? native_read_msr+0x7/0x40
[    1.114099]  intel_idle_init_cstates_icpu.constprop.0+0x762/0x7f0
[    1.116063]  intel_idle_init+0x31b/0x4c0
[    1.117315]  ? __pfx_intel_idle_init+0x10/0x10
[    1.118734]  do_one_initcall+0x5a/0x320
[    1.119981]  kernel_init_freeable+0x31b/0x470
[    1.121373]  ? __pfx_kernel_init+0x10/0x10
[    1.122681]  kernel_init+0x1a/0x1c0
[    1.123796]  ret_from_fork+0x29/0x50
[    1.124963]  </TASK>
[    1.126012] input: Power Button as
/devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
[    1.128477] ACPI: button: Power Button [PWRF]
[    1.163767] ACPI: \_SB_.LNKB: Enabled at IRQ 10
[    1.193831] ACPI: \_SB_.LNKC: Enabled at IRQ 11

We didn't bisect, but the first commit we hit this problem was [1] (6.4.0).

journal log [2], more logs [3] and cki issue tracker [4].

kernel build [5] and kernel config [6].

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3D8d7868c41df58edabc4e408d119a1aef58a54d9d
[2] https://s3.us-east-1.amazonaws.com/arr-cki-prod-datawarehouse-public/da=
tawarehouse-public/926684240/4626306156/redhat%3A926684240/build_x86_64_red=
hat%3A926684240-x86_64-kernel/tests/6/results_0001/job.01/recipes/14200798/=
tasks/5/results/1689014206/logs/journalctl.log
[3] https://datawarehouse.cki-project.org/kcidb/tests/8725936
[4] https://datawarehouse.cki-project.org/issue/2128
[5] https://s3.amazonaws.com/arr-cki-prod-trusted-artifacts/trusted-artifac=
ts/926684240/publish%20x86_64/4626306101/artifacts/kernel-mainline.kernel.o=
rg-redhat_926684240-x86_64-kernel.tar.gz
[6] https://s3.amazonaws.com/arr-cki-prod-trusted-artifacts/trusted-artifac=
ts/926684240/build%20x86_64/4626306065/artifacts/kernel-mainline.kernel.org=
-redhat_926684240-x86_64-kernel.config

Thanks,
Bruno Goncalves

