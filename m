Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DCA768B410
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 03:08:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbjBFCId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 21:08:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjBFCIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 21:08:32 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1AC6D51C
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 18:08:30 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id v6-20020a17090ad58600b00229eec90a7fso12376268pju.0
        for <linux-kernel@vger.kernel.org>; Sun, 05 Feb 2023 18:08:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wFA+qqcHIsxmmy2Bs+0XDIcvd3GUt4Oi3ikg3og5iTc=;
        b=oaufHGaMM86Zvit/UMGFQnzGcbvKOqGaTZZHpe8Fl41Dt0SgTv+80Hzwr82Ktwhg+e
         g4zOy7FXojHZOAMeZ9I8hDGetp4JsqmRURNrKRjBIxEbHY0ndl+MhpLiKyYZ3dDqNG7k
         jLe00ILbaebrDcgbMWn8oCJq3sQwVgDRAhPnn2GJWB1nENOavCk1sf8rKRh9TnArwZyZ
         LBjaf8Kj1MjueViKIiut5N9IfIDSrJSIzBAgaYD/+ywS7ESRrg5QF6iVd6EFksMIbYYR
         YBRORj69tZ4ZYKRuELZ0pIMgzzLICQMIh/iWRyjHMfR9/ev8/FyD2AeUgl4S8v6cP0aI
         1DhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wFA+qqcHIsxmmy2Bs+0XDIcvd3GUt4Oi3ikg3og5iTc=;
        b=TujM03yU5rnV5Qvr2c1YyqoXQB61HIdsQFW9HXsUlqexkO++R4teR4aebA8ulkc0RL
         A1gSIQjUNREcRAqGxbCq1PjX3GjHKO1Tz/FHvhLcdr7PTZBvaWSuozd1twuffr8PtNd4
         61Ibsh0vf9sgjzJxpbReK94hkr84hWujNQRFpLUNwx7vZvoEpb4h3MONhs+AaFPtic1j
         9W/V3zZ1tXMrVZQVj1Cx/5e+IOu4nKPK50y5o7pH5FdyXRCmjsPiHHMXBi+Kz0NdvzBP
         gTx73w8zTrV1ubRDILBGn2llBdoZCAUI1XeX+ZxBKhxpORVFAG74WZ/idiLBNVQWuTWd
         A3Mw==
X-Gm-Message-State: AO0yUKVF6l0qgPglArY/p7xkcgLe7JDnJRi5CSzKn5DY4Bot2ADJ2m42
        EQvKVdrPVJGPdag5cSq7sy0=
X-Google-Smtp-Source: AK7set+5L6igrBTSO/bj398d0D2R/rCfgx2P4xjp2jztXRfKjjAEIcdDyrQeBw/9lzvS3R3llKha9w==
X-Received: by 2002:a17:903:1212:b0:197:35fc:6a5d with SMTP id l18-20020a170903121200b0019735fc6a5dmr22443583plh.30.1675649309981;
        Sun, 05 Feb 2023 18:08:29 -0800 (PST)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id f5-20020a633805000000b004f22f5297bcsm4930231pga.67.2023.02.05.18.08.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 05 Feb 2023 18:08:29 -0800 (PST)
Date:   Mon, 6 Feb 2023 10:14:10 +0800
From:   Yue Hu <zbestahu@gmail.com>
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        LKML <linux-kernel@vger.kernel.org>, huyue2@coolpad.com
Subject: Re: [PATCH 4/6] erofs: move zdata.h into zdata.c
Message-ID: <20230206101410.00006187.zbestahu@gmail.com>
In-Reply-To: <20230204093040.97967-4-hsiangkao@linux.alibaba.com>
References: <20230204093040.97967-1-hsiangkao@linux.alibaba.com>
        <20230204093040.97967-4-hsiangkao@linux.alibaba.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  4 Feb 2023 17:30:38 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> Definitions in zdata.h are only used in zdata.c and for internal
> use only.  No logic changes.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Yue Hu <huyue2@coolpad.com>

