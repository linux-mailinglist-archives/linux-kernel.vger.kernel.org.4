Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4837565D0EA
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 11:47:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234745AbjADKp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 05:45:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234789AbjADKpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 05:45:52 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9352BDF59
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 02:45:51 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id u28so43181756edd.10
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 02:45:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=IdKD4D0Kg9wx23NkX+Sft35QKMHqUVVXOU59oYRlAvs=;
        b=k6Oohnk9Zg5T8J3kto16VOrEKlyVe2SuXwZfzEwgoXLzcYXUzUJj1J47YNGthXEzxT
         ioK51OD7q8w+AZvx66fwxQDqOQxONgq3EqfjGbng4P9qYmtDVSudbrGpa92MU5X7vmqu
         wpeIJR+p7JshikCRzT4RjMBcd5exNQ1KkbpkU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IdKD4D0Kg9wx23NkX+Sft35QKMHqUVVXOU59oYRlAvs=;
        b=mNRnh75kmfwueG9+YSrGQzXh1rIQme+Gi/qoytPaYsXYbnxuGyscpBuWO0c6B1nJlo
         xhz9ris3qL1jQh/XP3UFGTqiQCWO6BuZcg7LPA/FS+tyvaPUgvAbPJtG+9Aop9xKMprP
         wO2Nq21Pok1QV8eQOKkTKBJVa5TjeU+yrZ7SMpxrgKc+3mkAiqFjf006IzSa3NAQDqxh
         e2dtIOiWW9aIZWvPOllcGLQCKJ85iZ02lkDBgivdwhacnz20z3L7otbqfjT/xip0nAWW
         +pEsI/cekzrVUg3QrFVWiAj+RRdrFvrMoE5jYe4gL1cZKL2wIkfoHfRPOX2HmTlYtGHH
         6aKw==
X-Gm-Message-State: AFqh2kp3eCVaiM9mpUxNlJMeEBiifQl1g8XTw3FAfPIfwjHBcfnl1hty
        nhtttg5RUCwTsGvXxX60Sjpzgg==
X-Google-Smtp-Source: AMrXdXvFf4atAYZDVydCxBdjlZNEnZcySjXzWhOd5N0HPQLRIaHpmK41cKTfO7Fzp1eCZaiYO1RwMw==
X-Received: by 2002:a05:6402:3784:b0:46d:cead:4eab with SMTP id et4-20020a056402378400b0046dcead4eabmr42712014edb.6.1672829150153;
        Wed, 04 Jan 2023 02:45:50 -0800 (PST)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:6531:9bb0:b3f7:86a8])
        by smtp.gmail.com with ESMTPSA id g32-20020a056402322000b0048c85c5ad30sm4754971eda.83.2023.01.04.02.45.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 02:45:49 -0800 (PST)
Subject: [PATCH v3 0/8] [PATCH 0/8] uvcvideo: Fixes for hw timestamping
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAL5YtWMC/4XNTQrCMBAF4KuUrI0k01hbV95DXORnaAJNKkkbkd
 K7O7h0oavhPXjfbKxgDljYpdlYxhpKmBOF9tAw63UakQdHmYEAEAMInrFgctw/lxCxLDo+uGkR4A
 wD9MoxGhpdkJusk/U0Tes0UelDWeb8+jyqks7tp1klFxwHK5WBU6+Eulqf5xjWeJzzyO4kVvivAC
 mud6KTnTGdhC9l3/c3hekWpgIBAAA=
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Wed, 04 Jan 2023 11:45:18 +0100
Message-Id: <20220920-resend-hwtimestamp-v3-0-db9faee7f47d@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-kernel@vger.kernel.org, "hn.chen" <hn.chen@sunplusit.com>,
        Ricardo Ribalda <ribalda@chromium.org>,
        linux-media@vger.kernel.org
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=2520; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=qG3sXZRqw9xlLyh3Znx7PGf7JYnlIdEA/ST1lXGv/Z4=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjtVjKYGRw/Cld6yBihPehpnkLu0yitoKuz8bujr4U
 nvyaigiJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY7VYygAKCRDRN9E+zzrEiBbJD/
 9p0NG0yz6UGFQbPm8qchwhVh9CRMhi7zCHnc8uE5Uu5/EaYItAUgq1mvQbtmIrabOKbBGIVlvbkxBR
 Jb3EEuobay9cQv4op2KULeHCL6Zs8P750aveKx3VY5PM5HB82dgsZEqXhDjwuqOCfX3xu8d4I3I38e
 VAs98hoNma3GCVnLb3PyqhLa9O8uB9bqsKy37NU/ukcbqqTnM1JX5bQPWK8MfhqcMGh2pPfihoPfg+
 /4M5p9Yz0y7hpSspX+AQFokuWY7UKMeqG+sDup539HxmlrsoIlRIp/TKSTyHGg8NAmHLHSldwdK+W8
 Ho6ispFt7hNlGp8fxJdzKq/NpU95pcoj2I0x2I81soNh8koSyYHz+SLwlsE4obK98RyCTpLZVQ9smp
 +1l5lVz655FEvgj6nNvnx3NrG75VXvSlWNzByIquvbhnQ8rKLnAni0at84ekqR3aHFhzrV44oe5EFQ
 Os6hnIzZOTf9i73fXbrdbH7r8QnyHL4Rp9HAhBSbyjOXb7UVjFSG2U2mTP41C9Vvo9NBRrUBKbgvs3
 aq0sUL9HquAv9+Q0gi1i3L9Pi1hRo2jf9LW23+FotzxjF80LmuKtICQiBNE/E6xdCPzmMeJojsZPRE
 AuEAuJijtFPfFWcsmkdNHJw75jFPOOn+M1ag5eWQa2EZb3KyzmfN6iOFX00g==
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

Add some fixes for fixing hw timestamp on some Logitech and SunplusIT
cameras. The issues have been previously reported to the manufacturers.

Also include a patch to fix the current hw timestamping logic for ANY
uvc 1.5 model running at under 16 fps.

To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: hn.chen <hn.chen@sunplusit.com>
Tested-by: HungNien Chen <hn.chen@sunplusit.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

---
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
Ricardo Ribalda (8):
      media: uvcvideo: Extend documentation of uvc_video_clock_decode()
      media: uvc: Allow quirking by entity guid
      media: uvc: Create UVC_QUIRK_IGNORE_EMPTY_TS quirk
      media: uvcvideo: Quirk for invalid dev_sof in Logitech C922
      media: uvcvideo: Quirk for autosuspend in Logitech B910 and C910
      media: uvcvideo: Allow hw clock updates with buffers not full
      media: uvcvideo: Refactor clock circular buffer
      media: uvcvideo: Fix hw timestamp handling for slow FPS

 drivers/media/usb/uvc/uvc_driver.c |  63 +++++++++++++++++
 drivers/media/usb/uvc/uvc_video.c  | 136 +++++++++++++++++++++++++------------
 drivers/media/usb/uvc/uvcvideo.h   |   4 ++
 3 files changed, 158 insertions(+), 45 deletions(-)
---
base-commit: 58540610e464d8b2ba46a11b81c3e6fcc4118fae
change-id: 20220920-resend-hwtimestamp-b3e22729284d

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>
