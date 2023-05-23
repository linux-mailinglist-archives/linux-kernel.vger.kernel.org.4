Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D16170E3AA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 19:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238005AbjEWRHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 13:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237999AbjEWRG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 13:06:59 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF0310DE
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 10:06:48 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-25374bda99dso707889a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 10:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1684861608; x=1687453608;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AnoJfWFwpqqb2y6h15+nUxCVtVesX1rNooY3eX+9ors=;
        b=0qzXySsDr9CmJ071N038R1YOWtQkaWX7lCQOfyXUZ6n8u1chm463uZFl9c20SYcsJo
         R3xLInWgQ8GC8Yz3QBDuJOxYhezgjFqDH5SoTCatqDe0CHyzbl4hJnhW07Wfj5kBp68z
         cvVfK70ELxu9+C1QyN7As/hjIv/G41S98iXKzeqEEiIL+2BE9ykKrZnFS+WgZn71Gz64
         eKrMLoA8kEnS8u4oHYWepGYx4YJ+JUH8VjZdZ3dCUFeIBWOFJJMAbrkc0doV7dgy3HaW
         oW3U/24T1hG3bWnuMNvja8FOIvtQoMFyN40+VsEZ9GZM6cKzR8xHUg55Db0hDSiPVJAV
         vanQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684861608; x=1687453608;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AnoJfWFwpqqb2y6h15+nUxCVtVesX1rNooY3eX+9ors=;
        b=YLhVmxBqJuzMHqynlXyHaWO7qTGWQ2foPvRbxs0Y7frxzQt/iFC3nGsareIL0vq/5e
         JR4n5jc60OXrx23EQPkvY9RYEELmO+vD6T46YGwJO0qrDe1dXBVzI/bSR3L4xmApTkhc
         ooclfkTfWZEx+60zAy6HwjvBu7a2+y1Z6NFalhJakn3JKXs5HYKhDBRzrVaE8sLgpk9S
         xfOrvGvgg5f2IFtGHpHQrokCAztoleR5ojIbPxzUKDLdy58Iy4c34mqxl5GvqmXvfxZv
         KbGOmJtSl0NpesDaYQWpkUe8V2+F5hm2UdV3wYz/n3+DZIMdvBHl8GzzhOSUa8rvmbbx
         wreA==
X-Gm-Message-State: AC+VfDxRo2pWMPoHnv0IZGZLuiw5Todf/M513M3hlYvXRBKfk59SXVO7
        QTlh/45eWAQ3J0DQWQ60forX2w==
X-Google-Smtp-Source: ACHHUZ56YcHLobiBIeWnRupb8PcxkalCiDfSGPtOrLB11GMF/L4xDrPwRbkkPxrJiAsPoh2oLNWfPg==
X-Received: by 2002:a17:90b:4c0e:b0:255:cbad:594f with SMTP id na14-20020a17090b4c0e00b00255cbad594fmr474866pjb.1.1684861608184;
        Tue, 23 May 2023 10:06:48 -0700 (PDT)
Received: from ?IPV6:2620:10d:c085:21c8::151e? ([2620:10d:c090:400::5:c0b1])
        by smtp.gmail.com with ESMTPSA id ch9-20020a17090af40900b0024df7d7c35esm6056486pjb.43.2023.05.23.10.06.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 May 2023 10:06:47 -0700 (PDT)
Message-ID: <8f733dce-02df-2a0f-380c-0391bc0bff70@kernel.dk>
Date:   Tue, 23 May 2023 11:06:45 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] io_uring: fix compile error when CONFIG_IO_URING not set
Content-Language: en-US
To:     lingfuyi <lingfuyi@126.com>, asml.silence@gmail.com
Cc:     io-uring@vger.kernel.org, linux-kernel@vger.kernel.org,
        k2ci <kernel-bot@kylinos.cn>
References: <20230523092629.3402710-1-lingfuyi@126.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230523092629.3402710-1-lingfuyi@126.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/23/23 3:26 AM, lingfuyi wrote:
> when compile with ARCH=mips CROSS_COMPILE=mips-linux-gnu- , and CONFIG_IO_URING
> is not set , compile will case some error like this:
> drivers/nvme/host/ioctl.c:555:37: error: initialization of
> ‘const struct nvme_uring_cmd *’ from ‘int’ makes pointer from
> integer without a cast [-Werror=int-conversion]

This was fixed weeks ago:

https://git.kernel.dk/cgit/linux/commit/?h=io_uring-6.4&id=293007b033418c8c9d1b35d68dec49a500750fde

and is also in 6.4 since -rc2.

-- 
Jens Axboe


