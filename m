Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19A975B8B20
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 16:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbiINO4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 10:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbiINO4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 10:56:16 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1155E49B53
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 07:56:15 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id fs14so14829757pjb.5
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 07:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=f7yXjUA7o3c8RBibnft4MAssPXC05QvGTbOLihidnak=;
        b=f97fSdop1GdCMeRk+KPqvPwptkbR7Mxru4vJNdTWk/oqxY23Emavq++uOlXZx47GeK
         H+xkuxSsd2kYocY0QWdASef212IxlK4znIBxeZQNU3IJaChI9S+vZkXyvexO1wjhNXXk
         2MXNy8vbMHGjkxMieN8C1lrj9D3rFXhAkKtEM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=f7yXjUA7o3c8RBibnft4MAssPXC05QvGTbOLihidnak=;
        b=Wsah0vhuI1SHtbY2wT/LndCJaxpsdsdDC4wUDfhnjI02Hgzwh6AuWopSPR1sryJNHU
         vn6GuDjYFBN4u7CYQWp0MfjBpPUIA8UVS63P1OwlSbZWI444lkiDNixZ1H4Aurl/uXK5
         3DHjAJNxWc5oQa7414wl7zkhN5nZdBan4sQ1uvMGMq+8uNuVcbG7AugPPWJLomqcljGs
         iJeTp3i8iHxT9+bJOciMRHE3G7pC0lyQZ8ylKY38YwED0Z5de/RKWPs1RsTgcneoCtI1
         kblMrlVQmfjxi4KPC28xI+57RVwehyqeiueHmsDTWeCGkr5VE68B4IeAZnzDxa+/JAcc
         PbTA==
X-Gm-Message-State: ACrzQf1MrDWpfLxUz2NPvR26RV1qq626qgy08XJ30v1HfxX+JqlBCfC1
        BlA/vxn0UON2Yz3qPkJttgF+5Q==
X-Google-Smtp-Source: AMsMyM4vuzYdEH9GswpZayyb6NvNSCMQkjS1LTqVpg3sA8d6xfbaZf1TM61BYG2t+NbgAunli/5SZA==
X-Received: by 2002:a17:90b:30d0:b0:200:22a4:bfcf with SMTP id hi16-20020a17090b30d000b0020022a4bfcfmr5163344pjb.181.1663167374571;
        Wed, 14 Sep 2022 07:56:14 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:8201:ef09:d097:37b8])
        by smtp.gmail.com with ESMTPSA id b9-20020a170902d40900b0016bedcced2fsm10757325ple.35.2022.09.14.07.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 07:56:13 -0700 (PDT)
Date:   Wed, 14 Sep 2022 23:56:07 +0900
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
Subject: Re: [patch RFC 08/29] parisc: Put console abuse into one place
Message-ID: <YyHrh/pklxPRJq+2@google.com>
References: <20220910221947.171557773@linutronix.de>
 <20220910222300.846719466@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220910222300.846719466@linutronix.de>
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
> 
> PARISC has a hope based mechanism to restore consoles in case of a HPMC
> (machine check exception) which is scattered over several places.
> 
> Move it into one place to make further changes simpler and add comments.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
