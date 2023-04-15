Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C221F6E2F65
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 08:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjDOG6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 02:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjDOG6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 02:58:16 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 643F64EDB
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 23:58:15 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id fw22-20020a17090b129600b00247255b2f40so6866944pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 23:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1681541895; x=1684133895;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZJQMIaZu4KVcFRqyZTsotNIVVhw2hXDbq0PaE5k6CMg=;
        b=DJTp27DRXu3cSNjNOHsuoOjhSlELOiYIcwVHA1eTlLS8S5lMEYniFpPJZQEBEs8lYN
         f9a0BJC2kf3QZlTj81I+BxreED+Whed476nADNd1dSwGemqCSKIRl7B1PtvvYbgg+wG8
         ImEzh6Yi9RTm3o5I8OXa2ygt7dYMz/HY4mkSM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681541895; x=1684133895;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZJQMIaZu4KVcFRqyZTsotNIVVhw2hXDbq0PaE5k6CMg=;
        b=ILTFPXHiIUIs/LAB3y9bzbpE0SuaQXWFh6s9ksxEtor3wWyMImB+RZ4MrZxVnVVCBL
         xU3jWXonnyxtLck+S9yYqtwvK3Wf6E4KdDUw4rijC9Vnmt5gjskspDugjb4F5WSwnXVp
         A3niZgHmhbhDZ6ttFLKosiZ4YLegjpUtxrMOYnjfyUJEpn2HXJgfA7vWZyEm82DrH8aV
         QLhiseDcpfmhc9B6aqrTNoPwVxlSbvlFdacEekKu1xI0fJYbNUY2ktwOubBgdsDj1g/J
         SsIXxn3+3E2hoqxPPwRhU1/WqMYuABL9b/VtWJ1TwoLMftNfYRRRNhIiIo6dywKQaEAw
         JiOw==
X-Gm-Message-State: AAQBX9e0e//vKVXuo78Hnod4qkYlFvsv3YTO/JyWT9t4H+C05sOD+AOA
        37uj2c7oFtc1WHPGq3si7fb6LQ==
X-Google-Smtp-Source: AKy350YKXKjSBv8sgeEJHGgGAEer1RxOLizjL29f5/0okJOICW7edttMb9+lDyUGRCyhbD8mhT6CSg==
X-Received: by 2002:a17:902:6944:b0:19e:e001:6a75 with SMTP id k4-20020a170902694400b0019ee0016a75mr5558903plt.6.1681541894865;
        Fri, 14 Apr 2023 23:58:14 -0700 (PDT)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id s14-20020a170902988e00b0019c93ee6902sm3989398plp.109.2023.04.14.23.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 23:58:14 -0700 (PDT)
Date:   Sat, 15 Apr 2023 15:58:08 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Pavankumar Kondeti <quic_pkondeti@quicinc.com>
Cc:     Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] printk: Export console trace point for
 kcsan/kasan/kfence/kmsan
Message-ID: <20230415065808.GI25053@google.com>
References: <20230413100859.1492323-1-quic_pkondeti@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230413100859.1492323-1-quic_pkondeti@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/04/13 15:38), Pavankumar Kondeti wrote:
> The console tracepoint is used by kcsan/kasan/kfence/kmsan test
> modules. Since this tracepoint is not exported, these modules iterate
> over all available tracepoints to find the console trace point.
> Export the trace point so that it can be directly used.
> 
> Signed-off-by: Pavankumar Kondeti <quic_pkondeti@quicinc.com>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org> # printk
