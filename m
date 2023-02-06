Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EAA468B3F4
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 02:45:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjBFBpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 20:45:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjBFBpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 20:45:03 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF6F1ADFD
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 17:45:02 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id hv11-20020a17090ae40b00b002307b580d7eso6337877pjb.3
        for <linux-kernel@vger.kernel.org>; Sun, 05 Feb 2023 17:45:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YnCWo4AAikXuZ3MEq0h3uZ00VDz0wRVmJZ9agLFsWm0=;
        b=CVOrYXEfZIXaPWopwnsNoos4/2/kLh2SSEF4H4H6UjF3XYdp0vCpHmWZf79tNP7zLc
         dX1ElMlw0u1XNAHLnWvw7t1e/g6bxeZriqQuf6aQ1+2zacjeY64mhbkyBRJnb4z2Lqty
         6h82A3nvwYsut4mTB9nqSIC3O4WHgHnigW3UN8HfCMjik9UBikt8TM99pWCysyl0L/x7
         3HzJY77Chrn3NjkdHFZ9k9FMONAk7GnJMTpYftSY2sU2oPtbYMPhWYFKNdPDB41ZUS6C
         mj88+Z2wIkzyJ22bId8U4DEx3zggYNs4IqcwrIqGQWkT40wh593OuWr3JcIHnn9CwNoj
         rm2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YnCWo4AAikXuZ3MEq0h3uZ00VDz0wRVmJZ9agLFsWm0=;
        b=ttIZ2bB0NNToNtyo+3gaxLLe6hbkT/Fz6pOqAS0n1+nZhV4yh3t4WMeP8FnafDAgvO
         LAiR9HwzTS5pU/7p0eoALRVQca2HHtaM2GyFNVyrjAuhQPZVqrDHBUbM20pnkEO6Xad7
         eE1BMNbkElM41U8+R/TVmeejc7pa2BfmY6+dyH3udlqotw6w50X5xNRz+LQ/O4NVSvXX
         T7d/vJPs6y2GQ+TFjYW+qbwqW/MysC9v9sHvKdwq0Ot3UDvwqziuvEw13HCN23A5pseL
         7PU/v+SiMTA1MmEaJRxoVdihaKHmI7mHr4v3CLuHaoW0W3dLNsL/CXKyadIdz77VnOPm
         u3gw==
X-Gm-Message-State: AO0yUKUC2NOjWM8OkU2wm4B///gm/3GtA5xWZCZGp6YXQQY2L2TKZURt
        oSERnP9A6ClTCc9d1vFO17o=
X-Google-Smtp-Source: AK7set+TBDGqJHxU1SXG0i6aacPGpcE/zA/ljipPknHQ3LUY8HyTPxg/DCxScV9FfMD3bWUv2JAARQ==
X-Received: by 2002:a17:902:c408:b0:196:e8e:cd28 with SMTP id k8-20020a170902c40800b001960e8ecd28mr25335941plk.15.1675647901977;
        Sun, 05 Feb 2023 17:45:01 -0800 (PST)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id m6-20020a170902bb8600b00177f25f8ab3sm5528616pls.89.2023.02.05.17.45.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 05 Feb 2023 17:45:01 -0800 (PST)
Date:   Mon, 6 Feb 2023 09:50:41 +0800
From:   Yue Hu <zbestahu@gmail.com>
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        LKML <linux-kernel@vger.kernel.org>, huyue2@coolpad.com,
        zhangwen@coolpad.com
Subject: Re: [PATCH 2/6] erofs: avoid tagged pointers to mark sync
 decompression
Message-ID: <20230206095041.0000140f.zbestahu@gmail.com>
In-Reply-To: <20230204093040.97967-2-hsiangkao@linux.alibaba.com>
References: <20230204093040.97967-1-hsiangkao@linux.alibaba.com>
        <20230204093040.97967-2-hsiangkao@linux.alibaba.com>
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

On Sat,  4 Feb 2023 17:30:36 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> We could just use a boolean in z_erofs_decompressqueue for sync
> decompression to simplify the code.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Yue Hu <huyue2@coolpad.com>
