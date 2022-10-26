Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEC4A60DC19
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 09:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233099AbiJZHay convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 26 Oct 2022 03:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232992AbiJZHat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 03:30:49 -0400
Received: from mail5.swissbit.com (mail5.swissbit.com [148.251.244.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 074D76B8E7;
        Wed, 26 Oct 2022 00:30:40 -0700 (PDT)
Received: from mail5.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id 9DBD53A1CC6;
        Wed, 26 Oct 2022 09:30:38 +0200 (CEST)
Received: from mail5.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id 82FBC3A19AE;
        Wed, 26 Oct 2022 09:30:38 +0200 (CEST)
X-TM-AS-ERS: 10.149.2.42-127.5.254.253
X-TM-AS-SMTP: 1.0 ZXguc3dpc3NiaXQuY29t Y2xvZWhsZUBoeXBlcnN0b25lLmNvbQ==
X-DDEI-TLS-USAGE: Used
Received: from ex.swissbit.com (sbdeex04.sbitdom.lan [10.149.2.42])
        by mail5.swissbit.com (Postfix) with ESMTPS;
        Wed, 26 Oct 2022 09:30:38 +0200 (CEST)
Received: from sbdeex04.sbitdom.lan (10.149.2.42) by sbdeex04.sbitdom.lan
 (10.149.2.42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.9; Wed, 26 Oct
 2022 09:30:38 +0200
Received: from sbdeex04.sbitdom.lan ([fe80::2047:4968:b5a0:1818]) by
 sbdeex04.sbitdom.lan ([fe80::2047:4968:b5a0:1818%9]) with mapi id
 15.02.1118.009; Wed, 26 Oct 2022 09:30:37 +0200
From:   =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>
To:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     Avri Altman <Avri.Altman@wdc.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "vincent.whitchurch@axis.com" <vincent.whitchurch@axis.com>,
        =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>
Subject: [PATCH 0/3] mmc: Improve block layer requeueing behavior
Thread-Topic: [PATCH 0/3] mmc: Improve block layer requeueing behavior
Thread-Index: AdjpC+qWoltr9IdKRm6wj2+qCOUtNQ==
Date:   Wed, 26 Oct 2022 07:30:37 +0000
Message-ID: <f30ec7fe7d834c1d8e116508500110cf@hyperstone.com>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.153.3.46]
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TMASE-Version: DDEI-5.1-9.0.1002-27224.006
X-TMASE-Result: 10--3.793700-10.000000
X-TMASE-MatchedRID: oCMH03eFz6AT3Cigx7DwIS+6f/7y7+GzFlIP4ZuPPchnyL8x0tKlO4Tw
        qzKAP6T8Y1mVlKjrUUzx+Rm6PSeis1IQLOwNk2UvngIgpj8eDcCLbopAC1KZxsavT21DsLD/UEh
        Wy9W70AEgBwKKRHe+r/QKUBFsa3vLup+A4QN6tct8Y/9k3xu3fim3yzlbq0uK2MIkLxRxv00=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-TMASE-INERTIA: 0-0;;;;
X-TMASE-XGENCLOUD: 381ae854-77e1-480e-8e83-5757b9225b54-0-0-200-0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mmcblk relies on block layer requeueing to fulfill some requests under
certain conditions. Improve the handling to get nicely ordered requests.

Using the terms a bit loosely to get a point across:
Current behavior for 512 blksz and max_blk_count = 1 the scenario would
be as follows:

- request for page 0 lba 0 to 7
- request for page 1 lba 8 to 15
- request for page 2 lba 16 to 23
- request for page 3 lba 24 to 31

mmcblk modifies data->blocks = 1 for each and requeues,
this leads to:

Access lba 0
Access lba 8
Access lba 16
Access lba 24
Access lba 1 (1. Requeue for page 0)
Access lba 9 (1. Requeue for page 1)
Access lba 17 (1. Requeue for page 2)
Access lba 25 (1. Requeue for page 3)
Access lba 2 (2. Requeue for page 0)
...

Of course we would rather have lbas consecutive.
Hyperstone GmbH | Reichenaustr. 39a  | 78467 Konstanz
Managing Director: Dr. Jan Peter Berns.
Commercial register of local courts: Freiburg HRB381782

