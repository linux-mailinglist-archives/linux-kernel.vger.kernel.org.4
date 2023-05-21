Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36C5E70AE53
	for <lists+linux-kernel@lfdr.de>; Sun, 21 May 2023 16:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbjEUO2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 10:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbjEUO1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 10:27:54 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F12109
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 07:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1684679231; i=efault@gmx.de;
        bh=D64N/U99IAOrDBrnnVLYscTrCB4BX8s4xJcSp7nf+XM=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=qrjIkrAne/oi11GqsPW57L4F7An2oOJG0VQTrCG3iDSWExxUFO8wZZ8LuXcCwq1hs
         xmQBKnWbra8K1bzhb3lW+oGCgAMCydyoyRAGvqLyl1D6Q5PTZxzzgt+7J/SSsV7E3p
         Mv6QNGK2iKRmeH6cIfPekT7rsTPnFIvLIsWEvXe/czNEhRYituEm1kVusvuYa+1rgq
         WN+jWwKtN2YehSc7eNlXEFXiqVvtzCE09+SkGrDNfQ+pg+zLE7SCwUs+F58vtGLMYP
         Z+B6xUH2ZqTRDvEcocPUp/dXsweeGdPYzka55XysrFfudbQ1K0JyXzvhyoHHrV9ZYP
         W6vr10FM41mig==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([185.191.219.131]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M9FnZ-1q5zDM0LW3-006PUg; Sun, 21
 May 2023 16:27:11 +0200
Message-ID: <28727b435c143f15feddffb4c29095fee2500dff.camel@gmx.de>
Subject: Re: r8169: disable ASPM during NAPI poll locking changes --> BUG:
 Invalid wait context --> PREEMPT_RT pain
From:   Mike Galbraith <efault@gmx.de>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date:   Sun, 21 May 2023 16:27:10 +0200
In-Reply-To: <e55be0ae115ad6494ebb48fecd03e5c2fe528230.camel@gmx.de>
References: <e55be0ae115ad6494ebb48fecd03e5c2fe528230.camel@gmx.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:g1dbrHI6vD+b5Xgqs9rehFTSEsCddxnM64RmcDEVQB1so24juyj
 2Gw+hCBEylt+6wBdAp2qFTdtfxXaiXYCEfw/qFLTJvsUhgXjXLjJuM1Wcg8+YdjkN5HAQN2
 dx1Oluoik8V9uo2tzFTPM54BrzvGKRr5h7ze9+pQl8R8qXjd9esAps0oDtUZ+Sg56tEZFlr
 DlLL4AZTtOs864ATr/4Tg==
UI-OutboundReport: notjunk:1;M01:P0:mYp4pNuJAGE=;c8CCNgrFYRweqvccLNVb8A4iDFz
 mbiz5B+73f216Rb5Z535PXJfdHgxCGMmwMaNyXojBEL84Q2Jw1TjZpTuGt8XxeBJshOsByvlG
 VsAc2qwPOmrKAEjzq24kLWBATe6SbiLIn16KRDs5gwmcSsOkdVq/UKixXzZQWpUEIMC08+4LU
 GDM3Amhs/Rb4BN84ArrOD2Uc2UMqo4HsM2osR95mRtHbYhzWMOCcI07c9oryNEGurr3gA0wbJ
 K2tzBt54Y52A8jd8k6Lt+KTSSSzcvklpMEE7H5/YX6xHtP8hBxMty4vRqCM5MQlaZRLDh3YDd
 /w5XBJFroCcs3bCh69lqEUWdFz6Mju7EK3MVfuE61dVnsXSy8wxRruojXSOiBgCfcJZkrU/Ma
 20Nq2E/ALAGFNbWDgR2Qgp4/A+CP3GUOZR4eTDeWBT01KUti0sxXeyheXu2/HZGSooxIZ01FD
 qiMQPaCyqESjreu+qGCyf1MLLnvagKfdBWyE5limZVDuG0JzWlc6hl7T55pqOc/y22f0fNo3X
 V+GEqSVU3WldX12ko8PuQ63g4XtvnNhaQ1bQ6VQ4w8WHno8TerHPT+vkLKnaj5mXeIaePNbVs
 0xSF1OsBTE3u0h8/HEWVDT31bRTVnNuOWR0Y9zL4IXGHARZERO32+0yd8mLADx7xwak+XVTFz
 YLGu+9gtwhxBocPm57zILxkLS8iq0jHdsaWyna5ywNhxdIGaUOKGYat93DjlUq9ubhcwsWXnN
 VywmKtHqYuf/t9neWebclsAV4p2h4rGmYpV9DU6FG18MvPUQAYWTjN8afj0odTkR+x0wqwSU+
 4hxdhDEChbpU6QyLaLn/yaXfSEJ9Be8cHNPqvWHeXOnazgTRLrvV6BHdLiGJ1zUbMsexf7PAT
 szY/ss8SC7cAZRaT44Y3YHYO/jqNUmG07WffjdXQ7/iCi9QbyNzGrPEAbxthH5K9vLKyKEi40
 9pdGYQ==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2023-05-21 at 08:03 +0200, Mike Galbraith wrote:
> Greetings,
>
> The locks added to prep for $subject induce invalid context moaning due
> to not being raw locks, but if I do that, the hold time does very bad
> things to RT.

The locks aren't really 160us horrible. The GPU was enabled (oops),
nouveau then makes box horrible for RT (and graphics:).  With GPU
turned back off, the largest trace I saw was 77us, which jibes pretty
well with new max of low to mid 50s without ftrace running, or up a tad
over 20us for this now pretty old commodity i7 desktop box.

	-Mike
