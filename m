Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98F83693666
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 08:52:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbjBLHwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 02:52:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjBLHwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 02:52:10 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 777221353B;
        Sat, 11 Feb 2023 23:52:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1676188329; x=1707724329;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0E1Gt/+FiG+CiVsSDQJ/BTXLWdA1fCoRpTzCCQaIe4U=;
  b=dSIKS2OpY32jT/vyL2Pf4SC9jl4IFHopfn0EWTak2moWOnD631UrewEP
   eQjXvEk/MBFYdyFMzfQuu+QHIiYLCKrV4MPT4WUOKZeMIM6y+9IpK7aGe
   7PMVFqL/dCOMU7t96wM8eL4wA/WVteamok+4AX9F9egj03g5c4tlPIT6J
   YPpC7mRvZe+13f3ysRlAEKMJ9sdrXiO9pHXQ/+MKO8q7W4ZsM0ImGdM2H
   KEZ/1KYsgLGKgYZiKJOM9LJBaiq6oUCXmhOuwyfHNQFilWlQDvGQLCIZj
   WLx4Q4NOlT1X0/5p/s1ujHIBB3MkVHEyqqOFRk5efEnEaTCwPK1Ri0GIL
   g==;
X-IronPort-AV: E=Sophos;i="5.97,291,1669100400"; 
   d="scan'208";a="196499394"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 Feb 2023 00:52:08 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sun, 12 Feb 2023 00:52:07 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Sun, 12 Feb 2023 00:52:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NVdTm6vvOMcbzuwGEGs1gKBPxeAfYjTZA3nCsOZ/4qpxG6nLLDlpxo7UiiowkdqCutsduE9aLW5EYh5oyPFVoBfHj0uEwfBiCXAaVr5nT/htqnBnMJz8Flhi4L5rQFw4wf49A1jCzwTqEiuQPPTZ9v+aHDO4U0W+I7sg6PM7NZLpuSdiVB8w1etlnQy56iUkDSPGYtn4whGD37uFocdUHFYab0Bmr9kvp6caMl4x0ueAxWXxdDrsqflgghyrLo5AsgdSxZPIzytq5my4CWlXNvq9BRJJYAuHDWTlClCwuTi3w/6KTQWZNg304SL8zPo5eeuURlZ/XgVffY63yUUqWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0E1Gt/+FiG+CiVsSDQJ/BTXLWdA1fCoRpTzCCQaIe4U=;
 b=eoxSI7iV+0zFVHFFdBxZ6wk9/UGKjaXKL3lSn65AXtPGWMIHiMSEytyVEN/ZpcYGBJjulJgNLB2QTt8MKMCe2NUW6DArtiB3uqSBaBGD7CVdEgRJYuHsC5HooZCt3waf2uywfQTwnwsoFb4CN0YAnUmCkw4KsGPIb1WLtdqPTPzSjS6Dl0VT7R5BPxkgqjfNgKViJmaw5CIdVeG1pJK6o9G1KpXawk/FTDcFPyuCf/cIlWDYmIQqk2mfQUTF3ha1wxDfAxDCv86h+qV3VNIDLWrsuNGlwHvGd/XpE2gTZZqlef1RXS0C4fT0fTQkprs0IZQ4aYH8lXjIQdTIBk/nyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0E1Gt/+FiG+CiVsSDQJ/BTXLWdA1fCoRpTzCCQaIe4U=;
 b=mtYF6dML5xBj1TvRb8ye30RYkQ0KLYoUT6dTCD8pcnMM4UwuLXO88McG2qv9jnkFiEqm2ZFY5wDYvTBb7ezePXxnIYhLCHuNuwh1bhjDa1OqTAnUqJ5QxA3mAAXu34DZvFaAXgiklyM2RQdhZVzJYefdGBZJxDX1OFkAr18mAH0=
Received: from PH7PR11MB5958.namprd11.prod.outlook.com (2603:10b6:510:1e1::22)
 by DS0PR11MB7683.namprd11.prod.outlook.com (2603:10b6:8:df::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.22; Sun, 12 Feb
 2023 07:52:05 +0000
Received: from PH7PR11MB5958.namprd11.prod.outlook.com
 ([fe80::cf2e:97c:7f47:9ca6]) by PH7PR11MB5958.namprd11.prod.outlook.com
 ([fe80::cf2e:97c:7f47:9ca6%4]) with mapi id 15.20.6086.017; Sun, 12 Feb 2023
 07:52:05 +0000
From:   <Tharunkumar.Pasumarthi@microchip.com>
To:     <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <arnd@arndb.de>, <UNGLinuxDriver@microchip.com>
Subject: RE: [PATCH v5 char-misc-next] misc: microchip: pci1xxxx: Add
 OTP/EEPROM driver for the pci1xxxx switch
Thread-Topic: [PATCH v5 char-misc-next] misc: microchip: pci1xxxx: Add
 OTP/EEPROM driver for the pci1xxxx switch
Thread-Index: AQHZPpY5D8pOvjRSE0idcTrTWegJHq7K5KqAgAAKI9A=
Date:   Sun, 12 Feb 2023 07:52:04 +0000
Message-ID: <PH7PR11MB5958E97602E314350290B54E9BDC9@PH7PR11MB5958.namprd11.prod.outlook.com>
References: <20230212035743.231353-1-tharunkumar.pasumarthi@microchip.com>
 <Y+iQnfR65M0El34R@kroah.com>
In-Reply-To: <Y+iQnfR65M0El34R@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB5958:EE_|DS0PR11MB7683:EE_
x-ms-office365-filtering-correlation-id: 6d020b50-d002-4367-440a-08db0cce088e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iQkeiGAajWbYj/VAU+ixc91v9nmEGTHdlIpnBZv8GDPzM5SUvpQjcCg0vbBPlOQbhRhrfm7oxziuVHZlkBN/juY3doT9X3OMnszBuEpyo7QHcRXpDkxl1yuG1vE0gLYQzxMdH++uXrCpvCiX/h7FvFyH3tRFfl137FNTuUfeA/dE7Jc5xwynqgoNOcXTdBa2L5QX4Ld/wkO2PPD8/7szRccA7jQ7kSdeh24FJYvsGpNFDUhWlStfetSXefxYgZnKoh4xyx2LPTooHo7a1+l4MAcKu6KVfRYVDNI7qKOBc50o2Xzw6VsTiMdeyRPOce4mx0EUTW9AUnSxu8h9K1vuL97JyltFF8yaBr15PqcsQmsZ0XDamkuTF3qk0VGuHy0fZpNvBxucAG/F/jcklo6MoNA5/6+Ec83E6IDX8OeEeFvcjHpCsFi/A/Z190m4u5XX3c8r0So7/UYfpMWdNdbpMh0s/4UUNEetsHeJR7vkO8VK2FT7eJ1lB8Sq06Y7j6GHwJmJO44+JScu1OKcTV6IPOu3wmaIXIJG7RCO/UYDS41DvT1jktWdcgRO+F1+ni6SrfoPeYR5E2AS17+foiRtlGfBYlLdnmipfWVv+Se1lP1Hf0Xc7WaRQIO7NycrLW03TnqaJiR2omNTXeE7tLMTapgj64nb1tLKdqojBLlSlKohSyjbUdAAN+c1QekqMT7Xd0WnbSqa41M+B0sJEa3iFAcl4YcXhLN5/7gquvAoL3Y=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5958.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(366004)(136003)(376002)(396003)(346002)(451199018)(9686003)(107886003)(38100700002)(122000001)(316002)(54906003)(33656002)(71200400001)(7696005)(478600001)(6506007)(26005)(53546011)(86362001)(55016003)(186003)(4326008)(66446008)(6916009)(38070700005)(66556008)(66946007)(64756008)(8936002)(5660300002)(4744005)(2906002)(66476007)(8676002)(76116006)(52536014)(41300700001)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lEaL6G+tyicmhkv5PwTw1JLKH8lKpJZH2kv3OYc8FOy8WWPTlYiMP3LLDVAT?=
 =?us-ascii?Q?XhIqkbMEwv/jKNVsjwF5cEQSZP9Jxg6QRLBFe2xBi5mWvi62+FaQlVnorWlt?=
 =?us-ascii?Q?C4TsXLz2ZqBrVANm3pOeCJQjpAL2oirfLyHvze43zcnXV5hQxRufpVyNc866?=
 =?us-ascii?Q?tV1QaOUBKw5yIXIl+S19t7wLIUpe/B1UpaVfYi9gpwp9Xa5cKMYGZlvlzGlP?=
 =?us-ascii?Q?clkvsqmNA1tLl8U8gcSqpL5auG+zDQWjTMAIXqIbtTQTMxn3M8qmHLiQOmY5?=
 =?us-ascii?Q?xZB6w7gUrf7lJCE/fvZs+AmiqxpTXpe1ZR5jS6f2F0oxGZCfvuxLoVTKYteK?=
 =?us-ascii?Q?E0nay5eCt2SZ1JNuCI2MI6L/BBwBt0yrIsrVi8PlwFjz8aHJ+Y5YGExIcyZ5?=
 =?us-ascii?Q?hTn63tLlhprDh+VBYzcxhJ67cCPWpTSQd07Ni+uBbjFPjs4zBKV2N4vylLxj?=
 =?us-ascii?Q?vuZ6EbZU+UdoWc4EWsA6ZG5CHIdakwkTzHHB13s7ND4fWB4jGzQvae2lSIo8?=
 =?us-ascii?Q?N07KLuB2BmUkPpiutjQtb5vvFHwsyq+UgjvGmAjJqGs3zzIzESI4zrII1gfC?=
 =?us-ascii?Q?r7XKPLwkAtHdlNvTo8PKIn4bk3AaDXkUaGopQU56hL6myVX7EeoSg/KqQol6?=
 =?us-ascii?Q?luQKfguxA4sY7kG8oF9e+z0cKM7/q7cJwD+XAk7lNIA+1Wu+61IaGiV6bd2u?=
 =?us-ascii?Q?GQb8WpcYStXlBM9Eq4pCnrzylFEcTInllSFo7zJ9OVxEsWiywFjWKfO8ej90?=
 =?us-ascii?Q?MQf2dimwLzHAd66UYVDC1iUvOB49VmjFgsZ2rJ1pBdi1QXlT2tiaaoGUZ4bw?=
 =?us-ascii?Q?xuRCIvfDEBtMfXlj6cgiksGeOigoci5PW3PY+PpXwWpRMiS2h8jMd1H0BWCU?=
 =?us-ascii?Q?oELq9lgkJIJam63FH0KdCntrNcQbzltuWr+9/bi6DreQGElVzFsc5Tr9T8lo?=
 =?us-ascii?Q?Q2i+M5fSBh8OTuyASq1LGkMaJpL3r0XedBCwTPN9/HKAKYjj38nR80rw6kMU?=
 =?us-ascii?Q?4SWubwO9MY7IrdZxCGbEbc79ubFNUHU9z5SCRKZfTc4gya7sMjR/C6pzsBcP?=
 =?us-ascii?Q?uTYnSv3ycQ+Yf9ZHbGstkCp58ux7kNrKVUtARgVtEKRXiHPhbdO6Y/gqinV6?=
 =?us-ascii?Q?EPrLTUo5dpcYKTw7b46ILQ0pY7Nnk0Xlufe4wrEYOOBx0mVTGj5ymyDezKyb?=
 =?us-ascii?Q?3Iv48DGJ7OeoKzsg77Y1Q3u35lNR2ZHINMlGyDFwfnzmJQPRTmvhTyrHIO7z?=
 =?us-ascii?Q?ejysabw41n/tIcBhY4k5h8L3E/iVEJ83QYFjr3uMMWo+6/bdRW56zTeRy1pg?=
 =?us-ascii?Q?+hb3HVIPePHyUKE8Nak1mS62cohEwSMTbvEsyBDq2q1cjxeGava6NBg5eOeJ?=
 =?us-ascii?Q?z7SgSyYBWCz6wQSihmKtZJNeLssB/cwd/L0NVaEtZW1CtpEQqy81XYCDjIvl?=
 =?us-ascii?Q?9V957HVwHTpcqKaFu32a6qEVDWFx/SF2K8AyPn6eHGWhqzqPhh13ywXpYRWd?=
 =?us-ascii?Q?ojyxlaFBvav0+ysC2Tf3DEkMJBrjcNbLn7LLJ+j/0I7hM0PG4dFYhEtHdyza?=
 =?us-ascii?Q?NnidTJxI1wG0H67XUEANbI47w8EFlsL6rJr8Du9XsDFo0p6V7VaUo7VRtXiP?=
 =?us-ascii?Q?EmA4ZOXLXUytJ5fe3M8a25Q=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5958.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d020b50-d002-4367-440a-08db0cce088e
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2023 07:52:04.9082
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BDJVyRZioyUMj+q5/EWCvelHYze50TgAxXcHpK6LRzdyKeHVUO9fbKUCq0+Qdmn6uHXQo9sbjF4rm/q7+QbDZeRwV5kcO6mmqAM9d1j3+I2Cp5UN2GBG+v80SrQJxpfF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7683
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Sunday, February 12, 2023 12:39 PM
> To: Tharunkumar Pasumarthi - I67821
> <Tharunkumar.Pasumarthi@microchip.com>
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e
> content is safe
>=20
> Again, you can not sit and spin in a busy-wait like this with no chance t=
o
> recover if something goes wrong with the hardware (hint, what if it got
> removed?)
>=20
> please fix.

Okay Greg. I will add timeout logic in driver to break out of busy-wait loo=
p to handle cases like these.=20

Thanks,=20
Tharun Kumar P=20
