Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C682D6AE455
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 16:18:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbjCGPSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 10:18:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjCGPRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 10:17:35 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFA4448E25
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 07:13:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678201999;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=WvISTS/f4ZrOg4Qn5jDzcftulng+Jaj+2XVbo0ebuCg=;
        b=DHrBC22zzCIzS2hQW1YNBk1sQPnLpMYb3JQtDDor0lUlzByubQeo/SiTiVFGjXNSwpAlAG
        HQ+ikHg4NpkKHUhykXytYijnx1d3V/54CLQP+axhfo2DwpeA45dQmS7l0rjJP/dIhkVEW/
        USfgjIrwHEXHV47wnMpqaze6mQZ9iFM=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-336-okAT5TNxNRqkrnHfZ_keTQ-1; Tue, 07 Mar 2023 10:13:13 -0500
X-MC-Unique: okAT5TNxNRqkrnHfZ_keTQ-1
Received: by mail-qk1-f200.google.com with SMTP id dm13-20020a05620a1d4d00b00742a22c4239so7583756qkb.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 07:13:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678201992;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WvISTS/f4ZrOg4Qn5jDzcftulng+Jaj+2XVbo0ebuCg=;
        b=QldcJR0pymEzxOG7r480/CAXbT2m+qdFEGPI7BRmVCKIYBWeXniGUhj9LUDN5NoU3J
         WaeSnNaNdMKBBBmZ4wJZ/XuM/vgioDOmXxYKknaVGq2bYrOl7T9wtQB3fpGsMM7qqODo
         lBtR/EtYG1hJin8BdFsmtmcLuYFNHaEA21dUgq1h1o1RYQRmvYb4e6kj8F7v0F7EgOF/
         hC9JIPlqpoqv+EIt1qJ9/Ni8CFuXyP+wigLq3yt1wuh055vUxs8BLmH8pq4ByPE5dMLZ
         SU4G0GApgzmjtcO31qPQp+XUmaSZgIbGRpNjKYTkDMmPhLDhnPViGmL3Uh6Td8m5qZLp
         Wdsg==
X-Gm-Message-State: AO0yUKUWaGhcXvwgG4gbpVgeThqdVGkUd81fiFjeJzmaGqx6QQQ82K4V
        JZl2XR5gj4PCZlHcqx8i18FZFNPJjQOFWpw1iMSL/TuecEIbM8DpgG2CofpIqzCKTpJjYopo3Iw
        vHEaExXZFTk20CgyeyFp4BEDX
X-Received: by 2002:a05:622a:1443:b0:3bf:c994:c9b6 with SMTP id v3-20020a05622a144300b003bfc994c9b6mr23589674qtx.29.1678201992402;
        Tue, 07 Mar 2023 07:13:12 -0800 (PST)
X-Google-Smtp-Source: AK7set9TmvzsR4HqKIqb+BcjJiWtp9AaRyGnpSJemAFjbkf0yUgxhC8H5Nq/lMkoHAF+O/d53/mIuQ==
X-Received: by 2002:a05:622a:1443:b0:3bf:c994:c9b6 with SMTP id v3-20020a05622a144300b003bfc994c9b6mr23589642qtx.29.1678201992132;
        Tue, 07 Mar 2023 07:13:12 -0800 (PST)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id d79-20020ae9ef52000000b007296805f607sm9712804qkg.17.2023.03.07.07.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 07:13:11 -0800 (PST)
From:   Tom Rix <trix@redhat.com>
To:     martin.lau@linux.dev, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, nathan@kernel.org,
        ndesaulniers@google.com, joannelkoong@gmail.com
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Tom Rix <trix@redhat.com>
Subject: [PATCH] bpf: extend btf id list
Date:   Tue,  7 Mar 2023 10:12:39 -0500
Message-Id: <20230307151239.1994179-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With clang and W=1, there is this error

kernel/bpf/verifier.c:10298:24: error: array index 16 is past
 the end of the array (that has type 'u32[16]'
 (aka 'unsigned int[16]')) [-Werror,-Warray-bounds]
    meta.func_id == special_kfunc_list[KF_bpf_dynptr_slice_rdwr]) {
                    ^                  ~~~~~~~~~~~~~~~~~~~~~~~~
kernel/bpf/verifier.c:9150:1: note: array 'special_kfunc_list' declared here
BTF_ID_LIST(special_kfunc_list)
^
./include/linux/btf_ids.h:207:27: note: expanded from macro 'BTF_ID_LIST'
 #define BTF_ID_LIST(name) static u32 __maybe_unused name[16];

When KF_bpf_dynptr_slice_rdwr was added to the enum special_kfunc_type
the total exceeded 16.  Increase the array size to 32.

Fixes: 66e3a13e7c2c ("bpf: Add bpf_dynptr_slice and bpf_dynptr_slice_rdwr")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 include/linux/btf_ids.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/btf_ids.h b/include/linux/btf_ids.h
index 3a4f7cd882ca..166c387b48f7 100644
--- a/include/linux/btf_ids.h
+++ b/include/linux/btf_ids.h
@@ -204,7 +204,7 @@ extern struct btf_id_set8 name;
 
 #else
 
-#define BTF_ID_LIST(name) static u32 __maybe_unused name[16];
+#define BTF_ID_LIST(name) static u32 __maybe_unused name[32];
 #define BTF_ID(prefix, name)
 #define BTF_ID_FLAGS(prefix, name, ...)
 #define BTF_ID_UNUSED
-- 
2.27.0

