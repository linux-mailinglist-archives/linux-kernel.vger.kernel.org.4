Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86E4965D602
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 15:39:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239378AbjADOjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 09:39:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234523AbjADOjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 09:39:10 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 115FADA9
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 06:39:09 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id jo4so83099972ejb.7
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 06:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=r18xklAWjx+TF7cp4UJMeABFqPp5Oxq9PAiHHqbB0/I=;
        b=PtY+76iieGZzTCVc1gjR6aZ+8MvRz9PqsQ0ayTQxgKbt8QP7cSj/FZbnfstwRXPrMI
         73s3I45OrA0oT2wKijU9NsqK7vtDWmHe3gBEfBLL23YK4TapuYRy+z8JV7JBDFlIfxk1
         LbwDPzTXFQQv21t1CW87DQCQA/KsosQnCRulQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r18xklAWjx+TF7cp4UJMeABFqPp5Oxq9PAiHHqbB0/I=;
        b=TB3m0jR3OotxovnhJ8waA29KOJNl/wyPFq7jGSmlPGzCh8WmCXrW8DX8LqEgErfi0b
         XphNEzFkqNALEE4tocN+jf4DEk11glgKq8ejUlOrxsR4ZNM0kvpMpZKdDBcLBUZ30pSc
         qFaJY86V65Yogj5J8VpNIoc7QfkOFXMU45GSYGBdT6IJsCJccRODCOLcMmjW6vghNA/k
         q3s4ceyS8nnswJWPlkHRHaoF3fQ0WkZKxiIjeZvyV+HNsoIHMZzm9z0q/F9ednE66zZM
         nzjt7gRLilMVf+SJoCWvutALvteDYREwsRl4sq7wnVLX091DSbd5CBycgMZQixcVGVBh
         Tbpg==
X-Gm-Message-State: AFqh2kq5pYLI+WU9hezk6jCThHgs/0/Fx7Kclwm1UDNd7K3JzJqfUZwV
        j+zJCQ2tgQYFviT5K2L98U4kSw==
X-Google-Smtp-Source: AMrXdXtRrxJEj9EhqTE6p1tDDzc93nU9PeSS+3TXfb8wSuNaG9ZU0KGU7Y84GuMj88gdoR3bMuV19Q==
X-Received: by 2002:a17:907:7d8f:b0:7b5:911c:9b12 with SMTP id oz15-20020a1709077d8f00b007b5911c9b12mr51581842ejc.1.1672843147655;
        Wed, 04 Jan 2023 06:39:07 -0800 (PST)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:a438:c7da:62e0:36f4])
        by smtp.gmail.com with ESMTPSA id c8-20020a170906924800b0078de26f66b9sm15386659ejx.114.2023.01.04.06.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 06:39:07 -0800 (PST)
Subject: [PATCH v6 0/3] kexec: Add new parameter to limit the access to kexec
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHWPtWMC/43PwWrDMAwG4FcpPs8lsp3a7mnvMXawZbkxSxOw27
 BR8u4TPZZQchK/4P+EHqJRLdTE+fAQlZbSyjxxOH0cBA5hupAsibNQnVIAYGQqLcSR5A/9EspKjW
 4SfLQEYLV2WXAzhkYy1jDhwN3pPo68HEq7zfXveWkBHl/v0QVkJ3PsIakOs7PwiUOdr+V+Pc71Ir
 6ZXNQORjGDxjsNGiHGfoPROxjNjKFsyCsfUj5tMGYHY5gJ0XUeXfLO4QbT72B6ZiAmbTFkjfb1qX
 Vd/wFLtDDu2gEAAA==
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Wed, 04 Jan 2023 15:38:45 +0100
Message-Id: <20221114-disable-kexec-reset-v6-0-6a8531a09b9a@chromium.org>
To:     Philipp Rudo <prudo@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Ricardo Ribalda <ribalda@chromium.org>, linux-doc@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Baoquan He <bhe@redhat.com>, Petr Tesarik <petr@tesarici.cz>,
        kexec@lists.infradead.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Ross Zwisler <zwisler@kernel.org>
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=2772; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=OajjYlRvNHsgrXyvUbmCD5R6Ksvr+o7Qr/VxU7sn1d0=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjtY970v3EmwV32lI5jOI4b9gfVlAvFBW6wkzR0+PI
 jpl8aYOJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY7WPewAKCRDRN9E+zzrEiHrJD/
 9fEKDNuonXKXxBHNhx0IxcHbN/OOBcBuWjqTI4prRhjr/F/h2r6uFgSrokHEbNdjPBJhCLSFw5qmqP
 5duMbJPDtzDnLBpZz7oWggPB0qGuGbdE0dJK+/6CeXDIWQaeLztkqPrP47gPG6o4XRia7wChR91J6V
 Of7wnXxZsxpfaKxNQOsLrCXPvIaplJZgH43vq6g9Got8Di372Ks2FcenODuE71OrmXf0N230vXajSC
 SHBKQalEt+J+c/bp+UFr3jAmessUxYoWC39B/F+apr/zq3YuebgeEbrmVV7XuHAuHozA5zsarWHfw8
 meopL40YT/+AtimjB0bSIAd+Pd6pLDL4QY8NASwiYpAzX4X+8YV4qsKadvC1LUcQegcvUcwr2+g1c0
 J1RpnKvE1t/ow4X1K+adRNCuaW2J0M06e2vNQnw+UhAVP+FsSoT+4TN8lgQt+A0JqqDBxAmwZA2VCN
 wLVNLFaRGPmK8aOx/5T3IdHg+HmcoMINhKOVNTh2Ruz9V0+jS69vJkOSocMZh61ljBJ2i82LcGIy4w
 48f4f4p18CEzOjcdT6VPgOiSea4fRLfFcT5UOznlJtl9lk/W3AHPJe3PdVloA0hT57DPAJardujq4D
 xSpdxH9QMBvGdsR0eeh3eLVxiVXnXFufRy3WjyvpHLyzeVbC7H2Ao3dGDMPA==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add two parameter to specify how many times a kexec kernel can be loaded.

These parameter allow hardening the system.

While we are at it, fix a documentation issue and refactor some code.

To: Jonathan Corbet <corbet@lwn.net>
To: Eric Biederman <ebiederm@xmission.com>
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: kexec@lists.infradead.org
Cc: Joel Fernandes (Google) <joel@joelfernandes.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ross Zwisler <zwisler@kernel.org>
To: Philipp Rudo <prudo@redhat.com>
To: Guilherme G. Piccoli <gpiccoli@igalia.com>
Cc: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Petr Tesarik <petr@tesarici.cz>
Cc: Baoquan He <bhe@redhat.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

---
Changes in v6:
- Fix kexec type on kexec_file
- Match the length of the table borders to the sections underline (Thanks Bagas!)
- Fix typo on kexec_load_limit_reboot (Thanks Petr!)
- Improve commit message (Thanks Baoquan!)
- Link to v5: https://lore.kernel.org/r/20221114-disable-kexec-reset-v5-0-1bd37caf3c75@chromium.org

Changes in v5:
- Remove maxlen from ctl_table. Thanks Steven!
- Link to v4: https://lore.kernel.org/r/20221114-disable-kexec-reset-v4-0-ab809c8d988c@chromium.org

Changes in v4 (Thanks Steven!):
- Uses sysctl instead or module_parameters
- Pass image type instead of boolean to permitted
- Fix typo on flag handling
- Return -EINVAL for values that does not change the current value.
- Link to v3: https://lore.kernel.org/r/20221114-disable-kexec-reset-v3-0-4ef4e929adf6@chromium.org

Changes in v3:
- s/paramter/parameter/ Thanks Ghilherme!
- s/permited/permitted/ Thanks Joel!
- Link to v2: https://lore.kernel.org/r/20221114-disable-kexec-reset-v2-0-c498313c1bb5@chromium.org

Changes in v2:
- Instead of kexec_reboot_disabled, add two new counters (Thanks Philipp!)
- Link to v1: https://lore.kernel.org/r/20221114-disable-kexec-reset-v1-0-fb51d20cf871@chromium.org

---
Ricardo Ribalda (3):
      Documentation: sysctl: Correct kexec_load_disabled
      kexec: Factor out kexec_load_permitted
      kexec: Introduce sysctl parameters kexec_load_limit_*

 Documentation/admin-guide/sysctl/kernel.rst | 25 +++++++-
 include/linux/kexec.h                       |  3 +-
 kernel/kexec.c                              |  4 +-
 kernel/kexec_core.c                         | 94 ++++++++++++++++++++++++++++-
 kernel/kexec_file.c                         | 11 ++--
 5 files changed, 127 insertions(+), 10 deletions(-)
---
base-commit: 479174d402bcf60789106eedc4def3957c060bad
change-id: 20221114-disable-kexec-reset-19b7e117338f

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>
