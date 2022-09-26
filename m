Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBEB85EA791
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 15:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234857AbiIZNoy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 09:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234295AbiIZNoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 09:44:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FEF31ED6FA
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 05:01:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D603AB80687
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 11:37:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FE9DC433B5
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 11:37:03 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Hwf952TM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1664192220;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0zXQQXhCqwhsaxCCEPdCRlZoB3PvoQf9Fi0hF1JYE9E=;
        b=Hwf952TMQ/d/IQyCcErjpTeYp/aueT0eDggn5AN9TEHFeV8gt3P+1dcMDJz6cE0DO+lcEJ
        stkD/9J4DVrg6FsnwWLU+GKfu64p1l6XcYDaTgg6d/6sS5sCddUh4G+9JJlzelxtMGvn8Z
        EqaMzVn18MMOHnpFZVvbpqWximA/y5I=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 0b926537 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Mon, 26 Sep 2022 11:36:59 +0000 (UTC)
Received: by mail-vs1-f52.google.com with SMTP id j7so6178967vsr.13
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 04:36:59 -0700 (PDT)
X-Gm-Message-State: ACrzQf147ZXCvGPS2PqNO9ZZk9FYj7L8NcCwn05PQhiNv71DtydSrlhb
        XawwtCIMjBuGvAHs9w0lyUcYZdYXMmP64/YjMdI=
X-Google-Smtp-Source: AMsMyM7AFryVAOqJzAt+m7xpXl8z6L1FZ1Ttvzd2rwSq5O9GzfWd23cBRh79WuhVVUkJEY8QBXprdxdYeak4WR1Ix7c=
X-Received: by 2002:a67:d81e:0:b0:398:2c98:229b with SMTP id
 e30-20020a67d81e000000b003982c98229bmr7963486vsj.73.1664192218723; Mon, 26
 Sep 2022 04:36:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220923170340.4099226-1-Jason@zx2c4.com> <20220923170340.4099226-3-Jason@zx2c4.com>
 <CAMuHMdXPcXq_F0dQdJ5nV2io1eDhJs7BZf+TmXWPqGVn9xeLNA@mail.gmail.com> <YzGIO4IK9WXFyXsD@zx2c4.com>
In-Reply-To: <YzGIO4IK9WXFyXsD@zx2c4.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 26 Sep 2022 13:36:47 +0200
X-Gmail-Original-Message-ID: <CAHmME9oTruc1eyBGGWmsGnnXOU1_xXi=MiM5V3fHTFBKCX30Mw@mail.gmail.com>
Message-ID: <CAHmME9oTruc1eyBGGWmsGnnXOU1_xXi=MiM5V3fHTFBKCX30Mw@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] m68k: rework BI_VIRT_RNG_SEED as BI_RNG_SEED
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Okay v4 on its way now. Also updating the qemu patch to fix the bug you found.
