Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 729956E50A2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 21:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbjDQTJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 15:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbjDQTJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 15:09:05 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE3A659EE;
        Mon, 17 Apr 2023 12:08:58 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-504efe702d5so3998493a12.3;
        Mon, 17 Apr 2023 12:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681758537; x=1684350537;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7nej44TA/n8SFUJoieP9x6f1gC4gVgPv5O2VYqp1T7E=;
        b=SqPcLbVrpmvGsMQz2m74OZMk2m5Ttvag+SLmXgUwJ3Wkp+46za/jXa1eUjL5L99DuX
         Sb3FhieNV9lmM7JSkkPr326mnUxsx45PqniNTjf54gtsPl8qaSnEpCopEf3I7+kE/esd
         SQpooHbUrT3arlZIqWEEsCtEgfe8Og6CRKO/SavxC7yn5val8mkq+fgVBZOJAQWlMITk
         UDWQuARzEe9JVOx8SBRTgAhDeG5K1QeUCmuXvYIwh9D7bLPjWtOZnRPKf4tPJyEzeC+h
         CWB5Xthjpw+hD9FqyNvqLzt6K0pc0W8I/w/rjSpfMSRkuDzGz1haZAMnx82F3zdOMHYz
         1l5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681758537; x=1684350537;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7nej44TA/n8SFUJoieP9x6f1gC4gVgPv5O2VYqp1T7E=;
        b=GBSzCjS4YzRGFaQJY++m+Dh3QGjPj27h9RCiMlFV/XnkVwAGWMZ8OEkEaEX9uFO3c4
         Np3+FZk1jpuTrUpWcAgxZ1JejB/JXhL9/ORTpEczAIfSSgt9J/VS7X8smb3NJsbkUoCN
         0b+a7Ioe6p3ibtYmfWYWJxBvJTLA0XptcgUoGYkKQr44zUhdrICpNxBXwXxR6K1YD/I+
         JfAl7swQhGsVEE03ovEgPWv77PLegZqw26k2tAq1lQNKCa21KNC4hM9AW43c5aJpdPSI
         vqLyJUVxT0IWL2Al6zXnT0SqIQRNZ18WmceqXbAfjFoKLFBeozbN0c3YIqjv3NOubQIw
         WvDw==
X-Gm-Message-State: AAQBX9fSa/0JV1MiTiAbmFAWPGvpOe2v9ZZjvGWO6JUYuXCRlfdcVdDH
        Bmyo2WjuWOGG40mPwlhmNUznou13NcBOvOYFuH0=
X-Google-Smtp-Source: AKy350btvLD0rq2xZndZ8isy4egH3yeRBu8ZBGBATkF8IgMdsjyFNGemt7Luz0KJW2G9wW7aR+CEZ9lI6Mr/V2nXXSQ=
X-Received: by 2002:aa7:d484:0:b0:504:b324:9ec3 with SMTP id
 b4-20020aa7d484000000b00504b3249ec3mr44717edr.1.1681758537088; Mon, 17 Apr
 2023 12:08:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230410161654.1660757-1-quic_eberman@quicinc.com>
In-Reply-To: <20230410161654.1660757-1-quic_eberman@quicinc.com>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Mon, 17 Apr 2023 14:08:45 -0500
Message-ID: <CABb+yY0iO3FPMi6WHaHio+vsjXWiN-x85kCXyjPZ6EWZgmnwgg@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] mailbox: Allow direct registration to a channel
To:     Elliot Berman <quic_eberman@quicinc.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 10, 2023 at 11:17=E2=80=AFAM Elliot Berman <quic_eberman@quicin=
c.com> wrote:
>
> Two mailbox controllers have channel/client binding mechanisms that are
> controller-specific and not using the devicetree binding mechanisms. Mail=
box
> channel/client is conceptually done in two steps: selecting the channel
> and binding the selected to channel to a client. Channel selection is som=
etimes
> controller specific (pcc and omap are examples). The channel/client bindi=
ng
> code is all the same.
>
> This small series de-duplicates and refactors the channel/client binding
> into a common framework function: "mbox_bind_client" which all of the
> channel selection mechanisms can use.
>
> I found this duplicate code while working on the support for Gunyah hyper=
visor
> message queues [1]. I've only been able to compile-test omap-mailbox and =
pcc,
> however it is a straightforward conversion here.
>
> [1]: https://lore.kernel.org/all/20230120224627.4053418-9-quic_eberman@qu=
icinc.com/
>
> Chagnes since v2:
>  - Fix warnings in drivers/mailbox/pcc.c reported by lkp@intel.com
>
> Changes since v1:
>  - Rebase to https://git.linaro.org/landing-teams/working/fujitsu/integra=
tion.git/log/?h=3Dmailbox-for-next
>  - Add Tested-By from Sudeep (thanks!)
>
> Elliot Berman (3):
>   mailbox: Allow direct registration to a channel
>   mailbox: omap: Use mbox_bind_client
>   mailbox: pcc: Use mbox_bind_client
>
>  drivers/mailbox/mailbox.c      | 96 ++++++++++++++++++++++++----------
>  drivers/mailbox/omap-mailbox.c | 22 ++------
>  drivers/mailbox/pcc.c          | 84 +++++++++++++++--------------
>  include/linux/mailbox_client.h |  1 +
>  4 files changed, 118 insertions(+), 85 deletions(-)
>
Seems fine. Will pick these up for the coming merge window.

Thanks.
