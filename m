Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B211974D79E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 15:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232215AbjGJNb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 09:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232079AbjGJNbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 09:31:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA633E9;
        Mon, 10 Jul 2023 06:31:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5DDC860B8D;
        Mon, 10 Jul 2023 13:31:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52D03C433C7;
        Mon, 10 Jul 2023 13:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688995876;
        bh=1TvHTk0OvZW5mauoWR+EvpE5IuZ2XI67qVt1FK3GGiA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EBHY3sJD7EWCavU+5I3QVagZ5RrjcoWTRlOqCjdxndRxyARrJv6y64nXnrKcDGhvl
         yE1E5RyOPOIpv0cwUlhUItiysrnmmS7fGqEE5xRcGwUQB+SK1+52uTmQQ5l5PduAbz
         8alNCnMB5IF7Ezy6fvQxEgPcJlnmNnusOXZgCLGc=
Date:   Mon, 10 Jul 2023 15:31:13 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 2/2] usb: typec: qcom-pmic-typec: register drm_bridge
Message-ID: <2023071052-hedging-blurb-2a20@gregkh>
References: <20230709201309.274306-1-dmitry.baryshkov@linaro.org>
 <20230709201309.274306-3-dmitry.baryshkov@linaro.org>
 <0408a6f6-356e-af6a-3e32-1781aec2854f@linaro.org>
 <74aa7196-e76c-a1c8-9b0f-1d5f236d3467@linaro.org>
 <CAA8EJpppsaKqKY0V9O1JMUGiE8USzg8b0ZPZwn-0bwg1wYD6Tw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA8EJpppsaKqKY0V9O1JMUGiE8USzg8b0ZPZwn-0bwg1wYD6Tw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2023 at 01:57:06PM +0300, Dmitry Baryshkov wrote:
> On Mon, 10 Jul 2023 at 13:04, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
> >
> > On 10.07.2023 12:02, Bryan O'Donoghue wrote:
> > > On 09/07/2023 21:13, Dmitry Baryshkov wrote:
> > >> The current approach to handling DP on bridge-enabled platforms requires
> > >> a chain of DP bridges up to the USB-C connector. Register a last DRM
> > >> bridge for such chain.
> > >>
> > >> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > >> ---
> > >>   drivers/usb/typec/tcpm/Kconfig                |  1 +
> > >>   drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c | 39 +++++++++++++++++++
> > >>   2 files changed, 40 insertions(+)
> > >>
> > >> diff --git a/drivers/usb/typec/tcpm/Kconfig b/drivers/usb/typec/tcpm/Kconfig
> > >> index 5d393f520fc2..0b2993fef564 100644
> > >> --- a/drivers/usb/typec/tcpm/Kconfig
> > >> +++ b/drivers/usb/typec/tcpm/Kconfig
> > >> @@ -79,6 +79,7 @@ config TYPEC_WCOVE
> > >>   config TYPEC_QCOM_PMIC
> > >>       tristate "Qualcomm PMIC USB Type-C Port Controller Manager driver"
> > >>       depends on ARCH_QCOM || COMPILE_TEST
> > >> +    depends on DRM || DRM=n
> > >>       help
> > >>         A Type-C port and Power Delivery driver which aggregates two
> > >>         discrete pieces of silicon in the PM8150b PMIC block: the
> > >> diff --git a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c
> > >> index a905160dd860..0722fb8d75c4 100644
> > >> --- a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c
> > >> +++ b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c
> > >> @@ -17,6 +17,9 @@
> > >>   #include <linux/usb/role.h>
> > >>   #include <linux/usb/tcpm.h>
> > >>   #include <linux/usb/typec_mux.h>
> > >> +
> > >> +#include <drm/drm_bridge.h>
> > >> +
> > >>   #include "qcom_pmic_typec_pdphy.h"
> > >>   #include "qcom_pmic_typec_port.h"
> > >>   @@ -33,6 +36,9 @@ struct pmic_typec {
> > >>       struct pmic_typec_port    *pmic_typec_port;
> > >>       bool            vbus_enabled;
> > >>       struct mutex        lock;        /* VBUS state serialization */
> > >> +#ifdef CONFIG_DRM
> > >> +    struct drm_bridge    bridge;
> > >> +#endif
> > >
> > > IMO there's no reason to ifdef the structure. Its up to you if you want to change it nor not, I have no strong feelings about it.
> > +1, there's no ifdefs in the drm_bridge.h header that would make this not compile
> 
> It is quite typical to idef unused structure fields. For example
> OF-related fields are frequently ifdef'ed.
> Let's see what the maintainers will say.

Please do not put #ifdef in .c files.

If it's not needed, please remove.

thanks,

greg k-h
