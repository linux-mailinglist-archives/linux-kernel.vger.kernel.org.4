Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 691A564746F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 17:38:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbiLHQiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 11:38:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbiLHQiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 11:38:19 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 510A913F1A
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 08:38:18 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id c17so2515253edj.13
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 08:38:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=dOtUGB6deKRvn6QoEmSpDe75lDhRqv61wD41Q8wWa80=;
        b=luem0n8WFWkWja2+Lv9JWQ+NtS8d+lsAB1pdwuXlv1mobiAy5zJwV/OlL3+I3f3okx
         mwUsp+3XwMnR9KcjNX5CdaIDgWQjlwa7WvLFcRcbUNLwdlM1rNeRmyLA/1mWO6Yx5yNb
         M1slKZeooAQ/yUAV9jsI6EUZVVK5GkIXh06Bs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dOtUGB6deKRvn6QoEmSpDe75lDhRqv61wD41Q8wWa80=;
        b=0FjW9Lh+z/+h24FKpGdDv/Q6k6tK1rRQYSQESdN32kIzvjkcCJCj/5uyPkvqKZ0Ww/
         eMkqVN4G9C1bzsRmyGDiVY0TTTRKHy+U2vNxZD5TubK70OKJGPq9nXrFt7LjxVX7laRa
         S1SzkGQipDZEqJd9rkthc8isBKhUJAUQtabcVg5R2FRofZ0z+qHMonVWiTsw97SH2GLs
         80llZX9jV/HfMgO5ljpGAKX6nfXtL1/O5arLD6LCF/kCMY+VlZMTqQtcRvzWNPz0LWda
         qp1bZYJnyMi/l8ZiF7dN66BR9yUHaZpq5U6YR4BNij9IPTCQ5EzmZgKMQpW0b+K/TakX
         S2MA==
X-Gm-Message-State: ANoB5pnvjqN5TfpPn0l0WfhZMeN9k25Rj9cDz1RWpuh4ac+cOmWmZVjh
        LyQhm8N4nyZkOQbUCgok64ru9g==
X-Google-Smtp-Source: AA0mqf6OBO9M0R4/tfeQ7wCA5W1m2OqhyRTihnaGWK/QGkoR17B6i0FAiHXfxux+B4+6fGussdqmUg==
X-Received: by 2002:a05:6402:550c:b0:462:6ba5:7215 with SMTP id fi12-20020a056402550c00b004626ba57215mr2498559edb.32.1670517496878;
        Thu, 08 Dec 2022 08:38:16 -0800 (PST)
Received: from alco.roam.corp.google.com ([2a00:79e1:abd:5c00:8aae:c483:8219:bdba])
        by smtp.gmail.com with ESMTPSA id ck3-20020a0564021c0300b0046778ce5fdfsm3569046edb.10.2022.12.08.08.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 08:38:16 -0800 (PST)
Subject: [PATCH v2 0/3] kexec: Add new parameter to limit the access to kexec
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOcSkmMC/32NQQrCMBBFr1Jm7UgnVVpdeQ9xkaTTJlgTmGmLUn
 p3gwdw9Xkf3v8bKEtkhWu1gfAaNeZUwBwq8MGmkTH2hcHUxhDRCfuo1k2MT36zR2HlGeniWiZqm6
 YboJjOKqMTm3woblqmqZQh6pzl83taqcT9/+hKWOPgztSb2g9dSzcfJL/i8jpmGeGx7/sXh46T4b
 4AAAA=
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Thu, 08 Dec 2022 17:37:59 +0100
Message-Id: <20221114-disable-kexec-reset-v2-0-c498313c1bb5@chromium.org>
To:     Philipp Rudo <prudo@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, Ricardo Ribalda <ribalda@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        kexec@lists.infradead.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Ross Zwisler <zwisler@kernel.org>, linux-kernel@vger.kernel.org
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=1662; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=CbpfLIuX926ztJbaYvtqTfAOAnBai/eNkyo5FXq7sBA=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjkhLppvk90Qatmkolw5wibtDPfBL94H1JvWQvB3WN
 cRKiW5CJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY5IS6QAKCRDRN9E+zzrEiE+MD/
 4jdZg1kfEyEVoTWZAnJ1gKb1scJhScOKm2An2e7s036FbeW+77cKX3+2hRGFOoSM9Q0WJiqkrps2hE
 ZuwISGYDHOVPv1cCAeIMKsaI1nzfqxS0lkdJfh/DVwdMhFCzMwUvzc/dI0cc0ul4qlDeJ1dWLIO2cV
 kxIMUfW5TTza7srzsy0xrrh8WYp+6flBKUCurqA31vYd+BjjzByskXJM7Eor0H5Or/nlTur+ARZrfC
 WeIw/AkROr3dp85JtTcE72FnTkvzMLuz4qesZQYZ4QtGbxRd8sGQLyqDpFAKAizhSoTb4FK0Ds5med
 c4mphKC89svw+/N5CCmsKkm3murdJCVOeMw4OmOsN4iElzjRG91EuBwfjZhLHalLBPT1F93fXRBSP0
 wXVb7HYBRA4Np9kTesGVp4D7QFZB1GQMx3zNfVQqkkAUbNl/VSqmRTJlOzHzUg2nXg964WGpAJ8esG
 DXVUAcdwgvwr7EjTKMcf/RkVMMbjR+wVX81hOQzYZC566o2Ai6l6tn+MdsAjE8lFxHGe4JIwhY4QNa
 ID8Oq2Uke1TrIsB61xgGjEuhLUUL+72eAO5vSkF/sWfCMGrc/9hZnWCaXlofTQYbhvxxt1GeoaZPWn
 h+x13mZFFA0wbhl57zPeqFvTIPojayferH1Lc8pZxfGwUlqCndwqqw9YdV8Q==
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
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

---
Changes in v2:
- Instead of kexec_reboot_disabled, add two new counters (Thanks Philipp!)
- Link to v1: https://lore.kernel.org/r/20221114-disable-kexec-reset-v1-0-fb51d20cf871@chromium.org

---
Ricardo Ribalda (3):
      Documentation: sysctl: Correct kexec_load_disabled
      kexec: Factor out kexec_load_permited
      kexec: Introduce paramters load_limit_reboot and load_limit_panic

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
