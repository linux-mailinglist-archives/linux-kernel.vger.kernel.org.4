Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52F2274E06C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 23:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbjGJVtw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 17:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbjGJVtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 17:49:51 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F25F4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 14:49:46 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5706641dda9so54813917b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 14:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689025786; x=1691617786;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7DYPBH6oK2/jBu853UJwxKE1C9UW9Ev/XP8Mk4wg4nU=;
        b=Z9OkOdC7v7kANi7li+3Ah1hsq6n4P6TS49EuaZw+AL0Qx2wD28axviRfV8OAbZsfVo
         zieEVG+8bbE0VBd7Tj6Bssw4qBjlfnM18FZpHezXGSNCnTRbCHxTv2gAXeax4TpppNU1
         HR9sLMQZ60IcPsndILzaZfUBgYw3ZLkElFdporGGvYpoawfF+vjOHp+JAEd8PcImwiin
         PzoA9blTv1KJyMcDTGufuyconRDMEucLFGWUJaHCKyaSDbLn8aIPyKoj/JlpytzOF0eQ
         IQOb2aSzcnU/HGF5hhoUXMWUFtJUKbkNUPziTp4exw6ru0vsAu+0w6C/YWgSdCfTFbHu
         IONg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689025786; x=1691617786;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7DYPBH6oK2/jBu853UJwxKE1C9UW9Ev/XP8Mk4wg4nU=;
        b=jBOJUau7XfdKmyTTeiE1arR8MGLIvztOFPe6o4uKmcjKuAcZvQD+QAa0CxPmx9zOhm
         YckNsMTSqnqkqCj78hM4ZmU0EuxjnPoN//Bg+dRu7YZm2iJPT3eeJB1mVNFDcdBfmDhV
         Z6Wigg9yxzw2G0Ahnni2ifKK2M+zvNWQDo6JSSdHKQapi8+ItPt5TU/8feUMcZySdTAA
         32fhgNIC8QuBq0Gkpdl+ARS6M/lka3EaEwRtDVOpyinjqCyld1OLs653dpS9NED4WRB7
         mDJ84oRuKIWK2XU7A638TAjgx+bFb66ba0rHvaYQEZDT+bJ64dEHB5bhplwq6BHcqLjJ
         FvFA==
X-Gm-Message-State: ABy/qLYF1a+pDzOJvRrltKT1b9SOj0+Y+f0/ZccdgQ47gTdaz8Q1dXli
        C07BaAObOE85X6eqCVyiYAGI6JyFMCM=
X-Google-Smtp-Source: APBJJlGCkHo5gVjHgSrEiq7NqsZL5Yi7+/Sw4GFzyGGPf/EbjCvCRlTJa/ftZ6zOd9x5QPLVZStgg2kerIo=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:4312:0:b0:579:fa4c:1f25 with SMTP id
 q18-20020a814312000000b00579fa4c1f25mr101418ywa.7.1689025785825; Mon, 10 Jul
 2023 14:49:45 -0700 (PDT)
Date:   Mon, 10 Jul 2023 14:49:44 -0700
In-Reply-To: <0000000000005ca92705d877448c@google.com>
Mime-Version: 1.0
References: <0000000000005ca92705d877448c@google.com>
Message-ID: <ZKx8+B3gI9/1g5A3@google.com>
Subject: Re: [syzbot] WARNING in kthread_bind_mask
From:   Sean Christopherson <seanjc@google.com>
To:     syzbot <syzbot+087b7effddeec0697c66@syzkaller.appspotmail.com>
Cc:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Trimmed the Cc list to avoid annoying folks with my thread necromancy.

On Sun, Feb 20, 2022, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    c5d9ae265b10 Merge tag 'for-linus' of git://git.kernel.org..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=11daf74a700000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=da674567f7b6043d
> dashboard link: https://syzkaller.appspot.com/bug?extid=087b7effddeec0697c66
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+087b7effddeec0697c66@syzkaller.appspotmail.com
> 
> BTRFS info (device loop3): disk space caching is enabled
> BTRFS info (device loop3): has skinny extents
> ------------[ cut here ]------------

Dropping the "kvm" label as this isn't a KVM bug, but rather something in either
workqueues or sched that KVM often triggers through its use of alloc_workqueue().

#syz set subsystems: kernel
