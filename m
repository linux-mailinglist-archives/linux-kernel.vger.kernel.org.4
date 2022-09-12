Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFA875B534F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 06:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbiILEhY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 00:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiILEhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 00:37:22 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 872601B788
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 21:37:21 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id m10-20020a17090a730a00b001fa986fd8eeso11187573pjk.0
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 21:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=cWYgHAq5ny4DLQrfpTw7PtOGqiMCf0iPFjcOwcgSxlU=;
        b=Crz6FiphaYqTlC2dMlFPl+GwYjNz2ePWhRHPifOOZt/mZkbMeSoz4MuYTmF5cUoQNV
         Ib2DdBKuxKpN4/oSzh9rMu7CwmDjxWe16386T+j6dS3h7wVp0ozBwsgrxdCGHUnw0Xsh
         r/dfL1YnFAUl4FJS9gBZ8KLZgjLfg5gVm+e1s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=cWYgHAq5ny4DLQrfpTw7PtOGqiMCf0iPFjcOwcgSxlU=;
        b=cW0cFiEBAKw6aRzZmTMt4Q+RNHflwmXuXO3eTD1uFPo7peDd54t6rwj6cBwsMdP6Rf
         nlqC77ZwyopUbb3pH7W6z2B5U0RmzLSRiYaaU2eIjKxVxAO2+linIU7GoaFy3oN3Nd1Z
         R2F5ICNRJGwzGa+GXmPyPbFu/Pqj0mwVh0eSk8aVmhJMmfGH9tfUve81Hzte/59mv3dx
         ho4mDNlznws/3LhmrlM7Z4liNhrKIL9edaOV7HwsUMIPjuFGV7a1aLDB/LoY8RDlp00l
         nK4o0iZAFWbjbVRRthzc/VOIT881xSXMGd3lqdSuRYyG0mdfZPwI1qc0mGSdPo28ce/d
         qa2w==
X-Gm-Message-State: ACgBeo2yaxyxN1ZNfFwK9Iu4x1chAxoQU7WZaUDoDCN222PenqvwIVWG
        S/O8s0JcRUeXqyw0q+HoAMirQw==
X-Google-Smtp-Source: AA6agR4KogsmNIRLD4nHdnmzTog+YMrXg3rCn64hzFxSQEP2+xciQ+EsdoGOUp+jKcNUtuqQoUTISg==
X-Received: by 2002:a17:902:a388:b0:176:e571:4923 with SMTP id x8-20020a170902a38800b00176e5714923mr24847717pla.6.1662957441064;
        Sun, 11 Sep 2022 21:37:21 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:7b09:9fce:b16b:c111])
        by smtp.gmail.com with ESMTPSA id 11-20020a63040b000000b004347838b12bsm4431251pge.75.2022.09.11.21.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 21:37:20 -0700 (PDT)
Date:   Mon, 12 Sep 2022 13:37:15 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Brian Geffon <bgeffon@google.com>, Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        Suleiman Souhlal <suleiman@google.com>,
        Rom Lemarchand <romlem@google.com>, linux-mm@kvack.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [RESEND RFC] zram: Allow rw_page when page isn't written back.
Message-ID: <Yx63e2lxNmEB3UhE@google.com>
References: <20220908125037.1119114-1-bgeffon@google.com>
 <Yxr5oNaCwjn8cdFF@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yxr5oNaCwjn8cdFF@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/09/09 17:30), Sergey Senozhatsky wrote:
> > +++ b/drivers/block/zram/zram_drv.h
> > @@ -50,6 +50,7 @@ enum zram_pageflags {
> >  	ZRAM_UNDER_WB,	/* page is under writeback */
> >  	ZRAM_HUGE,	/* Incompressible page */
> >  	ZRAM_IDLE,	/* not accessed page since last idle marking */
> > +	ZRAM_NO_WB,	/* Do not allow page to be written back */
> >  
> >  	__NR_ZRAM_PAGEFLAGS,
> >  };
> 
> Unrelated but somehow related.
> 
> I wonder if it's time for us to introduce a dedicated, say u16,
> flags member to struct zram_table_entry. Unless my calculations
> are extremely wrong, we are about to run out of spare bits in
> zram_table_entry::flags on 32-bit systems.

Looking at it more - I wonder why do we define ZRAM_FLAG_SHIFT
as 24? This is far more than maximum zram object size. Our max
size needs PAGE_SHIFT bits (which is normally 12 bits, can be up
to 16 (for 64k arm64 pages)). So we probably can start defining
ZRAM_FLAG_SHIFT as (PAGE_SHIFT + 1).

Or am I missing something?

---

diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
index b4eecef2a11f..cb8f1f644baf 100644
--- a/drivers/block/zram/zram_drv.h
+++ b/drivers/block/zram/zram_drv.h
@@ -39,7 +39,7 @@
  * The lower ZRAM_FLAG_SHIFT bits is for object size (excluding header),
  * the higher bits is for zram_pageflags.
  */
-#define ZRAM_FLAG_SHIFT 24
+#define ZRAM_FLAG_SHIFT (PAGE_SHIFT + 1)

 /* Flags for zram pages (table[page_no].flags) */
 enum zram_pageflags {
