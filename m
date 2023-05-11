Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 704016FF32C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 15:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237951AbjEKNjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 09:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238268AbjEKNij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 09:38:39 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEBBD11D9A
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 06:36:36 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-b9a6ab9ede3so10792470276.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 06:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683812191; x=1686404191;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cFAIywGWIpHXBlSdgbcQzT1KF9uNjxkkfEt4tXTB8GY=;
        b=NC0E8vqh5yAN4U7/8Y4/aq1xl0d7frmoThyvYuilmHbwwjROn6dxNX8nVcnyidJB/m
         qatfvm0yPY+Hd+IP/3kpI+kcPi99ppeI5XYfd1P5Ruw8e75i5B1I1jbaaK1EdUI5Ymz3
         N4kZVZJsafykkM3zIzaecbyDFU9a7TqFZ8nTIJW3gaeoNugJowg7LiiQiuGkwZcnfe2q
         lYerGGZj/igiPYsHxKj+I0F9H0UjZcRTIQhb8OmxMG4483Qaftq0NXmGIOa6ecdW7Em0
         8DQri3W1uK6NdjjMQGKcHLW7JsaLdDl4yjoOza8ga5sM1fqbNV8dqJ7nnJ1cciewr7uX
         Ws8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683812191; x=1686404191;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cFAIywGWIpHXBlSdgbcQzT1KF9uNjxkkfEt4tXTB8GY=;
        b=jSYEpudWsGSxlJIgIFNS1ds7gE4PeuShsSuD/FghlWe7Pzu9Xds/jstXyKEII1j9jW
         vNmMs97g/5d4UdRDvwQ+gzTYU85St8eoYgmEkuy4oK9QaM8LoIelu/Fb8Atidsj5CqNv
         xwf5bz71rgfiBLRlcPOV2mOyKgCxoDVff+XX3oApQtLyhCmrJO3BdNevQqIrnXL51xqp
         DCSeFRZDEGU232/ifQPmrF9osqKbQcFtfEUp6hXfanXCENbjS2JYbbcMWdK6csi406zI
         X8YiFLKG3zi7z/gcsxnxLdkdfO9ERlIba/2HJ4k+R1b7Lg14CXQrhheXbfNb93uj7rR/
         1JnQ==
X-Gm-Message-State: AC+VfDw8aG5bEKM1djcXMbul/0XfRp0wBi/4OtA0jEa27wVSQJhoZ9k+
        nPDAEz8BnHkJGfpk2U+3Ww5BSoRtJn0qxJdMDNplpQ==
X-Google-Smtp-Source: ACHHUZ7QMtu9AVeo1bHy1+Z0/j5lqVmaGvWbkRPmujYL/1PGBpqhTIe8hp6y79vxcM6RG1l/dmxLaabpyZzUPNvVMDw=
X-Received: by 2002:a25:fc07:0:b0:b9a:6f77:9018 with SMTP id
 v7-20020a25fc07000000b00b9a6f779018mr19959978ybd.41.1683812191411; Thu, 11
 May 2023 06:36:31 -0700 (PDT)
MIME-Version: 1.0
References: <1683730825-15668-1-git-send-email-quic_rohiagar@quicinc.com>
In-Reply-To: <1683730825-15668-1-git-send-email-quic_rohiagar@quicinc.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 11 May 2023 15:36:20 +0200
Message-ID: <CACRpkdZZKsLQbR0zttAWjxYWEPdWo3cHo_OVhuGxBZ89XhDTmw@mail.gmail.com>
Subject: Re: [PATCH v7 0/4] Add pinctrl support for SDX75
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        richardcochran@gmail.com, manivannan.sadhasivam@linaro.org,
        andy.shevchenko@gmail.com, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2023 at 5:00=E2=80=AFPM Rohit Agarwal <quic_rohiagar@quicin=
c.com> wrote:

> Changes in v7:
>  - Collected reviewed by tags from Andy and updated the sdx75
>    driver with the new macro which was missed in v6 patch.

This looks good to me, but I definitely need Bjorn's ACK on the series
before I can merge this.

Yours,
Linus Walleij
