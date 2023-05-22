Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B16370C40E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 19:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232779AbjEVRMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 13:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231889AbjEVRMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 13:12:22 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F90B3
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 10:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1684775528; i=efault@gmx.de;
        bh=Zte54EARQKsZTrx2rqYIeuLYcV3HtQOjx8KqSA04kH0=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=gqg3e+9J6qYfFbGGG8fjNyYDxfK3MMlgL7PUgXgFjV56irr2hU3wvysKgO5s/Ym2C
         b5kH2JvJBzkCHghrwFP8KzwJruA534s/RHaKq//HXcJN9C+HjN+CqDsR4shkZhF/4F
         ORqtgUb/zkQrdKOi0WOdB3C/oUWYpTC0QfnG/CO3VDPNMqdOVcRNs8AQos7KiGAV+C
         LRqERBNBkJpeN6amFx1+hj68ptQIGyX8fdyU4UY1meIQzFahvhL879gxyqzvSGmBP7
         4HZE/m7btjhzyZ9fRXyATLoIS8W6wB6vN8+Vl1xMWYSkh9KpIQhxhkRhkgcJ+BA5CG
         8YoU36FokdWCA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([185.191.219.131]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mwfac-1qKLis2mXi-00yDAd; Mon, 22
 May 2023 19:12:08 +0200
Message-ID: <b142363b8f87eaa73ee815fcb5b98a6bd5040001.camel@gmx.de>
Subject: Re: r8169: disable ASPM during NAPI poll locking changes --> BUG:
 Invalid wait context --> PREEMPT_RT pain
From:   Mike Galbraith <efault@gmx.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Date:   Mon, 22 May 2023 19:12:08 +0200
In-Reply-To: <1bea6e585a1be8ab89b9a3db2fb5c58431378f50.camel@gmx.de>
References: <e55be0ae115ad6494ebb48fecd03e5c2fe528230.camel@gmx.de>
         <28727b435c143f15feddffb4c29095fee2500dff.camel@gmx.de>
         <20230522080604.MgUGcyeU@linutronix.de>
         <d7fa9ffe0e6cd546b8ff3826379c2cf78e5342b6.camel@gmx.de>
         <20230522134315.oBK0Ll7f@linutronix.de>
         <1bea6e585a1be8ab89b9a3db2fb5c58431378f50.camel@gmx.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lK3WkCZ6sXyhZIRlUxBPU+9E2tS/rIP0pRJO1zLfFjwZ36UX8Pv
 zDrvOoH3vjZ5W14gzIytLLsZpx9wszkPAu6NVzD/bs86n/ffflyPVyTJOmMoGHXBOXbz0sb
 boNObMR+conu9lrchnNyB/yPDeyTOTPKk5j5/PYotrmQi16mJbd73IYzxdBWrY9zm9ztZOt
 7bogIgcuszh54RZ91cq6A==
UI-OutboundReport: notjunk:1;M01:P0:o++6JQvYfR0=;DluzbXj5Dq5Hx6r6GFw3PCKbYQj
 LqywBJ/VAFuEwibvM/NBIdRS0dVkxMzqXEGzvywNyJ+Xpyf2sEi7WkutIPuu4bSKPdIvZsHN+
 8GEMEeJtPZoizRmutV5AiSRorRXVSdYINf6Qx9ZhBLhtyqnpZU+LRqpVCOfSPJH9+twx1rLzf
 EhgZY2kws693nWHZ9i6G26fpUYhOg1AU16fhPzm+M5L6NxFVPKxTxb7lYsWA34NLpmflSOwBI
 kN5eDDJ6hZwcXZPxq0akHIofEdmQLIjxiOnb+9YG66SilUatmZhYqEBDo5HnULswW0JdWjMsy
 lL85PEYobEUr+36kyCe8lTGkiFOoRY9j9y19c1qhDxPlypKSkw8IiU8LfsLFrnHMkKAdIkjxp
 nOKovF1OZxd4C8XQa40wQC/GhxUrB1Ssr8mpCXFyXF4NQvhxH02HLR4qAjWX0KsQ7hCft+DnA
 MfEgBqy7v1fG0Z13oYTAFKUyJAP/mI8m3c4EXkFJetdsRiRLa4FYShRinWsykqr9L/XKJcXE0
 D4h6m6lxBUgtcLJL7FGvr8x9szGq2aXbTqIqTQeGDWvYDDQJwkhlN4wIc1Wg6i0sV8DBrRHtY
 x/Pw41GKtCZqTW77sqFZy/E+8oQCjULF9bWK1HvJXhE0xKI6BHFbBZqnFDvW+b/HRF2zNuRwk
 6W4Fr+OTfAFHCwY4JyX238vhexn752wy3xYY4psSQVuVir70Tcx+PapsYHpBYx73OEdL5xFNA
 pSGPV/YuijFYap3vzYix/V3t5/H7lFw+fSEqjWip+Ja1A2zxnwvjEe+EtzjAEVNIjPtOD7g6U
 d8/AZkd7gtKKngpuD/g4nr5EVW0NVZffqzou7vhCikWh4umo2Mmm4syeh+AerIb2FfvOK7Vnq
 hEcKCLk3UVXpXxYTnV9oUUIPzRH+tVE/U7AOSG+NLVUxbu0PlwU5I+Q1ztU03S2vK1w67te/k
 t7YXHg==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-05-22 at 19:02 +0200, Mike Galbraith wrote:
> That 160us was with the nouveau left on by mistake, the worst ftrace
> recorded with me beating up box was 77us (and it inflates).

Grr, ftraced 160us was with the GPU mucking up box's RT performance,
ftraced 77us was without GPU.  Box was very busy in both cases.

	-Mike
