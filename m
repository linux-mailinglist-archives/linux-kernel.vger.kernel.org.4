Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26E9E6A7204
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 18:25:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjCARZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 12:25:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjCARZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 12:25:46 -0500
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A7463CE29
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 09:25:45 -0800 (PST)
Received: by mail-ed1-x541.google.com with SMTP id eg37so56731579edb.12
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 09:25:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TIKf9USoNGrPIqwS1jS8iBKNWT2IT5bq/zGBG74CLF4=;
        b=Xsfaf+/FD3GogNA3ROSwSXWpx4XBHfzhDLFRoNWC4yapB6vtuymB48aBUVI3HLKDAN
         pQRbos/7jYC2eusNNp9nrYgf8+9mfKAiLGzMBqKGnYcGr3rjuZ4UDeKhwjvCG7347nmq
         F+prEmHcbPEPeBNUwWT4FNCPpLAiyFrrV99z+WWICA0kPf8EmVSrg2REP1nt9vwaM6lW
         /thkZzrzN78f+gSAkuP/O1v8SaX3GO98l0w0aHZsNgbQbp2iaCJ/AxDqI1omAuVJ32V+
         7PAuNJQ/yzO+hWWzZdRGtpEjoA/tlyRXhsW/QjyPz3O9nUoGmhlk9K2kZbEz1cnWt2t0
         Zang==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TIKf9USoNGrPIqwS1jS8iBKNWT2IT5bq/zGBG74CLF4=;
        b=neS/3pEgZpDlNLWdwbUaIP6yJj043QpkeulawLNfC043lo0lYpnhVlphD5vehBNGAq
         UIRo/+d1RLGa+5gz5a1Utcp6JOKIvnDWJVvQosXNY0fXp91/3i40imB/JA+h96h/G9iT
         Re/YVf8CFNzd169T3TcYVE1YD1Nqe5WtGmfUNTRZ6FO1bFKB/vEkcu4JV9TFKR60IoYK
         RUxDUv1xx+lWPpKSDnaie9ojHg5k4tcXul0ERLBqNPrkxwokJ4E8JF7iThZiqNSET0L2
         359jD3KzsX8yGv4O7drYfppebGPsMyyabBHpynpzZLB8pp+7gx+Q1B3KMsw6e2O5P5GF
         m2AA==
X-Gm-Message-State: AO0yUKURMxStqgbWJsbtNhUrd/7PUMaS8oZgYBBT5BeDF+5LgpRuSBhe
        1zLjFJSqcVk0gbKdy7LpTNGBBk9FlSQaJ00B
X-Google-Smtp-Source: AK7set9jTbAsR9cNioxPfi+x3CvaDwDw3kuiDvH0WYzKjl2K+AGsLhBFTzGOL5SDJ9QkyYY2BEtbPg==
X-Received: by 2002:a17:906:9484:b0:8e5:2a12:8ec0 with SMTP id t4-20020a170906948400b008e52a128ec0mr6586812ejx.31.1677691543838;
        Wed, 01 Mar 2023 09:25:43 -0800 (PST)
Received: from [127.0.1.1] (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id v23-20020a170906489700b008e9ac1ad79dsm5974715ejq.194.2023.03.01.09.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 09:25:43 -0800 (PST)
From:   Jakob Koschel <jkl820.git@gmail.com>
Subject: [PATCH 0/2] drm/nouveau: avoid usage of list iterator after loop
Date:   Wed, 01 Mar 2023 18:25:36 +0100
Message-Id: <20230301-drm-nouveau-avoid-iter-after-loop-v1-0-0702ec23f970@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJCK/2MC/x2NwQqDMBBEf0X23IVEi6X9ldLDxmzqQk1ko6Eg/
 nuTXgYeM7w5ILMKZ3h0BygXyZJiBXvpYJopvhnFV4be9IMZjEWvC8a0F6YdqSTxKBsrUmj5SWn
 FqwvhfrPjyIGgehxlRqcUp7mZFsp12opVOcj3f/58necP6PufK4wAAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1677691543; l=1273;
 i=jkl820.git@gmail.com; s=20230112; h=from:subject:message-id;
 bh=ufRWs1wfmAulODCpfYVVJMkyck345u9wLDQP6nFhSdw=;
 b=wOeLFKWvzQ/NXw7t6I+ftrfBnD3HB8qkUJjRx9ThZJJuxKGi9huiiDiV9n599nJmo9FVrvsk0jGm
 nUM3NjVZAWOMcK1x7xvYI6aO4TYVYk/+wzXc9iAa/fBs0bHheMTd
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

That allows catching potential bugs with BUG_ON(!pstate) that otherwise
would be completely undetectable.

It also helps the greater mission to hopefully move the list iterator
variable into the iterating macro directly [1].

Link: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/ [1]
Signed-off-by: Jakob Koschel <jkl820.git@gmail.com>
---
Jakob Koschel (2):
      drm/nouveau/device: avoid usage of list iterator after loop
      drm/nouveau/clk: avoid usage of list iterator after loop

 drivers/gpu/drm/nouveau/nvkm/engine/device/ctrl.c | 9 ++++++---
 drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c    | 9 ++++++---
 2 files changed, 12 insertions(+), 6 deletions(-)
---
base-commit: c0927a7a5391f7d8e593e5e50ead7505a23cadf9
change-id: 20230301-drm-nouveau-avoid-iter-after-loop-4bff97166efa

Best regards,
-- 
Jakob Koschel <jkl820.git@gmail.com>

