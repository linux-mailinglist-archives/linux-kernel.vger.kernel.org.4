Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4B766D5606
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 03:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232634AbjDDB3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 21:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232578AbjDDB3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 21:29:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EA4810D3
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 18:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680571680;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zKXKlpbqPz1zBDAc8gRMr7UD/43fGbZFIFAeWQ+/v+c=;
        b=YENrR3fzcquy8NVqzzhRwAbX3XfKwDAN+7FMzwvAYq8s33manYEh6/r2QrcO804wB/Oqkx
        M8MrCekUw54SbI8Yh+7P8Y9RHwXZEh5ACVyzOWzR/kfFjX86jyR3P5+Eij5ZnhI2XbZU3a
        fJLIdVP0/81GP8tQCb1LRv39Sp4PxbM=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591--PpjZpA3NwyGgg0E3WNS3A-1; Mon, 03 Apr 2023 21:27:59 -0400
X-MC-Unique: -PpjZpA3NwyGgg0E3WNS3A-1
Received: by mail-ed1-f70.google.com with SMTP id j21-20020a508a95000000b004fd82403c91so43277975edj.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 18:27:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680571678;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zKXKlpbqPz1zBDAc8gRMr7UD/43fGbZFIFAeWQ+/v+c=;
        b=0mMpd69gDRghEL4Z+sm8qzXzJToRfE0U6vFaS9jkJlRIMruyrrdXX6aZjXTzGWjR1Z
         P+smnS4wiAUqooAjXDi0ltknNKGc1+rRXBIMNEN7y0QQVelgeuocMyZxcEe0I2X1LndN
         Z71nqEax2l22ViWR1U2TW1pREDUkacR5RJVYIovlrwxNbtp9oBNZ4sXHCAvevbNJmJiZ
         oC+P9uAJ8A4TfuNN7F5/s0EutYEjo/AH4IP1QdCI1jnRW0NnvxV4IIHR89HR7K5OKn84
         VP4DuK9NzuPhakof9JjhK/cZA73dImsQAChoDevsocHsfF9EQQR60weNrnogeVgn6drM
         ykdQ==
X-Gm-Message-State: AAQBX9cY/AzSZa2x/VBcvrfJJAnvutzVIMIWV4Lu9kV9J6c70qg2CcK1
        k2Vu4g5I4SG7VpFZaZ22ROmqSmdILIFNMk0VT+Tgq58m7tSsmdo9whODZp4qKLeE8RE1VQ2AvWy
        /oWxlRklKGgm6rATwM4U7bskd
X-Received: by 2002:a17:906:3518:b0:947:f937:d58c with SMTP id r24-20020a170906351800b00947f937d58cmr399013eja.73.1680571678179;
        Mon, 03 Apr 2023 18:27:58 -0700 (PDT)
X-Google-Smtp-Source: AKy350YwVNPsPlkQRJTUmcCSFAR4UCs9dVRBPURJGBPqRf9UDK5ZqVStZ/XxLd5hu3kZ37jVcjG1Sg==
X-Received: by 2002:a17:906:3518:b0:947:f937:d58c with SMTP id r24-20020a170906351800b00947f937d58cmr398989eja.73.1680571677891;
        Mon, 03 Apr 2023 18:27:57 -0700 (PDT)
Received: from cassiopeiae.. ([2a02:810d:4b3f:de78:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id z9-20020a17090665c900b0093fa8c2e877sm5158255ejn.80.2023.04.03.18.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 18:27:57 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     airlied@gmail.com, daniel@ffwll.ch, tzimmermann@suse.de,
        mripard@kernel.org, corbet@lwn.net, christian.koenig@amd.com,
        bskeggs@redhat.com, Liam.Howlett@oracle.com,
        matthew.brost@intel.com, boris.brezillon@collabora.com,
        alexdeucher@gmail.com, ogabbay@kernel.org, bagasdotme@gmail.com,
        willy@infradead.org, jason@jlekstrand.net
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-next v3 03/15] maple_tree: split up MA_STATE() macro
Date:   Tue,  4 Apr 2023 03:27:29 +0200
Message-Id: <20230404012741.116502-4-dakr@redhat.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230404012741.116502-1-dakr@redhat.com>
References: <20230404012741.116502-1-dakr@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Split up the MA_STATE() macro such that components using the maple tree
can easily inherit from struct ma_state and build custom tree walk
macros to hide their internals from users.

Example:

struct sample_iterator {
	struct ma_state mas;
	struct sample_mgr *mgr;
};

\#define SAMPLE_ITERATOR(name, __mgr, start)			\
	struct sample_iterator name = {				\
		.mas = MA_STATE_INIT(&(__mgr)->mt, start, 0),	\
		.mgr = __mgr,					\
	}

\#define sample_iter_for_each_range(it__, entry__, end__) \
	mas_for_each(&(it__).mas, entry__, end__)

--

struct sample *sample;
SAMPLE_ITERATOR(si, min);

sample_iter_for_each_range(&si, sample, max) {
	frob(mgr, sample);
}

Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 include/linux/maple_tree.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
index 1fadb5f5978b..87d55334f1c2 100644
--- a/include/linux/maple_tree.h
+++ b/include/linux/maple_tree.h
@@ -423,8 +423,8 @@ struct ma_wr_state {
 #define MA_ERROR(err) \
 		((struct maple_enode *)(((unsigned long)err << 2) | 2UL))
 
-#define MA_STATE(name, mt, first, end)					\
-	struct ma_state name = {					\
+#define MA_STATE_INIT(mt, first, end)					\
+	{								\
 		.tree = mt,						\
 		.index = first,						\
 		.last = end,						\
@@ -435,6 +435,9 @@ struct ma_wr_state {
 		.mas_flags = 0,						\
 	}
 
+#define MA_STATE(name, mt, first, end)					\
+	struct ma_state name = MA_STATE_INIT(mt, first, end)
+
 #define MA_WR_STATE(name, ma_state, wr_entry)				\
 	struct ma_wr_state name = {					\
 		.mas = ma_state,					\
-- 
2.39.2

