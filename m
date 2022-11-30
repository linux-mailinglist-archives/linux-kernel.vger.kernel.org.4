Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B92B63D2EA
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 11:12:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235731AbiK3KMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 05:12:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235596AbiK3KMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 05:12:01 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C9FF419B8
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 02:10:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669803058;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NAPWN76bkmlkit0jp4yV1GQFH8+HLa/sfheRK684iiA=;
        b=M/fmJ/I0q/aZ6FGKkQxk5C4NyKP2Vpu7Y97ZmMtZK9JD2N3tjPRvNPXiwecYE1YN7TNkDu
        NKy19zUGK51Wd9mYaFaNqhXUIcTr0FOZgEH4KmlFHghzK9VcoHfGuHP1oztI14eNimyGoi
        Jx2mZX076IPhQ+gTfJbr1KznHPz7pkE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-659--dUu3qT7Mw2hrcemaTcW8g-1; Wed, 30 Nov 2022 05:10:52 -0500
X-MC-Unique: -dUu3qT7Mw2hrcemaTcW8g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B31DB101A52A;
        Wed, 30 Nov 2022 10:10:51 +0000 (UTC)
Received: from plouf.redhat.com (unknown [10.39.195.154])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A39B840E9790;
        Wed, 30 Nov 2022 10:10:39 +0000 (UTC)
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Florent Revest <revest@chromium.org>,
        Jon Hunter <jonathanh@nvidia.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 2/2] selftests: hid: ensures we have the proper requirements in config
Date:   Wed, 30 Nov 2022 11:10:21 +0100
Message-Id: <20221130101021.1868764-3-benjamin.tissoires@redhat.com>
In-Reply-To: <20221130101021.1868764-1-benjamin.tissoires@redhat.com>
References: <20221130101021.1868764-1-benjamin.tissoires@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

They are implicit right now but might get defaulted to N in the future,
so force them in the config so we don't get any surprises.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 tools/testing/selftests/hid/config | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/hid/config b/tools/testing/selftests/hid/config
index d4130489c1b1..e3595b4a3708 100644
--- a/tools/testing/selftests/hid/config
+++ b/tools/testing/selftests/hid/config
@@ -11,8 +11,10 @@ CONFIG_BPF_SYSCALL=y
 CONFIG_BPF=y
 CONFIG_CGROUP_BPF=y
 CONFIG_DEBUG_INFO_BTF=y
+CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
 CONFIG_FPROBE=y
 CONFIG_FTRACE_SYSCALLS=y
+CONFIG_FUNCTION_ERROR_INJECTION=y
 CONFIG_FUNCTION_TRACER=y
 CONFIG_HIDRAW=y
 CONFIG_HID=y
-- 
2.38.1

