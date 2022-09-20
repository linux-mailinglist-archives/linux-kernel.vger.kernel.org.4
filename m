Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 418125BEC72
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 19:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbiITR7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 13:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbiITR7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 13:59:00 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CEA5647FE
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 10:58:59 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-11e9a7135easo5374668fac.6
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 10:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=9ifI65Hcjk0ar/WNQwl170y/WKbWs7okCtxxCy/qE2s=;
        b=XKH6q98TKXBJ2o4JrzYanFRPybgTnKMI5lkc/YDkvCAcv049niXMJJ/MeErlhdukM4
         B9fKoe9cUSF0Fd3kyAzdxvuU30yEF/51WGP4ty6Xth76/2jmhIhqEq/D5BaxSuzvEDRD
         7ffUK0Jx/ENWTp7q8oDdRhnewhoRXD3Y5Vl8jPjqpHC1B+4M6IMeaXqZx6iae5mMcy2a
         BVat7mLBLXqG9ajL1ISrPdRV6+TtuZ+2jP9sOG0iTZMQ4upYWz+3Lf8vRZNKNwNZDdtv
         M/MddCftsymBQKqQe/NPz9VH5TewffG0Aj7TarXJYt5b08xquD4pk/z+lkWZBhQTvt8O
         Yqqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=9ifI65Hcjk0ar/WNQwl170y/WKbWs7okCtxxCy/qE2s=;
        b=UZqA4CkIjt44lgnAILC+UzP4ZbwDxDTcgeeAVYYs3UVvaLY6l1q+8EzTfKo/IesVfm
         DUBFK4xe64VaMeg873LqdxveZOLrIkCu6fzducnRR4bi5jteUevThcM/8pegMhFwMNaS
         Q4LcBP02vVZyzqEUskwyjp7mjdFtSBOaDG8nBlWxiDYcPTt/Q5SM1DzpNwjTrpLim2i0
         vwGVak/x2ciaFeCWUPx/1sNj0wsKqxW/XlNyOCXsoHoAR/uDK3/Nhax9pgetxXYgFks3
         SwouPFaHuyF6lNlZ5SgM12FxsA2yOLlEoKeYZnPQ5N3lH3wiz87Bwj04me5SKr1G2wvj
         oO9g==
X-Gm-Message-State: ACrzQf3AE1c5sSwYoX1mFyJ9R0k4v/sRFbRiIJnASQg4SNO3NcpH3xgN
        VDNY5VPCFoPQXZaZD9X8YV8geuR6AYY4hA8EiO46Di/sESw=
X-Google-Smtp-Source: AMsMyM4KjOL/xOAu/DOJeszQinNG7G5PzfuYqArkpO6R+/UtVWBwBDvPwY8i9UdwUuzkccz/QqzdIB/4gCYHbdyLHdo=
X-Received: by 2002:a05:6870:e99a:b0:12c:8a51:ba3f with SMTP id
 r26-20020a056870e99a00b0012c8a51ba3fmr2753078oao.276.1663696738482; Tue, 20
 Sep 2022 10:58:58 -0700 (PDT)
MIME-Version: 1.0
From:   Jaccon Bastiaansen <jaccon.bastiaansen@gmail.com>
Date:   Tue, 20 Sep 2022 19:58:48 +0200
Message-ID: <CAGzjT4fd3cGh0zKDLUxM4Rce2mh_R9cQcNunBz0iykVHsLAS5g@mail.gmail.com>
Subject: Repost: Clocksource: should the read() function of a clocksource be
 NMI safe?
To:     daniel.lezcano@linaro.org, Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

The ktime_get_*_fast_ns() functions in kernel/time/timekeeping.c are
listed as NMI safe.

If I am correct, the implementation of these functions uses the read()
function of the currently selected clocksource.

But a potential lockup can occur if this read() function uses a raw
spinlock. A running read() function can be interrupted by an NMI which
also calls the read() function. The NMI handler will then spin forever
in an attempt to lock an already locked raw spinlock.

Is my reasoning correct? Should the read() function of a clocksource
always be NMI safe? This requirement is not documented and I see that
several clocksource drivers (such as drivers/clocksource/i8253.c) are
not NMI safe (they lock a raw spinlock in their read() function).

Regards,
   Jaccon Bastiaansen
