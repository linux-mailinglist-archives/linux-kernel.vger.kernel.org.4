Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47EDB70E3ED
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 19:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237772AbjEWROS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 13:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238038AbjEWRON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 13:14:13 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30B01E45
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 10:14:05 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id BC49E1C000E;
        Tue, 23 May 2023 17:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1684862044;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F772pcpn5g0zLkZKffeMc8TtjgX7auyHWBGcgytVmMQ=;
        b=WxON7726VMMGBNI478t6jhilp3G1kYu/2eRVpOURXEz2EpPTlURA6p9GwMcLignn/wKL2A
        4TM8veizlfn0Iq/UK38WVXUzlR0oR1+XtvTtRKzH5zIIDRO17cWWyNHA4gZH/1gU0W5WQ0
        aT0A7xCxrNm9miSowSmG3qB+7f9Q5bsv7aGzdb0GLpeUCfz1kWc1OSZZqPmb+Il4CrMgA6
        WaoB8Pe9QMgxsPGpjW9wAqhSTTU5OWEvboyj+vfnevTH60/OU3mTTUX9SIeSmWdShIy93S
        8k6t4GpKtVeOj8pL3cBZ1d5OU1OAyhR/wSjV1zM56Zb1Ugl7HXpMi1X0dSBBnA==
Date:   Tue, 23 May 2023 19:14:02 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Robert Marko <robert.marko@sartura.hr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] nvmem: core: Expose cells through sysfs
Message-ID: <20230523191402.0728443a@xps-13>
In-Reply-To: <2023052351-doze-purist-9780@gregkh>
References: <20230523100239.307574-1-miquel.raynal@bootlin.com>
        <20230523100239.307574-3-miquel.raynal@bootlin.com>
        <2023052351-doze-purist-9780@gregkh>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

gregkh@linuxfoundation.org wrote on Tue, 23 May 2023 17:58:51 +0100:

> On Tue, May 23, 2023 at 12:02:39PM +0200, Miquel Raynal wrote:
> > +/* Cell attributes will be dynamically allocated */
> > +static struct attribute_group nvmem_cells_group =3D {
> > +	.name		=3D "cells",
> > +};
> > +
> >  static const struct attribute_group *nvmem_dev_groups[] =3D {
> >  	&nvmem_bin_group,
> > +	NULL, /* Reserved for exposing cells, if any */ =20
>=20
> Please don't do this, but rather use the is_visible callback to
> determine if it should be shown or not.

Ah, excellent point. Don't know why I overlooked that member.

Thanks,
Miqu=C3=A8l
