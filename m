Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DAF2658E1D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 15:54:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233442AbiL2OyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 09:54:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233601AbiL2Oxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 09:53:40 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2731FF2;
        Thu, 29 Dec 2022 06:53:39 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id z16so1123213wrw.1;
        Thu, 29 Dec 2022 06:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ccq95IZNXm9rVZDfCeTqu5lSGJXR28E+vmtTwPcaamg=;
        b=ekFyAFgaaNki7S+7E4Gz20eL+7Whui6g7qwdwTgMop9nsxhN0LhAVMbNvGXm+V90LH
         X6EBoo9DJdXIZ5hCe3QHyKQcUY9ieLl9xceDK8J2YJWORfnh7BRz6tAL10bgRKPnhqjp
         aW1G2LhOJoY7/dgYDYrzxbGzLqJF/mHc+mC0GY+5IRn/KmvYRMWlYoLgCtmv5wLlO7du
         68qrkoStvgQ3oW8xTfJba759GEd7/U+YaIWMI/Gww9pq3sDj58cFmtANff8pivZ4dNIf
         A3iI1wu9qZ6N+iYhYWNZgFEgdLCs4cGXtH+veim7SuiPZwy8pIaefyFWDwgPtXFfIV0z
         XaLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ccq95IZNXm9rVZDfCeTqu5lSGJXR28E+vmtTwPcaamg=;
        b=N7e87b0y9PyEZyG37KfgACAdQcX0GwBubGC5pQxaJVCQxQTzFEIOBsl16NwgZeL6ED
         okfHvKXwiI06HNQvRoHB8gVIzhvpbHx23HjLUdpdIdjQMdQntBL6Mnh12YLXfGrF+dFY
         Jr+hK8Y3N+YEMhULhDBjW5sp63hF91P+laSMH4UH8Hl6necP41sXI+yjtXJaCnmaJVfh
         aVj2L65sEnNpiKRQQK+GOXQ4p/KGtEwHpo5/rp2IzHw9NGbcIimOWJ+GnQNseZAhNo5x
         GxuaKc4uoVfm+EgOkqatYxJeqRjEtSCSH8T238Wu8FLeMI1aqe1RUb9RvngJAtQg72B5
         kHeA==
X-Gm-Message-State: AFqh2kqA9ZMBfSXzJ/eYqwMK5Yc/cl0TU0P0FasKZj9lbAp00YQkPZbV
        BcRlc4+wLK34zWytbBta7QWKma3YVmmIEj5c
X-Google-Smtp-Source: AMrXdXvp3Q4zQlK6xWLHi9MPyCpoexg5UaRopR2zLTJ9XTYu/rRnCtIela47vdbKjiUqO6z87VrEDw==
X-Received: by 2002:a5d:5965:0:b0:27f:1c70:58c3 with SMTP id e37-20020a5d5965000000b0027f1c7058c3mr8172632wri.24.1672325617544;
        Thu, 29 Dec 2022 06:53:37 -0800 (PST)
Received: from tpt440p.steeds.sam ([69.63.64.50])
        by smtp.gmail.com with ESMTPSA id v7-20020adfe287000000b00241bd177f89sm18151089wri.14.2022.12.29.06.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 06:53:36 -0800 (PST)
From:   "Sicelo A. Mhlongo" <absicsz@gmail.com>
To:     linux-omap@vger.kernel.org
Cc:     "Sicelo A. Mhlongo" <absicsz@gmail.com>,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, tony@atomide.com,
        devicetree@vger.kernel.org, maemo-leste@lists.dyne.org
Subject: [PATCH v2 0/2] ARM: dts: n900: use iio driver for accelerometer
Date:   Thu, 29 Dec 2022 16:52:48 +0200
Message-Id: <20221229145251.3535402-1-absicsz@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221227223841.2990847-1-absicsz@gmail.com>
References: <20221227223841.2990847-1-absicsz@gmail.com>
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

The accelerometer in the N900 is now supported by the iio framework. This patch
series makes the switch to the new compatible.

The iio framework does not support some of the extended properties in the
previous driver, but the change is useful for modern userspace, which expects
accelerometers to be exposed via iio

Sicelo A. Mhlongo (2):
  ARM: dts: n900: rename accelerometer node
  ARM: dts: n900: use iio driver for accelerometer

 arch/arm/boot/dts/omap3-n900.dts | 54 ++++++--------------------------
 1 file changed, 9 insertions(+), 45 deletions(-)

-- 
2.39.0

