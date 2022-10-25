Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64B7B60D208
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 18:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231946AbiJYQy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 12:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231906AbiJYQyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 12:54:40 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 870A822B24
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 09:54:39 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id o4so13918996wrq.6
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 09:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d/ULxq2EdVWZOhwK21JX/tvDkCGf2dqu3n7qEL+lTOY=;
        b=gWB9UysqAbqOPf2utGCOJH9LJdHOTVvaB5IzqXJ++K/yLuCOmVzCGmTWOlhFwGnNZ0
         /1dY+xVgUo+QcHKWnYnpR5lT0jOKo+LhbGfj7zACigig7IiRakyNWEOebPeyBRg9NfRa
         gFWh5ww9Y0Jc+XhTLLpQqIOM21QcG72QsPGe+gi5I9OSY0fVe2rKCalR6BMzhJwfZ91Q
         Zgmp9N7XliVwx3Ml6S9CO1NA9AbKpCiYuL+qAWLMxnMXHUnEb69TTsEaOEJ0njKBXIrq
         NtiigBcNGVlOe3WJ7lJgbHvYDnRr3BeFTzYElFREinnm+LCJ0/Resp8Sv5GGG8mgsqVG
         ANjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d/ULxq2EdVWZOhwK21JX/tvDkCGf2dqu3n7qEL+lTOY=;
        b=3q2/EitpKNr9wuCWo9O9cNzrJTTKBKMwylKo8uYaSlhszWDlJD+FO51c3M6QLkfhAt
         FX0OauUPaxib7/yszNS3GBilq0bEzmuMWrRwLI8kAsKMLXM8F39p9yisACw+V3JZZiKP
         c9tSSF3t8T0ym2OAFCj5mhAxSeg7qpDsbv4e3SCmQQ0N9f3eO8bY3iEaelZ5qD7tMjEx
         Of42O1bkO+LPHiU3VBmBYT8EWIzUB1sTBIJjDajKg0kzJR2nbUEPtVJnu02a5SryY+Im
         VTstBV8QaKRVANQRC8FGm+XD8iYi1E50bUgclP0f9FfkIKcR/ISMPQLrOSAB145tPIPc
         lhYw==
X-Gm-Message-State: ACrzQf14wIkgzyYXB5y7fJT7XpoIahPCrY6L6LdG5MttfdMmPsTp9GRh
        vxVWn0dJreUlOZRqH6qo9Vo=
X-Google-Smtp-Source: AMsMyM4V89EQvtcJaplOO/9x329iSAUjR7qxmdGlVdpsRjAzRPe8F7TxA5tDAipFjnBHO1jzESd3aA==
X-Received: by 2002:a05:6000:1c0a:b0:22e:5d8a:c903 with SMTP id ba10-20020a0560001c0a00b0022e5d8ac903mr25013588wrb.182.1666716878012;
        Tue, 25 Oct 2022 09:54:38 -0700 (PDT)
Received: from kista.localdomain (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id a20-20020a05600c349400b003a6a3595edasm3023989wmq.27.2022.10.25.09.54.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 09:54:37 -0700 (PDT)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     maxime@cerno.tech, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com
Cc:     wens@csie.org, samuel@sholland.org, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH v2 4/5] iommu/sun50i: Fix flush size
Date:   Tue, 25 Oct 2022 18:54:14 +0200
Message-Id: <20221025165415.307591-5-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221025165415.307591-1-jernej.skrabec@gmail.com>
References: <20221025165415.307591-1-jernej.skrabec@gmail.com>
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

Function sun50i_table_flush() takes number of entries as an argument,
not number of bytes. Fix that mistake in sun50i_dte_get_page_table().

Fixes: 4100b8c229b3 ("iommu: Add Allwinner H6 IOMMU driver")
Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/iommu/sun50i-iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/sun50i-iommu.c b/drivers/iommu/sun50i-iommu.c
index df871af04bcb..e62e245060ac 100644
--- a/drivers/iommu/sun50i-iommu.c
+++ b/drivers/iommu/sun50i-iommu.c
@@ -512,7 +512,7 @@ static u32 *sun50i_dte_get_page_table(struct sun50i_iommu_domain *sun50i_domain,
 		sun50i_iommu_free_page_table(iommu, drop_pt);
 	}
 
-	sun50i_table_flush(sun50i_domain, page_table, PT_SIZE);
+	sun50i_table_flush(sun50i_domain, page_table, NUM_PT_ENTRIES);
 	sun50i_table_flush(sun50i_domain, dte_addr, 1);
 
 	return page_table;
-- 
2.38.1

