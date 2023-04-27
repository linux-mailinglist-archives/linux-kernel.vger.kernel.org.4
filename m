Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 375B46F0A74
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 19:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243834AbjD0RCv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 27 Apr 2023 13:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244070AbjD0RCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 13:02:49 -0400
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B11A26BE;
        Thu, 27 Apr 2023 10:02:48 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-94f9cd65b1aso250929566b.0;
        Thu, 27 Apr 2023 10:02:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682614967; x=1685206967;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BGZN0OIlJZEcU3Y6FEqZUH0KBPvZDL+wwAagUBR8bvo=;
        b=iw0GTrbTlW1B51OhgEuXs31lv7yQNan8kwkEhOld8yDDf9xhEflygjTsE9myZN894Z
         LWsT1bIM2axdcbuJZnf9sbHXAXwxpudjgm5y7toRxIiNQqf9y83Ym9yB98ZQy2xhUHSE
         o9Ockk+ClQb5C5aECfoP8YpeF1k/xwbH9Zv5uP9NTdJf6kuV0ykVeH73h57RwUZAvLE1
         fkS8UfetrZ9wtmqj5Zuh/hezeXSOCt038A+1om1Ld3wiVBD5DO60PhyUaByvIFVmQppt
         X7IXdEO+faThpkapmp2oesveAVxJaw6N5gbuOq6stg0j5i5HH9IZWZU6bETIqaNFATn9
         EiJg==
X-Gm-Message-State: AC+VfDyEnp5/n178loZG4/bZJny+ccjLCRPA/VTiBADDzOuxKPCkB3RI
        6IOD47od2dNrr7hJ481/LyOPUN3w0lazr3HHVcM=
X-Google-Smtp-Source: ACHHUZ7WDT1wItUrvDHB7jxZ8M9bA71N73B3eFcrzz8iAvJSFRJ5fRGMt24Cwa13zrFoLDHo+dsZehN5rOqa3HjFjzA=
X-Received: by 2002:a17:906:6483:b0:94f:4122:28f5 with SMTP id
 e3-20020a170906648300b0094f412228f5mr2336502ejm.2.1682614966651; Thu, 27 Apr
 2023 10:02:46 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1681443714.git.yu.c.chen@intel.com>
In-Reply-To: <cover.1681443714.git.yu.c.chen@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 27 Apr 2023 19:02:35 +0200
Message-ID: <CAJZ5v0hdmL=pM7QPcox3+m9CBs9SA_sMf+HFbo11W4ho_+vHCw@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] Fix test_resume failure by openning swap device non-exclusively
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Ye Bin <yebin10@huawei.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pavankumar Kondeti <quic_pkondeti@quicinc.com>,
        Yifan Li <yifan2.li@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 14, 2023 at 6:14 AM Chen Yu <yu.c.chen@intel.com> wrote:
>
> test_resume does not work in current kernel when using swapfile for hibernation.
> This is because the swap device should be openned non-exclusively in test_resume mode.
>
> Patch 1 is a preparation to turn snapshot_test into a global variable.
> Patch 2 is the fix to open swap device non-exclusively only for test_resume mode.
>
> Change since v2:
> Adjust the initialization of fmode and refine the commit message
> per Rafael's suggestion.
>
> Change since v1:
> Turn snapshot_test into global variable and do not introduce parameters for swsusp_check()
> nor load_image_and_restore().
>
> Chen Yu (2):
>   PM: hibernate: Turn snapshot_test into global variable
>   PM: hibernate: Do not get block device exclusively in test_resume mode
>
>  kernel/power/hibernate.c | 15 ++++++++++++---
>  kernel/power/power.h     |  1 +
>  kernel/power/swap.c      |  8 ++++++--
>  3 files changed, 19 insertions(+), 5 deletions(-)
>
> --

Both applied as 6.4-rc material, thanks!
