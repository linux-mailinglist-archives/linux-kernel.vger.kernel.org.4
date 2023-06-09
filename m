Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FBD6729F59
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 17:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241980AbjFIP4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 11:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241999AbjFIP4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 11:56:32 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 822573A96
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 08:56:25 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id ca18e2360f4ac-777b4716673so61795639f.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 08:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686326183; x=1688918183;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KqAimDvnh6CPASJWE79N/CEnDvYL3nhLI7BR9MCv+68=;
        b=BF57r8A4HEY28sjgViBf2OnCR98DgvGGocGLPip/A2SsuaaBg2HLYLf4TslS2ag8rQ
         VAg1cF+l+XCTTKGxdwMOBnHyaOAcGsnnoZ0RO5O+CRnaCTpOD9PM4gp82+DnGYY5Qxsw
         JRZZqErayvJUW2+2hkS8eW+JizoeMj9poU2js=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686326183; x=1688918183;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KqAimDvnh6CPASJWE79N/CEnDvYL3nhLI7BR9MCv+68=;
        b=CujrKVqflGu/d9xLyFCz/pFeSbX+KhHl+AvGlSJH6UKOJF80+1e4IU80lWYNMIDeFs
         Lty6Jq0WQ10BtYLj9BiaU2aF98NoncEf7pR7C6s2iYJXgv6gJu556ZArCbyBw7jN6Iug
         98CrwEdzPJKZldy7cJCd2J6YgqasWUsLCJqHg6wkBmp2hLjKAes/6330YH5ZXlaTbrjT
         4LA4G1UehB1kSv52dAwQWuG3sAI1MQr9jmmsgm2Coe00olENvjJ1S57FfhJDsdXwToDd
         cSyshGGPEyYx7vo5Ot15wLTDQXg0tm0LLXvG/Se4JB/v7NBdY8/3iiN/IR7gi/z2rNez
         hzKA==
X-Gm-Message-State: AC+VfDzsU9Bc7sS4/hbR9A2koolzrcruiMZATs+qD2y3YqKjp9E4Q83b
        TSbJ8zJRN5Q2XUFC94KeigLdNFzr/bokK3vlEyI=
X-Google-Smtp-Source: ACHHUZ7bVyZnKYJG8Bb+54VQ75QmtmQ8eTPqa1EvxupPJbgW6QdhCvMQR3/3Xgm37wHKroLSWPnVBA==
X-Received: by 2002:a5d:9d4e:0:b0:777:a7a5:9c80 with SMTP id k14-20020a5d9d4e000000b00777a7a59c80mr1545260iok.6.1686326183451;
        Fri, 09 Jun 2023 08:56:23 -0700 (PDT)
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com. [209.85.166.178])
        by smtp.gmail.com with ESMTPSA id s19-20020a5e9813000000b007635e44126bsm1102318ioj.53.2023.06.09.08.56.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jun 2023 08:56:22 -0700 (PDT)
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-33d928a268eso285725ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 08:56:22 -0700 (PDT)
X-Received: by 2002:a05:6e02:1c0c:b0:33d:5640:f315 with SMTP id
 l12-20020a056e021c0c00b0033d5640f315mr375551ilh.25.1686326181977; Fri, 09 Jun
 2023 08:56:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230608130147.2835818-1-yangcong5@huaqin.corp-partner.google.com>
 <20230608130147.2835818-2-yangcong5@huaqin.corp-partner.google.com> <77dce4ec-89aa-8802-b169-744f6c11b177@linaro.org>
In-Reply-To: <77dce4ec-89aa-8802-b169-744f6c11b177@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 9 Jun 2023 08:56:10 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UxQPWm6BNSeTAJWq1Cc8qFL2WTJHFiOrca5mnTEPHMvQ@mail.gmail.com>
Message-ID: <CAD=FV=UxQPWm6BNSeTAJWq1Cc8qFL2WTJHFiOrca5mnTEPHMvQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: HID: i2c-hid: ilitek: Introduce
 bindings for Ilitek ili9882t
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Cong Yang <yangcong5@huaqin.corp-partner.google.com>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, dmitry.torokhov@gmail.com, jikos@kernel.org,
        benjamin.tissoires@redhat.com, hsinyi@google.com,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jun 9, 2023 at 8:50=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> > +  vccio-supply:
> > +    description: The 1.8V supply to the touchscreen.
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - vccio-supply
> > +
> > +additionalProperties: false
>
> Why do you disallow all properties from toouchscreen.yaml? Aren't they
> applicable?

This matches what hid-over-i2c.yaml does. It only picks
`touchscreen-inverted-x` and `touchscreen-inverted-y` from the common
file, which aren't needed here. I assume that the rest of the things
from the common file can be probed using the i2c-hid protocol?

-Doug
