Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F18145F70E0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 00:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231754AbiJFWDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 18:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbiJFWD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 18:03:26 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 953F51142E2
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 15:03:22 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id a21-20020a5d89d5000000b006b97a46422eso2037573iot.5
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 15:03:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6IJIJqMDGFCohKrd+JKckm0XxXnzTcfpT36QiFBeR1k=;
        b=34R4LF7iDJtMC8Av1PYB4JXjMIu78eYCfzBI7X6kR7AyBlx7DChJ5CzEtjnhL8Gkow
         i/q0JyQekMA+eeKhPUe0GzAerrsmaMYG4dKYDMK3O/PURoElgGctR6EJiGicBQZqef/4
         +WU5kV2iMj82o/NNeFCtWUT8DPIvvskuyvKIx8uvHpSyt6i3BlZlfIDaA+A9ir65ZI6Q
         aK2h+qnr/h9G/P12lhet8QWxv+DLhi9YSc5Izzhf5mBlGX60d5d5jhkTh0LBHySavDp+
         OOuaBy25DxQdDLzjr1958DzA9MQHvuLAvqbTrDk23RdsL3A1NZlgshW8KsiGZq0ts2By
         anKw==
X-Gm-Message-State: ACrzQf1tcSnEpB13Ll+Sk3ez339KOQdxUolE7ueMXoxGU+yA+2lD+gJY
        6RHVxkNK+apEm51hZJI8piYo15lf9B43SEXZUnCFHJaknk+1
X-Google-Smtp-Source: AMsMyM7KLZwAvT/TyGWR3s23yIONUIqRLJBX9fZ6QZxi2gi8K9BnjLAE96clAuT5B8F4fJAnNio39JNRxVmABda5ugAj95A3KOMF
MIME-Version: 1.0
X-Received: by 2002:a02:a682:0:b0:34c:14fc:b490 with SMTP id
 j2-20020a02a682000000b0034c14fcb490mr977406jam.196.1665093801898; Thu, 06 Oct
 2022 15:03:21 -0700 (PDT)
Date:   Thu, 06 Oct 2022 15:03:21 -0700
In-Reply-To: <12068295.O9o76ZdvQC@mypc>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000947b3a05ea64dc75@google.com>
Subject: Re: [syzbot] memory leak in __get_metapage
From:   syzbot <syzbot+389b82b29093b3e2640a@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, fmdefrancesco@gmail.com,
        ira.weiny@intel.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
SYZFATAL: executor failed NUM times: executor NUM: exit status NUM

2022/10/06 22:02:25 SYZFATAL: executor failed 11 times: executor 0: exit status 67
SYZFAIL: wrong response packet
 (errno 16: Device or resource busy)
loop exited with status 67

SYZFAIL: wrong response packet
 (errno 16: Device or resource busy)
loop exited with status 67


Tested on:

commit:         ffb39098 Merge tag 'linux-kselftest-kunit-6.1-rc1' of ..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=167fffb8880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=10f41fbb818af57a
dashboard link: https://syzkaller.appspot.com/bug?extid=389b82b29093b3e2640a
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Note: no patches were applied.
