Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C590B6D7CB5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 14:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238043AbjDEMeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 08:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238044AbjDEMeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 08:34:17 -0400
Received: from ci74p00im-qukt09082302.me.com (ci74p00im-qukt09082302.me.com [17.57.156.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B4E14200
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 05:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1680698055;
        bh=F9sCyrOcH7GGRQDR6k6ODpcaztnsDl3q3KGT+/q2kkg=;
        h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To;
        b=NmXz7YV7suT/an18Bm3kXN9qYYtVjz3JC1Pi8c0rRjXIdgsdCD8vRXK/hBea1Z9Lu
         quEvBE0iU0J7QwF/85KbSweyw1r7Qx/Fuv5ZGD/UPBXkFcoTwgXTaAFXgvU3AbgwWT
         4rrXV9DwtnE0SYMeftz7cBij6tYLUzfFQmuJo3L8WnFBUdEg2cUESCcpJobOgAXrgB
         l+99wx4vkv/KGzD0Md7ar0jhyNvmMeMkXw7t/L1m+1fdGYUmrMcDUZ8Q4QVJ8DebbB
         wv7+thpKKDIfqJPeY/Hz7QrQaWpX6M/549f2GK66uUSQVnetRWhjLQyg6xutArhL6q
         xsAQInPOLXWUw==
Received: from localhost (ci77p00im-dlb-asmtp-mailmevip.me.com [17.57.156.26])
        by ci74p00im-qukt09082302.me.com (Postfix) with ESMTPSA id 54AAE2FC0494;
        Wed,  5 Apr 2023 12:34:13 +0000 (UTC)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 05 Apr 2023 14:34:11 +0200
Message-Id: <CROTQHUM88W0.2URPO95U5ZMS5@void.crly.cz>
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
In-Reply-To: <20230329195802.veybo3367zifw77n@penduick>
X-Proofpoint-ORIG-GUID: 8ldobzSC-nxTZzHvT0knq1iLnYTlBAI9
X-Proofpoint-GUID: 8ldobzSC-nxTZzHvT0knq1iLnYTlBAI9
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.138,18.0.572,17.11.62.513.0000000_definitions?=
 =?UTF-8?Q?=3D2020-02-14=5F11:2020-02-14=5F02,2020-02-14=5F11,2021-12-02?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=366 suspectscore=0
 adultscore=0 clxscore=1015 phishscore=0 malwarescore=0 spamscore=0
 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2304050113
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Maxime,

On Wed Mar 29, 2023 at 9:58 PM CEST, Maxime Ripard wrote:
> > In order to preserve semantic correctness however, I propose to preface
> > the change with a patch that renames sun4i_dotclock and tcon-pixel-cloc=
k
> > such that dot/pixel is replaced with d/data. What do you think?
>
> I don't think it's exposed to the userspace in any way so it makes sense =
to me
>

Here's a new series that includes those renames:
<https://lore.kernel.org/all/20230331110245.43527-1-me@crly.cz/>

It turns out however that the new dclk rates can't be set exactly as
requested without touching pll-video0*, tcon0 now therefore gets
reparented from pll-mipi to pll-video0-2x which, as it further turns
out, breaks DSI. While simply forbidding the video0-2x mux option seems
to me as the right way to go because there's not much use for it with
non-DSI interfaces either besides the opportunity to power pll-mipi
down, I'd like to run by you first.

Kind regards,
Roman

* As pll-mipi doesn't have CLK_SET_RATE_PARENT flag set, pll-video0
  retains its boot-time rate of 294 MHz set by sunxi-dw-hdmi driver
  in u-boot. Why 294 MHz (as opposed to the default rate of 297 MHz)?
  The driver actually asks for 297 MHz, clock_set_pll3 rounds it to
  294 MHz though because it limits itself to 6 MHz steps.
