Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBF245B9FFA
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 18:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbiIOQvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 12:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbiIOQup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 12:50:45 -0400
Received: from mta-01.yadro.com (mta-02.yadro.com [89.207.88.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DFFF72873
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 09:49:56 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 11938452B5;
        Thu, 15 Sep 2022 16:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :x-mailer:message-id:date:date:subject:subject:from:from
        :received:received:received:received; s=mta-01; t=1663260594; x=
        1665074995; bh=aJxsl1IsEqMemsBoxDxN4T9Vj5dLZ6MlRk5zTSvOYqM=; b=j
        gElWU7UGUR0ZJ7Q+h/29kcz3EMEYGEhAB2T77Qg24rfP56t+i7+Llw5cmKkU+vmY
        yrNoV9n4sBDo0MPdL2UVujgjzjSjkhmdFbjCfEZT/qxI1FYbLwf1wwe01YvqaYC0
        7YK/dkM4BB8KRopHvw60ofJXp+l0wmJt2gMRtyzvs8=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Caa5CL7E_TCb; Thu, 15 Sep 2022 19:49:54 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (T-EXCH-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 7C73C4525A;
        Thu, 15 Sep 2022 19:48:51 +0300 (MSK)
Received: from T-EXCH-08.corp.yadro.com (172.17.11.58) by
 T-EXCH-02.corp.yadro.com (172.17.10.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.669.32; Thu, 15 Sep 2022 19:48:51 +0300
Received: from t14gen1.yadro.com (10.199.21.212) by T-EXCH-08.corp.yadro.com
 (172.17.11.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1118.9; Thu, 15 Sep
 2022 19:48:47 +0300
From:   Evgenii Shatokhin <e.shatokhin@yadro.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, Ilya Kuznetsov <ilya@yadro.com>,
        <linux@yadro.com>, Evgenii Shatokhin <e.shatokhin@yadro.com>
Subject: [PATCH 0/2] mailbox: Fix error handling in mbox_send_message()
Date:   Thu, 15 Sep 2022 19:47:28 +0300
Message-ID: <20220915164730.515767-1-e.shatokhin@yadro.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.199.21.212]
X-ClientProxiedBy: T-EXCH-02.corp.yadro.com (172.17.10.102) To
 T-EXCH-08.corp.yadro.com (172.17.11.58)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fixes a couple issues I found while experimenting with mailbox device drivers:

1. If one tries to send a message via the mailbox using mbox_send_message(), and the controller driver for the mailbox device returns any error, mbox_send_message() returns -ETIME when in blocking mode. This is confusing at least.

2. If the mbox controller driver fails to send a message, mbox_send_message() needlessly waits for the message to be sent. That ends when the waiting timeout has been expired. However, the pointer to the message remains in the queue of the mbox framework (chan->msg_data) and the framework will try to process it over and over again, when one tries to send other messages. If the driver rejects the message each time because it is invalid (some drivers do that), this will prevent anyone from using that mailbox channel.

Evgenii Shatokhin (2):
  mailbox: Propagate errors from .send_data() callback to
    mbox_send_message()
  mailbox: Error out early if the mbox driver has failed to submit the
    message

 drivers/mailbox/mailbox.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

-- 
2.34.1

