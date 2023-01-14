Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E14B66AECE
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 00:35:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbjANXfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 18:35:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbjANXfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 18:35:07 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE4AD659B;
        Sat, 14 Jan 2023 15:35:05 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id v10so34875034edi.8;
        Sat, 14 Jan 2023 15:35:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B2dKhwGkggyvco2BWOxYe3ouShVm3nX1AbOxxt3Y1Mo=;
        b=K90X840mVfYzdiMX47qN4epJtBMijiyCyzx/cAJPTFr8C+vLUpDkkxfQrrLkUfZ4PJ
         QdOoZPUyifgx0v9ZEf2Twvjdpc+ZkhJQymE6fFtd8m0sQmy9LmO2Ld7KiMYvcpxcIjx6
         aWtLgiCYe29ntbw7TPTjaHkfdIDFgKnevtVzIE1J7Qj3JLgvRzDkj8+mCWAGe3q34hgL
         h8/xRvgBQHFvqITKkxESyi1MblscJBkCuzDPbKta8ws3vspCft8uYQTZVs/F/wMFQOSD
         FwrjlcQymBFoKjMpSvN1PCVNpD66dOoBN5YiHozc+gkm2s+VMRONmpcsOTzK+JJFJyL4
         Mc4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B2dKhwGkggyvco2BWOxYe3ouShVm3nX1AbOxxt3Y1Mo=;
        b=k1sInC1HyAgAjExJpxo1+y9UMiK74RBcsJhaLclDf6c//WvxLl2+tHb/Lk3jDWrffV
         Uyavo2aZD0xEjcEswA3RNEyidKfCcXep2ZvLCIhvByAgl/UaQWGLdGZpV93RCH7Oq27w
         5s+ah0FNdprMqdUa9fMQQTta3UNKO6cYMCrHnCABDdmZRqagnFc3fl2BLxlapEA0UlEM
         lLdYLkzkLdMvSrPNK9LGvzLxpzL6eAtni3bPDG9pdUxt74qKgNCW8O72sH8ajIFPdSxd
         6gzma9vbO23/OE8jrUvEYFyrjCpC2VQS9Xu94abRYrR7FoLd8yxB4KCpX3gUuGmEh4t6
         wRow==
X-Gm-Message-State: AFqh2kp8v8VzeTUpkZm3s0j/mB/D0s3wG/+td52yxpCEgCCEBTfPDfIL
        o4DyR91g3byYhRbG+ogqYCM=
X-Google-Smtp-Source: AMrXdXszlQ6y65XdA4OM1QOd9axutkTgtNcuFoQlwjfLD8AJzTMH5eg2XNpPSFK3En2bKkfISKXHRw==
X-Received: by 2002:a05:6402:4518:b0:46c:b2a7:1e03 with SMTP id ez24-20020a056402451800b0046cb2a71e03mr67404971edb.36.1673739304112;
        Sat, 14 Jan 2023 15:35:04 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a01-0c22-7ae1-c100-0000-0000-0000-0e63.c22.pool.telefonica.de. [2a01:c22:7ae1:c100::e63])
        by smtp.googlemail.com with ESMTPSA id d7-20020a50fb07000000b0049cbd334b13sm1967620edq.29.2023.01.14.15.35.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Jan 2023 15:35:03 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        neil.armstrong@linaro.org, devicetree@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v1 0/2] ARM: dts: meson: Add more L2 (PL310) cache properties
Date:   Sun, 15 Jan 2023 00:34:53 +0100
Message-Id: <20230114233455.2005047-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I had these patches in my testing tree for a while now. The vendor
kernel uses the same configuration, so it probably makes sense to
use them upstream as well.


Martin Blumenstingl (2):
  ARM: dts: meson8: Add more L2 (PL310) cache properties
  ARM: dts: meson8b: Add more L2 (PL310) cache properties

 arch/arm/boot/dts/meson8.dtsi  | 3 +++
 arch/arm/boot/dts/meson8b.dtsi | 3 +++
 2 files changed, 6 insertions(+)

-- 
2.39.0

