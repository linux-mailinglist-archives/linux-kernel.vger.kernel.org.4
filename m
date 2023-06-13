Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDEAE72ECC3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 22:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240940AbjFMUTQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 16:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241050AbjFMUSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 16:18:55 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D720E1BEA
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 13:18:34 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id 46e09a7af769-6b291d55f52so3333885a34.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 13:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686687514; x=1689279514;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U6KHUky1DpkusNGgmBNXNnpcQ1dWjAR0pkWJnKeXby4=;
        b=K51pHP9wViB3ZadMEXzWsfIDKin1lsEdjUYjh4DAwZ9sRHvdPjCCPf9ICl06aw5cUM
         QCRpWcyMMeWIyke9qqZO0B0qjy/mN6tyRAheWiPYKE6boBZfSeHb/3glWNTAVPHzvltu
         anwJ3GiEbzQXjjlDk2g9eGm7zSJB9xg+Ehl/JjSyVxyt9Y93aNsoDxx7HWS9aKOTwE0s
         7XtO9aZwf6Lem17hnmOg8y48qHKRxU5qXgoihMMzOSYzowYHUNkGTr0uuTOGdw4cTmks
         K7jkvCu8YCPUkTvNSDe4dX/b+Fbp7pNGPckvp3MXIBC/7nzzhr6wE2Hs9UBoSHWI0pon
         8/6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686687514; x=1689279514;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U6KHUky1DpkusNGgmBNXNnpcQ1dWjAR0pkWJnKeXby4=;
        b=ka4FxCPqVpY5UaDo0frxHIBIjBNBiTh9IUzbfP/Es22Z+bIXlyx8oZqvUHYzxdWPi/
         pDoL+ppMabHBXi8eVzgf2squlKZE2GylXPg3b+/bDxQ+89W0S+KmF2p+q7QQhT/IJuwz
         yiS/rIgFXPI+gLoSPTGjYRfzEI15ynjEMwk7vtPBoLPkqM1gkuIi/tam0XU9rxSnNhpZ
         iVmZH2FlsRJz2FhZ6RRBraxwyinZGVRWSZeyj856HDIR5YBoW7nAnCHTwpSa1vS8Ox8X
         T04Me5Ic0al5UzY1cEDhY7xDU7n1U4SHxij3ITQkui5lAfX4Lc5JskCeWp/0rhsJ9MT1
         YfEw==
X-Gm-Message-State: AC+VfDw4VS1qCBNn2rFbzmMS9QgX8iBtbgUUZxBEPT4FLX5uL+woUADr
        bmI7D1fhPFJaETRucknKocs=
X-Google-Smtp-Source: ACHHUZ4eH3naw2Bb7NNIPO+T6DjhoydZDXuiQtS5uS/ty3oL192spHUAvHw0WLQKL53n1rGK/9di5Q==
X-Received: by 2002:a05:6358:e813:b0:12b:dce7:f428 with SMTP id gi19-20020a056358e81300b0012bdce7f428mr5201292rwb.1.1686687513897;
        Tue, 13 Jun 2023 13:18:33 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::e])
        by smtp.googlemail.com with ESMTPSA id b72-20020a0dd94b000000b0056cea0480c6sm2509985ywe.2.2023.06.13.13.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 13:18:33 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH 2/5] mmzone: Introduce folio_migratetype()
Date:   Tue, 13 Jun 2023 13:18:24 -0700
Message-Id: <20230613201827.9441-3-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230613201827.9441-1-vishal.moola@gmail.com>
References: <20230613201827.9441-1-vishal.moola@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce folio_migratetype() as a folio equivalent for
get_pageblock_migratetype(). This function intends to return the
migratetype the folio is located in, hence the name choice.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 include/linux/mmzone.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 744bf32e48a8..b58c76e68ac7 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -105,6 +105,9 @@ extern int page_group_by_mobility_disabled;
 #define get_pageblock_migratetype(page)					\
 	get_pfnblock_flags_mask(page, page_to_pfn(page), MIGRATETYPE_MASK)
 
+#define folio_migratetype(folio)				\
+	get_pfnblock_flags_mask(&folio->page, folio_pfn(folio),		\
+			MIGRATETYPE_MASK)
 struct free_area {
 	struct list_head	free_list[MIGRATE_TYPES];
 	unsigned long		nr_free;
-- 
2.40.1

