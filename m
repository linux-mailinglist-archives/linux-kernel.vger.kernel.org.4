Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22ABA5B874D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 13:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbiINLd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 07:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiINLd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 07:33:26 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 350B0796AC
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 04:33:26 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id s18so8885660plr.4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 04:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=gS8azrHSw5cgE5XIQ69TufFsmNMPVrJN1hbHC/2+Sw8=;
        b=b6tXjno+mMOBvU/isCOEZ7b/o8PYetINlqjYchqGzbzAwZ11YE9P0b5nByQ8y4vMO5
         RfquN2KgG/NMnQIVO33B57/DeCANhnjF8BY0SECG9xrYKDuoGq0EK15y90GvAzLgFJ7f
         DEipuqMM4dQhufaD/RxNd+yYfUMLNspxrq2Ls=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=gS8azrHSw5cgE5XIQ69TufFsmNMPVrJN1hbHC/2+Sw8=;
        b=6INGb2YeTcHRaykv7z63W6cwXzelBJ3mJvmiHE26jP3mccySoL4px7NNIosipEBiC0
         B72xbGemZ9Zqfb3SRZ/0AyytG0gbTmhvc4PYxDvgohzvy3QMiFtoo8rkV0qEdxy/Dyi8
         /E9RYMEkRodU5/T+h5Tcdys7KrIoyCWBeRDMVj3uuQTejdJfshXLXDUfsTelGquIXUhg
         yUsmJ/uR7ZbruLkg282l9TSnlua6Ly8TAHE8Pc1JLvA7fXObqyWQmMjrsZqPuLSI4VG0
         qINldGo2TtQyGUhkeEBF1Njcqt22jQrn7cNFSQGNE7I4FvKOgz/YUI+NhubiAw8sVhbf
         VKFQ==
X-Gm-Message-State: ACrzQf2TzrOPl3gs4ZgBBRiRsm/S5CD3nMS3PhbwVMQOLTbrYiRBrGdY
        LKWegDmRYYxYt1dSX/UVzB5dvQ==
X-Google-Smtp-Source: AMsMyM5MvHvT7xmd2Z1YRLBfreKZ3xxqRq3hBpJbdqQqbLF3Zh7DkompjbKmNCmPLDER/H0gN75GrA==
X-Received: by 2002:a17:90a:7e08:b0:200:7cd8:32f6 with SMTP id i8-20020a17090a7e0800b002007cd832f6mr4257908pjl.96.1663155205789;
        Wed, 14 Sep 2022 04:33:25 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:e5f0:cfaf:bc8c:558e])
        by smtp.gmail.com with ESMTPSA id i7-20020a17090332c700b00177e263303dsm9468791plr.183.2022.09.14.04.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 04:33:25 -0700 (PDT)
Date:   Wed, 14 Sep 2022 20:33:18 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helge Deller <deller@gmx.de>,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
Subject: Re: [patch RFC 03/29] printk: Remove write only variable
 nr_ext_console_drivers
Message-ID: <YyG7/h3xlZz+Zj9T@google.com>
References: <20220910221947.171557773@linutronix.de>
 <20220910222300.524466942@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220910222300.524466942@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/09/11 00:27), Thomas Gleixner wrote:
> Subject: [patch RFC 03/29] printk: Remove write only variable
>  nr_ext_console_drivers
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
