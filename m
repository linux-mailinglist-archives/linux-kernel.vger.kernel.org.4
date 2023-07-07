Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C08A74B547
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 18:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232449AbjGGQuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 12:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjGGQuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 12:50:35 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A7F5210B
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 09:50:32 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4fb9ae4cef6so3400778e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 09:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1688748630; x=1691340630;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zLXZgXJ3+fhscV17K2fnf26FIQt2ef2bWf/PY4eWVh0=;
        b=hyHMpsodfUphxMQtvgZcrCErIt/draEzO+5GgYcb0UWo1tfECJI4gic4qNSFPBY/My
         MFsCGsK8prgsg4QEU5R7K7nEywcIJizxTK0jK4QjHBJpY7cJKsIypFy9aa+qZANusALM
         qk6shmdJQOrZ29FsBJqbmvp8GRYu45TXnDVls=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688748630; x=1691340630;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zLXZgXJ3+fhscV17K2fnf26FIQt2ef2bWf/PY4eWVh0=;
        b=HYTHlNOp1QE5txqBOvgkJOZvYlSn5C+ONLTEDax2cUtyGJuQutJCRa89pTr2tHZkz2
         VNf/gRGm4RWwej3veJWUXAQyM8BTfokNLkQCbe7ONK1uHYdGIqRrkOJmgoZGy+02hcIk
         M85GM4lA1vsNAHyDfHFpBwEhGSf3n1wEKrDaPdPxswCbIBOh2bT3IBQu1DQhiXYzWOR+
         J/Ml7bYCaXya1rx0eqtG6kJs07jfuhjnfF1xQBGOpHZ+t90JAc14kN0g/5nI00lUYPgI
         b/Oi5YL1JJDCr2QUfVlzv6UnJaweCcVh/9NNPGjxmQ/+R6b41BeUDmHkt8ycJ/4Cz9T+
         1E+A==
X-Gm-Message-State: ABy/qLZX88l3/Ktmlz3/GTA/CGzxeFzf8G5tTK205XNG8o3w20y+FPYB
        WoJnaty8NE086X/OktwZWO6KUZQlTC3tiU/1aFK/cA==
X-Google-Smtp-Source: APBJJlFYE0KzWchkSLd4eTNLZD7YP8SQpN4Z0h/zxKMp/tmb83tI67cZgBUuqXQWDgXPk5OhM9tU+A==
X-Received: by 2002:a19:655c:0:b0:4fb:744e:17db with SMTP id c28-20020a19655c000000b004fb744e17dbmr4231504lfj.1.1688748629915;
        Fri, 07 Jul 2023 09:50:29 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id d28-20020ac24c9c000000b004fb75142020sm741162lfl.276.2023.07.07.09.50.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jul 2023 09:50:28 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-4fb7769f15aso3417281e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 09:50:28 -0700 (PDT)
X-Received: by 2002:a05:6512:2141:b0:4f6:2e4e:e425 with SMTP id
 s1-20020a056512214100b004f62e4ee425mr3732573lfr.50.1688748628215; Fri, 07 Jul
 2023 09:50:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230706145154.2517870-1-jforbes@fedoraproject.org> <20230706084433.5fa44d4c@kernel.org>
In-Reply-To: <20230706084433.5fa44d4c@kernel.org>
From:   Justin Forbes <jforbes@fedoraproject.org>
Date:   Fri, 7 Jul 2023 11:50:16 -0500
X-Gmail-Original-Message-ID: <CAFbkSA0wW-tQ_b_GF3z2JqtO4hc0c+1gcbcyTcgjYbQBsEYLyA@mail.gmail.com>
Message-ID: <CAFbkSA0wW-tQ_b_GF3z2JqtO4hc0c+1gcbcyTcgjYbQBsEYLyA@mail.gmail.com>
Subject: Re: [PATCH] Move rmnet out of NET_VENDOR_QUALCOMM dependency
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, jmforbes@linuxtx.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 6, 2023 at 10:44=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Thu,  6 Jul 2023 09:51:52 -0500 Justin M. Forbes wrote:
> > The rmnet driver is useful for chipsets that are not hidden behind
> > NET_VENDOR_QUALCOMM.  Move sourcing the rmnet Kconfig outside of the if
> > NET_VENDOR_QUALCOMM as there is no dependency here.
> >
> > Signed-off-by: Justin M. Forbes <jforbes@fedoraproject.org>
>
> Examples of the chipsets you're talking about would be great to have in
> the commit message.

The user in the Fedora bug was using mhi_net with qmi_wwan.

Justin

> pw-bot: cr
>
