Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C61926B64BD
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 11:07:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbjCLKHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 06:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjCLKHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 06:07:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B4A35B8
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 03:07:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0B2BAB80B07
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 10:07:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9312C433EF;
        Sun, 12 Mar 2023 10:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678615649;
        bh=qV7XQ2p2izx7xHPGCQGgsgpAg5qAVwtPpQmf3Y1eAy4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KOPtuBLrSW3/6A3z1MUphBJ0hfQTUWD6qhxTmAvb5wXtDHl+kfWY+1F3G2ODIslQU
         IkZoXqif2UcZ2fIEtA4iVDIJTPzenoW7CliUo4Q9KB8nZm278Ricgrfn6FjigtWHfD
         DcWANJZApu911E59cL9gyVGCDBztJS2eDIZBBjs3an5GPU8opTgV0mIyN/3C/CO5DF
         eBj2PugdQqxaxZMPzB0AP/A1EJYwyQAepPGlvcKRVpxub5BAAzC8euMENpN0nP9eEP
         QLw1ex9AX1u4Jnht9R9I5qtLa8r7jnOm9/tqsDdCEfmsLsakNc0YPbFAOvhmHZIUqK
         Pbn1wPu9vW4pw==
From:   Christian Brauner <brauner@kernel.org>
To:     Mike Christie <michael.christie@oracle.com>
Cc:     Christian Brauner <brauner@kernel.org>, mst@redhat.com,
        virtualization@lists.linux-foundation.org,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/11] Use copy_process in vhost layer
Date:   Sun, 12 Mar 2023 11:07:18 +0100
Message-Id: <167861517311.906526.10521882337920120967.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230310220332.5309-1-michael.christie@oracle.com>
References: <20230310220332.5309-1-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=2158; i=brauner@kernel.org; h=from:subject:message-id; bh=CgZ83KTaSC6ErC9mXI7QQblLNfxRBw7u0DY+KR5K5+4=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTwLgkI9bTZvi3i/WSNDN9ppS+mx6lduHe2yiNu9gKm/NsW MgFCHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABOJnM/IsFL5tjJ37J89szq+flE/lL pg7iSuBSXRFlXrjJbv5T+QG83wP8fogkFzXouMo6rPLxcLvSXzz32LD/411cr6x7nom5t8+AE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian Brauner (Microsoft) <brauner@kernel.org>


On Fri, 10 Mar 2023 16:03:21 -0600, Mike Christie wrote:
> The following patches were made over Linus's tree and apply over next. They
> allow the vhost layer to use copy_process instead of using
> workqueue_structs to create worker threads for VM's devices.
> 
> Details:
> Qemu will create vhost devices in the kernel which perform network or SCSI,
> IO and perform management operations from worker threads created with the
> kthread API. Because the kthread API does a copy_process on the kthreadd
> thread, the vhost layer has to use kthread_use_mm to access the Qemu
> thread's memory and cgroup_attach_task_all to add itself to the Qemu
> thread's cgroups.
> 
> [...]

I've picked this up now and it should show up in -next tomorrow.
Thanks for the patience,

tree: git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux kernel.user_worker

[01/11] csky: Remove kernel_thread declaration
        commit: e0a98139c162af9601ffa8d6db88dbe745f64b3c
[02/11] kernel: Allow a kernel thread's name to be set in copy_process
        commit: cf587db2ee0261c74d04f61f39783db88a0b65e4
[03/11] kthread: Pass in the thread's name during creation
        commit: 73e0c116594d99f807754b15e474690635a87249
[04/11] kernel: Make io_thread and kthread bit fields
        commit: c81cc5819faf5dd77124f5086aa654482281ac37
[05/11] fork/vm: Move common PF_IO_WORKER behavior to new flag
        commit: 54e6842d0775ba76db65cbe21311c3ca466e663d
[06/11] fork: add kernel_clone_args flag to not dup/clone files
        commit: 11f3f500ec8a75c96087f3bed87aa2b1c5de7498
[07/11] fork: Add kernel_clone_args flag to ignore signals
        commit: 094717586bf71ac20ae3b240d2654d826634b21e
[08/11] fork: allow kernel code to call copy_process
        commit: 89c8e98d8cfb0656dbeb648572df5b13e372247d
[09/11] vhost_task: Allow vhost layer to use copy_process
        commit: 77feab3c4156229511b378f15c0a16574d9c08ea
[10/11] vhost: move worker thread fields to new struct
        commit: d45e2b73ead0daec350680fbf20144a2d3670186
[11/11] vhost: use vhost_tasks for worker threads
        commit: 5ab18f4b061ef24a71eea9ffafebd1a82ae2f514
