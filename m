Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A197C6E5003
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 20:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbjDQSRI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 14:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjDQSRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 14:17:06 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26696BF;
        Mon, 17 Apr 2023 11:17:05 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id hg12so12109718pjb.2;
        Mon, 17 Apr 2023 11:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681755424; x=1684347424;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ds1VKehmOi/HHiiWsO7beV6p2Sd3mrnNBiK+1FCw+0I=;
        b=hYGNFVTTz0gOGuOPfVhy+okKohkn1cD24KwlpWbAkzpfDlsXXShpi3D9vQxSq0HokR
         EGdK0INdFlBMrzEfxN0x8wXDvZSlLLsgGcC01lFIVtde2tJencp6GYOUJPSlE78g+SDl
         yShnel6MOudVRehy3w9eA1kiQ7ZPtji2h3BODXTzRRhIkXM0r0aewNsm664sIDXGjEw+
         CjHXn4R8rmSwlWRy5Fy1i7t7SW6a2bOojfTPLgh2EFbMVDslxHcrmZRuIFFPgQ4+Ukh2
         yBboYfLbwRLpnwqL8MYZGeB23wMqI/zZtlMr/Lcp19+6xQjzQjRtNkl0WtwhruWg9MyR
         6FeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681755424; x=1684347424;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ds1VKehmOi/HHiiWsO7beV6p2Sd3mrnNBiK+1FCw+0I=;
        b=WkWDgb2S1tiwTvJBYsHvWASq9/wMnXIjzmTjsEHUYsf/YwsZdXhT/QOXO7IjeeqxaK
         +xNL/kUGFzj3ZiUOND2iurvKatt4YGQD9e6oK90VmJNQJI9cmHU9lL00jnJItt2cMHgY
         qLWzVrHqLNbzJHPr9x5AD1WKHZXKVzPxs2VLdJTuJ7/HvDYNgLt3Bw2QXgKt40WvqkC7
         0hIM1hoMjZvCNd5wVpqSbKaYzYaZ/lGxhmtL1f0qrw8+GRDHt18Wj9hB1OLqWJOyqQqA
         CrmQ2sWdOqAUjU7TLmdqxvuvGVFN/duhjh8ZPYi707N15uas8vA+O31bFoIHCPHMv1OE
         kG+w==
X-Gm-Message-State: AAQBX9caf3pH/fQseTU+lfp/pDMJEpQOZMx4Dz2sKApeTGFiOnN/6dP5
        4Ti4DJ4C/evh3fTecYITxnQv62KnSbKUxfT/TY8=
X-Google-Smtp-Source: AKy350aNw/QMzW3UVdQVnxpBGTccQO+6mSj/lsyilWeNe+l4ezKCQxjnGNzlbBOgZiF7abdZnboqjFnqU1dcmOr5Qjw=
X-Received: by 2002:a17:903:25d3:b0:1a4:f282:91c7 with SMTP id
 jc19-20020a17090325d300b001a4f28291c7mr4074094plb.6.1681755424543; Mon, 17
 Apr 2023 11:17:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230416194624.1258860-1-mmyangfl@gmail.com> <81ed4e15-19ea-34d9-3e05-d1195b2cdd57@linaro.org>
In-Reply-To: <81ed4e15-19ea-34d9-3e05-d1195b2cdd57@linaro.org>
From:   Yangfl <mmyangfl@gmail.com>
Date:   Tue, 18 Apr 2023 02:16:28 +0800
Message-ID: <CAAXyoMPShMwVjckmYRxStv=t=_GiNmqdLVUUjuxvVLdvp+-4Rw@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] clk: Add basic register clock controller
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-clk@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
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

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> =E4=BA=8E2023=E5=B9=B4=
4=E6=9C=8817=E6=97=A5=E5=91=A8=E4=B8=80 14:27=E5=86=99=E9=81=93=EF=BC=9A
>
> On 16/04/2023 21:46, David Yang wrote:
> > These clocks were provided in `include/linux/clk-provider.h`, but lacks=
 DT
> > bindings. Add DT bindings for them.
> >
> > v2: split clock controller and its clocks
>
> I gave you several comments on v1 and this vague changelog entry
> suggests you ignored all of it.
>
> Implement feedback and respond to each one that you ack it or disagree
> with it.
>
>
> Best regards,
> Krzysztof
>

All issues have been addressed in v3 patch. I omitted details in
changelog to reduce redundancy. If that is not the proper way to make
response in dt maillist, please let me know.

Responses for each comments in v1 and v2 have been sent against original em=
ail.
