Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A6595FEA0D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 10:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbiJNIGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 04:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiJNIGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 04:06:35 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53CAE18B779
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 01:06:34 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id l6so3682824pgu.7
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 01:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=90kmgNBxYuQDRjoJ++HQAlxGZIWs9oLzsbBHk0vLgUo=;
        b=OtPMThNbb2WOOHLxa+QlctGa0JbZInKy8kSXh9SoHLMCt8nULHPQnF09yBTHpP/Udk
         gu5KnxTVZoOUFHA/9H1eutkfBF3jVWc0fItRmP6uvZ9Ey+NoJPO6lZm3NPbZAGqnjQaY
         IVIk40rjWuKwERXAWAEXExLmLK0tFhM77u9fEdlCWFf5RyJR4Oe0ONg8KO+OviHZXmZd
         R0lcP+zIKbbZPU75ixyN3lOFmcrj2KPjcqTjH6da57Os3AOujFcXPbvSz/r8H5Spn7Dr
         /nTyFdJMPJsoT3nxEvsgEd1z9N3zTHshx7VbJsOiY9MBe30I4xdRBGX4PV05vF6iLmye
         qR9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=90kmgNBxYuQDRjoJ++HQAlxGZIWs9oLzsbBHk0vLgUo=;
        b=MHbANmXmVtav+D9+0ACfRZvUOjOvhWRVnY5ZfB6C3hD9oHvbr3EAQxRVOgCIC+r05s
         EBhT45aLxNkW50QMqESO4N9/mDFWXrD6y/DY9iChtgJ6X3egmwD6D4F3BIzwwVfJYGSL
         sEJ73KX/TXqiVz/CdoV14uHJU/1aLMYxLIsaKpUOSji7Oe4+VPZTRZh0Bgok/eZYhmnn
         fdaYRMrBpl7qu8RD1zWrAPNYN/zJEUm5cmoCX6ZMSxXna8h1VWuyX3aHa9OnX6CPtNyW
         ZZvf/mNONskNpoWqI3OZiOBtSzaVuUr6EyOZA+aQp3ZY7db5l+gEgyeTFVp8oaG3omzY
         BiLA==
X-Gm-Message-State: ACrzQf16g8hLbbJCHJ7+RTgRPGi6yW/jPyVi1RIUbuRw341vCZj9ToqL
        Co+kixnsPbybumoRFLUYNPxwBm2S/oC6TKLC
X-Google-Smtp-Source: AMsMyM5Zx7Qn9iRmKEY5gHbnSMEHHrDjyxn7uuX9kvfDoFaNsj+MDU3tUeehdFxmy9MnBKR6CLGVUA==
X-Received: by 2002:a65:63ce:0:b0:43a:2103:b7b8 with SMTP id n14-20020a6563ce000000b0043a2103b7b8mr3666169pgv.59.1665734793849;
        Fri, 14 Oct 2022 01:06:33 -0700 (PDT)
Received: from C02G705SMD6V.bytedance.net ([63.216.146.188])
        by smtp.gmail.com with ESMTPSA id ik20-20020a170902ab1400b001730a1af0fbsm1119196plb.23.2022.10.14.01.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 01:06:33 -0700 (PDT)
From:   Jia Zhu <zhujia.zj@bytedance.com>
To:     dhowells@redhat.com, xiang@kernel.org, jefflexu@linux.alibaba.com
Cc:     linux-cachefs@redhat.com, linux-erofs@lists.ozlabs.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        yinxin.x@bytedance.com, Jia Zhu <zhujia.zj@bytedance.com>
Subject: [PATCH V3 0/5] Introduce daemon failover mechanism to recover from crashing
Date:   Fri, 14 Oct 2022 16:05:54 +0800
Message-Id: <20221014080559.42108-1-zhujia.zj@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v2:
1. Remove useless header file.
2. Remove useless assignment statement about object_id.
3. Modify some code comments.
4. Add Reviewed-by lines from Jingbo Xu.

[Background]
============
In ondemand read mode, if user daemon closes anonymous fd(e.g. daemon
crashes), subsequent read and inflight requests based on these fd will
return -EIO.
Even if above mentioned case is tolerable for some individual users, but
when it happenens in real cloud service production environment, such IO
errors will be passed to cloud service users and impact its working jobs.
It's terrible for cloud service stability.

[Design]
========
This patchset introduce three states for ondemand object:
CLOSE: Object which just be allocated or closed by user daemon.
OPEN: Object which related OPEN request has been processed correctly.
REOPENING: Object which has been closed, and is drived to open by a read
request.

[Flow Path]
===========
[Daemon Crash] 
0. Daemon use UDS send/receive fd to keep and pass the fd reference of
   "/dev/cachefiles".
1. User daemon crashes -> restart and recover dev fd's reference.
2. User daemon write "restore" to device.
   2.1 Reset the object's state from CLOSE to OPENING.
   2.2 Init a work which reinit the object and add it to wq. (daemon can
       get rid of kernel space and handle that open request).
3. The user of upper filesystem won't notice that the daemon ever crashed
   since the inflight IO is restored and handled correctly.

[Daemon Close fd]
1. User daemon closes an anonymous fd.
2. User daemon reads a READ request which the associated anonymous fd was
   closed and init a work which re-open the object.
3. User daemon handles above open request normally.
4. The user of upper filesystem won't notice that the daemon ever closed
   any fd since the closed object is re-opened and related request was
   handled correctly.

[Test]
======
There is a testcase for above mentioned scenario.
A user process read the file by fscache ondemand reading.
At the same time, we kill the daemon constantly.
The expected result is that the file read by user is consistent with
original, and the user doesn't notice that daemon has ever been killed.

https://github.com/userzj/demand-read-cachefilesd/commits/failover-test

[GitWeb]
========
https://github.com/userzj/linux/tree/fscache-failover-v4

RFC: https://lore.kernel.org/all/20220818135204.49878-1-zhujia.zj@bytedance.com/
V1: https://lore.kernel.org/all/20221011131552.23833-1-zhujia.zj@bytedance.com/
V2: https://lore.kernel.org/all/20221014030745.25748-1-zhujia.zj@bytedance.com/

Jia Zhu (5):
  cachefiles: introduce object ondemand state
  cachefiles: extract ondemand info field from cachefiles_object
  cachefiles: resend an open request if the read request's object is
    closed
  cachefiles: narrow the scope of triggering EPOLLIN events in ondemand
    mode
  cachefiles: add restore command to recover inflight ondemand read
    requests

 fs/cachefiles/daemon.c    |  14 +++-
 fs/cachefiles/interface.c |   6 ++
 fs/cachefiles/internal.h  |  57 +++++++++++++-
 fs/cachefiles/ondemand.c  | 158 ++++++++++++++++++++++++++++----------
 4 files changed, 188 insertions(+), 47 deletions(-)

-- 
2.20.1

