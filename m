Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 818B566C2DE
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 15:55:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232342AbjAPOzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 09:55:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbjAPOyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 09:54:11 -0500
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1163D24483
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 06:43:19 -0800 (PST)
Received: by mail-ua1-x930.google.com with SMTP id g25so2502175uaw.8
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 06:43:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JrkHVNRmnhZL9c7e/tiK9zbteggD/bg2MaRxrtXICaA=;
        b=4hi68ap0w5TIliRa6FiT23ev6Yly6wfrRSYwDoOCoStkCiquhU9FZNpG8MYx+xhxp2
         B699t8NGWIyLGkZMc19aTewjSSwoO/KDMSqHMfXUBeWUUxq3zJtjE+/AAhaBrW4nJbOF
         Tp2TTirxp/AQcXahLlJe5a15vd3rmCxkISToBZXO8v8wIv8f3qwMsCIL6ZaXGdM7//po
         xec5EGqZSJFDy80Prpnytz7R3WV9o4mTvvGyju/ogWcAwmKLZlua9yvTAG0dCWexU9mj
         jNksVAB7Muc9KNbQDOtmEG1iJUu0W8D4Tbf6PX/i0Bz4pK4oXhhk9ui/tKq/X7IGDEn9
         7rog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JrkHVNRmnhZL9c7e/tiK9zbteggD/bg2MaRxrtXICaA=;
        b=rVSp3eZw9vHNy3XI9g/GWfIFjQBrpOmU8e4JSPlBsot0mO4B1jimyNHIxnlYY+xRIl
         kkfgmdBnzPIEjbPSEnT7/K60cJXODmRWfRqxtaBZYi+Zx+o8THW+1nVSzuXmqawwLnOy
         AmoCP6ydEEuP4fBRJSgkwsLxB9+zEE311belaOipD+qzc7cYnaOeE5f1H89Czud9+/cS
         RCo8BPjP0CRWP0VPWuUQDm7hjH+wxZhBdQWC5AKFqJEC3zAWlHwPLrLZfViCGN3VPh2B
         3Ee+LeGNPQX+xPs2/V8zJaGpJcQ2jwKjyHy9sYKEivdS+KtcLOe5UzaSXkejYxhIUPTM
         NUhQ==
X-Gm-Message-State: AFqh2kpix07uFCwivu2Klga/1m8Fg2j6O0BlPXsThU3WDYar+exEe2At
        kdAJnv/WQ6mOpDRPyG5tQk8e8dsWstLXXto58n934w==
X-Google-Smtp-Source: AMrXdXtyMquODUcwF8GI68Qc/1WycAYd52xwMGrrUlIOZhID3X1ycKOyqw6fPA9YoJfhslIgO5oXJDlTg8skb6vnyoo=
X-Received: by 2002:a9f:362c:0:b0:5d2:c6ce:7c41 with SMTP id
 r41-20020a9f362c000000b005d2c6ce7c41mr4591111uad.112.1673880198144; Mon, 16
 Jan 2023 06:43:18 -0800 (PST)
MIME-Version: 1.0
References: <Y8U9vrwzHVAyBZHK@francesco-nb.int.toradex.com>
 <CAMRc=Mc5YgWqRsmw=n6EV8PW5OZfMZYotiqSy=gSvHH1PbVN4w@mail.gmail.com>
 <CACMJSesujoLTRFXMRuA2tBAJhainmy6-CmoeuO8OwW9VifaiKw@mail.gmail.com>
 <10740fc72ae6fb7aeb7d5ea243495bc225ca656f.camel@toradex.com> <CAMRc=Me0ewbyGi+e2mxijsvLUqUZSF5nNCtUfONT2-q=U0VCLw@mail.gmail.com>
In-Reply-To: <CAMRc=Me0ewbyGi+e2mxijsvLUqUZSF5nNCtUfONT2-q=U0VCLw@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 16 Jan 2023 15:43:07 +0100
Message-ID: <CAMRc=Mc36r-Qoq3HDhhVqF+OOQ9YSfsw1wddnXfHFmjL32Q=1g@mail.gmail.com>
Subject: Re: spidev regression in 6.2-rc kernel
To:     Max Krummenacher <max.krummenacher@toradex.com>,
        "francesco@dolcini.it" <francesco@dolcini.it>
Cc:     "bartosz.golaszewski@linaro.org" <bartosz.golaszewski@linaro.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 16, 2023 at 2:45 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> Thanks Max, that makes sense now, working on a fix.
>
> Bart

Max, Francesco,

I've sent out a fix, please give it a spin and leave your Tested-by if
you don't mind.

Bart
