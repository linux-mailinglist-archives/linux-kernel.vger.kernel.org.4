Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D73545E772D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 11:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbiIWJbn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 05:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbiIWJbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 05:31:09 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D829E10B7;
        Fri, 23 Sep 2022 02:30:13 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id b23so8000756qtr.13;
        Fri, 23 Sep 2022 02:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=vOfuNjfQiyEloXtJTaSMMkcQA8aK6Y7PCNl4Uwk0PSk=;
        b=qObvJ39iCzN4zRzPJEpMNadE83eBKVxHrHsJhPrDuuospVygmZPKzrm+aaizD9/Hcw
         ac2Q2GZ9WEQLc6CrDL6KUuBXDsWMFstLWkYuCJs3FKeJRXO7zwvFXrzvv97shkqyQibK
         8BU7r0Zk82VMWeyxFX8eNgR3NCtIDkwsqGfQaRRPu9jf4ieYwtvWCOxeLkyYZ63qFViu
         YR5pqEaoKx61KPQr6KywTohmBwD2bAWKhBosFnTSsSgPCABq82991O8xX2yrvaYA2H5q
         +ANITjCjz+0FEumYzxiGhhCuN1Av9UayyOAVK+QSd6qsiNQhEl2PxV5v6POwfNo/n6Ny
         6adw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=vOfuNjfQiyEloXtJTaSMMkcQA8aK6Y7PCNl4Uwk0PSk=;
        b=iow+yPDW1GpPXYeF7/r8O/I91WtDvtfXwNKN9sMHdfTLufWyo7nrSduVj6Zo1NlyS6
         jyX7HI070zoODDGawV5lwjf0lsgGo7y7wmfdgHY6JsBbrFSDZxVsai/tJGkajQoMcnP5
         D00M//UiYoKV9J/Qb2zlcS6Pt2D7we3Nry1OoP+6cRPsORODhdwo5v16Ze5OIHxY5378
         C41KgB8VZgOA9ceWv9intCAYLjRXD1n+n8eQEszgfu51aauU9pBg0JDUz2Aig+2QY/My
         4H+py8jqJdrA43ga2q8Dx9E49028CsOUuwmLYmVA/zQKPrJUHJQThJFbMD2Sh+ggAys5
         beSA==
X-Gm-Message-State: ACrzQf2oMoI9DhqheJx31AT5KEhmCIGrwt7NgMj7f1qaSMiEm4ao4gkR
        CbZzfaMH86P4mqEbUFLq/q0h+lfrZVfkttMpm8w=
X-Google-Smtp-Source: AMsMyM7YBRy/ugzLt03xHCnOFOBsJFlgbHJx1WuVyIMhYryLnO1Tnm+Jhxk9n1/Ci2XZ+pnuwH3HaiqfcB4B+VHQdew=
X-Received: by 2002:a05:622a:1701:b0:35b:b3bb:7c4e with SMTP id
 h1-20020a05622a170100b0035bb3bb7c4emr6186932qtk.195.1663925412410; Fri, 23
 Sep 2022 02:30:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220922194639.1118971-1-marcus.folkesson@gmail.com>
 <a34d9ee8-8bf8-3158-7fe6-cbde513aa1a7@linaro.org> <CAHp75VcEGb3kS03QG0ebOJYH1X_D5EbBjL6iNWUxQ5j=aCu29A@mail.gmail.com>
 <2de38167-976b-6996-7929-a41a842991a2@linaro.org>
In-Reply-To: <2de38167-976b-6996-7929-a41a842991a2@linaro.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 23 Sep 2022 12:29:36 +0300
Message-ID: <CAHp75VdMNTVvk3hu9xSsntU6k6FJceS_4Ou6d-=ozmP3KMARxQ@mail.gmail.com>
Subject: Re: [PATCH v7] iio: adc: mcp3911: add support to set PGA
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Marcus Folkesson <marcus.folkesson@gmail.com>,
        Kent Gustavsson <kent@minoris.se>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 23, 2022 at 12:24 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 22/09/2022 23:07, Andy Shevchenko wrote:
> > On Thu, Sep 22, 2022 at 11:00 PM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >> On 22/09/2022 21:46, Marcus Folkesson wrote:
> >
> > ...
> >
> >> No need to cc-us. Use scripts/get_maintainers.pl.
> >
> > While I understand your point it's much easier to Cc all related
> > people for all patches in the series, given the fact that many (code)
> > maintainers ask for that (Cc'ing them all patches). So I prefer to be
> > on the contributor side for the sake of ease of contribution.
>
> Then please explain me how I am related to this patchset (it's one
> patch, BTW, not a patchset)...

That is a good point! I was under the impression that this is a series
with some DT changes.

-- 
With Best Regards,
Andy Shevchenko
