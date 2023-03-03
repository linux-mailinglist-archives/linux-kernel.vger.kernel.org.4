Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACDD06A9695
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 12:40:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbjCCLka convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 3 Mar 2023 06:40:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjCCLk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 06:40:27 -0500
Received: from mail6.swissbit.com (mail5.swissbit.com [148.251.244.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02181521D3;
        Fri,  3 Mar 2023 03:40:25 -0800 (PST)
Received: from mail6.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id 492FF221761;
        Fri,  3 Mar 2023 11:40:24 +0000 (UTC)
Received: from mail6.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id 3DFB5220859;
        Fri,  3 Mar 2023 11:40:24 +0000 (UTC)
X-TM-AS-ERS: 10.181.10.103-127.5.254.253
X-TM-AS-SMTP: 1.0 bXgxLmRtei5zd2lzc2JpdC5jb20= Y2xvZWhsZUBoeXBlcnN0b25lLmNvb
        Q==
X-DDEI-TLS-USAGE: Used
Received: from mx1.dmz.swissbit.com (mx1.dmz.swissbit.com [10.181.10.103])
        by mail6.swissbit.com (Postfix) with ESMTPS;
        Fri,  3 Mar 2023 11:40:24 +0000 (UTC)
From:   =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
CC:     Wenchao Chen <wenchao.chen666@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Avri Altman <avri.altman@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH] mmc: core: Disable REQ_FUA if the eMMC supports an
 internal cache
Thread-Topic: [RFC PATCH] mmc: core: Disable REQ_FUA if the eMMC supports an
 internal cache
Thread-Index: AQHZTRVhGw7IamWdbkW+N3YLAv3UBK7nlDEQgAFYhgA=
Date:   Fri, 3 Mar 2023 11:40:23 +0000
Message-ID: <a35f3d45cab0442b9491c0b120e3fb47@hyperstone.com>
References: <20230302144330.274947-1-ulf.hansson@linaro.org>
 <5712c69ae37447c5b576d87b247f5756@hyperstone.com>
In-Reply-To: <5712c69ae37447c5b576d87b247f5756@hyperstone.com>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TMASE-Version: DDEI-5.1-9.0.1002-27480.007
X-TMASE-Result: 10--1.097400-10.000000
X-TMASE-MatchedRID: dwNgap4H9hjUL3YCMmnG4vHkpkyUphL9pIm7+t7/ErssTMNBTJAZWem5
        73tusZjQtAooHLFhogVeWwXKQGp3JHh1rPkUeh+7upDIC9422DplH44U2Ru12mdAe5NczV1Ve8w
        NVrnxqoN1trix3E1eFJ/NKWBrHFmLBXdkbv140jU1yhbbA7We06wfObg093CkJUvol+PHbEyqLr
        Si9+cPfTvtgB+lCbJUb3JmPdq59vloMCLywE0ygbq9UFRTJ0kKxEHRux+uk8h+ICquNi0WJLxXM
        1hseCqOlJuZJgT8RltlDYN/ce5s3vVHDCDtM7pWftwZ3X11IV0=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-TMASE-INERTIA: 0-0;;;;
X-TMASE-XGENCLOUD: 7600cef7-30f3-4b32-8fd4-694eeb41f124-0-0-200-0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> 
>> REQ_FUA is in general supported for eMMC cards, which translates into so called "reliable writes". To support these write operations, the CMD23 (MMC_CAP_CMD23), needs to be supported by the mmc host too, which is common but not always the case.
>> 
>> For some eMMC devices, it has been reported that reliable writes are quite costly, leading to performance degradations.
>> 
>> In a way to improve the situation, let's avoid announcing REQ_FUA support if the eMMC supports an internal cache, as that allows us to rely solely on flush-requests (REQ_OP_FLUSH) instead, which seems to be a lot cheaper.
>> Note that, those mmc hosts that lacks CMD23 support are already using this type of configuration, whatever that could mean.
> 
> Just note that reliable write is strictly weaker than turning cache off/flushing, if card loses power during cache off/flush programming / busy, sector-wise atomicity is not mandated by the spec.
> (And that is assuming cache off/flush is actually respected by the card as intended by the spec, should some cards be checked?) Maybe some FS people can also chime in?

Nevermind, the sector-wise atomicity should not matter on 5.1 cards or if the block length isn't being played with, which it isn't in our case.
If reliable write is implemented only according to spec, I don't see why the cache flushing should be less expensive, which would only make sense if
a) < sector chunks are committed to flash
b) reliable write is implemented much stricter than the spec, ensuring atomicity for the entire write.

I guess the cards which increase performance do b)? Or something else?
Anyway regarding FUA i don't have any concerns regarding reliability with cache flush.
I can add some performance comparisons with some eMMCs I have around though.

Regards,
Christian

Hyperstone GmbH | Reichenaustr. 39a  | 78467 Konstanz
Managing Director: Dr. Jan Peter Berns.
Commercial register of local courts: Freiburg HRB381782

