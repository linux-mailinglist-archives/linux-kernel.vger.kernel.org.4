Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1797D6D16D6
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 07:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbjCaFgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 01:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCaFgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 01:36:09 -0400
Received: from pv50p00im-zteg10011401.me.com (pv50p00im-zteg10011401.me.com [17.58.6.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F21383C8
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 22:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1680240968;
        bh=sKGRoi8TeZzYLNcSuhfkFHZh2ruRuMHAHIi1NUfW1Nk=;
        h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To;
        b=YfLElU2Ymf/i7Ge+KOBYztYdfyRgC6f6dwW6rf7hWSEDNfS6mqDRuG1iwPe8a2w6O
         7h7bjp2x2BP+G/qRj5njtsX0LQtic/6fmaQf0zuqtwaGOex7CGIApAHDYPcuUbP49l
         kHrczWSLy6Z/ljWE0RVbimXTtgIKhPLTNGEu+NqTrqZrxEojQAtfcKhQjuwbozCP79
         lq34BaM83M8o44jP0bQZ4ShHrdxEy5dzluDfnQZn9ZE4oBgrijwiVPVE7Mapiceq6b
         4LAWSNeXudl09L66wPxGQHsuCbWY4nvspjV362rOJn65XXF9dlemhbeUPD9GdD37LP
         YhYr7hRwOzQkw==
Received: from localhost (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
        by pv50p00im-zteg10011401.me.com (Postfix) with ESMTPSA id 28B4FDC02DC;
        Fri, 31 Mar 2023 05:36:04 +0000 (UTC)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 31 Mar 2023 07:36:02 +0200
Message-Id: <CRKBPM6IOSJS.3RBNRJ8TSZX9U@iMac.local>
Cc:     "Maxime Ripard" <maxime@cerno.tech>,
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
To:     "Frank Oltmanns" <frank@oltmanns.dev>
X-Mailer: aerc 0.14.0
References: <20230320161636.24411-1-romanberanek@icloud.com>
 <87wn356ni4.fsf@oltmanns.dev> <20230327202045.ceeqqwjug4ktxtsf@penduick>
 <CRHKFX934UA0.1MCKCD8SJSPIE@iMac.local>
 <20230329195802.veybo3367zifw77n@penduick> <877cuyon5e.fsf@oltmanns.dev>
In-Reply-To: <877cuyon5e.fsf@oltmanns.dev>
X-Proofpoint-GUID: 1DKQc4fsLyT6il9NAOZ-x1dK75Ip_PH6
X-Proofpoint-ORIG-GUID: 1DKQc4fsLyT6il9NAOZ-x1dK75Ip_PH6
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.517,18.0.883,17.0.605.474.0000000_definitions?=
 =?UTF-8?Q?=3D2022-06-21=5F08:2022-06-21=5F01,2022-06-21=5F08,2020-01-23?=
 =?UTF-8?Q?=5F02_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 phishscore=0
 mlxlogscore=252 spamscore=0 clxscore=1015 suspectscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2303310043
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Frank,

On Thu Mar 30, 2023 at 6:45 AM CEST, Frank Oltmanns wrote:
> Roman, will you please submit a V2 of the patch I submitted then? Or do
> you want me to do it?

Yes, I'm already on it, only missing a cover letter.

Roman
