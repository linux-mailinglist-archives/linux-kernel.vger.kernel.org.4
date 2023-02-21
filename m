Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD0B169E1AB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 14:48:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233722AbjBUNsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 08:48:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233681AbjBUNsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 08:48:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 019EA55B6;
        Tue, 21 Feb 2023 05:48:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A6D2BB80EA4;
        Tue, 21 Feb 2023 13:48:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00B51C433EF;
        Tue, 21 Feb 2023 13:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1676987327;
        bh=2TM8cD39FcqW3UyP2lWEFylxG1JRyg7YkP7CzvuECJ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fozNm5rFYq3oCk4d5IStZhRPm4Rqil7tkfa2ClSpJE0arhrmEELp3lwRXs1n7Hnc3
         N7FGVhjQD8elI9Dyd0ZuVhLlA7iYa2/UYTGTZeTzuasrFW2me7Dipunld+r/zB0cbd
         KAwh9Kr84w/SC9IwYyvTtr8kabbjDv6ZWXYvr/sI=
Date:   Tue, 21 Feb 2023 14:48:45 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ziyang Huang <hzyitc@outlook.com>
Cc:     hminas@synopsys.com, fabrice.gasnier@foss.st.com,
        amelie.delaunay@foss.st.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usb: dwc2: drd: fix inconsistent mode if
 role-switch-default-mode="host"
Message-ID: <Y/TLvbMPfiBC2ujE@kroah.com>
References: <SG2PR01MB204837BF68EDB0E343D2A375C9A59@SG2PR01MB2048.apcprd01.prod.exchangelabs.com>
 <Y/Sf8j5y+DJ9L4fY@kroah.com>
 <SG2PR01MB2048B375B64A96654FA20DABC9A59@SG2PR01MB2048.apcprd01.prod.exchangelabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SG2PR01MB2048B375B64A96654FA20DABC9A59@SG2PR01MB2048.apcprd01.prod.exchangelabs.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2023 at 08:33:32PM +0800, Ziyang Huang wrote:
> 
> 在 2023/2/21 18:41, Greg KH 写道:
> > On Tue, Feb 21, 2023 at 06:30:04PM +0800, Ziyang Huang wrote:
> > > Some boards might use USB-A female connector for USB ports, however,
> > > the port could be connected to a dual-mode USB controller, making it
> > > also behaves as a peripheral device if male-to-male cable is connected.
> > > 
> > > In this case, the dts looks like this:
> > > 
> > > 	&usb0 {
> > > 		status = "okay";
> > > 		dr_mode = "otg";
> > > 		usb-role-switch;
> > > 		role-switch-default-mode = "host";
> > > 	};
> > > 
> > > After boot, dwc2_ovr_init() sets GOTGCTL to GOTGCTL_AVALOVAL and call
> > > dwc2_force_mode() with parameter host=false, which causes inconsistent
> > > mode - The hardware is in peripheral mode while the kernel status is
> > > in host mode.
> > > 
> > > What we can do now is to call dwc2_drd_role_sw_set() to switch to
> > > device mode, and everything should work just fine now, even switching
> > > back to none(default) mode afterwards.
> > > 
> > > Fixes: e14acb876985 ("usb: dwc2: drd: add role-switch-default-node support")
> > > Signed-off-by: Ziyang Huang <hzyitc@outlook.com>
> > > ---
> > > Changes since v1
> > > - Use corrent name in Signed-off-by
> > Nope, still incorrect, please use your synopsys address.
> > 
> > thanks,
> > 
> > greg k-h
> 
> 
> Oh, I'm not a Synopsys employee but a free developer. This is my first time
> submitting a kernel patch, please excuse me. Thank you.

Ah, my fault, sorry, I saw the synopsys email on the to: line and
thought it was you.  Nevermind then, sorry, this will be reviewed once
6.3-rc1 is out.

thanks,

greg k-h
