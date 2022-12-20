Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 814626528AD
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 23:06:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbiLTWGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 17:06:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233999AbiLTWGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 17:06:08 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40EEAB1E
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 14:06:07 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id bj12so32455458ejb.13
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 14:06:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=qguXqp2j+6VtyLB8eUBD1D9muuuDDTBR/GzC0b/pu1k=;
        b=O4vVH20xii9YmkpEcTbvxvo0Kpp7cn68jcaqvG8QZqgPD0IaQ5BbajyX4g/nZKmoIe
         5fStIY1Es5sM4ze2N4kebYQNPt8U637KvF8TtUBsrOyLwpr75715dRO36hOps80iQ2Jh
         gyYPxx3MSTSOns65tEwJapBJROPJI9XJFFT7U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qguXqp2j+6VtyLB8eUBD1D9muuuDDTBR/GzC0b/pu1k=;
        b=VC2mwRpSKngGocZ+v5+XnswqAFx847cjgGtB7R520Ik1lRg0zrzudkIucoNQRbIk2D
         wGjm6jlqEGaYB4sdZ4VD5P0uX7o/7bY3Szx1b1Tsn+qpx+7N5Kx7HREzpNRmRiG3GHH+
         jfHPUZCjuwuOLhLNxwWjlspiP+x6bert3g2re8HwsJQUalLOtajyrjMt0dpGgUKqnNTs
         Nrjb18+0KXsrEhY19e/ypQAegN5DWcVaNdWw4frfhtKcFxCmHAtOEjudpU+9JfPDfU9L
         HDDnZwbn5UWlZW+lzBciTmIc8g+QCzxztKE4TEg9JpCzOckLJZrF2kiXdx4NdkCJ3NOe
         M4tw==
X-Gm-Message-State: AFqh2kpU1fcgiskXR+pPRMABZbkk84oX8zpKNDiV626swGZrWQPT714E
        KLHj9HjXax7IyJsPOOsm+ua9Mg==
X-Google-Smtp-Source: AMrXdXu6YxWTPi3QdZRM5wHojbmkje75tyctzgPEzqVflCJ+t0XQiwVNcUG6Jy0bCImoz9tngbt5Sg==
X-Received: by 2002:a17:907:8b89:b0:7c9:6e0e:1428 with SMTP id tb9-20020a1709078b8900b007c96e0e1428mr20328765ejc.47.1671573965862;
        Tue, 20 Dec 2022 14:06:05 -0800 (PST)
Received: from alco.roam.corp.google.com (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id ku13-20020a170907788d00b00837ac146a53sm1175492ejc.23.2022.12.20.14.06.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 14:06:05 -0800 (PST)
Subject: [PATCH v3 0/3] kexec: Add new parameter to limit the access to kexec
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALYxomMC/43NQQqDMBAF0KtI1p3iJIraVe9RukjiaELVQKKhRb
 x7hy67KF0N/8N/s4tE0VMSl2IXkbJPPiwc1KkQ1ullJPA9ZyFLKRGxgt4nbSaCBz3JQqREK2BnGk
 JslGoHwUujE4GJerGOt8s2TVw6n9YQX59PGfncfqMZoYTB1NjL0g5tg1frYpj9Np9DHMWdySz/YC
 QztupahcqiMfUXcxzHGztA9xsFAQAA
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Tue, 20 Dec 2022 23:05:42 +0100
Message-Id: <20221114-disable-kexec-reset-v3-0-4ef4e929adf6@chromium.org>
To:     Philipp Rudo <prudo@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     linux-doc@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Ricardo Ribalda <ribalda@chromium.org>,
        Ross Zwisler <zwisler@kernel.org>, kexec@lists.infradead.org
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=1912; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=oqqxwk7ur+7vMvrJ1y110OEyC4kpNJWaizp+/KtIfaM=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjojG4Me5Y6xAi+85V5xL3fNRPfkdN7GpnFJ5jXJXt
 3b8EXpGJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY6IxuAAKCRDRN9E+zzrEiGx/EA
 CHRNxJxeuVSxaapNclsd0IR2v561HSo/3zhW/RH7NG2VBrxbPwzBolyjgfbRMakKqbztlmWf7etZ/S
 Ep8ev+3WFlQsbehkKTh6z8lDHwTvFKMv0rTH2vOngOJA6pmqJht/zB4OPbSPyvOOkZNQ29mIp/liFj
 EKBwrxpy5Y7uvfuZ7Q1DDtI5rMrKl4AxGI3wrv/FS46xCOpiRfoNcxuH2fUR+ZzHW5aFmq7qw1LfQJ
 ZiH9lBk8S1JbySrhQGdPQ1HCWi78T3R9NRtUvTnW9LeUrqBTiRZuoYHucvGQS/uAsB1BinY3LCbGhs
 diuRkD2qfJU++eGUxoJjo2ZVOGkGTKm3HURUutGJlo7Yq488PpyKU7gyZSvSdhapopQGyFiepkRJus
 WrXhAwVwoL+wCnSWYiJvZz8CNZRsCM+fofRYyUWiujR1sdFWx0okvhcCcWSloR5/VkO+98PYy5h1sP
 L2P/mWyVFAR6C9hXQCKkq1TRuZCglgRtM2Etmuwa4ZfvrdmKdUzvaetSwU7GrCy7PHpq4oFRpj/eL/
 kRe+5rIF5PpKoHnOuhkTiPsSQntBm+wep0iu3tiZ1Phzj3c2MFkZfdY7NpethPomAo8bq3ygEFlWp8
 80QP1c/4+/QjU2g780bLf1Ux8QBvaOA0TokD2Y9MPRfDXTbLA9nAh1WKUHOg==
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
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

---
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
      kexec: Introduce parameters load_limit_reboot and load_limit_panic

 Documentation/admin-guide/kernel-parameters.txt | 14 ++++
 Documentation/admin-guide/sysctl/kernel.rst     |  7 +-
 include/linux/kexec.h                           |  3 +-
 kernel/kexec.c                                  |  2 +-
 kernel/kexec_core.c                             | 98 ++++++++++++++++++++++++-
 kernel/kexec_file.c                             |  2 +-
 6 files changed, 119 insertions(+), 7 deletions(-)
---
base-commit: 479174d402bcf60789106eedc4def3957c060bad
change-id: 20221114-disable-kexec-reset-19b7e117338f

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>
