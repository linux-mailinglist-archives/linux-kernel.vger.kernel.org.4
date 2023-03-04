Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0BA46AAC2E
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 20:46:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjCDTqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 14:46:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjCDTqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 14:46:42 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D058B1C30E;
        Sat,  4 Mar 2023 11:46:35 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id l7-20020a05600c1d0700b003eb5e6d906bso3053184wms.5;
        Sat, 04 Mar 2023 11:46:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677959194;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jL+0SGbmsE5qL/ygYR2iPquPm8JXmREXBtNOxFccJGE=;
        b=ViQe3pnacBvfxCp6tX9u9Z0L5MdcmmqpQBwRKdUSbaVdJAX5LnV7NnRMiDQwWN7hqn
         3xEgwIGFjUnXnDts1QeKqnWnfQdZ750DylJhy34EzrI1v768xAO4cjPz+yqOlGpVuZ7o
         ju+U4mTKt9Yj9FGpCFq+VFV1ZzPgKZgGxTUtj29TS2Lk8ottlKU2thzQUCddhM9gHIyZ
         G7k20ci4kEmZENat5xG44dQxfr+1UNadoaflLmaMNrvWsITPEYTQpAMbnpssQhGD8c7b
         Cdf2yu4JO85ZdlGYlVhL30ifCVlGcQB5qNVT+Mgkb2SYLzM8AQYeBS1W/Mp78LcdRNlB
         jVYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677959194;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jL+0SGbmsE5qL/ygYR2iPquPm8JXmREXBtNOxFccJGE=;
        b=bt+n5Fk2gCB29/Row5jPSXKhqhlhP77dkj0t9k04LN9N752/CVAd5qsUyCRTvHnave
         MGKDfTi/Mb9FAY79lnSwahD8exzUM12iD+UEcJSgU8hbjTf+bF6LuzoV0+I3uEUP7JlL
         LuJ3dgmM2yBaybESqXMbIAdir7S03KG5uaSGODsCa/xW4OnPxu5mXF3DvPZWwNMNMVCG
         53EjC/K61qzLR98BoAJtFOYbriZIPZHzeh3w2m41e4Cwa88KMb8T4i3Rqnrbk0Thvbsx
         hCa4jjsaFnDYBrsXMWOEQto53igOgTy7BDZ5QDB7oRYbTpPn9imP+hWF7emm7Ew1V6e0
         peNA==
X-Gm-Message-State: AO0yUKX/H+FZ8ypyX2sXSmfUpFAiieJRNRe/HizFkbfnPo6JzAfNCo5N
        yGNSt3kJ7Iw+x0DSBn/1YFNmnrBfCcvp4A==
X-Google-Smtp-Source: AK7set81FQQ6z+fkQfDbSI3303Jfts7/uUV1jvI7PQ451Re4nH4cOC2YGTQB7EHQ1kzAJlVBKWdZgg==
X-Received: by 2002:a05:600c:4751:b0:3eb:2e66:8 with SMTP id w17-20020a05600c475100b003eb2e660008mr5396294wmo.35.1677959194242;
        Sat, 04 Mar 2023 11:46:34 -0800 (PST)
Received: from xws.localdomain ([217.138.207.232])
        by smtp.gmail.com with ESMTPSA id n37-20020a05600c3ba500b003e2052bad94sm10696067wms.33.2023.03.04.11.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Mar 2023 11:46:33 -0800 (PST)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Maximilian Luz <luzmaximilian@gmail.com>
Subject: [PATCH 0/3] platform/surface: Add support for tablet-mode switch on Surface Pro 9
Date:   Sat,  4 Mar 2023 20:46:08 +0100
Message-Id: <20230304194611.87770-1-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.39.2
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

This series adds support for the tablet-mode switch on the Surface Pro
9. On that device, the posture subsystem (POS) can be used to query the
state of the Type-Cover (detached, laptop-mode, flipped-back, ...) and
receive notifications when it changes. We can use this to implement a
tablet mode switch, extending the driver already in use on the Surface
Laptop Studio.

More specifically, the posture subsystem allows for different posture
sources, identified by a numerical ID, each of which can have different
states. At the moment, however, the tablet-mode switch driver using the
POS subsystem only supports the Surface Laptop Studio, and support for
that is hard-coded.

To support the Surface Pro 9, we therefore need to adapt the driver to
properly disambiguate between different posture sources (patch 1) and
then implement the respective functions for the source ID representing
the Type-Cover (patch 2). Finally, we also need to add the respective
device to the Surface Pro 9 entry in the aggregator registry, to allow
the driver to load (patch 3). 

Maximilian Luz (3):
  platform/surface: aggregator_tabletsw: Properly handle different
    posture source IDs
  platform/surface: aggregator_tabletsw: Add support for Type-Cover
    posture source
  platform/surface: aggregator_registry: Add support for tablet-mode
    switch on Surface Pro 9

 .../surface/surface_aggregator_registry.c     |   2 +-
 .../surface/surface_aggregator_tabletsw.c     | 180 ++++++++++++++----
 2 files changed, 142 insertions(+), 40 deletions(-)

-- 
2.39.2

