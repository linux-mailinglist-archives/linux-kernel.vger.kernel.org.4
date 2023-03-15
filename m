Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2CA56BB293
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 13:37:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232887AbjCOMhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 08:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232629AbjCOMhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 08:37:06 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40EA99F231
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 05:36:08 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id x3so74817690edb.10
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 05:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678883757;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=v3AbtWw6suiC6wsgkPulkRPqSqhEWumoaEULtcVx4II=;
        b=UUyc3nCKEXxYIAvfUnExp+QTdSkTFIu9t8ydCSrqZDptzGCSFLH8ee3fZ9DwxttBZn
         bWXD/dayTOnYjs4EMW7CgU5izRz8/FjzsEKnd5nVanmuhtpk5QjsJ4Qg/YHK0js3wbre
         j4vSjHMgi5UQaNYRCbb+rlaf9Sl3rIJSr6uyc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678883757;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v3AbtWw6suiC6wsgkPulkRPqSqhEWumoaEULtcVx4II=;
        b=mPRPMUM/8/yVPLC1Rb0vYXv2RZNfxGe27IqgN1Np7gP6drcZBYUZi0kKBdAwBtNq4y
         bWboaXwFG+JmEaCDnDMub4yeNRrQiM1eQXMcjmnhiZ61k+/j7X4MAZvxkaOnMR5rOUEH
         zpMO7yvN8twNUNdoYXaR4O1QqS9S+g/8vV/zrwdKHL5TZa8yikZ/2dB3XVweTWMVi8nO
         fC18jFS3LqIjt6JAaPJjo4qiVS5YXaMeyXmtEiZNJjtbsrf8lnmG8erF9FXrHCcgVjE4
         KEOn21gJwkdw7Grb1xywB94QHlSZ1n2E6pkvRMYl9REbvX5+PWLQuus1SU49gN/RSfwq
         13vA==
X-Gm-Message-State: AO0yUKWwLLFrKykxVcIo3hBz+wmVxd1hhxfoVDkMA1l+PjGc2Lt3M0h7
        ikrVMkla+C/uXsxttIl6lRqSBg==
X-Google-Smtp-Source: AK7set9OR5b/Qm3j/4JMoT/s9ZRNL3k3QK14I2UhgzOn/yKKc97QcljFnXnzUCfMz6JPJ7yNT5dGAA==
X-Received: by 2002:a50:fa83:0:b0:4fc:65c7:a991 with SMTP id w3-20020a50fa83000000b004fc65c7a991mr3049243edr.35.1678883756985;
        Wed, 15 Mar 2023 05:35:56 -0700 (PDT)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:491c:f627:27f0:1c4])
        by smtp.gmail.com with ESMTPSA id w3-20020a50c443000000b004c30e2fc6e5sm2363256edf.65.2023.03.15.05.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 05:35:56 -0700 (PDT)
Subject: [PATCH v8 0/6] uvcvideo: Fixes for hw timestamping
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJi7EWQC/4XNy2rDMBAF0F8JWldFGst6dNX/KFnoMY4FsR0kxy
 UE/3snXRZTrYZ74Z55soolY2UfpycruOWal5mCfTuxOPr5gjwnygwEgHAgeMGKc+Lj95onrKufbj
 x0CGDAgVWJ0TD4ijwUP8eRpvP9eqVyzHVdyuP30SbpfP1rbpILji5KFaC3SqjPOJZlyvfpfSkXdi
 Zxg7YCpCSbhJY6BC3hQOnaSvdSghs8ohmUSQeKaiuKFG9TirLrrQd3oPRtpSdFa6GNixqlsgeKbi
 ualGi8c+Acxq4/UExbMS9lkMnYEKwF+UfZ9/0HrO2TqGACAAA=
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Wed, 15 Mar 2023 13:35:36 +0100
Message-Id: <20220920-resend-hwtimestamp-v8-0-0edaca2e2ab3@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     "hn.chen" <hn.chen@sunplusit.com>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=3581; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=J5KYLbnu+2Bz9Xzx2a4HAWzDhT4jcTRsFJte5ILahg0=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBkEbucb6IgefhHxZXW8DpQ2rbDqY7lWltU6gZaUUYY
 S8MmRY+JAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCZBG7nAAKCRDRN9E+zzrEiMuSD/
 9AP9R+CG3jO7evqVhx/hUHFgrE4t+l/yfUiE5+C3v8ZEdedPiZqA1tSOb8ncCyyf7hBICA3ofB+ELj
 ly/2brI3bLYzbJl0GrYQlxDt/ML+aI9W9IuFwIStQnE1G+uT2jkwBIvmueTi1s+3PYEXAA5VEj/t4N
 WJfktaHWeMNO3t/1XNRjaPOflZHnwtog+vw/l7uGlQ3/yGWBgwgFs5Blo/cNttgfjbZsj8II5K3TfF
 bJvZmcvikh88ddvNaSe1qvOfQZ/yYohCqallMUsu3ZCfMHSLpApzOycujESNiX27NFIPdaZzgwYBO7
 MwC8npvijm+DdB9IKVjSkcOu10PWj1g5HPxMhmOYL4XKVew8DSQVf7qRQgZWbD9ABaVJoZ2BaDuhOL
 7LyQA1EkeXbvXClYNF7caq/3PDEuqkUmIXKjggm2qiwcn2jLx9VLhBto331mB6VzFyjyxGavS0n6PF
 WR9GlcSidWa7sjEW6peP/kMAPuwHyIjZZC7EeKWEMPaV5TcuCPifBl7KmFgTGtg5iyEXEz4U4BLBIi
 KnPQGCDuSLHuqQvHks7TimE8zv1UgF3PBHqAeDR10vlAjU2/RN3z3kLl7qD/t0qIe+QaxfQ96BCl8f
 D30ug5j/IrW65MI4IiIUweDCA34KNqd763nQRLY+85QW/SK8OaArxLI7tn7w==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add some fixes for fixing hw timestamp on some Logitech and SunplusIT
cameras. The issues have been previously reported to the manufacturers.

Also include a patch to fix the current hw timestamping logic for ANY
uvc 1.5 model running at under 16 fps.

@HungNien, the logic for empty_ts has slightly changed since v4, would
be great if you could test it on your end.

To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: hn.chen <hn.chen@sunplusit.com>
Tested-by: HungNien Chen <hn.chen@sunplusit.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

---
Changes in v8: Thanks Sergey!
- Move last_sof save into uvc_video_clock_add_sample().
- Improve comments on add_sample().
- Link to v7: https://lore.kernel.org/r/20220920-resend-hwtimestamp-v7-0-cf1d78bb8821@chromium.org

Changes in v7: Thanks Sergey!
- Fix all negative modulus, including old bug
- Improve doc for 1/4 second accuracy.
- Link to v6: https://lore.kernel.org/r/20220920-resend-hwtimestamp-v6-0-c7a99299ec35@chromium.org

Changes in v6 (Thanks Sergey!):
- Rebase on top of linus/master
- Add missing host_sof assignment, ups :(. Sorry about that!
- Improve comments for empty TS quirk
- Link to v5: https://lore.kernel.org/r/20220920-resend-hwtimestamp-v5-0-660679c6e148@chromium.org

Changes in v5: Thanks Dan
- Check for !buf on empty TS packets.
- Link to v4: https://lore.kernel.org/r/20220920-resend-hwtimestamp-v4-0-a8ddc1358a29@chromium.org

Changes in v4 (Thanks Laurent!):
- Rebase on top of pinchart/next/uvc
- Use heuristic for UVC_QUIRK_IGNORE_EMPTY_TS
- Link to v3: https://lore.kernel.org/r/20220920-resend-hwtimestamp-v3-0-db9faee7f47d@chromium.org

Changes in v3 (Thanks Laurent!):
- Rebase on top of pinchart/uvc/next
- Fix hw timestampt handling for slow FPS
  - Improve commit message
- Quirk for invalid dev_sof in Logi C922
  - Improve commit message
- Allow hw clock updates with buffers not full
  - Fix typo and improve messages
- Refactor clock circular buffer
  - Improve commit message
- Quirk for autosuspend in Logi C910
  - Improve commit message
  - Add comments around the quirk
- Create UVC_QUIRK_IGNORE_EMPTY_TS quirk
  - Improve comments
- Allow quirking by entity guid
   - unsinged int
- Extend documentation of uvc_video_clock_decode()
   - uvcvideo on commit message
   - Improve comment
- Link to v2: https://lore.kernel.org/r/20220920-resend-hwtimestamp-v2-0-d8d0616bb612@chromium.org

Changes in v2:
- Require 1/4 sec of data before using the hw timestamps
- Add Tested-by SunplusIT
- Link to v1: https://lore.kernel.org/r/20220920-resend-hwtimestamp-v1-0-e9c14b258404@chromium.org

---
Ricardo Ribalda (6):
      media: uvcvideo: Fix negative modulus calculation
      media: uvcvideo: Ignore empty TS packets
      media: uvcvideo: Quirk for invalid dev_sof in Logitech C922
      media: uvcvideo: Allow hw clock updates with buffers not full
      media: uvcvideo: Refactor clock circular buffer
      media: uvcvideo: Fix hw timestamp handling for slow FPS

 drivers/media/usb/uvc/uvc_driver.c |   9 +++
 drivers/media/usb/uvc/uvc_video.c  | 141 +++++++++++++++++++++++++------------
 drivers/media/usb/uvc/uvcvideo.h   |   2 +
 3 files changed, 108 insertions(+), 44 deletions(-)
---
base-commit: 63355b9884b3d1677de6bd1517cd2b8a9bf53978
change-id: 20220920-resend-hwtimestamp-b3e22729284d

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>
