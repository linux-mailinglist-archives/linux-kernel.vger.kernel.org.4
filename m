Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1739D619239
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 08:53:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbiKDHxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 03:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiKDHxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 03:53:19 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87F1D286F1
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 00:53:18 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id q71so3728246pgq.8
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 00:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zup+uRlcf7AhU3cAwCzxwDKZNLa4muKa6BvILHvv3H8=;
        b=IFZopsVsHu7I2P3qwC6/kTzZlyHHO5eGhZoRx365O/lkZJxLZjYZs0js6ZlWEFdlLB
         bYKyfPeH4sZuVDuob832AJop/6rEUcinrSQulCe7kEO3fPrjs3L4re19Vi0gwJmtW5pG
         Wz8wjX++FnnlNl80m2EGMTru3BfSwvlyT8GFY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zup+uRlcf7AhU3cAwCzxwDKZNLa4muKa6BvILHvv3H8=;
        b=ESTqS7BIOesDFiYbrtfR2riuGrLroiTUursB0HDdNyi5XLMnoFGl4BKUxCxiohEpaH
         Ow/zSUsDrjTh5w8l5CY7IeVWeC3cwCLfuxj5lIk6xSDJ+BkPe9RbePcTk9BtEyq/aBG5
         p8yZA8pJvnvGTzKXj+Zcq8/RGQ11bOERWbs5PvTX3WUxR4aT1YRoCm91/y1hFULPRCkZ
         hy4TFXR4GMt3WTZbDohebCirF+RKNLGqA1AQhK8xCD/TlRRnAIpGOTScynPFnYhdeWfT
         rbFJRFDjGbO81Dv1IIJmxpWftDl41qvOfqt/Gqms68C6MXWPHEf/gU96YJVUFWWXnszi
         CQYQ==
X-Gm-Message-State: ACrzQf2kJDVppWsTEKuZb+c96k/vjP4xtFxcXw9Sw49UJ2H7uthv3smI
        pwDvDIdZSCnSCdC7rGuubG+6yzyWxZ24rA==
X-Google-Smtp-Source: AMsMyM43KtChkf1aDRP4ODWe/7OB9VsNIWOVsZw/cipe1Yhe81tq2sk+ZvLsVyvbfq041q0AQDXBIw==
X-Received: by 2002:a63:4b5e:0:b0:470:5e7:b0d2 with SMTP id k30-20020a634b5e000000b0047005e7b0d2mr11587921pgl.189.1667548398082;
        Fri, 04 Nov 2022 00:53:18 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:f2f6:8f5:87c8:3aeb])
        by smtp.gmail.com with ESMTPSA id e18-20020a17090301d200b00177f25f8ab3sm1999081plh.89.2022.11.04.00.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 00:53:17 -0700 (PDT)
Date:   Fri, 4 Nov 2022 16:53:13 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCHv4 4/9] zram: Introduce recompress sysfs knob
Message-ID: <Y2TE6XSTkyXVF+kB@google.com>
References: <20221018045533.2396670-1-senozhatsky@chromium.org>
 <20221018045533.2396670-5-senozhatsky@chromium.org>
 <Y2Lbxp6to4QNYyGe@google.com>
 <Y2M0t5etyJiUfeQi@google.com>
 <Y2PzseskzPelrZum@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2PzseskzPelrZum@google.com>
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/11/03 10:00), Minchan Kim wrote:
> zram->table[index].flags
> 
> If we squeeze the algorithm index, we could work like this
> without ZRAM_RECOMP_SKIP.

Something like this?

Allocate two ->flags bits for priority and one bit for RECOMP_SKIP.
Two priority bits let us to have 3 alternative algorithms (01 10 11)
plus one default (00). So 4 in total.

---
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 12f03745baf9..af0ff58087ca 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -127,6 +127,19 @@ static size_t zram_get_obj_size(struct zram *zram, u32 index)
        return zram->table[index].flags & (BIT(ZRAM_FLAG_SHIFT) - 1);
 }
 
+static inline void zram_set_priority(struct zram *zram, u32 index, u32 prio)
+{
+       prio &= ZRAM_COMP_PRIORITY_MASK;
+       zram->table[index].flags &= (prio << ZRAM_COMP_PRIORITY_1);
+}
+
+static inline u32 zram_get_priority(struct zram *zram, u32 index)
+{
+       u32 prio = zram->table[index].flags;
+
+       return prio & ZRAM_COMP_PRIORITY_MASK;
+}
+
 static void zram_set_obj_size(struct zram *zram,
                                        u32 index, size_t size)
 {
diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
index bdfc9bf0bdd5..33e52c5a9a90 100644
--- a/drivers/block/zram/zram_drv.h
+++ b/drivers/block/zram/zram_drv.h
@@ -40,6 +40,8 @@
  */
 #define ZRAM_FLAG_SHIFT (PAGE_SHIFT + 1)
 
+#define ZRAM_COMP_PRIORITY_MASK  0x3
+
 /* Flags for zram pages (table[page_no].flags) */
 enum zram_pageflags {
        /* zram slot is locked */
@@ -49,8 +51,9 @@ enum zram_pageflags {
        ZRAM_UNDER_WB,  /* page is under writeback */
        ZRAM_HUGE,      /* Incompressible page */
        ZRAM_IDLE,      /* not accessed page since last idle marking */
-       ZRAM_RECOMP,    /* page was recompressed */
        ZRAM_RECOMP_SKIP, /* secondary algorithm cannot compress this page */
+       ZRAM_COMP_PRIORITY_1,
+       ZRAM_COMP_PRIORITY_2,
 
        __NR_ZRAM_PAGEFLAGS,
 };
