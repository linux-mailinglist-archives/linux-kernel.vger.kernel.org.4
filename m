Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A484E5EAFBD
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 20:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbiIZSZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 14:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbiIZSZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 14:25:18 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 219355E335
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 11:23:13 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id x1-20020a17090ab00100b001fda21bbc90so13301927pjq.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 11:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=ZbRJ8mO2p4vx8AyTjHr+MwJ8AVi8WB920WfIqpKjyQw=;
        b=F7JV5x/0etVoVGG4rO8OrL84nTxFnDrGuT1q6LOVYhfZKjrDIeEub2gbhtzkVtHd4n
         wklDvq0dbdpz83B/AL021wZUdMCpXJ/2nhf6CBHIAVLdMJlJ2J1pNnqSE9cLMtQoaXuh
         enRpmU+RrZ2KQlbZvsVWaFBxccDvm0e99X088=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=ZbRJ8mO2p4vx8AyTjHr+MwJ8AVi8WB920WfIqpKjyQw=;
        b=3v2QIID1Llnt5DlDnFL0UrCDugZ4I7VpH/Hw04Nw8k1Ex9N72OXOxWzJqRjB3MKh+/
         JCE4ARjtQICIuVx6ZLh0WM36jzqm/M6+q9YL5meMaoT3Ikk40Cr/ysJaEP0BqMetF3rA
         GOyUry+rBxKPhQ4fttmAAuTaL83pY8Hf+/DGucEHaZHkFC4crwamu02LVvO6Bjty86fl
         GoHqH1VmwW4JgF16YWrnBSE/9KBV+9tWMpYOrlQBgBWzpi6yc3BtzY3UpXemfzlT+zHf
         k0SKTUk5fqdY4hBPCnVWOr3yI3fzVwSXy4k019VQuIZiGFM46BsmH/XkXwcgG4vJmqkl
         9sKQ==
X-Gm-Message-State: ACrzQf2jHvxm5ufrfx4MClGh3KQmfWWz/Au1ri/s9cEL4SWk9SJhclOJ
        Og9pZYjzI60djCsihpvHXVmdKQ==
X-Google-Smtp-Source: AMsMyM7cHLr6MN/ihVvR7ni/vtK2sXPKlCsxW2iE+njcokZhvd2+/CDvsgVcm6iCkHQY6DQjsUvnhA==
X-Received: by 2002:a17:902:bb98:b0:178:8e09:5675 with SMTP id m24-20020a170902bb9800b001788e095675mr23402986pls.91.1664216592557;
        Mon, 26 Sep 2022 11:23:12 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c37-20020a631c65000000b0043949b480a8sm10914556pgm.29.2022.09.26.11.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 11:23:11 -0700 (PDT)
Date:   Mon, 26 Sep 2022 11:23:11 -0700
From:   Kees Cook <keescook@chromium.org>
To:     andrey.konovalov@linux.dev
Cc:     Marco Elver <elver@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH mm v3] kasan: fix array-bounds warnings in tests
Message-ID: <202209261123.91B4E71B2F@keescook>
References: <e94399242d32e00bba6fd0d9ec4c897f188128e8.1664215688.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e94399242d32e00bba6fd0d9ec4c897f188128e8.1664215688.git.andreyknvl@google.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2022 at 08:08:47PM +0200, andrey.konovalov@linux.dev wrote:
> From: Andrey Konovalov <andreyknvl@google.com>
> 
> GCC's -Warray-bounds option detects out-of-bounds accesses to
> statically-sized allocations in krealloc out-of-bounds tests.
> 
> Use OPTIMIZER_HIDE_VAR to suppress the warning.
> 
> Also change kmalloc_memmove_invalid_size to use OPTIMIZER_HIDE_VAR
> instead of a volatile variable.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
