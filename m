Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 291B360D870
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 02:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbiJZAYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 20:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbiJZAYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 20:24:48 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23F0E1DDD2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 17:24:45 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id p3so11539385pld.10
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 17:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:content-id:mime-version:references:in-reply-to:cc
         :to:subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IgaYZInvHXlLYVk4zW+vNcwWy/urUb5g0jRG2+4Ix0I=;
        b=IL3gA9c7b+T4WSQT2YbrUsyjaEev78jZjdExfzaFAeJRV2ukQ6Tcu5iBDr5DGz+Tpo
         kN9iKRRG3vnzkqnTR+5S1f5eE7vhlI5kEJJuM3i/nF+ejSXQwYLOS/Vaf5rPOHnmlMYz
         FjPOdJsC3O5oQPsOSApezWy84PJtmV8gB1gpsvWwa5QhgLTSiG838h9ZcUNACzV0TZ/j
         MV6rwZ76ViOvQrSL7QADWtUkKkC2g64x8JW+RKFblOvNoUn5YMC291+K1Sqr1C2Mrh1J
         cYVuqqd/5e9U9xVHfH8LYgAOxap5bHy2BJ6hqzCu78yO0yrRJKPLsT5DMyspudmZ+M6k
         T+bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:content-id:mime-version:references:in-reply-to:cc
         :to:subject:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IgaYZInvHXlLYVk4zW+vNcwWy/urUb5g0jRG2+4Ix0I=;
        b=0EdxA3Ju9OlLwEFIGShfQi6khShUZiU2ET0mWy1qJDN+6FIUEhMbEVFwuBrZTyCZvT
         Z2fr5uGDxhIVFIjadz0hvGRSua0wUo9pOOXIiPPnQSWpoG7wYNNkKV7Uhf6I9vYi7tL9
         PxGPE2+TiZWe7wz8Xt8fF7Esw6Dvx0GNiubP/3ayJlzBirYq64EQRFdljQn8KVXl1B3C
         mJrVzvbqeuwexokNVSr6R/59f6ZkpoYbfmZqWXdPZOXLpm6g8PxBtVq855634Qtlr797
         Ii0HRHALbMyk/bMSEKVOVJjKg6BIBvkZ7LOZjZGXNssYJrltlZHqK/OTXBUOxozPQYJ+
         4NYw==
X-Gm-Message-State: ACrzQf2S6zQ7xCZK0UiWAmDZW810wykX5Nu+0KlnEAKcddV7Whyv8/lE
        +n54FO5lHBF+y4FHGxlDt32s/UdcW58=
X-Google-Smtp-Source: AMsMyM62s5NjkzEV0+VPVj4O04GecKUynPlpASnblEDUYjRg6vrn6VX6Vc60aT5zIqD/h9TcgM1EoQ==
X-Received: by 2002:a17:90b:1d8a:b0:20f:95f9:ff34 with SMTP id pf10-20020a17090b1d8a00b0020f95f9ff34mr1042528pjb.227.1666743884599;
        Tue, 25 Oct 2022 17:24:44 -0700 (PDT)
Received: from jromail.nowhere (h219-110-108-104.catv02.itscom.jp. [219.110.108.104])
        by smtp.gmail.com with ESMTPSA id d17-20020a170902ced100b00186ae540083sm1734616plg.91.2022.10.25.17.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 17:24:44 -0700 (PDT)
Received: from localhost ([127.0.0.1] helo=jrobl) by jrobl id 1onUDq-0002Ol-J5 ; Wed, 26 Oct 2022 09:24:42 +0900
From:   "J. R. Okajima" <hooanon05g@gmail.com>
Subject: Re: [PATCH] mmap: Fix remap_file_pages() regression
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
In-Reply-To: <20221025161222.2634030-1-Liam.Howlett@oracle.com>
References: <20221025161222.2634030-1-Liam.Howlett@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9221.1666743882.1@jrobl>
Date:   Wed, 26 Oct 2022 09:24:42 +0900
Message-ID: <9222.1666743882@jrobl>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Liam Howlett:
> When using the VMA iterator, the final execution will set the variable
> 'next' to NULL which causes the function to fail out.  Restore the break
> in the loop to exit the VMA iterator early without clearing NULL fixes
> the issue.

Thaks, it passed the test.


J. R. Okajima
