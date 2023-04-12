Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0CD6DE8DE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 03:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbjDLB25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 21:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjDLB2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 21:28:55 -0400
X-Greylist: delayed 348 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 11 Apr 2023 18:28:54 PDT
Received: from st43p00im-ztbu10073601.me.com (st43p00im-ztbu10073601.me.com [17.58.63.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DEDB3594
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 18:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1681262584;
        bh=5lYEMcGNaDjCakbfqg3dZSHw5YYijll0DV6pUU4IwUQ=;
        h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To;
        b=atT1omM/juMY7qst5KCgYsE6VaDU9lY5T+rr6QEqEViHM+OS2qQL8LwuyIe7a9Mpm
         1UBL2YqmM4xmqD/xSJfIzVz7PmkjxvSOBcEsoIE/UQkOFAcd/LfEee3O/9im9b1dnl
         4UracAxZZ8NNMIjFcgjL6IoYGD1Q9vQtqtsVPYRimlHooPEqc/HvIYMT9XTh+FkCQ1
         YyATazRM8rb1SN7g03dIXN1bdogviM+cFb/8W4WABoZjnaX1BKLUyQCUd5L2S8SpNI
         OAXQM8UUStujT1JHMzhmsklmNMW8eDRshhkwvMMnRNzZn1daAqltxZsq/9I/zscDLW
         l/PqMUceJJ44Q==
Received: from localhost (st43p00im-dlb-asmtp-mailmevip.me.com [17.42.251.41])
        by st43p00im-ztbu10073601.me.com (Postfix) with ESMTPSA id 923FD180C17;
        Wed, 12 Apr 2023 01:23:01 +0000 (UTC)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 12 Apr 2023 03:22:59 +0200
Message-Id: <CRUDUEL17ER4.1R8WRNNB5CJ35@void.crly.cz>
Cc:     "Frank Oltmanns" <frank@oltmanns.dev>,
        "Chen-Yu Tsai" <wens@csie.org>, "David Airlie" <airlied@gmail.com>,
        "Daniel Vetter" <daniel@ffwll.ch>,
        "Samuel Holland" <samuel@sholland.org>,
        <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-sunxi@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <icenowy@aosc.io>
Subject: Re: [PATCH] drm/sun4i: uncouple DSI dotclock divider from
 TCON0_DCLK_REG
From:   "Roman Beranek" <romanberanek@icloud.com>
To:     =?utf-8?q?Jernej_=C5=A0krabec?= <jernej.skrabec@gmail.com>,
        "Maxime Ripard" <maxime@cerno.tech>
X-Mailer: aerc 0.14.0
References: <20230320161636.24411-1-romanberanek@icloud.com>
 <20230329195802.veybo3367zifw77n@penduick>
 <CROTQHUM88W0.2URPO95U5ZMS5@void.crly.cz>
 <2219295.iZASKD2KPV@jernej-laptop>
In-Reply-To: <2219295.iZASKD2KPV@jernej-laptop>
X-Proofpoint-GUID: g1DkOftfS7myPiNQXtcxfcmsJmiyUcmX
X-Proofpoint-ORIG-GUID: g1DkOftfS7myPiNQXtcxfcmsJmiyUcmX
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.138,18.0.883,17.0.605.474.0000000_definitions?=
 =?UTF-8?Q?=3D2022-06-21=5F08:2020-02-14=5F02,2022-06-21=5F08,2020-01-23?=
 =?UTF-8?Q?=5F02_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=24 bulkscore=0 mlxlogscore=51
 malwarescore=0 adultscore=0 clxscore=1011 spamscore=24 mlxscore=24
 suspectscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2304120009
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat Apr 8, 2023 at 9:07 AM CEST, Jernej =C5=A0krabec wrote:
> Dne sreda, 05. april 2023 ob 14:34:11 CEST je Roman Beranek napisal(a):
> > While simply forbidding the video0-2x mux option seems
> > to me as the right way to go because there's not much use for it with
> > non-DSI interfaces either besides the opportunity to power pll-mipi
> > down, I'd like to run by you first.
>
> It's been a long time since I looked at A64 HDMI clocks, but IIRC, pll-vi=
deo0=20
> is the only useful source for HDMI PHY (as opposed to HDMI controller.)
> So question remains how to properly support both displays at the same tim=
e.
>

Correct.

> Have you ever tried to make HDMI and DSI work at the same time? This is o=
ne of=20
> issues of the PinePhone IIUC.
>

Yes, I have. Prusa3D's SL1 printer, on which I previously worked on,
uses both outputs simultaneously. I had encountered the same reparenting
problem back then but since I hadn't been able to identify it,
I resorted to fiddling with the DSI pixelclock until it worked.=20

DSI & HDMI co-existence is yet another reasoni though for forbidding
the pll-video-2x parent. megi's kernel includes Mr. Zheng's commit which
does the same.

<https://github.com/megous/linux/commit/7374d57>

Best wishes
Roman Beranek
