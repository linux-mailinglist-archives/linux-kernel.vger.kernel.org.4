Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD475F745C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 08:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbiJGGvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 02:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiJGGvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 02:51:18 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3C8F1176C5
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 23:51:17 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id j3-20020a170902da8300b001782a6fbc87so2793408plx.5
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 23:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tfq9PSGDXYpZtQCHcbvdnQkS1SYQVEwTPGR6C7TSjig=;
        b=XIYie7P9h7PQH9nyPA5sytpXQ+nirNYK9pq/gqG+8siVETbp96FSGn0WQDYKVN+mhw
         mTRYyGpCXbhtTmHJkF8QOZtoVnVLLm8n7njs7piHPjhti6kvF96dg1FDH6CQjP+nt2vE
         gZA0ORzUpF4YiXrlj1xudqFlukEhwyo7/S2bjzDwaFpIiF2Y3Elym/tOITnLSqpHkigs
         EvqeHnDUhvQCi2O7ocMaLM4lBkji3vJE0CwZWWtXATytnN5xb7yGnamMuCzmUB73E4W1
         C+YFwa607cckvF3sNR0I+OhOYguVa7CL61ChD/FgYBPXpedfg1z/qGoNhPgZxu5AODk/
         XXog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tfq9PSGDXYpZtQCHcbvdnQkS1SYQVEwTPGR6C7TSjig=;
        b=LDCcv2fiwwlh+iO01cv0cvHXqGJXveS8TIMqtjeI5FEIlFWbcJ8uP1HbBQ/l1WWCDv
         Z/3Dc9Tb2BjcmnWO2Kx8UHFhuT74XQezC6cTSIJqRY8+sR8FAPK2J2+nU8K7WgZUNQr6
         I3EYSljA+dtll1KF6vGoYcZoXNt7dYshOBSMD0mhAv4kE75foMuSZ4RPbVTpi3HmBPnp
         aYkYV4wqEI+OvJP0oTvjENiOYAy35fWTUVkDNIcAD/nZik5dfIqHMLO8RtwqM2m4zJQ8
         CHOsisxd1nfMki1LYFZDa0uOD5AGiw6KLOUxWzcWVZPZWdpnhgMFfhCRbPQpujdIIi/I
         NqBw==
X-Gm-Message-State: ACrzQf26qvMjskpnHBFpot0JYSZ8GHRt4Ej8cdsEfaGzMAyNw+U8DoIv
        Uf0gkb8NdIsfidJpkoQxpwvu6t4dlKZF
X-Google-Smtp-Source: AMsMyM77gwewrkwlUBIXJIRw0AYhQ3+4cmMkTaTi5DgxmQFldZmVoa3rzJoVPLNGFjXvJ1sfZvIXpkgUbNnd
X-Received: from sgzhang.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3d89])
 (user=sgzhang job=sendgmr) by 2002:a17:90a:f016:b0:20b:a65f:af42 with SMTP id
 bt22-20020a17090af01600b0020ba65faf42mr1196300pjb.79.1665125450706; Thu, 06
 Oct 2022 23:50:50 -0700 (PDT)
Date:   Fri,  7 Oct 2022 06:50:39 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20221007065042.700761-1-sgzhang@google.com>
Subject: [PATCH v2 0/3] mtd: mtdoops: use pr_ functions, add and direct call
 mtdoops_erase function when panic
From:   Ray Zhang <sgzhang@google.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ray Zhang <sgzhang@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In mtdoops driver, to comply with latest kernel code requirement, change
printk() to counterpart pr_ functions. Add mtdoops_erase function; When
panic function invokes mtdoops, if needed, call mtdoops_erase function
immediately.

Ray Zhang (3):
  mtd: mtdoops: change printk() to counterpart pr_ functions
  mtd: mtdoops: add mtdoops_erase function and move mtdoops_inc_counter
    to after it
  mtd: mtdoops: panic caused mtdoops to call mtdoops_erase function
    immediately

 drivers/mtd/mtdoops.c | 107 +++++++++++++++++++++++-------------------
 1 file changed, 60 insertions(+), 47 deletions(-)

-- 
2.38.0.rc1.362.ged0d419d3c-goog

