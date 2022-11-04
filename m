Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 344CE61919B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 08:12:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbiKDHMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 03:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbiKDHMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 03:12:19 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D48C1275FE
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 00:12:18 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id h14so3767781pjv.4
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 00:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ome+6eb1fVWp9/DjTZmKuTHrFooj0YZvMdCpPjHEIJc=;
        b=k6otuHVPS8vwU3tm2qAxRFT1CRJkVi3eHgQ/pHPA0maQR6mYzvNXtfuhFB5IMs3avo
         kFWGNdennNGcekOwssJvwFg+VLBHPTS+JLMLH6JhDrJ0xV0KVzfnxj8wNO8wTmw188Rx
         IZqgez1wxEP6nBXUCiGC1RpOaNGCbsEDyDLsY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ome+6eb1fVWp9/DjTZmKuTHrFooj0YZvMdCpPjHEIJc=;
        b=iWjQtVPKSDwbSqadDhwsBpePSFvXQbDqGIiSBcigxb8GKP2aGb0vuFDBYHTZGsFkfu
         A4h5hI5GYHOip23VBR+AoIY6pTpJPTx9nbqhqIcO2fK+BINGTpxpu5pGeQvEA/UBaUx2
         0IRbgrso54KKqZGVgKXC1cMWNybacsa5tCJCM1iM3aqJvUzbSCHw/bRDPDPwtr7x3BDu
         tdOUAh1mBQskzgbiZpFZaluBpi0XqyA2mKsORbEGQLJU8QQ9jzVSWVFUJvQJfGB9Qi9/
         tKWVMaofzWPwqYRIHpRXB9jpejxpwFQVJgIUwZOiVl82EKUYZQgPc3JXBcZkJUBl8+PH
         ilpw==
X-Gm-Message-State: ACrzQf1IjgMBK2RAbFUVaBMKDZZYZdPmUsG+Ze7mUCDpteh5c5aX68hD
        +w/ZKuNuob7reOvLMUW04d5odQ==
X-Google-Smtp-Source: AMsMyM59CqcWOHw0lngHLemoGGCLj787y/gNtbIUEMA/joNTAVddQiFiJ9LdLiRKiaVN5WZFm9jAmw==
X-Received: by 2002:a17:903:2352:b0:186:aaed:e7b8 with SMTP id c18-20020a170903235200b00186aaede7b8mr33495286plh.47.1667545938290;
        Fri, 04 Nov 2022 00:12:18 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:f2f6:8f5:87c8:3aeb])
        by smtp.gmail.com with ESMTPSA id r15-20020a635d0f000000b0046f59bef0c5sm1734679pgb.89.2022.11.04.00.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 00:12:17 -0700 (PDT)
Date:   Fri, 4 Nov 2022 16:12:13 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCHv4 4/9] zram: Introduce recompress sysfs knob
Message-ID: <Y2S7TWpx6UnQHsZ9@google.com>
References: <20221018045533.2396670-1-senozhatsky@chromium.org>
 <20221018045533.2396670-5-senozhatsky@chromium.org>
 <Y2Lbxp6to4QNYyGe@google.com>
 <Y2M0t5etyJiUfeQi@google.com>
 <Y2PzseskzPelrZum@google.com>
 <Y2SLmuxLy8tf1X9m@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2SLmuxLy8tf1X9m@google.com>
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/11/04 12:48), Sergey Senozhatsky wrote:
> > read_block_state
> >     zram_algo_idx(zram, index) > 0 ? 'r' : '.');
> > 
> > zram_read_from_zpool
> >     if (zram_algo_idx(zram, idx) != 0)
> >         idx = 1;
> 
> As an idea, maybe we can store everything re-compression related
> in a dedicated meta field? SKIP flag, algorithm ID, etc.

That's just an idea.

Something like this

---
diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
index bdfc9bf0bdd5..c011d0f145f6 100644
--- a/drivers/block/zram/zram_drv.h
+++ b/drivers/block/zram/zram_drv.h
@@ -49,8 +49,6 @@ enum zram_pageflags {
        ZRAM_UNDER_WB,  /* page is under writeback */
        ZRAM_HUGE,      /* Incompressible page */
        ZRAM_IDLE,      /* not accessed page since last idle marking */
-       ZRAM_RECOMP,    /* page was recompressed */
-       ZRAM_RECOMP_SKIP, /* secondary algorithm cannot compress this page */
 
        __NR_ZRAM_PAGEFLAGS,
 };
@@ -64,6 +62,11 @@ struct zram_table_entry {
                unsigned long element;
        };
        unsigned long flags;
+#ifdef CONFIG_ZRAM_MULTI_COMP
+       unsigned int incompressible:1;
+       unsigned int priority:2;
+#endif
+
 #ifdef CONFIG_ZRAM_MEMORY_TRACKING
        ktime_t ac_time;
 #endif
---

The reason I'm thinking about it is that we have flags bits that are
used only when particular .config options are enabled. Without those
options we just waste bits.

Recompression is one such thing. Another one is writeback.

---
diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
index c011d0f145f6..7076ec209e79 100644
--- a/drivers/block/zram/zram_drv.h
+++ b/drivers/block/zram/zram_drv.h
@@ -45,8 +45,6 @@ enum zram_pageflags {
        /* zram slot is locked */
        ZRAM_LOCK = ZRAM_FLAG_SHIFT,
        ZRAM_SAME,      /* Page consists the same element */
-       ZRAM_WB,        /* page is stored on backing_device */
-       ZRAM_UNDER_WB,  /* page is under writeback */
        ZRAM_HUGE,      /* Incompressible page */
        ZRAM_IDLE,      /* not accessed page since last idle marking */
 
@@ -68,6 +66,8 @@ struct zram_table_entry {
 #endif
 
 #ifdef CONFIG_ZRAM_MEMORY_TRACKING
+       unsigned int under_writeback:1;
+       unsigned int written_back:1;
        ktime_t ac_time;
 #endif
 };
---

So we can use ->flags only for things that are independent of .config
