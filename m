Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD576BBD88
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 20:46:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232934AbjCOTqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 15:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232916AbjCOTpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 15:45:52 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EAE7A0B3D
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 12:45:30 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id n42-20020a056602342a00b0074cde755b99so10222290ioz.16
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 12:45:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678909527;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m3gz3xsJlzi9I/BXzFPtsw6/RKirgL0ojbtilyzyWGE=;
        b=nCjc5kogYV74yQiDVVlMS7SU/trhB6kJjm05ZY8qex1ys8jbieRgAiPp2+6rUtgPMz
         g0Cpvrtx6oMWXVYXzic7qyZb7BVxlH6ffA30vbNFXNz2c2mbeNDds9FfVaoxB1cub0mt
         7mivgYyTHHdys8RZCHgEtWPdMSjT4RWZPWIZbvO7QD9r0HXuRElJq3sT8TR1loUlX0b1
         9dhrY8nwLEnwCebTlJ35BOdGnuB7DuOZpOrMip0unsWXHfk46Mp8IMWWjHoe0U80jBkw
         4oSfO69qc7tA6f0hXj006H29ArYEgXgfjGcYB4OCCDmlrYYaTY5oxqmkQokqxkwnbxMN
         zWoQ==
X-Gm-Message-State: AO0yUKUArzVdFwnV0Z+1I6xiWDv58u3pqb5fNsrj7kleZIVfzno6+LQn
        gNdG2MPRy0Yug0V3YMEa37NB5VFQXewZbod4yETg7fuHi3nQ
X-Google-Smtp-Source: AK7set8fj6jN1Lm8Vd5kFbwsbJx/1p5jwVjR5Rpi7WCEVbJXjCGwFDxGta/+oQ0yxwHls60hwXX91LG2M0ZBAaZ3L8AAZv4sWQjY
MIME-Version: 1.0
X-Received: by 2002:a02:85aa:0:b0:3f6:657a:e922 with SMTP id
 d39-20020a0285aa000000b003f6657ae922mr18093097jai.5.1678909527609; Wed, 15
 Mar 2023 12:45:27 -0700 (PDT)
Date:   Wed, 15 Mar 2023 12:45:27 -0700
In-Reply-To: <20230315193521.jcox7j3is24gk6mj@fpc>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000000dabd05f6f59668@google.com>
Subject: Re: [syzbot] [wireless?] KMSAN: uninit-value in ath9k_hw_init
From:   syzbot <syzbot+df61b36319e045c00a08@syzkaller.appspotmail.com>
To:     glider@google.com, linux-kernel@vger.kernel.org,
        pchelkin@ispras.ru, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file drivers/net/wireless/ath/ath9k/wmi.c
Hunk #1 FAILED at 200.
Hunk #2 succeeded at 234 (offset -8 lines).
Hunk #3 succeeded at 291 (offset -8 lines).
Hunk #4 succeeded at 302 (offset -8 lines).
Hunk #5 succeeded at 347 (offset -8 lines).
1 out of 5 hunks FAILED



Tested on:

commit:         34add094 kmsan: add test_stackdepot_roundtrip
git tree:       https://github.com/google/kmsan.git master
dashboard link: https://syzkaller.appspot.com/bug?extid=df61b36319e045c00a08
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=124d82a4c80000

