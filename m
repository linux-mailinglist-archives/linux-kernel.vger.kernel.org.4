Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC54715DD5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 13:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231842AbjE3LvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 07:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231749AbjE3LvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 07:51:14 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7C94E8
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 04:51:10 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-96f818c48fbso809205266b.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 04:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1685447469; x=1688039469;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VXw2bJhZ/bTyaEyxNQlJ8soVao7954SJAKnERIc09i4=;
        b=autIVxQ3xlvfVjTszY4j7+kzC2GuU0njfhIYohgWpp1qmD6xio9ea4zY0tbwtCd7Pk
         Cp3DjJqyNpteL0lGjtfZLLq18W210AQ+o7/oK1DpZxDqbJ4cNjOHvGDtVQMlFifBkNzb
         4AZEqwfIIoWEvuYWgOSyjyZ0AzjiTnaMh5JUI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685447469; x=1688039469;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VXw2bJhZ/bTyaEyxNQlJ8soVao7954SJAKnERIc09i4=;
        b=F0k1jP4A/9TWgYWBajxXYNJpvzQ4FkeJI35Ox4FMEFxlGPNUtNx4LI7/Mr8P3tCPSN
         WD4okxlLMmBbGLuryvz89nemJ8tFXPb2alLEvXYDeDq3syxQC0iktpExDjLXnVP6KDP2
         X++DMTPZ99moHv5QSBGJUQOCbOFgddcpjh38UaX2nqtSGc9BSt9id77ehhkicszvHeqX
         vSWq1EP8s5tuhFWw+nCfammG6gIeIkqETO8utxIVwgH2wSzAXjWDxMe/+HWc1R0raisb
         iOWKXHS+qRXe8mWeR0L4QEv2Atkl9Q10fljC+Eg7ZaFn7G1vREJutVYLTgHpwIDKA6qr
         J9Lg==
X-Gm-Message-State: AC+VfDxJrzSAsNn4qKswWfJW2yXb5KuI/MQ7qtdJv89KRTU2KmXmVv0w
        az/DJuKE1TNhZN0ILHbeJsQ0c45NqiibxMT3v2R8d29r
X-Google-Smtp-Source: ACHHUZ4DrvXPsfyL1kfZibMlI2HkjmSMsBNAHCaVrmMq5YpOcPLYiCh/kjzbA3wf9YXiujA4tHY9Cg==
X-Received: by 2002:a17:907:3e01:b0:970:1a15:62d1 with SMTP id hp1-20020a1709073e0100b009701a1562d1mr2374318ejc.34.1685447468945;
        Tue, 30 May 2023 04:51:08 -0700 (PDT)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id t7-20020a1709064f0700b009531d9efcc4sm7323229eju.133.2023.05.30.04.51.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 May 2023 04:51:08 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-9700219be87so805493766b.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 04:51:08 -0700 (PDT)
X-Received: by 2002:a17:907:3f11:b0:961:b0:3dfd with SMTP id
 hq17-20020a1709073f1100b0096100b03dfdmr2439731ejc.7.1685447467702; Tue, 30
 May 2023 04:51:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230528190835.386670951@linuxfoundation.org> <ZHXUGdFMIcB5HL8s@duo.ucw.cz>
In-Reply-To: <ZHXUGdFMIcB5HL8s@duo.ucw.cz>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 30 May 2023 07:50:50 -0400
X-Gmail-Original-Message-ID: <CAHk-=wjekYoijzNK-MCQKvrO_7m0m9nRmt3ebKcHyhR-XJimUA@mail.gmail.com>
Message-ID: <CAHk-=wjekYoijzNK-MCQKvrO_7m0m9nRmt3ebKcHyhR-XJimUA@mail.gmail.com>
Subject: Re: Wrong/strange TPM patches was Re: [PATCH 6.1 000/119] 6.1.31-rc1 review
To:     Pavel Machek <pavel@denx.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, l.sanfilippo@kunbus.com,
        jarkko@kernel.org
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

On Tue, May 30, 2023 at 6:46=E2=80=AFAM Pavel Machek <pavel@denx.de> wrote:
>
> > Lino Sanfilippo <l.sanfilippo@kunbus.com>
> >     tpm, tpm_tis: Avoid cache incoherency in test for interrupts
>
> Description on this one is wrong/confused.

Yes. Commit 858e8b792d06 ("tpm, tpm_tis: Avoid cache incoherency in
test for interrupts") in mainline.

The change to test_bit/set_bit may be a good one (and adding the
IRQ_TESTED case to the bit flags), but that commit wasn't it.

As you say, the enum should now enumerate bits, not bitmasks.

             Linus
