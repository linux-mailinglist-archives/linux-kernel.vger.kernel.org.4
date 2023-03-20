Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E89146C1EF7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 19:04:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbjCTSEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 14:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjCTSDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 14:03:55 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D40252F79C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 10:58:04 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id a16so8664514pjs.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 10:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679335063;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4AANWMLFPRmqhsaZtqr8wdmw+KFHZMOER6tyEOUd1jY=;
        b=REH2jn2OfcZCAPeStUeUq49OTLi9tZJ5xjqGFjPTLsMVH6/lywLOG04dMcYwMxi1dq
         s1gvbYmT9zVGC7S0wevCthgCeWAyxbV+0bt7yn4ymYzp3tCTxf40fys0jshhpVu9e+Xc
         5OPYpWIP559OGoz3qQdiV+VTrZBBDCegBBy4fYeavrB1cpH5zc/gtRs/OzbVwglpbuIa
         rSPkHe1nO2S8agJTliFff2+AKg5Fi6EXhmLhS9CsEQ56F5xW2p4ROE8SUJzvhsYIr5/j
         OrN9g4WBQIPyZKyIdw+SI6hdNMol3M7JXYQW49I+C4sIF0dcDNl3KsjwnEkXMRXKXcS6
         EJgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679335063;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4AANWMLFPRmqhsaZtqr8wdmw+KFHZMOER6tyEOUd1jY=;
        b=1xrPpGxyup8std6L6ncmiGadaeWCttgexAm4qsIAdH8U4FqusXw1tfL1aZbxKXumkf
         NkyBSVyHaDtatJA5pDeyny1ZxllR+8b/Jsan+bEtmgIJG6InkelDFZyAfDScRaOf4iKA
         6J5V0drwim+Zw8qFP2EpzgVpA5ca+/RCAZwLNHwImGVlrPGzUu7z4j+UURt1n8Abwi+R
         kgonpe45Ge37u867RuoLisu5O/aAPe1xtvgaT5uukrWa6hE2x968lgWgObiC9nxY2Poa
         fXOdj25kMZ4phSOagjeFPDy89N/Vie8IiopTogd0w9uF+a5Meyr3HpCJ2Hl8Kgu42DaC
         VzOA==
X-Gm-Message-State: AO0yUKWm5VMbTK3nej7eVy/b0gu0H1a3pLTcs1ZNLuNlPLqq2dXR/1dV
        kXz8mpaCK0OhvEnsNVqb3/w=
X-Google-Smtp-Source: AK7set8fGDyvTqz/UDhWEIkreYPizKZ+oIkBGAVWJ/oXrm7P+7Mwvb2ax5zFzHUbFo+e42xQrwArwQ==
X-Received: by 2002:a17:902:d0d3:b0:19d:1a8e:836f with SMTP id n19-20020a170902d0d300b0019d1a8e836fmr15097987pln.27.1679335063575;
        Mon, 20 Mar 2023 10:57:43 -0700 (PDT)
Received: from f37.eng.vmware.com ([66.170.99.1])
        by smtp.googlemail.com with ESMTPSA id q2-20020a170902edc200b001a1a18a678csm7040042plk.148.2023.03.20.10.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 10:57:43 -0700 (PDT)
From:   Shreenidhi Shedi <yesshedi@gmail.com>
X-Google-Original-From: Shreenidhi Shedi <sshedi@vmware.com>
To:     gregkh@linuxfoundation.org, dhowells@redhat.com,
        dwmw2@infradead.org
Cc:     yesshedi@gmail.com, linux-kernel@vger.kernel.org, sshedi@vmware.com
Subject: [PATCH v5 6/7] sign-file: use const with a global string constant
Date:   Mon, 20 Mar 2023 23:27:30 +0530
Message-Id: <20230320175731.79709-6-sshedi@vmware.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230320175731.79709-1-sshedi@vmware.com>
References: <20230320175731.79709-1-sshedi@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shreenidhi Shedi <yesshedi@gmail.com>

Reported by checkpatch.

Signed-off-by: Shreenidhi Shedi <yesshedi@gmail.com>
---
 scripts/sign-file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/sign-file.c b/scripts/sign-file.c
index d3abc5721a7e..e8dfbdd3eea3 100644
--- a/scripts/sign-file.c
+++ b/scripts/sign-file.c
@@ -71,7 +71,7 @@ struct module_signature {
 
 #define PKEY_ID_PKCS7 2
 
-static char magic_number[] = "~Module signature appended~\n";
+static const char magic_number[] = "~Module signature appended~\n";
 
 static __attribute__((noreturn))
 void print_usage(void)
-- 
2.39.2
