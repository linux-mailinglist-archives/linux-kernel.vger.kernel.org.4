Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17970617519
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 04:37:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbiKCDhP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 23:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231143AbiKCDhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 23:37:05 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF9D41580B
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 20:37:02 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id v4-20020a17090a088400b00212cb0ed97eso641936pjc.5
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 20:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0VxL6xNBl5lCDUhZ3i3gS+DLrovMzwSN/smbDEMEamg=;
        b=QMR1UHOQfYvoMqfuhWjmpZHjJOXvYvq6UWFMJIJYKwH4MfjyX326OiYfmwVBOgACFz
         teJPjG4nbnuRED4D+QWfz0A4tbFi3twqL1Sw7y4yoEqmdUw1oTl2zmaM3BApf1F765qU
         OPC31ZbHajmw8WU4gxHaJ5yEpuBPEUWuxYb6E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0VxL6xNBl5lCDUhZ3i3gS+DLrovMzwSN/smbDEMEamg=;
        b=vUF0NsF3+t8pQugjNiy00BiZHpZhlynl2K+U505ghk4+2mYGajSdNwbdlBBAM9fvaC
         H2NFlzt9TOr/AwK980Ccg7yjnssF5XPDhp0sW49YNzOFLIuA4lo+MwT4SSkQ3+XeBaKW
         KK25xEaUjfnX6yjopMr7mJTVQBc9Q9upanyB1r8mC4mD2IjVB4nmJSdy1jrakEtC6IWs
         z6w8qTUeo7fl70mRF7HFRW7vl82TbjK2APSCBLGVAJEXEZemW6wH89mvpBs9wl/Zydca
         97kRecHLQ5OM4FxppSzAVgLMeQrMaGEKraXNRDue3VeHwpBkJa3RULEI1dLHjnO2TbA6
         5EGQ==
X-Gm-Message-State: ACrzQf0lDTre4s2Aag28fXsY3+1KHI0PQuqXy9YUHIHXqYHZKBtDrSkI
        vmG4gvSiVD70YWmcY1bdN7a0kg==
X-Google-Smtp-Source: AMsMyM5DLnQG4KKQycClyilkhFBM/IejNoUE0OOKLcC1g2jkCMEyQfdF8+S7DCDMDBJOBtVfZT7i0w==
X-Received: by 2002:a17:90a:a087:b0:213:ba17:2c8c with SMTP id r7-20020a17090aa08700b00213ba172c8cmr25438386pjp.80.1667446622441;
        Wed, 02 Nov 2022 20:37:02 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:f22:e30:374d:5a2b])
        by smtp.gmail.com with ESMTPSA id a15-20020aa795af000000b0056bb99db338sm9496419pfk.175.2022.11.02.20.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 20:37:02 -0700 (PDT)
Date:   Thu, 3 Nov 2022 12:36:57 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCHv4 0/9] zram: Support multiple compression streams
Message-ID: <Y2M3WVw/2L/f3S7I@google.com>
References: <20221018045533.2396670-1-senozhatsky@chromium.org>
 <Y2LN+tMDkVo/7XTI@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2LN+tMDkVo/7XTI@google.com>
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Minchan,

On (22/11/02 13:07), Minchan Kim wrote:
[..]
> Hi Sergey,
> 
> First of all, I am really sorry to attend the party too late.
> 
> I absolutely agree the feature is really useful and even I am
> thinking to support multiple comression trials on the fly for
> future. So I'd like to introduce the feature more general shape
> to be extended later so review will go.

On the fly recompression (from the same context) was what I had as
a first version (which was internal and was never published), and
we didn't like it at all. It's too limited, has zero flexibility,
zero extensibility and has too high of a price tag attached to it
(in terms of CPU cycles, power and time).

So we moved it to user-space (deferred context) and this unlocked
numerous possibilities: recompress only when we really need to and,
more importantly, can afford it; wire in numerous metrics: battery,
CPU load etc. And many more.
