Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28512651387
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 20:56:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232445AbiLST43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 14:56:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232506AbiLST4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 14:56:17 -0500
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 056C4DF12
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 11:56:17 -0800 (PST)
Received: by mail-io1-f72.google.com with SMTP id a14-20020a6b660e000000b006bd37975cdfso4543423ioc.10
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 11:56:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cj5G7w7wrnXTjWG4Lf9C2ODteMMiP5v7wAraEGH3U0k=;
        b=FhkLsZXcH9tIcvQmov6wvXADE8ga+0Ae/8XGkbU8PNf2SSTYKSWSuYywFOqGaExKLa
         C4Qsj6mdHiO0IePZMxAVCauaUYbnJZVBDRRzLDNZoBjErK/MCnyByiGYiqwGVYrwCWuZ
         BSIbrRN1egWx19A38knFBbgJdUFogVSV3y4G5snxc5jG8cneewkYZzUzCYWtRPl3CBZl
         3RbFLofi/KZJuPmJD9GsMZizGlndY0eFXFP+tHOvqRxjQU/wprIgvom2HyH9fXyqtHoi
         rQ8PqcJLtz+JmYwBcqd5G/CKpEHRtsTWSY4wrdpa0+ckzS8yXDZYhurcJRMUpNDeFccX
         5FWw==
X-Gm-Message-State: ANoB5pkVqPhfEGoianM/AWdthXH7zivmr4XYrbA4i6NCrd9q8cElW6oc
        SZE+2CJ88jL/gnsZ0bUfk+/xP645Itnw9Jy4HUDDzakcixEQ
X-Google-Smtp-Source: AA0mqf7eE0GC/Cb+W5QzJIxt46Tbcb3KvugY9SCOhpmm/M5g7dQmZkOk8OKjjh9bxyYHJeuaULjQLcDPviCk4OX2G41hWkxQ25I2
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:13c1:b0:303:7f25:72c with SMTP id
 v1-20020a056e0213c100b003037f25072cmr7289815ilj.221.1671479776357; Mon, 19
 Dec 2022 11:56:16 -0800 (PST)
Date:   Mon, 19 Dec 2022 11:56:16 -0800
In-Reply-To: <Y6C8iQGENUk/XY/A@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000051b79a05f033b6e5@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in put_pmu_ctx
From:   syzbot <syzbot+b8e8c01c8ade4fe6e48f@syzkaller.appspotmail.com>
To:     acme@kernel.org, alexander.shishkin@linux.intel.com,
        bpf@vger.kernel.org, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        mark.rutland@arm.com, mingo@redhat.com, namhyung@kernel.org,
        netdev@vger.kernel.org, peterz@infradead.org, sdf@google.com,
        syzkaller-bugs@googlegroups.com
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

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file kernel/events/core.c
patch: **** unexpected end of file in patch



Tested on:

commit:         13e3c779 Merge tag 'for-netdev' of https://git.kernel...
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git
dashboard link: https://syzkaller.appspot.com/bug?extid=b8e8c01c8ade4fe6e48f
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15861a9f880000

