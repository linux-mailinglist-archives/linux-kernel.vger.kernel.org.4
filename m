Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39CCE712493
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 12:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243120AbjEZKZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 06:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243072AbjEZKZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 06:25:52 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A4EC134
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 03:25:36 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R921e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=durui@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VjW4mAL_1685096732;
Received: from localhost(mailfrom:durui@linux.alibaba.com fp:SMTPD_---0VjW4mAL_1685096732)
          by smtp.aliyun-inc.com;
          Fri, 26 May 2023 18:25:33 +0800
From:   Du Rui <durui@linux.alibaba.com>
To:     snitzer@kernel.org
Cc:     agk@redhat.com, alexl@redhat.com, dm-devel@redhat.com,
        durui@linux.alibaba.com, gscrivan@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: Re: dm overlaybd: targets mapping OverlayBD image
Date:   Fri, 26 May 2023 18:25:32 +0800
Message-Id: <20230526102532.29276-1-durui@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <ZGz32yw7ecKhW+lj@redhat.com>
References: <ZGz32yw7ecKhW+lj@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike:

> I appreciate that this work is being done with an eye toward
> containerd "community" and standardization 

> it appears that this format of OCI image storage/use is only
> used by Alibaba? 

> But you'd do well to explain why the userspace solution isn't
> acceptable.

Yes overlaybd has origins in container community, but this work (kernel 
modules) does *NOT* actually target at container. Because on-demand lazy
loading of container images involves complex interactions with the image 
registry through HTTP(s) protocol, and possibly with other transport 
serivces (like HTTP proxy, sock5 proxy, P2P, cache, etc.). This is better 
implemented in user-space and finally exported to kernel as a virtual 
block device like TCMU or ublk. The user-space impl of Overlaybd has a 
very large install base in Alibaba, as well as some other big companies, 
including another major cloud provider. (We'd better not unveil their
names before we get their permissions). And We are pleased with the
flexibility in user-space that allows for easy integration to various 
systems / environments.

We implement this kernel module and try to contribute it to upstream
because we belive it is useful for device mapper and LVM ecology:

(1) dm-overlaybd essentially implements generic redistributable snapshot
    of an block device. This may enable LVM to push/pull individual 
    snapshots to/from a volume repo globally distributed.

(2) dm-overlaybd is highly efficent. Its index performance doesn't degrade 
    with the number of snapshots increasing. In constrast, qcow2 (dm-qcow2) 
    do not support efficient external snapshots. It has O(n) overhead in 
    this case, where n is the number of (backing-file) snapshots.

(3) dm-zfile is an efficient generic compressed block device. This allows
    LVM to support compressed snapshot, in order to save disk space without
    compromise much performance, and may even improve performance in some
    cases.


> I also have doubts that this solution is _actually_ more performant
> than a proper filesystem based solution

This proposal is not focused on performance, it's focused on new features
to dm and LVM as described above, but I still advice you to run benchmarks
and see the results. After all, ext4, xfs and other mature file systems are
highly optimized as well.

> solution that allows page cache sharing

Page cache sharing can be realized with DAX support of the dm targets
(and the inner file system), together with virtual pmem device backend.

> There is an active discussion about, and active development effort
> for, using overlayfs + erofs for container images.  I'm reluctant to
> merge this DM based container image approach without wider consensus
> from other container stakeholders.

This proposal intends to help dm and lvm ecology, and is not related to 
those file systems. It actually supports all kinds of file systems with 
full capabilities. It is of little use in container, as the user-space 
implementation is more feasible. And, there is nothing preventing the 
container stakeholders to continue discussing and developing overlayfs, 
erofs, composefs, etc.
