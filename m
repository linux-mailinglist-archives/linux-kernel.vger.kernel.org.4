Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 938A9634249
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 18:15:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233204AbiKVRPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 12:15:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232852AbiKVRPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 12:15:46 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0316C73BB7
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 09:15:45 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id c203so14945875pfc.11
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 09:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I8wkkRX69sIhIBAwNUmzVRDA4iCA+IYX3ihJPlLDEDc=;
        b=jX31Z4RI+TO1Xz7qsX4BnOuS8u0xKdw2IJRFFGNHToCfHTilU0Iw4KUt74bGooIHwN
         iRdiwrjXrSJlAVAG+CLOxIZxYpqlZf+hlwjU3azZinH9f6PXMfgy2kHyRqWK/eVac0oy
         DT+tCmfduxVlrmEdJ6qoHd1VwJFO/Y6D5aFqE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I8wkkRX69sIhIBAwNUmzVRDA4iCA+IYX3ihJPlLDEDc=;
        b=CC1q3nHJGFwtDFkzFw83XFaptJeXFTuSq7rwVnWUvkVjkLd7xNcqiTy8s9PbKDeSaD
         N/PRt38QyDYcjSS5I8p3RlMZh4LeTX/sTELCU5L4UuHgJp8VB1zCkxgInuUE9NDMPzAq
         anQCyuslyTw0ukmpJReenhKHxk1+Aq/Cw4F/8CbW6SNNpmeF1w6rmiLnh1zzyc/NJWwn
         OLDMzl34c4ujrXLxpUn4pyviC7n9wOc2d+gPjBLImpIUJrzPp+PDMlDmtYukUnPVRhjI
         P0MKFEZ83u+t1bBVEAEztvvnTEe3QC1BV17e4o4BrfHqeA4FK95S87GC991y6QTB+bLN
         InVQ==
X-Gm-Message-State: ANoB5pkZO2C57Zhys/w637e6aqLqrRgIAexf3WB6hdQHXt6C72M0G1VK
        dG/oBCM47wvrZya4Bw7PIUHRbvL9KRO8K0xX
X-Google-Smtp-Source: AA0mqf76gUnvS8cwGVI6O3/C6486f2ZlsvPjvsTtc/YWs8NCGWYMza4GxvMBdAs79DkXIEsWDTjxOw==
X-Received: by 2002:a63:f012:0:b0:477:b658:c2ea with SMTP id k18-20020a63f012000000b00477b658c2eamr688956pgh.598.1669137344396;
        Tue, 22 Nov 2022 09:15:44 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d12-20020a170902654c00b00168dadc7354sm7709131pln.78.2022.11.22.09.15.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 09:15:43 -0800 (PST)
Date:   Tue, 22 Nov 2022 09:15:42 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Petr Skocik <pskocik@gmail.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Marco Elver <elver@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/1] *** Fix kill(-1,s) returning 0 on 0 kills ***
Message-ID: <202211220913.AF86992@keescook>
References: <20221122161240.137570-1-pskocik@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221122161240.137570-1-pskocik@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2022 at 05:12:40PM +0100, Petr Skocik wrote:
> Hi. I've never sent a kernel patch before but this one seemed trivial,
> so I thought I'd give it a shot.
> 
> My issue: kill(-1,s) on Linux doesn't return -ESCHR when it has nothing
> to kill.

It looks like LTP already tests for this, and gets -ESRCH?
https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/containers/pidns/pidns10.c

Does it still pass with your change?

-- 
Kees Cook
