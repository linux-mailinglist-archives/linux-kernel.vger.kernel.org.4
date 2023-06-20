Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 657AD7360BC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 02:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjFTAn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 20:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjFTAnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 20:43:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5134210C1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 17:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687221756;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C9apoWPgHQ+HttjrVOmvMmvBAGzRpC/qILH8eE4EO5c=;
        b=SflrllJCClIuWKYrZsEM01Q2Z0OHgt6T6f2W/3RBC+l4g0iD5I/060vtexSWkPPr/WV+2B
        GuhQquTLdahkz8cYUYWVaxnD2L3DhHwgOjtuCr1RxPYxl6542Y23IPYPstd6qFNpUjoV9Z
        yfeYdq6mfLeqq0Jh4uu5BKOZemW82hg=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-281-q5j84Qn9OmSrvx8xRMLrNQ-1; Mon, 19 Jun 2023 20:42:35 -0400
X-MC-Unique: q5j84Qn9OmSrvx8xRMLrNQ-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-94a341efd9aso320979666b.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 17:42:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687221754; x=1689813754;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C9apoWPgHQ+HttjrVOmvMmvBAGzRpC/qILH8eE4EO5c=;
        b=EUAmgPRzv9gz5Xzm36giIMnOBChV0jwxwjTxEmCoy7rO1al2o+Ar8q4AwN+B0OSdJE
         d2B9d+9qwzntSVBSvF5lCiACqOA8KuyEKwDACUiziK1JEITA2vf/5BHKPvBgjAcphW0n
         zdSucfMRDwAu7eTJSsBWv6shUDfpDiD0Xr3pUwvevMWwHhXohaKoxPNH+kjvCqFzjUti
         VJp0p/LXe1X3Py00ruSk3XPdu9HLCuhZGWCbM58dlPYAHUcO4jqhjRvWzBgX6vFTRfdv
         6nhgCN+1E5pG4XeMzlQymKnxt0C/RHOMC2vxkwVcN9gXalikqItUFsGffrZSUZHoCTG2
         +mug==
X-Gm-Message-State: AC+VfDzfHTf2v4DfYWl3Lhc0J9i07QrpydqU/WjLy35/zpn7XutisWqD
        xD529IHPO7SHIzxLMdBAvm1u5v2V6qlOcqIR4tycRiHKmD/pFAP44ISfNEcBE4RiT59EKNUnnXX
        f/gjnGn+pSeVYJYnwVD4e4Uzh
X-Received: by 2002:a17:907:3e0a:b0:8b1:7de3:cfaa with SMTP id hp10-20020a1709073e0a00b008b17de3cfaamr11230756ejc.3.1687221754040;
        Mon, 19 Jun 2023 17:42:34 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7CuI4jncrqThsJCOY9EL8v0SHvOVlwMCpxRyLtkLTLUI18H8CeggEpcXJgjnduPuXIFRYrhA==
X-Received: by 2002:a17:907:3e0a:b0:8b1:7de3:cfaa with SMTP id hp10-20020a1709073e0a00b008b17de3cfaamr11230750ejc.3.1687221753916;
        Mon, 19 Jun 2023 17:42:33 -0700 (PDT)
Received: from cassiopeiae.. ([2a02:810d:4b3f:de9c:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id c16-20020a17090603d000b00986e6a7d230sm377729eja.168.2023.06.19.17.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 17:42:33 -0700 (PDT)
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
Subject: [PATCH drm-next v5 02/14] maple_tree: split up MA_STATE() macro
Date:   Tue, 20 Jun 2023 02:42:05 +0200
Message-Id: <20230620004217.4700-3-dakr@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230620004217.4700-1-dakr@redhat.com>
References: <20230620004217.4700-1-dakr@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
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

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
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
2.40.1

