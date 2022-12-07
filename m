Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 738D864543C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 07:47:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbiLGGqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 01:46:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbiLGGqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 01:46:11 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E81A453EEF
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 22:46:07 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id x28so9902370lfn.6
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 22:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UggBnOsrR1wkrKlJvT82Md2mFprFXQWOhZq6Vyy7RUo=;
        b=mCdlG2Bgc/f4NLCzy43WqBES4E8lPmklK7koyRdfChGfTWeS85kK7HHqqOJP8BIjS3
         QYx977jxzJ8U7TndfDGPoUlnX6VObd82cqQypwg94kjfdt2Io+tb1H96tFvX85/TF0rx
         lzk4O7hh59l8MjRx2OdlKMZmECT5vh/Oeg5j5M0fv7Ea1Hd5DWotLGYMLb/YbtYlstoY
         KS1luVzcvx0LpAUdHPue0E5ZiannpyztMjNk0XuHCscv7hWVuJAtMDc5TbfAdK6YFUYP
         GjwIsfXsvxZXV54MbiVtWAcrdveBvZW/3Rgfqg7gd+ABQDOAkE+9gWS0jlz0hCz1jYO7
         OWeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UggBnOsrR1wkrKlJvT82Md2mFprFXQWOhZq6Vyy7RUo=;
        b=Th1LKYxMKepMDb+z15fHxty3HUvij25ZAm1Y3zoQUoE44Dhkac5klazuVb8u6twBcv
         bvhWOvxjCjsdgvU/iuLRNP6M6eJsmzAOFA5gajWcz0ywV8T7cvSC4c96pN0DH9Chle8u
         PC21Zpjv8h6rImi3JXa5MCSHK3yDkNYip04aNsSfYcfd4ZRxmb1rF25ym1dwHxB5EWKc
         V1ld9lStytBhA/xaPX5HdVxvrNTBSocmuPXpalHz014aVWGldjEScM6V+1KML461QhUH
         dSSZLf60pJV58U6c1oNpR/pZbVXPYEejGmzt9wgqrDnvFFBzjqVHrMgxxC80ekEYwgy+
         aZQA==
X-Gm-Message-State: ANoB5pmj5/ewhoYQVqW8MkxDHnLnldsCpybeMQLtNeBJfiD5R9UwpmMk
        Yt/G8S9rVm8s+rQ6oqKwR1zfgT4qdZ9TsgWwuH/H+Q==
X-Google-Smtp-Source: AA0mqf75R2vTJ9LYkGzilSarQU81AXrkyaGMWGmYtfsvRnYLw6CFNWv6oHmlaI3sTnIQ+qBA+vfhN4eC63FSUJryZio=
X-Received: by 2002:a05:6512:25a8:b0:4b5:7bf5:f885 with SMTP id
 bf40-20020a05651225a800b004b57bf5f885mr3154248lfb.330.1670395566220; Tue, 06
 Dec 2022 22:46:06 -0800 (PST)
MIME-Version: 1.0
References: <20221206144134.1919987-1-yebin@huaweicloud.com>
In-Reply-To: <20221206144134.1919987-1-yebin@huaweicloud.com>
From:   Jun Nie <jun.nie@linaro.org>
Date:   Wed, 7 Dec 2022 14:44:12 +0800
Message-ID: <CABymUCN-WC5aCpVestRFpXVgZobxs48crUDX2419yvXxLgyjRQ@mail.gmail.com>
Subject: Re: [PATCH v2] ext4: fix kernel BUG in 'ext4_write_inline_data_end()'
To:     Ye Bin <yebin@huaweicloud.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        jack@suse.cz, Ye Bin <yebin10@huawei.com>,
        syzbot+4faa160fa96bfba639f8@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bin,

Thanks for the patch! The bug is reproduced with this patch. I can
help trigger another
test when you have new patch.
https://syzkaller.appspot.com/text?tag=CrashLog&x=16760797880000

Regards,
Jun
