Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 707B2700F56
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 21:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238641AbjELTgq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 15:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbjELTgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 15:36:44 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA178A60
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 12:36:43 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-50bc3a5f462so32935a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 12:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683920202; x=1686512202;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N5IdU5Q8nCheWE4jK5FL6kzjqbDAPnnRUBDcJRvuYAo=;
        b=lRP89mxCvo75uh0S0NjqgP70xoomzczasLvdS9fa4uZftAyBY1yzVD3bFhj02kKsrb
         NSB27iBzNH9aqinX+G74eaVfxpZxa3ZQnSSbsxlFCesjDlVxWgU/5FngB9Zq0cwuwkRq
         BEjsGE36Nm7mE4n8UDOZFTv8ejSz39r3DieI/ilvtkMgfK+Dg/huvM4cPsN20aR/0RNC
         2jWZBczBHB4aFkXOOdheEyOAY6A8/b27ivzxx8c3MWg/djfD8sd4HyhTZhGIUpGxAGus
         4KFaOknpz9cE9HAsIL+0F5H/y9W0O9u/I6IQjpNdqqxi1WZfEvsDwCRo35/kL410x0hi
         t9Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683920202; x=1686512202;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N5IdU5Q8nCheWE4jK5FL6kzjqbDAPnnRUBDcJRvuYAo=;
        b=c3uRWMSk+knINsABZcSGP4Pn69LX07C7kpocYCYWnwuF/8pN4JZVO8EvVyhKtp7Arw
         yTjCZM5AW/M4GLW9/f/mVwnjBaCDb/N1y0TV91ZcxBv5fBGj4hxueK7vXZh+hTfZO2iF
         9s5S+jsNzbloWKmqoulPNEFq8e3JMmLPBx2r2gGe/K7gwpz9lnt658A/rB23y7VURdxj
         +aZ/DQH0wcQYQhiQ9DOINY+Wg2YX6RIddSatGpRpwkRT+BzdEPvZAjk0WE8IQ0mFrNoh
         QdUwttCBgEtbdkb752n6BmoYkN4uttG5t6SOIAU3UvMYiu/dHkblOVDIG9EGlZPszEu5
         0Nlg==
X-Gm-Message-State: AC+VfDz8X4itnBUZhR+8KrXYRzVV8jsDk9ptDfvGXjRyn5bAsLEcJWrI
        1n48MGuKwAUrYajInb40ZO6T3xlhNWgUlfw5s9zDSA==
X-Google-Smtp-Source: ACHHUZ7BaLgtSG8qvcmJGeKENN7igmwlHMhuCLu10KpHk8tPxcnhY3nvJ0lG+kvZCAMSHtl4N+4yWJ8DBc5F7zFKPBs=
X-Received: by 2002:a50:d795:0:b0:50b:f6ce:2f3d with SMTP id
 w21-20020a50d795000000b0050bf6ce2f3dmr134297edi.0.1683920201692; Fri, 12 May
 2023 12:36:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230510192731.300786-1-jefferymiller@google.com> <ZFv5VkIzTEVwo2PI@google.com>
In-Reply-To: <ZFv5VkIzTEVwo2PI@google.com>
From:   Jeffery Miller <jefferymiller@google.com>
Date:   Fri, 12 May 2023 14:36:30 -0500
Message-ID: <CAAzPG9PpP4_hUxmpYmTGQmH7qd5AbgEBv1fDcE_sYJNnYn=bgA@mail.gmail.com>
Subject: Re: [PATCH] Input: synaptics-rmi4 - retry reading SMBus version on resume
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Andrew Duggan <andrew@duggan.us>,
        Jonathan Denose <jdenose@chromium.org>, jdenose@google.com,
        Lyude Paul <lyude@redhat.com>, loic.poulain@linaro.org,
        benjamin.tissoires@redhat.com,
        Andrew Duggan <aduggan@synaptics.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2023 at 3:06=E2=80=AFPM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
>
> I am not really fond of adding random repeats in the code base. Andrew,
> do you know if the Synaptics device needs certain delay when switching
> to SMbus mode?
>
That's reasonable. It's true this is a sleep to workaround rmi_smbus'
expectation that
it is able to successfully read from the i801 i2c smbus addr 0x2c on resume
when it cannot.

I do not know why the i801 i2c addr 0x2c is not responding on resume.
Infrequently it won't respond on boot during the initial
psmouse_smbus_create_companion but that is less noticeable since
it will stay in ps/2 mode and just lack features.

I do know adding a sleep in-between the psmouse deactivate call
and rmi_smbus's attempts to read from the 0x2c addr allow it to
succeed on this machine. I do not know the details as to why however.

I can apply workarounds until the underlying issue can be
identified and properly resolved.

I can apply patches and provide any sort of debugging or extra information =
that
might be useful to anyone familiar with these devices.

The smbus controller in this particular machine is:
00:1f.3 SMBus [0c05]: Intel Corporation 8 Series/C220 Series Chipset
Family SMBus Controller [8086:8c22] (rev 04)

Perhaps there's some way to detect when the addr is available later
and have it trigger a new probe similar to how psmouse_smbus_notifier
is triggered when the i801 bus becomes available?

Thank You,
Jeff
