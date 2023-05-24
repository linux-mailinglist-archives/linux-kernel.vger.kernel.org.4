Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4617470FEE5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 22:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233435AbjEXUAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 16:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjEXUAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 16:00:12 -0400
X-Greylist: delayed 421 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 24 May 2023 13:00:08 PDT
Received: from postout2.mail.lrz.de (postout2.mail.lrz.de [IPv6:2001:4ca0:0:103::81bb:ff8a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5C4399
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 13:00:08 -0700 (PDT)
Received: from lxmhs52.srv.lrz.de (localhost [127.0.0.1])
        by postout2.mail.lrz.de (Postfix) with ESMTP id 4QRML60CcCzyT9;
        Wed, 24 May 2023 21:53:01 +0200 (CEST)
Authentication-Results: postout.lrz.de (amavisd-new); dkim=pass (2048-bit key)
        reason="pass (just generated, assumed good)" header.d=tum.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tum.de; h=
        content-transfer-encoding:content-type:content-type:subject
        :subject:content-language:from:from:user-agent:mime-version:date
        :date:message-id:received:received; s=tu-postout21; t=
        1684957981; bh=Fl1s8tTECGHBSsv780IorDgMeOB7qr0o3umwB4Kv6Wc=; b=l
        xNKHTrzRkMgMwWRLaS9278EFjUHEY3bUOImy3h/fWEz2iIfJucurNeTdBX/FVcJn
        aV2OKV6cYg5Y2eCLiy9o9pPTq3atdWMMl5GBolUJEWZDJSkoJPcZVDEF88tQbBjZ
        ZjJN3w6MHHMKHHa4O6elXnxvjd/RtBdnPaz1G/ilDV6zzL+tXFq8Ov9u9kKtl1gy
        og21bk/BYxTJBJuXcLu6sS4ipMlsaDkxh9E6BpbfqPDAm+4xLm+5nx4tfUlMpeVw
        ZPLGYBibt7qECJbehPBWw8+AZ5YbUW1SksVx3jq3VPDPjN7XMCSq/dqoLfFy0OBn
        tiBxEw3CNF9WUvoGgX1Xg==
X-Virus-Scanned: by amavisd-new at lrz.de in lxmhs52.srv.lrz.de
X-Spam-Score: -2.884
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
Received: from postout2.mail.lrz.de ([127.0.0.1])
        by lxmhs52.srv.lrz.de (lxmhs52.srv.lrz.de [127.0.0.1]) (amavisd-new, port 20024)
        with LMTP id VCdqrq-NIYKT; Wed, 24 May 2023 21:53:01 +0200 (CEST)
Received: from [192.168.2.108] (cm115.cm.in.tum.de [131.159.25.62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by postout2.mail.lrz.de (Postfix) with ESMTPSA id 4QRML52tqczyRg;
        Wed, 24 May 2023 21:53:01 +0200 (CEST)
Message-ID: <51354ca5-acd2-f542-95e0-85ed8418f483@tum.de>
Date:   Wed, 24 May 2023 21:53:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
From:   =?UTF-8?Q?Josef_Sch=c3=b6nberger?= <josef.schoenberger@tum.de>
Content-Language: de-DE, en-GB
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: KernFS: Missing IN_DELETE_SELF or IN_IGNORED inotify events
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everybody,

I'm currently working on event listeners for cgroups for a long running
daemon. I found that the removal of cgroups that I'm currently listening
for produces neither an IN_DELETE_SELF nor an IN_IGNORED event; which is
unfortunate, since I need to maintain a map from watch descriptors to
paths, from which I would like to remove all obsolete entries.

Since this is not the documented behaviour and since I could not find
any material that would specify an intention behind this, I'm assuming
that this is a bug?

I've found that the same applies to the sysfs. Taking a look at the
kernel code, I'd guess that the issue might be in KernFS.

I've appended a minimal reproducible example.

Thanks
Josef



#include <stdlib.h>
#include <err.h>
#include <sys/inotify.h>
#include <unistd.h>
#include <stdio.h>
#include <sys/stat.h>
#include <signal.h>

void cleanup(int signo) {
    (void) signo;
    printf("Removing /sys/fs/cgroup/demo again...\n");
    if (rmdir("/sys/fs/cgroup/demo"))
        err(EXIT_FAILURE, "Could not remove /sys/fs/cgroup/demo");
    exit(0);
}

int main(void) {
    if (geteuid() != 0)
        fprintf(stderr, "Need root privileges.\n"
                "Will probably not be able to cgroup without.\n"
                "Giving it a shot regardless...\n");

    int fd = inotify_init();
    if (fd < 0)
        err(EXIT_FAILURE, "Could not create inotify fd");

    if (mkdir("/sys/fs/cgroup/demo", 755))
        err(EXIT_FAILURE, "Could not create cgroup @ /sys/fs/cgroup/demo");

    signal(SIGINT, cleanup);

    int wd = inotify_add_watch(fd, "/sys/fs/cgroup/demo", IN_DELETE_SELF);
    if (wd < 0)
        err(EXIT_FAILURE, "Could not add /sys/fs/cgroup/demo to inotify
fd");

    printf("Expecting to read an IN_DELETE_SELF or IN_IGNORED event...\n");
    char buf[512];
    ssize_t nbytes = read(fd, buf, sizeof(buf));
    if (nbytes < 0)
        err(EXIT_FAILURE, "Could not read from inotify fd");

    printf("Read %zd bytes\n", nbytes);
    cleanup(0);
}
