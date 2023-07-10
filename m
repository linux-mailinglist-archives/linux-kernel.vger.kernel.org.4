Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF8C774D73C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 15:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbjGJNRX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 09:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjGJNRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 09:17:21 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F9AE9
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 06:16:56 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4fbc0314a7bso6963424e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 06:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1688995014; x=1691587014;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=F4n0uH620C2sWk1GmzpQB7W6JnujnPRr8xlLs9TDOuw=;
        b=UHFBRtl6stRiqdz+gvR0Ggfua66yR1rcgejJmNDmKj25AqPb0Lo3RljiAOsydCV2xT
         1AXHRyZoba5W3p7Z0MDUhTptDC0wlJd/zb1adRVOe2aS2uuvkvXNgTCljRGRU7SdHN1a
         POkQz/8qmaeO9lHZdKlWzEUGMb1C7VGd5sYyWBrU1z+pPCjlYnXih/seJGfXwKFNit33
         n9zPqN58mdbanfR7b1/v1idIhmJvqcOeZDQszOZ/DoGzACBG2XWfGZwfZNWVEa/YB2nV
         3qsGlCJEOubBVvRBYv+cpvo+Gcl7oxo9q/3J0evbOBZuwOLMObqRME71/h7ss3BRhYsb
         hmJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688995014; x=1691587014;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F4n0uH620C2sWk1GmzpQB7W6JnujnPRr8xlLs9TDOuw=;
        b=QfruU0OwSx2P4XwBGL3KI+uryjkO00P8AvrPhSJ3rOFcGsE0Z0LMC/j982/vWOhcLY
         B1BBMh9W50EaDV5j74ofB2MsvGskoguS+Sv9IQzvaqUcIbeaagKwo9VhqflPWQJMSoUj
         7WYXtf23bXdqXu69QbgHCfBiafh8kxWHGCvOme+9OIMgP6aLZAFSsXNhwRMpFiCmBCwi
         NXXrLKzpMpuxBDuNNrtdfBUsgT2H9IRwgcNrBI6vJzxmkeaWki6oKDc5ktHj72mxioYh
         dx8tVdYWoSpdloZaWlUbJ2Jh8SYFWlJ15Og4XnUcOHX99pxdE4sLwESI0OM04M5V4Tu/
         pcBQ==
X-Gm-Message-State: ABy/qLZWbK8NmMnBHnuOKd7acnVh3bQCoW7Sv9PM39XP04L/y8ePrO/q
        fVUPv3T/+WsPZQDajfcJM5KhlwoY4filjEOn0FvxSA==
X-Google-Smtp-Source: APBJJlECk0IdfI/txKD8DxyQxVreN7bf/a8GY0kNcS71aeW8pnW+ghnKKJLPA0xx83fjuWNTOzC6tjlQeE7Z0VxVW1k=
X-Received: by 2002:a05:6512:32d0:b0:4f8:6dfd:faa0 with SMTP id
 f16-20020a05651232d000b004f86dfdfaa0mr9434275lfg.2.1688995014501; Mon, 10 Jul
 2023 06:16:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230707044613.1169103-1-hezhongkun.hzk@bytedance.com>
 <ZKfFVfZovt4PnMsy@dhcp22.suse.cz> <CACSyD1M9rSadO7xb8-H0dU2-xtrZnJMBgqEMTSHhE6M5vFgC-Q@mail.gmail.com>
 <ZKgk0HfuuxsyBBXI@dhcp22.suse.cz> <CACSyD1NX7sfPu2Wi1ep0gJ-wt1O8-+++321Uhw4YK1Uz4rxj-g@mail.gmail.com>
 <ZKvgTTqwTnUXiY3m@dhcp22.suse.cz>
In-Reply-To: <ZKvgTTqwTnUXiY3m@dhcp22.suse.cz>
From:   =?UTF-8?B?6LS65Lit5Z2k?= <hezhongkun.hzk@bytedance.com>
Date:   Mon, 10 Jul 2023 21:16:42 +0800
Message-ID: <CACSyD1NkvXuyjUEc_pb_89B-5XyBd8sSSD1XmKKkDBssMV5FhA@mail.gmail.com>
Subject: Re: [External] Re: [RFC PATCH 0/2] zram: objects charge to mem_cgroup
To:     Michal Hocko <mhocko@suse.com>
Cc:     minchan@kernel.org, senozhatsky@chromium.org, david@redhat.com,
        yosryahmed@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> OK, this is an important detail to mention. Also have tried to get some
> numbers of how much excess is happening for a mixed bag of compressible
> memory?

Yes, I've done the test many times.  The numbers of excess depend on the
compression ratio only. The maximum amount will not exceed 400KB,and will be
smaller than the hard limit finally.

> --
> Michal Hocko
> SUSE Labs
