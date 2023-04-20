Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C34776E8C41
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 10:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234343AbjDTIJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 04:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234337AbjDTIJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 04:09:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1DF9FC;
        Thu, 20 Apr 2023 01:09:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2746C645AB;
        Thu, 20 Apr 2023 08:09:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 911D1C433EF;
        Thu, 20 Apr 2023 08:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1681978147;
        bh=ImzOYmQ4yUAimeoREYTG/Ic4X9E0mCDibkc7vPhya5g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Gm2KDvefKPiwYxUSqqIQl5ioJOzO0AcVRlCaKwSP1rY1ZyadRI8dF/Ce3WkKJQRSs
         Sc5BXlTLKFHYQwrzFGZOKgV2aR12u/kZ4Dw9hUXt8WZ8IAZh+a33VypEYXIwETMJT4
         RtiSofNBctrEcmE2qu2FroRvVRTLpqw8hK4BzQmQ=
Date:   Thu, 20 Apr 2023 10:08:59 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Frank Wang <frank.wang@rock-chips.com>, linux@roeck-us.net,
        heiko@sntech.de, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        huangtao@rock-chips.com, william.wu@rock-chips.com,
        jianwei.zheng@rock-chips.com, yubing.zhang@rock-chips.com,
        wmc@rock-chips.com
Subject: Re: [PATCH v2] usb: typec: tcpm: fix multiple times discover svids
 error
Message-ID: <ZEDzGydXbbpekeaB@kroah.com>
References: <20230316081149.24519-1-frank.wang@rock-chips.com>
 <ZBROkdOFAP4GPPU6@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBROkdOFAP4GPPU6@kuha.fi.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 17, 2023 at 01:27:13PM +0200, Heikki Krogerus wrote:
> On Thu, Mar 16, 2023 at 04:11:49PM +0800, Frank Wang wrote:
> > PD3.0 Spec 6.4.4.3.2 say that only Responder supports 12 or more SVIDs,
> > the Discover SVIDs Command Shall be executed multiple times until a
> > Discover SVIDs VDO is returned ending either with a SVID value of
> > 0x0000 in the last part of the last VDO or with a VDO containing two
> > SVIDs with values of 0x0000.
> > 
> > In the current implementation, if the last VDO does not find that the
> > Discover SVIDs Command would be executed multiple times even if the
> > Responder SVIDs are less than 12, and we found some odd dockers just
> > meet this case. So fix it.
> > 
> > Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
> > ---
> >  drivers/usb/typec/tcpm/tcpm.c | 16 +++++++++++++++-
> >  1 file changed, 15 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> > index 66de02a56f512..a3ae2c79f3540 100644
> > --- a/drivers/usb/typec/tcpm/tcpm.c
> > +++ b/drivers/usb/typec/tcpm/tcpm.c
> > @@ -1515,7 +1515,21 @@ static bool svdm_consume_svids(struct tcpm_port *port, const u32 *p, int cnt)
> >  		pmdata->svids[pmdata->nsvids++] = svid;
> >  		tcpm_log(port, "SVID %d: 0x%x", pmdata->nsvids, svid);
> >  	}
> > -	return true;
> > +
> > +	/*
> > +	 * PD3.0 Spec 6.4.4.3.2: The SVIDs are returned 2 per VDO (see Table
> > +	 * 6-43), and can be returned maximum 6 VDOs per response (see Figure
> > +	 * 6-19). If the Respondersupports 12 or more SVID then the Discover
> > +	 * SVIDs Command Shall be executed multiple times until a Discover
> > +	 * SVIDs VDO is returned ending either with a SVID value of 0x0000 in
> > +	 * the last part of the last VDO or with a VDO containing two SVIDs
> > +	 * with values of 0x0000.
> > +	 *
> > +	 * However, some odd dockers support SVIDs less than 12 but without
> > +	 * 0x0000 in the last VDO, so we need to break the Discover SVIDs
> > +	 * request and return false here.
> > +	 */
> > +	return cnt == 7;
> >  abort:
> >  	tcpm_log(port, "SVID_DISCOVERY_MAX(%d) too low!", SVID_DISCOVERY_MAX);
> >  	return false;
> 
> This is OK by men, but let's wait for Guenter.

What ever happened to this patch?

thanks,

greg k-h
