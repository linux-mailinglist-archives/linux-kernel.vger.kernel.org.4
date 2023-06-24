Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30CBA73CACC
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 14:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233072AbjFXMUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 08:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233000AbjFXMUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 08:20:44 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 019B51BFC
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 05:20:43 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-763e968b7feso144658285a.3
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 05:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687609242; x=1690201242;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FIQRhP0Mo8ANvdwGv6BJmi7mUWnYo3RwZ/e8paR7FaM=;
        b=Beuj0NNtnok3NI8RorYOHhfe/ZjoF4mUwFlGf+MAgh3NzeFxwCGBFpEq9tH7zCa2Sb
         9ibTKEvJZORYeaugtkPEqaG2CDIL6pMrEqcxlo1oitN1QMosb5Cz1tKWjjLu2D/0yZyJ
         KmNoMq3QHk9KNuVIJmU1flaxUqnwRy5Pp63o+tkibmNM0UlmIOtyshG6OEzZHkJkQ237
         JdQS+U7kBn8kii/Hn4lNCFJZERCHRQaV4KrmQnAEvrh/ChJz/g5M0lR8oG838nskK/vN
         DugMNf0P3Tff3faU7f+K9r39RjD+K7MfvIcIyboLdM2GO8xTlXs44XJvEPWNYtkIRVIb
         /0Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687609242; x=1690201242;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FIQRhP0Mo8ANvdwGv6BJmi7mUWnYo3RwZ/e8paR7FaM=;
        b=grrolSebKokY1jJr9gGb5fwn6iV2e5BK6QJW4jWGLoLzu9FA2TepPZSMJlKDHsW4fG
         FWBNrCT6Qb/midjTOBBQF6cBo5gVncvuYVH5vbGBuxUlYvZSxB2ur3XGAPTZ2M6+N64A
         lrAvr8N+OheiiCsLmbv7jbPkBXJGEIESC8ul/NdKDGdohg/PjA4UWLpbHesTre/qcLTn
         7oTbRJsSytSwJiyYjlIwpQSq+Harn1uDseaiBwQjFRt3VmvpVVt6q18ZpFDsrCHLltSL
         HF4RfzfksBczw5Y6ZvULQEQPLstDA935FzjU5o6owAI6a8G4UPTo/vb0FPkuwwyCgSKk
         L09A==
X-Gm-Message-State: AC+VfDxLqH/4oXw59YwIM3hXhZejLIOSytsCl7oZhyQdVaR8yAizGT7l
        VOMTzxJ3/HzrfOxp6qLtNPlgjKoR/Yy+5YZ3FPOiEw==
X-Google-Smtp-Source: ACHHUZ5yY82PJW4oX+7VuF5Qp7CVUbNq1PhDOTW7eVdvXOmkSJrJ+LSC3ErjztV/pd8V1oWegINFRkDxSFL42BZfjdM=
X-Received: by 2002:a05:620a:28c6:b0:765:5f7a:48e1 with SMTP id
 l6-20020a05620a28c600b007655f7a48e1mr1409350qkp.40.1687609242163; Sat, 24 Jun
 2023 05:20:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230624112958.27727-1-jonas.gorski@gmail.com>
In-Reply-To: <20230624112958.27727-1-jonas.gorski@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 24 Jun 2023 14:20:30 +0200
Message-ID: <CACRpkdbW_V_1RtYy1+KRXTMe5E4g2vDvcR7Y9f2O4C=XLnUaXg@mail.gmail.com>
Subject: Re: [PATCH] bus: ixp4xx: fix IXP4XX_EXP_T1_MASK
To:     Jonas Gorski <jonas.gorski@gmail.com>
Cc:     Imre Kaloz <kaloz@dune.hu>, Krzysztof Halasa <khalasa@piap.pl>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 24, 2023 at 1:30=E2=80=AFPM Jonas Gorski <jonas.gorski@gmail.co=
m> wrote:

> The IXP4XX_EXP_T1_MASK was shifted one bit to the right, overlapping
> IXP4XX_EXP_T2_MASK and leaving bit 29 unused. The offset being wrong is
> also confirmed at least by the datasheet of IXP45X/46X [1].
>
> Fix this by aligning it to IXP4XX_EXP_T1_SHIFT.
>
> [1] https://www.intel.com/content/dam/www/public/us/en/documents/manuals/=
ixp45x-ixp46x-developers-manual.pdf
>
> Fixes: 1c953bda90ca ("bus: ixp4xx: Add a driver for IXP4xx expansion bus"=
)
> Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>

Yups that's a bug! (My typo...)

I'll funnel it upstream through the SoC tree.

Yours,
Linus Walleij
