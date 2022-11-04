Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6796193C1
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 10:43:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbiKDJnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 05:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbiKDJnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 05:43:13 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 156A326578
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 02:43:10 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id u24so6730105edd.13
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 02:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=RPphcWVh7UNeplFOvV4VO8hoaj8/g9ioN7P0vM2qKR8=;
        b=T2nOTO7Dz7QaPVpvVnHBAqdWXD4u2blzpxZXrargrjmKlPFD8hmH9oH/xAF2/wXdcc
         lVe+VZoKgpddk1HxBTlDCU7ok9Yr6hsXN11jA5tXJbgzfdpQH/EBQ6elSfHXfHp8Efv3
         SdNUUzvtSBGt8/fZT+vCLMwps+fA2yt/nmrcg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RPphcWVh7UNeplFOvV4VO8hoaj8/g9ioN7P0vM2qKR8=;
        b=2EuNsBSARfleu95ojos9GDv47FbktmpYvEX/A3/NASsHEkfMfDgRTILsO7rxYchLYY
         3L2qvWGkXXS1Y+qsGxHcev48YDycxw3rNWch8rj7uS6T5ea5WgzPEU0dFatQm9DBxyvv
         zOIvN3DhBE7Q4CV+d2pHF/VToV+bEY/FQwJEHTYjm+zE8DJBtFEtAxJJaH2dvhPxA3QA
         fqEIr7OIlQaDe09K7vgaI7Tgm336fzZg4tuxzPARcFj/54VFmRhKLg2vSTNxZGx4PI6+
         unAtTMhHD/4bV3G4Do/AEy0kLr8CEGu/h2XUiZUEN5wCAyKDsm7Q3XoGuwaIlN7tERgV
         tbKQ==
X-Gm-Message-State: ACrzQf1Sf9IQ8/xpK0rU378HWncx0onh3ii5Z2j6OAdNv5/z/GZ0CMun
        wtux/TH3vcu4Y9vcws5/h02fp69NSZl0Tbxl
X-Google-Smtp-Source: AMsMyM4iLjXgA67LSFrM0VRHSCL0DSQFR1PTtxzzTdel4CERB9zRxP+riXrPr+zDDTGYe+bo11Zzgw==
X-Received: by 2002:a05:6402:371b:b0:460:ff7d:f511 with SMTP id ek27-20020a056402371b00b00460ff7df511mr35154930edb.148.1667554989453;
        Fri, 04 Nov 2022 02:43:09 -0700 (PDT)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:943d:d0b8:228:b5e0])
        by smtp.gmail.com with ESMTPSA id y14-20020a17090668ce00b0078b03d57fa7sm1561653ejr.34.2022.11.04.02.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 02:43:09 -0700 (PDT)
Subject: [PATCH v2 0/2] media: uvcvideo: Limit Power Line Control
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-b4-tracking: H4sIAJjeZGMC/22MywrCMBREf6VkbST3plbryv8QF3ncNIE2gcQWSum/G92JroYZzpyNFcqBCrs2G8
 u0hBJSrAUPDTNexYF4sLUzFIgAAjipsho18YsDpU/9RQM6VmmtCnGdVTS+8nEexzr6UJ4prx/7AjXu
 v6IFuODSYYtIEqV1N+NzmsI8HVMe3ur/lzPYrhV930mrvi+Pfd9fQDByAdkAAAA=
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Fri, 04 Nov 2022 10:42:48 +0100
Message-Id: <20221101-easycam-v2-0-5956414a608c@chromium.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-kernel@vger.kernel.org,
        Ricardo Ribalda <ribalda@chromium.org>,
        linux-media@vger.kernel.org
X-Mailer: b4 0.11.0-dev-d93f8
X-Developer-Signature: v=1; a=openpgp-sha256; l=883; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=cEazZ8iF+PvRrDR+R/rL9s3vH7vWgL/cmAKb9jbP6wM=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjZN6beLJScLmrVHVgdcUQkabFAyvC9h7KGyb37tl7
 2ds7EN2JAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY2TemwAKCRDRN9E+zzrEiACTEA
 CnjP5odtvlU3GQJyaj+d8nfyikIdgmYlBLzUHVPAQg/XciAinDZkiQ7DyhRAvFWFHTHtBir9p0PCvq
 6lJ5AoEhr0L8myQ7y1o4bJeQbLeQOskYRiNdZTgvNkez0Scc2yY6RxElsnyrjCMMb0QSlgIvAQF8gM
 3ESZNSnvXujwP09vbNYpU/hGm6Et5Jnc+ypsrkR5I/OgYv+R6ygWk2E/3cmKKC320fa0nloUONab3x
 raCJ1Fanx4GqNGY+1v5YRW1ToYA+z0PqGQ6/d8vcdt/T341D6nJWsSCY50l5tCmV4DzDgrjuJbZ01b
 6quO+v9bTyydQy+1XuGHNk2dmJWw9jeMXMUCYpMjgvChF6kotzXFDhxTTvL2lbFITOUozm1xb8iKz7
 G7c4vvexZtn4cWq76qcvlo/MvKi6TAkVN1upLvAx4ggvugXawo/iwmyQjeExt/7Gxlr6EN0sTG8jsv
 kLxSAGla5TbxPrrWvHwM9S93uu2n3Iigc3oJf8R1MUSKyFYG/HJEZ/qT34d1jFAXEU5SPtZLrcAo4e
 NVjNzgl2vL//IMQspi2yTPhGY2u6fW4yn5O1EwP0eADVIhpUH1KIPfmPIx0ER2q4ywWurRHhdHk3D4
 9lPTdcx11yqBSXmUghPWjY0zuv0cdgEhBqUsQWxb0SfZZEoK6pQX/TmlRAmA==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Another set of webcams with invalid PLC controls.

To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

---
Changes in v2:
- Add Lenovo Integrated Camera
- Link to v1: https://lore.kernel.org/r/20221101-easycam-v1-0-71d6409963da@chromium.org

---
Ricardo Ribalda (2):
      media: uvcvideo: Limit power line control for Acer EasyCamera
      media: uvcvideo: Limit power line control for Lenovo Integrated Camera

 drivers/media/usb/uvc/uvc_driver.c | 42 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)
---
base-commit: 23758867219c8d84c8363316e6dd2f9fd7ae3049
change-id: 20221101-easycam-8f1ab598b12f

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>
