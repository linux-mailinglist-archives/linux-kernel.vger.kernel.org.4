Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E21BA6DEC74
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 09:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjDLHVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 03:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjDLHVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 03:21:42 -0400
X-Greylist: delayed 397 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 12 Apr 2023 00:21:41 PDT
Received: from qs51p00im-qukt01071902.me.com (qs51p00im-qukt01071902.me.com [17.57.155.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A682B30CA
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 00:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1681283703;
        bh=FuHa2VctxY8ljAUtLpIjGV5QmLAE4POaPbEVmwgcH2o=;
        h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To;
        b=qY08AyFEmbBbMRmPeik5yhhAU3lwphghNn24tlEZ05vOVrFWtZSNDXmUtGuHh8n5N
         vFBfCSUOMVpXxOSzg00fpuzPLEkUrVvbznMG5ErYZEbnDeeVkW/qbjlOxr2oX2Bomy
         v5KC7nZMd/+z/r5cZ1ilzsAebgJn1m7/DiOQebOT8F4ZVvCSXRwH8NdCfGRPrEJ3oB
         IW+Pc4wC30B0LWGprb9e4gJMCsOTJFQN0WuKuHYUD5U/L2E8ZltqoR4xXpdes5Ct1i
         WjQc3/gtJcsSykcDtr8ljRgmxlFNdy87z4EydHZshcht2f70xYrxVMuOJsMe5ICQGc
         ww/8hNCOGbCqQ==
Received: from localhost (qs51p00im-dlb-asmtp-mailmevip.me.com [17.57.155.28])
        by qs51p00im-qukt01071902.me.com (Postfix) with ESMTPSA id 4C7375EC011E;
        Wed, 12 Apr 2023 07:15:01 +0000 (UTC)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 12 Apr 2023 09:14:59 +0200
Message-Id: <CRULBWW4VCWG.3KS7HX7P1G4P6@void.crly.cz>
Cc:     "Frank Oltmanns" <frank@oltmanns.dev>,
        "Chen-Yu Tsai" <wens@csie.org>, "David Airlie" <airlied@gmail.com>,
        "Daniel Vetter" <daniel@ffwll.ch>,
        "Jernej Skrabec" <jernej.skrabec@gmail.com>,
        "Samuel Holland" <samuel@sholland.org>,
        <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-sunxi@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/sun4i: uncouple DSI dotclock divider from
 TCON0_DCLK_REG
From:   "Roman Beranek" <romanberanek@icloud.com>
To:     "Maxime Ripard" <maxime@cerno.tech>
X-Mailer: aerc 0.14.0
References: <20230320161636.24411-1-romanberanek@icloud.com>
 <87wn356ni4.fsf@oltmanns.dev> <20230327202045.ceeqqwjug4ktxtsf@penduick>
 <CRHKFX934UA0.1MCKCD8SJSPIE@iMac.local>
 <20230329195802.veybo3367zifw77n@penduick>
 <CROTQHUM88W0.2URPO95U5ZMS5@void.crly.cz>
 <pu3vdz4gnkwgn4thg6tndbnvfroevpnq75bqbfv7yyrh4gkv63@xxl3dsjf2ih3>
In-Reply-To: <pu3vdz4gnkwgn4thg6tndbnvfroevpnq75bqbfv7yyrh4gkv63@xxl3dsjf2ih3>
X-Proofpoint-GUID: s-iO_fMJ2HHG6apJavxJxsPYR0SgWQJt
X-Proofpoint-ORIG-GUID: s-iO_fMJ2HHG6apJavxJxsPYR0SgWQJt
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.425,18.0.572,17.11.62.513.0000000_definitions?=
 =?UTF-8?Q?=3D2022-01-11=5F01:2022-01-11=5F01,2020-02-14=5F11,2021-12-02?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=487 phishscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1015
 adultscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2304120065
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed Apr 5, 2023 at 5:03 PM CEST, Maxime Ripard wrote:
> On Wed, Apr 05, 2023 at 02:34:11PM +0200, Roman Beranek wrote:
> > It turns out however that the new dclk rates can't be set exactly as
> > requested without touching pll-video0*, tcon0 now therefore gets
> > reparented from pll-mipi to pll-video0-2x which, as it further turns
> > out, breaks DSI. While simply forbidding the video0-2x mux option seems
> > to me as the right way to go because there's not much use for it with
> > non-DSI interfaces either besides the opportunity to power pll-mipi
> > down, I'd like to run by you first.
>
> Sounds reasonable

Okay, I'm unsure of how to denote that in the code however. Should I
just comment the parent out of the table and put an explanation in
a comment nearby? Or just erase it? I couldn't find an applicable
precedent.

> > * As pll-mipi doesn't have CLK_SET_RATE_PARENT flag set, pll-video0
> >   retains its boot-time rate of 294 MHz set by sunxi-dw-hdmi driver
> >   in u-boot. Why 294 MHz (as opposed to the default rate of 297 MHz)?
> >   The driver actually asks for 297 MHz, clock_set_pll3 rounds it to
> >   294 MHz though because it limits itself to 6 MHz steps.
>
> We could also address that though

Should I include it in v2 of the series, or leave it for later?

Thanks,
Roman
