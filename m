Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC0326B063B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 12:43:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbjCHLnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 06:43:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbjCHLm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 06:42:56 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7535CBD7B7
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 03:42:42 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id j11so45006783edq.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 03:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1678275761;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EDKdC+6hyofhr4T6hi4EtGoiKJnWevsXeOWcKWN7al0=;
        b=nFRaw4lRKgq21mLnujYmx7aDGXo5bh4wBopYEpo93z1WAKMfKlsOTX5UtBEAlFj4MK
         NCQPbZe2kI80OUzdMDRmaye8z4jLpSLUpNCnK0oY5eq+Y5EKN78F11gcPvMcIPRfUu7y
         pWqD3EErABEaYqSL3mw5BPC3CLoRQYQ72UxW4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678275761;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EDKdC+6hyofhr4T6hi4EtGoiKJnWevsXeOWcKWN7al0=;
        b=BMzM+mUB71qsMfUzOXpCSa/tnawu/HvasaLIVi1Sw2OTBIflL7/QJf1IYRHhgxnK9l
         wLncpk1booUGh2u2KpCt2lvWrTBCvT4PW6QbWaK19KH4PRoeKLlt4FVWkroSxaT4NUWW
         +eZzOQRmQI5SBu//GITqZGS8tT/FVv2l39IxZHGhg8lKdzbHN05AWgwwRy/dZ+ipJJSo
         ho5f5Bs/tVWntjsHEpsCP0uY/NwohIMjtnZbrDBRwSTm3xFxdonVUP83As03TncLDKhy
         mYeZDnE3yZ96CgZuF8YH/0EiKN9V/lEuDBDLJPNEoN0hdC66GPPJZhE9SOJ8XPBXth0h
         nZHA==
X-Gm-Message-State: AO0yUKVS+z9sGtj9wX7PgfoDoO51bTzcCTmSPojGshCocXOTwKuhSgrJ
        cUWTZhudEO1mQ5UVl/vCc6VNq1K3/toU38tsCwPDmw==
X-Google-Smtp-Source: AK7set8BaGh8OjHnxwN0qIs+csLDTXeeXp0Bl3oKcw0Y8sphZ/mVUWo81LJtE30LCSVi+GXGDfxr3OOPoprwBJif+v4=
X-Received: by 2002:a50:f619:0:b0:4c0:616:5fc3 with SMTP id
 c25-20020a50f619000000b004c006165fc3mr9926513edn.0.1678275760869; Wed, 08 Mar
 2023 03:42:40 -0800 (PST)
MIME-Version: 1.0
From:   Daniel Dao <dqminh@cloudflare.com>
Date:   Wed, 8 Mar 2023 11:42:29 +0000
Message-ID: <CA+wXwBQwgxB3_UphSny-yAP5b26meeOu1W4TwYVcD_+5gOhvPw@mail.gmail.com>
Subject: Unexpected EINVAL when enabling cpuset in subtree_control when
 io_uring threads are running
To:     Jens Axboe <axboe@kernel.dk>
Cc:     io-uring@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        cgroups@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

We encountered EINVAL when enabling cpuset in cgroupv2 when io_uring
worker threads are running. Here are the steps to reproduce the failure
on kernel 6.1.14:

1. Remove cpuset from subtree_control

  > for d in $(find /sys/fs/cgroup/ -maxdepth 1 -type d); do echo
'-cpuset' | sudo tee -a $d/cgroup.subtree_control; done
  > cat /sys/fs/cgroup/cgroup.subtree_control
  cpu io memory pids

2. Run any applications that utilize the uring worker thread pool. I used
   https://github.com/cloudflare/cloudflare-blog/tree/master/2022-02-io_uring-worker-pool

  > cargo run -- -a -w 2 -t 2

3. Enabling cpuset will return EINVAL

  > echo '+cpuset' | sudo tee -a /sys/fs/cgroup/cgroup.subtree_control
  +cpuset
  tee: /sys/fs/cgroup/cgroup.subtree_control: Invalid argument

We traced this down to task_can_attach that will return EINVAL when it
encounters
kthreads with PF_NO_SETAFFINITY, which io_uring worker threads have.

This seems like an unexpected interaction when enabling cpuset for the subtrees
that contain kthreads. We are currently considering a workaround to try to
enable cpuset in root subtree_control before any io_uring applications
can start,
hence failure to enable cpuset is localized to only cgroup with
io_uring kthreads.
But this is cumbersome.

Any suggestions would be very much appreciated.

Thanks,
Daniel.
