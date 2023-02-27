Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE1F06A4D85
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 22:46:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbjB0Vqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 16:46:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbjB0Vq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 16:46:27 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E89298C7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 13:46:11 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id bh1so8266167plb.11
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 13:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mXgojBwrlxtAqkqi3m8eA8saXCE8aC8dYvlKT0132G8=;
        b=qm5ux6gnD5DjmItwJsdIJ2BBKADH1JcBq3kTwtFWTBJW+Cg5DL53I4/MU2Juj0bUkk
         gMMYmiYa8DpdOBfSY5SFVpNJYH2fCoMOpKPQeeQNtKcPI/pCZMKqF+ruBiprzNydctGK
         c2M5V48o1EcgjhU2yCbhPqkJTQf7fwX2UE3ucEVrEdRzLd6eDdcamxv6vItr/PCbxNYP
         PjHv8BqmbmEv+m0NwK0V6M5lkTUF/raLlk60FfaMZK2cfPqH5hv5ruw2FeWTuLd8qMNx
         WEaZGoxek4024i+78l/nKMuB3zLfvbgFoqk4MZj/icKngIBjOLwu7Ez4CyaMVDG2welh
         RDKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mXgojBwrlxtAqkqi3m8eA8saXCE8aC8dYvlKT0132G8=;
        b=1IMfvv9dPnPdrt9e/oPrY5YSvt2luM13wAUSUkvbLc4HdtK4lu5k2wAQPrNzqjTmnh
         Q1RfWlm9A33JP2pwTfM0kgy4Lm5KpEuR5TqNhuaZReprfLg+CkkubkbcNVHxagfQA3aB
         cQHPpkmsCnRpu3GFKi7TuEULDLNCNB8ZpuJNot2GTMfdIOVn1lp4Xf2zRdQuc/1nZ5t8
         4goyDet0fcN5z1c5RTaXraCNfN4F19K6gFr8aTLnLXT4lsAlxTlhhcpgIFNepNm4MNkq
         iyl/8DaNRHfvIVUF+AmIrpD5PTBRlqvuiJLtXc0sa//ngsapbmH+wpDxl4W1AR2UiDrr
         9RdA==
X-Gm-Message-State: AO0yUKVwaoRPb5c5bINa49et6/f/1vBdc5JmomkMo5CgBpMKrEcedJYt
        lUfWPXuuXctEiZLdYO+C5hG9PDUtiA0iejM0
X-Google-Smtp-Source: AK7set+RaJjdc/yi8v5IzW1B2wtX/FN5jbCYbEoHd/Mbo9tOb8tVGchKcWTC2jhLVHnO9/NC99l8LQ==
X-Received: by 2002:a17:902:e851:b0:19a:839f:435 with SMTP id t17-20020a170902e85100b0019a839f0435mr10097058plg.3.1677534370439;
        Mon, 27 Feb 2023 13:46:10 -0800 (PST)
Received: from dread.disaster.area (pa49-186-4-237.pa.vic.optusnet.com.au. [49.186.4.237])
        by smtp.gmail.com with ESMTPSA id q6-20020a170902a3c600b0019608291564sm5065061plb.134.2023.02.27.13.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 13:46:09 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1pWlJv-002szD-7q; Tue, 28 Feb 2023 08:46:07 +1100
Date:   Tue, 28 Feb 2023 08:46:07 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Pengfei Xu <pengfei.xu@intel.com>
Cc:     Helge Deller <deller@gmx.de>,
        linux-xfs <linux-xfs@vger.kernel.org>, asml.silence@gmail.com,
        geert@linux-m68k.org, linux-kernel@vger.kernel.org,
        heng.su@intel.com
Subject: Re: [Syzkaller & bisect] There is "xfs_dquot_alloc" related BUG in
 v6.2 in guest
Message-ID: <20230227214607.GB360264@dread.disaster.area>
References: <Y/g/femUL7jZ9gF3@xpf.sh.intel.com>
 <a39d97c1-2ced-d159-f742-e5c6008f79ee@gmx.de>
 <20230226223403.GU360264@dread.disaster.area>
 <Y/xbyABFGZEeKduv@xpf.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/xbyABFGZEeKduv@xpf.sh.intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 27, 2023 at 03:29:12PM +0800, Pengfei Xu wrote:
> Hi Dave and Helge Deller,
> 
> Thanks Helge Deller to add the xfs mailing list!
> 
> On 2023-02-27 at 09:34:03 +1100, Dave Chinner wrote:
> > On Sat, Feb 25, 2023 at 08:58:25PM +0100, Helge Deller wrote:
> > > Looping in xfs mailing list as this seems to be a XFS problem...
> > > On 2/24/23 05:39, Pengfei Xu wrote:
> > > > [   71.225966] XFS (loop1): Quotacheck: Unsuccessful (Error -5): Disabling quotas.
> > > > [   71.226310] xfs filesystem being mounted at /root/syzkaller.qCVHXV/0/file0 supports timestamps until 2038 (0x7fffffff)
> > > > [   71.227591] BUG: kernel NULL pointer dereference, address: 00000000000002a8
> > > > [   71.227873] #PF: supervisor read access in kernel mode
> > > > [   71.228077] #PF: error_code(0x0000) - not-present page
> > > > [   71.228280] PGD c313067 P4D c313067 PUD c1fe067 PMD 0
> > > > [   71.228494] Oops: 0000 [#1] PREEMPT SMP NOPTI
> > > > [   71.228673] CPU: 0 PID: 161 Comm: kworker/0:4 Not tainted 6.2.0-c9c3395d5e3d #1
> > > > [   71.228961] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> > > > [   71.229400] Workqueue: xfs-inodegc/loop1 xfs_inodegc_worker
> > > > [   71.229626] RIP: 0010:xfs_dquot_alloc+0x95/0x1e0
> > > > [   71.229820] Code: 80 15 ad 85 48 c7 c6 7c 6b 92 83 e8 75 0f 6b ff 49 8b 8d 60 01 00 00 44 89 e0 31 d2 48 c7 c6 18 ae 8f 83 48 8d bb 18 02 00 00 <f7> b1 a8 02 2
> > > > [   71.230528] RSP: 0018:ffffc90000babc20 EFLAGS: 00010246
> > > > [   71.230737] RAX: 0000000000000009 RBX: ffff8880093c98c0 RCX: 0000000000000000
> > > > [   71.231014] RDX: 0000000000000000 RSI: ffffffff838fae18 RDI: ffff8880093c9ad8
> > > > [   71.231292] RBP: ffffc90000babc48 R08: 0000000000000002 R09: 0000000000000000
> > > > [   71.231570] R10: ffffc90000baba80 R11: ffff88800af08d98 R12: 0000000000000009
> > > > [   71.231850] R13: ffff88800c4bc000 R14: ffff88800c4bc000 R15: 0000000000000004
> > > > [   71.232129] FS:  0000000000000000(0000) GS:ffff88807dc00000(0000) knlGS:0000000000000000
> > > > [   71.232441] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > [   71.232668] CR2: 00000000000002a8 CR3: 000000000a1d2002 CR4: 0000000000770ef0
> > > > [   71.232949] PKRU: 55555554
> > > > [   71.233061] Call Trace:
> > > > [   71.233162]  <TASK>
> > > > [   71.233254]  xfs_qm_dqread+0x46/0x440
> > > > [   71.233410]  ? xfs_qm_dqget_inode+0x13e/0x500
> > > > [   71.233596]  xfs_qm_dqget_inode+0x154/0x500
> > > > [   71.233774]  xfs_qm_dqattach_one+0x142/0x3c0
> > > > [   71.233961]  xfs_qm_dqattach_locked+0x14a/0x170
> > > > [   71.234149]  xfs_qm_dqattach+0x52/0x80
> > > > [   71.234307]  xfs_inactive+0x186/0x340
> > > > [   71.234461]  xfs_inodegc_worker+0xd3/0x430
> > > > [   71.234630]  process_one_work+0x3b1/0x960
> > > > [   71.234802]  worker_thread+0x52/0x660
> > > > [   71.234957]  ? __pfx_worker_thread+0x10/0x10
> > > > [   71.235136]  kthread+0x161/0x1a0
> > > > [   71.235279]  ? __pfx_kthread+0x10/0x10
> > > > [   71.235442]  ret_from_fork+0x29/0x50
> > > > [   71.235602]  </TASK>
> > > > [   71.235696] Modules linked in:
> > > > [   71.235826] CR2: 00000000000002a8
> > > > [   71.235964] ---[ end trace 0000000000000000 ]---
> > 
> > Looks like a quota disable race with background inode inactivation
> > reading in dquots.
> > 
> > Can you test the patch below?
> > 
> Thanks for your fixed patch in short time!
> I installed below patch on top of v6.2 kernel.
> And there was no any BUG dmesg anyway, so the fixed patch worked.
> 
> And left some "Internal error xfs_iunlink_remove_inode" related Call Trace.
> I'm new to xfs, could you help to check if it is some other issue or we
> could ignore it.

I'm guessing this the filesystem detecting a corruption and shutting
down. That's normal behaviour when tools like syzkaller through
random crap at the filesystem and expect it to like it.

> I put the dmesg in bugzilla attachment as follow:
> https://bugzilla.kernel.org/show_bug.cgi?id=217078 ->
> https://bugzilla.kernel.org/attachment.cgi?id=303793

I am not authorised to access bug 217078, so I can't read any of
this. Just cut out and attach the relevant dmesg output to the email.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
