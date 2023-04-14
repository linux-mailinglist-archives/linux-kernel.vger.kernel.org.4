Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C89A6E26AC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 17:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbjDNPSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 11:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbjDNPR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 11:17:59 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A0AA2737
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 08:17:36 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id n19-20020a05600c501300b003f064936c3eso15048042wmr.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 08:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681485454; x=1684077454;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LiiGjyqX4o159cvbNlKsXJAHA/ueLUd6Q3sCWwwpz5Y=;
        b=DOaKY7KMiuRzv77phiJcAAJ0NvzAbTEawUceJCq6OubBbrOFy3Y2WowDMWM1MdGYR3
         qnxbuVikIfwiaWU3C/6stDlcrBYUtEJPZC6mXfRzfuRNK1brACCZs8MqXBEc8IqMZheI
         OoWJkk6gu7SDNrsmn4lCNzIOyj6jABoMy3GDDBFa1fJz40ZVsCmKSbFNvSbb1MHdqYlp
         782o1F334MH2N07jMwV2b4JQVr9ztDdcdcwufcgZ2rq0bOXHMrWvDwQWE1kepwuQKTvG
         iu5v4ZDskKltIMbH1D19AeTWfSDxUKF4ulyKN1T/UUaFGah5Elk+bCXeFQyc7lmYPPJd
         EIbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681485454; x=1684077454;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LiiGjyqX4o159cvbNlKsXJAHA/ueLUd6Q3sCWwwpz5Y=;
        b=gGbeYRKd8AffB0B6Ib0iam8j0RUfGp6N+tzZ5jkWAtbYs49nxcZUOCTrpGmqswty9W
         oqZuaarjQ8aqmMcvltGlVGtioeBwX5wRe4HYHjkkqSVPKOgyUlgGETE+9W+wkoMlkXVU
         f+RAgpMb/GiZNRX6YhPtaEdyPjoajNo2zYRv+I+q35FES80uqjzkxopzG0RcDy1l+v9w
         egfdjMFTg8jws1w3Kg3uMnr/uGIdtq2o/VZjeyiTv+9SO7vpSZCSLHNqd4vloclnhhcm
         VTbkcG+H1Yw2yPITorejMQ9IpxZpZNm5SSaXweXu1hpLibOiCfWuSYp72Ok182GR+4XU
         0qOw==
X-Gm-Message-State: AAQBX9crYdVJYo6mUI9w3OUVuGfx+e7Fk/PEISFIYrWbEiSjM8rV5qZE
        7lTCspzaKrjlnufUqn4/ECV8Sg==
X-Google-Smtp-Source: AKy350bQFzW/yiQUVEbMS8iwEGtjIIv6F3QJDvhfsmxOMugGGxPwOpR0bNIgwlJINtCCORADLPrWlg==
X-Received: by 2002:a05:600c:21cf:b0:3ef:3ce6:7c54 with SMTP id x15-20020a05600c21cf00b003ef3ce67c54mr4860044wmj.35.1681485454655;
        Fri, 14 Apr 2023 08:17:34 -0700 (PDT)
Received: from myrica (054592b0.skybroadband.com. [5.69.146.176])
        by smtp.gmail.com with ESMTPSA id 8-20020a05600c228800b003edef091b17sm4508021wmf.37.2023.04.14.08.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 08:17:34 -0700 (PDT)
Date:   Fri, 14 Apr 2023 16:17:35 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Akihiko Odaki <akihiko.odaki@daynix.com>
Cc:     Eric Auger <eric.auger@redhat.com>,
        virtio-dev@lists.oasis-open.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, qemu-devel@nongnu.org
Subject: Re: virtio-iommu hotplug issue
Message-ID: <20230414151735.GA4145625@myrica>
References: <15bf1b00-3aa0-973a-3a86-3fa5c4d41d2c@daynix.com>
 <20230413104041.GA3295191@myrica>
 <c6fb5a06-aa7e-91f9-7001-f456b2769595@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6fb5a06-aa7e-91f9-7001-f456b2769595@daynix.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13, 2023 at 08:01:54PM +0900, Akihiko Odaki wrote:
> Yes, that's right. The guest can dynamically create and delete VFs. The
> device is emulated by QEMU: igb, an Intel NIC recently added to QEMU and
> projected to be released as part of QEMU 8.0.

Ah great, that's really useful, I'll add it to my tests

> > Yes, I think this is an issue in the virtio-iommu driver, which should be
> > sending a DETACH request when the VF is disabled, likely from
> > viommu_release_device(). I'll work on a fix unless you would like to do it
> 
> It will be nice if you prepare a fix. I will test your patch with my
> workload if you share it with me.

I sent a fix:
https://lore.kernel.org/linux-iommu/20230414150744.562456-1-jean-philippe@linaro.org/

Thank you for reporting this, it must have been annoying to debug

Thanks,
Jean

