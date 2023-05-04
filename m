Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A31E26F6C3A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 14:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbjEDMpn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 08:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbjEDMpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 08:45:41 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBDE76199;
        Thu,  4 May 2023 05:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=14sjKY8h8FWkGXw0wntZ015vh0LfS2hxWosSTp8tzLU=; b=mUJiJWJRnjt37+pnHmf80+vLPa
        LTmHDz9mwSOwtSnTc4j8e8JgtGrZz5XXOIYOpuocZKx65fWcStKlwHC4Y5Ber/9PjieGsaCph8eFh
        YjCWuaPgjD8iJWZ1zUU9AyzAe3hopakTtyQwYfgbFmNZQxUBu4Z/bLgqv5H++JpCtyT+1othWxq8+
        y3M7uuBa8MkAwxAlj4EYvTLErrYNUPTHJB80QgBuU1eDUHcD4CB2g4svUTkzfmXK8zLK56VgBqnp4
        kPvLhcrKgfVo1CPwVcJl6SFZSExnoH/yNX1LJjKYzjabB23KydEZolNi3/3EkETqXRVo+JrIuQ75o
        iiiTuh2A==;
Received: from p200300ccff0d59001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff0d:5900:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1puYKp-0000l9-2J; Thu, 04 May 2023 14:45:23 +0200
Date:   Thu, 4 May 2023 14:45:21 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Tony Lindgren <tony@atomide.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [BISECTED REGRESSION] OMAP1 GPIO breakage
Message-ID: <20230504144521.1b3a3574@aktux>
In-Reply-To: <CACRpkdY9ShRATHa776KyzeArmQdKxdwGxJC11YnmhWiCdSGzEA@mail.gmail.com>
References: <20230425173241.GF444508@darkstar.musicnaut.iki.fi>
        <20230425201117.457f224c@aktux>
        <20230425183857.GG444508@darkstar.musicnaut.iki.fi>
        <20230425212040.5a4d5b09@aktux>
        <20230425193637.GH444508@darkstar.musicnaut.iki.fi>
        <20230425215848.247a936a@aktux>
        <20230426071910.GE14287@atomide.com>
        <20230504055156.GO14287@atomide.com>
        <CACRpkdY9ShRATHa776KyzeArmQdKxdwGxJC11YnmhWiCdSGzEA@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.24; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -1.0 (-)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 4 May 2023 14:13:32 +0200
Linus Walleij <linus.walleij@linaro.org> wrote:

> On Thu, May 4, 2023 at 7:52=E2=80=AFAM Tony Lindgren <tony@atomide.com> w=
rote:
> > * Tony Lindgren <tony@atomide.com> [230426 07:20]: =20
> > > Seems that we should just revert this patch for now and try again aft=
er
> > > the issues have been fixed. =20
> >
> > Looking at the proposed fixes being posted seems like they are quite
> > intrusive.. How about we partially revert this patch so omap1 still
> > uses static assigment of gpios? =20
>=20
> I think Andreas patch (commit 92bf78b33b0b463b00c6b0203b49aea845daecc8)
> kind of describes the problem with that: the probe order is now unpredict=
able,
> so if we revert the patch then that problem returns, but I don't know how
> serious that problem is.
>=20
well, I think we can even fully revert 92bf78b33b0b463b00c6b0203b49aea845da=
ecc8
after my patch

gpiolib: fix allocation of mixed dynamic/static GPIOs

is in as a short time solution. That should only leave unpredictable
numbers of multiple dynamic gpio controllers.

Regards,
Andrea
