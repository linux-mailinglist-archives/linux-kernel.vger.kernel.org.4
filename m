Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A52716C73F1
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 00:17:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbjCWXRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 19:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjCWXRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 19:17:10 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B3D519C5F
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 16:17:09 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id cu4so620918qvb.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 16:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679613428;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ii1C/7JJiAWrr0n4Sj/e0pcYJ+z7V8KDh2zqZ2/fO3Q=;
        b=D2S+nz909zw/Jul8nzDozG+ztDYl5MhyWiQB6ffeX9fBL8CYDAPIW2CoEuW5bLte3t
         oDhnToir/u2VhgCGeymvvfuhCWOFjsN4NlBFx5QJZo8atBMMpwo5xJu+1yuZoKSn0lQB
         YRcL/VYQIsg4eKvjw5XtR3zAXGWo16SnkR3clHP5VKu13+g6vWYdUTE2GOk4NRFKy5kg
         WNBzGkf89ZiGw881bSdarc667K991sXSAM0Ja9NWBPftzEh3/+xjgxY5nvIuXs84f0Uj
         pOQx375QK4eKwhh7OxZLuYOEfWMjmdPsCxv9cfNvLEpgd2Or/jQ9JPKfUOR1lPKfACvv
         b7xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679613428;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ii1C/7JJiAWrr0n4Sj/e0pcYJ+z7V8KDh2zqZ2/fO3Q=;
        b=GvhhINdxAKnHZi9HsdmySwXW0LFBZcTY0YXbBs3z7OD4HSR9Hh4hF2OrAdiWgrbNob
         8BjoHBOxgiZfApgZO9hdg1pzeKL+Q+h67lWuyNDqSb8+MgBW9uz4XcPia7yMoztOZ50y
         DSQKObAuNww+GZlBI6YwJ3itc7qmLkNvTAdDBuoTOOyU/SrNoBnr3/AZxuu3/I2Dg4BY
         1V/i2moIpVmdSThYWJNT/JrY7iQT+yXu8srMwNccOxqtBN/LW0lyJE4IZk9ENG5XiZ1u
         YIfurbtnXQorhOaYlMnOCC9+CtvQ29GUVvFuD14qwmK4/T9f5dfyAH7g8zvHZuDSJmp/
         uaeQ==
X-Gm-Message-State: AAQBX9duHAdKzMDErY4wi1XOe0nvw+Ycfj408Gl78jSn+dnqjvdg/fR9
        phjawqXbsrfLqXaCND+1PGEj335Fvz0=
X-Google-Smtp-Source: AKy350Z/8+JXK19M5r5CnO1BAWOlvIwPyCqvq5EUIS4g4FStNo8Tfj7GoatYtZaeUlOSekQkb2YphQ==
X-Received: by 2002:a05:6214:2461:b0:5ac:b644:b4c5 with SMTP id im1-20020a056214246100b005acb644b4c5mr1223230qvb.47.1679613428071;
        Thu, 23 Mar 2023 16:17:08 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id mf10-20020a0562145d8a00b005dd8b9345e8sm226560qvb.128.2023.03.23.16.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 16:17:07 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH] scripts/gdb: Bail early if there are no generic PD
Date:   Thu, 23 Mar 2023 16:16:57 -0700
Message-Id: <20230323231659.3319941-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid generating an exception if there are no generic power domain(s)
registered:

(gdb) lx-genpd-summary
domain                          status          children
    /device                                             runtime status
----------------------------------------------------------------------
Python Exception <class 'gdb.error'>: No symbol "gpd_list" in current context.
Error occurred in Python: No symbol "gpd_list" in current context.
(gdb) quit

Fixes: 8207d4a88e1e ("scripts/gdb: add lx-genpd-summary command")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 scripts/gdb/linux/genpd.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/scripts/gdb/linux/genpd.py b/scripts/gdb/linux/genpd.py
index 39cd1abd8559..09f9b75cbcdd 100644
--- a/scripts/gdb/linux/genpd.py
+++ b/scripts/gdb/linux/genpd.py
@@ -5,7 +5,7 @@
 import gdb
 import sys
 
-from linux.utils import CachedType
+from linux.utils import CachedType, gdb_eval_or_none
 from linux.lists import list_for_each_entry
 
 generic_pm_domain_type = CachedType('struct generic_pm_domain')
@@ -70,6 +70,8 @@ Output is similar to /sys/kernel/debug/pm_genpd/pm_genpd_summary'''
             gdb.write('    %-50s  %s\n' % (kobj_path, rtpm_status_str(dev)))
 
     def invoke(self, arg, from_tty):
+        if linux.utils.gdb_eval_or_none("&gpd_list") is None:
+            raise gdb.GdbError("No power domain(s) registered")
         gdb.write('domain                          status          children\n');
         gdb.write('    /device                                             runtime status\n');
         gdb.write('----------------------------------------------------------------------\n');
-- 
2.34.1

