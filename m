Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E13EC628129
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 14:19:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236037AbiKNNTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 08:19:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236779AbiKNNTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 08:19:34 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9F222AE2F
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 05:19:06 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id y14so28228760ejd.9
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 05:19:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=wptfyIK6cGXWafJRIE0+wKYEiUfT/C8Cp/88f6SDnJI=;
        b=KN2CymL7WFkKiYXpoBmRpQWQXiDY44c7m6Y6yAFKT1NlHPmEkO6jZ5Yupm7GugU/Wo
         ThOL9DjjqdaifsHu4IQ8e+xX70/vP0uafrmaoWSB2xHm25+2eT0nAg+QDEDjmqkf3sJe
         JkJuIjrYCBcLhpIvAHy+6j27qnBKw3LG+ys7M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wptfyIK6cGXWafJRIE0+wKYEiUfT/C8Cp/88f6SDnJI=;
        b=A8bxKEip5JwpQ3ptRJzy3AKw3tEVKQmtbtIhUlkrE4bS8jhwZKr5YDLdVteqvgCze2
         cPFgfTQGk9esPnXJVeAPPfnVz+Z3mTEW8hjxXCOyJHgt297cKuBmB8VVl4JHnu85pBcD
         QjN1cyeXUvKQnKfrGOeMMyXGMbUAHPZFrXVCLYf9N9ZJxrUZKX8+z1SI18sUlOXAGFt/
         DlMjAFtJ2tJsICu/Hi0YPMTID3bDS0kgnBr6C+GlR729erL7Ri0zHr9hD/0YzGyapEsn
         ZOfN9oejoPtplkAXi2gsbkJ/v0B4bYPAsjg5m6wOj0csa7e7GpmwTKDClIA6Dp8KWH1L
         NBWw==
X-Gm-Message-State: ANoB5pkmPUcEVcgxZh0hETyZAFfkiN48xjmNwrqAtyw1FvJCtrJgRfSy
        IF2QqfyqHQPJIEv42n/UAFRdCw==
X-Google-Smtp-Source: AA0mqf5XAHfO6upM08Nlwr28NvlYYCOvH4cs7UB4GYrPptHd4Wu7+zqYlEwJB7EXRhdzfIqrEule5A==
X-Received: by 2002:a17:906:edb7:b0:78d:b712:fe99 with SMTP id sa23-20020a170906edb700b0078db712fe99mr10318362ejb.462.1668431945090;
        Mon, 14 Nov 2022 05:19:05 -0800 (PST)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:c205:5c4e:7456:c8cc])
        by smtp.gmail.com with ESMTPSA id g13-20020a50ec0d000000b0045b3853c4b7sm4802061edr.51.2022.11.14.05.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 05:19:04 -0800 (PST)
Subject: [PATCH v1 0/2] kexec: Add new toogle to disable kexec_reboot
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-b4-tracking: H4sIAC1AcmMC/w3LQQqEMAwF0KtI1hMwVVDnNm39arB0oNFBEO9ul2/xbjIUhdG3uangr6a/XCGfhu
 Lm8wrWuZpc65yI9Dyr+ZDAOy5ELjAcLFMYIDJ03bhQncEbOBSf41ZvPlN6nhcDB99zagAAAA==
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Mon, 14 Nov 2022 14:18:37 +0100
Message-Id: <20221114-disable-kexec-reset-v1-0-fb51d20cf871@chromium.org>
To:     Eric Biederman <ebiederm@xmission.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        Ross Zwisler <zwisler@kernel.org>, linux-doc@vger.kernel.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.11.0-dev-d93f8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1244; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=JfIkpVZ3TPV8FpLGteqEp65kTEUP1lPgQkWDBE88DK8=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjckA4FzdwiaV6YR2rAuNRu5qRVsvHdkr8TBqmbGPm
 CtXfY96JAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY3JAOAAKCRDRN9E+zzrEiG2XD/
 9E6yRRi3EQWhNK8uXRmHb1MCO0lvuapyhVEgfn84IwmzoXZD0pthUawboSbdfqV2aCv95D7xDPGaom
 Tkf8PBHwsFpeOBEWQ/jYmYr4+LqnKjvY3DJsWQPJTXM7VQ9EdTGBL5ZBfqHMmeGVvrUQB2dSWgqYcF
 T3kFrEMBraghVcFnOA3223Ba2sSuonthRcaotPb+xSYYUMn/rkJXpdplql6892hC+w9L1sFDARUx7C
 tvhRMa/vmLgAgd1tGn2TU7gPPutTUG7Jx0TAN04IZ97QZdyE7h7vKyskbiu0cmnhILdGFpomAVfnpW
 xGV4XIGWqmIwc8x3v9jMckXWb23Av3Wfu3CWoPPXPKpajj9Vdz1C4kCQb7gTq2RQK0iRgIv1F1jUZ4
 5M8T38wr+Wv5+YbShJzRhR53LUtmNRBLjDlZ6x7FpUpTth5w3vyn4s/kzukKpAepAWp96lfjhoZ/hV
 8By8SfhB73wVspAP3X4fKz7Dn5Ghpgo6V0ww1ERk4z4Wp4Xzh1W0q3FF1jfIEIyMokns/CxFNKSD+b
 Fuz/sLCrcNriPFsUkaXZX5n2KLveB+bOEoO0sBHzL+UhDyPkVYF3kKKZQw/O/TjeF6ybBcFuq1jiuI
 ovH518DkpySdiiVfyHPxGcCI72WSIEGqwvrjoE0cFpEAPFpQtq3RQTTNU+DA==
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

Kexec lets the system administratior replace the current kernel with a
different one. 

Add a new toggle to limit that replacement to system crashes only.

To: Jonathan Corbet <corbet@lwn.net>
To: Eric Biederman <ebiederm@xmission.com>
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: kexec@lists.infradead.org
Cc: Joel Fernandes (Google) <joel@joelfernandes.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ross Zwisler <zwisler@kernel.org>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

---
Ricardo Ribalda (2):
      Documentation: sysctl: Correct kexec_load_disabled
      kexec: Introduce kexec_reboot_disabled

 Documentation/admin-guide/sysctl/kernel.rst | 18 +++++++++++++++---
 include/linux/kexec.h                       |  1 +
 kernel/kexec.c                              |  4 ++++
 kernel/kexec_core.c                         | 13 ++++++++++++-
 kernel/kexec_file.c                         |  5 +++++
 5 files changed, 37 insertions(+), 4 deletions(-)
---
base-commit: 094226ad94f471a9f19e8f8e7140a09c2625abaa
change-id: 20221114-disable-kexec-reset-19b7e117338f

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>
