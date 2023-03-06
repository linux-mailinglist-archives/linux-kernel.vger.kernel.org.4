Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 772D36AD138
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 23:11:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbjCFWLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 17:11:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjCFWLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 17:11:05 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C463B20A
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 14:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678140598;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=vOophCpjusgwUNYYPMTooXspBj++ckS+ruBhJaNGhv0=;
        b=G9vBUaad8dHxJFxLRjfYdtHUwbt64Q7UAXgyIOH8olB9Vkyt60kMccldR/Wf0f1Z0JMA7Q
        J1ropCK0TyRs46mDmo/38mIYeq2+InSDA85ebYYcjNqtgaNbEkhlqgKQLznuE/WrDqEbAV
        SL2EOkv0CsWBUVPZkWflPjVmId/urlM=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-450-EXgVhvnxOauqAZrGcD1eTw-1; Mon, 06 Mar 2023 17:09:57 -0500
X-MC-Unique: EXgVhvnxOauqAZrGcD1eTw-1
Received: by mail-qt1-f197.google.com with SMTP id o10-20020a05622a138a00b003bfdabf3b89so6069180qtk.13
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 14:09:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678140596;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vOophCpjusgwUNYYPMTooXspBj++ckS+ruBhJaNGhv0=;
        b=AnCDBc1LbVsJfNuY+J7YGqwGWv5TLfIDVsmAYcgAsCPCuH7TSAUtMl7wZOMYblW5Q4
         aTKy7y76l6QZSfYJr9SazCLqU6eQ7HtRlo3dzDsMKHSbXigNf/nvvRrboMnZ2ibKKjqG
         XBNcIGyMW8DgK6XGPOCfTN3eyTisVD3Pofrqh829MEoXefJmgR56mfqldjrA5g3gROqS
         koHkrc3eliVC5Ngu8xkPpEIky+xvztQczLf8h/XllDf3j8+EoHfcYb098bnePg+ygs4O
         jOFtpkTKE07Cl/ctu1D/4gr98rVbDx+Yxzun38bJ2JjLGRhwPh8ZRKXb8vvfWg3rEs7j
         3xxQ==
X-Gm-Message-State: AO0yUKVDC4EnyVYQlyn/PQKLbO9c9Ugw5EF+Xpadk025I/qKmFY41DGA
        8ju3yNwHO6kzjDsa+C0u+HaPQlFeXD0izHaW6q4OmOqEcjNCGYywuw68FNpIg541yRLNcxRyoob
        aqQwm1OqOfpNsVuqS/0rUQyjq
X-Received: by 2002:a05:622a:134b:b0:3b6:3260:fa1d with SMTP id w11-20020a05622a134b00b003b63260fa1dmr20997327qtk.45.1678140596685;
        Mon, 06 Mar 2023 14:09:56 -0800 (PST)
X-Google-Smtp-Source: AK7set8GgiY+9cbM7LBZb/BNp1EefmRpRUsArdkNAYzYrqtiFnS2dotD0Rfl7N/1s/gPpiBBAtSG2A==
X-Received: by 2002:a05:622a:134b:b0:3b6:3260:fa1d with SMTP id w11-20020a05622a134b00b003b63260fa1dmr20997293qtk.45.1678140596472;
        Mon, 06 Mar 2023 14:09:56 -0800 (PST)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id d24-20020ac800d8000000b003bfaf01af24sm8432345qtg.46.2023.03.06.14.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 14:09:55 -0800 (PST)
From:   Tom Rix <trix@redhat.com>
To:     mhiramat@kernel.org, akpm@linux-foundation.org,
        ndesaulniers@google.com, masahiroy@kernel.org, paulmck@kernel.org,
        hannes@cmpxchg.org, ojeda@kernel.org, thunder.leizhen@huawei.com,
        christophe.leroy@csgroup.eu, vbabka@suse.cz
Cc:     linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] init/Kconfig: extend -Wno-array-bounds to gcc 13
Date:   Mon,  6 Mar 2023 17:09:47 -0500
Message-Id: <20230306220947.1982272-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

With gcc 13.0.1 on x86, there are several false positives like

drivers/net/ethernet/microchip/sparx5/sparx5_psfp.c:167:31:
  error: array subscript 4 is above array bounds of ‘const struct sparx5_psfp_gce[4]’ [-Werror=array-bounds=]
  167 |                 gce = &sg->gce[i];
      |                        ~~~~~~~^~~
In file included from drivers/net/ethernet/microchip/sparx5/sparx5_psfp.c:8:
drivers/net/ethernet/microchip/sparx5/sparx5_main.h:506:32: note: while referencing ‘gce’
  506 |         struct sparx5_psfp_gce gce[SPX5_PSFP_GCE_CNT];
      |                                ^~~

The code lines for the reported problem
	/* For each scheduling entry */
	for (i = 0; i < sg->num_entries; i++) {
		gce = &sg->gce[i];

i is bounded by num_entries, which is set in sparx5_tc_flower.c
	if (act->gate.num_entries >= SPX5_PSFP_GCE_CNT) {
		NL_SET_ERR_MSG_MOD(extack, "Invalid number of gate entries");
		return -EINVAL;
	}
..
	sg->num_entries = act->gate.num_entries;

So disable array-bounds as was done on gcc 11 and 12

Signed-off-by: Tom Rix <trix@redhat.com>
---
 init/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/init/Kconfig b/init/Kconfig
index 1fb5f313d18f..10d0a0020726 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -898,10 +898,14 @@ config GCC11_NO_ARRAY_BOUNDS
 config GCC12_NO_ARRAY_BOUNDS
 	def_bool y
 
+config GCC13_NO_ARRAY_BOUNDS
+	def_bool y
+
 config CC_NO_ARRAY_BOUNDS
 	bool
 	default y if CC_IS_GCC && GCC_VERSION >= 110000 && GCC_VERSION < 120000 && GCC11_NO_ARRAY_BOUNDS
 	default y if CC_IS_GCC && GCC_VERSION >= 120000 && GCC_VERSION < 130000 && GCC12_NO_ARRAY_BOUNDS
+	default y if CC_IS_GCC && GCC_VERSION >= 130000 && GCC_VERSION < 140000 && GCC13_NO_ARRAY_BOUNDS
 
 #
 # For architectures that know their GCC __int128 support is sound
-- 
2.27.0

