Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4616C691B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 14:07:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbjCWNHP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 09:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230476AbjCWNHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 09:07:14 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC57031E34
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 06:06:36 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id y5so24718462ybu.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 06:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679576796;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/r9LM1Q2qIKLtOPEl772hrltusDqn+Brh1BjZrpMNYM=;
        b=aJYOeYVIuVOFXyxuM0TlM1Dhy/T2DQixr0B3Lcf39cJnmKGZq5cUKA1v220YZuL/7X
         L/wO8MYy0AvL7CByAfTsZIQmnDogXfJSd9Zw/XA4dMQ3c2M2tSVHGqNpkB7ZZnjEfrvo
         yo86iXvQe9f8Ozn/TcO56lphPW2/hB+/tb/oX7g181MHJQEVQN14DC1CrxVbr7b+zM7i
         E5niJBI9NxeFlnU7cxR3JQ4Diu9njjF2yn77re5lpUWghhZgyf1jp8Vmqzi2LC8Or2QZ
         Syd2j5bd8NUzEkkNT57odPgmJuMeNLUFHvEzqVQm5kN18XDBzN3g2K5+9CZ4ae+yAUI8
         MHQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679576796;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/r9LM1Q2qIKLtOPEl772hrltusDqn+Brh1BjZrpMNYM=;
        b=417WeEQ/+rDOTpVt4xlchYq7ETVyAeKn+6MNQAWHP4Ipbmh18vVbt3/UQWtIpPGn+a
         C3ZtX7ypJZ08iSTlnuSfDKc1kP4k3fk2GUJB7N64qmcU8j6d3682+OCbR9QKMdj3UN/+
         mHDXb+Fx1HlWGd1UE0zsjUfhw7kVyTAJn+TF/oIM4+YBkcEXzPMkPvkIhTywUuE8OIOC
         KvslnlJA0edasr71z/l98+kA9EJHWJvX6+BXOR3NG8itVh7FYHPI6ENNyrGosx3YZ+wd
         uQPdFSb077j1Wf/J+XDaaNXVhmTTOVyYy7gtDFmxde6Ec04ZL3k4CzpIwSL2cheML43N
         e7Vw==
X-Gm-Message-State: AAQBX9ewWi4MuG832zC7VyaPzXchuGySVO2FS2JG5iCcpVQVCOdNmkdH
        cra6HbEzsIRPYD+w+bpnW/ezlyXAJOhWwT0Zxosq/g==
X-Google-Smtp-Source: AKy350ZANGRUtGitxcZHoKtnsnguHi+xqg0awFuyXFXLKPcA/kC+NS7m8Mkqn0zmQpuTplN8mMcvMmxXLUCmeIVX+0s=
X-Received: by 2002:a05:6902:1005:b0:a6b:bc64:a0af with SMTP id
 w5-20020a056902100500b00a6bbc64a0afmr2287099ybt.4.1679576796025; Thu, 23 Mar
 2023 06:06:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230323090431.73526-1-yang.lee@linux.alibaba.com>
In-Reply-To: <20230323090431.73526-1-yang.lee@linux.alibaba.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 23 Mar 2023 14:06:24 +0100
Message-ID: <CACRpkdZq8SBrqp3F7ViwrE=6yNLgHrA9RBngPD1GNyxRy5dnCA@mail.gmail.com>
Subject: Re: [PATCH -next] PCI: v3: Use devm_platform_get_and_ioremap_resource()
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Thu, Mar 23, 2023 at 10:04=E2=80=AFAM Yang Li <yang.lee@linux.alibaba.co=
m> wrote:

> According to commit 890cc39a8799 ("drivers: provide
> devm_platform_get_and_ioremap_resource()"), convert
> platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.
>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
