Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 860706470DB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 14:35:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbiLHNfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 08:35:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbiLHNfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 08:35:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A504A89AD1;
        Thu,  8 Dec 2022 05:35:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 379F661F24;
        Thu,  8 Dec 2022 13:35:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 935B5C43470;
        Thu,  8 Dec 2022 13:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670506518;
        bh=sTzRjyxijHPruFuQWxY2Ukotxs42BSGOh9sw0YwCzc0=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=CZ57Mp2jVybYIVcp0MO9ZLEKnR5NEpWMJrUGtgtDuNNFQqgSdEoiwIbQFcVHt8FRM
         8qRBvK6tsd80hCsS3GkkBz3Ed8uavZuL9zy+if22xXxeO5X2UYoHymNAEyjNNa9K1y
         7oHUdBdEFXNz/8HU4UsOiSrWChyd0ngKo/prVTAsuoI0zGoMJcpm/lCW+KE5oh8SGr
         Mecl0RfVtMG923gqK/F2m2XLJH1kYXHf5OyvcLa7XGrBPySttBqjkG+D0Hs4TIYdtt
         rbVFPRl2kvI3HUjFh79vjLlmVOMrkAcBgrgTEi1HF53w63sToNcf2HttoFUx+cMPyb
         a4HKv7mtdvvow==
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-14455716674so1830073fac.7;
        Thu, 08 Dec 2022 05:35:18 -0800 (PST)
X-Gm-Message-State: ANoB5pli24Krv1WR9PoPZ9+mf0zMOsdSWjOXNlWiy1yDFreGMKVYEKiO
        wxny8taUd6C52/6GCq7iUaYAUSyxc8r2thmVs2I=
X-Google-Smtp-Source: AA0mqf4Exhr+Obxbk34lh9V02lpbEw36wYAUf+fBs3ETMd2tUcAZzaHIZGiP20zWqkdObqLvtUYzuridOhmFqOvKR5o=
X-Received: by 2002:a05:6870:430a:b0:13d:5167:43e3 with SMTP id
 w10-20020a056870430a00b0013d516743e3mr44096197oah.257.1670506517677; Thu, 08
 Dec 2022 05:35:17 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6839:1a4e:0:0:0:0 with HTTP; Thu, 8 Dec 2022 05:35:17
 -0800 (PST)
In-Reply-To: <202212070929276734686@zte.com.cn>
References: <202212070929276734686@zte.com.cn>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Thu, 8 Dec 2022 22:35:17 +0900
X-Gmail-Original-Message-ID: <CAKYAXd94Ug06LGL88q52b-MNijSHeJPoGFYFfXkjuZSW1ZVDwg@mail.gmail.com>
Message-ID: <CAKYAXd94Ug06LGL88q52b-MNijSHeJPoGFYFfXkjuZSW1ZVDwg@mail.gmail.com>
Subject: Re: [PATCH] ksmbd: Convert to use sysfs_emit()/sysfs_emit_at() APIs
To:     ye.xingchen@zte.com.cn
Cc:     sfrench@samba.org, senozhatsky@chromium.org, tom@talpey.com,
        linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2022-12-07 10:29 GMT+09:00, ye.xingchen@zte.com.cn <ye.xingchen@zte.com.cn>:
> From: ye xingchen <ye.xingchen@zte.com.cn>
>
> Follow the advice of the Documentation/filesystems/sysfs.rst and show()
> should only use sysfs_emit() or sysfs_emit_at() when formatting the
> value to be returned to user space.
>
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>

Thanks!
