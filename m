Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1DE7715DC7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 13:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232003AbjE3Lsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 07:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjE3Lsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 07:48:41 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8037BF0
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 04:48:23 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-565e6beb7aaso38703477b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 04:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685447300; x=1688039300;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fo+34sYQaffJ2bO9R7Slc11dOrFe3PLfK25qyke+6Mc=;
        b=WA45haybAy0KlloK/J0ZXn1ZE57YMK8Td5RNT3woNczAgZB+NO5R4aB/OMIyZt4dL4
         cSpCu6xHS/VPxx4XaWjA/8Nkj176uiHH4JwAY2mBqbovexcrkN7yQswnih16yXXbCG0Z
         0wDzLbpVMYFmrEEtGbU7bF1fk2aTmR6r0KfISv3pGW7xrBTbqIk9q7iKZI4h7v9wyHjd
         JCKjN46r68PyZOw9Um4m18pyZViv/MVD4iJmj7xjrPvyXGpA+wrA4X5V5VXHHEq1+D/m
         ny4UlgAcowA3BTW0dJ2rzc6I/Y4MyCjao1wIxmgurrHCb/Xai8B+bSEyvqn/XQkaO+Z1
         Q0LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685447300; x=1688039300;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fo+34sYQaffJ2bO9R7Slc11dOrFe3PLfK25qyke+6Mc=;
        b=HA9BN4YjqQHtSV8u1HwERPpoi1ujFZOdSyP2cgSYg9WZ6ra5Wy9JjEIYpMzArC+tO8
         wikibgxkQn4tpbI3iPAhO8uwWSaEQHpbidxbNeRv/D7Uvk9oxMe1I7ujzDX3Lxzo5CNf
         FbdQsl/IrGIfqfMNVFN3M61kzcC0x/CahS8ggM3xZ4996cqUegS5j4xNw9B75IbkVnGW
         sQwBQEY18aUWQLElhsJwv3AbOt8mZ4THTeqaqEmWT4SfwZRbcHZM73WIuhimv9c5MZ+5
         IyS0vTd5Z/4QMimCstLLqBFt0o3N5p/N/+sG4ejVpvB8sIIDnAM/VysZPkkyrU4VN88u
         quDw==
X-Gm-Message-State: AC+VfDxQz2zC09+NYDBOiEiUGmTJNa+5kskF83OPJV3LlEfyOv/WbQrI
        iUzEVATX5yKS9Cup6cA+1PuNS0gH/JLKTN7PrzktkA==
X-Google-Smtp-Source: ACHHUZ7agup3yBnbNHh2JZEme16G+OLzh3l+j3zrwX+koxpY4MlgdwIU37DTG3GjsBi1UkaJ41UL6xtv/L69kOSv2B4=
X-Received: by 2002:a81:6d8d:0:b0:565:a8e7:239e with SMTP id
 i135-20020a816d8d000000b00565a8e7239emr1850710ywc.23.1685447299840; Tue, 30
 May 2023 04:48:19 -0700 (PDT)
MIME-Version: 1.0
References: <1685277277-12209-1-git-send-email-wellslutw@gmail.com>
In-Reply-To: <1685277277-12209-1-git-send-email-wellslutw@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 30 May 2023 13:48:08 +0200
Message-ID: <CACRpkdaOh52hba6EbNeUGgV1ZmunJS4Tc1W7N6LCgQ0WkdABWA@mail.gmail.com>
Subject: Re: [PATCH v2] pinctrl:sunplus: Add check for kmalloc
To:     Wells Lu <wellslutw@gmail.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        wells.lu@sunplus.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 28, 2023 at 2:35=E2=80=AFPM Wells Lu <wellslutw@gmail.com> wrot=
e:

> Fix Smatch static checker warning:
> potential null dereference 'configs'. (kmalloc returns null)
>
> Changes in v2:
> 1. Add free allocated memory before returned -ENOMEM.
> 2. Add call of_node_put() before returned -ENOMEM.
>
> Fixes: aa74c44be19c ("pinctrl: Add driver for Sunplus SP7021")
> Signed-off-by: Wells Lu <wellslutw@gmail.com>

Patch applied as non-urgent fix, dropped the changelog as pointed
out by Andy.

Yours,
Linus Walleij
