Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58F8D62E1BF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 17:27:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240637AbiKQQ1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 11:27:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240441AbiKQQ0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 11:26:41 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F6691403A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 08:23:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668702218;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Wlt5unR1IlykHqwwCL72sYJUvClxf8f/c3u+ZPgz6uA=;
        b=LnSfHI4Q6fKoIoln9W+Um0GmcXNxDz0w3+YW1HAp0WdA/l0/0tPAkWDxyv6BvWS2+2r1bW
        NUHckXwouYeZdnSqnFiy5EgTBBNVwGKHEE+24dP91T9gjcqJqedxxVOOLyQcJXEkwF7C4g
        85KXunyBuRiXTkfhzPj78LihNQ7EeY4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-459-BnDAMHQbNDiW3fEUbffCFw-1; Thu, 17 Nov 2022 11:23:32 -0500
X-MC-Unique: BnDAMHQbNDiW3fEUbffCFw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C7D6538041CD;
        Thu, 17 Nov 2022 16:23:30 +0000 (UTC)
Received: from pauld.bos.com (dhcp-17-237.bos.redhat.com [10.18.17.237])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 868724C819;
        Thu, 17 Nov 2022 16:23:30 +0000 (UTC)
From:   Phil Auld <pauld@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Steven Price <steven.price@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Frederic Weisbecker <frederic@kernel.org>, pauld@redhat.com
Subject: [PATCH v5 0/2] cpuhp: fix some st->target issues
Date:   Thu, 17 Nov 2022 11:23:27 -0500
Message-Id: <20221117162329.3164999-1-pauld@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a few cpuhp related issues.

The first prevents target_store() from calling cpu_down() when
target == state which prevents the cpu being incorrectly marked
as dying.  The second just makes the boot cpu have a valid cpuhp
target rather than 0 (CPU_OFFLINE) while being in state
CPU_ONLINE.

v3: Added code to make sure st->target == target in the nop case.

v4: Use WARN_ON in the case where state == target but st->target does
not.

v5: Fixed lowercase on first patch title and cleaned up cover letter.
Rebased on v6.1-rc5.

Phil Auld (2):
  cpuhp: Make target_store() a nop when target == state
  cpuhp: Set cpuhp target for boot cpu

 cpu.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

-- 
2.31.1

