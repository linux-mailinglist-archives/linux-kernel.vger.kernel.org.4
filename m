Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 743C66C10D5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 12:31:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbjCTLa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 07:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbjCTLa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 07:30:57 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F8C2AD04
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 04:30:54 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id A71C05FD11;
        Mon, 20 Mar 2023 14:30:51 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1679311851;
        bh=mhNTaHeLzsk1HXgLUGJbb0lrEbiczjFN7BA22rqS9Dk=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=nV4woBe+8aZHrSnq/vzub1yq/dvrl60wWv1cdQO1RWciCybeDaIp2F+EWM2fPb8ND
         YCjfyC4Lwt+pM/+mRaKBs51MiMHxkwWssQKZlGJpg36xpFWlGrO5r7b5DNe3BWTmsR
         NU9lLuY5hFCQY/mkhjGzJRXjWtBe68DEBJRCfH2Q4HnNxNGyZOXDT/24uphhlwYJ3n
         k08z4kOFWidVwvxjpOWUmxZh3DUkuqUXnWOFL3STHh3wKjDbPwsl9YLohPYd5b8vN6
         NVS05h6oEGYUKfFLE1Bl2x6aI0ttBrDz79MdDb5TwQE+gfmwdR2IAScXQSwN/0HB0d
         51njr403RXOtA==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Mon, 20 Mar 2023 14:30:49 +0300 (MSK)
Date:   Mon, 20 Mar 2023 14:30:48 +0300
From:   Dmitry Rokosov <ddrokosov@sberdevices.ru>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     Neil Armstrong <neil.armstrong@linaro.org>,
        Arseniy Krasnov <avkrasnov@sberdevices.ru>,
        Liang Yang <liang.yang@amlogic.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        <linux-mtd@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kernel@sberdevices.ru>,
        <oxffffaa@gmail.com>
Subject: Re: [RFC PATCH v1] mtd: rawnand: meson: invalidate cache on polling
 ECC bit
Message-ID: <20230320113048.3mry647oq33zfmag@CAB-WSD-L081021>
References: <d4ef0bd6-816e-f6fa-9385-f05f775f0ae2@sberdevices.ru>
 <20f7f1f8-e8f8-b3e1-251e-27db71ab6840@sberdevices.ru>
 <20230313121808.27170d1b@xps-13>
 <dc46c06f-6b36-3c1c-bf96-2ef37e29dfdb@linaro.org>
 <20230320104314.i2stk665xbrleb53@CAB-WSD-L081021>
 <20230320115558.49c5a062@xps-13>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230320115558.49c5a062@xps-13>
User-Agent: NeoMutt/20220415
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH02.sberdevices.ru (172.16.1.5) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/03/20 09:56:00 #20977321
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Miquèl,

On Mon, Mar 20, 2023 at 11:55:58AM +0100, Miquel Raynal wrote:
> Hi Dmitry,
> 
> ddrokosov@sberdevices.ru wrote on Mon, 20 Mar 2023 13:43:14 +0300:
> 
> > Hello guys!
> > 
> > Was it applied to some nand 'prepare-for-merge' release branch?
> 
> Not yet, I'll apply it this week in mtd/fixes, you'll be noticed.
> 
> Thanks,
> Miquèl
> 

Thank you for clarification!

[...]

-- 
Thank you,
Dmitry
