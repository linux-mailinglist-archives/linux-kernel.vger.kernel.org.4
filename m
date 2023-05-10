Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D1E46FDB6D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 12:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235265AbjEJKOb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 06:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjEJKO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 06:14:28 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A3241BCA;
        Wed, 10 May 2023 03:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1683713663; x=1715249663;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=VWpUFvQJU0uDL6SOQp8A7VXx6pKragw4c6r9QdEoe0I=;
  b=bye76LZdiQDft7tPSENr5NatsjlhG3NPWh9nE2vJSq75zUu39s6uXN52
   0NAO4IkjAa32NJzMyfpRzGlpeuBJ8yIMQBY8qwHp/RKOH6Dn9AhyxMJ9/
   mtzStlBTQkc5TUokllCbee6eXkfZUe9ugDaQICvHKWdPZbZvJXsWMHvMc
   Eaqtfo/Xzrw+w6IRWT2KvWvo9JKwQYDZtxnA9Iboa1lSCkhFlhTWofgyp
   HsFBumEq+xmAFQBTK/NT2nINSC0jbk5/p0HHRd0HXlzpMQPf0Ez6G/hng
   bFtphRZz3pFW7depFssQhI45vdf+ofvHc6ZHY5ajao0rjQJBEsn+u4WUj
   A==;
X-IronPort-AV: E=Sophos;i="5.99,264,1677513600"; 
   d="scan'208";a="230371924"
Received: from mail-dm6nam11lp2176.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.176])
  by ob1.hgst.iphmx.com with ESMTP; 10 May 2023 18:14:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QgmOiMPlKiX6blnU2EzHcpebKGDYbEyzu9VK9E+7mfpSx6Glaj4FosV+v0fCahHstX9R7Ue8yTS8o0qCjTMIeT0Ra2pkzq+GC2cjhCyo7Z+DjfWh3qYDM2V4UMeQkav6JS0Qc49KHxLxz7OYPCXfPc5jGe0QAe4m7YaK1G3Si6WI11Y1ipPhr5ae6iEdupTT7l/hASq1QuMWWv75vJxgTdGGDG5ZhZZ53xjTbswl3sIZbq2UgYcqpEPr3xe/HhYmJsIB3SvsWVYy4jd02P3ASeg9jG3iyJGzCYvGmVIepLdXDLZ/5A7WEMbhOLmt6OyDj9upB721ucs1BRIygdsc7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VWpUFvQJU0uDL6SOQp8A7VXx6pKragw4c6r9QdEoe0I=;
 b=IsI1rCLKzZr1oPc0WutXIlwKWek7gqtJfDdVjy/DNKaCluD25XBIarto+uejQICY1+3YCVXIq8Den/z+hX6JEl5am8jhbKWSHwpMGHyHC2rsAxYHoJ9RU/4/Sl5+FLJP4fIr1xVUE/5q6zaYy4gDMmGrU0BcBxgsLUoA7kFVGumG5SE4hI54y2SuWk+BF/UdYq7bKHJcCfIFuiCiWOcrzZwoemchhxTu5YtNK2y8n47hW2nao8vQHMxNLsaF5GmWWq5GDIEZEQH83yNQgCa70epJEGnnB138LiRcpM6TpY/diaFUD9JCvve29OSkTjk+mbAcvZhY2OiK56/WmrcT1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VWpUFvQJU0uDL6SOQp8A7VXx6pKragw4c6r9QdEoe0I=;
 b=W8NVI5FwSKhHCAh34xVosLswqLm7txvunsz5koFRhqEeRIQ1IqKcZ8tCCF9YmLebEadWnZYFlyNzTeP8M57IF8lYTFLcFKss3YJvFXkA7VgTk4//Pxa9UZCa/wd684vKTCoOBQXcMDuTK4GFSDGowWrGcYedmNeQOEGKvlyqB2A=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 SJ0PR04MB8421.namprd04.prod.outlook.com (2603:10b6:a03:3d6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18; Wed, 10 May
 2023 10:14:18 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::188b:9005:b09b:81e2]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::188b:9005:b09b:81e2%6]) with mapi id 15.20.6387.020; Wed, 10 May 2023
 10:14:18 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Kiwoong Kim <kwmad.kim@samsung.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "sc.suh@samsung.com" <sc.suh@samsung.com>,
        "hy50.seo@samsung.com" <hy50.seo@samsung.com>,
        "sh425.lee@samsung.com" <sh425.lee@samsung.com>,
        "kwangwon.min@samsung.com" <kwangwon.min@samsung.com>
Subject: RE: [RFC PATCH v1] ufs: poll HCS.UCRDY before issuing a UIC command
Thread-Topic: [RFC PATCH v1] ufs: poll HCS.UCRDY before issuing a UIC command
Thread-Index: AQHZglDu43E5t3NkAkm0mgEOIPPd169TS1eQ
Date:   Wed, 10 May 2023 10:14:18 +0000
Message-ID: <DM6PR04MB6575DFEBFBE75610D9613220FC779@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <CGME20230509083312epcas2p375f77d18a9026f7d263750baf9c9a5bb@epcas2p3.samsung.com>
 <1683620674-160173-1-git-send-email-kwmad.kim@samsung.com>
In-Reply-To: <1683620674-160173-1-git-send-email-kwmad.kim@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|SJ0PR04MB8421:EE_
x-ms-office365-filtering-correlation-id: 1bff5b6e-4544-406d-a827-08db513f5111
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cSk94JthR4yV6c2jex5Edo+nKP6wRUbdKu4+vHO+gMWLuPz3oDD5eb+jlL6Vul/mpDPGJyh6Ot01TupaOVcGL+T0j0/yZ9bBiWQ06nbrE/Vfk0bVeOy/Y9gi5xgleZOJyboIuGB+qNx1yBkKs8P8SMUZf3S79eEhG7GLMRQizmR79IruDkM16/XqnbnZnNGhoBdBBcB9NxMrvCF9osEOeBrtKMjG9HA+9HdjXuu0Kb4OSIXzb4w3AAuHxluhHJRPVTtnpeK98po61WnmnaoTz0l3rzkSx4O5lZMbfTRGFmkF+6xxdVqiL3myh1Y3shGBz6rmW5mAXhwZ0RoBwZDasxA0OfO1+XBIcNQgMUVuKUaf4JZtwzIqDLzCEMwva6g83whoU0PhSTCWv/JiI2oSMwU3vWZlJToz2gQ+TG8hdEuCC3ye38oQZNC+ci10wG2azrVDChrPHR11e+BAddsn9kdC8Y3SUYd9OrX/lfyiPFcc+kNOfFBOZRYCKxfDBfYRplWvkIr++nr7ECUoAoWGFOPeVe16ZcMRTUeCUhOa8SQv9aq5y4i77CNNj/rAZZK4WkDPVJDhPUm2VhHOPByW+PWy+jNc1+8x9ANU36SDIeXn4EHvbaW5TuEOzXCZNvZG3HKQrsiluM/tTIWlgi52rqvLttM0ZR5VhzqyKlPkgQ4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(39860400002)(136003)(376002)(366004)(451199021)(66946007)(66476007)(76116006)(55016003)(316002)(41300700001)(66446008)(66556008)(38100700002)(110136005)(64756008)(921005)(83380400001)(82960400001)(38070700005)(2906002)(5660300002)(86362001)(8676002)(8936002)(122000001)(7696005)(7416002)(33656002)(6506007)(26005)(9686003)(52536014)(966005)(186003)(71200400001)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Qm94VEFzYW9PZVFtT3l1R1hpMmFFM3ZFbVFMdDFPZzk5QllvU3l6SGRjY1FC?=
 =?utf-8?B?S3dNb3RDWVc5dVFNR2oxZ3R3QXQ3eVd1QjNKYUFkeGY5NVZocmUzUHlKS3B4?=
 =?utf-8?B?cGxxOHJ5ZHptcUtLdlhiVE1vcUhkZXkxUlhxVzdDOUwxcFpGR2VrVVRFcGx5?=
 =?utf-8?B?S3l5MFpvS1RmcnlXOHRHai9tVkI5OUJZRlFMcnhSSjNYTmlWT1RDeUxRZlRB?=
 =?utf-8?B?MWRqSHJZcjl0MStBN05DMHI5NEgyOWlVcXE1OE91K3JELzN6NVdLa2szenVw?=
 =?utf-8?B?a2c4L25vR0ZkTm9lVmhrT0haZysraDRNeHpKQ3IxZkNLRnF2aS9jTk12MFFi?=
 =?utf-8?B?UGNKampsMVNUSWhBOFd5T1N2QzY0Z2wwd2lNRUw4S0NBVVJnMGpWUHV1V3Iw?=
 =?utf-8?B?aFJyZkJ5ZzlRd0RqaG9pMEV1bFdSUHYwYVlmckl0TCt2YWlKcG9wMnU3Yktl?=
 =?utf-8?B?bzY1cnd2ckF5U0o1Um9OWmNPc3dSbzNoMUxFL3pSV3l1L3NTRkJHYzFLVUQv?=
 =?utf-8?B?MFY1WXczVWY1UDdQZHBYVytDbCs5NlRRaUh0dlIreHliS3NyV1NQaCt0WGRV?=
 =?utf-8?B?NW9zd1BVUDJ5MTU5cjMxbkRhdk1aenNha1dNOCtUSjFPNXJHVVg0cWNnUzFW?=
 =?utf-8?B?SXFHYzArb0ZOUTFxRHkwQUFJMFRiNEZaNXg5a3I3L1BCaEZWOVZkM0wwcGxn?=
 =?utf-8?B?Y1p4NnY5dTJSeHVrd21hSGwvdC96dlR5KzFEMjdnRWdjMVRTNTJsY2FJUm4r?=
 =?utf-8?B?WWF5QTg3U01HUlhqaVNCd2s5b0FScy9FSmZlWWZjc244NzFsajJrU2JYenJG?=
 =?utf-8?B?enYvMG9ha21LUUdVeDJRN1grbUhaemkzWEhtRGpkYlB1bDYyYzFNcE1iOXdh?=
 =?utf-8?B?ZzRBSXJzTTVRS1g3ckxiZlFWckdMdWlGVFVxaGN6Z01GWi9IOHo4NHU2U01U?=
 =?utf-8?B?UktTYXU2V1I1aHhFUDArdlJKeDdjUTh5dUIvTi9hdmMxYkZQeExQeUp2UkVh?=
 =?utf-8?B?QzZqVUdpUlZGMzBzYjUvaG1vZHBNNVprcUlZUDQvTjVzWVRRZ3ppZUpoSUdG?=
 =?utf-8?B?ald6Q2NHSVdmVGFVdm5BNGZsc3pTWHVTTUZlaHpjSXdBcFpGSFVyaGJpdHhi?=
 =?utf-8?B?WDNQcE9iZTNJWEpJVDl6M3VwYXJORlp6MmJVemtIa1RLVytwNW9pQWF1bVRr?=
 =?utf-8?B?ekZCbzdHM1RaMzhmR25TUkI3QkhvUm9QQmJGV0lGQWJMSTBnd2NyMEJ0bzlq?=
 =?utf-8?B?SjczVkt6SEJyWWNPa0wvZEVRSmRON3pxMXJia1Y3TmgwVytyNDRMY1RUWnNT?=
 =?utf-8?B?K2NLUUZac3A5V2htempOYWFBRkgxRHpzQU9RNjhlUFVPV3dibzRiR3I0Wk5l?=
 =?utf-8?B?d1V6T01QZTYrRDdnaHMvNkFsOFZ4Y05ycHpyODB4WkFFZ0JRNHV4cHlpRG1i?=
 =?utf-8?B?Yjc5akFnVlZzTGFraVNSMEw4ZVloN1JBVjJHcytsZW5HNVhVQVJOQ2lxVzZv?=
 =?utf-8?B?TkhvTGkvcHZ5NlNzN2ZRVXRuT01tdFF3dEQyRk1aZmd0YTNUOWppeGZDd3Vm?=
 =?utf-8?B?Q2UwcHAxOVJxeHl0K1o2VzdxVENsd1hSQUR1ZmtzOXBqUnZuenFnckpNMnNh?=
 =?utf-8?B?Z2JLRUE0Qm1EdE5QN3lxalhNVWZxdEZBd3BKUldKQ2JhRkJUaTRLRG84ZURr?=
 =?utf-8?B?eXUxS1h5NlJnZUpoNEc1aWgycVdvWHU1RVJsV0JtU2FyYWJuSk9VNThhVGRF?=
 =?utf-8?B?NU9ZQ2RtQXRBNEptZXRnTGhKZG1qWTVMd3oxVkVKQzNmc1c4c2hXR1NIazNU?=
 =?utf-8?B?TWRuVjloWUtHWDB6NC9KNDVjaklGR2owQzBMaVk3Ky85azRjZlNDQTczYUo1?=
 =?utf-8?B?UW9zWE5UVWh2Zjg0MXdlOUYzU1RFUFcxVTB5L1ZZc2xqa0FHeWpPbkJGYmRH?=
 =?utf-8?B?UytOUW9tTTNKRlhhMzdxd2NIL1l3TnE1SGF0eTQ5cXZGUXdGTDB0eG94Q3V0?=
 =?utf-8?B?Z2c2Ty80eGNSMWRLTnBLYTJSRUk1OWRKVzVkMjIreTZvMFgxcGI5WElDQjJs?=
 =?utf-8?B?RjJ6dU9UN0c2TDBJM0NaWFFMSlQ5NGp4SEp3UzJZeXZiTnlpQ05mRUtqS0Mw?=
 =?utf-8?Q?ZOW24iYY94SZIKHzDuUiL6Jo0?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?M3ZYcVUwdlNNRGtZMUZ5ZTNEbUhCejN2SUo4SC9iakJadndFQUxRS0ttSU5q?=
 =?utf-8?B?SUhUVEd6Z0VjMnBGM2wwMUxrK1hDTGdZM1NQdVNDMW9QUnlDN2EzcnpldzlL?=
 =?utf-8?B?Qk9naWRyM0hUcWJwdEVZN0JKUzdaM3I4aTJRMi9hZVFOZThhQVFTaEU4cnNH?=
 =?utf-8?B?eDdMQUpPNUVmMmo5VzUyS0orZGo1cnA1MXlpWWNhQ29NOE5zSmtiTEN2QzNl?=
 =?utf-8?B?T2ZWbVpBcFBUcEdKUWVxcjVRVzVMYnRrY0xMeTN2dmhpRnVwdjNIL0Z0YXNY?=
 =?utf-8?B?aCtSYnMzUVFnaGdRUHFsUi91THozNjJoZHBWYnlxOThqZzJaVGEzYTJEa2do?=
 =?utf-8?B?aEQ0Umc0cnZxbHp1WG9XL25HOFFBbUUzMkNyblBJVDBSNDhJRWM4NFZjNU0r?=
 =?utf-8?B?Q01OZFhpekx5T012c29FZnI2RmxoZGhhdzlVNlpLVmZlRjN0VFJGd25SVDBF?=
 =?utf-8?B?MlJSdG5QeFNVN010Y25YN3ZKNHVkQ1BvSHUva0k3VkVPa20rZExwcGozaXVF?=
 =?utf-8?B?SXRzeG9tMzB1SzdkVzF1UE5od21GWThYaTNmMmVNZ1BwK2MwejlYVlBGZTlI?=
 =?utf-8?B?TEFReDY0SG5IdjFZbUFHeTFvRklJNG5OeURjNWR5SVJoNmltdUpNQkFnVTZp?=
 =?utf-8?B?SFpFVW4rYXF6VzZ1RFd2a0hZMXJnVVBVOFYyRGFJZVczV2w2ZElLZnI2N0Zi?=
 =?utf-8?B?dnV5TFk4R2plUzdTall2eWVRM2NydEJ6ODZ1Z2JNYXlWUk1KMG1rN3JaWkIy?=
 =?utf-8?B?Rlp0cU03SVBhZ1o3elB4MExNOUMrUmV2Uk5oMGxWUVJ3R2QzZjcxVFJ5bXJ1?=
 =?utf-8?B?OGRScjdwMDNPc2d5V3hYNXJFZG9NZXdYaTk2ODArcUtoaG53N3lBVi9tVkFE?=
 =?utf-8?B?SWt4SmFFTEpMK2cweEdXUjJDVWl2eXh1OThEQ01LUStNSkg1a2pvNlNUbkpJ?=
 =?utf-8?B?MEJLMUg1bjBTamN1cksrbXhkMEJRQTV0NiswRGNkQzRQOWlyTHJBeFZDcm5q?=
 =?utf-8?B?UEZCVDdkejNXeFVva0p2Qkk1b2YwWjlwZ0NSSmlOcGl0UWR0cUtDYnFwQmZ6?=
 =?utf-8?B?K2FseTFnajQvMEpUa2dWRlFhSEtlTVdqbXVHK0c2QlFhQWpIUXhiOHMvUXhE?=
 =?utf-8?B?K1Faa1NmaE5Pd0VIaFZMME40NUJ6ZW4rakl0azFnUEtnc2c5YlU0Qm9hMjV1?=
 =?utf-8?B?WTI5Si9VRHBFZXc1OWhVcXh2VVdzSEloZHQ4U2txL1B2RmM3SUZkcWxtNUl2?=
 =?utf-8?Q?uY2xyQV04KDE4LI?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bff5b6e-4544-406d-a827-08db513f5111
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2023 10:14:18.7656
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jAAJE/OArteM8CVuYHbNKlkYlBWDe6JcRvPuFOVCTygGheg1NdpSzOhaujO9g7iTaN1YmdkztU8B9qVRXm+hCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB8421
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBXaXRoIGF1dG8gaGliZXJuOCBlbmFibGVkLCBVSUMgY291bGQgYmUgd29ya2luZw0KPiBmb3Ig
YSB3aGlsZSB0byBwcm9jZXNzIGEgaGliZXJuOCBvcGVyYXRpb24gYW5kIEhDSQ0KPiByZXBvcnRz
IFVJQyBub3QgcmVhZHkgZm9yIGEgc2hvcnQgdGVybSB0aHJvdWdoIEhDUy5VQ1JEWS4NCj4gQW5k
IFVGUyBkcml2ZXIgY2FuJ3QgcmVjb2duaXplIHRoZSBvcGVyYXRpb24uDQo+IFVGU0hDSSBzcGVj
IHNwZWNpZmllcyBVQ1JEWSBsaWtlIHRoaXM6DQo+IHdoZXRoZXIgdGhlIGhvc3QgY29udHJvbGxl
ciBpcyByZWFkeSB0byBwcm9jZXNzIFVJQyBDT01NQU5EDQo+IA0KPiBUaGUgJ3JlYWR5JyBjb3Vs
ZCBiZSBzZWVuIGFzIG1hbnkgZGlmZmVyZW50IG1lYW5pbmdzLiBJZiB0aGUgbWVhbmluZw0KPiBp
bmNsdWRlcyBub3QgcHJvY2Vzc2luZyBhbnkgcmVxdWVzdCBmcm9tIEhDSSwgcHJvY2Vzc2luZyBh
IGhpYmVybjgNCj4gb3BlcmF0aW9uIGNhbiBiZSAnbm90IHJlYWR5Jy4gSW4gdGhpcyBzaXR1YXRp
b24sIHRoZSBkcml2ZXIgbmVlZHMgdG8NCj4gd2FpdCB1bnRpbCB0aGUgb3BlcmF0aW9ucyBpcyBj
b21wbGV0ZWQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBLaXdvb25nIEtpbSA8a3dtYWQua2ltQHNh
bXN1bmcuY29tPg0KSXMgdGhpcyByZXBsYWNlcyB5b3VyIHByZXZpb3VzIHN1Z2dlc3Rpb24gLSBo
dHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sLzE2ODIzODU2MzUtNDM2MDEtMS1naXQtc2VuZC1l
bWFpbC1rd21hZC5raW1Ac2Ftc3VuZy5jb20vDQpPciBpcyBpdCBhZGRyZXNzaW5nIGFub3RoZXIg
aXNzdWU/DQoNClRoYW5rcywNCkF2cmkNCg0KPiAtLS0NCj4gIGRyaXZlcnMvdWZzL2NvcmUvdWZz
aGNkLmMgfCAxMyArKysrKysrKysrKystDQo+ICAxIGZpbGUgY2hhbmdlZCwgMTIgaW5zZXJ0aW9u
cygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdWZzL2NvcmUv
dWZzaGNkLmMgYi9kcml2ZXJzL3Vmcy9jb3JlL3Vmc2hjZC5jDQo+IGluZGV4IDk2Y2U2YWYuLmZj
Nzk1MzkgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdWZzL2NvcmUvdWZzaGNkLmMNCj4gKysrIGIv
ZHJpdmVycy91ZnMvY29yZS91ZnNoY2QuYw0KPiBAQCAtMjM2OCw3ICsyMzY4LDE4IEBAIHN0YXRp
YyBpbmxpbmUgaW50IHVmc2hjZF9oYmFfY2FwYWJpbGl0aWVzKHN0cnVjdA0KPiB1ZnNfaGJhICpo
YmEpDQo+ICAgKi8NCj4gIHN0YXRpYyBpbmxpbmUgYm9vbCB1ZnNoY2RfcmVhZHlfZm9yX3VpY19j
bWQoc3RydWN0IHVmc19oYmEgKmhiYSkNCj4gIHsNCj4gLSAgICAgICByZXR1cm4gdWZzaGNkX3Jl
YWRsKGhiYSwgUkVHX0NPTlRST0xMRVJfU1RBVFVTKSAmDQo+IFVJQ19DT01NQU5EX1JFQURZOw0K
PiArICAgICAgIGt0aW1lX3QgdGltZW91dCA9IGt0aW1lX2FkZF9tcyhrdGltZV9nZXQoKSwgVUlD
X0NNRF9USU1FT1VUKTsNCj4gKyAgICAgICB1MzIgdmFsID0gMDsNCj4gKw0KPiArICAgICAgIGRv
IHsNCj4gKyAgICAgICAgICAgICAgIHZhbCA9IHVmc2hjZF9yZWFkbChoYmEsIFJFR19DT05UUk9M
TEVSX1NUQVRVUykgJg0KPiArICAgICAgICAgICAgICAgICAgICAgICBVSUNfQ09NTUFORF9SRUFE
WTsNCj4gKyAgICAgICAgICAgICAgIGlmICh2YWwpDQo+ICsgICAgICAgICAgICAgICAgICAgICAg
IGJyZWFrOw0KPiArICAgICAgICAgICAgICAgdXNsZWVwX3JhbmdlKDUwMCwgMTAwMCk7DQo+ICsg
ICAgICAgfSB3aGlsZSAoa3RpbWVfYmVmb3JlKGt0aW1lX2dldCgpLCB0aW1lb3V0KSk7DQo+ICsN
Cj4gKyAgICAgICByZXR1cm4gdmFsID8gdHJ1ZSA6IGZhbHNlOw0KPiAgfQ0KPiANCj4gIC8qKg0K
PiAtLQ0KPiAyLjcuNA0KDQo=
