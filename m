Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3276C5FC689
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 15:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbiJLNd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 09:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiJLNdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 09:33:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCF5FCE9BF
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 06:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665581632;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=cRrYv5VDYCsMPFcwu3e26THq2yQkJQsQZS+BU0hoSvo=;
        b=RtI52IToAwxi/NSrkq9NNDD15ErM2HQw44cTxbhgncwLe8DbIp56fFlL5I7+sQMELve7Gg
        aDn2yzr4qPBimI1aJmKphG8WsA9rmbBejwKonN/+qr/2gzpXNMSi3Ja9tWjPP7S9TYCSpJ
        eKmFKeqVprQcCHXCT1S3fX6IIbsOLJA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-534-KP6Bwa2ZPQqUW1N9ZBsdnA-1; Wed, 12 Oct 2022 09:33:48 -0400
X-MC-Unique: KP6Bwa2ZPQqUW1N9ZBsdnA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 24B1529AA2FD;
        Wed, 12 Oct 2022 13:33:48 +0000 (UTC)
Received: from llong.com (unknown [10.22.33.120])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6D617112131E;
        Wed, 12 Oct 2022 13:33:47 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org, john.p.donnelly@oracle.com,
        Hillf Danton <hdanton@sina.com>,
        Mukesh Ojha <quic_mojha@quicinc.com>,
        =?UTF-8?q?Ting11=20Wang=20=E7=8E=8B=E5=A9=B7?= 
        <wangting11@xiaomi.com>, Waiman Long <longman@redhat.com>
Subject: [PATCH v2 0/2] locking/rwsem: Fix rwsem waiter optimistic spinning problem with RT tasks
Date:   Wed, 12 Oct 2022 09:33:31 -0400
Message-Id: <20221012133333.1265281-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2:
 - Add an additional patch to limit the # of first waiter optimistic
   spinning in the writer slowpath.

It turns out the current waiter optimistic spinning code does not work
that well if we have RT tasks in the mix. This patch series include
two different fixes to resolve those issues.

Waiman Long (2):
  locking/rwsem: Prevent non-first waiter from spinning in down_write()
    slowpath
  locking/rwsem: Limit # of null owner retries for handoff writer

 kernel/locking/rwsem.c | 31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

-- 
2.31.1

