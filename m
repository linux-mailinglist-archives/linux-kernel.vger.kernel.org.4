Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8318709F4B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 20:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbjESSoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 14:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjESSoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 14:44:11 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D38BE47
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 11:44:10 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-96f850b32caso69763566b.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 11:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1684521848; x=1687113848;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iP0roWAg79GmNnTX3PActukmpsHrXoYZPfWyNU+CGOc=;
        b=XzfMn2+xMQxSD4yOtkkYJSoocxFa6IRMYl4mivx7mjMgkuWlajFoErGAXzRctR986V
         qAcRzGOC9YNFf2FY00DcJMqNTuK4x4xg5QqDnrNoO6he4tPvitXfqOAGBw17RPtUqw8F
         J/pj8d44//1dOqbAMy5DPcoWjhWaCgBtOQqM0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684521848; x=1687113848;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iP0roWAg79GmNnTX3PActukmpsHrXoYZPfWyNU+CGOc=;
        b=UI4GNudjIsmjJDcwS7Ym3U3sIQernIm9uCn9jo0ywBk1tSAgu7OVJuJZfazvlP+wyX
         P0u1XiS1en4m3CfrXg4+9s7vKmAcv3PySmq4EZmQbUHFBWjFMKxPhtqxGNX9+isKL/gm
         3fYG9rSUF4aMGUn6qU8nK09u+DpVbM+ydz24rE734qZgOHv8DOWh3tsIUgxGHjxU2TZu
         QtBPB82r0kjd3J3bK0TT5xDQpfsMZ7Smr77M4USH7/MZYwfSGmfq9gDQ1qyTbGR8AFpr
         bj5/527eG4BETzo+0N/IRJkkscUBaq2vpet94TW44AQW1GayG/Nun0hqMkt77G2zXqHf
         rybw==
X-Gm-Message-State: AC+VfDyBFJlUvGMJsxlqcOu56RJz/I3uc/+60Nl60V3sUj6zO5lgOvI+
        6EdCaBPDq4COefdmdpOpXGlEXbYFVCk99sMjdt9oVlbI
X-Google-Smtp-Source: ACHHUZ4bq5s3grLZ8zVoMAWdRX+s1gUjKhetQcJ/pcv23uURqa9CPjPTESFVD8miZZaSPNHDf7viQA==
X-Received: by 2002:a17:907:2d0b:b0:931:624b:680c with SMTP id gs11-20020a1709072d0b00b00931624b680cmr2859149ejc.29.1684521848503;
        Fri, 19 May 2023 11:44:08 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id u18-20020a170906655200b0094e96e46cc0sm2579637ejn.69.2023.05.19.11.44.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 May 2023 11:44:08 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-510b869fe0dso6268255a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 11:44:07 -0700 (PDT)
X-Received: by 2002:a17:906:fd85:b0:961:78c2:1d27 with SMTP id
 xa5-20020a170906fd8500b0096178c21d27mr2552006ejb.19.1684521847716; Fri, 19
 May 2023 11:44:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAJZ5v0g9RmqJm=bpc9SQryYo4r+9Ctj7_aXQcfFRWTS3=xs6qw@mail.gmail.com>
In-Reply-To: <CAJZ5v0g9RmqJm=bpc9SQryYo4r+9Ctj7_aXQcfFRWTS3=xs6qw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 19 May 2023 11:43:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=whZqMhLk6qbcO-pQSPFh2v-iu8v0A8U=mppYjLVHkf0Pw@mail.gmail.com>
Message-ID: <CAHk-=whZqMhLk6qbcO-pQSPFh2v-iu8v0A8U=mppYjLVHkf0Pw@mail.gmail.com>
Subject: Re: [GIT PULL] ACPI fix for v6.4-rc3
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 19, 2023 at 8:28=E2=80=AFAM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> This adds an ACPI IRQ override quirk for LG UltraPC 17U70P so as to
> make the internal keyboard work on that machine (Rub=C3=A9n G=C3=B3mez).

I've pulled this, but those overrides are just odd. How does Windows
work on those machines?

This feels like we're missing something...

             Linus
