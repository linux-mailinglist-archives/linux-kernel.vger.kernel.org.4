Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0DB569CB8E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 14:03:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232023AbjBTNDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 08:03:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232186AbjBTNDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 08:03:03 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2075559C6
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 05:02:59 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id g1so4157165edz.7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 05:02:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=omN2dnLSVe9aABOg/lBEWYbyUhDj383CyEPYnU3/aZ0=;
        b=fGcC2Kjp5QZF80tDjhQDwMjLJGR/9lmGa60T8djqUNxQLBc6p1zPin0xx70601gTaw
         QHLaybuQbuQfPrSoo+x30davvcxGBKlGoJxFduvIGOeyjbiQS+l28LCysr0eJFNW0uyq
         P86S2wjScq5EyViaKdIzPN/eb/zobhEG5XHsnDaCdKY7SSZ6500j5qeGWIIR0+isCrhF
         bSRDbqFEnJ1EeU4sSrLD4RRVjzjM0JPyV2lCFLAj3nSXaSfvAkDAusEpLjbRP7mgyx/P
         +iOWx8EFW7G/LEs/lQ0v+WJOSGCl6+cFlbh4xh71WcKutCYDx36qiIouFdv3O/fBe1A4
         QaYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=omN2dnLSVe9aABOg/lBEWYbyUhDj383CyEPYnU3/aZ0=;
        b=MJUyFpTU8wdbdlesJIqw2ecIXDzsAJXld0pysXKyT1FkZJqma5d0KFTHNftvZdOlOE
         FrbAarghM6AeiH4o48dykOlTVq+a+eJRsOHKzJjz1h/2PKxfkQIpA8q+VCMoKWYQY/mU
         Jy6iu7YuRGZbV3yatUL0Eyll1TM4cNumnjJhQOp9MyoL3MUMBV3r+Pqa5Peim/ih9Tla
         wb8+TE2GMr12ZBFq/cgM4gO21jACv6hpiIyyrH+6AXRycjKmB4uWPrDoJ+PlcNuSZRbT
         jhX6OKYMuzEmjPJ/AfCoHt+5Xe0lIZgOzTncnmKp26ZW0KHn+XElXtWgucaQe1r1sffJ
         BWgg==
X-Gm-Message-State: AO0yUKWM8RfLj3cyFY4eH3Cl47K4/9loGvGQnI8RQ3OeHuHyC46otqai
        gd946y0ijlHbjA4FiKbm0Q4=
X-Google-Smtp-Source: AK7set8S9YUWsbk0FJBnT1JqGWGfoIrm7UPqiOpOXv8mWju2krRJD+tJwLBpOWQT7qA2lxm3nC4YnA==
X-Received: by 2002:a17:907:7288:b0:8bd:dc0:3834 with SMTP id dt8-20020a170907728800b008bd0dc03834mr9618676ejc.34.1676898178000;
        Mon, 20 Feb 2023 05:02:58 -0800 (PST)
Received: from gmail.com (1F2EF163.nat.pool.telekom.hu. [31.46.241.99])
        by smtp.gmail.com with ESMTPSA id kw24-20020a170907771800b008cd1f773754sm1858919ejc.5.2023.02.20.05.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 05:02:57 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Mon, 20 Feb 2023 14:02:55 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86/asm changes for v6.3
Message-ID: <Y/Nvf+xayGNkhaOd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86/asm git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-asm-2023-02-20

   # HEAD: 65c24d7b0f9142c6acc9bd6dabeba22767077681 x86/lib: Fix compiler and kernel-doc warnings

Header fixes and a DocBook fix.

 Thanks,

	Ingo

------------------>
Anuradha Weeraman (2):
      x86/lib: Include <asm/misc.h> to fix a missing prototypes warning at build time
      x86/lib: Fix compiler and kernel-doc warnings


 arch/x86/lib/cmdline.c | 4 +++-
 arch/x86/lib/misc.c    | 2 ++
 2 files changed, 5 insertions(+), 1 deletion(-)
