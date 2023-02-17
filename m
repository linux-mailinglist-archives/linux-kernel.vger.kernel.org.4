Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B775669ACD7
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 14:46:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbjBQNpy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 08:45:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbjBQNpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 08:45:30 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6607C13D65
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 05:44:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676641483;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ysk0aOdzp2igGOtHeZoTd2E71aY9qQ/NU2yUGbV3q7I=;
        b=PMCDPjjTA/rrNGC4Vylab7IVxFwRiyFhD8G72minNrGtbNkC3/7L1zKz41lIALSi7RaCJF
        V88vnFD2EJdvIo8nsmfj4TXP4dj9BytB9FjNLzSHF+s/hS6X0Hkcxs+b/RdH0JFTxySc+e
        ZufSTYlUEtWXTZeOcSVQAZOC0N1ui7o=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-673-M4VkDKjFNnmdZfWubZMmgA-1; Fri, 17 Feb 2023 08:44:42 -0500
X-MC-Unique: M4VkDKjFNnmdZfWubZMmgA-1
Received: by mail-ed1-f69.google.com with SMTP id d9-20020a056402400900b004ad062fee5eso1727798eda.17
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 05:44:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ysk0aOdzp2igGOtHeZoTd2E71aY9qQ/NU2yUGbV3q7I=;
        b=7Ly/Xh5XfWS/eu8q+6erM7HnTDp0DMa5vtjijm32CEanJu/8Tc45Z0i4jRI+glUe+g
         zOoEvGfkgXckCei4DOiyk/VpDJ/H0yQD5kTSZxLn6+K2GlqqaFgrek84p7urLV+S+jGX
         LkY4NZG+7Zeo+csVzmhsz+TeYwjWeXMaeM7TmHOfgr3SYIIm1RGnLVp/OSGyVTDpHxv8
         mXIWdjtG+AGlUhxakLeaMFjSkK85wkPGL6klbEna3nU0WRe2wYPPa0XpHmL3OCNdoldl
         /YrinjtkHEz3c+12ZIMn68w2hOZ/sTJSGjskk9gRX/H31MqUp71ua2MtuaFGLWZC6PxC
         7i5A==
X-Gm-Message-State: AO0yUKX1JIbxNPRb9i3XpYFEe2cnFrO1SBDEVsbD1tOHLvR67p2NBHTB
        pJjEnRcWnHTKq8iiU/9MjrRlGY2el0wlZOZy0dzGMWApnUoCAKj6vxaDLdCp0Qapmx4RABayQHP
        OHmZJf/Tg3yTiHrx60i7kxdgs
X-Received: by 2002:a17:907:d309:b0:8b1:2dda:b60d with SMTP id vg9-20020a170907d30900b008b12ddab60dmr5401603ejc.20.1676641481149;
        Fri, 17 Feb 2023 05:44:41 -0800 (PST)
X-Google-Smtp-Source: AK7set+xPQs4iBYRE3EkYeswx89ncoFpP13u/wl+vaRpLe0EqlVsAKT/Yi78czFv33gb2ohWXHgOKA==
X-Received: by 2002:a17:907:d309:b0:8b1:2dda:b60d with SMTP id vg9-20020a170907d30900b008b12ddab60dmr5401592ejc.20.1676641481019;
        Fri, 17 Feb 2023 05:44:41 -0800 (PST)
Received: from cassiopeiae.. ([2a02:810d:4b3f:de78:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id r10-20020a1709063d6a00b00882f9130eafsm2167138ejf.26.2023.02.17.05.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 05:44:40 -0800 (PST)
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
Subject: [PATCH drm-next v2 03/16] maple_tree: split up MA_STATE() macro
Date:   Fri, 17 Feb 2023 14:44:09 +0100
Message-Id: <20230217134422.14116-4-dakr@redhat.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230217134422.14116-1-dakr@redhat.com>
References: <20230217134422.14116-1-dakr@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
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

struct sample_iter {
	struct ma_state mas;
	struct sample_mgr *mgr;
	struct sample_entry *entry;
};

\#define SAMPLE_ITER(name, __mgr) \
	struct sample_iter name = { \
		.mas = __MA_STATE(&(__mgr)->mt, 0, 0),
		.mgr = __mgr,
		.entry = NULL,
	}

\#define sample_iter_for_each_range(it__, start__, end__) \
	for ((it__).mas.index = start__, (it__).entry = mas_find(&(it__).mas, end__ - 1); \
	     (it__).entry; (it__).entry = mas_find(&(it__).mas, end__ - 1))

Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 include/linux/maple_tree.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
index e594db58a0f1..ca04c900e51a 100644
--- a/include/linux/maple_tree.h
+++ b/include/linux/maple_tree.h
@@ -424,8 +424,8 @@ struct ma_wr_state {
 #define MA_ERROR(err) \
 		((struct maple_enode *)(((unsigned long)err << 2) | 2UL))
 
-#define MA_STATE(name, mt, first, end)					\
-	struct ma_state name = {					\
+#define __MA_STATE(mt, first, end)					\
+	{								\
 		.tree = mt,						\
 		.index = first,						\
 		.last = end,						\
@@ -435,6 +435,9 @@ struct ma_wr_state {
 		.alloc = NULL,						\
 	}
 
+#define MA_STATE(name, mt, first, end)					\
+	struct ma_state name = __MA_STATE(mt, first, end)
+
 #define MA_WR_STATE(name, ma_state, wr_entry)				\
 	struct ma_wr_state name = {					\
 		.mas = ma_state,					\
-- 
2.39.1

