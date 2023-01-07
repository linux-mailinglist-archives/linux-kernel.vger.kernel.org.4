Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE409660B21
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 01:57:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236690AbjAGA5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 19:57:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236318AbjAGA5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 19:57:10 -0500
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A6D27FEF2
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 16:57:09 -0800 (PST)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-4a0d6cb12c5so43587597b3.7
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jan 2023 16:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=G4ygQMnbfTZ6EBQJgmZlXK4asyIqXnkbEOYVxlcrFGg=;
        b=MQ8visknR84o9KYmWTCrCfB8TwLXgQEjNsWWg1GkBnsC5tkWFPsJWAGY2J9kTBBpYt
         QSlO4sDXVVeMUobVQSpdcA9wO8J//Arw6IpcPyjXCcRtFbu6v8yzw2/VNtCuqlMBd52j
         KN36UynejxQJA6vULLUCbPBVPyR6+yEutLbJ+Zmhvayb6uOTw3txkPMS9hOdqdLipGmU
         fGObSFUnXzJBNVeIc2z5FMD66ZpLUCcL8aeyQw/5sZdImpJmI9TKQ+fxg9kX8mbtcoKg
         PK2Y/SVQcROFrQylJSTYKIFI5OGUgAh0DyCQD5+oebUTP+/3jAw+tAqvRwgeka9wdg/X
         sg7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G4ygQMnbfTZ6EBQJgmZlXK4asyIqXnkbEOYVxlcrFGg=;
        b=bIqI7Ox4mTGkSlo1F8mDuJg9pGJvicGfhSD85UubaCH2YoaPjvbFmfF72qPQtiwMpo
         p7NM6Mfp5XmQCT1GbxyXopv96TsyDcAaqEwxVXFHNJv57FLXl1vxDzb1Xm1Zcm44dsFS
         uLq26UsWmvTrcKehAXhkPaMDtR/EDUHXcY9vHBmL56Iafxbv18I0Aw4szVGOaCKYgQij
         zqJqaU6qzheobiqqwBK2EFTSQszhKqCwYeMz3RCxp2+wUPvIKl3/uN8wBDmqS/LU4mr+
         /PlGpaY+Ry5GsO6nSE1XF9mzj1C0E9yAj1YSc6tWgydr5QizkfNAn8HUbCuYWvxLRNDX
         f9xQ==
X-Gm-Message-State: AFqh2kpyNN7N/IFjuDbmwE3r6Kvd9UDJW2WgVVxUN7U3Facws2lKk3uw
        3SeFZh5cQQbJBD6G2hnmamsRoZpBnzJu73Mdvy+YXgSmQTpZlCbjuKg=
X-Google-Smtp-Source: AMrXdXtqXeedSVZjIGtdNBjmIu580m6APnU5FTyzj1lTOYK+9c3rRuITwL+GfYyyBwZ0uUE3ztkMxbTbv57Tvdo2IGs=
X-Received: by 2002:a81:7343:0:b0:484:a94f:210 with SMTP id
 o64-20020a817343000000b00484a94f0210mr4609833ywc.129.1673053029127; Fri, 06
 Jan 2023 16:57:09 -0800 (PST)
MIME-Version: 1.0
References: <20230106143002.1434266-1-steve@sk2.org>
In-Reply-To: <20230106143002.1434266-1-steve@sk2.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sat, 7 Jan 2023 01:56:58 +0100
Message-ID: <CANiq72=jLOsDPCWSMT3sxBSYoe=UtvLyQXdTZE+PsCrhb34gpg@mail.gmail.com>
Subject: Re: [PATCH v2] auxdisplay: ht16k33: Use backlight helper
To:     Stephen Kitt <steve@sk2.org>,
        Robin van der Gracht <robin@protonic.nl>
Cc:     Miguel Ojeda <ojeda@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 6, 2023 at 3:30 PM Stephen Kitt <steve@sk2.org> wrote:
>
>     Changes since v1: mention BL_CORE_SUSPENDED.

Thanks Stephen.

Robin, it would be great to get your ack/review (or if you can give it
a quick test, that would be great too).

Cheers,
Miguel
