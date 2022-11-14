Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84FD16279DB
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 11:00:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237129AbiKNKAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 05:00:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236841AbiKNJ7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 04:59:43 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51AEB201A1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 01:57:51 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id f5so26958818ejc.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 01:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g1LCiKWkAngOCMZs2BOrkAiMYS+xuvcOMxc9v906b0g=;
        b=fw3IOir+wK621jjhytLUR3HRpXea6nvokGxDGqr9LMVErtI4UrPyIfcXRr/kuFE6W3
         fsrJ9hmrGLzSXk0WXDRNtUVDIXus9euFGVmtQ3X3NMmcue/Y0Nh3ZUPVtupDIVdnc/YY
         DscN8sAnhVPIBIj78jyjRhUlzggR134pnX0F8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=g1LCiKWkAngOCMZs2BOrkAiMYS+xuvcOMxc9v906b0g=;
        b=5X27OPc+f2kY/wSjQ+OP/Jm2VjBsoZDYw/s8IUa59G0M5cA3sGtrEorpMdNH1HJpDn
         g3G6adRnAW30zx9CVGU0P5K9XDBVekKQO25I3L6C3DSOxUWGeYCzl0UBHHG6IgVjeKSz
         BAwXLfYXnj1IsXhPMxrhDotUFgA9V9ek3n0+ex552yjBNNYyXeTxgsnVZhTRPhuCPAHC
         JTfC+ck0gIA+oowh0HCuINTCnHyfqHXDuhQ74B8nUDdp5WlnkFeTqXKF62BZSy4qZ3DM
         TMz3jkS2tiajewVot0jOw4qhwWdj675+5Upj6JjLCPOwoZ9nwR5w1m03kUzWDPIJk/mz
         jQ3w==
X-Gm-Message-State: ANoB5pl5qEyct6CDV/SwcRQG2vNsk9OXWmGppszt7qedR7a+1iB+8pRH
        BL5X3FeIeO/aqoP2WbCXojqDsQ==
X-Google-Smtp-Source: AA0mqf4lp53u7quF2EADkWo0M0W4uo6u5+OG9vQl1heyj6jEVm7mI2d32I3SbNtG8+VAordGPL69Fw==
X-Received: by 2002:a17:906:24d9:b0:7ad:2da5:36e1 with SMTP id f25-20020a17090624d900b007ad2da536e1mr9033958ejb.548.1668419869833;
        Mon, 14 Nov 2022 01:57:49 -0800 (PST)
Received: from cloudflare.com (79.184.204.15.ipv4.supernova.orange.pl. [79.184.204.15])
        by smtp.gmail.com with ESMTPSA id qo14-20020a170907874e00b007adf2e4c6f7sm3965723ejc.195.2022.11.14.01.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 01:57:49 -0800 (PST)
References: <20221110113034.17563-1-jakub@cloudflare.com>
 <CAC5umyhw=V1O_cC+Q4=XSye7htJ1aSAhMmbqSe7TngsohhuQ6w@mail.gmail.com>
User-agent: mu4e 1.6.10; emacs 27.2
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Akinobu Mita <akinobu.mita@gmail.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@cloudflare.com,
        linux-kbuild@vger.kernel.org, x86@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Wei Yongjun <weiyongjun1@huawei.com>
Subject: Re: [PATCH] fault-inject: Enable stacktrace filter for x86-64
Date:   Mon, 14 Nov 2022 10:56:26 +0100
In-reply-to: <CAC5umyhw=V1O_cC+Q4=XSye7htJ1aSAhMmbqSe7TngsohhuQ6w@mail.gmail.com>
Message-ID: <87a64too2r.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 12, 2022 at 01:41 AM +09, Akinobu Mita wrote:
> 2022=E5=B9=B411=E6=9C=8810=E6=97=A5(=E6=9C=A8) 20:30 Jakub Sitnicki <jaku=
b@cloudflare.com>:
>>
>> Stacktrace filtering for fault injection has been disabled on x86-64 sin=
ce
>> 2007 due to the lack of a DWARF unwinder. See commit 6d690dcac92a ("fault
>> injection: disable stacktrace filter for x86-64").
>>
>> In 2017, the ORC unwider, an alternative to DWARF unwinder has been added
>> in commit ee9f8fce9964 ("x86/unwind: Add the ORC unwinder").
>>
>> We can now re-enable the stacktrace filter for x86-64.
>
> The same change by Wei Yongjun is already in the linux-next via -mm tree.
>
> But thank you for the good explanation.

Thanks for letting me know. Will check linux-next next time.

Please ignore my patch. Sorry for the noise.
