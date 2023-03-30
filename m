Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1596F6D0454
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 14:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbjC3MHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 08:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231234AbjC3MHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 08:07:00 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B44CD658B
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 05:06:59 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id kq3so17809920plb.13
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 05:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680178019;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z2gBu0cd56okBmgzR+FM39ycpsQMxjUJpB7f1n614EA=;
        b=GicAwO0/B1GYQYs19bT/t/pZlHMPISuoBxHxVjM3tAxbxQp67F614LMvDlh+YgPD0/
         h4AZ/D64h/F4EbJdnyKNrkDIViZBed+z+ExP06XqF8jl5bQQ27ii7dzg/RGCuosft7Yx
         QAtFliPjJ6vOkF/e1EGdeyHgSpjpTefNvRl6B5cmfsGr/LT4WU7f3dqL99UR5Hfez0lI
         IoIijvCbPjwhyuNkC3ZxVaoAZTOkyOf2ZbKaOnpC4rDf1SBQZTesSGWamWHT1svIcWK3
         Z1KnQAi0nXxH1Ye28dc5UMrF4V3yluCT7isGhYrgyEff+2EB16I9lHj9BEs5KXci8KhJ
         PyXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680178019;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z2gBu0cd56okBmgzR+FM39ycpsQMxjUJpB7f1n614EA=;
        b=igi3Yyb3Od7PSyUxqswA4/Cj2eZIbjUaA4u85/fGKS3kUFkUjn5+af7qQEwIlWgH7h
         rsogc2plSAQcpJr1ZrjSdcm3VrV9R7Sy79sF6lOIz+7w/b4ke1q0CNDk2c3w3d0IqOtg
         I5ZlsxSMXpNaM3T1165ATRY/flMW90qv+g9tu4OZFDZQouUTvtuX8T8ce1zmJaVvtEck
         +kEd31mXWhYn3TQvECgBXJIjvg9+wlS2yceaqrtwIQLkMGcA/EBl8X1b2d/17TEGYz1d
         vldCZumOXpkc/Cbcg0IZH6heNGecL2ZBof5yWZeoqSicBn7H3Ns4z62YhQRYMVw1cuZW
         9kfA==
X-Gm-Message-State: AO0yUKULF2TaEqhWZGN/M5TTnutv1sT1ZbOiVMQm4HR3o3/lrjV/7zEO
        ZfPj1ucjIssamdm3MMU14AQ=
X-Google-Smtp-Source: AK7set+4uqlqFfPED8zRNgqghXHa4HmDT6d/nF9VLxEkI+X1TT9Tq2pkT3vQ9iXuM+03v3kVbyx3Lw==
X-Received: by 2002:a05:6a20:651c:b0:d8:d0e5:df90 with SMTP id n28-20020a056a20651c00b000d8d0e5df90mr20181565pzg.44.1680178019021;
        Thu, 30 Mar 2023 05:06:59 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id u14-20020a62ed0e000000b006242f4a8945sm24665653pfh.182.2023.03.30.05.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 05:06:58 -0700 (PDT)
From:   xu xin <xu.xin.sc@gmail.com>
X-Google-Original-From: xu xin <xu.xin16@zte.com.cn>
To:     david@redhat.com
Cc:     akpm@linux-foundation.org, imbrenda@linux.ibm.com,
        jiang.xuexin@zte.com.cn, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, ran.xiaokai@zte.com.cn, xu.xin.sc@gmail.com,
        xu.xin16@zte.com.cn, yang.yang29@zte.com.cn
Subject: Re: [PATCH v6 0/6] ksm: support tracking KSM-placed zero-pages
Date:   Thu, 30 Mar 2023 12:06:54 +0000
Message-Id: <20230330120654.120937-1-xu.xin16@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <78e35d88-8a4e-3b36-bbbd-94048c0c5b54@redhat.com>
References: <78e35d88-8a4e-3b36-bbbd-94048c0c5b54@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, I'm sorry to reply so late because I was so busy with my job matters recently.

I appreciate David's idea of simplifying the implement of tracking KSM-placed zero pages.
But I'm confused with how to implement that via pte_mkdirty/pte_dirty without affecting
other functions now and in the future.

>
>I already shared some feedback in [1]. I think we should try to simplify 
>this handling, as proposed in that mail. Still waiting for a reply.
>
>[1] 
>https://lore.kernel.org/all/9d7a8be3-ee9e-3492-841b-a0af9952ef36@redhat.com/

I have some questions about using pte_mkdirty to mark KSM-placed zero pages.

(1) Will KSM using pte_mkdirty to mark KSM-placed zero pages collides with the existing
    handling of the same pte in other featutes? And in the future, what if there are new
    codes also using pte_mkdirty for other goals.

(2) Can the literal meaning of pte_mkdiry represents a pte that points to ksm zero page?

(3) Suppose we use the pte_mkdirty approach, how to update/decline the count of ksm_zero_pages
    when upper app writting on the page triggers COW(Copy on Write)? In *mm_fault outside
    mm/ksm.c ?


Move the previos message here to reply together.
>The problem with this approach I see is that it fundamentally relies on 
>the rmap/stable-tree to detect whether a zeropage was placed or not.
>
>I was wondering, why we even need an rmap item *at all* anymore. Why 
>can't we place the shared zeropage an call it a day (remove the rmap 
>item)? Once we placed a shared zeropage, the next KSM scan should better 
>just ignore it, it's already deduplicated.

The reason is as follows ...
Initially, all scanned pages by ksmd will be assigned a rmap_item storing the page
information and ksm information, which helps ksmd can know every scanned pages' status and
update all counts especialy when COW happens. But since use_zero_pages feature was merged,
the situation changed, ksm zero pages is the only exception of ksm-scanned page without owning
a rmap_item in KSM, which leads to ksmd even don't know the existing of KSM-placed, and thus
causes the problem of our patches aimed to solve.






