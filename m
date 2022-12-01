Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89F9F63F1A2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 14:30:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbiLANaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 08:30:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231510AbiLANaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 08:30:08 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3912C7719
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 05:30:02 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id w15-20020a17090a380f00b0021873113cb4so2070727pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 05:30:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2kY3NLaWipR1zedC/jmsfnKKl0xpLan3rm6Eu7wqOeM=;
        b=ORSicg58a6hRLgdxRbMRDuxvOquEWrB/ZzoECxHiBMKGQef/ydZkd7joyUeUwrVnW3
         Jr624dd6wp4xhywKnm4W+RZ2GwBPEVRH7mWz3nipnDa4EOPImZ0Ur8AE6EtWgWRYTFpC
         SsBDiKs/ZcuyLXrf//RQzL8fTH0o03MVEkODE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2kY3NLaWipR1zedC/jmsfnKKl0xpLan3rm6Eu7wqOeM=;
        b=ow4LlaAdUhBP9yvmaDdY5vu/j2NhqM149b2exO4nSCaAitkLFARteXK4Uh/lLbHIAA
         pVYevyjIIigUa87xGb5SZdlZBZw0UTf1jt1lOWJUf2wUd6geoDuiZYbEqTsUCgKn44HC
         z11Qgc91P8BXt445+GMtlM6sVM527IMDvX7sXYv+soXCcPZfQScIw3CGczwdhm5fRbtX
         D4IW76pvtEWFwPZ0ZYa+teiP236dDgDExLxMeewc2qSBwyMdM3YUmWtoYPQE1g9RnMfH
         nBX2/odByiS22n9AaP1tAycuUOqWYUXvUmh84lBLXdoIIhbb9EckpgYL63ET2PwSONSh
         7gpA==
X-Gm-Message-State: ANoB5pkkjh8RCsv2hl9E4s5PEZhTqRYT6ubsDlxQHaNw/YobE6uHR+MJ
        tIMzHydzU3NtnS8JFr1y1cqxsQ==
X-Google-Smtp-Source: AA0mqf43wwjJ2cKJdTG97AELdC/uSnXM0EaKmCuZ0FZVEzuso8VgcRdHON+wr4QKXEfoHSZDl1LVaw==
X-Received: by 2002:a17:902:bd83:b0:17d:6603:8e45 with SMTP id q3-20020a170902bd8300b0017d66038e45mr51898303pls.173.1669901402494;
        Thu, 01 Dec 2022 05:30:02 -0800 (PST)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id z20-20020a63c054000000b00439c6a4e1ccsm2511231pgi.62.2022.12.01.05.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 05:30:01 -0800 (PST)
Date:   Thu, 1 Dec 2022 22:29:56 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Dmitry Rokosov <ddrokosov@sberdevices.ru>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Aleksey Romanov <AVRomanov@sberdevices.ru>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "ngupta@vflare.org" <ngupta@vflare.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>
Subject: Re: [RFC PATCH v1 0/4] Introduce merge identical pages mechanism
Message-ID: <Y4isVKvBoQs5vhFr@google.com>
References: <20221121190020.66548-1-avromanov@sberdevices.ru>
 <Y3vjQ7VJYUEWl2uc@cmpxchg.org>
 <Y3w7VP5CKvm6XmoJ@google.com>
 <Y3w8/q/HoSbqamoD@google.com>
 <20221122121413.ssieckg523urj37h@cab-wsm-0029881.lan>
 <Y32eA93V7w1Wu3VH@google.com>
 <20221123085306.52ozfjimaeikcbof@CAB-WSD-L081021>
 <20221201101417.f6qm4v3m7ibh3l72@CAB-WSD-L081021>
 <Y4iGOTRvAS+WRrtq@google.com>
 <20221201111448.oepcy6jh77sjx3rd@CAB-WSD-L081021>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221201111448.oepcy6jh77sjx3rd@CAB-WSD-L081021>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/12/01 14:14), Dmitry Rokosov wrote:
> 
> BTW, happy holidays :)

Happy holidays!
