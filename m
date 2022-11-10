Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 805236245CF
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 16:28:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbiKJP17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 10:27:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231540AbiKJP04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 10:26:56 -0500
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 10 Nov 2022 07:26:51 PST
Received: from esa.hc4959-67.iphmx.com (esa.hc4959-67.iphmx.com [216.71.153.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 518953C6EB;
        Thu, 10 Nov 2022 07:26:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=seagate.com; i=@seagate.com; q=dns/txt; s=stxiport;
  t=1668094012; x=1699630012;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lsgagpbmuB2IUJ7ZiM8adSY/2uNHkOwBFbdb6oBXIWg=;
  b=ihPtatguG0kz9oH4JdYrf/7jCSJdGHtqNZFpiKdEwIlgNNyHq9vh5gOT
   GceRz+O6KTH1qDSbrxXmZYnf824forReVVNOkwlXk/UDIAGaarsAwFi0Y
   4DyjT5znuAtwkmU+1cGZsiFYi5lf/6iAmOGkvaUmk91mGFxd7wOctHvME
   I=;
Received: from mail-mw2nam10lp2108.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.108])
  by ob1.hc4959-67.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 07:25:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bze4t94mZXgZ1hmtRpuMjsAsVSuakgzQF1+k2xhCHE5gF78EqlnKWgrwu9vTRX7m9vAogc1jWOiJPt/8GowsXXLdwfEPrtfX0i27czfK7KX9z0PvOMiKQYKTviFWvs/UDib5kdpW5En+jMzXhCV8Q7Bq7W4OoH9QXSLM/dxCGV9LKOFT/FcQ70H+Kc1HjgSZYMCRuj1fXoeGnuKQOBh/MfRE+dtXcMG4CC0bMBaOQtIFbRlkmAPGcnyK8OJAeZkRn2OtnDP/ZW0u4BHaUboVQfYBgMXjT7EeEDHK8ZuYQvCuvCJHL1WwUpxNKXY7krKkehItWa2+qCr877XvbgWbHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=61aMhqDm4Gjm92doTGp0m5vknnP9IfrjhBuP5w4+uNY=;
 b=QkJQCcf8Bw11fvkusoz71ANq9AJCiVXClvHQ5XWuuiHiI8fQ7KNfLo7KIo29fuIEG87FMhZcrK54E045fWSkwakFaZY9tOOxaikTVeCyCOV2kOutLsJdeUsmi+To+nU9q+7Vw31jyfPBaLEW48nIaDGcoDJKUPqhg5wfjpcoZmL+xmwkG2V/BsQRKSWnoJdyXflWZ7EyPJUGEbH907267xQlwRC3ZEeb1h4bhCILz0lTE/V/qkyF8hhoz+H/1a4L+98+YrmuGIkLbausaf73kfNf9yIyg7sONbPT4j369L7gE6WtkCg9HCkBAq8wvKU6Ijz/cvEHqk8Xr8Wyodcfaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seagate.com; dmarc=pass action=none header.from=seagate.com;
 dkim=pass header.d=seagate.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seagate.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=61aMhqDm4Gjm92doTGp0m5vknnP9IfrjhBuP5w4+uNY=;
 b=Gpe7XQJ27toUyIAWbBw0i0k6tNtDpZ0OGNKn2Q4NrPWpwT7pzHBxab3+XvyCKHxMk/dD/RtCTUdDcif8CgDpMayJ34Qj2cIuRWY/gsgXVq6SIEBtx9SpN1BfyyhfkpqPK1InzL/wZPGf2+8D2iFjUqosziam+ZNJUWyjNAJZEgE=
Received: from PH7PR20MB5058.namprd20.prod.outlook.com (2603:10b6:510:1f2::10)
 by CH0PR20MB3868.namprd20.prod.outlook.com (2603:10b6:610:c5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Thu, 10 Nov
 2022 15:25:43 +0000
Received: from PH7PR20MB5058.namprd20.prod.outlook.com
 ([fe80::d6f5:75c3:2b61:a389]) by PH7PR20MB5058.namprd20.prod.outlook.com
 ([fe80::d6f5:75c3:2b61:a389%5]) with mapi id 15.20.5791.026; Thu, 10 Nov 2022
 15:25:43 +0000
From:   Arie van der Hoeven <arie.vanderhoeven@seagate.com>
To:     Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rory Chen <rory.c.chen@seagate.com>,
        Davide Zini <davidezini2@gmail.com>
Subject: Re: [PATCH V6 8/8] block, bfq: balance I/O injection among
 underutilized actuators
Thread-Topic: [PATCH V6 8/8] block, bfq: balance I/O injection among
 underutilized actuators
Thread-Index: AQHY76ET6Eue/sV/vkqLe2mFk8QJU644UM2E
Date:   Thu, 10 Nov 2022 15:25:43 +0000
Message-ID: <PH7PR20MB5058FFC62E46AB2AE3AB0F38F1019@PH7PR20MB5058.namprd20.prod.outlook.com>
References: <20221103162623.10286-1-paolo.valente@linaro.org>
 <20221103162623.10286-9-paolo.valente@linaro.org>
In-Reply-To: <20221103162623.10286-9-paolo.valente@linaro.org>
Accept-Language: en-US, en-001
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_56e366eb-86f1-4645-85a7-f29555b26fee_Enabled=True;MSIP_Label_56e366eb-86f1-4645-85a7-f29555b26fee_SiteId=d466216a-c643-434a-9c2e-057448c17cbe;MSIP_Label_56e366eb-86f1-4645-85a7-f29555b26fee_SetDate=2022-11-10T15:25:42.588Z;MSIP_Label_56e366eb-86f1-4645-85a7-f29555b26fee_Name=Seagate
 Internal;MSIP_Label_56e366eb-86f1-4645-85a7-f29555b26fee_ContentBits=0;MSIP_Label_56e366eb-86f1-4645-85a7-f29555b26fee_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seagate.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR20MB5058:EE_|CH0PR20MB3868:EE_
x-ms-office365-filtering-correlation-id: 5e542537-c7e8-4459-aff5-08dac32fd543
stx-hosted-ironport-oubound: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xw7DotnDIDsV60rcU8r0zvRU4laOYBMcJbxyivL/lk+UpqSt7tiIZ1q5z8Yw39Cjl3Zh/7oLvMT6wi3qjBkNN9dgcHlTD6+QiZeV7wwcjJe3rg/gCALeZ2Hs8IFM2Xk6Z03SzZbUisOe81Fli60LpYIcNQX4vyDCKRnmbVB+NbcxLEMfozaqOcIGOCQuMO9TXq4F9l9BYnu8RFosZN5+1q+cooaq7AnmI3k9j6T8PxUx1myvMOzX7Kl90XR9XQ1csxipgXkZbx04F59Qs8co6B+g9/8BNiJW25Cy3WVFNaCMckLHMvJTRxg5N99lXdGDZVrXSzYTD32a8yWGIrkPv6a+0blsgFizg79AdgZWeXcwho7esIXsQ+3rI1sh68hBjG2YRll2A0faMILzIduYoAztgrPF4pllwXKFnTOlerT40AAM7nx1feAVTppHvEpTNVkPQlPWYPeAnvc2C6dBXwr8z/gIypDgUJnayjoCBj4ETnIPImDQDQI0/g6H3YPGQclfh5UhjwS6rb/H8PKD+8V+FASQmXogOzWp629hhCRHCSiqLBV6N6VnQ0RcD2yXKvuKyPCryiDcnmAkyRXFl2eVmifBiyKuQOU0Oe1hp7o8BJwAYp/5gsiYq1WtRBY/IbQGBm90JNCJ1lP2DVaOlh+i8BQ9imeBH/Ms11xbIeim0uehM/BCfi9fZLckH5jOob4r147bP8mRt4bW2QrZV6tgFxqcVosV/kALghH8b5l6CVskb/eVpEIXjsIopjER0KM94mBBVwO0KbovThyg9g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR20MB5058.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(136003)(376002)(39860400002)(346002)(451199015)(33656002)(38070700005)(86362001)(7696005)(6506007)(66556008)(2906002)(5660300002)(186003)(53546011)(9686003)(26005)(83380400001)(122000001)(38100700002)(52536014)(64756008)(66946007)(66446008)(76116006)(316002)(66476007)(8676002)(8936002)(71200400001)(55016003)(41300700001)(54906003)(4326008)(110136005)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?xeiZXS49pRnxlsFFIU3CJqCrZOWB35kyZsQ99fHWdFochIN6fsdKSOosod?=
 =?iso-8859-1?Q?nQp2m6CT0JqmqIo+IXlnrSCN2yTIKncJsXRCZAaQNmuNF2uiB+3m5Mklf9?=
 =?iso-8859-1?Q?ICr5NYaGUaBp/7e9XOIIBzXeXZ6Xw3vDGrs+qLuh2HCdVNm+HH3g+kDjhT?=
 =?iso-8859-1?Q?jiQTqgDUEaiDGUXJ6SVVMAYqHfZwBXbjPIZJJvotqtm2FeTqAUbrTJK4Zm?=
 =?iso-8859-1?Q?sss92zZ6orUWoQuSEArZAvsL3u8mgmMbhNQ6N1irWUeDMdobyCDb95/jCc?=
 =?iso-8859-1?Q?kqvCMk4bvFJJheZPizTw/YEgGsbTRDVviw1OS63sGsvG9FOuRCaF+Vd22X?=
 =?iso-8859-1?Q?Av53vJLrn7k0xRwsYoRR+9BCvcYgHtDp1E6nSkFcnjbqMrz/RMQuFIL8F1?=
 =?iso-8859-1?Q?hI5nGa9Yz+ClS5GatLcPHkCtTz02qpMwKK3vgqpnWy5vFw+LQnUX9gB7Ut?=
 =?iso-8859-1?Q?YlJa9A01VS+eRrH/Vmzcv2BiN5e+dTCW9H0f+loOhcjewZrUF2RMYseGwd?=
 =?iso-8859-1?Q?oq93TssuuufztE/wZ6Vnnl2XU7iT2rdGqSlxsyOLxdr8Kbf3gh7Kb1Dp0j?=
 =?iso-8859-1?Q?qsoHkwX+aKmoSgDdB6JNOaevh49nkuJJ9FSEK7hrPC/DTF5QAkRM1B9OYs?=
 =?iso-8859-1?Q?hHCnaRndy6pTlIujKsOCaI3pApPYFonqcr35LFevAGDFziIRzQz8yJV8WS?=
 =?iso-8859-1?Q?W6FyUOYomc2hfJsagwovy4ZcK8QzClDYQ3Y+1ZgU7g3lT99exl8ZV76uqL?=
 =?iso-8859-1?Q?J8azWHpdUFS1UGN8yLljN/rPRU6fpTuXJwFY91+EmO4dE29aVWa5TeLWze?=
 =?iso-8859-1?Q?0gCwTCHT9QCUsxsdbIN7XJCkt6ydS/2z4HMxiqPOIqitvuCop14i2QYTMk?=
 =?iso-8859-1?Q?rzTodS2bPc3/hL5YzmWyOtE5cA0G9J9N9u9TKYAV4QTSGDjcZDCXKoe/AA?=
 =?iso-8859-1?Q?5Pgw4Kmro0Vmg09D/1yEzon1cd5fwotmEkssWleCk+aKLdkMXpFIuN9IAE?=
 =?iso-8859-1?Q?AyXq1uZwSbJJBKiwAzFUlLh7xgMVfTaAnzxftyq3DIGxD3kSnsTuhEWRr5?=
 =?iso-8859-1?Q?mhbBvvXT3UH+wrIsaOkDSHzpdYy7hP96yqRhoFOZtCnWCGv8ewKrwTbqrk?=
 =?iso-8859-1?Q?VTbInizBJJ3qt9Wvh1ld7LOT+76Jc96qA7sNpcUFlfcb/ZaLf+3gjmLAka?=
 =?iso-8859-1?Q?CKyL5Qpbfjmlo0XllB9v7fxSVreM0A5+Ttk7clZjFjoB7jwMefsjaf3QUv?=
 =?iso-8859-1?Q?I/NxF3BjX9/7TX4tbzAhmzWVb2cdiYez61pZrgVXKHQ66yfQZlDzKes1sa?=
 =?iso-8859-1?Q?GxyNHvv9ktNceXyHyj6+n5PiTAk0makyG37qH7SS/wYcfwdrWH/QCPTOhh?=
 =?iso-8859-1?Q?OsfxhiQlrAnTH2sIiTBL2eb72BVSm6DDnjmMcB7aBe4hOChRp4MoMQ2FgK?=
 =?iso-8859-1?Q?ePmzmg9EkVzgSpm+q3O9CESPtDX2cqoTfbdK8W9tbtna798W1i/SViBQ+A?=
 =?iso-8859-1?Q?tSbYCpslXUIWuZjfLpc+cdOb7Uw4hlfavkrKBKZyY/PIgfrs/fV/Y1O6AK?=
 =?iso-8859-1?Q?liZXzOUY7Gcqw1aFuhHG8UzUAyGwp/6mIs05hktkeSdZOS4BXla6ktbFSj?=
 =?iso-8859-1?Q?UGKCy62Z+RLBIHmoI8RuA3LMJD7FWfn/ggT1iNvMo/oRDVGbb/vrouYA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: seagate.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR20MB5058.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e542537-c7e8-4459-aff5-08dac32fd543
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2022 15:25:43.4583
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d466216a-c643-434a-9c2e-057448c17cbe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1JDjXFJUc0SJi6lh2vHE1WR5egmVcpkFiqW2Ypw/suqv+66DR4HhMfCA6slcJtx1N8N9VJ6U/gZVZdJ1tHjJlMdzb/np9/+Y3vyNI1+LMk4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR20MB3868
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Checking in on this series and what we can communicate to partners as to po=
tential integration into Linux.  Is 6.1 viable?

We have at least one big partner whose launch schedule is gated on these ch=
anges.

Regards,  --Arie


From: Paolo Valente <paolo.valente@linaro.org>
Sent: Thursday, November 3, 2022 9:26 AM
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org <linux-block@vger.kernel.org>; linux-kernel=
@vger.kernel.org <linux-kernel@vger.kernel.org>; Arie van der Hoeven <arie.=
vanderhoeven@seagate.com>; Rory Chen <rory.c.chen@seagate.com>; Davide Zini=
 <davidezini2@gmail.com>; Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH V6 8/8] block, bfq: balance I/O injection among underutiliz=
ed actuators


This message has originated from an External Source. Please use proper judg=
ment and caution when opening attachments, clicking links, or responding to=
 this email.


From: Davide Zini <davidezini2@gmail.com>

Upon the invocation of its dispatch function, BFQ returns the next I/O
request of the in-service bfq_queue, unless some exception holds. One
such exception is that there is some underutilized actuator, different
from the actuator for which the in-service queue contains I/O, and
that some other bfq_queue happens to contain I/O for such an
actuator. In this case, the next I/O request of the latter bfq_queue,
and not of the in-service bfq_queue, is returned (I/O is injected from
that bfq_queue). To find such an actuator, a linear scan, in
increasing index order, is performed among actuators.

Performing a linear scan entails a prioritization among actuators: an
underutilized actuator may be considered for injection only if all
actuators with a lower index are currently fully utilized, or if there
is no pending I/O for any lower-index actuator that happens to be
underutilized.

This commits breaks this prioritization and tends to distribute
injection uniformly across actuators. This is obtained by adding the
following condition to the linear scan: even if an actuator A is
underutilized, A is however skipped if its load is higher than that of
the next actuator.

Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
Signed-off-by: Davide Zini <davidezini2@gmail.com>
---
 block/bfq-iosched.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index db91f1a651d3..c568a5a112a7 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -4813,10 +4813,16 @@ bfq_find_active_bfqq_for_actuator(struct bfq_data *=
bfqd,

 /*
  * Perform a linear scan of each actuator, until an actuator is found
- * for which the following two conditions hold: the load of the
- * actuator is below the threshold (see comments on actuator_load_threshol=
d
- * for details), and there is a queue that contains I/O for that
- * actuator. On success, return that queue.
+ * for which the following three conditions hold: the load of the
+ * actuator is below the threshold (see comments on
+ * actuator_load_threshold for details) and lower than that of the
+ * next actuator (comments on this extra condition below), and there
+ * is a queue that contains I/O for that actuator. On success, return
+ * that queue.
+ *
+ * Performing a plain linear scan entails a prioritization among
+ * actuators. The extra condition above breaks this prioritization and
+ * tends to distribute injection uniformly across actuators.
  */
 static struct bfq_queue *
 bfq_find_bfqq_for_underused_actuator(struct bfq_data *bfqd)
@@ -4824,7 +4830,9 @@ bfq_find_bfqq_for_underused_actuator(struct bfq_data =
*bfqd)
        int i;

        for (i =3D 0 ; i < bfqd->num_actuators; i++)
-               if (bfqd->rq_in_driver[i] < bfqd->actuator_load_threshold) =
{
+               if (bfqd->rq_in_driver[i] < bfqd->actuator_load_threshold &=
&
+                   (i =3D=3D bfqd->num_actuators - 1 ||
+                    bfqd->rq_in_driver[i] < bfqd->rq_in_driver[i+1])) {
                        struct bfq_queue *bfqq =3D
                                bfq_find_active_bfqq_for_actuator(bfqd, i);

--
2.20.1

Seagate Internal
