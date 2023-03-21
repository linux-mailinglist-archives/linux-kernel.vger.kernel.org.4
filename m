Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E11E6C3152
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 13:15:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbjCUMPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 08:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjCUMPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 08:15:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36E8C303EE
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 05:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679400855;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=MeqgjoxuzuKVfvN4kKyBkqoYwC4zvCCK7OH75FGIWlU=;
        b=grsgzSa4xvUInq6AHnKmUHoqxgRxC+jTQZ1kiuEswpmksVRlkjDyafCTPPfrDgzb7GOvI9
        OGq9ds1PhvS0/a9dqrvP6NcTeGsG/SYVPwc+ucjL6GwsUK1tqQUNVH0xNEAk2XDHaE+qBB
        gnkI1yd0In4gu0vtQMl80aj0yJA2MxM=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-283-uGWQS0m1PfeBdfZpOsrzEQ-1; Tue, 21 Mar 2023 08:14:14 -0400
X-MC-Unique: uGWQS0m1PfeBdfZpOsrzEQ-1
Received: by mail-qt1-f199.google.com with SMTP id h6-20020a05622a170600b003e22c6de617so3087221qtk.13
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 05:14:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679400854;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MeqgjoxuzuKVfvN4kKyBkqoYwC4zvCCK7OH75FGIWlU=;
        b=OZHM9564cHmxcoWWlv3rddzAAWD0mox+zZfjl9qdgoh3wZAfjZMektUavLXaPWqXGw
         v5+VvxJbkT+5JHa1F206921cEam1r/LQRgTnFYeIehxm7v0g30/sRMaDByJoBKj62TbD
         c+SwkxQPXA+4LE+6WXsuJISg2ebtjmETi5ScTYjmuXKwcgPBeTh+LUEk3rGbAhc4CkUA
         KxrHwPn9hZ5+hr1Ee5ZAUxNHJXbWTmVHTyDHGn7n7x3KNETNWO+kh7sJHFYbV1s6qv+z
         pTtTRy7IjsWlYMHRbskc81HJUMsyxuwCJfe3W50Eiam5HQZicz4Z/O8/2Mv/8Dt0sWhU
         Kj1Q==
X-Gm-Message-State: AO0yUKW0E+orduSmUVvUQw/1vANZjNf5f5J+BL9fElL+3fQ7sVE+n7XH
        3BbIw95fEL5ObqVfp6xTRLiJdLzk42LY50WOnGWkqHySbJy/oYvqVm2PF8NTw2pQOtMjcdM61QA
        Vwo8AAVbQ3lkAWyS7VK96GVN2ZrGJ7ZUz
X-Received: by 2002:a05:6214:194f:b0:571:428:73dc with SMTP id q15-20020a056214194f00b00571042873dcmr3855047qvk.34.1679400853996;
        Tue, 21 Mar 2023 05:14:13 -0700 (PDT)
X-Google-Smtp-Source: AK7set/d3J0U6kitajYIEj3ZmtdOs+/3zJa8HNAgthEmb+l3c5O1ncy7hAlyyZwyTIOqyZbkV1OzhA==
X-Received: by 2002:a05:6214:194f:b0:571:428:73dc with SMTP id q15-20020a056214194f00b00571042873dcmr3855016qvk.34.1679400853756;
        Tue, 21 Mar 2023 05:14:13 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id bk12-20020a05620a1a0c00b0074357a6529asm9225502qkb.105.2023.03.21.05.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 05:14:13 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     abbotti@mev.co.uk, hsweeten@visionengravers.com, nathan@kernel.org,
        ndesaulniers@google.com
Cc:     linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] comedi: remove unused dma_chain_flag_bits function
Date:   Tue, 21 Mar 2023 08:14:10 -0400
Message-Id: <20230321121410.1782901-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clang with W=1 reports
drivers/comedi/drivers/cb_pcidas64.c:377:28: error: unused function
  'dma_chain_flag_bits' [-Werror,-Wunused-function]
static inline unsigned int dma_chain_flag_bits(u16 prepost_bits)
                           ^
This function is not used, so remove it.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/comedi/drivers/cb_pcidas64.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/comedi/drivers/cb_pcidas64.c b/drivers/comedi/drivers/cb_pcidas64.c
index ca6038a25f26..59390b23fa81 100644
--- a/drivers/comedi/drivers/cb_pcidas64.c
+++ b/drivers/comedi/drivers/cb_pcidas64.c
@@ -374,11 +374,6 @@ static inline u16 pipe_full_bits(u16 hw_status_bits)
 	return (hw_status_bits >> 10) & 0x3;
 };
 
-static inline unsigned int dma_chain_flag_bits(u16 prepost_bits)
-{
-	return (prepost_bits >> 6) & 0x3;
-}
-
 static inline unsigned int adc_upper_read_ptr_code(u16 prepost_bits)
 {
 	return (prepost_bits >> 12) & 0x3;
-- 
2.27.0

