Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C7FC5F8047
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 23:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbiJGVui (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 17:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiJGVue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 17:50:34 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40FFD5F9AA
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 14:50:33 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id x13-20020a170902ec8d00b00177f0fa642cso4048610plg.10
        for <linux-kernel@vger.kernel.org>; Fri, 07 Oct 2022 14:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7/yVcGYygsrAEZFYKV0NW4OziSMy6BZisPCxXiPujb8=;
        b=XpGN9HYFdv5WvEkOkY9rgpF+Wim45NNbn4P0GrEOPOWjMe79qqCr4xoXFYfdb60N+E
         gqhBtgKozIH+YI22jjyl4WlITO7bEx+bgr/3R7sOKOQ0oeFPTSzY0YR4mmdxO1H8imjj
         PQzw9ePzT5bpEdEM1vdyixSGBH7bkthNUTIKJ23QhMGkh+2M09RDtnZwUee/HpURCrmq
         fCGGgnWMv6rT3L0RWT4kEYR7+vzGo4kSRA3Qz7ZlJoRPTiOHnzADHAoI+77BonF2sWRl
         2uSGryYYdhi6tEva9spi3Oh3lxPFEUR+xVgx76UXjYPuIRllJosz59PsHzCjse+Vu2rL
         qxjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7/yVcGYygsrAEZFYKV0NW4OziSMy6BZisPCxXiPujb8=;
        b=LlDy3NvUZwVjUjoyQJDdW0U47yIe3ZIbA19IHI96T94oz9hp6kOmCaBHVlVs//kHf8
         AifdheoBAfWgmHFR9wJfWPiwCPiigktfuYJU9BaaksmyFDVBS5gpOp50ipHPJd/Fpxmk
         dYfmr1pzDw43amAL+8vd91JXKZf6o9yvGuI8FfoMg0O6t3/8QY8ol70K2YNhucUzfaAU
         edsszs4lpUCnrA1XLGc2WiGl21z2RK15c1m2HRzxl6ocw49rDclf+N6AFNv3xtaY3V/o
         k0b41shsuk6IAPk21sXrYbHn+tGM9EyqH6yItXMzICC1ihwNH2tsIl58rEI00J4hoCWU
         T3nA==
X-Gm-Message-State: ACrzQf3JyLnFuQSD0YIWMVNkDjgNbTbN0bgxfKveAh47HFF6I0DZvR9L
        RZaUG0ZJR++bgPTncUO6NiPj0IeT9rqH
X-Google-Smtp-Source: AMsMyM5y0wueuZvi4OVNCMErL2v02Mlg8WCBTvrXSuakRQLPoC4y79uu723Mc0rRIXk6ISJY9I9vsiR0f7JU
X-Received: from sgzhang.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3d89])
 (user=sgzhang job=sendgmr) by 2002:a05:6a00:1707:b0:562:e790:dfc3 with SMTP
 id h7-20020a056a00170700b00562e790dfc3mr990774pfc.59.1665179432707; Fri, 07
 Oct 2022 14:50:32 -0700 (PDT)
Date:   Fri,  7 Oct 2022 21:50:24 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20221007215027.918507-1-sgzhang@google.com>
Subject: [PATCH v3 0/3] mtd: mtdoops: use pr_ functions, add and direct call
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
printk() to counterpart pr_ functions. [Note: change to pr_debug() may
cause behavior difference.] Add mtdoops_erase function; When panic
function invokes mtdoops, if needed, call mtdoops_erase function
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

