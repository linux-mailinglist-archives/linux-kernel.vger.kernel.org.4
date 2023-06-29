Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC117429EB
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 17:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232509AbjF2Pvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 11:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231496AbjF2Pvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 11:51:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB3A530D1;
        Thu, 29 Jun 2023 08:51:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 53F1F61512;
        Thu, 29 Jun 2023 15:51:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F0CEC433C0;
        Thu, 29 Jun 2023 15:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688053901;
        bh=0+IOMK6WhZShNaFf3O0bh+KyvYLal+y1KgYHkEx7OUo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bRnyyiZbJkO7ai5MWKdWLd0maxGj4i1sNZrEB9vFlT9XCeUTcc9EAmfWK7cmJP2m8
         TiXhrfMT9qTKz9jyfp9xG1099d9l6Fs55XDqaLsw6g5hmg+eb+/fh1gO7l8JrZQ5pS
         n9tw0fb9h+rFSrFvPQdyEtFW44c9CGu86dlykzG7jqyEhAJ+sKMQolRhlB4eLzsSNo
         RYWy1LQEkacvPwDf+oKdDUOo+jP+5STPBH4U5QTY+XkodHZmtEipUf+9MWNRFh0Vw8
         q2DCCVaSa+3JSWV2KT+v97OY7N62qMkWyO8FNTRtdzjMtwJf+kvAe/jVPpm18aiEqT
         1vFcSZOoDBDfA==
Date:   Thu, 29 Jun 2023 16:51:34 +0100
From:   Lee Jones <lee@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Rob Herring <robh@kernel.org>,
        William Breathitt Gray <william.gray@linaro.org>,
        "Sahin, Okan" <Okan.Sahin@analog.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        "Bolboaca, Ramona" <Ramona.Bolboaca@analog.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        "Tilki, Ibrahim" <Ibrahim.Tilki@analog.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v7 5/5] mfd: max77541: Add ADI MAX77541/MAX77540 PMIC
 Support
Message-ID: <20230629155134.GB2110266@google.com>
References: <20230626175443.GA3446604-robh@kernel.org>
 <20230627135615.GF10378@google.com>
 <CAL_JsqL3T6pjnTFgFvbYMeATD6cjhc-Sm0vZW2cv5k+w9Oxjuw@mail.gmail.com>
 <ZJry8QTka8m6ag/j@fedora>
 <20230627163344.GG10378@google.com>
 <CAL_Jsq+Z64tuMO8a2Y=2GrXZ8q0L4Z2avCiphsn0HOOC71Dzjg@mail.gmail.com>
 <20230628134013.GH10378@google.com>
 <472a4d86-3bfb-4c2b-a099-f1254dd01e24@sirena.org.uk>
 <20230629072500.GA2110266@google.com>
 <d070eecd-cb3b-4968-803e-1817a1a4359a@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d070eecd-cb3b-4968-803e-1817a1a4359a@sirena.org.uk>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Jun 2023, Mark Brown wrote:

> On Thu, Jun 29, 2023 at 08:25:00AM +0100, Lee Jones wrote:
> > On Wed, 28 Jun 2023, Mark Brown wrote:
> 
> > > As I mentioned before the number of resends of what are frequently very
> > > similar serieses (eg, two PMICs from the same vendor in flight at the
> > > same time) was causing me real issues with tags going AWOL and things
> > > getting lost in the noise.
> 
> > As much as I empathise with each of these points (I feel it too), the
> > alternative seems to be causing more issues for more people.  With that
> > in mind, I'm going to revert back to how we've been doing things for a
> > long time now.  Please try to Ack and forget.  If a contributor fails to
> > apply a previously issued tag, we'll have to bring that up at the time.
> 
> The thing that's causing a lot of the issues here is that you're only
> applying the serieses en masse, blocking things on getting absolutely
> everything lined up (including this time over a merge window).  I really
> don't understand why you feel you're forced to batch everything together
> like this.

https://lore.kernel.org/all/CAL_Jsq+Z64tuMO8a2Y=2GrXZ8q0L4Z2avCiphsn0HOOC71Dzjg@mail.gmail.com/

-- 
Lee Jones [李琼斯]
