Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46EFC6D20AE
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 14:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232032AbjCaMpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 08:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231982AbjCaMpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 08:45:10 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A2920C3C
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 05:44:45 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id i6so27246401ybu.8
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 05:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680266683;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UvnUgg3Ls+y40iXDGkVLpdvDFg3PxVYT5UY/vybmeUY=;
        b=AyvQyanPhZ2U65WSbl3U2gnJhBvk5I1pvBowGb4eu0YPLDxrexuaapupCblmoSjJFn
         n43oVIkoEBbUK4Mjaz6pN4HjGoCLa5L4dGDPxRkIPWptKo4c7kHc2kNyFlSO6ckKaoEJ
         /cBhvFTeIeFKqlBEcG48j+qDzUaYdwG7aiU/a3/G/KFQbNPKlbRCnxa3DFPX92RB3yXF
         IEJXC5OPgIrHH/Zs8UOFCPyXAmTTuIhMyiwd7NfeNYr0r0J0zk7b+NuyGkrYZG0DGWCU
         Bjfi2tfambOUhCwWZrXMNMroQJgER+2bgrzt3D2WuuLFK+LAwSzQeLBF2HJBzB9YWQ0W
         nueQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680266683;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UvnUgg3Ls+y40iXDGkVLpdvDFg3PxVYT5UY/vybmeUY=;
        b=pDn+BlVkIS5XoDJ69c/LoUKxHphfSLKk17UZ9OeSItR7zD++/KR1T1wfKRrOXI9PWQ
         bGaOiuPHrS9sSyoAqyOUj0iOL5JY3DV3tOznnVKlY+xFJBd6gmyEKS9ICIarBSWn4Rci
         bbPV8Of/T5owsCC0X2XkUAZsF8oOYaATVjMtjuxAH3gW8CAOP7nUEZK2ylukBqL5Liv+
         iFRiKud/AlM7rEMnmSYCaborBwTMng8IXKilpfXlelpkNYG2uY3reImXkIzVJT5s9yE/
         OxYwc+QoN7Ek4D0no8yS5aUPJNFyfwOPRYg1nScj/iNkcWIIsgqKnTgcTZKt3amqWjpg
         tuhQ==
X-Gm-Message-State: AAQBX9dvUPBN5kP6EiVlizUA5Bv+To/ClZejTnQksAZKajWd6ZfGzV93
        ahA152Du6AnR24CDok5Hr3a4mHTLneRQqWweZpBSt7qzSEGdfq3XX9U=
X-Google-Smtp-Source: AKy350ZfukvvUVBE8HkdYcE0VnaqMDsyvNCK3EB2uK31jEKrZFLWrWk9cL27Ex4/2aohMlmoktdbs/xWrAOBIT+O7vk=
X-Received: by 2002:a05:6902:1083:b0:b75:8ac3:d5da with SMTP id
 v3-20020a056902108300b00b758ac3d5damr13776701ybu.4.1680266682909; Fri, 31 Mar
 2023 05:44:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230331093318.82288-1-gregkh@linuxfoundation.org> <20230331093318.82288-2-gregkh@linuxfoundation.org>
In-Reply-To: <20230331093318.82288-2-gregkh@linuxfoundation.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 31 Mar 2023 14:44:31 +0200
Message-ID: <CACRpkdb0jxDjyMcH-hT1LJU7hDjqUG0nuoxR1PLCpeWNmo=YSg@mail.gmail.com>
Subject: Re: [PATCH 2/7] driver core: create class_is_registered()
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>,
        Sebastian Reichel <sre@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-gpio@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 31, 2023 at 11:33=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:

> Some classes (i.e. gpio), want to know if they have been registered or
> not, and poke around in the class's internal structures to try to figure
> this out.  Because this is not really a good idea, provide a function
> for classes to call to try to figure this out.
>
> Note, this is racy as the state of the class could change at any moment
> in time after the call is made, but as usually a class only wants to
> know if it has been registered yet or not, it should be fairly safe to
> use, and is just as safe as the previous "poke at the class internals"
> check was.
>
> Move the gpiolib code to use this function as proof that it works
> properly.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Bartosz Golaszewski <brgl@bgdev.pl>
> Cc: Sebastian Reichel <sre@kernel.org>
> Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> Cc: linux-gpio@vger.kernel.org
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

This looks good to me!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
