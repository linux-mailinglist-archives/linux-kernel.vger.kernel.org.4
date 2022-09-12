Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 067975B5CB5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 16:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbiILOvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 10:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230082AbiILOvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 10:51:49 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8605A1837C
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 07:51:48 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id p1-20020a17090a2d8100b0020040a3f75eso8405789pjd.4
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 07:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=LgLrA8w4lGgdiykWREg3/XrG7vTO7+v/5c4/2rZWRK8=;
        b=BN9Fko/7dUCTZ9hU/AQNESgmelgC6IuQ2JYDoDcxOsOI4M/AQUbxXNOIwHQrlqnEjX
         BEeSdDLBVX+RXncPsVDytvvUT74IzgXKGFi7EcM8Tc91HqWGOLOfJIBN5b2IS8C3KNDr
         93CTgTluUZgdrwebpYtzfbXv4SJz+uanyyYhA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=LgLrA8w4lGgdiykWREg3/XrG7vTO7+v/5c4/2rZWRK8=;
        b=42YjWzG7pQVoQ47fZRKJx3vtsLKfH2nezIE/6glCRXoH9jiSdLVWFMP0XrS6clvhIR
         fiZj7xSJj8bcO1NKAPZSdR3dbM44NH1OvI2PKeXaefSxWESTCOAYBmknaNzinky3blIe
         IuydVQNxk3o+vnh8o2H07+J/QvVlGIJGPliuHf5FTrcokxWwPW7l8x02S/mUBN4yPT7N
         9wMscdlCUI61Kryy23pSk8HrjnkgrdsEtX353Y/3jg+Fi+5c3ZJ7VJKwx/TFM6XB9e6y
         Y8kCWNLb+90v6ACDCJF3fJVWH+RYL+5JJ1CMJ0T2nZrOUWP7ZjcsrKayB4BRJ6b1SI4G
         +N6Q==
X-Gm-Message-State: ACgBeo1SuFiTcSVB1sWLFNln9NmdP4SuIQRXMD+yWZ+1yzDoN3TEsI2C
        qLGXm6jt3a95OiZxQ4E3vJczag==
X-Google-Smtp-Source: AA6agR5b/y7dalrpDcvsskkc5HQXP7heua38BHRB+7iUY+5gwN7ebjn5H1kofu5KiUED5Cn7EQxgtw==
X-Received: by 2002:a17:902:f541:b0:176:e8f1:cd57 with SMTP id h1-20020a170902f54100b00176e8f1cd57mr25894799plf.8.1662994308064;
        Mon, 12 Sep 2022 07:51:48 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:481a:bead:f512:e554])
        by smtp.gmail.com with ESMTPSA id m20-20020a170902c45400b0016d72804664sm6032114plm.205.2022.09.12.07.51.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 07:51:47 -0700 (PDT)
Date:   Mon, 12 Sep 2022 23:51:42 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Brian Geffon <bgeffon@google.com>, Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Nitin Gupta <ngupta@vflare.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH] zram: do not waste zram_table_entry flags bits
Message-ID: <Yx9HfpsJ3JJZLJJ9@google.com>
References: <20220912053755.156704-1-senozhatsky@chromium.org>
 <CADyq12yWFMyTRCQmmGoLg7epvXRWu-XqKMS4N2vEomvvuWNpBA@mail.gmail.com>
 <Yx9EMhwLXnDYlQwd@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yx9EMhwLXnDYlQwd@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/09/12 23:37), Sergey Senozhatsky wrote:
> > > -#define ZRAM_FLAG_SHIFT 24
> > > +#define ZRAM_FLAG_SHIFT (PAGE_SHIFT + 1)
> > 
> > Why not just hard code 16 with an explanation that it cannot be
> > increased further using the analysis you did in the other thread? It's
> > going to be tricky to reason about how many free flag bits actually
> > remain with PAGE_SHIFT across all architectures, especially given we
> > have no architecture specific flags.
> 
> Well, zram should not make any assumptions on arch code. How do
> we know that PAGE_SHIFT 16 is the max value we will ever have?
> Some arch can come around someday and use PAGE_SHIFT say, 18,
> and we won't be aware of it (using hardcoded value of 16) until
> someone hits a really hard to debug problem in zram.

And I'd probably also add something like this, to keep us alert should
we run out of bits in the future:

---

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index f3948abce2f7..07913bcdb5c2 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -2449,6 +2449,8 @@ static int __init zram_init(void)
 {
        int ret;
 
+       BUILD_BUG_ON(__NR_ZRAM_PAGEFLAGS > BITS_PER_LONG);
+
        ret = cpuhp_setup_state_multi(CPUHP_ZCOMP_PREPARE, "block/zram:prepare",
                                      zcomp_cpu_up_prepare, zcomp_cpu_dead);
        if (ret < 0)
