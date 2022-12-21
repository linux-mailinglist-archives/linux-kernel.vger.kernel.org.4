Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 659EE65310B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 13:50:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231986AbiLUMuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 07:50:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiLUMuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 07:50:17 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF2622BF6
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 04:50:16 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id fc4so36461258ejc.12
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 04:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=WMiE0vd/yYBaXGsz07hU3FBQiAft2wmjzq4IoD9fajA=;
        b=FsDwchrubRoccRz16UU3/VfvJCLPLXjk9mbF3gAuquaoYgXTYXOxrdFCpS6vCpy75E
         98jX7Jg91/wbuAw2LVOYnSMwt9XdTJpru7YFRAagTsctrMCnq4nkKHOoviboa8xmKyYy
         qXFv71vL8uYh9dE5jZxt6PCYEu4NaMd2SXkmQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WMiE0vd/yYBaXGsz07hU3FBQiAft2wmjzq4IoD9fajA=;
        b=LOF/FHl+HRNTMylN2it05xhfdsqUPL1TGVzLEiWvrCyPc37ETW0jJDgZ6iazrzLNuy
         sbiNBYSPJbNB1t1u3z2RBlXCX2da8Jhyb8OKJUXyGgNP0n3ZiGZXtRB3cNoBFi3uLZBF
         t5oyf1SiySy9xzsKhb65l9Qsd6WFSWog4gVrA5J7LLLLBLUYGz4m2XaZPZaL1OD0dumE
         9963jTNlt3Rlc9b675wzVC/wxxS120Qr98Xdpb5D1u53KuvRjN6hpG2OjieVnfUfRTpa
         AnKKBvw3ThC9oy4XlTuWljErYUsNtp98EfCauH+DAVQhBWSEmG22CFBeqG1WEotYwTKI
         mH/g==
X-Gm-Message-State: AFqh2komGZAIvegwUGXqQ9uF6GK4IXfiOuHS2MmmBZADL1WjK/Gkp++U
        y9v9SvYdqAz9pSTXmoD/rT4TDA==
X-Google-Smtp-Source: AMrXdXuil/5SfXayT9oVY55/8d68hsnH602ZQHAwgj636BYZ+mDSkdlwA3kBxhfcmcYQOjM14us5Lg==
X-Received: by 2002:a17:906:6543:b0:81a:bebd:d4b0 with SMTP id u3-20020a170906654300b0081abebdd4b0mr1316054ejn.44.1671627015175;
        Wed, 21 Dec 2022 04:50:15 -0800 (PST)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:4b82:b1f8:cb4f:fbbd])
        by smtp.gmail.com with ESMTPSA id w7-20020a170906b18700b007c0b28b85c5sm7039250ejy.138.2022.12.21.04.50.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 04:50:14 -0800 (PST)
Subject: [PATCH v4 0/3] kexec: Add new parameter to limit the access to kexec
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPgAo2MC/43NTQrCMBAF4KtI1kY6SWobV95DXCTppAn2B5K2KK
 V3d3ApIl0N78H7ZmUZU8TMLoeVJVxijuNAQR0PzAUztMhjQ5mJQggAULyJ2dgO+QOf6HjCjBMHbS
 sEqKSsPaOlNRm5TWZwgbbD3HVUhpinMb0+nxagc/uPLsAL7m0JjSicryu4upDGPs79aUwtuxO5iB
 2MIMYpXUuQDqwtfzByByOJUegVaqFN489fzLZtb9GhTkdMAQAA
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Wed, 21 Dec 2022 13:50:00 +0100
Message-Id: <20221114-disable-kexec-reset-v4-0-ab809c8d988c@chromium.org>
To:     Jonathan Corbet <corbet@lwn.net>, Philipp Rudo <prudo@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     kexec@lists.infradead.org, Ricardo Ribalda <ribalda@chromium.org>,
        Ross Zwisler <zwisler@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=2161; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=VBCVJ+aD/h3GyICYpp+9hUZz7wDvOWS2v3+hHEeVJG0=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjowD7/oKW4m0F/oh1hjb/+F27kY8sEEjovm4nldnc
 ++mdDAKJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY6MA+wAKCRDRN9E+zzrEiCRiD/
 4v6YHmqUA36mCtnhhZgNBiEwdUEvmgxZ0WLQ4heB78T72NPYXMF09anLaJ0p7l9FdGBGNT8FA6eQX6
 GQ15UnOLfNCaGiI/XMktb6T29UUA0gIGq7ohW6vzrUJnHk90jo8cCv5cQGQFZFyHPQGZWE9CYBzkgB
 WsJEXQnvLfqGLfXW8XiBP2eWlUINVEyMsD60u/ZejcyICdnllmnY3gjCCg5wIRQQXDh4H1dT6MSMev
 4XFxYK25FDX3N5xFTmdynwhI2rhSfxrZuzUjOQg9g4sL6Bhi4jsZOwOLJKADo/maI/Fk7cjfbyKCOu
 r7ZsRslYNoVOvTkdqlaXW+OPbGDHWwboSFtoY2B0yKURuz1q476QsDy+2oqi4dwhlJLkKjNpjCK9Ur
 oRmVio+DnU1g5F3x8dcOMO4ig6LNM+i39llbr82wzYrmpbyH/8o84fmXXWVdcxTGSI3g3muSijaL5X
 3I1Gr7LRTn8ed42PY5sJy3FQp5EO0BpB7+zB3trHkYwieE3tgLvXEWR1oSl6NDVycl9AabG3Hdm1+I
 cYBCqGkabyDdzpOMzrARBMdldMekG2cOzqeznE1ru8e+Rz4N6VADI1cVvzpZ5Ku490beZmS64FgK+g
 wrPGrb0s45Ggx/t6+rvZdjIBLsohAJeqd4XK4fJdOXy/EUvBtgRxRf1V12Gw==
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
 kernel/kexec_core.c                         | 96 ++++++++++++++++++++++++++++-
 kernel/kexec_file.c                         | 11 ++--
 5 files changed, 129 insertions(+), 10 deletions(-)
---
base-commit: 479174d402bcf60789106eedc4def3957c060bad
change-id: 20221114-disable-kexec-reset-19b7e117338f

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>
