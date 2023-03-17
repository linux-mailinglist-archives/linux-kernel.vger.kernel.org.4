Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44A226BE7F7
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 12:24:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbjCQLYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 07:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjCQLYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 07:24:15 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80A07199D5;
        Fri, 17 Mar 2023 04:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679052252; x=1710588252;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ne+p3N8Ib99sku3IAtZqQTH9XpGJHwwTexAnxYXGCk8=;
  b=H6QxXdiyKDxXGeCnnaIbGXJH7sp9FCCeDD0gdJ5e1YXthpi2poUWI3tq
   udOujGjEzO6RuYq1neq1QTGoxxVhAOQSg3gFlLSErlDky/tMWkq4uNOLK
   yuJbZrnOhgh2fNJzGHk3Pjtxvwth+SWwueOjN2GkL2/2/iPOJnp5cFyoj
   tbUsTPCl6vQ/79SnEKRi48maXh5CV0KrC+QetWsvoNcblo6h5EsGugzta
   655sTa95HGFfbBmtZJ83TcDX8858nL9vlYYcEjBRYLmqsISEgaOqUWdOT
   VB2yxcWJSMogUY2eiySEfTje/Dcm1+BY8kR0iGDUDUJwQqZKW2lMhf0AB
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="424511069"
X-IronPort-AV: E=Sophos;i="5.98,268,1673942400"; 
   d="scan'208";a="424511069"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2023 04:24:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="823638591"
X-IronPort-AV: E=Sophos;i="5.98,268,1673942400"; 
   d="scan'208";a="823638591"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 17 Mar 2023 04:24:08 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 17 Mar 2023 13:24:07 +0200
Date:   Fri, 17 Mar 2023 13:24:07 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Frank Wang <frank.wang@rock-chips.com>
Cc:     linux@roeck-us.net, gregkh@linuxfoundation.org, heiko@sntech.de,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, huangtao@rock-chips.com,
        william.wu@rock-chips.com, jianwei.zheng@rock-chips.com,
        yubing.zhang@rock-chips.com, wmc@rock-chips.com
Subject: Re: [PATCH 1/4] usb: typec: tcpm: fix cc role at port reset
Message-ID: <ZBRN11OwtkvXk1Hd@kuha.fi.intel.com>
References: <20230313025843.17162-1-frank.wang@rock-chips.com>
 <20230313025843.17162-2-frank.wang@rock-chips.com>
 <ZBA8Y/dbozOk2df7@kuha.fi.intel.com>
 <f0f0ac72-0a90-da9e-f686-49c21a76866b@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0f0ac72-0a90-da9e-f686-49c21a76866b@rock-chips.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 15, 2023 at 10:55:20AM +0800, Frank Wang wrote:
> Hi Heikki,
> 
> On 2023/3/14 17:20, Heikki Krogerus wrote:
> > On Mon, Mar 13, 2023 at 10:58:40AM +0800, Frank Wang wrote:
> > > In the current implementation, the tcpm set CC1/CC2 role to open when
> > > it do port reset would cause the VBUS removed by the Type-C partner.
> > > 
> > > The Figure 4-20 in the TCPCI 2.0 specification show that the CC1/CC2
> > > role should set to 01b (Rp) or 10b (Rd) at Power On or Reset stage
> > > in DRP initialization and connection detection.
> > > 
> > > So set CC1/CC2 to Rd to fix it.
> > > 
> > > Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
> > > ---
> > >   drivers/usb/typec/tcpm/tcpm.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> > > index a0d943d785800..66de02a56f512 100644
> > > --- a/drivers/usb/typec/tcpm/tcpm.c
> > > +++ b/drivers/usb/typec/tcpm/tcpm.c
> > > @@ -4851,7 +4851,7 @@ static void run_state_machine(struct tcpm_port *port)
> > >   		break;
> > >   	case PORT_RESET:
> > >   		tcpm_reset_port(port);
> > > -		tcpm_set_cc(port, TYPEC_CC_OPEN);
> > > +		tcpm_set_cc(port, TYPEC_CC_RD);
> > >   		tcpm_set_state(port, PORT_RESET_WAIT_OFF,
> > >   			       PD_T_ERROR_RECOVERY);
> > >   		break;
> > Will this work if the port is for example source only?
> 
> Yeah, this only set at port reset stage and CC value will be set again
> (Rd for Sink, Rp_* for Source) when start toggling.

Okay. Let's wait for comments from Guenter.

thanks,

-- 
heikki
