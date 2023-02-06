Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0971468B53C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 06:38:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbjBFFir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 00:38:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjBFFip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 00:38:45 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2127.outbound.protection.outlook.com [40.107.215.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD15AFF0E
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 21:38:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qj0KW31XJ370LOhfqcaldQkbv8tAOU9r81/Efr1wo1fSip/NuSXmlXcnsGn/ZN04UDfA3BIroXijUKtHrQaip8bus7fHTDipZO2yZP4O0uK4q03xuvr0uby2yG3r/oSp5rfd4kAb8dy0cLzY5mKRFFQhpIBVrG+T0/7qoNvSVsulgHVAT66vbIobrLbI13soBB2YXnnUJl9qWeAfeuxvxLNpsIsJwyWXXNzKoCzITf9mhscaAPu2Uqwl2VuCiVZa4MwoX30nySELmZEEDPls3LtPHVUmxHe1CyRnNAJu7U0FK3JABV1l2dAruw7q/ScgfOkGTPY0FeaI6TRiBtiLgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qju7whXgI8b//4Ovj1VHhOKZj5ii0VQRPa0WRJhMQHs=;
 b=nx/IhA0HRxMfL30Podrf5V4cC4P149Pw50zivWPe6cvGJtK9zH6HngwwtFodv69uV5M7noAUygVS4w11uOx1DLdkpfE++PM9NAylKUYIP3ZUXBjmMq2zvcl0XQzpV31doddq34blsMAc37ymdG5ZCPvkdrx7vhEcmaTEu5st1TScaH8T2/FSJXYTOlcGXrjtxQJYKj/LzNqbKG5n8XguO1DXCC54DdT+7Hg0sxdkMDaczgPpLE5mxuHoN3UTYs/VPirwW1pmXVUOyvAR/DL/inihhGekq4ZAOiRAkLqKWYo5NftY7Q8A8t/NDuP/sjoSJlSQ75J1rRKcgJ73CnOt+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qju7whXgI8b//4Ovj1VHhOKZj5ii0VQRPa0WRJhMQHs=;
 b=Epr0QYMANUhRlRiMkV7PWnWmwt++WwIZD0Pg+RVePC/weEU/rvHG6YibdDuF90PTL4ZpybuSO9IOuu/VGB45acnv3nZ9DEap/0o3/DMRUYnRLzz32T968xGFXYkNWE6q8+EcVyY7D8R8S6NXh1DP62xPNtJQsOHBYuzNKH6nwf8=
Received: from OS3PR01MB6641.jpnprd01.prod.outlook.com (2603:1096:604:10b::11)
 by TYCPR01MB5840.jpnprd01.prod.outlook.com (2603:1096:400:a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Mon, 6 Feb
 2023 05:38:37 +0000
Received: from OS3PR01MB6641.jpnprd01.prod.outlook.com
 ([fe80::9438:5139:7952:d8b0]) by OS3PR01MB6641.jpnprd01.prod.outlook.com
 ([fe80::9438:5139:7952:d8b0%7]) with mapi id 15.20.6064.034; Mon, 6 Feb 2023
 05:38:37 +0000
From:   David Rau <david.rau.zg@renesas.com>
To:     Guenter Roeck <linux@roeck-us.net>, Mark Brown <broonie@kernel.org>
CC:     "perex@perex.cz" <perex@perex.cz>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "support.opensource@diasemi.com" <support.opensource@diasemi.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] ASoC: da7219: Fix pole orientation detection on OMTP
 headsets when playing music
Thread-Topic: [PATCH] ASoC: da7219: Fix pole orientation detection on OMTP
 headsets when playing music
Thread-Index: AQHY/Wc8EHyTvYawJkGeL+1XJ6BDpa6jYNiAgAIOc/CAANeEgIASDP8AgAAoZACAAGKRgIADYrqAgAAUigCAABqigIAAD+IAgALjMQCAAlK64A==
Date:   Mon, 6 Feb 2023 05:38:37 +0000
Message-ID: <OS3PR01MB6641CA1DB8524BCA0F9867D9CDDA9@OS3PR01MB6641.jpnprd01.prod.outlook.com>
References: <20230117195645.GA83401@roeck-us.net>
 <OS3PR01MB66416CEF9F6E5AE62D194BACCDC49@OS3PR01MB6641.jpnprd01.prod.outlook.com>
 <20230119161221.GA981953@roeck-us.net>
 <OS3PR01MB66416C10BF8E6400C84DAD02CDD09@OS3PR01MB6641.jpnprd01.prod.outlook.com>
 <38f09c4d-70d1-f65f-6e9b-4ad84eda4059@roeck-us.net>
 <Y9kE1cSUg2CQM5vq@sirena.org.uk> <20230202155101.GB1373010@roeck-us.net>
 <Y9vtIISfmpICi+9u@sirena.org.uk>
 <8f89eeac-b3ef-4137-80df-6cf044873b05@roeck-us.net>
 <Y9wQygzbFyOWl54r@sirena.org.uk> <20230204154222.GA877819@roeck-us.net>
In-Reply-To: <20230204154222.GA877819@roeck-us.net>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB6641:EE_|TYCPR01MB5840:EE_
x-ms-office365-filtering-correlation-id: 85a19d9a-260d-4ccc-478d-08db0804653c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TjTMIMkBLQb3t/oSg/qZ2dkdKuEfRahh4o63ltzwhodXzpTGXHyPmZ/W++tjkjgw8CCG4EWHCcUX86To1lYT/1K5lubDAmKDbBZ/4Ah2DqN7vnV4SuJoapF/6Qyha3UxvoNj4IbNuGh4kxf39WECgw9H9lTbqVmx1pKbrUSgWoGpB8S6vX6aUg8lsfQJeqZ0CZER1e22lphFm0MGoe2VP80H3N9fCWj3r8+OWv8owHJn342T/pfXFcvmFc2K2XBKxjH9xNatLwaUGU56BMUrdZzPeLo9A4nv1oYTFTvnwlAUSOwiGfZPkRMtgTJTKDJnfFec2smCx5pVDxqrd+bEBV2K+efpCgZiTjrjoul4REiZHkAeYNhiDLDiqY+6qpyJsE5+26YPQMluImilQnT4QhA056T1fhDmpUhXEy7pwWPsJ+dSM7BwI/ASmTjQYVUrzwkliB83q62RimPX89meIELohh4WE6AIeJoRFNle+prFNOhJG/JIEaBQOucQufMIQJKQ7Na2Es+Sc2dZc4YzXLFBgG99exja9Th9yejiYHep0tVrapVs5C80oVAxuxZ6cD7BD/8uBDga+a9VWDrTRtLzK4s/dEV85jmtGc/3QMBcVW/5A89L1mpWgiuplN4NgdgKq81c6+vwJrYtYvc1SC5+UmyJO7Ez1kai1vOaNcTe9xNII+i0HHT2UTtAqSVqQLg40/O6jwXwM0qoFl2mraO7h2D/41D/5rJPaxnjXBDWoQm3Ab9sL7vDDHkaQdR8wzDf1CPSqpAkzLFRtyBbnQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6641.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(396003)(39860400002)(346002)(366004)(376002)(451199018)(316002)(110136005)(54906003)(33656002)(26005)(86362001)(55016003)(7696005)(71200400001)(186003)(66476007)(64756008)(2906002)(30864003)(8936002)(66556008)(4326008)(8676002)(5660300002)(41300700001)(9686003)(6506007)(966005)(53546011)(478600001)(66446008)(38100700002)(76116006)(66946007)(52536014)(38070700005)(83380400001)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wEncDnQ7o/DD8vqY7byPqRrAcPRBwJSWYmik35EcjYL41uT2rNExUsO/MZ9Y?=
 =?us-ascii?Q?IJWDWUgmt8lvMX4jKBlexc+2avO4ask8QA1MTYg0RQXvxQZBWpQthihsJa4y?=
 =?us-ascii?Q?g99qmpo3yypK+Q21XO/vzjZ0qMJRryL++vqyY/k+AqMVynIOut5iityBRsbj?=
 =?us-ascii?Q?luDgRY6HE4ZQcDFk91H0xPSyJckAJ1hd3sLmqQrxy4qGprPztik2eXOHjMg0?=
 =?us-ascii?Q?ERZC8tcF63yDl5IQPHj/CwquA314RdrSJ9xBN7Pm99V26gmmj427SxXHdx6p?=
 =?us-ascii?Q?mIYBNMqJEGUQaWvbjbkW7k6LEH6lprMNyoXYR9chZf8oWAmJdOUodKAbvonD?=
 =?us-ascii?Q?ojoKyhgnLvpGP/j5pHVZxb20uXcZUL1xysS5azcAZrrLCjWKStBslNMNGMEv?=
 =?us-ascii?Q?B5c7UaWr6VLqqtoKEiGGpntmz8ShwEBuxEJBWWTHdIx5U0h5I8jx4zRI7Pr/?=
 =?us-ascii?Q?DoZ1dCFacVymnAFvRdWFjfw+E8n6f1zBFparZ8keP6sdh6FLtr7Rg1JJWVnx?=
 =?us-ascii?Q?9DE2oUf5ETOt20OMFfX3pyu1KzgH12pcxDnmrkTx4LvBdjMW7Gn1O1uHdgMw?=
 =?us-ascii?Q?eBCw1NziHuUYBXIbdfOnb8SGA/wIC0TebhzSGAiGPxitAHYfgav81jufWLv/?=
 =?us-ascii?Q?XII98tCCDrhAP4oax+IS/ZOSQ/JQLoUlY5Z+uPBvq0lVjd5+8y7K138Jl8FH?=
 =?us-ascii?Q?3UDbigi2lfMC+6XLzh/NISGy7yAVTHcaPYufwKHnGfeSSl4QihwUrXTtibJo?=
 =?us-ascii?Q?zAtTOeOAyk9kmxK01vcBUQjaIf+Mi67re/Minq7EwEeibZoHZ1UvjCrXnMou?=
 =?us-ascii?Q?FpR0o5i+m6Le7ZfV9MgvKrk4r3vGsYSEAAYupp3USBEFeQ3RitV0sdvNp9Gw?=
 =?us-ascii?Q?dY0DhiyaOTMoIbPjCqJoNp46+FBFPlFKgX3q4VGrJ4KyIGgvl9zwSlBrsAVx?=
 =?us-ascii?Q?3rHYvfvIkggxoDViRXzaum47NTiZhyDz8YqdwBN9J5q0uh86pmMBiHVBiisa?=
 =?us-ascii?Q?/0cQrhVMBYPEjSZMX8DrB8gI4BUljXBxYabIfIs1vb/irCBSfFhVrVTbTZPa?=
 =?us-ascii?Q?7JDkQDuwB5VG16v40aEmAYTq7jLCoxJ9/jLSne/io+Z576OjpcFN+0GILB9Y?=
 =?us-ascii?Q?xuB94+k34V8M+AWRq1bxDRbyUm3iBSU5I8RL5/5rXVBB2ueXDIOgSUue8KTc?=
 =?us-ascii?Q?6l9Q2Vxxs1EuNmfhBJD1GrOECjHPGarqy5Z5dbt+lJgXvOhBoQ5JNk+bhpCk?=
 =?us-ascii?Q?aGKr1V1kU/6FhRN8XraL1rmiAk1O3QoQUkCBIwII/+f8fZhkpILd7B4dabQK?=
 =?us-ascii?Q?Ywo+O3PToO4mPTDis4WiFf5xXtU1USem88Wx+9tpJhoxKp41eycFETGDslVc?=
 =?us-ascii?Q?7t6YzpnkRoen0/xwQGEHB5ZrtO09RRW37j3tb48r94tD6yiFj7sE8zM9CGRl?=
 =?us-ascii?Q?BvLrfpTY35vo3BnfmLjSgFde2UcwvM+hDARjQvJQPQJhzDeNZAAe15Ahs+qk?=
 =?us-ascii?Q?I1QeUbfNo5Ihkfq6fhYDityn0TYlyxZAd44ZJhSBKkvEySN5XssfqhRtyzWr?=
 =?us-ascii?Q?f5ZekLCpqyMVA1Q2Fu7MbRIj7uZhdtBlPyS7KFKV?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6641.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85a19d9a-260d-4ccc-478d-08db0804653c
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2023 05:38:37.3772
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7ulbBOLsGBwA3rGKy4frBlDmgKB3T+C+LS4/ko31bX7fsEhHc28nZ4L0cmP8UT+WD7T941yUsQdLetAPjkgWbp6UKNKM9gJO3DkioZU2Aqg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB5840
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



-----Original Message-----
From: Guenter Roeck <groeck7@gmail.com> On Behalf Of Guenter Roeck
Sent: Saturday, February 4, 2023 23:42
To: Mark Brown <broonie@kernel.org>
Cc: David Rau <david.rau.zg@renesas.com>; perex@perex.cz; lgirdwood@gmail.c=
om; tiwai@suse.com; support.opensource@diasemi.com; alsa-devel@alsa-project=
.org; linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: da7219: Fix pole orientation detection on OMTP h=
eadsets when playing music

On Thu, Feb 02, 2023 at 07:36:42PM +0000, Mark Brown wrote:
>=20
> > > they have the potential to actually lock up are the=20
> > > cancel_work_sync() calls but they were unchanged and the backtrace=20
> > > you showed was showing the thread in the msleep().  My guess would=20
> > > be that you've got systems where there are very frequent jack=20
> > > detection events (potentiallly with broken accessories, or=20
> > > possibly due to the ground switch putting things into the wrong=20
> > > priority) and that the interrupt is firing again as soon as the=20
> > > thread unmasks the primary interrupt which means it never actually st=
ops running.
>=20
> > That is what I strongly suspect is happening. I don't know why=20
> > exactly the interrupt is firing continuously, but the hang is always in=
 msleep().
> > One possibility might be that the event is actually a disconnect=20
> > event, and that enabling and immediately disabling the ground switch=20
> > causes another interrupt, which is then handled immediately, causing th=
e hang.
>=20
> Could be.  I'd be willing to guess that it's not just one event but=20
> rather a stream of events of some kind.  Possibly if it's due to the=20
> ground switch it's spuriously detecting a constant stream of button=20
> presses for the affected systems, which don't produce any UI visible=20
> result which would cause users to pull the accessory for whatever=20
> reason?  Whatever's going on I bet it's broken accessories triggering it.
>=20

> That seems to be unlikely. The average number of crashes per affected sys=
tem is 1.92, which points to something the users are doing and less to a br=
oken accessory.=20
> We do observe crashes due to broken accessories, but in those cases the n=
umber of crashes per system tends to be much > higher.

> Anyway, below is a patch with a possible fix. Of course, I still don't kn=
ow what the patch originally tried to fix, so it might not do much if anyth=
ing good.
I added the software debouncing before insertion task to ensue the better c=
ompatibility of OMTP Jack.=20
> For example, it keeps button detection in the interrupt handler to avoid =
dropping button events, so if spurious button detection as you suspected is=
 indeed (part of) the problem we might still see a large number of interrup=
ts.

> Guenter

Thanks a lot for your big efforts to implement the temporary fix and verifi=
cations.
Would you please let me know the average number of crashes per affected sys=
tem if you rollback to the pervious fix?
Ref:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/s=
ound/soc/codecs?id=3D2d969e8f35b1849a43156029a7a6e2943b89d0c0
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/s=
ound/soc/codecs?id=3D06f5882122e3faa183d76c4ec2c92f4c38e2c7bb

David
---
From 81dbe47c94d8d97ce7919a5ec4d4269c55b56ae6 Mon Sep 17 00:00:00 2001
From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 2 Feb 2023 16:09:14 -0800
Subject: [RFC] ASoC: da7219: Prevent hung task errors in interrupt handler

Commit 969357ec94e6 ("ASoC: da7219: Fix pole orientation detection on OMTP =
headsets when playing music") tried to improve pole orientation on certain =
headsets. Part of the change was to add a long sleep in the beginning of th=
e interrupt handler, followed by enabling the ground switch

Unfortunately, this results in hung tasks in the threaded interrupt handler=
.

INFO: task irq/105-da7219-:2556 blocked for more than 122 seconds.
Not tainted 5.10.159-20945-g4390861bfc33 #1 "echo 0 > /proc/sys/kernel/hung=
_task_timeout_secs" disables this message.
task:irq/105-da7219- state:D stack: 0 pid: 2556 ppid: 2 flags:0x00004080 Ca=
ll Trace:
 __schedule+0x3b0/0xddb
 schedule+0x44/0xa8
 schedule_timeout+0xae/0x241
 ? run_local_timers+0x4e/0x4e
 msleep+0x2c/0x38
 da7219_aad_irq_thread+0x66/0x2b0
 irq_thread_fn+0x22/0x4d
 irq_thread+0x131/0x1cb
 ? irq_forced_thread_fn+0x5f/0x5f
 ? irq_thread_fn+0x4d/0x4d
 kthread+0x142/0x153
 ? synchronize_irq+0xe0/0xe0
 ? kthread_blkcg+0x31/0x31
 ret_from_fork+0x1f/0x30

Solve the problem by enabling the ground switch immediately and only after =
an insertion has been detected. Delay pole orientation detection until afte=
r the chip reports that detection is complete plus an additional time depen=
ding on the chip configuration. Do this by implementing ground switch detec=
tion in a delayed worker.

Fixes: 969357ec94e6 ("ASoC: da7219: Fix pole orientation detection on OMTP =
headsets when playing music")
Cc: David Rau <david.rau.zg@renesas.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 sound/soc/codecs/da7219-aad.c | 156 ++++++++++++++++++++++------------
 sound/soc/codecs/da7219-aad.h |   3 +
 2 files changed, 105 insertions(+), 54 deletions(-)

diff --git a/sound/soc/codecs/da7219-aad.c b/sound/soc/codecs/da7219-aad.c =
index c55b033d89da..47685c996bda 100644
--- a/sound/soc/codecs/da7219-aad.c
+++ b/sound/soc/codecs/da7219-aad.c
@@ -8,6 +8,7 @@
  */
=20
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/platform_device.h>
 #include <linux/clk.h>
 #include <linux/i2c.h>
@@ -339,6 +340,82 @@ static void da7219_aad_hptest_work(struct work_struct =
*work)
 				    SND_JACK_HEADSET | SND_JACK_LINEOUT);  }
=20
+static void da7219_aad_handle_removal(struct da7219_aad_priv=20
+*da7219_aad) {
+	struct snd_soc_component *component =3D da7219_aad->component;
+	struct snd_soc_dapm_context *dapm =3D snd_soc_component_get_dapm(componen=
t);
+	struct da7219_priv *da7219 =3D snd_soc_component_get_drvdata(component);
+
+	da7219_aad->jack_inserted =3D false;
+
+	/* Cancel any pending work */
+	cancel_work_sync(&da7219_aad->btn_det_work);
+	cancel_work_sync(&da7219_aad->hptest_work);
+
+	/* Un-drive headphones/lineout */
+	snd_soc_component_update_bits(component, DA7219_HP_R_CTRL,
+				      DA7219_HP_R_AMP_OE_MASK, 0);
+	snd_soc_component_update_bits(component, DA7219_HP_L_CTRL,
+				      DA7219_HP_L_AMP_OE_MASK, 0);
+
+	/* Ensure button detection disabled */
+	snd_soc_component_update_bits(component, DA7219_ACCDET_CONFIG_1,
+				      DA7219_BUTTON_CONFIG_MASK, 0);
+
+	da7219->micbias_on_event =3D false;
+
+	/* Disable mic bias */
+	snd_soc_dapm_disable_pin(dapm, "Mic Bias");
+	snd_soc_dapm_sync(dapm);
+
+	/* Disable ground switch */
+	snd_soc_component_update_bits(component, 0xFB, 0x01, 0x00);
+
+	snd_soc_jack_report(da7219_aad->jack, 0, DA7219_AAD_REPORT_ALL_MASK);=20
+}
+
+static void da7219_aad_insertion_work(struct work_struct *work) {
+	struct da7219_aad_priv *da7219_aad =3D
+		container_of(work, struct da7219_aad_priv, hptest_work);
+	struct snd_soc_component *component =3D da7219_aad->component;
+	u8 statusa;
+
+	mutex_lock(&da7219_aad->insertion_mutex);
+
+	if (!da7219_aad->jack_inserted)
+		goto unlock;
+
+	/* Read status register for jack insertion & type status */
+	statusa =3D snd_soc_component_read(component, DA7219_ACCDET_STATUS_A);
+	if (!(statusa & DA7219_JACK_INSERTION_STS_MASK)) {
+		da7219_aad_handle_removal(da7219_aad);
+		goto unlock;
+	}
+
+	/*
+	 * If 4-pole, then enable button detection, else perform
+	 * HP impedance test to determine output type to report.
+	 *
+	 * We schedule work here as the tasks themselves can
+	 * take time to complete, and in particular for hptest
+	 * we want to be able to check if the jack was removed
+	 * during the procedure as this will invalidate the
+	 * result. By doing this as work, the IRQ thread can
+	 * handle a removal, and we can check at the end of
+	 * hptest if we have a valid result or not.
+	 */
+	if (statusa & DA7219_JACK_TYPE_STS_MASK) {
+		schedule_work(&da7219_aad->btn_det_work);
+		snd_soc_jack_report(da7219_aad->jack, SND_JACK_HEADSET,
+				    SND_JACK_HEADSET | SND_JACK_LINEOUT);
+	} else {
+		schedule_work(&da7219_aad->hptest_work);
+	}
+
+unlock:
+	mutex_unlock(&da7219_aad->insertion_mutex);
+}
=20
 /*
  * IRQ
@@ -348,23 +425,21 @@ static irqreturn_t da7219_aad_irq_thread(int irq, voi=
d *data)  {
 	struct da7219_aad_priv *da7219_aad =3D data;
 	struct snd_soc_component *component =3D da7219_aad->component;
-	struct snd_soc_dapm_context *dapm =3D snd_soc_component_get_dapm(componen=
t);
 	struct da7219_priv *da7219 =3D snd_soc_component_get_drvdata(component);
 	u8 events[DA7219_AAD_IRQ_REG_MAX];
-	u8 statusa, srm_st;
+	u8 statusa;
 	int i, report =3D 0, mask =3D 0;
=20
-	srm_st =3D snd_soc_component_read(component, DA7219_PLL_SRM_STS) & DA7219=
_PLL_SRM_STS_MCLK;
-	msleep(da7219_aad->gnd_switch_delay * ((srm_st =3D=3D 0x0) ? 2 : 1) - 4);
-	/* Enable ground switch */
-	snd_soc_component_update_bits(component, 0xFB, 0x01, 0x01);
+	mutex_lock(&da7219_aad->insertion_mutex);
=20
 	/* Read current IRQ events */
 	regmap_bulk_read(da7219->regmap, DA7219_ACCDET_IRQ_EVENT_A,
 			 events, DA7219_AAD_IRQ_REG_MAX);
=20
-	if (!events[DA7219_AAD_IRQ_REG_A] && !events[DA7219_AAD_IRQ_REG_B])
+	if (!events[DA7219_AAD_IRQ_REG_A] && !events[DA7219_AAD_IRQ_REG_B]) {
+		mutex_unlock(&da7219_aad->insertion_mutex);
 		return IRQ_NONE;
+	}
=20
 	/* Read status register for jack insertion & type status */
 	statusa =3D snd_soc_component_read(component, DA7219_ACCDET_STATUS_A); @@=
 -378,36 +453,29 @@ static irqreturn_t da7219_aad_irq_thread(int irq, void =
*data)
 		statusa);
=20
 	if (statusa & DA7219_JACK_INSERTION_STS_MASK) {
+		u8 srm_st;
+
+		srm_st =3D snd_soc_component_read(component, DA7219_PLL_SRM_STS) &
+							DA7219_PLL_SRM_STS_MCLK;
+
 		/* Jack Insertion */
 		if (events[DA7219_AAD_IRQ_REG_A] &
 		    DA7219_E_JACK_INSERTED_MASK) {
 			report |=3D SND_JACK_MECHANICAL;
 			mask |=3D SND_JACK_MECHANICAL;
 			da7219_aad->jack_inserted =3D true;
+
+			/* Enable ground switch */
+			snd_soc_component_update_bits(component, 0xFB, 0x01, 0x01);
 		}
=20
 		/* Jack type detection */
 		if (events[DA7219_AAD_IRQ_REG_A] &
 		    DA7219_E_JACK_DETECT_COMPLETE_MASK) {
-			/*
-			 * If 4-pole, then enable button detection, else perform
-			 * HP impedance test to determine output type to report.
-			 *
-			 * We schedule work here as the tasks themselves can
-			 * take time to complete, and in particular for hptest
-			 * we want to be able to check if the jack was removed
-			 * during the procedure as this will invalidate the
-			 * result. By doing this as work, the IRQ thread can
-			 * handle a removal, and we can check at the end of
-			 * hptest if we have a valid result or not.
-			 */
-			if (statusa & DA7219_JACK_TYPE_STS_MASK) {
-				report |=3D SND_JACK_HEADSET;
-				mask |=3D	SND_JACK_HEADSET | SND_JACK_LINEOUT;
-				schedule_work(&da7219_aad->btn_det_work);
-			} else {
-				schedule_work(&da7219_aad->hptest_work);
-			}
+			int delay =3D da7219_aad->gnd_switch_delay *
+						((srm_st =3D=3D 0x0) ? 2 : 1) - 4;
+
+			schedule_delayed_work(&da7219_aad->insertion_work, delay);
 		}
=20
 		/* Button support for 4-pole jack */
@@ -431,40 +499,16 @@ static irqreturn_t da7219_aad_irq_thread(int irq, voi=
d *data)
 				}
 			}
 		}
+		snd_soc_jack_report(da7219_aad->jack, report, mask);
 	} else {
 		/* Jack removal */
 		if (events[DA7219_AAD_IRQ_REG_A] & DA7219_E_JACK_REMOVED_MASK) {
-			report =3D 0;
-			mask |=3D DA7219_AAD_REPORT_ALL_MASK;
-			da7219_aad->jack_inserted =3D false;
-
-			/* Cancel any pending work */
-			cancel_work_sync(&da7219_aad->btn_det_work);
-			cancel_work_sync(&da7219_aad->hptest_work);
-
-			/* Un-drive headphones/lineout */
-			snd_soc_component_update_bits(component, DA7219_HP_R_CTRL,
-					    DA7219_HP_R_AMP_OE_MASK, 0);
-			snd_soc_component_update_bits(component, DA7219_HP_L_CTRL,
-					    DA7219_HP_L_AMP_OE_MASK, 0);
-
-			/* Ensure button detection disabled */
-			snd_soc_component_update_bits(component, DA7219_ACCDET_CONFIG_1,
-					    DA7219_BUTTON_CONFIG_MASK, 0);
-
-			da7219->micbias_on_event =3D false;
-
-			/* Disable mic bias */
-			snd_soc_dapm_disable_pin(dapm, "Mic Bias");
-			snd_soc_dapm_sync(dapm);
-
-			/* Disable ground switch */
-			snd_soc_component_update_bits(component, 0xFB, 0x01, 0x00);
+			cancel_delayed_work(&da7219_aad->insertion_work);
+			da7219_aad_handle_removal(da7219_aad);
 		}
 	}
=20
-	snd_soc_jack_report(da7219_aad->jack, report, mask);
-
+	mutex_unlock(&da7219_aad->insertion_mutex);
 	return IRQ_HANDLED;
 }
=20
@@ -938,6 +982,9 @@ int da7219_aad_init(struct snd_soc_component *component=
)
 	snd_soc_component_update_bits(component, DA7219_ACCDET_CONFIG_1,
 			    DA7219_BUTTON_CONFIG_MASK, 0);
=20
+	mutex_init(&da7219_aad->insertion_mutex);
+
+	INIT_DELAYED_WORK(&da7219_aad->insertion_work,=20
+da7219_aad_insertion_work);
 	INIT_WORK(&da7219_aad->btn_det_work, da7219_aad_btn_det_work);
 	INIT_WORK(&da7219_aad->hptest_work, da7219_aad_hptest_work);
=20
@@ -973,6 +1020,7 @@ void da7219_aad_exit(struct snd_soc_component *compone=
nt)
=20
 	free_irq(da7219_aad->irq, da7219_aad);
=20
+	cancel_delayed_work_sync(&da7219_aad->insertion_work);
 	cancel_work_sync(&da7219_aad->btn_det_work);
 	cancel_work_sync(&da7219_aad->hptest_work);
 }
diff --git a/sound/soc/codecs/da7219-aad.h b/sound/soc/codecs/da7219-aad.h =
index 21fdf53095cc..b1b7f8ba45bd 100644
--- a/sound/soc/codecs/da7219-aad.h
+++ b/sound/soc/codecs/da7219-aad.h
@@ -10,6 +10,7 @@
 #ifndef __DA7219_AAD_H
 #define __DA7219_AAD_H
=20
+#include <linux/mutex.h>
 #include <linux/timer.h>
 #include <sound/soc.h>
 #include <sound/jack.h>
@@ -194,6 +195,8 @@ struct da7219_aad_priv {
=20
 	u8 btn_cfg;
=20
+	struct mutex insertion_mutex;
+	struct delayed_work insertion_work;
 	struct work_struct btn_det_work;
 	struct work_struct hptest_work;
=20
--
2.39.1

