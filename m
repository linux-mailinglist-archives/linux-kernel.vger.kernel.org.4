Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F0A56C3C41
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 21:53:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbjCUUxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 16:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbjCUUxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 16:53:18 -0400
Received: from pv50p00im-ztdg10011201.me.com (pv50p00im-ztdg10011201.me.com [17.58.6.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4A2F241EE
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 13:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1679431997;
        bh=0ZnuQUjrwZDWrnJLwNfU9ZEvt169Mzw+VbAzP/NbgBA=;
        h=Mime-Version:Content-Type:Date:To:Subject:From:Message-Id;
        b=L/r0KNA1frJtVd/bGT2GtLcOQDbTZmntf0m1J/vdow+GrJN5B3+b9slmsY3G/MhdZ
         GN3xVTbL7xBbbE90iNWfH9DzwnYlmjCAqOuIbW9EwkTZ+hudj4zLiOfFXusUpJ4k9I
         oNVJU7XZOaA1aumqScvOjHqrTobrK8tELZtc1dG7GHzmTMqECdYsEo/s3qtOWaeM6J
         LtgyPTcSuM69O5KB1rjp/5VWd60FFjSolKptr+MbbQk6W5mRtVe5IwIP1212C9qSAt
         FBtzsdSpevFsua7brlyZKp2cFpd7ADBEd6BZ0c6V4jhvLCRTEZdtKsTEfrAvTaPDtT
         gimQolH/ZrmMQ==
Received: from localhost (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
        by pv50p00im-ztdg10011201.me.com (Postfix) with ESMTPSA id 4372C680B6E;
        Tue, 21 Mar 2023 20:53:14 +0000 (UTC)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 21 Mar 2023 21:53:11 +0100
To:     "Maxime Ripard" <maxime@cerno.tech>
Cc:     "Chen-Yu Tsai" <wens@csie.org>, "David Airlie" <airlied@gmail.com>,
        "Daniel Vetter" <daniel@ffwll.ch>,
        "Jernej Skrabec" <jernej.skrabec@gmail.com>,
        "Samuel Holland" <samuel@sholland.org>,
        <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-sunxi@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/sun4i: uncouple DSI dotclock divider from
 TCON0_DCLK_REG
From:   "Roman Beranek" <romanberanek@icloud.com>
Message-Id: <CRCCWA4HQQX4.YATGMBYCEH72@iMac.local>
X-Mailer: aerc 0.14.0
References: <20230320161636.24411-1-romanberanek@icloud.com>
 <20230321145646.w6kr7ddurfxpg5rt@houat>
In-Reply-To: <20230321145646.w6kr7ddurfxpg5rt@houat>
X-Proofpoint-GUID: c612MYQytYPmYtx84RnEOuXcSzSfwBD_
X-Proofpoint-ORIG-GUID: c612MYQytYPmYtx84RnEOuXcSzSfwBD_
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.517,18.0.883,17.11.64.514.0000000_definitions?=
 =?UTF-8?Q?=3D2022-06-21=5F08:2022-06-21=5F01,2022-06-21=5F08,2022-02-23?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=394 mlxscore=0
 suspectscore=0 clxscore=1015 malwarescore=0 bulkscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2303210165
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue Mar 21, 2023 at 5:50 PM CET, Roman Beranek wrote:

> > Also, how was it tested/confirmed?
>
> By counting Vblank interrupts (GIC 118).

Sorry, that was perhaps too abbreviated. To test this change, I set up
an A64 board running kmscube on DSI-1 and verified that the rate of
Vblank IRQs tracked with a video mode set on DSI-1, once with a 2-lane
panel and once with a 4-lane panel.

Roman
