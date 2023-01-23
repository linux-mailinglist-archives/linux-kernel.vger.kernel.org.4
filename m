Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D46086787DA
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 21:33:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232281AbjAWUds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 15:33:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231607AbjAWUdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 15:33:46 -0500
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEC3983E5;
        Mon, 23 Jan 2023 12:33:44 -0800 (PST)
Received: by mail-oi1-f174.google.com with SMTP id i5so11440390oih.11;
        Mon, 23 Jan 2023 12:33:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TrqI5Ij0O95gCzmKCmcYaV3PIFWC+QL1zw9c0VIbm+A=;
        b=I1aAQocG/0QuLGz2DX2Zn7xL4D1cfH+3z64mnnp2Qb74Dt1dzl2nDsQlDsnbShf/lw
         KQENvKn0rIrdL583wgFJZSyDeOVKDP5l/Dt3ZJegj0jGLCiR5qtuc2+dUJ/sNYXDud3s
         +fZ5b1Bu35g5281+GN0dUrpEi4u8nJpYWg1Aag4+kZ1aAQOFzrp5wZ/qSISNnerjgUP7
         3uTimR+I5hSEvYZj5iHXApsvoFi1UCQ4Jl0j0cOHIjcR0GLAECiF81pwJ0RIND76wCpH
         X6KU/BJC4FvfeX3klTRcd8KkgTg75Wte5V3IDNkcWRsMzQEJ0IgP3FWkK8JYy0TRRN2o
         TeVg==
X-Gm-Message-State: AFqh2koTA6pXSvC7Dmkg1w2lTkxYUParGALct1gk5Jv+csxL+bFgpgA7
        S6o0+uAZk148TORNBlcplA==
X-Google-Smtp-Source: AMrXdXsGKKWCKC87sdHRroBTg34rpaNG4pqP2GTedN+HwXhwJK32IDUo9Nlm9V/lhJeTRuJUTQ1oeQ==
X-Received: by 2002:a05:6808:2819:b0:360:cd17:6968 with SMTP id et25-20020a056808281900b00360cd176968mr18783885oib.15.1674506024074;
        Mon, 23 Jan 2023 12:33:44 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id bx35-20020a0568081b2300b0036701c185basm135326oib.55.2023.01.23.12.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 12:33:43 -0800 (PST)
Received: (nullmailer pid 2476342 invoked by uid 1000);
        Mon, 23 Jan 2023 20:33:41 -0000
Date:   Mon, 23 Jan 2023 14:33:41 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lucas Stankus <lucas.p.stankus@gmail.com>,
        Puranjay Mohan <puranjay12@gmail.com>,
        Dmitry Rokosov <ddrokosov@sberdevices.ru>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
        Renato Lui Geh <renatogeh@gmail.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Andreas Klinger <ak@it-klinger.de>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        Kent Gustavsson <kent@minoris.se>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Oleksij Rempel <linux@rempel-privat.de>, kernel@pengutronix.de,
        =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>,
        Nishant Malpani <nish.malpani25@gmail.com>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        Dragos Bogdan <dragos.bogdan@analog.com>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Stefan Popa <stefan.popa@analog.com>,
        Robert Yang <decatf@gmail.com>,
        Sean Nyekjaer <sean@geanix.com>,
        Artur Rojek <contact@artur-rojek.eu>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Philippe Reynes <tremyfr@yahoo.fr>,
        Alexandru Lazar <alazar@startmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Stefan Agner <stefan@agner.ch>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Harald Geyer <harald@ccbib.org>,
        Eugene Zaikonnikov <ez@norophonic.com>,
        Phil Reid <preid@electromag.com.au>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Sankar Velliangiri <navin@linumiz.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        chrome-platform@lists.linux.dev
Subject: Re: [PATCH 3/5] dt-bindings: iio: correct node names in examples
Message-ID: <20230123203341.GA2459877-robh@kernel.org>
References: <20230118184413.395820-1-krzysztof.kozlowski@linaro.org>
 <20230118184413.395820-3-krzysztof.kozlowski@linaro.org>
 <20230121171709.5eb75e94@jic23-huawei>
 <45b9b378-6619-c47a-b5ea-6b6b7edca785@linaro.org>
 <20230122170105.6a1a9766@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230122170105.6a1a9766@jic23-huawei>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 22, 2023 at 05:01:05PM +0000, Jonathan Cameron wrote:
> On Sat, 21 Jan 2023 19:31:23 +0100
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> 
> > On 21/01/2023 18:17, Jonathan Cameron wrote:
> > > On Wed, 18 Jan 2023 19:44:11 +0100
> > > Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> > >   
> > >> Do not use underscores and unneeded suffixes (e.g. i2c0) in node name in
> > >> examples.
> > >>
> > >> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > >> ---  
> > >   
> > >> diff --git a/Documentation/devicetree/bindings/iio/health/ti,afe4403.yaml b/Documentation/devicetree/bindings/iio/health/ti,afe4403.yaml
> > >> index 6c5ad426a016..12f75ddc4a70 100644
> > >> --- a/Documentation/devicetree/bindings/iio/health/ti,afe4403.yaml
> > >> +++ b/Documentation/devicetree/bindings/iio/health/ti,afe4403.yaml
> > >> @@ -42,7 +42,7 @@ examples:
> > >>          #address-cells = <1>;
> > >>          #size-cells = <0>;
> > >>  
> > >> -        heart_mon@0 {
> > >> +        heart-rate@0 {  
> > > 
> > > These are both heart-rate and pulse oximeters so measure more than just
> > > the rate (oxygen saturation in the blood). Reality is they actually
> > > measure light absorption over time, but you can calculate an estimate
> > > of both rate and oxygen saturation from that.
> > > 
> > > I don't really mind simplifying that to heart-rate, but wanted to
> > > call this out for possible discussion.  
> > 
> > They could be heart-mon. The fix is mostly around the underscore. I
> > don't have any arguments for changing it to heart-rate, thus we can go
> > with whatever you prefer.
> I'm fine with either and as we have a patch with heart-rate that wins
> currently. I'll just let this sit for a little longer than
> normal to see if we get any other responses!

I don't care all that much until we've documented something. Otherwise, 
we may be just changing things twice. We have the list in the spec, but 
really I'd like that in schema form. We'd also need to figure out how to 
use that. There's always going to be odd things which we don't have any 
defined name.

For now, I'd just do 's/_/-/'.

Rob
