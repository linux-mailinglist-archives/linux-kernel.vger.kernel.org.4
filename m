Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E94E75F397E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 01:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbiJCXCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 19:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbiJCXCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 19:02:45 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D27F2D1F7
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 16:02:44 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id y2so7469224qkl.11
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 16:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=6VsJp9sS4qNsji9YfkYRRlTBglgWqR5JdV0cIEyNwGY=;
        b=cDtPmqgES0aE0aaU/VNCeB7zPh9/2Z8gBJnrHAQ9Irgc6sc3C6VdJM+aMr6FQlH7T8
         C7yigcPeMjnwk4RiPQWmTszf2st84DrAmO8CbqwK6b/6aDMzB0//SVXDN2YpxnhVu0pu
         o6yfzwnc5cFFcx5HS9OgCimzl8aJRM9ig/ECU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=6VsJp9sS4qNsji9YfkYRRlTBglgWqR5JdV0cIEyNwGY=;
        b=Zi+hnPXb4M/A0gJ09jdyepXOGCuaizA5slSoK6Q8SRGi6mcXn+2eMsUVN3JKWmJrdd
         YFlv5FSiljZnrjPQ6UYXFFJNCtpgG3jsAmuatRVHSrsfHjun+QHXgrkpNWlBn6xSTB3+
         Knq+xm/F0T8G58rA9I/BYYMhnfWdRSkYYjWn18lwcHJfgkzNVGo2cUqJ3cJStr5/0kB2
         stCDDk8dYHmoo0hy6rygx2XlSkbV2ucKZIRglRpxdEU0l3mb3uuymXwvkKUz7FqO2Cv0
         3qRoUwQOO+xHYI5TF5akTb4VFEMbamMla1kJAGgxJ+9UFvMU1ru9oisRlkbD+aiGr2Gs
         6eaA==
X-Gm-Message-State: ACrzQf3/QnUTf4RxtCDY6Zozjdds0pclxl2JqWTvu9NMGuTCRMa398dd
        8ly4Wv9wR5WM05g5+g9nyaHOlRmPADoAVQ==
X-Google-Smtp-Source: AMsMyM5y2H8DPy79qKVHhOm1BnL8IBtFKXP+G2jDSGsscDiqvCgWWzWBAdKAfoCLF20AnYgNKeL4yg==
X-Received: by 2002:ae9:ed86:0:b0:6cd:f5da:f133 with SMTP id c128-20020ae9ed86000000b006cdf5daf133mr15216936qkg.782.1664838163470;
        Mon, 03 Oct 2022 16:02:43 -0700 (PDT)
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com. [209.85.219.48])
        by smtp.gmail.com with ESMTPSA id h19-20020ac85153000000b0035d5e5660cbsm10602497qtn.59.2022.10.03.16.02.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Oct 2022 16:02:42 -0700 (PDT)
Received: by mail-qv1-f48.google.com with SMTP id de14so7680135qvb.5
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 16:02:42 -0700 (PDT)
X-Received: by 2002:ad4:5baf:0:b0:4b1:7a87:4f6c with SMTP id
 15-20020ad45baf000000b004b17a874f6cmr9802897qvq.117.1664838162390; Mon, 03
 Oct 2022 16:02:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220926220134.2633692-1-khazhy@google.com> <3362d316-0c86-ecaf-4422-d12ee115a2eb@nvidia.com>
In-Reply-To: <3362d316-0c86-ecaf-4422-d12ee115a2eb@nvidia.com>
From:   Khazhy Kumykov <khazhy@chromium.org>
Date:   Mon, 3 Oct 2022 16:02:31 -0700
X-Gmail-Original-Message-ID: <CACGdZYLrwi2a=0b0sEtjpsZptZxR_0jcNSckrrACcospuicYDA@mail.gmail.com>
Message-ID: <CACGdZYLrwi2a=0b0sEtjpsZptZxR_0jcNSckrrACcospuicYDA@mail.gmail.com>
Subject: Re: [PATCH] block: allow specifying default iosched in config
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gentle ping now that the merge window is open :)
