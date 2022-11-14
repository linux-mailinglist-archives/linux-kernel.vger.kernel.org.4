Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F304862812E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 14:21:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237357AbiKNNVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 08:21:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236176AbiKNNU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 08:20:57 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 382C62E69E
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 05:20:09 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id l11so17274561edb.4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 05:20:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MsxhLEEX+JewM1mfo6aagFFHoHLJtXvPCtuaWZUrbFE=;
        b=dSgMCm1OCQ0Kvx1xT2UF42+0L1ozkoEmbhvIY8tlQHWOSE6BbiHKQIuGprS9O716hY
         ATi0JW8DnbquF4DWZbt0QSn/XdY0aKE9xBxk1cBdXe00pEer6Za6v6Qvxwn56um1rtdA
         fQJ3EgQRDmqJcKM3nI8dB92nA/q7sSLj/eIdbpFYBy8gO63mS8N9q5CHTgF1rNFX3LR9
         iLuNddjb/5+hQnr+5MyU7/3l4jDBIZ16U9SmYCiI1NCyoOooQvt8t26Uj2N7rVnJZYPK
         VqXK5d7pxY8AcRIp0RagQRRFcYSkxPOKG0gciib4kElj6C6gzV9kJGIFlJdninxrS9TN
         yCJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MsxhLEEX+JewM1mfo6aagFFHoHLJtXvPCtuaWZUrbFE=;
        b=n6r0SoGgl+vmcEzNdv62MZq3/PkpUMajAxqhrGqWDOxDAArIGdK2AytoKj6VuDZCjn
         gmly8B3otRIfAo5hLOTTDcI/nxltlwvHutM2mipkST02LZD922upXLF7AWhCB+3Zvt75
         Fok0n3v4lyQns8IIKM1V/EdPMVCo3utReequMlzoAx5AiGd2ffqdMiKkRDKBuOeFrE+H
         IVSbQuEFd1TR02jBu6JAHfoGWQzxTQPH9sSGa+MPrwwBwlKQ7qjZvgnfDhOdkIJ/tS8E
         YLylp8fSVMYzZSXIeXuC4Ql2Ku47pBpWIdwXO/S0UMjT3kMPRX0irAerm5A84ijtdxnB
         s5lQ==
X-Gm-Message-State: ANoB5pmePKUdlKI2iEfj+2fJz9HRpaBpRFYTJdIVXiRUPBVpItAXm0CN
        JYtR78ppt00W4+i3GA3+e95yT4F+FTPuz6z0SO/wPwczj9k=
X-Google-Smtp-Source: AA0mqf4ek/cJs4+qeyY+pfVw9FIVNmbyc7P0td+hFzXMthx+hF5NM8dN0wclv3EWCY43IlieEr97pq2JpiiTG1rWvns=
X-Received: by 2002:a05:6402:682:b0:45d:45de:c062 with SMTP id
 f2-20020a056402068200b0045d45dec062mr11124828edy.133.1668432007660; Mon, 14
 Nov 2022 05:20:07 -0800 (PST)
MIME-Version: 1.0
References: <20221111120048.42968-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20221111120048.42968-1-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 14 Nov 2022 14:19:56 +0100
Message-ID: <CACRpkdY5sqFQq1364MVrCk2201DO9pR-mwHqur=jnnykgpt0uQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] pinctrl: Move for_each_maps() to namespace and
 hide iterator inside
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 11, 2022 at 1:00 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> First of all, while for_each_maps() is private to pin control subsystem
> it's still better to have it put into a namespace.
>
> Besides that, users are not relying on iterator variable, so hide it
> inside for-loop.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Patch applied!

Yours,
Linus Walleij
