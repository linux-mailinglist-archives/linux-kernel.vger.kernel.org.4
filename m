Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56B996912C7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 22:50:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbjBIVum (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 16:50:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBIVuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 16:50:40 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4A4725298
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 13:50:39 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id j6-20020a9d7686000000b0068d4ba9d141so1004256otl.6
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 13:50:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LflqKbDPnAQeYR9AbcdPJDaBzU2Bf2qyTJfC5gOQhL8=;
        b=kXqaFMBOxc4uVQ3XzG0x1KL3GlK1Gi/2GsBJZz95xUBeuFl/18Jh3xiCeDg7jnM/bf
         QvxKRNqFjXOREnbv3xCHzKfsVJ4rdfMFj1F3mtgHSleUBOxNhbVsFtpbdbIfnJcEfqsX
         TCk55qDhT4SmaNOJWyn2+DT6MobPKCJZhuVeqAMZTwntlz4ntieeDMG+/Myqs892P8zF
         dvbw7i5gp3NvlV7wanrEpUtQJkDojM2lXt18L31wqyGCE3Du5S+L5RgSZUrcIbDBH8xZ
         z89S4C5FSmiBHUSlR15Wh44iD1Up7hBuHXAfjsNEGAOBITphaUDeHn52ACTq5uGOsbFh
         8thA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LflqKbDPnAQeYR9AbcdPJDaBzU2Bf2qyTJfC5gOQhL8=;
        b=xy++7/6H7qv6vP0GVLGPdMACdEZ31NmCGQqtMTYDSDaHyixy4/34vIG9JgYL1Wtupp
         XegSuAEPabWUBCR12x9Hc0F6KqiyiVh/2JZKO/Pds4PorL8+vg7mdnoU/dgcw1gY059d
         U3kW4R9crDGyAJFnsbt561Y7TfiGNGIj0uGWqAPFSmKhrlAWDEJoLVmbf/sU5ZLlSaix
         Z1PeEizA2+BL3qQSRcfNqa2HG/NFyQb1tG8uZh22F1XqqYtQ4MAcX4mRHH5T3gIezD4x
         36GJe4lgfjKJhl9v5zXmIn692SxYkNLFW9dtXjx4n+PCVZ/yoUR3kYE0r2L8fkYL3EEg
         hG0w==
X-Gm-Message-State: AO0yUKXLR6gx7X8HNze7wfJU7xt0smgiHpaw1TIFTfDk8AdPzegrFNqh
        5E4xF6dOkPxBmk4IU3XdqmBPgFHfS/oWSEEdtLc=
X-Google-Smtp-Source: AK7set+WkhR5tYPUisCbtFnw9buB/s82cjlepH/D4+52yoEbCzMU9BZOC1mPYoBRTixHn9XPjhZrBg==
X-Received: by 2002:a05:6830:3918:b0:68b:d890:1e03 with SMTP id br24-20020a056830391800b0068bd8901e03mr8275124otb.21.1675979438866;
        Thu, 09 Feb 2023 13:50:38 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id v26-20020a9d69da000000b0068bcd200247sm1240668oto.75.2023.02.09.13.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 13:50:38 -0800 (PST)
Date:   Thu, 9 Feb 2023 13:50:30 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Hugh Dickins <hughd@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Yang Shi <shy828301@gmail.com>,
        Zach O'Keefe <zokeefe@google.com>
Subject: Re: [PATCH 1/2] mm/MADV_COLLAPSE: set EAGAIN on unexpected page
 refcount
In-Reply-To: <20230209132846.122ad88e1c2bd0603a630e5c@linux-foundation.org>
Message-ID: <1f344fc1-834d-f1df-8a2c-79918be5b22@google.com>
References: <20230125015738.912924-1-zokeefe@google.com> <ecb2cf3-45f0-8aae-3e1-da4e79de9c27@google.com> <20230209132846.122ad88e1c2bd0603a630e5c@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Feb 2023, Andrew Morton wrote:
> 
> Thanks, I'll merge [1/2] into mm-hotfixes.

Great, thanks.

> 
> I'm not seeing anything in the [1/2] changelog which indicates that a
> backport is needed.  IOW,

Correct: it's just changing the errno for some racy cases from "you're
wrong, don't bother me again" to "it might be worth having another go":
not fixing an instability, as 2/2 was.

> 
> # cat .signature
> When fixing a bug, please describe the end-user visible effects of that bug.

If whatever's being run by the end-user is coded to try again on -EAGAIN,
then the end-user will less often see occasional unexplained failures.

Hugh
