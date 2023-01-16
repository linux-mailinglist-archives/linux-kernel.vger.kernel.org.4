Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ACE266C369
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 16:16:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbjAPPQb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 16 Jan 2023 10:16:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbjAPPQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 10:16:02 -0500
Received: from mail5.swissbit.com (mail5.swissbit.com [148.251.244.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E3620044;
        Mon, 16 Jan 2023 07:03:48 -0800 (PST)
Received: from mail5.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id BDDA43A175C;
        Mon, 16 Jan 2023 16:03:44 +0100 (CET)
Received: from mail5.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id A95713A16BB;
        Mon, 16 Jan 2023 16:03:44 +0100 (CET)
X-TM-AS-ERS: 10.181.10.102-127.5.254.253
X-TM-AS-SMTP: 1.0 bXgyLmRtei5zd2lzc2JpdC5jb20= Y2xvZWhsZUBoeXBlcnN0b25lLmNvb
        Q==
X-DDEI-TLS-USAGE: Used
Received: from mx2.dmz.swissbit.com (mx2.dmz.swissbit.com [10.181.10.102])
        by mail5.swissbit.com (Postfix) with ESMTPS;
        Mon, 16 Jan 2023 16:03:44 +0100 (CET)
From:   =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>
To:     Avri Altman <Avri.Altman@wdc.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
Subject: RE: [PATCH] mmc: block: workaround long ioctl busy timeout
Thread-Topic: [PATCH] mmc: block: workaround long ioctl busy timeout
Thread-Index: Adkpq3tb+gXfT/KXQXawlvtJeLUDVwADfyhQAAB3+5A=
Date:   Mon, 16 Jan 2023 15:03:43 +0000
Message-ID: <5cb91ce2557f41398e23ac25e74b5dc0@hyperstone.com>
References: <68590206e8b044a2a71457cbbeda0794@hyperstone.com>
 <DM6PR04MB65759FBA12E7A48DD904E0D6FCC19@DM6PR04MB6575.namprd04.prod.outlook.com>
In-Reply-To: <DM6PR04MB65759FBA12E7A48DD904E0D6FCC19@DM6PR04MB6575.namprd04.prod.outlook.com>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TMASE-Version: DDEI-5.1-9.0.1002-27390.000
X-TMASE-Result: 10--18.948500-10.000000
X-TMASE-MatchedRID: gIwa0kWWszLUL3YCMmnG4vHkpkyUphL9GbJMFqqIm9xXGTbsQqHbkq3V
        nhPwJLcsq0agEQokQkS0HhY97FjlNd4bgXBxaoBL9Ib/6w+1lWRb0MaM9Tusz+2u9WxDRZ0zwPg
        xkqlR8CmXE+xHCJjkvB+PULRvXYsgNnnMApX7i6FIcJTn2HkqsbFcDzCo2ZtWS4KPPiCB23Bw4C
        DKub+trC93ukh5vTf713H+AdKxwnPFTOSd1Hf9FM2CuVPkCNzuFlIP4ZuPPcgQRik6+J7XSci+U
        JljoDHwimyY0YAT/KnTZ4zxN64GR49oUcx9VMLgEzQnFLEeMUndB/CxWTRRuyUIayx+Skid
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-TMASE-INERTIA: 0-0;;;;
X-TMASE-XGENCLOUD: dd70fa38-b836-4549-aeb0-e78f05dbc5e4-0-0-200-0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>Subject: RE: [PATCH] mmc: block: workaround long ioctl busy timeout
>>         cmd.opcode = idata->ic.opcode;
>>         cmd.arg = idata->ic.arg;
>>         cmd.flags = idata->ic.flags;
>> +       /* R1B flag might be removed here to work around hw, so save it */
>> +       poll_prog = (idata->rpmb || (cmd.flags & MMC_RSP_R1B) ==
>> MMC_RSP_R1B);
>> +       busy_timeout = idata->ic.cmd_timeout_ms ? :
>> +               MMC_BLK_TIMEOUT_MS;
> Isn't commit 23e09be254f9 already introduced the very same thing?
> Meaning mmc_poll_for_busy() is already called with the appropriate timeout?

mmc_poll_for_busy() is, but the problem is already at
mmc_wait_for_req(card->host, &mrq);
Drivers like SDHCI will setup their hardware timer for (in SDHCI) the data inhibit bit.
Drivers dont check if the set timeout is above their capabilities, that's why sanitize also
removes the busy flag.
So without this patch and issuing a secure erase that takes reasonably long, it will fail like so:

[  464.749702] Polling 19507500ms / 19507500ms for busy: CMD38 : 80000000
[  545.761530] mmc2: Timeout waiting for hardware interrupt.
[  545.762623] mmc2: sdhci: ============ SDHCI REGISTER DUMP ===========
[  545.763199] mmc2: sdhci: Sys addr:  0x00000000 | Version:  0x00001002
[  545.763776] mmc2: sdhci: Blk size:  0x00007200 | Blk cnt:  0x00000000
[  545.764353] mmc2: sdhci: Argument:  0x80000000 | Trn mode: 0x00000013
[  545.764928] mmc2: sdhci: Present:   0x1fef0006 | Host ctl: 0x00000035
[  545.765504] mmc2: sdhci: Power:     0x0000000b | Blk gap:  0x00000080
[  545.766080] mmc2: sdhci: Wake-up:   0x00000000 | Clock:    0x00000207
[  545.766656] mmc2: sdhci: Timeout:   0x0000000e | Int stat: 0x00000000
[  545.767231] mmc2: sdhci: Int enab:  0x02ff000b | Sig enab: 0x02ff000b
[  545.767807] mmc2: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000000
[  545.768382] mmc2: sdhci: Caps:      0x44edc880 | Caps_1:   0x800020f7
[  545.768959] mmc2: sdhci: Cmd:       0x0000261b | Max curr: 0x00000000
[  545.769534] mmc2: sdhci: Resp[0]:   0x00000800 | Resp[1]:  0xfff6dbff
[  545.770110] mmc2: sdhci: Resp[2]:   0x329f5903 | Resp[3]:  0x00900f00
[  545.770686] mmc2: sdhci: Host ctl2: 0x00000000
[  545.771089] mmc2: sdhci: ADMA Err:  0x00000000 | ADMA Ptr: 0x0b4b1208
[  545.771665] mmc2: sdhci: ============================================
[  545.773325] sdhci-arasan fe330000.mmc: __mmc_blk_ioctl_cmd: CMD38 cmd error -110

(First print added by me, shows cmd_timeout_ms set by mmc-utils)
Erroring out already at
if (cmd.error) {
	dev_err(mmc_dev(card->host), "%s: cmd error %d\n",
					__func__, cmd.error);
	return cmd.error;
}
i.e. timeout set by user space is  being limited by the max hardware timeout.

Regards,
Christian

>
> Thanks,
> Avri

Hyperstone GmbH | Reichenaustr. 39a  | 78467 Konstanz
Managing Director: Dr. Jan Peter Berns.
Commercial register of local courts: Freiburg HRB381782

