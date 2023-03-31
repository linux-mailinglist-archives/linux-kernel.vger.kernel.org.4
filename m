Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3E76D2311
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 16:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232951AbjCaOww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 10:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232311AbjCaOwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 10:52:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 731D220D9A
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 07:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680274281;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=NxiS3F96XX8Cx+zMaAlwGGsTAfl1PqYiaP5Qp7Bk1SM=;
        b=QI6JOJVzU0KWrY9CL9gO9ELlt6FtB91gb/G+MR0hu6LiMpECRfBqH4+M4ZhYYcSz0hoikK
        yh9PhcyLgjr06XQm0CXMO2+tn1HoK108ce5cVfc03/pKh93BmnQIh74sm5y9MTAZ/rxke8
        pYJ2tl5hoDp6Yt1WtWuNKBKFG5scuUc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-659-4VfH5a2oMCmrUGd6y1d2Mw-1; Fri, 31 Mar 2023 10:51:16 -0400
X-MC-Unique: 4VfH5a2oMCmrUGd6y1d2Mw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BE0308030A0;
        Fri, 31 Mar 2023 14:51:15 +0000 (UTC)
Received: from llong.com (unknown [10.22.17.48])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3586C492B02;
        Fri, 31 Mar 2023 14:51:15 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Christian Brauner <brauner@kernel.org>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        gscrivan@redhat.com, Waiman Long <longman@redhat.com>
Subject: [PATCH 0/3] cgroup/cpuset: Fix CLONE_INTO_CGROUP problem & other issues
Date:   Fri, 31 Mar 2023 10:50:42 -0400
Message-Id: <20230331145045.2251683-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first patch of this series fixes the incorrect cpumask problem
when the CLONE_INTO_CGROUP flag is used to clone a child to a different
cgroup. It also includes 2 other miscellaneous fixes to the cpuset code.

Waiman Long (3):
  cgroup/cpuset: Make cpuset_fork() handle CLONE_INTO_CGROUP properly
  cgroup/cpuset: Make cpuset_attach_task() skip subpartitions CPUs for
    top_cpuset
  cgroup/cpuset: Allow only one active attach operation per cpuset

 kernel/cgroup/cpuset.c | 76 ++++++++++++++++++++++++++++--------------
 1 file changed, 51 insertions(+), 25 deletions(-)

-- 
2.31.1

