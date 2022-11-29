Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A3FC63C477
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 17:00:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234334AbiK2QAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 11:00:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235976AbiK2P7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 10:59:49 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04835C32;
        Tue, 29 Nov 2022 07:58:31 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id z20so20365486edc.13;
        Tue, 29 Nov 2022 07:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2jte3UkADbZqkDkz468rdbv/0NOM4s5ZmViVa2ZZlQ8=;
        b=Ree2fF3HX+AtsxhEFrz1qEpeKKbWHPt72RxapGbQ9mUbpnTqTcYediTJwrsJ5vhV6/
         94Kq8wTv5UtB4tFX/ROQkaHJSv6QnrQgBTGBAp2chXmAqegzWPlWVFMOLgD8r7AxRfN0
         P2I/JGlIKlC/Bg68UNxWT/22QOYhzzoE8rKhr0qrQU4FYi+DAX4W6v0Ptzb6DacjyScm
         Fp9BcWg1QebXz8OQ4gjUrdkmGEWaHwXjgnt8xPbKkqCoMR17Dm5v20X4ZKaPJ7tLUfdU
         3UY5KDQk549Eg2kMXZ4GilZwMLbX36iZR2KndrYtSS2uSq3I+DB0PVBgBfLL7Q0WajVD
         l98Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2jte3UkADbZqkDkz468rdbv/0NOM4s5ZmViVa2ZZlQ8=;
        b=mL93OiXb0GuuOYMxMS5VtymPoqh3PztV1jThfUQ/mWWqKNUIq0Y7mStYfjjF9hOIvL
         ZrbjAhrc6T5iDhFQOYmPBQ6MDTUIapZe8PUbZIh2UjVUCl/xkcuMyjZ5L03mGI/g4Bkx
         JdSTsKJcYdvgienuO8054TBH/JUjnMA4pRiYtMVHdFXTqeh/5xhZQ/LS76ZU4XEVdw06
         YElEni9FYUr8fwjmwFirKQSW0nFjFaK/EYs2My3Tkz3jJ44jiuekdnwKFlGhNl2DUXDU
         44rIId/hmVQthCzK8+VWz/FqjRmn391qYJFOlKFeNG+4V9WRS7bcea6hs+amRLazzDF8
         tC5w==
X-Gm-Message-State: ANoB5pmeUZT4CEt2S1GNMM/2EDOBb1PE2bGtNze8vAjnDBpnnEAywkDp
        lak/ejHRYIgOMnJnamYTsWdEhuWcM+s=
X-Google-Smtp-Source: AA0mqf7MLkbVibcb05kCmtJmvGzjV6UQaLM+Y5Puxu0X7+mbJ6jxLm2heIZmnIZoyFtt8yN2Ls5DnQ==
X-Received: by 2002:a05:6402:388e:b0:468:fb0d:2d8b with SMTP id fd14-20020a056402388e00b00468fb0d2d8bmr20747563edb.124.1669737510334;
        Tue, 29 Nov 2022 07:58:30 -0800 (PST)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id u23-20020a056402065700b0046778ce5fdfsm6371059edx.10.2022.11.29.07.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 07:58:29 -0800 (PST)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraj.iitr10@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: [PATCH v2 0/4] kvfree_rcu() updates related to polled API
Date:   Tue, 29 Nov 2022 16:58:18 +0100
Message-Id: <20221129155822.538434-1-urezki@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v1 -> v2:
  - Rebase on latest dev.2022.11.23a branch.

Uladzislau Rezki (Sony) (4):
  rcu/kvfree: Switch to a generic linked list API
  rcu/kvfree: Move bulk/list reclaim to separate functions
  rcu/kvfree: Move need_offload_krc() out of krcp->lock
  rcu/kvfree: Use a polled API to speedup a reclaim process

 kernel/rcu/tree.c | 221 +++++++++++++++++++++++++++-------------------
 1 file changed, 131 insertions(+), 90 deletions(-)

-- 
2.30.2

