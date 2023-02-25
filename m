Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C42DC6A26F7
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 04:33:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbjBYDdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 22:33:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjBYDde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 22:33:34 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1096F170A
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 19:33:32 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id s26so4799583edw.11
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 19:33:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=D6emmK/84159cRFlNViGvusDlD5gFIIfsUoa5uDy+co=;
        b=QH02ClObWdS4jvMlh+O8aUUUTPBFxzMq6ZZc2YNNvzr7GAUVW9Eu5Ac38LvVnsbxB2
         zEJKFVFyqZblmo2NO8AYVhrFek/FxLA8unrsXVU9+1SxEZnlU6AJqqG6oGZr/9FqFfnu
         OiDMh6HNfHjBu/x6z6L2VWS47OrAjc5NVd3Yc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D6emmK/84159cRFlNViGvusDlD5gFIIfsUoa5uDy+co=;
        b=YAy+TxYXU+JfFKmlh/YwScuefBwYm7TmBteRwgUaYIZAiGbuDuJ3tt2hgwO512XsNj
         L3lpESjj2846Xwe3F8LBO1yhNX9+uSWDMqXS3tqTyOg9eawlKK2yla4L57tXKYSikw35
         xJrNtwhuafmKl05pB95e8D9aK8T1t+6SsID9HBJQGABuxsk1qyRDJZpk0nWfj7LqOsBm
         Am6CcxxlvRRwt7TXqCvEscBFSHSUdE0A6b50fw/wS9CoAuw9NHNYhBoCFn6Z1dHP6jaB
         zU2ZS/zRIZ7KFs5pdkYF+RViug7MChfKZmCEnkdSOJAGS/ZnXqVg3D2soi5JraNxzkit
         Cl9Q==
X-Gm-Message-State: AO0yUKUkLqVLLdyP/5IUoXYmt4YRmdt1mYkbIUyCojFvYKkhJHlQ3sKB
        2wAuh1wQ3Zla69RkFQr9Bucn7lKVFfESu/rwssv7kw==
X-Google-Smtp-Source: AK7set/IbSUKnwncsnlhBCqQLJr2cH2y+ivnCnijEPMnvTNnxqZM8UBhB644cou1QHFlIuHLDPbAQA==
X-Received: by 2002:a17:906:7c96:b0:8b1:387b:c0c8 with SMTP id w22-20020a1709067c9600b008b1387bc0c8mr23618137ejo.15.1677296010281;
        Fri, 24 Feb 2023 19:33:30 -0800 (PST)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id jy25-20020a170907763900b008e2dfc6382asm329010ejc.125.2023.02.24.19.33.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Feb 2023 19:33:29 -0800 (PST)
Received: by mail-ed1-f45.google.com with SMTP id o12so4846933edb.9
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 19:33:29 -0800 (PST)
X-Received: by 2002:a50:aa9e:0:b0:4ac:b616:4ba9 with SMTP id
 q30-20020a50aa9e000000b004acb6164ba9mr8454339edc.5.1677296009264; Fri, 24 Feb
 2023 19:33:29 -0800 (PST)
MIME-Version: 1.0
References: <Y/gxyQA+yKJECwyp@ZenIV>
In-Reply-To: <Y/gxyQA+yKJECwyp@ZenIV>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 24 Feb 2023 19:33:12 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiPHkYmiFY_O=7MK-vbWtLEiRP90ufugj1H1QFeiLPoVw@mail.gmail.com>
Message-ID: <CAHk-=wiPHkYmiFY_O=7MK-vbWtLEiRP90ufugj1H1QFeiLPoVw@mail.gmail.com>
Subject: Re: [git pull] vfs.git misc bits
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2023 at 7:41 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> That should cover the rest of what I had in -next; I'd been sick for
> several weeks, so a lot of pending stuff I hoped to put into -next
> is going to miss this window ;-/

Does that include the uaccess fixes for weird architectures?

I was hoping that was coming...

               Linus
