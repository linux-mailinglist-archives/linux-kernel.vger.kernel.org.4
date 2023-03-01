Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0B256A6939
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 09:55:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjCAIzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 03:55:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbjCAIzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 03:55:51 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B73311D2
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 00:55:50 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id m8-20020a17090a4d8800b002377bced051so16568175pjh.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 00:55:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3PME0vYl4W7bdOakpW6RwisA55LnP676psaYUNk5FkU=;
        b=GHJuevaQRHYZJVJJ5LVZYB1oPKi95eeUiUaCrbzC5beBXqOU/ZAg9gZ/nt9NGjQA+8
         ktMGhQsR6KCRleV581Qvc4Ai0pjdNMqZnXYcrDF5otbpcAa0euJiA3j68ZC6mPEVyt1v
         j5lzjl2JEQ8f8lccLipZe4h43WHcODIItDUkk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3PME0vYl4W7bdOakpW6RwisA55LnP676psaYUNk5FkU=;
        b=R38CH710I0lLKtQWA3Yd86ZroJ2JE9PgMsPJWz+XYzX89JhNyw249vaJ77ecfdLGEY
         6RuqSkyvwncdO/96b8vOyd4hTxWt6d4pye/TaNJQwPYs0u027Fe5q/IMT/CKe0DcgRco
         XpgQ4d1vgNdaAeHPFkTK36AgsDcKHaVcEzYtroSMrB9PFmUJ1giuTpLRWNcIvK0FB2yd
         f15OkpvK914SVQcgz1xfkQD4jwGUIXVoijrEBdTozxRlD1LgEJnrqDsEt8Wma2C20PR/
         EI202ybwG/AA1eDEYStL8YmQGVHyfVaJ7gydB8DiqvZQcnjLqxzIGb+Sirfr9Su3CoCu
         2qCw==
X-Gm-Message-State: AO0yUKUhkgQg6Ye5XiNc03uvZlYBXDm4htIc3cij/C2Ux5iKXFrYxvQO
        yNb4bYysoh580RGiawFbyd8iPw==
X-Google-Smtp-Source: AK7set9IWfcyD+xbHaCV5vyOBZLGwnnkWv0tyY+6e3P6CXhbUECiB9tCdBHFEjQFeqblj2I3GCQEcQ==
X-Received: by 2002:a05:6a21:3391:b0:cd:2952:7b69 with SMTP id yy17-20020a056a21339100b000cd29527b69mr7845624pzb.52.1677660949699;
        Wed, 01 Mar 2023 00:55:49 -0800 (PST)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id d7-20020aa78147000000b005ccbe5346ebsm7318876pfn.163.2023.03.01.00.55.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 00:55:49 -0800 (PST)
Date:   Wed, 1 Mar 2023 17:55:44 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yosry Ahmed <yosryahmed@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCHv2 3/6] zsmalloc: fine-grained inuse ratio based fullness
 grouping
Message-ID: <Y/8TENp78WSQ0UW3@google.com>
References: <20230223030451.543162-1-senozhatsky@chromium.org>
 <20230223030451.543162-4-senozhatsky@chromium.org>
 <Y/f2WvhNlwhsf2Cz@google.com>
 <Y/riPlQ2UK00WirI@google.com>
 <Y/6GAYJ4c9W0bPzp@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/6GAYJ4c9W0bPzp@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/02/28 14:53), Minchan Kim wrote:
> BTW, I still prefer the enum instead of 10 define.
> 
> enum fullness_group {
>     ZS_EMPTY,
>     ZS_INUSE_RATIO_MIN,
>     ZS_INUSE_RATIO_ALMOST_FULL = 7,
>     ZS_INUSE_RATIO_MAX = 10,
>     ZS_FULL,
>     NR_ZS_FULLNESS,
> }

For educational purposes, may I ask what do enums give us? We
always use integers - int:4 in zspage fullness, int for arrays
offsets and we cast to plain integers in get/set stats. So those
enums exist only at declaration point, and plain int otherwise.
What are the benefits over #defines?
