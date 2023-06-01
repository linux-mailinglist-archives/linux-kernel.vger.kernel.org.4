Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9731871918C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 06:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbjFAEEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 00:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjFAED4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 00:03:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEC7DB2;
        Wed, 31 May 2023 21:03:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 82F2E61646;
        Thu,  1 Jun 2023 04:03:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 069F9C433D2;
        Thu,  1 Jun 2023 04:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685592233;
        bh=FpUMA+UmpnfCAjI0s1Cjb5HWSEuHsI8wU/Ubh3Bc0Rk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FxKoEm2DV+jtUJJSL8K6aCnFQSKSls4+YREVf9zr9+TC+8tkxYBY5p4jaafJtotuf
         jWei1nLx3iPbN0UwZMp8seD365yMPBvHmm9t9afAv+HgFcGSNLWStCO+vpisfzLWRg
         3fE8QvHpkKmHNRh65u0rR7xlupD/7aK76DsS17U1o8xjYCUKKofDr21SOnXg8CHijC
         xq6AwOXsqyiqVGr7z1qWhDv7LeHezxWnD0QcqmE88FVR4y2AyVxRvHCe3eeNWVnUa9
         8RXE+Qc+2W5TpQjo+A1yn50EnCmb4dLkFJs10btgRGjF93rUmtdwtorI8Y45a1dkNX
         cQ8nvI0v/1r/w==
Date:   Wed, 31 May 2023 21:07:34 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     "Mehul Raninga (Temp) (QUIC)" <quic_mraninga@quicinc.com>
Cc:     "agross@kernel.org" <agross@kernel.org>,
        "konrad.dybcio@linaro.org" <konrad.dybcio@linaro.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Viken Dadhaniya (QUIC)" <quic_vdadhani@quicinc.com>,
        "Visweswara Tanuku (QUIC)" <quic_vtanuku@quicinc.com>,
        "Vijaya Krishna Nivarthi (Temp) (QUIC)" <quic_vnivarth@quicinc.com>
Subject: Re: [PATCH] serial: qcom_geni_serial: Setup serial port after Deep
 sleep
Message-ID: <20230601040734.qiy3ibrpznrqptui@ripper>
References: <20230530111557.10944-1-quic_mraninga@quicinc.com>
 <20230530150631.7eg6nkre6sva5dcz@ripper>
 <SJ0PR02MB7742A7386189692ACACC0A3FE3489@SJ0PR02MB7742.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ0PR02MB7742A7386189692ACACC0A3FE3489@SJ0PR02MB7742.namprd02.prod.outlook.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 31, 2023 at 01:06:22PM +0000, Mehul Raninga (Temp) (QUIC) wrote:
> Hello Andersson,
> Thanks for the review. Kindly find my reply inline below
> 
> > -----Original Message-----
> > From: Bjorn Andersson <andersson@kernel.org>
> > Sent: Tuesday, May 30, 2023 8:37 PM
> > To: Mehul Raninga (Temp) (QUIC) <quic_mraninga@quicinc.com>
> > Cc: agross@kernel.org; konrad.dybcio@linaro.org; gregkh@linuxfoundation.org;
> > jirislaby@kernel.org; linux-arm-msm@vger.kernel.org; linux-
> > serial@vger.kernel.org; linux-kernel@vger.kernel.org; Viken Dadhaniya (QUIC)
> > <quic_vdadhani@quicinc.com>; Visweswara Tanuku (QUIC)
> > <quic_vtanuku@quicinc.com>; Vijaya Krishna Nivarthi (Temp) (QUIC)
> > <quic_vnivarth@quicinc.com>
> > Subject: Re: [PATCH] serial: qcom_geni_serial: Setup serial port after Deep sleep
> > 
> > WARNING: This email originated from outside of Qualcomm. Please be wary of
> > any links or attachments, and do not enable macros.
> > 
> > On Tue, May 30, 2023 at 04:45:57PM +0530, Mehul Raninga wrote:
> > > While exiting deep sleep, serial port loses its configuration hence it
> > > prints garbage characters on console.
> > 
> > Presumably it lost its configuration sometime after suspend, rather than while
> > resuming the system?
> 
> I will reword commit message in V2 as below:
> Serial port lost its configuration sometime after suspend hence it
> prints garbage characters on console after resuming.

Please wrap your replies to 72 chars wide

You can probably be more specific than "sometime after suspend" :)

> > 
> > >
> > > Set serial port configuration while resume from deep sleep.
> > >
> > 
> > What happens if you do this unconditionally?
> 
> pm_suspend_via_firmware returns true indicating system is resuming
> from deepsleep. In case we are not resuming from deepsleep, this
> serial port setup is not required.
> > 
> > > Signed-off-by: Mehul Raninga <quic_mraninga@quicinc.com>
> > > ---
> > >  drivers/tty/serial/qcom_geni_serial.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/drivers/tty/serial/qcom_geni_serial.c
> > > b/drivers/tty/serial/qcom_geni_serial.c
> > > index 8582479f0211..c04b8fec30ba 100644
> > > --- a/drivers/tty/serial/qcom_geni_serial.c
> > > +++ b/drivers/tty/serial/qcom_geni_serial.c
> > > @@ -20,6 +20,7 @@
> > >  #include <linux/serial.h>
> > >  #include <linux/serial_core.h>
> > >  #include <linux/slab.h>
> > > +#include <linux/suspend.h>
> > >  #include <linux/tty.h>
> > >  #include <linux/tty_flip.h>
> > >  #include <dt-bindings/interconnect/qcom,icc.h>
> > > @@ -1737,6 +1738,8 @@ static int qcom_geni_serial_sys_resume(struct
> > device *dev)
> > >       if (uart_console(uport)) {
> > >               geni_icc_set_tag(&port->se, QCOM_ICC_TAG_ALWAYS);
> > >               geni_icc_set_bw(&port->se);
> > > +             if (pm_suspend_via_firmware())
> > 
> > I'm not familiar with this api, but aren't all our systems implementing firmware-
> > assisted suspend?
> 
> Not all the platform supports deep sleep hence to differentiate if
> resume is from deep sleep suspend or normal suspend, this api is
> required.

Can you point me to where this difference in flags is coming from in the
upstream kernel?

Thanks,
Bjorn

> > 
> > Regards,
> > Bjorn
> > 
> > > +                     qcom_geni_serial_port_setup(uport);
> > >       }
> > >       return ret;
> > >  }
> > > --
> > > 2.17.1
> > >
