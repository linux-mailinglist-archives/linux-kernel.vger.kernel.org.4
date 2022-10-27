Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5BD160FD38
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 18:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236338AbiJ0Qfp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 12:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236630AbiJ0Qfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 12:35:37 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 770B750533
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 09:35:37 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id v4-20020a17090a088400b00212cb0ed97eso1937168pjc.5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 09:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=urppZBfNFt0XJ3ZhcESG7TULR6plK7BmAb/zbSwQDp8=;
        b=o3a3iNSMsWwMI8Y20Q1ZqbfszHCrda/DokFv8WT3R06YwqLHyCk3o7Q2VO4FBGfful
         8/TYklRnQWmaJj6+zSLkIsIuIng1aBSUX3x1Kzmf20jb8DW5/3TsxhFN8LspTo28XrpI
         AmdGSGrwARlf7D8rFYMgOSfvB40taSFGsydXRELdRv5Jdj8ftqly/Jyb2BKB4OiK5Wvz
         VkWn40Fg50p5OjrJW/mGO4PCxzVWKPtdOnwnWIbprRjRBeF0yjfZ9Lem1fowKz8Q+A6j
         dynGNplaXhtgFBB7eWEEBXoDPFDQiVtF5ELANn1RFUvfa+jlY65x95ttljaye2345fZs
         QaKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=urppZBfNFt0XJ3ZhcESG7TULR6plK7BmAb/zbSwQDp8=;
        b=a5P8Ug9KYllBYe+dlHO6kn4jVa6bighlMzWWjtgybjMou/yUuytCZ6dL/ZDjsfBwjt
         97eUsJlD0zW53D9Gur4JRuSv799nA03DUg52/yh1dN1ZEpRD14L7mj+V+fztX5c0lxxv
         gvc9yHQu4aEXWGKyV/rZcrwOYsaYkHU66ByNOdNn5+gT5UbrJ4EkD6zjR43sAoQ+jkvz
         xF4QoLM3/5WuvnGu59cyt9OEwT+oYas22IyqNeKiZS5k+7jbf3AN3n9KOx4qFlRKhDOK
         InCVl3DD62cAQCutGEOZkuLvw04sfnhAV1ZXMkstt6nIISa9vSETbNAp2umHQyvFC4xX
         GSZw==
X-Gm-Message-State: ACrzQf1/w6f7/MO7XzFNhrQ4hOZj9/Fb6h4sHJ42qec8IKwsrlq6PSzM
        ddZT8DwiWCOChZuXn0CJ+cTXMf+RnWlMxFQvOUWSXQ==
X-Google-Smtp-Source: AMsMyM6It3+2j+zCgkl6u8Y+MHPUVoTqKr7o+Ow0VF1Q9QWhO8mAeIBq0NfhI8RqsxJEIFwO2j5pPV1V41nIRNdWByg=
X-Received: by 2002:a17:90b:3a88:b0:209:f35d:ad53 with SMTP id
 om8-20020a17090b3a8800b00209f35dad53mr11113376pjb.102.1666888536691; Thu, 27
 Oct 2022 09:35:36 -0700 (PDT)
MIME-Version: 1.0
References: <20221024210953.1572998-1-gwan-gyeong.mun@intel.com>
 <87mt9kppb6.wl-ashutosh.dixit@intel.com> <Y1ercgaqQwfqt42U@ashyti-mobl2.lan>
 <87ilk7pwrw.wl-ashutosh.dixit@intel.com> <Y1h8yn4QHI3aBlCe@ashyti-mobl2.lan>
In-Reply-To: <Y1h8yn4QHI3aBlCe@ashyti-mobl2.lan>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 27 Oct 2022 09:35:24 -0700
Message-ID: <CAKwvOdkpQvk31zbipLDPXfsDZ8FpGHs9t-+9JfFQO85Bs4h=wg@mail.gmail.com>
Subject: Re: [PATCH] drm/i915/hwmon: Fix a build error used with clang compiler
To:     Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
Cc:     "Dixit, Ashutosh" <ashutosh.dixit@intel.com>,
        anshuman.gupta@intel.com, intel-gfx@lists.freedesktop.org,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        Andi Shyti <andi.shyti@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
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

On Tue, Oct 25, 2022 at 5:18 PM Andi Shyti <andi.shyti@linux.intel.com> wrote:
>
> Hi Ashutosh,
>
> > But I'd wait to hear from clang/llvm folks first.
>
> Yeah! Looking forward to getting some ideas :)

Gwan-gyeong, which tree and set of configs are necessary to reproduce
the observed warning?

Warnings are treated as errors, so I don't want this breaking our CI.
-- 
Thanks,
~Nick Desaulniers
