Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B22506FBEFA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 08:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234599AbjEIGFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 02:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjEIGFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 02:05:43 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40FE0903C
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 23:05:42 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1aaea3909d1so51353015ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 23:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683612342; x=1686204342;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IzJM++trNdzMDT7oM7AdgBO0zlbtFrrX6DG+chcJV/k=;
        b=nNrTrG9YjTTi3415nM9nQU2ZssYKWGffubLAK/Ys9KUaoUmfmgiS/FqPnj+HRy1te5
         PtDQGeDWvyIHSaF30g20SAOuqJfQqKnLmux9/m7AQI45hpmp01HZqB37ZgKqPgVlBzRh
         ozSsOEzgjpCkTqnRPJe8Ip/wVFw8KI38s/lumYkTMmTs2tR2icnzJGexoXYFbps7dBaT
         Tx7INzEOLBSS4dQX0BurzlIQW7Bz+vBTRkS4EerYfSuph1Y+nU3+PponYHbttRVC/xfz
         Xhod6cl/4Y72l3DRDKkxdV0VutovMxVOx/EVBZb+/EK9/Uo4UzHOkCFO4ZIXSZZ/sNgz
         y1OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683612342; x=1686204342;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IzJM++trNdzMDT7oM7AdgBO0zlbtFrrX6DG+chcJV/k=;
        b=L2Kqr/dN0YBAsWY5eLTL+JjuTiLxpXd+SbM/l4APqgiWnlmZGoHhduvRLPVNMn1k45
         jHKv6hJECMAazRpzcZODwAqBE7YS71ET78QCeOcPQ7gILe5mVN55k9yeb/iIGsoP9x7M
         D6vQ+tA95bPRSwYk1nkJJqKQqBBHyjuVGHZqgSU2VNZXO/nm7hXtgsvG9V2sinyqPMKU
         zegOFqcXCVP7LpLFCM7ClWzkPLQwxWCCjySD5id+04sBJr2WiIok3/x/5RiBuRSNQFC6
         J+cssPdYAFic61tDu5iVif3NEw1fL1cHHZYgRS3WwtNg03pO69vzr6j31dZ1aDV6atbI
         MNVw==
X-Gm-Message-State: AC+VfDy1Eo7/qYZEDODCpOr3fplvrDkEy75Cf2VqHz1dbuNUjwNkS6N1
        6AWRRsmQR1GA6hRgAJGlP4w=
X-Google-Smtp-Source: ACHHUZ4u7KnVLIOZkZt1uNMyWmer6cE3FrcCiocERxPqyOOAoWfVdAr7wQJ8HYuWhbudTNjNq4CRzA==
X-Received: by 2002:a17:902:db10:b0:1ac:5c90:23e with SMTP id m16-20020a170902db1000b001ac5c90023emr12875765plx.7.1683612341636;
        Mon, 08 May 2023 23:05:41 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([104.28.245.199])
        by smtp.gmail.com with ESMTPSA id ay8-20020a1709028b8800b001a9a3b3f931sm582220plb.99.2023.05.08.23.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 23:05:41 -0700 (PDT)
From:   David Yang <mmyangfl@gmail.com>
To:     linux-phy@lists.infradead.org
Cc:     David Yang <mmyangfl@gmail.com>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] phy: hisilicon: Add inno-usb2-phy driver for Hi3798MV100
Date:   Tue,  9 May 2023 14:04:43 +0800
Message-Id: <20230509060449.1151113-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
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

This series adds support for inno-usb2-phy on Hi3798MV100.

v2: split patches, and other changes according to reviews

David Yang (2):
  phy: hisilicon: Add inno-usb2-phy driver for Hi3798MV100
  phy: hisilicon: Allow building phy-hisi-inno-usb2 on ARM32

 drivers/phy/hisilicon/Kconfig              |  2 +-
 drivers/phy/hisilicon/phy-hisi-inno-usb2.c | 62 ++++++++++++++++------
 2 files changed, 47 insertions(+), 17 deletions(-)


base-commit: ba0ad6ed89fd5dada3b7b65ef2b08e95d449d4ab
-- 
2.39.2

