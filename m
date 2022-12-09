Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD1C64871D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 17:58:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbiLIQ6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 11:58:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbiLIQ6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 11:58:05 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00D1756EED
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 08:57:57 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id x28so7960549lfn.6
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 08:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RpqPCBfzDAs8JVS1IeOpD/CKxCRHOoR51Vnm5lxDkNA=;
        b=lsm4bM/FVHMd9HNKHL0b6U4XIPGnbS59knpkI/1xA5FnZQfqN3PUXusvmDIht8LRNa
         P2vbJj4oi73OsOmEOrlLKzDBweEBcFCa0bCOVRpmsl/skFkyXhI5Km9L7UfAf8YQ1d7k
         QaBuOOZvdDjHkIQic82vHrks4VJm0S1NCJwmzhWMiCiCxo57iiq12dLDKVYGldmqPgp2
         Rm2jqVZ4h1lx/eqy4hHdYDQ+1i/JCNYd63U+Iq9vwkT1XtFbltg0Fd96byPPBhmpkfH3
         LKKAKWYkzD3CEX3oXnHwRRCEA/GZhIxws/cQifyAFBoysezf0/Z7kyjGlo+24fi3axOi
         GikQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RpqPCBfzDAs8JVS1IeOpD/CKxCRHOoR51Vnm5lxDkNA=;
        b=yuTjGLGE7OL3+eXNcK0RPd8DwnfVdX6tjPGLBe01GatZTzDIHjsskz/HpV+v6Px+1L
         g/6HmTV/WaY0lavtcVlsjkXrCI9guSXjuQ7BU04vE0hWyO61OOgILCjnCQq6kdJma7n3
         l2NSl7r1bNGgVBHw6DIIssA80qKnz7+mYs/yYeDAUU8G/No+UwHMMFOVuykOr6BhxA6Q
         B8jRT2RB7rS3Xi1ElISgWOxI29H8ptTEQC6mrr1vpwcq1RUlW4BnekBBXKvHvIvL6qDE
         ntyaYXl7fvqxWzLsBtdta7f1DmomAoMQ3YdL/R1xS3RBOCOXZuym5DGeAIHuJQ+39HLb
         KaTA==
X-Gm-Message-State: ANoB5pltTEv+/tNz76vdWaJXG28HzyvgQq8dnjcotCj4WAXC+8ydW2dJ
        skIyFfUU7dmOhN23Xx8tsV8ZzQ==
X-Google-Smtp-Source: AA0mqf7kzu6iAfWEPXh8v/aZNVbaQTPA+0OCONbOH+E5SHR2eUqLP85TXJEV/QkpOHRfXXEDIX1s/g==
X-Received: by 2002:a19:7405:0:b0:4b5:7096:23ff with SMTP id v5-20020a197405000000b004b5709623ffmr1813356lfe.66.1670605076396;
        Fri, 09 Dec 2022 08:57:56 -0800 (PST)
Received: from krzk-bin (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id y1-20020a196401000000b004b5850e6b63sm332534lfb.65.2022.12.09.08.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 08:57:55 -0800 (PST)
Date:   Fri, 9 Dec 2022 17:57:53 +0100
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Marcello Sylvester Bauer <sylv@sylv.io>
Subject: Re: [RESEND PATCH v11 2/2] mfd: max597x: Add support for MAX5970 and
 MAX5978
Message-ID: <20221209165753.q4ovlu2lebxfibed@krzk-bin>
References: <20221124110210.3905092-1-Naresh.Solanki@9elements.com>
 <20221124110210.3905092-3-Naresh.Solanki@9elements.com>
 <CABqG17hCoY86w3usA6RNLQbGjHo_JRFioznuvdCZLo4_KNaMWg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CABqG17hCoY86w3usA6RNLQbGjHo_JRFioznuvdCZLo4_KNaMWg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 06, 2022 at 11:00:52PM +0530, Naresh Solanki wrote:
> ping

You missed several mailing lists and maintainers, so whom do you ping?
Yourself? Please start using get_maintainers.pl...

>=20
> Regards,
> Naresh Solanki
>=20
>=20
>=20
> 9elements GmbH, Kortumstra=C3=9Fe 19-21, 44787 Bochum, Germany
> Email:  naresh.solanki@9elements.com
> Mobile:  +91 9538631477
>=20
> Sitz der Gesellschaft: Bochum
> Handelsregister: Amtsgericht Bochum, HRB 17519
> Gesch=C3=A4ftsf=C3=BChrung: Sebastian Deutsch, Eray Basar
>=20
> Datenschutzhinweise nach Art. 13 DSGVO
>=20
