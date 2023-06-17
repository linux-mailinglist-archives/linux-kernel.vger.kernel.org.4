Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E95B1733DA2
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 04:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbjFQCdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 22:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjFQCdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 22:33:33 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DB491BB
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 19:33:32 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-570808d8ddeso7413257b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 19:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686969211; x=1689561211;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w1BkZZKBocPMjpIloCCWwhc0v4h35bGIijW2xI7DyPo=;
        b=d+KNGnzwtOFQadj6izEIiICy1h5C9k4FzV9hMju6hbz/lutzJkjiT2tjpVGcBV4OSc
         /kWRkvxvuWSR3wymnq5a0njUh+/D/Rovs5hB44A1KShH8clas65qE/NnSIe+nxBx1pQ8
         5lQdNShp2uSEHNMaxLWb2819z7R7AzEZh8DolW7mLG8ajDSFboXH5gMBnA6bE2y+/Cuq
         0kouAFZ630C43H45PEVrGNWGc4oN5Gj/nGmwKjoBCO6JUFZ8gZFBabTdbrAnvHPeXWSo
         ksf71fUez1xC6Gc75Yxke0YQRi5HzmlLenWt3QkSDls7YlVaZHglPa9AXskVvJA8mYaH
         lmcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686969211; x=1689561211;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w1BkZZKBocPMjpIloCCWwhc0v4h35bGIijW2xI7DyPo=;
        b=hiTgM+x+Yc9B2cn/aWVuE/zOtd6NZ+Ua2uNMuTJkGb2Px9t3j3d2G8ooP23ASk3tZu
         xZbyK1Er17wlxapKxFHOeXHqSiqxla/F28NM3fve1BLojDQh5ZdOq9/nDcjJMb3dzqK3
         n1e2LL3lK+lvBxnfbUlIH1QXUq1tCnBHREj4WXJM3u+snnQ0X2mn017qQcUmMwdQSImv
         OLB0PFlt9GSgHIrOU0DhSHSiTE7ZtnwEB3oOWo72o0+a7oXIXTjScFJYYFlvtFp7X8JM
         ET8ic2FlVYPlC+lSiYlGnr+Z5P5Y5gBKVpBiG9xN8/9DS4wzaD1/6rtvoITds0RxR//j
         9Utg==
X-Gm-Message-State: AC+VfDzzMUmgV5llPk3ukkk8kasH/hTrq3PxTHQhdajg5w+DLsc5b2lz
        a/a1hDXIvsn5liZnz3OHpZ0j1+k9wvU=
X-Google-Smtp-Source: ACHHUZ4AqYExU95b7oBPInYLWDLxvRTio8cafMb8K1qlc/HXf50p0gmJtH5sfa5+xJ+TnQOPrbuzUw==
X-Received: by 2002:a81:7209:0:b0:56d:31a1:bd9b with SMTP id n9-20020a817209000000b0056d31a1bd9bmr3535290ywc.41.1686969211647;
        Fri, 16 Jun 2023 19:33:31 -0700 (PDT)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id l9-20020a170902f68900b001b176ba9f17sm1035922plg.149.2023.06.16.19.33.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Jun 2023 19:33:31 -0700 (PDT)
Date:   Sat, 17 Jun 2023 10:42:01 +0800
From:   Yue Hu <zbestahu@gmail.com>
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
        huyue2@coolpad.com
Subject: Re: [PATCH v2] erofs: clean up zmap.c
Message-ID: <20230617104201.00002120.zbestahu@gmail.com>
In-Reply-To: <20230615064421.103178-1-hsiangkao@linux.alibaba.com>
References: <20230615063219.87466-1-hsiangkao@linux.alibaba.com>
        <20230615064421.103178-1-hsiangkao@linux.alibaba.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Jun 2023 14:44:21 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> Several trivial cleanups which aren't quite necessary to split:
> 
>  - Rename lcluster load functions as well as justify full indexes
>    since they are typically used for global deduplication for
>    compressed data;
> 
>  - Avoid unnecessary lines, comments for simplicity.
> 
> No logic changes.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Yue Hu <huyue2@coolpad.com>
