Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2CD573E25B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 16:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjFZOnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 10:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjFZOnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 10:43:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5149FE7E;
        Mon, 26 Jun 2023 07:43:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C619760C34;
        Mon, 26 Jun 2023 14:43:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF16DC433C8;
        Mon, 26 Jun 2023 14:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687790618;
        bh=SdT5dYqk63aXHMWbRS0vGySaZDKAUnxuNnhGJkSrdRU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CNZ/WZPR3/AThVgJYgL+P+vh7mL1idZHkrilcVKqSlAXPEMwVDJQ8WOYpRIzcl0Ez
         7Hv2KnxATg+ts7PvYUrBs4dm0XHQo8VjbCnx8xi0pDz2/H3r1h0lplfaxc3DFDiZA5
         SrrJJMK2B6VbiVFrbH0hfyfSPJCs2iYa/LEmKoIk=
Date:   Mon, 26 Jun 2023 16:43:35 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 1/3] usb: typec: ucsi: call typec_set_mode on non-altmode
 partner change
Message-ID: <2023062628-pleading-hedging-2ceb@gregkh>
References: <20230614-topic-sm8550-upstream-type-c-audio-v1-0-15a92565146b@linaro.org>
 <20230614-topic-sm8550-upstream-type-c-audio-v1-1-15a92565146b@linaro.org>
 <ZJlIViwb9sfNrgjH@kuha.fi.intel.com>
 <c0bb8255-db4f-e93b-5593-0faa32e44410@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0bb8255-db4f-e93b-5593-0faa32e44410@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2023 at 03:23:11PM +0200, Neil Armstrong wrote:
> Hi,
> 
> On 26/06/2023 10:12, Heikki Krogerus wrote:
> > Hi Neil,
> > 
> > Sorry to keep you waiting.
> 
> No problem, thanks for reviewing my patches!
> 
> > 
> > On Wed, Jun 14, 2023 at 03:10:39PM +0200, Neil Armstrong wrote:
> > > Add support for calling typec_set_mode() for the DEBUG, AUDIO
> > > accessory modes.
> > > 
> > > Let's also call typec_set_mode() for USB as default and SAFE
> > > when partner is disconnected.
> > > 
> > > The USB state is only called when ALT mode is specifically
> > > not specified by the partner status flags in order
> > > to leave the altmode handlers setup the proper mode to
> > > switches, muxes and retimers.
> > > 
> > > Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> > > ---
> > >   drivers/usb/typec/ucsi/ucsi.c | 17 +++++++++++++++++
> > >   1 file changed, 17 insertions(+)
> > > 
> > > diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
> > > index 2b472ec01dc4..44f43cdea5c1 100644
> > > --- a/drivers/usb/typec/ucsi/ucsi.c
> > > +++ b/drivers/usb/typec/ucsi/ucsi.c
> > > @@ -809,6 +809,23 @@ static void ucsi_partner_change(struct ucsi_connector *con)
> > >   		break;
> > >   	}
> > > +	if (con->status.flags & UCSI_CONSTAT_CONNECTED) {
> > > +		switch (UCSI_CONSTAT_PARTNER_TYPE(con->status.flags)) {
> > > +		case UCSI_CONSTAT_PARTNER_TYPE_DEBUG:
> > > +			typec_set_mode(con->port, TYPEC_MODE_DEBUG);
> > > +			break;
> > > +		case UCSI_CONSTAT_PARTNER_TYPE_AUDIO:
> > > +			typec_set_mode(con->port, TYPEC_MODE_AUDIO);
> > > +			break;
> > > +		default:
> > > +			if (UCSI_CONSTAT_PARTNER_FLAGS(con->status.flags) ==
> > > +					UCSI_CONSTAT_PARTNER_FLAG_USB)
> > > +				typec_set_mode(con->port, TYPEC_STATE_USB);
> > > +		}
> > > +	} else {
> > > +		typec_set_mode(con->port, TYPEC_STATE_SAFE);
> > > +	}
> > 
> > Can you do that (set safe mode) in ucsi_unregister_partner() instead?
> 
> It seems greg already landed the patch into usb-next, but I can send a fix to
> move it to unregister

Yes please.
