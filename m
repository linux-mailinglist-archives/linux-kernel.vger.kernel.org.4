Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 112486C366C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 17:00:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231543AbjCUQAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 12:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231418AbjCUQAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 12:00:04 -0400
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B40742688;
        Tue, 21 Mar 2023 08:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=aS8MFhdJ30cMvkQgg+DI1ei4jfPRzJJxBGYN5yzRvQk=;
  b=lDA3lmlX/N08J0TUs7CdbT5vT/WVJNnAUSIOShviI/gS7i5N8yQZLTKy
   C78MWpZSWw3roLWVMrnfgjs/FFLJUGz5ymy+nnVaVPQAqUfpJKfONQz9X
   ST29DUpxw8zw7jW5fWSCH1Otr5d0kQOXPBcgiZU+uYX02MCRTWyGGxqC9
   A=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.98,279,1673910000"; 
   d="scan'208";a="98336204"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2023 16:59:49 +0100
Date:   Tue, 21 Mar 2023 16:59:49 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
To:     =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
cc:     Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>,
        gregkh@linuxfoundation.org, outreachy@lists.linux.dev,
        johan@kernel.org, elder@kernel.org, vireshk@kernel.org,
        thierry.reding@gmail.com, greybus-dev@lists.linaro.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH 2/3] staging: greybus: use inline function for macros
In-Reply-To: <20230321154728.3r7ut3rl2pccmo2e@pengutronix.de>
Message-ID: <82a4e5f1-a1f2-c70-3645-9464ccb17bab@inria.fr>
References: <cover.1679352669.git.eng.mennamahmoud.mm@gmail.com> <1274302b52ae905dab6f75377d625598facbbdf1.1679352669.git.eng.mennamahmoud.mm@gmail.com> <20230321154728.3r7ut3rl2pccmo2e@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1488484427-1679414389=:10740"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1488484427-1679414389=:10740
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT



On Tue, 21 Mar 2023, Uwe Kleine-König wrote:

> Hello,
>
> just some nitpicks:
>
> On Tue, Mar 21, 2023 at 01:04:33AM +0200, Menna Mahmoud wrote:
> > Convert `to_gbphy_dev` and `to_gbphy_driver` macros into a
> > static inline function.
> >
> > it is not great to have macro that use `container_of` macro,
>
> s/it/It/; s/macro/macros/; s/use/use the/;
>
> > because from looking at the definition one cannot tell what type
> > it applies to.
> > [...]
> > -#define to_gbphy_dev(d) container_of(d, struct gbphy_device, dev)
> > +static inline struct gbphy_device *to_gbphy_dev(const struct device *d)
>
> drivers/staging/greybus/gbphy.c always passes a variable named
> "dev" to this macro. So I'd call the parameter "dev", too, instead of
> "d". This is also a more typical name for variables of that type.

I argued against that.  Because then there are two uses of dev
in the argument of container_of, and they refer to completely different
things.  It's true that by the way container_of works, it's fine, but it
may be misleading.

julia

>
> > +{
> > +	return container_of(d, struct gbphy_device, dev);
> > +}
> > [...]
> >  };
> > -#define to_gbphy_driver(d) container_of(d, struct gbphy_driver, driver)
> > +static inline struct gbphy_driver *to_gbphy_driver(struct device_driver *d)
> > +{
> > +	return container_of(d, struct gbphy_driver, driver);
> > +}
>
> With a similar reasoning (and also to not have "d"s that are either
> device or device_driver) I'd recommend "drv" here.
>
> Best regards
> Uwe
>
> --
> Pengutronix e.K.                           | Uwe Kleine-König            |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ |
>
--8323329-1488484427-1679414389=:10740--
