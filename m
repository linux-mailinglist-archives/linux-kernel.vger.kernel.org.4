Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6786016EF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 21:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbiJQTJG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 15:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbiJQTJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 15:09:02 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 168DF72ECC;
        Mon, 17 Oct 2022 12:09:02 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id n18-20020a17090ade9200b0020b0012097cso40215pjv.0;
        Mon, 17 Oct 2022 12:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bx7n35j6Slc9c7K9PZOEInk30eMtyZFgLAsHKA2uWBA=;
        b=UGvR8YyioSnMVWr+ZXpvBpTUR6XZsUDSY+zgyWuOEX3PL5p+LtCNKvGEpi6HVzY6A6
         f4M47zqvgOdYhgY09TlUk3qCId4LO0y1Lp7/1eBcGTsbxzfCFEa1qb40Yw4rcU9wdkgI
         vFu94Ayp2JY/m6M7/l2WtjuwE8Fx2NDlU+hncczFoeJhTPwdB96Kb99CMMpQs/k28HZX
         MQkd5bwb4naWhMXIxzb459HvV/Wf0eAq2yYVtVVYXw/NcAcOpKtOMhbE+7c16Yxv51DL
         uiml69ztXu65gWYuCsGVXNBRo2s7+31wJtoz+eMCivdxwHS5IYI9HOuLBeQahmCZVqH0
         9gKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bx7n35j6Slc9c7K9PZOEInk30eMtyZFgLAsHKA2uWBA=;
        b=8I/Sp7DQ64P3aAvpZDczgc1MloSvbSN9ldZ/3SGLZPXwYTviPPqCmcgZ4W76B6DKzS
         a7XOuJye2+cfEGRjjBK8Kp4VTbGgXKRpfvP7MHc+GzIJM5GIJ0A7W/kTQFvtinKkQN02
         NDTUKjnGSYmx2o0v7xOtneqGniAqR/SszTM0vrj15S4yZc3etnHu5WldDq2bqRQW/3bA
         BYiFnqO0sPw4CaeYZnGHtxqbOyTstIy2Nmt/xM4d8OiTXnNQQnvphp0D1prUMrNQgCK/
         srI2cdtjCmixHsgM3Fb7a3KkaNNIz3OYhghI5f/DTgMBWO8lICWebFqx9tPFEm0KIoNO
         dgMg==
X-Gm-Message-State: ACrzQf1FnwSpsjF+EdOY/NOXz3D/3cFz9L6wk4G1A4khiN1NMg3oas4c
        fd7KlyyP1Hk2svwjkyhFmCs=
X-Google-Smtp-Source: AMsMyM7aOAMF7/oKbs5BWocJ2BIvChHfsMUvfaWw+p/GNLb/RhN4RpTeSpV+UOsuC9R5h+3nIC0G4g==
X-Received: by 2002:a17:903:1003:b0:181:6c26:1114 with SMTP id a3-20020a170903100300b001816c261114mr13469897plb.75.1666033741410;
        Mon, 17 Oct 2022 12:09:01 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id x185-20020a6263c2000000b00562a526cd2esm7374202pfb.55.2022.10.17.12.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 12:09:01 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 17 Oct 2022 09:08:59 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Kemeng Shi <shikemeng@huawei.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/8] blk-iocost: Remove vrate member in struct ioc_now
Message-ID: <Y02oS3f8yTw1r0VC@slm.duckdns.org>
References: <20221017020011.25016-1-shikemeng@huawei.com>
 <20221017020011.25016-5-shikemeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221017020011.25016-5-shikemeng@huawei.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2022 at 10:00:07AM +0800, Kemeng Shi wrote:
> If we trace vtime_base_rate instead of vtime_rate, there is nowhere to
> access now->vrate except function ioc_now using now->vrate locally.
  ^
  which accesses ("to access" doesn't mean the same thing here)

> Just clean it.
       ^
       remove

> Signed-off-by: Kemeng Shi <shikemeng@huawei.com>

With the above description updates,

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
