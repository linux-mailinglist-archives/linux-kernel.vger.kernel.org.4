Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 392766C40FB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 04:25:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbjCVDZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 23:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjCVDZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 23:25:46 -0400
Received: from pv50p00im-zteg10021401.me.com (pv50p00im-zteg10021401.me.com [17.58.6.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C2BC8A66
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 20:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1679455543;
        bh=d3CewEP7Fm5d2yjoCy7LEmwv7xA2WuRpJAgeMc7rORA=;
        h=Mime-Version:Content-Type:Date:Subject:From:To:Message-Id;
        b=nELPWmPqlsYHoj5Fg/JvGkvnx3wjmIUX/yugpVBKJ1PJAwfZ6JpLI99lFdO5EmGN4
         GUB0l344L+9VbtqsVgtlTl5sKo6ZmBTbc+5mZIVo8Alf+7/qD/S4yhFBfwDCpeSCRL
         9Md3x9/y38+/H50Dw2bAkIFWqZvshc5HfN3do/YjYfc0oVoMF2K/UA58Y9zWhEvaof
         AyOwmsG4wooqJe/JqV6TFTnqbHjrliyCuKeO520gTSrfGPtTj8Jzk6Cz0k+Tm6gqLB
         IMFifi1uiKndfRVYdY2ZO5RVFz9pcJUpbDzA5y5AZTBjl1LWxiapElMfGTSmz9SpPi
         kSK2fICVuFfFA==
Received: from localhost (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
        by pv50p00im-zteg10021401.me.com (Postfix) with ESMTPSA id 322128E02AF;
        Wed, 22 Mar 2023 03:25:39 +0000 (UTC)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 22 Mar 2023 04:25:37 +0100
Cc:     <jagan@amarulasolutions.com>, <michael@amarulasolutions.com>,
        "Chen-Yu Tsai" <wens@csie.org>, "David Airlie" <airlied@gmail.com>,
        "Daniel Vetter" <daniel@ffwll.ch>,
        "Jernej Skrabec" <jernej.skrabec@gmail.com>,
        "Samuel Holland" <samuel@sholland.org>,
        "open list:DRM DRIVERS FOR ALLWINNER A10" 
        <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Allwinner sunXi SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Allwinner sunXi SoC support" 
        <linux-sunxi@lists.linux.dev>,
        "open list" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] drm/sun4i: tcon: Fix setting PLL rate when using
 DSI
From:   "Roman Beranek" <romanberanek@icloud.com>
To:     "Frank Oltmanns" <frank@oltmanns.dev>,
        "Maxime Ripard" <maxime@cerno.tech>
Message-Id: <CRCLAFZ02N4O.1WVSKC1TFLUOO@iMac.local>
X-Mailer: aerc 0.14.0
References: <20230319160704.9858-1-frank@oltmanns.dev>
 <20230319160704.9858-2-frank@oltmanns.dev>
 <20230321145739.jlpbzplsc27dlh7v@houat> <87a605hmo5.fsf@oltmanns.dev>
In-Reply-To: <87a605hmo5.fsf@oltmanns.dev>
X-Proofpoint-GUID: HqhfhkMmz8MluUsjSYUoJn8zi8ifE6wZ
X-Proofpoint-ORIG-GUID: HqhfhkMmz8MluUsjSYUoJn8zi8ifE6wZ
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.517,18.0.883,17.0.605.474.0000000_definitions?=
 =?UTF-8?Q?=3D2022-06-21=5F08:2022-06-21=5F01,2022-06-21=5F08,2020-01-23?=
 =?UTF-8?Q?=5F02_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 spamscore=0
 bulkscore=0 clxscore=1011 mlxlogscore=231 malwarescore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2303220023
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue Mar 21, 2023 at 8:55 PM CET, Frank Oltmanns wrote:
> My apologies, I wasn=E2=80=99t patient enough.

Frank, there's no need to apologize, in my judgement. You weren't
impatient, we simply happened to run into a coordination problem for
which, I think, neither of us was particularly to blamew. Take it easy
:)

Roman
