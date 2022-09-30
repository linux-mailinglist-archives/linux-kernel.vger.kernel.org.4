Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87A9E5F1154
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 20:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231911AbiI3SFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 14:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231804AbiI3SE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 14:04:57 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4958D29802
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 11:04:54 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id de14so3149012qvb.5
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 11:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=iqHbVanndELe5mjNZTy7OvpiCCuQgO+WYAxDnYsUJcY=;
        b=IHHCPlMXciC+5S1svHTsMJM4/glNZMU2sRpO6nK1xevj+9U8Y9eMJTID0GjtZoh9mS
         +O1xVGq1AvlaSQ8hInRe4VTrvKsQPiVxJVpmfN1MXlDEL9gp6evPfY5dctyYIZkWCAjb
         HTy1LKOJyDhgRAENtfKVDHgAlP7LCSHSi7ACzCAuv9BFF554W9HpgnYNnVDf1zVxBx8d
         oYhDJR+MjXbyvgffxljGnubXbxlk4sYxCAU6AcWvsehfJLKTm0xmtrnGIps7t1hIHnJz
         oLGGOcn059HCwFJcqgaQ9JUzJqPLjHy5DmXbWtZ3H2TeEUPPQBXhVAd08ZGn421F5SH/
         1/Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=iqHbVanndELe5mjNZTy7OvpiCCuQgO+WYAxDnYsUJcY=;
        b=rm2vp89AesrFhp+dYNxXFbqPj6YicYEjI2q8hs2LrfywuQ4wJIB5h+cGYgeuGidWrd
         I1wIH+XDpNHJ2gYIo9FOvlDiKNMFKaNjvslkFyMWoKznx4iyElYO21OY3QThIdZ5/yeq
         QuaUX4DKmqLWNe3W0Batx0o4Kb6Ye99/g3E2XbDSjVv5vcA+Xb7RKdfhy9bgNBF9an3F
         GMMCt49X/PUBKs3Ox3EX7y+R7aChvFKaY2Pafk6/PEBDFOkx8FxiKmEDRm3LyxFXtAuB
         FKUGQmJ7YHEjglfgh7av/8m1o05kxjY7sU3xnLdGQqk5ezLQGSiRSGuiVgPx32T3uzcM
         z01w==
X-Gm-Message-State: ACrzQf2mpeZAs1tT4BVPwWffB3OHnOCCdoB3eE8D3SsyRT9mLl1QhY9o
        5/qTfWIuF8UTEWkGXQesTDDZUw==
X-Google-Smtp-Source: AMsMyM6t9laiIF4VuZRpnGYpLrHU5VcBrMIRDYhFEduEaYNrPENr04UL4LYlkCpOQ0lzxzeBxL8V4w==
X-Received: by 2002:a05:6214:dc3:b0:4af:a98c:b0fa with SMTP id 3-20020a0562140dc300b004afa98cb0famr7775879qvt.99.1664561093196;
        Fri, 30 Sep 2022 11:04:53 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-122-23.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.122.23])
        by smtp.gmail.com with ESMTPSA id dm25-20020a05620a1d5900b006b8e63dfffbsm3449216qkb.58.2022.09.30.11.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 11:04:51 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1oeKNW-004NtZ-2U;
        Fri, 30 Sep 2022 15:04:50 -0300
Date:   Fri, 30 Sep 2022 15:04:50 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Li Zhijian <lizhijian@fujitsu.com>
Cc:     Bob Pearson <rpearsonhpe@gmail.com>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        Zhu Yanjun <zyjzyj2000@gmail.com>, yangx.jy@fujitsu.com,
        y-goto@fujitsu.com, mbloch@nvidia.com, liangwenpeng@huawei.com,
        tom@talpey.com, tomasz.gromadzki@intel.com,
        dan.j.williams@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [for-next PATCH v5 03/11] RDMA: Extend RDMA kernel verbs ABI to
 support flush
Message-ID: <Yzcvwlq9QcssgDjJ@ziepe.ca>
References: <20220927055337.22630-1-lizhijian@fujitsu.com>
 <20220927055337.22630-4-lizhijian@fujitsu.com>
 <942fdca3-2cd4-88d2-033c-6bd3f7bb258a@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <942fdca3-2cd4-88d2-033c-6bd3f7bb258a@fujitsu.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2022 at 02:21:24PM +0800, Li Zhijian wrote:

> we can see, IBV_ACCESS_REMOTE_ATOMIC and IBV_ACCESS_ON_DEMAND are
> tagged "if supported" . but currently kernel just returns EINVAL
> when user registers a MR with IB_ACCESS_ON_DEMAND to RXE.
>
> I wonder we should return -EOPNOTSUPP if the device doesn't support requested capabilities

Yes, unsupported combinations of access flags should trigger
EOPNOTSUPP

Jason
