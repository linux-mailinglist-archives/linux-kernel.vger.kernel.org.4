Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D076B6FDAE3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 11:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236572AbjEJJjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 05:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbjEJJjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 05:39:52 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC6C84207;
        Wed, 10 May 2023 02:39:49 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-643990c5319so4943790b3a.2;
        Wed, 10 May 2023 02:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683711589; x=1686303589;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ckUkgH/LBnma6i9Vpo625SXqSP6maiHgE6xir4pKJms=;
        b=m/7g9q2gDUy79+/IGUGORh8Y7n3vgTLW1eXsaskk5Y2v+SDrACdtEW0NrPgmqHqvT4
         /TYZukg4HzB7OWEn2AZLtStG8gudqMhFlRNDduE1MhQFES079vi0huIstWLDZVTrhnFO
         o3RFIhoVKf4iAwTU5gaS/HJhMoUs5giGua0N4DAzCU6ZkQgN4C6WZMcDYPjjCAJwcOF+
         r8GqJJJfm6BHrB6GwsqWXic4Of2MhHIBoQLhfYcBxGIa9uxJvKj9yyDhBIRsVGE1Bx/H
         8PJjQsScIUQw0WvTw3ViQLc2a+eLc0Q/Nkt/ue7YW2zrT4YZgF5L56/oMZYKCsurLtGA
         E54A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683711589; x=1686303589;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ckUkgH/LBnma6i9Vpo625SXqSP6maiHgE6xir4pKJms=;
        b=cQAQyE/lyh5JOLqe2KFLLHRriKPxHASULR2iap211Fkv1mIfdsgSCoreiNo/PWW/ZM
         ZeLIHNw/u6XEXNHw2OTjGFWaqg4TvyxKoD7WglUDPdFVNIodUWFnSjX7K6AKiZNYd2QL
         bgzXeR+kS6Uy5LN6uaupJjtBpXWU9sZnHLWSlZ39SxeWTryf4shpUWUi6qJ1LyVt/j9J
         vg4cqgHLM/CWlI8r2IcMRZFVsuwts0PRPdtCFeU8DeZ9XEP5fE+ubK4IIDNvboE447ST
         aTV3Wo6RK4X4x1Pz4m7/iY0ktNwQUwydTiRmSCey7cBPYB/xX4K1ROKMMIzTcZIQN7Df
         6vNQ==
X-Gm-Message-State: AC+VfDxJllXtnkhKKYT9Z4HO91+ImdN2DDqM+M2Lj1VwBiU0DyOp6duF
        Zzxvu6wvNdSk1xJKwakett4=
X-Google-Smtp-Source: ACHHUZ5h1CcuHuK9TqFByVj4+TJuybYkXRAb2fs0LdBAx6tO7lb8dtKMK754kG524icZ86ZmFh6e/A==
X-Received: by 2002:a05:6a21:9987:b0:102:1083:b4aa with SMTP id ve7-20020a056a21998700b001021083b4aamr3086031pzb.25.1683711589075;
        Wed, 10 May 2023 02:39:49 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-71.three.co.id. [180.214.232.71])
        by smtp.gmail.com with ESMTPSA id y14-20020a17090a784e00b00246b7b8b43asm3099735pjl.49.2023.05.10.02.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 02:39:48 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 9DCE0103AAB; Wed, 10 May 2023 16:39:43 +0700 (WIB)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Linux SCSI <linux-scsi@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kernel Janitors <kernel-janitors@vger.kernel.org>
Cc:     Oliver Neukum <oliver@neukum.org>, Ali Akcaagac <aliakc@web.de>,
        Jamie Lenehan <lenehan@twibble.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH v2 1/3] MAINTAINERS: Drop DC395x list and site
Date:   Wed, 10 May 2023 16:39:31 +0700
Message-Id: <20230510093933.19985-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230510093933.19985-1-bagasdotme@gmail.com>
References: <20230510093933.19985-1-bagasdotme@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=823; i=bagasdotme@gmail.com; h=from:subject; bh=Sn0BZ1jABONtyvPtSO4/uSeRQGjS1WJByjZ9y+aap0Q=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDCnRaaHrrmYb2P5RaVsWKBx55HR38UHhyplnZgdzdtQoc IQL/73XUcrCIMbFICumyDIpka/p9C4jkQvtax1h5rAygQxh4OIUgIlMvcXIcNJgvn/olRAFqaV/ bDfePM6VJRN5IvP5rvsT5jc8O7tvwRNGhodnTLM6RfsPfXBgvPW3amtOKedvcT3uM1Ixp4yToyU f8gEA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Emails to DC395x list bounce (550 error) and visiting the site returns
404 page.

Drop both twibble.org links. The driver should now be covered by
linux-scsi list.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 MAINTAINERS | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7e0b87d5aa2e57..ca88932ee04e2f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5716,10 +5716,7 @@ DC395x SCSI driver
 M:	Oliver Neukum <oliver@neukum.org>
 M:	Ali Akcaagac <aliakc@web.de>
 M:	Jamie Lenehan <lenehan@twibble.org>
-L:	dc395x@twibble.org
 S:	Maintained
-W:	http://twibble.org/dist/dc395x/
-W:	http://lists.twibble.org/mailman/listinfo/dc395x/
 F:	Documentation/scsi/dc395x.rst
 F:	drivers/scsi/dc395x.*
 
-- 
An old man doll... just what I always wanted! - Clara

