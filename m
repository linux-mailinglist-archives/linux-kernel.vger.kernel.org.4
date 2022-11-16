Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6578262B9A6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 11:44:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233873AbiKPKod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 05:44:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233819AbiKPKoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 05:44:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9750C2AEA
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 02:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668594680;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=KMf1wj6uhiThKc0LO2n9P1YxDQHLdC8FGGp8WLlmHBQ=;
        b=by60+Rutuomb40P5INSp5CVUrf5x4FAjz27tz+NpBEr0wFhYNpN8bsikay0Qh7+BK3MogA
        EwK/zCHLO/RrmCz+hRIpfaxoU+KDXxm5Wk15VEXx7PbwhlrV2+Na+DRA4p/PogvjTLIHkv
        GdrlMUOhPbLUByJtRrig27OC1gOZyio=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-624-7SY8pOamOjCEh56wKFscnQ-1; Wed, 16 Nov 2022 05:31:17 -0500
X-MC-Unique: 7SY8pOamOjCEh56wKFscnQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 49D5A1C09B8D;
        Wed, 16 Nov 2022 10:31:15 +0000 (UTC)
Received: from plouf.redhat.com (unknown [10.39.194.179])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7063240C83AA;
        Wed, 16 Nov 2022 10:31:14 +0000 (UTC)
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH] HID: bpf: return non NULL data pointer when CONFIG_HID_BPF is not set
Date:   Wed, 16 Nov 2022 11:31:10 +0100
Message-Id: <20221116103110.1746497-1-benjamin.tissoires@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dispatch_hid_bpf_device_event() is supposed to return either an error,
or a valid pointer to memory containing the data.

Returning NULL simply makes a segfault when CONFIG_HID_BPF is not set
for any processed event.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---

This was detected by my own CI. Yes, a little bit embarrassing...

It applies on top of for-6.2/hid-bpf in case it was not obvious

Cheers,
Benjamin

---

 include/linux/hid_bpf.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/hid_bpf.h b/include/linux/hid_bpf.h
index 9b11f8f25ad5..3ca85ab91325 100644
--- a/include/linux/hid_bpf.h
+++ b/include/linux/hid_bpf.h
@@ -148,7 +148,7 @@ void hid_bpf_device_init(struct hid_device *hid);
 u8 *call_hid_bpf_rdesc_fixup(struct hid_device *hdev, u8 *rdesc, unsigned int *size);
 #else /* CONFIG_HID_BPF */
 static inline u8 *dispatch_hid_bpf_device_event(struct hid_device *hid, enum hid_report_type type,
-						u8 *data, u32 *size, int interrupt) { return NULL; }
+						u8 *data, u32 *size, int interrupt) { return data; }
 static inline int hid_bpf_connect_device(struct hid_device *hdev) { return 0; }
 static inline void hid_bpf_disconnect_device(struct hid_device *hdev) {}
 static inline void hid_bpf_destroy_device(struct hid_device *hid) {}
-- 
2.37.3

