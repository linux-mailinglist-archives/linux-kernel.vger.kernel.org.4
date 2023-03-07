Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB7916ADA40
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 10:24:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbjCGJYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 04:24:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbjCGJYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 04:24:13 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D8CD231F8;
        Tue,  7 Mar 2023 01:23:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 44313CE1B22;
        Tue,  7 Mar 2023 09:23:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A50BC4339B;
        Tue,  7 Mar 2023 09:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678181015;
        bh=FEZ229MXqpUyWWN79hzsTRn3rF6R//LPmlIOiK5Hx7A=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=Ms/4SzaLvkspmawWz6fzoBC1eyyc4Zujhw9JpUcQxjTYiE3NBZ4sZlpxUZbPs+0O8
         ir0vGCB2U27gaKko54HJZFSNsmILy56V1mybyaodGimHT3TIgwHer+AIo6tRouqmFN
         cGSn5i2y4MeWvh8aIy+Vabm3D1nkK8km12FUlJjUwyUzWebCk72zwu32nTj97FaPcj
         QMaQum6DCdgZkPyptx1oiDaemXikacuVMZD4P98sG1ULdbt3H5mJh2oJG6uhYGGB39
         /SzSdg3IMIM0GSZpAGp0uq8LmJKsgeMBL4cR/AED3FB1ofklF1Lj6d/jl6CZ2CqLN4
         Tfh7hrp9aHfcw==
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-17638494edbso14397894fac.10;
        Tue, 07 Mar 2023 01:23:35 -0800 (PST)
X-Gm-Message-State: AO0yUKV56LGh2MXalchLEADXmjpjBoqOGwDdnjOvWTJKW8yb39g8Q6+V
        6jVHOitPrqlfCBeIotoMD2O373Yq32PIdRKNB9c=
X-Google-Smtp-Source: AK7set90FjnIwljK7YG3xS28HA5GyL8jhH4ZvsToFFrR+AAM5DjC1HfuLtWqI0lzYQSR4B6NdxctYjFhZbcrPGBQS5k=
X-Received: by 2002:a05:6870:4356:b0:176:6103:6dc5 with SMTP id
 x22-20020a056870435600b0017661036dc5mr4847265oah.11.1678181014462; Tue, 07
 Mar 2023 01:23:34 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ac9:67ca:0:b0:4c2:5d59:8c51 with HTTP; Tue, 7 Mar 2023
 01:23:34 -0800 (PST)
In-Reply-To: <20230302135804.2583061-1-chenxiaosong2@huawei.com>
References: <20230302135804.2583061-1-chenxiaosong2@huawei.com>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Tue, 7 Mar 2023 18:23:34 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-262k5tdiqPKMsNi58iUwvs-ntGG833B9933aSUDXFHQ@mail.gmail.com>
Message-ID: <CAKYAXd-262k5tdiqPKMsNi58iUwvs-ntGG833B9933aSUDXFHQ@mail.gmail.com>
Subject: Re: [PATCH] ksmbd: fix possible refcount leak in smb2_open()
To:     ChenXiaoSong <chenxiaosong2@huawei.com>
Cc:     sfrench@samba.org, senozhatsky@chromium.org, lsahlber@redhat.com,
        hyc.lee@gmail.com, linux-cifs@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        zhangxiaoxu5@huawei.com, yanaijie@huawei.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2023-03-02 22:58 GMT+09:00, ChenXiaoSong <chenxiaosong2@huawei.com>:
> Reference count of acls will leak when memory allocation fails. Fix this
> by adding the missing posix_acl_release().
>
> Fixes: e2f34481b24d ("cifsd: add server-side procedures for SMB3")
> Signed-off-by: ChenXiaoSong <chenxiaosong2@huawei.com>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>

Thanks for your patch!
