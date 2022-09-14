Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7049C5B8AF9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 16:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbiINOty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 10:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbiINOtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 10:49:49 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A3195B9
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 07:49:47 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id d74-20020a4a524d000000b004755f8aae16so1801474oob.11
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 07:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=kJ9cObmCfJy7zayueRZ8avT0ZkBC3fAXveiFVXW2d3c=;
        b=BS8LjY8kVKMrnEmhnKSq83R4AizxpIgEbctiVDPMRcdKOmBMECLYxiTY+zmFs9d/Am
         Zp0NwuDgfToaqteR8JP4GOo7qgCTMbz/9pw9grsuTo+3xmlA67gGc+c4tdcBdEslPqXQ
         cRaJDWOIXWvkeLsBnVclQAgo7wJ+2Y1vkW7ukrDyi0pGUu0MEJ/TJ3U/zA9frXxZ4PXv
         GHe9hetUR1JtaCPXOrjBKVVSSo21VdPcBI+zdw4jDL9mf3y4LWC4SClyIdaOKHqcNLVB
         XmCBcN+UOk2lhGJVwc3JTraZmcdd1AvoTXZyS0XaryNrkZpovJOKgNS2SsofpJ1RR+40
         2ocg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=kJ9cObmCfJy7zayueRZ8avT0ZkBC3fAXveiFVXW2d3c=;
        b=w54LWcckMPQfU69okPBlRUmqRINwabzxS7foRYNu6gdUIRjiVYt629/zt1fQjrH+Wf
         j5kAWsNjtGC2LHmLq9E1AqXPXNXNZYkV1MbzRVx8DKrxBj3smwRyE4M7QUg+V3mZrXgw
         7xnxs4idGZmQ3nQNRfZDXjakE1A2UbTmpWPbs2zJGi2poSAbUfU/2nMLr3CGDNugjvzI
         +3bLd/gH0iLF9mXwbsnf/HMy2nkC4D7vQu2DY2Cs8vTngRBiVPh2ravoi+TjSgm5SBZf
         dnjiQb8TAQcb2bkaF0BH8QLN5VKSK13tLJUJoLTsCGs+Xokq+IfIg+roZvGVsqKGEwLy
         M/gg==
X-Gm-Message-State: ACgBeo3uDf+5atBKDES0M81AgYPwoH4z7Y3jsM5EB1IVIgOdf62lN0wj
        wsy0vi9ObtZoNzQUPcyJIr9Gwn1spa8E4kYN44c=
X-Google-Smtp-Source: AA6agR5hbY7TnWmhNQMvFEFho6lqEUCWEj/P/ohu/W7QkUem154xEfPhzk+xspl1CmpWCz2IxmyClW+PwuQx7kBnhqA=
X-Received: by 2002:a4a:bf11:0:b0:436:1611:6b51 with SMTP id
 r17-20020a4abf11000000b0043616116b51mr12780772oop.18.1663166986819; Wed, 14
 Sep 2022 07:49:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220815072835.74876-1-yang.yang29@zte.com.cn>
In-Reply-To: <20220815072835.74876-1-yang.yang29@zte.com.cn>
From:   Joonsoo Kim <js1304@gmail.com>
Date:   Wed, 14 Sep 2022 23:49:35 +0900
Message-ID: <CAAmzW4ORH=kMbzMg7tpGTF_0Ky4Rb1TZ+W=q=pgppNaRxkScQQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mm/page_io: count submission time as thrashing
 delay for delayacct
To:     cgel.zte@gmail.com
Cc:     akpm@linux-foundation.org, iamjoonsoo.kim@lge.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yang Yang <yang.yang29@zte.com.cn>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>,
        wangyong <wang.yong12@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2022=EB=85=84 8=EC=9B=94 15=EC=9D=BC (=EC=9B=94) =EC=98=A4=ED=9B=84 4:33, <=
cgel.zte@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> From: Yang Yang <yang.yang29@zte.com.cn>
>
> Once upon a time, we only support accounting thrashing of page cache.
> Then Joonsoo introduced workingset detection for anonymous pages and
> we gained the ability to account thrashing of them[1].
>
> Likes PSI, we count submission time as thrashing delay because when
> the device is congested, or the submitting cgroup IO-throttled,
> submission can be a significant part of overall IO time.

It's not the main purpose of this patch. Without this patch,
swap thrashing through frontswap or some block device supporting rw_page
operation isn't measured correctly. I think that description change is
required. Please refer to commit 937790699be9c8100e
(mm/page_io.c: annotate refault stalls from swap_readpage).

No objection on the code side.

Thanks.
