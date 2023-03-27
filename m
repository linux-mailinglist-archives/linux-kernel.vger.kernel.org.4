Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E53AA6CB2B3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 01:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231819AbjC0X5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 19:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbjC0X5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 19:57:11 -0400
X-Greylist: delayed 512 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 27 Mar 2023 16:57:10 PDT
Received: from ci74p00im-qukt09090301.me.com (ci74p00im-qukt09090301.me.com [17.57.156.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D1B1724
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 16:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1679960917;
        bh=Q+4Mb10klAZfMB/A5WCIqgvbYnDs5kzDVHJcVRl+RCs=;
        h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To;
        b=RSTB7ckd1aOjjLJRWit0Cy7vETE2wbok67SWzCI9qyxcISWS33pRhXYDDjf41ykry
         RO/dRmauj3/cvlsaSfmkSgZa1S2+5m8KV1Rs776lzvya6PAnJ1X12n8IRYXbJNe/us
         MGH5On5zf1f0lYc0KfFoq7ghe9IEPOoZBAN8qaH+77dtZdoM73iURM3md6ba0DxEKh
         dRlqVdMUjyNV6dHsKuNglKrXUY7EVnCdeCRiC/0DfOnIDdX8FwdyIoU2hiE+QUYGPd
         3K/jdQHO35TkLQGUcsEHA2uzy2+7NZSpfX+FBff8seHaEIGQ3dFz0Cp8EAHDYh085A
         Xyv/n5Tz4MYPQ==
Received: from localhost (ci77p00im-dlb-asmtp-mailmevip.me.com [17.57.156.26])
        by ci74p00im-qukt09090301.me.com (Postfix) with ESMTPSA id 323E011202B4;
        Mon, 27 Mar 2023 23:48:34 +0000 (UTC)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 28 Mar 2023 01:48:33 +0200
Message-Id: <CRHKFX934UA0.1MCKCD8SJSPIE@iMac.local>
Subject: Re: [PATCH] drm/sun4i: uncouple DSI dotclock divider from
 TCON0_DCLK_REG
From:   "Roman Beranek" <romanberanek@icloud.com>
To:     "Maxime Ripard" <maxime@cerno.tech>,
        "Frank Oltmanns" <frank@oltmanns.dev>
Cc:     "Chen-Yu Tsai" <wens@csie.org>, "David Airlie" <airlied@gmail.com>,
        "Daniel Vetter" <daniel@ffwll.ch>,
        "Jernej Skrabec" <jernej.skrabec@gmail.com>,
        "Samuel Holland" <samuel@sholland.org>,
        <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-sunxi@lists.linux.dev>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.14.0
References: <20230320161636.24411-1-romanberanek@icloud.com>
 <87wn356ni4.fsf@oltmanns.dev> <20230327202045.ceeqqwjug4ktxtsf@penduick>
In-Reply-To: <20230327202045.ceeqqwjug4ktxtsf@penduick>
X-Proofpoint-GUID: p8h-miPlykEtip94gyjHAwmjbUceibHK
X-Proofpoint-ORIG-GUID: p8h-miPlykEtip94gyjHAwmjbUceibHK
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.425,18.0.572,17.0.605.474.0000000_definitions?=
 =?UTF-8?Q?=3D2022-01-11=5F01:2022-01-11=5F01,2020-02-14=5F11,2020-01-23?=
 =?UTF-8?Q?=5F02_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=272 phishscore=0
 suspectscore=0 mlxscore=0 adultscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2303270187
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Mar 27, 2023 at 10:20 PM CEST, Maxime Ripard wrote:
>
> On Sat, Mar 25, 2023 at 12:40:04PM +0100, Frank Oltmanns wrote:
> > Claiming to set the divider to a different value (bpp / lanes) than wha=
t we=E2=80=99re actually using in
> > the end (SUN6I_DSIO_TCON_DIV) is somehow bugging me. I feel like the pr=
oposal that I submitted is
> > more direct: <https://lore.kernel.org/all/20230319160704.9858-2-frank@o=
ltmanns.dev/>
>
> Yeah, this patch looks better to me too: it's simpler, more straightforwa=
rd. If Roman can confirm it
> works with his testing, I'll be happy to merge it.
>

So I've just found out that my understanding of what sun4i_dotclock is
was wrong the whole time. I treated it as a virtual clock representing
the true CRTC pixel clock and only coincidentally also matching what
A64 Reference Manual labels as TCON0 data clock (a coincidence to which
DSI is an exception).

Now that I finally see dotclock as 'what could dclk be an abbreviation
to', I to agree that it's not only straightforward but also correct to
keep the divider at 4 and adjust the rate as is done it the patch Frank
submitted.

In order to preserve semantic correctness however, I propose to preface
the change with a patch that renames sun4i_dotclock and tcon-pixel-clock
such that dot/pixel is replaced with d/data. What do you think?

Roman
