Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBF2963E27A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 22:07:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbiK3VHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 16:07:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbiK3VG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 16:06:59 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A402862CB
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 13:06:58 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id l22-20020a17090a3f1600b00212fbbcfb78so3177304pjc.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 13:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ra/gOzDNFG0eeALE33ZJcJC4OwrLB1F+C50L6Bg9NsY=;
        b=IWsyTZOMah093ZX+ocqvvaw/wSZFlYoA0Dfkn6U7CeDM4Hwgshj91iG6YULchp8UT9
         imDzV5l1WznZeU+LlGYxlaBvkm+sHdJzHGwDEQiPs/tpQET9GxL0+32R/ahLwiYdCYxQ
         bIgQSO7oqcEwf59D+YOEZA/OmvCuB/68hjZsc6ZeyOGi67OgenU1mT9sFXerPyki978I
         wXHgOqn2D34Wus26ZOgNpnFsBaD1T5tyExMcpy9e8px1GDUkxM0i6h3agNHJjPJjrq77
         vkfd1TXakTGvMM5xn3VjHx4wt85GxdK2hiuau3784fX2sUGSkWaune5yyRxkROYltfW9
         YbGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ra/gOzDNFG0eeALE33ZJcJC4OwrLB1F+C50L6Bg9NsY=;
        b=ah8dkZJBbeRIRwAXvdpv12wz8BwJutcNwlW/scBlI0XTV4hOn8Qv5wlsJNs83BJuoQ
         xPK4TISAx5r4RmFEoq+WFFdhadZpWuMVThq+5hrpVVDT/pb0yTEppN/C+WTtOyQ1PHv4
         bCC021wR3dV6UYIrBIJrhewVK6gEUZAJJMH/nk+VahcDrLTibFEtA1/nG/d1wCNw2O5T
         fH9DrHj6PL1oszh8sjFVejB+8ibmJda5tnDkyJp/MKnSPCQk1323EgjQ0Hd67gg7gYHQ
         Lr4qrrQv3XWaAsd+g8ySHdoPlghXIMFolKfoEPYcX7pgB6Rk1+khCkg4rmLsrRcYRS1m
         KN1A==
X-Gm-Message-State: ANoB5pmfViUhkrPoqGrtP7f/ouVAvW82tqLm8EMFlg6+ZgG8Bj/hXdx2
        81C3bRgEJ0wRwnmi8CBiMhTTSU0+orLDYQ==
X-Google-Smtp-Source: AA0mqf5IgUBN4jInv+Q01bWY+W/A81kK9HdwLRJHVzsWv7G7shhCaXxptOlua8Q0mruAcElLMtXrCg==
X-Received: by 2002:a17:902:7d93:b0:186:9cf4:e53b with SMTP id a19-20020a1709027d9300b001869cf4e53bmr48114816plm.50.1669842417581;
        Wed, 30 Nov 2022 13:06:57 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id pl11-20020a17090b268b00b001faafa42a9esm1671627pjb.26.2022.11.30.13.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 13:06:57 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 30 Nov 2022 11:06:55 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Phil Auld <pauld@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH v6 0/4] workqueue: destroy_worker() vs isolated CPUs
Message-ID: <Y4fF7/CtH+sq4KqC@slm.duckdns.org>
References: <20221128183109.446754-1-vschneid@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221128183109.446754-1-vschneid@redhat.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

So, this generally looks great to me. Lai, what do you think?

Thanks.

-- 
tejun
