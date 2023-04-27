Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A18426F0880
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 17:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243711AbjD0Pib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 11:38:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244020AbjD0Pi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 11:38:29 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB41A2701
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 08:38:27 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-95369921f8eso1412144766b.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 08:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1682609906; x=1685201906;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d7uiTmpUlfL81ZU9AzSI0GBW5946jNS5Utc+TlhKUqY=;
        b=BF8k0gsGCynf3Aschz2b6YGMo5KEVMtqbqXm/NtTeTwR8Lt9X+D1gnm7GmWlchSfdz
         5QoRUYrWwomsEZHFhpFgcmIqqw7Q+lnpQIPlG3hMVMoznFCy/R1z2gYNEVWj+TRaHK70
         7VY5oHrvBVRcXAMEQNT3+FrZKg9hE+R6Fu0zk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682609906; x=1685201906;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d7uiTmpUlfL81ZU9AzSI0GBW5946jNS5Utc+TlhKUqY=;
        b=InIHqDE4uUiQ2EEZOxB7yPTfR96YvkQvfxh6er+drAvXVlxgQLfXZ4A53TBbcpxzAj
         ed0pNfvEVNG26ByENmviLCDuSmuZgL+hYQnKx6zOSeD1hipNq4lrS2N9DB5AxvOTfPTa
         UKzrGqPIh6hbbNAqayknT3mAxmaa/TAY4FcQYmKqa9rTZ/4erwHxyoFgz6KTSlvsPtV+
         RkfZz9EooxnV7cNtYb9ggms+1loQTuYxR03kW/opMJrknQjppH8I+84fZ1WcxgrbDGko
         41Lp59BoLPTPS3KDdFnZW4BqzvsyQPM2wfSE+MbKsnQC5i/G64SNJptMG3n6o9DH0gbG
         VMJw==
X-Gm-Message-State: AC+VfDxidCbrGXeaCOp7W5ouTJ1ckfz2pR2LfJ4I+4k07QpgyO7svREn
        kb2SFgkoOS50tO/KIts08b0svwW0zY2eW2okLdJl3w==
X-Google-Smtp-Source: ACHHUZ43CM5pQoH6cHIoXnmp9N886kS+OqjtUyJcM6igtbe+dc12Niv91sBBNRw/RVx5S93mtFyhLw==
X-Received: by 2002:a17:907:368d:b0:94d:8b66:46cb with SMTP id bi13-20020a170907368d00b0094d8b6646cbmr2058466ejc.3.1682609906117;
        Thu, 27 Apr 2023 08:38:26 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id v10-20020a1709063bca00b0094ee3e4c934sm9865289ejf.221.2023.04.27.08.38.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Apr 2023 08:38:25 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-50847469a7fso12593954a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 08:38:25 -0700 (PDT)
X-Received: by 2002:a05:6402:403:b0:50a:1604:f04c with SMTP id
 q3-20020a056402040300b0050a1604f04cmr1972054edv.4.1682609904880; Thu, 27 Apr
 2023 08:38:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230427111125.13769-1-jarkko@kernel.org>
In-Reply-To: <20230427111125.13769-1-jarkko@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 27 Apr 2023 08:38:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiGauUNbV_1ZdxG92aWF+oqnnqdRg4z2h-FxXjB_w3Xiw@mail.gmail.com>
Message-ID: <CAHk-=wiGauUNbV_1ZdxG92aWF+oqnnqdRg4z2h-FxXjB_w3Xiw@mail.gmail.com>
Subject: Re: [GIT PULL] tpmdd: a critical bug fix for v6.4-rc1
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Eric Snowberg <eric.snowberg@oracle.com>,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 27, 2023 at 4:11=E2=80=AFAM Jarkko Sakkinen <jarkko@kernel.org>=
 wrote:
>
> This PR fixes a critical bug in my first pull request.

That doesn't work AT ALL.

You have this duplicated line

-       TPM_CHIP_FLAG_FIRMWARE_UPGRADE  =3D BIT(7),
+       TPM_CHIP_FLAG_FIRMWARE_UPGRADE          =3D BIT(7),
+       TPM_CHIP_FLAG_FIRMWARE_UPGRADE          =3D BIT(7),
+       TPM_CHIP_FLAG_FIRMWARE_UPGRADE          =3D BIT(7),

in that patch (presumably due to some edit-time fat-fingering), which
causes lots and lots of

  ./include/linux/tpm.h:285:9: error: redeclaration of enumerator
=E2=80=98TPM_CHIP_FLAG_FIRMWARE_UPGRADE=E2=80=99
    285 |         TPM_CHIP_FLAG_FIRMWARE_UPGRADE          =3D BIT(7),
        |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  ./include/linux/tpm.h:284:9: note: previous definition of
=E2=80=98TPM_CHIP_FLAG_FIRMWARE_UPGRADE=E2=80=99 with type =E2=80=98int=E2=
=80=99
    284 |         TPM_CHIP_FLAG_FIRMWARE_UPGRADE          =3D BIT(7),
        |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  ./include/linux/tpm.h:286:9: error: redeclaration of enumerator
=E2=80=98TPM_CHIP_FLAG_FIRMWARE_UPGRADE=E2=80=99
    286 |         TPM_CHIP_FLAG_FIRMWARE_UPGRADE          =3D BIT(7),
        |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

errors.

While I could easily just remove the duplicated lines in my merge,
that would make things non-bisectable, so I unpulled this instead.

             Linus
