Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78AD7653731
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 20:46:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233757AbiLUTqR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 14:46:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbiLUTqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 14:46:14 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1690920BEC
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 11:46:12 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id qk9so39249ejc.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 11:46:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=h5QqjbWC4xPqNCugqJ9inOxUkbx/4jCQyhj7e6d+JX0=;
        b=gy8HEbmVaGXlWVpYtQSfYtXKoJlAwrX2PiZnxXo9HoTMGvawfZ+wlH6pOBMI2rJ95R
         /oMpWzeHuxdhZYx7w9UuejGKiMy7C9Y7/uVbbkZWbiC5EySjHA14dJohFrdn7hjbfX9W
         worysGPSqMzZPNCuYeUhwE2dBuffLaUUIFjxY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h5QqjbWC4xPqNCugqJ9inOxUkbx/4jCQyhj7e6d+JX0=;
        b=KtpV37NaBMdGA3xKjvtgh+o0HXO8TnTyJOHQt1HIb3PN7X1lmFTw46oZH/Pq7+hVgH
         QLYNxjzoKV3S8QWJO2O2b+A5YTJZzBJBUzTP7Cw9Uxlrar8AO+wH5zPTkaSFGymKr1EI
         0XfhDokYEEAYZuBzjF4vpQ8KFlism7KqZX7K6AcIUPPyvYv6FAx/yXWXl2E8GvImpfHW
         0L1dtzeBm33BGbso2w7tGGPBGhfPh/VhDXLxOAkaStyqgRUVIggB2UBnRHrdsfXT7LT5
         yfaTtF0x5td9cuARMVD2lX+bka7IhcWmvvLZiJ9ybww7W4if4Io1DfIJFK8wWRxD1rtH
         8JJw==
X-Gm-Message-State: AFqh2kqPnE54012Cjflv+WakhxWwui8KUTX2iptOneEhVa775Utb3dGC
        1VptLLnnjYG/JiyMCRFuZvHFag==
X-Google-Smtp-Source: AMrXdXtRt6qphcfjVI4QjTn7e3c297nIpVXd5Stx/oZg+CVvsEnswh01KNoB+LTkOeEQPOYsYa3+Wg==
X-Received: by 2002:a17:907:d50e:b0:81f:fc05:2ba0 with SMTP id wb14-20020a170907d50e00b0081ffc052ba0mr2675538ejc.2.1671651970624;
        Wed, 21 Dec 2022 11:46:10 -0800 (PST)
Received: from alco.roam.corp.google.com (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id f24-20020a056402005800b0046cbcc86bdesm7382008edu.7.2022.12.21.11.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 11:46:10 -0800 (PST)
Subject: [PATCH v5 0/3] kexec: Add new parameter to limit the access to kexec
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHRio2MC/43NwarCMBAF0F+RrI10ktQmb/X+Q1wkk4kN1hYSLY
 r03x1cikhXw71wzzxFpZKpir/NUxSac83TyKHdbgT2fjyRzJGzUI1SAGBkzNWHgeSZ7oSyUKWrBB
 c6Aui0tknwMvhKMhQ/Ys/b8TYMXPa5XqfyeH+agc/hNzqDbGQKLUTVYLId/GNfpku+XXZTOYkjk7
 NawShm0DirQSOE0H5h9ApGM2MoGXLK+Zj2XxizgjHM+GAbhzY6a/GDWZblBd8zzw2TAQAA
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Wed, 21 Dec 2022 20:45:56 +0100
Message-Id: <20221114-disable-kexec-reset-v5-0-1bd37caf3c75@chromium.org>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Philipp Rudo <prudo@redhat.com>
Cc:     Ross Zwisler <zwisler@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        kexec@lists.infradead.org, Ricardo Ribalda <ribalda@chromium.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=2328; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=pHYAwK2HBx9n8zpILJY4+z4Vwehv4LFp5obwLjvJPUI=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjo2J2bQVimyy1/Vsjq4S0a4azyR8AdmG30PBxAZnh
 G4wJW8GJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY6NidgAKCRDRN9E+zzrEiI/FEA
 CG6+MF4+l8zL5dE4Gt3+i0jiytzzPAhfXFs4fHRSCsUD2O2MNBscf1A4mFZLPnTaW7vBMNVrfFEufO
 7gIESmiyNGt6ayHX1VooSQ1ShQsdAWtyVGe1W6o4w6yeO83drpRi+sU/5OpDYnpEASg0y+NSwRqzAZ
 Z+nysGMjXUNaB+2sTaWHHEFHRM7ALV7br6WhBL2WCHQTTSVE6XpRl7twTUn3Yhcef9ec0pX+jduF4g
 ScjmpYOqWv5hXqMymVLqbg/BjCGdVWVuWcfFdp7JIEmC73e15DUmlJRpZ9cyUk20l61NuMK2R4vRqx
 B6LzBRyuBMFF0SupmUNcjJRZsniObm/UscQJdm/zeX5TLZ9jo5iPjHGLwAsTEzb/hr8uaymqCyka2Z
 0MST/nj60mrMDj5cTcvVfdglJxBr/RgDggDuGPbLNYUMacpuQWqR/IarPTHekEP3MJRWLll+Gse4i5
 i0I0ECLpz6rDav25LJLgdE/4Nk+5fqUI5glc5OmDmkhlD95fzmg5DSpFUCf70EMQb0w57j9SFbWwcX
 tStaxYotNcUOSxPw+TUcc3RL504iw0GF8kKxKmBAiFHVEB/K1CHUXy4D8oo3q7GVk1IAnGAwDsMzWf
 bP2mw6WT2gEgAAPMNLnnG9094iJ41CQS6r/kA3eIYyo1cPjcJHKui7ZnTSQw==
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
