Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 064C55B9F03
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 17:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbiIOPiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 11:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiIOPiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 11:38:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5EE782768
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 08:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663256276;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=yWvXjU22B2a+CJZc9xqXnahaTSnreVnQQz8zOTHm+5E=;
        b=VDn4NCxzf6E98+sfvou1bRekLIuc2Hj+VQ/xj3qXtl6IZh0mubiDljgGSFlWQCaHtm9wfy
        M4ZwjeQVvJTF59gZZy2VI6RM2hPcc9jnWZ+oJlh6diaOszD5iquJuSBJybo10PK03zxV56
        qVF0dprb+tTgyJ16FQBUN5fKf2YdUBA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-612-c2gjJMrvPtep94woJ0YCVA-1; Thu, 15 Sep 2022 11:37:53 -0400
X-MC-Unique: c2gjJMrvPtep94woJ0YCVA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DD8EA801231;
        Thu, 15 Sep 2022 15:37:52 +0000 (UTC)
Received: from pauld.bos.com (dhcp-17-237.bos.redhat.com [10.18.17.237])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 862632166B26;
        Thu, 15 Sep 2022 15:37:52 +0000 (UTC)
From:   Phil Auld <pauld@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Steven Price <steven.price@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [RESEND PATCH v4 0/2] cpuhp: fix some st->target issues
Date:   Thu, 15 Sep 2022 11:37:49 -0400
Message-Id: <20220915153751.2123654-1-pauld@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a couple of cpuhp inconsistencies.

The first prevents target_store() from calling cpu_down() when
target == state which prevents the cpu being incorrectly marked
as dying.  The second just makes the boot cpu have a valid cpuhp
target rather than 0 (CPU_OFFLINE) while being in state
CPU_ONLINE.

A further issue which these two patches don't address is that
the cpuX/online file looks at the device->offline state and can
thus get out of sync with the actual cpuhp state if the cpuhp
target is used to change state.

v3: Added code to make sure st->target == target in the nop case.

v4: Use WARN_ON in the case where state == target but st->target does
not.

Phil Auld (2):
  cpuhp: make target_store() a nop when target == state
  cpuhp: Set cpuhp target for boot cpu

 kernel/cpu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

-- 
2.31.1

