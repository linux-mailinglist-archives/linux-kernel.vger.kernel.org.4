Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D143E724BB5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 20:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239025AbjFFSsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 14:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233251AbjFFSsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 14:48:04 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B32510F9;
        Tue,  6 Jun 2023 11:47:53 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id 5614622812f47-39ab96e6aefso2492501b6e.1;
        Tue, 06 Jun 2023 11:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686077272; x=1688669272;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9nepVt8ykMn9O/MEw0MYaAhSa9BA9jIh1JKqT4QH0FQ=;
        b=ByOUV/7shilcp/KWuUnNuCm1th7+a8ovOuq+CXp6egVRh92xqbuYJQ4Fjb4FbBTRWz
         SSx+d4y2UvuBNrnrr2Cib1Plm+jYzwhm1zGTcu5THmhxYMYVAckwxstQJHkU6NT6uhF5
         0lZJsWMTHGlg9Bd1lRdt8bzc/7ZRPnG4cByfZrftEHke7hJYf0AwVx8IvytLGaMBqnMQ
         BLVb9DiT2Rpo2xKsK8wv5tLet7C53T/Kv34f9gdyD7q2hvfLB6qBbivLPRgaYgbuAweS
         ZBFJVPIerbq9vt5U5ubbX9O95CYVqY/xQNM9HTogbT8DydZuYRjeyptGY+l9IjzYcOR2
         iUtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686077272; x=1688669272;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9nepVt8ykMn9O/MEw0MYaAhSa9BA9jIh1JKqT4QH0FQ=;
        b=RZIUgsph1vFVGAeGLl4dp+GC8kkIpweUg1PG0YNG9M2qdWh4UzA8IeZP84VE9aw7sz
         qFiJfI8tj4e3QUJDdYBcA1ssajGWq27GSvJybvUxn4fZrTplzbdnBECMucAlAxJfTMKi
         M/6pKCZVBTsyxN2SFMUyquTtuwC4YM1PA9HlR1W/YE4M6xQ1K+KhK5ER31c2CfmZUivf
         8OU1etMCZR4Xz9i8w0JAWKxJqtwSonb5+jTP92wkZonUdNAdwaJUafbKNYdbash7v5Ov
         YYDiTSZOkA9m0r9IcA6PVCytFG9s5gUsbBgINJX649Y6Etr62UZp05wytUJ0LbS1+Qyt
         eDzQ==
X-Gm-Message-State: AC+VfDz9s4gxT3XL5xZ1QIvPw93oQsVWTMTHK8C3Y+ajOhtxRDfm30hL
        9rC4ULka1EcTz51q5kL8L+89KJsc1CE=
X-Google-Smtp-Source: ACHHUZ4mt1pSrGKy/CeR6TSOtxLIeYeKHDRMfl8b8wo8Pb3vM6k6MxnqAWXKs4EQG9AvRKHc0d+iyw==
X-Received: by 2002:a05:6808:919:b0:397:f6c7:c5b3 with SMTP id w25-20020a056808091900b00397f6c7c5b3mr3026222oih.16.1686077272440;
        Tue, 06 Jun 2023 11:47:52 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:f59e:5ad5:28cc:2003])
        by smtp.gmail.com with ESMTPSA id m7-20020a170902bb8700b001b225749647sm2758399pls.217.2023.06.06.11.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 11:47:51 -0700 (PDT)
Date:   Tue, 6 Jun 2023 11:47:48 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     cong yang <yangcong5@huaqin.corp-partner.google.com>
Cc:     Conor Dooley <conor@kernel.org>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jikos@kernel.org, benjamin.tissoires@redhat.com,
        dianders@chromium.org, hsinyi@google.com,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: input: touchscreen: Add ilitek 9882T
 touchscreen chip
Message-ID: <ZH9/VMp0vH6HLDBb@google.com>
References: <20230605060524.1178164-1-yangcong5@huaqin.corp-partner.google.com>
 <20230605060524.1178164-2-yangcong5@huaqin.corp-partner.google.com>
 <20230605-anyway-grab-f7a35aa199fb@spud>
 <CAHwB_NK_j1SJ1BBkVqafFM_+fWSyvwjCpMmHQxjLjnz_KHR=KA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHwB_NK_j1SJ1BBkVqafFM_+fWSyvwjCpMmHQxjLjnz_KHR=KA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06, 2023 at 10:06:05AM +0800, cong yang wrote:
> Hi,Conor,
> 
> On Mon, Jun 5, 2023 at 6:20 PM Conor Dooley <conor@kernel.org> wrote:
> >
> > Hey Cong Yang,
> >
> > On Mon, Jun 05, 2023 at 02:05:23PM +0800, Cong Yang wrote:
> > > Add an ilitek touch screen chip ili9882t.
> >
> > Could you add a comment here mentioning the relationship between these
> > chips?
> 
> Okay, I will add in V3 version.
> 
> > On Mon, Jun 05, 2023 at 02:05:23PM +0800, Cong Yang wrote:
> >
> > > Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
> > > ---
> > >  .../bindings/input/elan,ekth6915.yaml         | 23 ++++++++++++++++---
> > >  1 file changed, 20 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/Documentation/devicetree/bindings/input/elan,ekth6915.yaml b/Documentation/devicetree/bindings/input/elan,ekth6915.yaml
> > > index 05e6f2df604c..f0e7ffdce605 100644
> > > --- a/Documentation/devicetree/bindings/input/elan,ekth6915.yaml
> > > +++ b/Documentation/devicetree/bindings/input/elan,ekth6915.yaml
> > > @@ -15,11 +15,14 @@ description:
> > >
> > >  properties:
> > >    compatible:
> > > -    items:
> > > -      - const: elan,ekth6915
> > > +    enum:
> > > +      - elan,ekth6915
> > > +      - ilitek,ili9882t
> > >
> > >    reg:
> > > -    const: 0x10
> > > +    enum:
> > > +      - 0x10
> > > +      - 0x41
> >
> > Is 0x10 only valid for the elan,ekth6915 & 0x41 for the ilitek one?
> > If so, please add some enforcement of the values based on the
> > compatible.
> 
> I don't think 0x10 is the only address for ekth6915,(nor is 0x41 the
> only address for ili9882t). It depends on the hardware design.

Only a handful of controllers allow switching between addresses, and
if they do they typically have a "main" and an "alternate" one, and not
something completely customizable. I do not believe Elan offers ways to
program different address, do they?

Thanks.

-- 
Dmitry
