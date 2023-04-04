Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3B6A6D5699
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 04:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232850AbjDDCLt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 22:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232495AbjDDCLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 22:11:41 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53CDA2117
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 19:11:32 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-17e140619fdso32918915fac.11
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 19:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680574291;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SAtnFSIR+/OS+qrbUyEQ4DU0jPdfwFgu5KRD+/XnAQ4=;
        b=ZoEDhFx1W0nzm5d1EMlGE8ZCsQEYL0sV9inq+o5yrf+61SgKK5b1VADU6moRpAJmKG
         uFFAbv9cXB0I9rq0j7fEUJkDQmFhn9iZpRV8E1CTaxhemRCu7PkaF58LqB/g1+F8JNeR
         7m5j5lFrK2t4tC+c4+tBjiYdJJCTsGxQJizxdDdNPg+xAPuxlMdXL5Rf18oUn8KcEM7Q
         I7pywLMlX4lEjxhOkfGadw4VreBmskho3h9hZFjddI3AAiF7EutL2yQLfaqfWnL8MyE6
         A79/xt3wXsrFgeunn/+rr3evUqVXAnIdBJ8OJHoo6m83kUp1PVEa1I3UTgmfEN/W/Bub
         2/pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680574291;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SAtnFSIR+/OS+qrbUyEQ4DU0jPdfwFgu5KRD+/XnAQ4=;
        b=2iZxBMfyv4t5LUE7wWxiSeqBJOypkb2NTVh4wU5iKEu9fR4aYOCifFYFkgtwg8ckHV
         hPfjg2U/Gol15I6JywbG7XWJgaR8Baw9CIAEQQGLu8JNSh3UdBbQmEUQS0CmMD+/t9hs
         PWYoJtyf9JZYL533kuZqyRrQ883DeSWWnNc22oCdn60sCe5wgxsu6nSzPB7OH3tdrUVt
         LWEqyhqBaF7eaPMEEQhXQvfHTTrLHXJb4Q+j3EzMaa8wdSvmuLfcoAakiUYv7SW9+25c
         E6rvuy0ByBNKY94MX2sBmsfjCQZBlH4+K4hHyNqXMJG3uyXubxcKoZqiylTKG/WrVPEC
         jPWQ==
X-Gm-Message-State: AAQBX9cWsKgKgcXM4ashjbGrq5DR5MaQPnvSsTVC67xetauIoOxiA3ox
        gy+6zzQh0pMUWYkZoY9y8E0=
X-Google-Smtp-Source: AKy350YzSKpavzyHR/Ddvwqyh7RmUYYpnW6nNHtV84cTqFEcvowjv64joezbZ36XB4xkzMX/DlxbFQ==
X-Received: by 2002:a05:6870:6301:b0:17e:6eaa:945f with SMTP id s1-20020a056870630100b0017e6eaa945fmr776955oao.8.1680574291519;
        Mon, 03 Apr 2023 19:11:31 -0700 (PDT)
Received: from localhost ([12.97.180.36])
        by smtp.gmail.com with ESMTPSA id u1-20020a056830118100b0069fb749271bsm4932630otq.15.2023.04.03.19.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 19:11:30 -0700 (PDT)
Date:   Mon, 3 Apr 2023 19:11:29 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Ye Bin <yebin@huaweicloud.com>
Cc:     dennis@kernel.org, tj@kernel.org, cl@linux.com, linux-mm@kvack.org,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        linux-kernel@vger.kernel.org, dchinner@redhat.com,
        yebin10@huawei.com
Subject: Re: [PATCH 0/2] fix dying cpu compare race
Message-ID: <ZCuHUQYvvwUURSvz@yury-laptop>
References: <20230404014206.3752945-1-yebin@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230404014206.3752945-1-yebin@huaweicloud.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 04, 2023 at 09:42:04AM +0800, Ye Bin wrote:
> From: Ye Bin <yebin10@huawei.com>

Here should be a description of your series.
 
> Ye Bin (2):
>   cpu/hotplug: introduce 'num_dying_cpus' to get dying CPUs count
>   lib/percpu_counter: fix dying cpu compare race
> 
>  include/linux/cpumask.h | 20 ++++++++++++++++----
>  kernel/cpu.c            |  2 ++
>  lib/percpu_counter.c    | 11 ++++++++++-
>  3 files changed, 28 insertions(+), 5 deletions(-)
> 
> -- 
> 2.31.1
