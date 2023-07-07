Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3547174AA0B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 06:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232037AbjGGEqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 00:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbjGGEqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 00:46:43 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B1E1BF0
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 21:46:42 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-666e97fcc60so1143303b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 21:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1688705202; x=1691297202;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+8KrRjriTlWtsSChPn/s5oP2eGKo7GVW4eTsZHk6Ir8=;
        b=cYoFrKnXiO+tDsFSsK1B1T1ZBRIT6BcP5+RMU9iiBwFEGpc/P6Ii4QVhDvxiK+kjEZ
         coApwrD87wyCH9lFoZItavQ3uWqGeqH4QqyVfeidIHdjpHY9YRzocmCPt4Mlje6+Lug7
         KQXhMElZZn+AJeJRlLG/4oV7peNLjlRFC97krGhJK+ncxy9nFt+h9GAJ1kr/TA4knJJ0
         QVg61Ye2jktdt+i9ZOjFhRJBNrMGUjyW9Xi+0MWAyotjd1k5c9Hut0pCQGJ1dt9i7c8q
         mdl6JRCWnNIcTM+CDDujnsyn3Y0/yUQMkQUPAjDWnD7ofmwBKkSL8KseMbhfCYFkYR+e
         3HTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688705202; x=1691297202;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+8KrRjriTlWtsSChPn/s5oP2eGKo7GVW4eTsZHk6Ir8=;
        b=BZTqh3rEMtjKuqNPmQRzh7tZJEc4hl6dDRKM0uzeKM/vNQ/6BGtLc2VMSC9sEsC2sq
         bHji3KMdU6uFjjQgyDv699EQqwJdlpaSxUvNvS4Jpz9xh1xp4ERJvf1KKi8moJ4mJY70
         60Elcmz9Bs/8TsPqjGm5Nxi2hceUAzqlMzjvYbw3+Qyx5I+U0ySJggXsvBPEac38aOj4
         pfUdBdSr6U0wa7GAI+Am8gFQR7Sc0s7qPE8N+isuO7xU9KuXKKucGHE/Tt24yWwHvueh
         FjSp3XLeXc10FZ+A52awcJSIDL/0FCu3+vQiTbuHuJJ/4aXBl3fZNfIhkON7qZC5M6Sq
         XcyA==
X-Gm-Message-State: ABy/qLb92cGUc0FSw8S2IiLawQRwGUhMb/3Tizy4RuKC1t2yiKHxcw0m
        6dxN+WfHlaBaevEnmzkm2RBhioaDRZx/xyG3gF8=
X-Google-Smtp-Source: APBJJlE+46zk9//AWNid+YikU2na+nPHt/wQKFs/Qk3UE1jZtuou5ZQg0EjDa9LUwhKDJ5lyTcwYfA==
X-Received: by 2002:a05:6a00:228a:b0:64d:1c59:6767 with SMTP id f10-20020a056a00228a00b0064d1c596767mr3699062pfe.24.1688705202320;
        Thu, 06 Jul 2023 21:46:42 -0700 (PDT)
Received: from Tower.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id x53-20020a056a000bf500b0064d32771fa8sm2027315pfu.134.2023.07.06.21.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 21:46:41 -0700 (PDT)
From:   Zhongkun He <hezhongkun.hzk@bytedance.com>
To:     minchan@kernel.org, senozhatsky@chromium.org, mhocko@suse.com
Cc:     david@redhat.com, yosryahmed@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Zhongkun He <hezhongkun.hzk@bytedance.com>
Subject: [RFC PATCH 0/2] zram: objects charge to mem_cgroup
Date:   Fri,  7 Jul 2023 12:46:13 +0800
Message-Id: <20230707044613.1169103-1-hezhongkun.hzk@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a new solution to charge ZRAM objects,more simple than
previous one[1],The compressed RAM is currently charged to
kernel,not to any memory cgroup.

As we know, zram can be used in two ways, direct and
indirect, this patchset can charge memory in both cases.
Direct zram usage by process within a cgroup will fail
to charge if there is no memory. Indirect zram usage by
process within a cgroup via swap in PF_MEMALLOC context,
will charge successfully.

[1]
https://lore.kernel.org/all/20230615034830.1361853-1-hezhongkun.hzk@bytedance.com/

Zhongkun He (2):
  memcg: Add support for zram object charge
  zram: charge the compressed RAM to the page's memcgroup

 drivers/block/zram/zram_drv.c | 43 +++++++++++++++++++++++++++++++++++
 drivers/block/zram/zram_drv.h |  1 +
 include/linux/memcontrol.h    | 10 ++++++++
 mm/memcontrol.c               | 23 +++++++++++++++++++
 4 files changed, 77 insertions(+)

-- 
2.25.1

