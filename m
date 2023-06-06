Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAD25724FC6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 00:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239914AbjFFWcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 18:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239901AbjFFWcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 18:32:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A92BD1723
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 15:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686090708;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TgaMBAQqmFIKSof0UPPW7FVba5nvGkZRXtKURLuSZuM=;
        b=bXV77NqRz9Op8dM11iLBmtaRG8rB1XnJJAV8r+Ya2g4s73un6SJ8zi80X07TT4bLWc0Cuf
        nUnVaOw8cQ7VR28eAZWpwXwjE2GbaJ64OVu2c+gaoyyQAX/lr3nNB2tzF9HnWHd5mo9JL1
        HofE+O1eIqIag09j5oqpdqm59oaxfy8=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-288-qxaUWhWwO4WZf5NIVnSdlw-1; Tue, 06 Jun 2023 18:31:46 -0400
X-MC-Unique: qxaUWhWwO4WZf5NIVnSdlw-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-97594143f1fso454677866b.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 15:31:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686090705; x=1688682705;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TgaMBAQqmFIKSof0UPPW7FVba5nvGkZRXtKURLuSZuM=;
        b=Ct45edVpVnZwY8ekiTONvqd4q0YhXhfakEAN2Se1L5FOfqOFRnvOgGDxvtLjmaV92l
         EViePitqDoQHoQpmDwWM5A5FE634k7ECSfzBMTpdwkNX46UFHiKWYncIqM++3ihcKfG1
         sMDMAIl2/WTyH+VP8ROtF9a4GbCRuDu0LEpYFPYp1vGEzgT6W802xvUHrWjZOeXPuIaB
         CF077BeSeTFidPCcmU4yDINlPrcLNbYJ/YPF7lLqHpMQFtSnsjlioS49Pr5V+hd791To
         Pkm0GL/OLDp4PB14yWGHRyYOVxbtEnNfCXYHI7rhy2xjmO8QJalTB07yJxvgCH4yKxOZ
         pkIg==
X-Gm-Message-State: AC+VfDxAV0+eAWzzzMMScZlDpGDbEqNi+OCrbbEg6529gJyPDy8p6lC3
        h2EkoZ9rXz3Gu5unCVVWzU6NXoto5r4f8uRBRMJxzer/zp/Ije7Ypy/FlJHtkxhPoDitw9KUhk/
        /aZ+f6f/e+drdRgAHNDziGBnO
X-Received: by 2002:a17:907:7f1f:b0:974:55ea:1ad8 with SMTP id qf31-20020a1709077f1f00b0097455ea1ad8mr4182399ejc.63.1686090705433;
        Tue, 06 Jun 2023 15:31:45 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7k+gI0czoVmC921zhzIqzKXOHylci9OpwOhdlMHjnqE4m4dX7VavWWqZ5q7J8PkPFhDWIb4g==
X-Received: by 2002:a17:907:7f1f:b0:974:55ea:1ad8 with SMTP id qf31-20020a1709077f1f00b0097455ea1ad8mr4182384ejc.63.1686090705309;
        Tue, 06 Jun 2023 15:31:45 -0700 (PDT)
Received: from cassiopeiae.. ([2a02:810d:4b3f:de9c:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id rh19-20020a17090720f300b0094edbe5c7ddsm6162646ejb.38.2023.06.06.15.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 15:31:44 -0700 (PDT)
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
Subject: [PATCH drm-next v4 02/14] maple_tree: split up MA_STATE() macro
Date:   Wed,  7 Jun 2023 00:31:18 +0200
Message-Id: <20230606223130.6132-3-dakr@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230606223130.6132-1-dakr@redhat.com>
References: <20230606223130.6132-1-dakr@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
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
2.40.1

