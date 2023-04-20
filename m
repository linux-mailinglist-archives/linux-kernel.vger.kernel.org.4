Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6B06E8C91
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 10:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234401AbjDTIVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 04:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233947AbjDTIVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 04:21:09 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3688B35B1;
        Thu, 20 Apr 2023 01:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681978868; x=1713514868;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4/conQ/6kczdzx/+dtomCs4WTfQIoGhLLwAeEZdDT40=;
  b=dP/zgW+STXui9fGDf9uXbiFD/3l77t4lwM5fhkIzGghIzsRDRev2ZOz+
   MDbxLHgUGiy/R+HA939WdIwsj7XUpOe1+alCgcYSZtYTRF64QJBA6lecM
   +OpsCPeUeO1qUA4GmkxuPHdeDfAknn9U8Hk53wQ4rgSkhRFVo3FFVVyhF
   dQGukaKCkKsK0zDgiBFJfyZD2jNeqT8EQ3TcU1TssE+A71HyT0nvUrCvY
   7qHekXNSvJYqbgd9O0g6VdffMcE427a2FwLlL+QWHnvvA6lT1kLVxnqX5
   Cnt/mxzKpy0xdVlYDtl4/OI7GyjgTe0e+oWSVkB2BZ4JPMCna09umEWeB
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="344425647"
X-IronPort-AV: E=Sophos;i="5.99,212,1677571200"; 
   d="scan'208";a="344425647"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2023 01:21:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="835631405"
X-IronPort-AV: E=Sophos;i="5.99,212,1677571200"; 
   d="scan'208";a="835631405"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 20 Apr 2023 01:21:00 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 20 Apr 2023 11:20:58 +0300
Date:   Thu, 20 Apr 2023 11:20:58 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Frank Wang <frank.wang@rock-chips.com>, linux@roeck-us.net,
        heiko@sntech.de, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        huangtao@rock-chips.com, william.wu@rock-chips.com,
        jianwei.zheng@rock-chips.com, yubing.zhang@rock-chips.com,
        wmc@rock-chips.com
Subject: Re: [PATCH v2] usb: typec: tcpm: fix multiple times discover svids
 error
Message-ID: <ZED16m8B1K+7sdJK@kuha.fi.intel.com>
References: <20230316081149.24519-1-frank.wang@rock-chips.com>
 <ZBROkdOFAP4GPPU6@kuha.fi.intel.com>
 <ZEDzGydXbbpekeaB@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZEDzGydXbbpekeaB@kroah.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 20, 2023 at 10:08:59AM +0200, Greg KH wrote:
> On Fri, Mar 17, 2023 at 01:27:13PM +0200, Heikki Krogerus wrote:
> > On Thu, Mar 16, 2023 at 04:11:49PM +0800, Frank Wang wrote:
> > > PD3.0 Spec 6.4.4.3.2 say that only Responder supports 12 or more SVIDs,
> > > the Discover SVIDs Command Shall be executed multiple times until a
> > > Discover SVIDs VDO is returned ending either with a SVID value of
> > > 0x0000 in the last part of the last VDO or with a VDO containing two
> > > SVIDs with values of 0x0000.
> > > 
> > > In the current implementation, if the last VDO does not find that the
> > > Discover SVIDs Command would be executed multiple times even if the
> > > Responder SVIDs are less than 12, and we found some odd dockers just
> > > meet this case. So fix it.
> > > 
> > > Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
> > > ---
> > >  drivers/usb/typec/tcpm/tcpm.c | 16 +++++++++++++++-
> > >  1 file changed, 15 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> > > index 66de02a56f512..a3ae2c79f3540 100644
> > > --- a/drivers/usb/typec/tcpm/tcpm.c
> > > +++ b/drivers/usb/typec/tcpm/tcpm.c
> > > @@ -1515,7 +1515,21 @@ static bool svdm_consume_svids(struct tcpm_port *port, const u32 *p, int cnt)
> > >  		pmdata->svids[pmdata->nsvids++] = svid;
> > >  		tcpm_log(port, "SVID %d: 0x%x", pmdata->nsvids, svid);
> > >  	}
> > > -	return true;
> > > +
> > > +	/*
> > > +	 * PD3.0 Spec 6.4.4.3.2: The SVIDs are returned 2 per VDO (see Table
> > > +	 * 6-43), and can be returned maximum 6 VDOs per response (see Figure
> > > +	 * 6-19). If the Respondersupports 12 or more SVID then the Discover
> > > +	 * SVIDs Command Shall be executed multiple times until a Discover
> > > +	 * SVIDs VDO is returned ending either with a SVID value of 0x0000 in
> > > +	 * the last part of the last VDO or with a VDO containing two SVIDs
> > > +	 * with values of 0x0000.
> > > +	 *
> > > +	 * However, some odd dockers support SVIDs less than 12 but without
> > > +	 * 0x0000 in the last VDO, so we need to break the Discover SVIDs
> > > +	 * request and return false here.
> > > +	 */
> > > +	return cnt == 7;
> > >  abort:
> > >  	tcpm_log(port, "SVID_DISCOVERY_MAX(%d) too low!", SVID_DISCOVERY_MAX);
> > >  	return false;
> > 
> > This is OK by men, but let's wait for Guenter.
> 
> What ever happened to this patch?

I wanted to wait for Guenter's review, but FWIW:

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

thanks,

-- 
heikki
