Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C43E4662220
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 10:52:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236991AbjAIJwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 04:52:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234316AbjAIJvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 04:51:51 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABD6512A9F;
        Mon,  9 Jan 2023 01:51:16 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id v23so4014684plo.1;
        Mon, 09 Jan 2023 01:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qzAkXDnr+TdemKBTBoMvg+ajy3gTNmDpDPz0yRbk3cE=;
        b=YvvsnJv5X4MUa+p4z03Whw3JreTN28OlOQDeRk00dRsPzl2hjoiwhHe8MmilQjHg1R
         mTZnctOdGE58MmP9jlWlrcyPgDM6vYriXgTNgksaXWM9bFyu+FB3URLwp1OdJQsms+YB
         qoTb9Bxh5fJR0n09ABaLMyo8QdpPViaymXfyH4C6o/dBndgHcOIPBnfsop8LCZ2kmjqb
         eXSfm/gcTve4Ho2IvPfp2FgIBadrWQMZBFkfAcUWZVgGX1kT6nke6c9yZH07jcHkI711
         dJJmnSRAi5RhwalRTat/fHJsLOtJAjOBt1jstkFa/yxiZNnrzZEmfGjG+TpsYiJ9t++1
         z7jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qzAkXDnr+TdemKBTBoMvg+ajy3gTNmDpDPz0yRbk3cE=;
        b=wSSWlLfr19BlN3azQwfoq3njBlalOB/V8BYDO4qIiR96L88AZbcYCRH8uGI3GPZ1RR
         8X15YnbXjhWEmZdweJ5S7uteIXZMppYPbOZdPxtxZxrNE831Z2syfirvswwarmO7lcPZ
         DPrpGW/txHzyEArgGqYReGaWVAZZjIMEspbXT2Fdwemw4S//+JB0C8CzUq62gXgX663d
         tiGE7LhgXtNfJI+/oh5cVxWZHlLoQk9JhNUMyy8Wf1MLuqIK5xiUcjYqfvBGT7+N5MeU
         qVu9HV3IgM92DL2CW8F30CBhErSvWRtrO1JQP7dEOelJflycqwyYysijyuT6BgCjs0Sj
         Xcfw==
X-Gm-Message-State: AFqh2kpWY+q6R/w27oEAXxcwahD/WJA57iEODPHHxm1WY8U5CV9e9fmf
        YcaINUrBOg6QwmLiBQmD6J4EtUIGX3s=
X-Google-Smtp-Source: AMrXdXsRVOml529LPLQlVFkBn0nmrdj7dfS8KuXQ8GTtvZEnNn01ICbGEiyj+JlcieFnWtB9IfmxJg==
X-Received: by 2002:a05:6a20:3953:b0:ab:fb31:a000 with SMTP id r19-20020a056a20395300b000abfb31a000mr96323913pzg.51.1673257876104;
        Mon, 09 Jan 2023 01:51:16 -0800 (PST)
Received: from debian.me (subs03-180-214-233-26.three.co.id. [180.214.233.26])
        by smtp.gmail.com with ESMTPSA id c15-20020aa7952f000000b005747b59fc54sm4333309pfp.172.2023.01.09.01.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 01:51:15 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 3FBD9103E6A; Mon,  9 Jan 2023 16:51:10 +0700 (WIB)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Yann Sionneau <ysionneau@kalray.eu>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Clement Leger <clement.leger@bootlin.com>,
        Guillaume Thouvenin <gthouvenin@kalray.eu>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH 5/8] Documentation: kvx: kvx-iommu: monospacize kvx iommu device tree path
Date:   Mon,  9 Jan 2023 16:51:05 +0700
Message-Id: <20230109095108.21229-6-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230109095108.21229-1-bagasdotme@gmail.com>
References: <874jt7fqxt.fsf@meer.lwn.net>
 <20230109095108.21229-1-bagasdotme@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=931; i=bagasdotme@gmail.com; h=from:subject; bh=iPlc/Kn3v/D/f2FzuuvXP8mVDXIepRcvmfLOHBwcrPw=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDMm7H3cXtN8SPWfRHq81STPLaI2mc+yj9nndTnkCDZ477sbM cl3cUcrCIMbFICumyDIpka/p9C4jkQvtax1h5rAygQxh4OIUgIkkHWNkWOKiK7M15vLTuw+NIqs+Md 1KPK/OfsZ9zzvpnQHCFzk31DH8U9P8kjHl7DbX1+9zDh04q7Hqm5ZlyIn9U56cXlYas3SBDyMA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device tree path shares the same "kvm-iommu" as the actual
documentation path (kvm-iommu.rst), which make it links to the doc
instead. Monospacize the path by enclosing it in inline code.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/kvx/kvx-iommu.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/kvx/kvx-iommu.rst b/Documentation/kvx/kvx-iommu.rst
index 5ed34463b8bb1f..c97035ba624c22 100644
--- a/Documentation/kvx/kvx-iommu.rst
+++ b/Documentation/kvx/kvx-iommu.rst
@@ -178,7 +178,7 @@ Device tree
 -----------
 
 Relationships between devices, DMAs and IOMMUs are described in the
-device tree (see Documentation/devicetree/bindings/iommu/kalray,kvx-iommu.txt
+device tree (see ``Documentation/devicetree/bindings/iommu/kalray,kvx-iommu.txt``
 for more details).
 
 Limitations
-- 
An old man doll... just what I always wanted! - Clara

