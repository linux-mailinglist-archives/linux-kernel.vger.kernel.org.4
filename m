Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FDBC7342EA
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 20:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236972AbjFQSMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 14:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjFQSMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 14:12:17 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9420F1737;
        Sat, 17 Jun 2023 11:12:16 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 46e09a7af769-6b1fa5a04e9so1368515a34.1;
        Sat, 17 Jun 2023 11:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687025536; x=1689617536;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5wx2MjUHPA+Xun7dM0j+8fNF+bZq54eMfmrRm0GhpLQ=;
        b=EQf9MpGKQUI9no+uZ9gdsmvfJjF9iTToYyP0km1wjv7eCr924UfJJtAOV0qNYZTt2d
         oxMR60tOx+DKIJCTsFA3lwTSJT5AGxiQvJqkBBfNHjEdOevVHJFKpPCI2LZxRC458/UO
         2m4iU1m1imidwlwrP/YnJUDe+txi1HSTUgyh9nRCHMAUlfwoZmKCbmdNmjDvwz9mA76j
         soYJ4lNfT5gxbQSA2vgwE2oERWW5G75fVzguD5VvcMISA7Nnn+PWBWmDeh05YqCGe0AK
         Ei/mJzpPKvBykofpX50L5ztmG3ToqyCYVepp/kkce0zCwHc+i6z3h7UsA6h2edv2qFSA
         9zhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687025536; x=1689617536;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5wx2MjUHPA+Xun7dM0j+8fNF+bZq54eMfmrRm0GhpLQ=;
        b=gHZcA8LNAZd5lKS3Hi70/aCJRFPDHyf2iuqXPS9Xb/8mQLWdJhjUVza2Hm4W/OtGxa
         si3xh/4VjIZT00C/GUt33gNTt86GXNQ6G1oY1xfzJ04lGhPtYlSeJc5nxOn1r8Qn4gU7
         /XOrGQ4FeZj/W6TBPRXG8iYPvyFolYTx5969N+Jy3KL9CUgrDJZgUN1sNWWxK8mSW/+x
         yGu1/ieH4wx2BRZVPRi4/ZY821P0bp2YHvXuW/Z8LJ+gW8T7lIVhxZmEbKlS4Jo/Vxp2
         ozLweiq+wMQMWubgUrjmkHYNdX/3mWdHPBye/Z1BtVrmxNe1HgE1VSFa5j5qEfaBG0vk
         Ogow==
X-Gm-Message-State: AC+VfDxE/UGwYG//sUGprmeS/e3KM34n/IO455G76ZfBng113VK4Qyxf
        tV/zYcy3ZvPcUIrvPEC8/whX0lXsjEg=
X-Google-Smtp-Source: ACHHUZ7DJBhtYdHPm7i7DgnBXij+fPxACYecTPivrMoxK6bpNjg+dHwafpRFmyfdf3h6BhL/450+rg==
X-Received: by 2002:a05:6830:1da4:b0:6af:a332:4c23 with SMTP id z4-20020a0568301da400b006afa3324c23mr1532341oti.14.1687025535864;
        Sat, 17 Jun 2023 11:12:15 -0700 (PDT)
Received: from smeagol.fibertel.com.ar ([201.235.4.68])
        by smtp.gmail.com with ESMTPSA id j24-20020a9d7698000000b006adda5cddb7sm6604927otl.62.2023.06.17.11.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jun 2023 11:12:15 -0700 (PDT)
From:   =?UTF-8?q?Joaqu=C3=ADn=20Ignacio=20Aramend=C3=ADa?= 
        <samsagax@gmail.com>
To:     linux@roeck-us.net
Cc:     =?UTF-8?q?Joaqu=C3=ADn=20Ignacio=20Aramend=C3=ADa?= 
        <samsagax@gmail.com>, derekjohn.clark@gmail.com, jdelvare@suse.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] hwmon: (oxp-sensors) Minor cleanup of driver code
Date:   Sat, 17 Jun 2023 15:11:41 -0300
Message-ID: <20230617181159.32844-1-samsagax@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make some cleanup of the driver removing unnecesary header and some
duplicated return on error logic.

Joaquín Ignacio Aramendía (2):
  hwmon: (oxp-sensors) Remove unused header
  hwmon: (oxp-sensors) Simplify logic of error return

 drivers/hwmon/oxp-sensors.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

-- 
2.41.0

