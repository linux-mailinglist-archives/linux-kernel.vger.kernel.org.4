Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB602670F48
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 02:02:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbjARBCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 20:02:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjARBBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 20:01:54 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4CAE54125
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 16:52:21 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id s13-20020a17090a6e4d00b0022900843652so694771pjm.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 16:52:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ngneZ5ot6sHXiEGEYxZFD2z6acm6v6FBOmpIfqb52ME=;
        b=Db+FMZyRdjI1+JDnEqm+dFBYa8BikO3dsCbOQLNRU4wcANOQsgy1Lw9WJBQ7EwdnWY
         3pkC77AqABzY5W3/2G/obeVeezmM8hFYOJwkqE/UG2xQ5FoPtcZQu+1Jy1KFOIU9HZXa
         Kl1ef3UuRCQPiKIDNBcPellz0HhMNbTR75J6I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ngneZ5ot6sHXiEGEYxZFD2z6acm6v6FBOmpIfqb52ME=;
        b=43XjMU3m92asoPRF30WLJv6rson587g/60Qn28Z75IUM13LbZzZQxzSehgufWUgzpg
         iVsCGMvaUkgQfvN9gYAfweIGuL9ET4s59MGtFrnhq+AH1cZn0ZZPG6Ng9SKgwa1nT6Ew
         mrnZCuFtogvyBX7sK7fRNy6Daf+Rm1D3pcTKundwQlqCKzoRojQq/OmQ1GNrH8N3j67E
         yetQrx4FKe41shWyhWkkQVxaEoXO+SMeJDKQkb+PgEpIiqC+a8qNodxSPoNThHEtqz54
         feY2FZjvOd0mYSV6vjDGEwH2DgNA80lGjmBPiUvjlSKV9B4kP/YonF+OgLmufaPW/Fgg
         n5qw==
X-Gm-Message-State: AFqh2kq2Zwy3/jxCspBdIrH6xfFFWKGtFLZrpivwXTZIGnLJtzUKhDMc
        SrN+CDS0EZT0L3SnvfChPcSTlQ==
X-Google-Smtp-Source: AMrXdXvdw48f1HPWGTuOB7gZIw7RBA1UdULAuXnyyg54PMV+G8bSsKB/Wgbo1JiX32SHUwbtiUBurg==
X-Received: by 2002:a17:902:f285:b0:194:9cad:e242 with SMTP id k5-20020a170902f28500b001949cade242mr4981048plc.27.1674003138810;
        Tue, 17 Jan 2023 16:52:18 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:10f3:73a5:7e44:adbf])
        by smtp.gmail.com with ESMTPSA id u10-20020a17090341ca00b00192f4fbdeb5sm8351461ple.102.2023.01.17.16.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 16:52:18 -0800 (PST)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv3 0/4] zsmalloc: make zspage chain size configurable
Date:   Wed, 18 Jan 2023 09:52:06 +0900
Message-Id: <20230118005210.2814763-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

	This turns hard coded limit on maximum number of physical
pages per-zspage into a config option. It also increases the default
limit from 4 to 8.

v3:
-- Fixed zspage isolated bitfield overflow (Mike)
-- Fixed parisc64 build failure (0day)
-- Minumum chain size value is 4 now (which has been zsmalloc default
   for ages)
-- Picked up Minchan's Acked-by

Sergey Senozhatsky (4):
  zsmalloc: rework zspage chain size selection
  zsmalloc: skip chain size calculation for pow_of_2 classes
  zsmalloc: make zspage chain size configurable
  zsmalloc: set default zspage chain size to 8

 Documentation/mm/zsmalloc.rst | 168 ++++++++++++++++++++++++++++++++++
 mm/Kconfig                    |  19 ++++
 mm/zsmalloc.c                 |  71 ++++++--------
 3 files changed, 213 insertions(+), 45 deletions(-)

-- 
2.39.0.314.g84b9a713c41-goog

