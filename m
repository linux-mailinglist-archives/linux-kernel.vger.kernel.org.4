Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A280C73021C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 16:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244741AbjFNOiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 10:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244810AbjFNOiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 10:38:10 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91580170E
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 07:38:09 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-57016aa67a8so4167317b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 07:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1686753488; x=1689345488;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4rsUwqp5Xyvu1hFuxKRFukI/DHyQglSKB0JsgWw+2yA=;
        b=ORtjq9TSEY/Vi7imgtZrw9bTnaAYew9FiATPBbQFCVc9vT6QMoO9dlzJzM04dLUsJI
         ml1xR0EQAcSO5R2+QnN3xR9NVxWEkXTM9Y6OvNrIs/5FDMIzr8R+pPQszcR956k4+gUa
         UmO/Z3GN1zbdsL0FEMkLJrrE+EjjIuTg97ZoXUolE+Ud+aJbcCiyFJBQNkGzggPublx5
         AMZQHySHIs2ZPleJ0ZMNzGdgC/v5fAz0C2/cHCfmhSCZBHbdfXfb3iqXoz7zsRnfZpr0
         gZnURuCE7FSR8Gu+lGJxi0VSU60L/pOQSPfQFY4Mr7JqCxEz1cYG0HKyKWNkVC4LTkJB
         Sagw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686753488; x=1689345488;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4rsUwqp5Xyvu1hFuxKRFukI/DHyQglSKB0JsgWw+2yA=;
        b=jKxPhgYSzvnPCjmhNrZt4uJTMjx6Z4YKKmfmoADw46B5umKkUHRq7WN7CDUqRpWUKf
         xogDZCM2+a1/evDg7qMGVBZj5FyVnQ5w7Vpyb20kL2s/gIQnbPs8gahIhyEAXjVxUcOc
         wx7EEACYTFq3nyzBEgKPiyvUlZTK8Im7mM41LZSKbXFU4q/FhKDEa4Pch0ogPOYYqjTv
         Xfy+EvKnrKYqcNqGmPQHG9KtOe2i5Vmh9segZ9UcRwHFawn0NkJMRzPzSwmkJgd6S0h+
         QLBTyRwIIRRicw13DK/fDzXTNGFZXxtPrRM18mxoo+taP0okweZDU4//nGW42W8nPEnM
         8ZAA==
X-Gm-Message-State: AC+VfDxJWWEyw1DFUAYXDPUHWMp6O5ARBKR9xENngcf64FPaa2+y8uIl
        KxVdjkWPoT74rI/DOiWAdq6rqg==
X-Google-Smtp-Source: ACHHUZ5LVupodK5eTAShM3x3z158nEPjvXDWDe0IIpwcKBw2RqV5qx2A4Z+sfYkCsE1M/c8AEn1Oug==
X-Received: by 2002:a81:5dd7:0:b0:568:a85f:80c1 with SMTP id r206-20020a815dd7000000b00568a85f80c1mr1826057ywb.39.1686753488665;
        Wed, 14 Jun 2023 07:38:08 -0700 (PDT)
Received: from localhost ([2601:586:4c7f:f985:f03e:5c2f:42af:384a])
        by smtp.gmail.com with ESMTPSA id f9-20020a816a09000000b00545dc7c4a9esm308651ywc.111.2023.06.14.07.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 07:38:08 -0700 (PDT)
Date:   Wed, 14 Jun 2023 10:38:07 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        willy@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: kill lock|unlock_page_memcg()
Message-ID: <ZInQzwsAFDgS1JyS@cmpxchg.org>
References: <20230614143612.62575-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230614143612.62575-1-wangkefeng.wang@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2023 at 10:36:12PM +0800, Kefeng Wang wrote:
> Since commit c7c3dec1c9db ("mm: rmap: remove lock_page_memcg()"),
> no more user, kill lock_page_memcg() and unlock_page_memcg().
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Thanks Kefeng
