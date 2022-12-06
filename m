Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4599F643BEB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 04:34:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232548AbiLFDe4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 22:34:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbiLFDey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 22:34:54 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C13D817AA5
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 19:34:53 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id a9so12710778pld.7
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 19:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PHYJa3J3t18km/Z2gjWUFE8PEpWCpwo/WtNH2bdNblg=;
        b=g5AGkeK8aEcms//ZBvjF0SoZMgsokz8SkcXL3u4h2va7941ALx6Gv9sCD6rySUhC9w
         EaYjJLsy62c5nbf9Et6aotaahkeO91Njqn9nAQCuou7On7iZ8fjDpSZ9nAc3zp7v7n7y
         XIf5B8M1QlnQn1Jj8VpwpMu8ZxU6oCSAOCoB59COU2KDXwUTE27K0Zq74hOS83Pqel33
         hb99S7wtBLtGDQdtcaBHJcmCsWCZmS5BDqI4fH60FiwmR5qAIn4kIYwSowH3z/yYqHok
         eEsUYTG6RB+pb70aIyCRxJ9sQlu3nIGErYPVzkZxOAsgTNmfVOHW1H8W0TmSvrgexPNx
         cySg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PHYJa3J3t18km/Z2gjWUFE8PEpWCpwo/WtNH2bdNblg=;
        b=zeOYSoebr0mNP4XYVChKw5Xy2zWnsfp3pfWE3D/YhyNzZzUDHpAdfBT54nKVodz7bs
         wtEVh8E3kluJbcke9cSyGPDt3gQkxM6fMUZ6zm94id0wo3i5yydXJf3ipRxgGLTMJmhm
         YabPY3Mxi7f/LaUbiZQwIuC7JK3StfJQs6ATH9W6PLXi+2Ew81PLjA02gxlqQx5T1wSn
         lKYZyG6HKKTLSr9FIV74w7cWRgiWAka5tfuLV9LTX/0tOix9dRd/z8cWUDIM1mg9WwH1
         DRhKI5qW50qyE37iNVvmbegYPR5G3lkkjm+F7PaYD3HWDgSANSHXaBcAreptq06XeXFX
         +Gyg==
X-Gm-Message-State: ANoB5pkztbWgyVHwj2PajWabmZdHgOw5FFo7FrIzuWMwUEstmIh+4AKg
        /FPYKwThQ2gggZz5tYEzoHdotg==
X-Google-Smtp-Source: AA0mqf6KDYdtsr9TKVQrgpUHo/vuLpTuRfrjeB9qfVGWssoqjFUriHxIUq14JbVAxVq7WZFeBDI2wA==
X-Received: by 2002:a17:90b:793:b0:218:9c4f:e97 with SMTP id l19-20020a17090b079300b002189c4f0e97mr83419380pjz.2.1670297693353;
        Mon, 05 Dec 2022 19:34:53 -0800 (PST)
Received: from dread.disaster.area (pa49-181-54-199.pa.nsw.optusnet.com.au. [49.181.54.199])
        by smtp.gmail.com with ESMTPSA id a14-20020a170902ecce00b00186b1bfbe79sm11372053plh.66.2022.12.05.19.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 19:34:52 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1p2OjK-0052kM-6w; Tue, 06 Dec 2022 14:34:50 +1100
Date:   Tue, 6 Dec 2022 14:34:50 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     syzbot <syzbot+912776840162c13db1a3@syzkaller.appspotmail.com>
Cc:     djwong@kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] KASAN: use-after-free Read in xfs_qm_dqfree_one
Message-ID: <20221206033450.GS3600936@dread.disaster.area>
References: <000000000000bd587705ef202b08@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000bd587705ef202b08@google.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 05, 2022 at 07:12:15PM -0800, syzbot wrote:
> Hello,
> 
> syzbot has tested the proposed patch but the reproducer is still triggering an issue:
> INFO: rcu detected stall in corrupted
> 
> rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { P4122 } 2641 jiffies s: 2877 root: 0x0/T
> rcu: blocking rcu_node structures (internal RCU debug):

I'm pretty sure this has nothing to do with the reproducer - the
console log here:

> Tested on:
> 
> commit:         bce93322 proc: proc_skip_spaces() shouldn't think it i..
> git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> console output: https://syzkaller.appspot.com/x/log.txt?x=1566216b880000

indicates that syzbot is screwing around with bluetooth, HCI,
netdevsim, bridging, bonding, etc.

There's no evidence that it actually ran the reproducer for the bug
reported in this thread - there's no record of a single XFS
filesystem being mounted in the log....

It look slike someone else also tried a private patch to fix this
problem (which was obviously broken) and it failed with exactly the
same RCU warnings. That was run from the same commit id as the
original reproducer, so this looks like either syzbot is broken or
there's some other completely unrelated problem that syzbot is
tripping over here.

Over to the syzbot people to debug the syzbot failure....

-Dave.

-- 
Dave Chinner
david@fromorbit.com
