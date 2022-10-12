Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2CC5FC19B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 10:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbiJLIER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 04:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbiJLIEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 04:04:15 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06216B2D87;
        Wed, 12 Oct 2022 01:04:08 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id f140so15834958pfa.1;
        Wed, 12 Oct 2022 01:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bgBbUs8TofhAMyCRBKzVfzUcwrUVLCp8g4mhXCX29EI=;
        b=RYdBLO9dY/gqXlXYXxFu9ncK7sNQqO2zp3qjR5bFPMisLHOEPQCfgZyKsP/Qw5EfRf
         NpgqkFHXwjefsMRE2wqTz+DuEzSOQK9YoOgknK7fc2aPljAd6DFP1XWJh05EAHjFehSC
         veyjXjO5ZOfUbcQZwtQFrbBqZ6JoHZDVZfgRMp88sVhEg+rljopvmeqHnJ+fDCcRkfM6
         0lhZjSyrq4jBmWJ4ygaeNhwVXXooPDXftXmB3lsiX8gkuHfhvaD0z9IU4yFOSWogCa5T
         9ZGPIH61gyXj0aE43sNbWrjLQje0yXVhxpcsutyL/RolAY5yfrclLXOzhBkHIFQCKVux
         N+Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bgBbUs8TofhAMyCRBKzVfzUcwrUVLCp8g4mhXCX29EI=;
        b=Uhs6Wl2gfQVEawIkSJYn6TKsZblRtlpIe5Xi9ZyBbdRFZNxpFVO6soicb4/duVaR9h
         m/xTCDou6knpAJ3dT5N1pMgwhqCPEM51orRnfHQSwUMM99v1+zOu3w8FEyPL5IGsfoAb
         w1MHjzyIRMOkeZ24sTBzBWcpmZnNUuRzJV39f3c6o0nNLIFUBvR1eFJEAMnagob34KhG
         WM5Jshmiv/iryk375I2hjyB50SUhJpb7vVTnZkb1+94uNKtZWjQYFKQh1zPiX8tLD4Kf
         Ok+bQtYvWEt6XyQKy44P+T+Oc4lG9yrwXxtOaQl1AzvzsX/GNb3vDi3zqoxOkmLgWs/Y
         6XIg==
X-Gm-Message-State: ACrzQf3dxFqdwQqGFsTDyos6DqAKFFqZla4/nLUl5vC2C60uQ4gnqXiK
        1bGsQjCBvv+aKfIO5X60FKA=
X-Google-Smtp-Source: AMsMyM5/gFPR44XKYIVSRUkh9qrb45lwI7Kt3s1rCkjgSgs2yzBwhsXyWvJp1lq+ljSddsECRDH1wg==
X-Received: by 2002:a05:6a00:22d1:b0:562:5d7d:5588 with SMTP id f17-20020a056a0022d100b005625d7d5588mr30138916pfj.58.1665561847849;
        Wed, 12 Oct 2022 01:04:07 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id p5-20020a170902e74500b0017f73caf588sm9984934plf.218.2022.10.12.01.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 01:04:07 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 11 Oct 2022 22:04:05 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH -next 4/5] blk-iocost: bypass if only one cgroup issues io
Message-ID: <Y0Z09aVsg9TUGSRH@slm.duckdns.org>
References: <20221011083547.1831389-1-yukuai1@huaweicloud.com>
 <20221011083547.1831389-5-yukuai1@huaweicloud.com>
 <Y0WhpuqK/8CEZAGc@slm.duckdns.org>
 <c19008c3-512e-92cc-6be1-3ecc24e74341@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c19008c3-512e-92cc-6be1-3ecc24e74341@huaweicloud.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 12, 2022 at 09:33:46AM +0800, Yu Kuai wrote:
> Perhaps a suitable configuration can avoid this problem.

Yeah, iocost is a throttling controller. The default parameters try to be
adaptive but it really needs benchmarked parameters to work properly.

Thanks.

-- 
tejun
