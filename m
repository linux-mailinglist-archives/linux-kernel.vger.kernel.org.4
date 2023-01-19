Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A7EC673325
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 08:59:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbjASH7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 02:59:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbjASH6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 02:58:44 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E8B54858C
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 23:58:38 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id DDA3B41DF4;
        Thu, 19 Jan 2023 07:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1674115116; bh=qyTTsAPiys3la5XkUpFouJxNDSn76IufAXYFiFAQBnk=;
        h=Date:From:To:CC:Subject:In-Reply-To:References;
        b=mitHd9GYk/SoARidHVomS7q8ZfQ2d1ULcTBxBJmXayM9ZzLstLc2FZIJdBjMnckQR
         gDYp8dfFqoI03GxQ4eEo0Fr6u9YykYkH6fZXzyRjJEYB0xVC5y8q7kWuEHlxrcvEgr
         p5Y1hIDnXP9fduqf2FlNsRb0GabgREmyR+s2Uf+XNA3BA0Pf4XU7HPmljZm7HPSAiu
         UTgPMiaPun4+/avrBqNXEL+lsi7U5vTbDHCDuSKx7GWUBaHRH1VhSoBvw42Z6shEr0
         b8/fLI7yf6fQJ2aEVzoWcD2LjAxZFkb1dczmckFmBZ+y0h2kaQMbEcoGFdORCTXhcR
         IwSx9uZRI0Cgg==
Date:   Thu, 19 Jan 2023 16:58:29 +0900
From:   "Hector Martin \"marcan\"" <marcan@marcan.st>
To:     Christoph Hellwig <hch@lst.de>, Janne Grunau <j@jannau.net>
CC:     Sven Peter <sven@svenpeter.dev>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Eric Curtin <ecurtin@redhat.com>, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] nvme-apple: Reset controller during shutdown
User-Agent: K-9 Mail for Android
In-Reply-To: <20230119061452.GA17695@lst.de>
References: <20230114-apple-nvme-suspend-fixes-v6.2-v2-0-9157bf633dba@jannau.net> <20230114-apple-nvme-suspend-fixes-v6.2-v2-1-9157bf633dba@jannau.net> <20230118052450.GA24742@lst.de> <20230119061452.GA17695@lst.de>
Message-ID: <60A924B7-9F29-4AF1-9DF8-EA90DBA48B3E@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Replying from mobile, please excuse formatting)

I'm actually not sure exactly how this works any more=2E The previous seri=
es I sent (which had slightly different logic) worked for me on a t8103 Mac=
 Mini in smoke tests and I'd assumed fixed the issue, but it turned out to =
fail (in a different way) on other machines/circumstances=2E This one seems=
 to work everywhere, but I can't explain exactly why=2E Maybe we do in fact=
 need to issue an NVMe disable before shutting down the firmware to reliabl=
y come up properly on firmware restart=2E

Maybe something like this?

/*
 * Always disable the NVMe controller after shutdown=2E
 * We need to do this to bring it back up later anyway,
 * and we can't do it while the firmware is not running
 * (e=2Eg=2E in the resume reset path before RTKit is
 * initialized), so for Apple controllers it makes sense to
 * unconditionally do it here=2E Additionally, this sequence
 * of events is reliable, while others (like disabling after
 * bringing back the firmware on resume) seem to run
 * into trouble under some circumstances=2E
 *
 * Both U-Boot and m1n1 also use this convention
 * (i=2Ee=2E an ANS NVMe controller is handed off with
 * firmware shut down, in an NVMe disabled state,
 * after a clean shutdown)=2E
 */

On 2023=E5=B9=B41=E6=9C=8819=E6=97=A5 15:14:52 JST, Christoph Hellwig <hch=
@lst=2Ede> wrote:
>Folks, can you chime in if this comment makes sense?  I'd really
>like to send the patches off to Jens before rc5=2E
>
>On Wed, Jan 18, 2023 at 06:24:50AM +0100, Christoph Hellwig wrote:
>> On Tue, Jan 17, 2023 at 07:25:00PM +0100, Janne Grunau wrote:
>> > +		/*
>> > +		 * Always reset the NVMe controller on shutdown=2E The reset is
>> > +		 * required to shutdown the co-processor cleanly=2E
>> > +		 */
>>=20
>> Hmm=2E  This comment doesn't seem to match the discussion we had last
>> week=2E  Which would be:
>>=20
>> 		/*
>> 		 * NVMe requires a reset before setting up a controller to
>> 		 * ensure it is in a clean state=2E  For NVMe PCIe this is
>> 		 * done in the setup path to be able to deal with controllers
>> 		 * in any kind of state=2E  For for Apple devices, the firmware
>> 		 * will not be available at that time and the reset will
>> 		 * time out=2E  Thus reset after shutting the NVMe controller
>> 		 * down and before shutting the firmware down=2E
>> 		 */
>---end quoted text---
>

--=20
Hector Martin "marcan" (marcan@marcan=2Est)
Public key: https://mrcn=2Est/pub
