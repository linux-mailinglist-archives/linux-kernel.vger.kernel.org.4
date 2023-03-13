Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5DB6B798D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 14:55:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbjCMNzQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 09:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231192AbjCMNzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 09:55:14 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0893E1CBDE
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 06:55:13 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id o12so49030532edb.9
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 06:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678715711;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5ANUqqLjStoxoRFBqdgwmvZsT70GJ/Jr3W8t8R6fOUM=;
        b=LfvryJ/Hh9VtYfYGkYcRE5XtQIW5CiCZpxNR9nyzT1kOsu0Jrtjr7v2iOxMb/w99cx
         tPaTM4Eluypt4+FrGHJ4bjOiMtHW3w9W5QMalZWrztjOw+h0fcExZfKUluQdaNxWUYXJ
         ztahp9nyxgr8S5qxk5aNIdgqrLwh4nlwLflUyQNzYL7zvYo+v0l7j6OL1sutWFvT2J/p
         CEn84V+4Q5kyARP8+iDj6iemwFOwiAsApfRDaAE5fNTr52L4TJ6hyXW1QTsibXdg3zFG
         NB/Rps7/RbXFEYRDO4UbwQrZrQPsvCTZqFGZbzdWpBAPkqbgLBWxg1WR5aNQ7MrM4SOW
         B8Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678715711;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5ANUqqLjStoxoRFBqdgwmvZsT70GJ/Jr3W8t8R6fOUM=;
        b=F9rSF9iaDIhMtSa87n0GyIiHz6kFiNVoXWnxnqQkFYLuAEaZB9wCk8XBkVjb8QN5Du
         gQqR+/RQpVy5K8BZPjyQFpBcjdcitZfPuUWulTQxXBz+Nt84QzQnzFtVOoLS/qDekJp4
         9Be7RVK9vGVs2OqtQ/BB0btju8GdLzK4dAVv0AaRQ+gEb/3IJVAHuw+lWnC6t+CZzwIo
         sEu2AoT/dMsa9EoII+5QMqVisba2wssIYo5PNXOwe7rzFhiOTB0SBGOfGUVEyVEeyE9Q
         ESffNiFaecBnq1d/8K2RYHSQRjWGxWM+xG9pTIM+wuhpAgbOzImCvbuDeBILfYDpgNDv
         7y0A==
X-Gm-Message-State: AO0yUKWJsQa/aOeKQSenoAjzWyvD/dQMv3ysM73eWrxILpLhZ6Ev+0bi
        KinOh49IUT5xudCFDQ1qiGo=
X-Google-Smtp-Source: AK7set9/H1wWlFAmPUJSqeoduvu77jubQDUoBG2Tq/orIZDxpSFJwPGjAQdHPFvc9rKR1pOjDEClTg==
X-Received: by 2002:a17:906:3141:b0:8b1:7b10:61d5 with SMTP id e1-20020a170906314100b008b17b1061d5mr33118610eje.33.1678715711476;
        Mon, 13 Mar 2023 06:55:11 -0700 (PDT)
Received: from [127.0.1.1] (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id t29-20020a50d71d000000b004fb419921e2sm2100094edi.57.2023.03.13.06.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 06:55:11 -0700 (PDT)
From:   Jakob Koschel <jkl820.git@gmail.com>
Subject: [PATCH v2 0/2] drm/nouveau: avoid usage of list iterator after
 loop
Date:   Mon, 13 Mar 2023 14:54:48 +0100
Message-Id: <20230301-drm-nouveau-avoid-iter-after-loop-v2-0-1e6428cc7fa8@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACgrD2QC/5WOwQqDMBBEf0Vy7pYkFqU99T+KhzVudMEkJdHQI
 v57o3/Qy8CbXWZmE4kiUxKPahORMicOvoC+VMJM6EcCHgoLLXUta6lgiA58WDPhCpgDD8ALRUB
 76BzCG269tfdWNQ1ZFCWnx0TQR/RmOpIcpvJ6HN6RLH/O8ldXeOK0hPg9t2R1uP/UZgUSZCs1G
 V2XAfI5OuT5aoIT3b7vP6y2HRnrAAAA
To:     Ben Skeggs <bskeggs@redhat.com>, Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Pietro Borrello <borrello@diag.uniroma1.it>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>, Jakob Koschel <jkl820.git@gmail.com>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678715710; l=1449;
 i=jkl820.git@gmail.com; s=20230112; h=from:subject:message-id;
 bh=2L1COAFZdosvV2nj+9Azdzd+YrB52T+o5+nwJnnaB04=;
 b=bzOGournFjDpt2sMS0dAIh4T4eb7MuWaz0jjEOJP/0+zGY+ul4w4rHxchzbQWjNAK2Exf5l6K3zw
 UxK4gnsXAp1nsjLXuxfTz8D3BlJSObdekHvIPgtIxVdtICKsgUqM
X-Developer-Key: i=jkl820.git@gmail.com; a=ed25519;
 pk=rcRpP90oZXet9udPj+2yOibfz31aYv8tpf0+ZYOQhyA=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set includes two instances where the list iterator variable
'pstate' is implicitly assumed to be valid after the iterator loop.
While in pratice that is most likely the case (if
'pstatei'/'args->v0.state' is <= the elements in clk->states), we should
explicitly only allow 'pstate' to always point to correct 'nvkm_pstate'
structs.

That allows catching potential bugs with WARN_ON(!pstate) that otherwise
would be completely undetectable.

It also helps the greater mission to hopefully move the list iterator
variable into the iterating macro directly [1].

Link: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/ [1]
Signed-off-by: Jakob Koschel <jkl820.git@gmail.com>
---
Changes in v2:
- convert BUG_ON() into WARN_ON()
- Link to v1: https://lore.kernel.org/r/20230301-drm-nouveau-avoid-iter-after-loop-v1-0-0702ec23f970@gmail.com

---
Jakob Koschel (2):
      drm/nouveau/device: avoid usage of list iterator after loop
      drm/nouveau/clk: avoid usage of list iterator after loop

 drivers/gpu/drm/nouveau/nvkm/engine/device/ctrl.c | 11 ++++++++---
 drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c    | 10 +++++++---
 2 files changed, 15 insertions(+), 6 deletions(-)
---
base-commit: c0927a7a5391f7d8e593e5e50ead7505a23cadf9
change-id: 20230301-drm-nouveau-avoid-iter-after-loop-4bff97166efa

Best regards,
-- 
Jakob Koschel <jkl820.git@gmail.com>

