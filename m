Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC076FCD12
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 19:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234032AbjEIR5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 13:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233992AbjEIR5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 13:57:43 -0400
Received: from m228-4.mailgun.net (m228-4.mailgun.net [159.135.228.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B1724EDD
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 10:57:41 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=equiv.tech; q=dns/txt;
 s=mx; t=1683655060; x=1683662260; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Subject: Cc: To: To:
 From: From: Sender: Sender; bh=6jttwz+Cugq4ceWJPmbhCtB6fO9JHbLfWVDtldhs2RI=;
 b=X7u5t44Q2a7RtJmVkklR1X/ulwhIPJYP6Bx1SJLNVEjmZgpAehFIqbRoLin1UK59t9r3dzHDXptVlwAQKPdmRb1rtkYNuGVKt4DhlV9WqbL2R3QlK6dOZ+qrlobd9+CgQDDNldn0aXNGdQrAdcN5p+8Qn/GbPq26GmsvHqyqKcC5aQ3UklB+tTr+3LqRzWBZZIkdJu5ceatCl2ZUPrsbKjFjMFGnHoPfc2lB0SDX7phDbTMI6zTKruh7HXUsR+GLQyqDJo/ZV0TvE+ONYlGAM3hIgQcNRQqNPJi2qgIzS6rBoTOWnCvXr5XD6HDejOXcURV7tKLxuR/YH2U4fttpFA==
X-Mailgun-Sending-Ip: 159.135.228.4
X-Mailgun-Sid: WyI4ZWI3MiIsImxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmciLCI5M2Q1YWIiXQ==
Received: from mail.equiv.tech (equiv.tech [142.93.28.83]) by c8d9e52701dd with SMTP id
 645a8994dd415858cb50579b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 09 May 2023 17:57:40 GMT
Sender: james@equiv.tech
From:   James Seo <james@equiv.tech>
To:     Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     James Seo <james@equiv.tech>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] Documentation: conf.py: Add __force to c_id_attributes
Date:   Tue,  9 May 2023 10:55:43 -0700
Message-Id: <20230509175543.2065835-2-james@equiv.tech>
In-Reply-To: <20230509175543.2065835-1-james@equiv.tech>
References: <20230509175543.2065835-1-james@equiv.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following error in the docs build that occurs with recent
versions of Sphinx when parsing kerneldocs for a function with the
'__force' macro in its signature:

  ./include/linux/err.h:51: WARNING: Error in declarator or parameters
  Error in declarator or parameters
  Invalid C declaration: Expected identifier, got keyword: void [error at 35]
    void * ERR_CAST (__force const void *ptr)
    -----------------------------------^

Currently, almost all of the few in-signature occurrences of '__force'
are in the error pointer functions. Of those, ERR_CAST() is the only
one with kerneldocs, but the kerneldocs aren't even being used to
generate documentation. This change will allow all the error pointer
functions to be properly documented.

In addition to '__force', <linux/compiler_types.h> also defines
'__nocast', '__safe', and '__private'. These are not currently used in
any function signatures and do not need to be added to the docs config.

Signed-off-by: James Seo <james@equiv.tech>
---
 Documentation/conf.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/conf.py b/Documentation/conf.py
index 37314afd1ac8..d4fdf6a3875a 100644
--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -74,6 +74,7 @@ if major >= 3:
             "__percpu",
             "__rcu",
             "__user",
+            "__force",
 
             # include/linux/compiler_attributes.h:
             "__alias",
-- 
2.34.1

