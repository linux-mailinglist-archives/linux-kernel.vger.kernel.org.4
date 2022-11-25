Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CAC96382CF
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 04:43:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbiKYDnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 22:43:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiKYDnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 22:43:19 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19C341EEC2;
        Thu, 24 Nov 2022 19:43:17 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id w4so2921404plp.1;
        Thu, 24 Nov 2022 19:43:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WHe1NBZkg23Y1ePxgOuhPSLDMktv7jzFjfTel+sqKQw=;
        b=VJQuZWb1DX0aab1jd+x+eX6c018kSvd7JTm/8zk3l+l1RIsueZHnh6QYJtS34pYLP0
         yZml3Wf/MwqJnwlaGEvNdg7+s4G7nYrfLrQn8SrjzlIkEikXWljeRMYo22OYVZF+VJPG
         vqrREwPU3yj7Va1CVNsScH2xDkqAHskPyLbcOhra2SxV6+uNlPW6C0wD4vJIHUN1quEH
         5Hi4f6XZnQL0aWoL38JEkr40trFJOonvcPGsuelveoKhTUu3UzL8ejCO+qIFSnxsIeSB
         Gu6OjlWaEfj9JsWYRcaIPqBJlWxm+D+hEFJ84XbHWYBfNawotvm6MOlicxCZQO+tc+2x
         rw3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WHe1NBZkg23Y1ePxgOuhPSLDMktv7jzFjfTel+sqKQw=;
        b=IIIigqpFVrh4Wz0aGmuWXyUNofvyzxtoM22/aX4sbuNVf/CK0EtXAYT54r804dx8dY
         CVxHQMo2l4DEjItzTWVUSjTxvQVcNerRpoEdEg+0+ViRK8bxbcSPF8HXwdcTRWt9/6P/
         eh5ZUjKStsT/LR22C5rSMzQcXXeNpsnpxtD1JltueuzQtAGnaL5NTHbmFqBh0h/luhVC
         uca/flOK37hEXo08XyUB2Ix/WaEsDDWaxsibryTIbIil2R5w9M6BsDUjrRWDNcjpNZ8+
         xII4uPHkk+fyE6arA2J4sRip+3HeFqrjHw7vZ7jKUFQJMojvWt4oN+OmHgB8i86hEK20
         JCMw==
X-Gm-Message-State: ANoB5plkwTMW1MXNr9qSqAsHjWeM319jS8m0vR1j0BHwTLTIVjuTI01J
        HF77vyRCBADfPf5vX+jMw6k=
X-Google-Smtp-Source: AA0mqf458Hi/OjHfUCkwvdmG9OHaDRIkvfLH2+zyFVuDUkm4vcYv8qymGfYiyXBPoUx7BwpnDSwaPA==
X-Received: by 2002:a17:90a:d681:b0:213:d08f:a455 with SMTP id x1-20020a17090ad68100b00213d08fa455mr45074809pju.130.1669347796539;
        Thu, 24 Nov 2022 19:43:16 -0800 (PST)
Received: from debian.me (subs02-180-214-232-73.three.co.id. [180.214.232.73])
        by smtp.gmail.com with ESMTPSA id u15-20020a17090abb0f00b0021885b05660sm1892378pjr.24.2022.11.24.19.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 19:43:16 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 564F6104368; Fri, 25 Nov 2022 10:43:12 +0700 (WIB)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        oe-kbuild-all@lists.linux.dev,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] Documentation/osnoise: escape underscore of NO_ prefix
Date:   Fri, 25 Nov 2022 10:43:00 +0700
Message-Id: <20221125034300.24168-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <202211240447.HxRNftE5-lkp@intel.com>
References: <202211240447.HxRNftE5-lkp@intel.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1565; i=bagasdotme@gmail.com; h=from:subject; bh=8q+Zei6xodqHKZunw7osmhH6R06srFtMBHc9ewN+LBA=; b=owGbwMvMwCH2bWenZ2ig32LG02pJDMkNlke4li5d7DRhol3Sgs5pigv/9Z/2dv105oiCVWTzba/H vAybO0pZGMQ4GGTFFFkmJfI1nd5lJHKhfa0jzBxWJpAhDFycAjCRKCmGf5rvgnS1Gf4Fn896MU3kyU Ov8ANbrcqn+qxq+eZu8Y5njxPDP7tzn+7EqahFT5gYGeHLIDX7fqn1xe6Euhmqz5hXZy/K5wQA
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

kernel test robot reported unknown target name warning:

Documentation/trace/osnoise-tracer.rst:112: WARNING: Unknown target name: "no".

The warning causes NO_ prefix to be rendered as link text instead, which
points to non-existent link target.

Escape the prefix underscore to fix the warning.

Link: https://lore.kernel.org/linux-doc/202211240447.HxRNftE5-lkp@intel.com/
Fixes: 67543cd6b8eee5 ("Documentation/osnoise: Add osnoise/options documentation")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/trace/osnoise-tracer.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/trace/osnoise-tracer.rst b/Documentation/trace/osnoise-tracer.rst
index 3c675ed82b27ae..fdd562d7c22d18 100644
--- a/Documentation/trace/osnoise-tracer.rst
+++ b/Documentation/trace/osnoise-tracer.rst
@@ -111,7 +111,7 @@ The tracer has a set of options inside the osnoise directory, they are:
    be used, which is currently 5 us.
  - osnoise/options: a set of on/off options that can be enabled by
    writing the option name to the file or disabled by writing the option
-   name preceded with the 'NO_' prefix. For example, writing
+   name preceded with the 'NO\_' prefix. For example, writing
    NO_OSNOISE_WORKLOAD disables the OSNOISE_WORKLOAD option. The
    special DEAFAULTS option resets all options to the default value.
 

base-commit: bd604f3db49c5b21171abea0414a2020dcbf2646
-- 
An old man doll... just what I always wanted! - Clara

