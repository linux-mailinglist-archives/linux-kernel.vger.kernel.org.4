Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1902C5EDDBE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 15:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233735AbiI1NdK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 09:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233333AbiI1NdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 09:33:06 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63FEEA2618;
        Wed, 28 Sep 2022 06:33:03 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28SA50sX027349;
        Wed, 28 Sep 2022 06:32:29 -0700
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3jt1dpenxf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Sep 2022 06:32:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=niROfZJejiUeZMt5RTpVH+0246Od5p/usnwU2T6xo2rjTnrDrLiCBMsp7RMFIQt7CX4HISh0ohThl3Gh0PTFUXRHBp1pCoH/oL/Ql18NNB2l6hH/0JxpTEdAybd2eZuyOyONA8pLoD9Gl2XwMupMRP67QAmKjxrjQ7b2+k3NnpkeEqr9BL3OUAknzeLL0VbkA6taN30zKSiaqAjyCYgpsXOglu2FnkwMyXxUcZzuA7MxhkQhS98hlqyFhtU1s7SSWWjHZVriM52iWRoIcNyweA0CvEylQtro4iBtd1gBhnfXNolSxzPdGshQFw32Jk4O6rE1RSoCEuyr+i/pMvKZYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+LtQuZRb9L1ocIGHTVuZPNTlIOH2rL3acWrHMa5SJ98=;
 b=BUUQZQvhuLb2orcGaRWPjI1WuowR913blXLOq5abLnZpOaFJooVFA268+EqT3+YRxgclm7D3Ra8SYJJYC02Zc6sfULEMIHEaVCFkdIcBXjqhKDaGkhFp/KJQpal+OUdeHox2Hza/z9TBPKpuf1XcyKWJKYION981qEoPgGFNue44gzpnKRzeS27SyCThpEb94ukvf9vLhQqigXwdBqG6U2Vm/sUwyrAFNUHEqqXrz2rSoNJwIjvpG49ZwQ0bvofRXZ9q7j7EjMBQeVKSzca2iZB29gcwQ3Ww7LWALd80bGmMHAwNbMAd0xosV17wLDsGs0zgb4A/FRqWCntIH4jcnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+LtQuZRb9L1ocIGHTVuZPNTlIOH2rL3acWrHMa5SJ98=;
 b=VRZUXBX51ScZaab2wpNLDn3ybEo1uvfdzVlDT582MPOTdhKLQ1gm2wlsAZmT49rGQR2NOsY4TBXYkXvUPdVjIq0JLLZLrYLGjReesHB1d2jy0lLhFMgTWkyLA6nnvDzx4Nb0FlUQ3V3KQwVr7xcoNvuGDsa5bytDxmBfG3mZwe4=
Received: from BN9PR18MB4251.namprd18.prod.outlook.com (2603:10b6:408:11c::10)
 by CH0PR18MB4273.namprd18.prod.outlook.com (2603:10b6:610:b8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Wed, 28 Sep
 2022 13:32:27 +0000
Received: from BN9PR18MB4251.namprd18.prod.outlook.com
 ([fe80::205a:3471:8e28:a0fc]) by BN9PR18MB4251.namprd18.prod.outlook.com
 ([fe80::205a:3471:8e28:a0fc%5]) with mapi id 15.20.5676.017; Wed, 28 Sep 2022
 13:32:27 +0000
From:   Elad Nachman <enachman@marvell.com>
To:     =?utf-8?B?UGFsaSBSb2jDoXI=?= <pali@kernel.org>
CC:     "maukka@ext.kapsi.fi" <maukka@ext.kapsi.fi>,
        Andrew Lunn <andrew@lunn.ch>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "arnd@arndb.de" <arnd@arndb.de>, "olof@lixom.net" <olof@lixom.net>,
        "sebastian.hesselbarth@gmail.com" <sebastian.hesselbarth@gmail.com>,
        "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH v2 3/3] ARM: orion5x: Add D-Link DNS-323 based
 on Device Tree
Thread-Topic: [EXT] Re: [PATCH v2 3/3] ARM: orion5x: Add D-Link DNS-323 based
 on Device Tree
Thread-Index: AQHY0aLGopOOuaBmGkieffwpIACh0K301L3Q
Date:   Wed, 28 Sep 2022 13:32:27 +0000
Message-ID: <BN9PR18MB4251A251E516E3ECD35F4E94DB549@BN9PR18MB4251.namprd18.prod.outlook.com>
References: <20220427162123.110458-1-maukka@ext.kapsi.fi>
 <20220922202458.7592-1-maukka@ext.kapsi.fi>
 <20220922202458.7592-4-maukka@ext.kapsi.fi> <YyzPVMrfcOkvngxl@lunn.ch>
 <6dc27862f8460f875c31ad2de56baa9f@ext.kapsi.fi> <Yy2iqE8XgXe8qYd9@lunn.ch>
 <20220923180226.vmjcefxlujg2r6u3@pali>
 <74f2b413a617a4315cc34a0ef386dd8d@ext.kapsi.fi>
 <20220926122318.qmt4dnes7caua333@pali>
In-Reply-To: <20220926122318.qmt4dnes7caua333@pali>
Accept-Language: he-IL, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcZW5hY2htYW5cYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy1mY2RmZTA5Yy0zZjMxLTExZWQtYjcyNS0xOGNjMTg3OGFiYThcYW1lLXRlc3RcZmNkZmUwOWUtM2YzMS0xMWVkLWI3MjUtMThjYzE4NzhhYmE4Ym9keS50eHQiIHN6PSI0NzU3IiB0PSIxMzMwODg0NTU0NTY4NTcyMTQiIGg9IlNDU2haUnpjeE9Lem9nVnhTQ2ZzeEVUZmlBZz0iIGlkPSIiIGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk5DZ1VBQUhBQUFBQitIRGEvUHRQWUFXUGtLd2Vjb3pPOFkrUXJCNXlqTTd3QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFFQUFBQUJBQUFBNlBxZWxBQUFBQUFBQUFBQUFBQUFBQT09Ii8+PC9tZXRhPg==
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR18MB4251:EE_|CH0PR18MB4273:EE_
x-ms-office365-filtering-correlation-id: 970e346d-5289-43d1-084a-08daa155e2da
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K8EmeF+CrRtMyzG66xWMmEXqBiOFfKUmzD7MTv1NK+fRUj1Q3Sgt9BN925QMJaeAOak4t6S4XSMq1oVcfmRxiD2uCBJEkwKEupl5h/hrUhGjvdU+qwcisBeAhUjNwVtxQmPCenZLT+HrFha7kVFQFvntwKSZKzFOvxoorQphxPKt4hVSayIq/beA35ZT9BJiHdsCLWl+fhOr80z/WhU5zc6vGk3eZYSaaB5WjA4OlKUVLZYZoWUOs8Kpa/24IjHWXtX5xATGsmc8oDCdUMsw7cL2bOWmQixaTgdoiczcvh0WhKNyszLnc9xvJUypszNZZtvm7JY8zih1XI04OLHNduF7Q2eO4spGkmYC5hQd1ugE47UfLbr7Yg9cQxm+ig0vpWtvO7f7rzwA71T1uCWJEJfGpHs4mnE93Eu856T8Dd/PSJzb8smq0Khw+R0WDUVgvrXcWXVoRqFt2eL5ae8CBzQTGmZfDu3hwmCClqEiYCFb31ic1AD79wqn3eFYombETUw+FT24MOxk1nfk3kNzOLbRsYKfZqfVNNidxvKP9Qzx1geOLUHNz0tnDJZ69qCqBnsBcm4LlgNbqBw6XaVC/ZdujFMoHcz61EgnbJVXmxrEoVZydatf3iGPwe85dXJXa8d0A0ZRa6aaQd6rprfEDEujZ/RJ6tjlwh1QZp347Kw8nCqUNlKFa9Y7VODk2IdyfzSRImMYETbkCSOwiSjHwgljmFnH2l5I8yuCD+QnvQZ1phG3xUauP7NpPIonFaPo0ccYAIBirwT8nVQzjETbRxLpvo6DLL7HgZktttViMtltmJtPfu0MejIMzXbu3xJp
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR18MB4251.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(366004)(376002)(346002)(136003)(451199015)(66476007)(66574015)(26005)(9686003)(186003)(478600001)(6506007)(7696005)(38100700002)(38070700005)(316002)(2906002)(83380400001)(966005)(53546011)(71200400001)(66446008)(33656002)(54906003)(6916009)(7416002)(8936002)(52536014)(122000001)(5660300002)(41300700001)(76116006)(66946007)(4326008)(8676002)(66556008)(64756008)(55016003)(86362001)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZWJDRzBGUmNYQzV0dTVWTnJJbXk3YWJiaUJIMkJ3YVZPakV2SEZibW13Qnhy?=
 =?utf-8?B?dFdjRHFMOTVFQk4waXQ3MEQ4WnZqQ0ZQY3ZkZEtkQzNJWlVGWktJdCtVQnNX?=
 =?utf-8?B?RFduWjVTaUVscG1BK1UxTE5oK0pOTmx1TjJ0T0d3MUdHS3Y3VVkrSEdDSHNH?=
 =?utf-8?B?M05MMzEzbjhIZFBldHRiMmg0blVWRkFaaFhqRC9ZakMwalpLZWNSMjU3N1Fu?=
 =?utf-8?B?Q2xKTG1RZXFtVUVXNjJ4aFpMNVZNVmVMYUd5ZVhkakJneDY2eUx5SWRmTmlk?=
 =?utf-8?B?N25Cd2FJM1pidzhPL3FEaUNmSWpGdk5DelVBRmlET2NWc0tlTTVRMm5vZy82?=
 =?utf-8?B?WW5GQThHREJuT1lHa3puWTBMTTd6emJXdm1uU0wxb2xieWVaYXpmRXUzeUFD?=
 =?utf-8?B?dkRjaElBRTBsOTZTR0NtUlJMQXdteGlraytwSVlHazE1cG1JZkF0YUJkd0E5?=
 =?utf-8?B?OWJocFZVdkgzTWtKaVNJQm1wTTkyUyt6QXFhV3FML3ZZRmhqMDltNnB3eFY5?=
 =?utf-8?B?alN0a2NhMTlqeFB5SXFpN25lTENzbU1keXFjSHI5VWh6dnpxcm9DeFFsSUl2?=
 =?utf-8?B?Y2ZHSlV6WFVUZ1RSZjFPVG1GT1EvUmI1cml0M3E3VTNwY0pjMERHclAvaXRN?=
 =?utf-8?B?S3ZiVVBZdkRNRmJNWkRucGM2QndnUE8yWC9RNGFkQWcwaHdpU1p1SS9tL2I1?=
 =?utf-8?B?alExeUFoSTNqY1RvZWpPL2krYjlkeFUwMHNRLzRpSUpxeGhpZzBISE11SUNu?=
 =?utf-8?B?VTJJUEd2NE9aRis2N1FITHFnK0l0cXB1SU10bmVsZXNQQ0xzV09obFlzMDgy?=
 =?utf-8?B?RkIxcFgrZlhaK2YzMGwxODBJYThycWhvWlVyalBRZmtHanEzdkRCV0lKbGYv?=
 =?utf-8?B?YkVZMDBSWmoveEZyUlZMZ2VMMGdJRXJMd2FSQ00xaFpVOGFIVXljVGFBem0r?=
 =?utf-8?B?UmRCQTRMK3ltaW9TZEhlUm9iVnJlWnVod1FyOVBIMkpCRTBKN0pEczRHMU50?=
 =?utf-8?B?emdZbG9UaVZOalE5MFBWY0lRc09jWTVEdkI1MmpHU21pK0pBcmg5a0trWjd1?=
 =?utf-8?B?MWQ5aEhBcEZFSW80Q2sxcCtHQ3JmU2VxZTJZbFJhd0s4WUNOZDk0YVlsWEN1?=
 =?utf-8?B?d0VwSnZIRkQ0Q1pUaWVidEl3TXVjbkxYYzdUMXErby9VUzRCRjRLa2RIQ2xy?=
 =?utf-8?B?V1NYWmV6ME82RWRaTnUwSUlMcTFod1V4TEwwTWFaYmdLOUEzdEs5aXVZY29H?=
 =?utf-8?B?RmZvaWpSNGlhMXFERDlvakJodThKTnVHZWVQRnhoUm1zS0JwQldKbmdjb2Q5?=
 =?utf-8?B?cmd6aFZsNGlHT1lPT2J3VE5FODQzb3NqK2N6SC9NTXQ0dVpyR2FNSVVISCtr?=
 =?utf-8?B?QnJHTFNWSjRNaWFudFdwSjQ3Snc0bERKbEpURUdUM0ZjT2NzTGsrYWJXdWZF?=
 =?utf-8?B?N21YTlFUMEJ1TjNUTWx1WDk4aS9MVmRSbFdxZklXQkpVNkFtWngzalRUbUpD?=
 =?utf-8?B?dXNqbDBzSG9DTkIwcWtDNURmNG0zOGdjZlBkNWtrUUF2YURydmFqdHp3eXZM?=
 =?utf-8?B?T1FvaWlDQ1VPR3FyMzAzM3hrVFB3MUQxeWFJVW5UZE5IMnRST09iMzg3MkVJ?=
 =?utf-8?B?MUFxREt4OG13RFMyMjFzcUQ1Si94Y2Q5dmk0WXpBOWRqTXVEbHdYS3I0RUJy?=
 =?utf-8?B?eWJMcWR0aTJPWG90ek5qYncxQks4KzNhRHQ3SGErWVRhYUVZWFJqUk5ML0Vl?=
 =?utf-8?B?WjNtcHVMaXBYTkJIaml1Tk4zR2FySU9rdDQxQXM5VnNSS1ROQUxsVEN0TkxS?=
 =?utf-8?B?QW5TVkVnL1Y3YkFzcm52bnNjWCs1NXF0alpqNTJmZXc3WUNmYXp3Smp1MjJD?=
 =?utf-8?B?TkhHbGJnZzh2bVcvU1ZCZi82c0dpamZwL1N5d29zdER2ajZMMy8waE9ESWF0?=
 =?utf-8?B?Z1Q4ZTN0a3RvL2ZQZ010L2N0bkQ0dWVhdUV1enNJM2JJT0NKOE1IS3RjVFR5?=
 =?utf-8?B?S0VZTEVIMVRkQlFLaWE3aENDWENROUpEcVRBbGVMQzg5YVgvNm5ZcFNaaDcx?=
 =?utf-8?B?ZVRsUkpOd0N1VDJPVVV2NkpTK0ZyTGw1MXpibDRSU3VvQWxsYWw4ZGh0bE96?=
 =?utf-8?Q?hIoPiW1RKhH7EZVN+UL4KDuPs?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR18MB4251.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 970e346d-5289-43d1-084a-08daa155e2da
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2022 13:32:27.6265
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vi5yKbTTn2HzblGqA/HP9jrUn4oCTMfj/gMD0IB2ip8x/yzeiSExk590L09SdVdIrR4KzXpECX3i+T4zPTSIEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR18MB4273
X-Proofpoint-ORIG-GUID: GaA1WPmHv646j50jrJOoVgzG8NhLqYuk
X-Proofpoint-GUID: GaA1WPmHv646j50jrJOoVgzG8NhLqYuk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-28_06,2022-09-28_01,2022-06-22_01
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUGFsaSwNCg0KSSBkbyBub3QgaGF2ZSBkb2N1bWVudGF0aW9uIGZvciB0aGlzIGNvbnRyb2xs
ZXIsIGFzIGl0IGlzIGFsbW9zdCAyMCB5ZWFycyBvbGQuLi4NCg0KSSBkaWQgbWFuYWdlLCBob3dl
dmVyLCB0byBmaW5kIHNvbWUgdmVyeSBvbGQgdS1ib290IGNvZGUgZm9yIGl0Lg0KDQpGcm9tIHJl
dmVyc2UgZW5naW5lZXJpbmcgdGhpcyB1LWJvb3QgY29kZSwgaXQgbG9va3MgbGlrZSB0aGlzIGlz
IGEgIkRFViIgTVBQIGZ1bmN0aW9uIHJlZ2lzdGVyLCBzaW1pbGFyIHRvIHRoZSBNUFAwXzcsIE1Q
UDhfMTUgYW5kIHRoZSBNUFAxNl8yMyByZWdpc3RlcnMuDQoNCkJhc2ljYWxseSwgc2V0dGluZyBi
aXRzIG9mIHRoaXMgcmVnaXN0ZXJzIGFzc2lnbiB0aGUgcGluIHRvIHRoZSBzcGVjaWFsIHB1cnBv
c2UsIHdoaWxlIGNsZWFyaW5nIGl0IG1ha2VzIGl0IGEgR1BQIChHZW5lcmFsIFB1cnBvc2UgUGlu
KS4NCg0KRm9yIGFsbCBvZiB0aGUgYm9hcmRzIChvdmVyIGhhbGYgYSBkb3plbikgc3VwcG9ydCBi
eSB0aGlzIHUtYm9vdCwgdGhpcyByZWdpc3RlciBpcyBzZXQgdG8gemVybyAoc2VlIGFib3ZlKS4N
CkZyb20gdXNlciBndWlkZXMgSSBoYXZlIGZvdW5kIGZvciBmZXcgb2YgdGhlc2UgYm9hcmRzLCBv
bmx5IE1QUHMgdXAgdG8gTVBQMTkgYXJlIHVzZWQsIGhlbmNlIGl0IG1ha2Ugc2Vuc2UgdG8gbGVh
dmUgdGhlc2UgTVBQcyBhcyBHUFBzIC4NCg0KSG9wZWZ1bGx5IHRoaXMgaGVscHMgaW4gc29tZSB3
YXkuDQoNCkZZSSwNCg0KRWxhZC4NCg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJv
bTogUGFsaSBSb2jDoXIgPHBhbGlAa2VybmVsLm9yZz4gDQpTZW50OiBNb25kYXksIFNlcHRlbWJl
ciAyNiwgMjAyMiAzOjIzIFBNDQpUbzogRWxhZCBOYWNobWFuIDxlbmFjaG1hbkBtYXJ2ZWxsLmNv
bT4NCkNjOiBtYXVra2FAZXh0LmthcHNpLmZpOyBBbmRyZXcgTHVubiA8YW5kcmV3QGx1bm4uY2g+
OyByb2JoK2R0QGtlcm5lbC5vcmc7IGtyenlzenRvZi5rb3psb3dza2krZHRAbGluYXJvLm9yZzsg
YXJuZEBhcm5kYi5kZTsgb2xvZkBsaXhvbS5uZXQ7IHNlYmFzdGlhbi5oZXNzZWxiYXJ0aEBnbWFp
bC5jb207IGdyZWdvcnkuY2xlbWVudEBib290bGluLmNvbTsgbGludXhAYXJtbGludXgub3JnLnVr
OyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9y
Zw0KU3ViamVjdDogW0VYVF0gUmU6IFtQQVRDSCB2MiAzLzNdIEFSTTogb3Jpb241eDogQWRkIEQt
TGluayBETlMtMzIzIGJhc2VkIG9uIERldmljZSBUcmVlDQoNCkV4dGVybmFsIEVtYWlsDQoNCi0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0NCkhlbGxvIEVsYWQhIEkgaG9wZSB0aGF0IHdvdWxkIG5vdCBib3RoZXJpbmcg
eW91LiBXZSBhcmUgZG9pbmcgaGVyZSBjbGVhbnVwIG9mIGtlcm5lbCBjb2RlIGZvciBvbGRlciBN
YXJ2ZWxsIFNvQ3MgKE9yaW9uKSBhbmQgdGhlcmUgb25lIHVua25vd24gdGhpbmcgYWJvdXQgODhG
NTE4MSdzIDB4MTAwMDggcmVnaXN0ZXIuIFNlZSBiZWxvdy4NCg0KT24gTW9uZGF5IDI2IFNlcHRl
bWJlciAyMDIyIDE0OjU2OjQ4IG1hdWtrYUBleHQua2Fwc2kuZmkgd3JvdGU6DQo+IE9uIDIzLjku
MjAyMiAyMTowMiwgUGFsaSBSb2jDoXIgd3JvdGU6DQo+ID4gT24gRnJpZGF5IDIzIFNlcHRlbWJl
ciAyMDIyIDE0OjEyOjI0IEFuZHJldyBMdW5uIHdyb3RlOg0KPiA+ID4gPiA+ID4gKwlpZiAob2Zf
bWFjaGluZV9pc19jb21wYXRpYmxlKCJkbGluayxkbnMzMjNhMSIpKSB7DQo+ID4gPiA+ID4gPiAr
CQl3cml0ZWwoMCwgTVBQX0RFVl9DVFJMKTsJCS8qIERFVl9EWzMxOjE2XSAqLw0KPiA+ID4gPiA+
DQo+ID4gPiA+ID4gSSBzcG90dGVkIHRoaXMgaW4gZG5zMzIzLXNldHVwLmMgYXMgd2VsbC4gRG8g
eW91IGhhdmUgYW55IGlkZWEgDQo+ID4gPiA+ID4gd2hhdCBpdCBkb2VzPw0KPiA+ID4gPiA+DQo+
ID4gPiA+DQo+ID4gPiA+IE5vIGlkZWEuIEkgaGF2ZSB0cmllZCB0byByZXBsaWNhdGUgd2hhdCB3
YXMgaW4gZG5zMzIzLXNldHVwLmMgYXMgDQo+ID4gPiA+IGV4YWN0bHkgYXMgcG9zc2libGUuDQo+
ID4gPiA+IEkgY2FuIHRyeSB0byBsZWF2ZSBpdCBvdXQgYW5kIHNlZSBpZiBhbnl0aGluZyBjaGFu
Z2VzLg0KPiA+ID4gDQo+ID4gPiBJdCBpcyBiZXN0IHRvIGtlZXAgd2hhdCB3ZSBkb24ndCB1bmRl
cnN0YW5kLiBJdCB3aWxsIGJlIHRoZXJlIGZvciANCj4gPiA+IGEgcmVhc29uLg0KPiA+ID4gDQo+
ID4gPiAJQW5kcmV3DQo+ID4gDQo+ID4gSGVsbG8hIEkgdHJpZWQgdG8gaW5kZXggYWxsIHB1Ymxp
Y2x5IGF2YWlsYWJsZSBNYXJ2ZWxsIFNvQyANCj4gPiBkb2N1bWVudGF0aW9ucyBpbnRvIGtlcm5l
bCBkb2N1bWVudGF0aW9uIHN1YmZvbGRlcjoNCj4gPiBodHRwczovL3VybGRlZmVuc2UucHJvb2Zw
b2ludC5jb20vdjIvdXJsP3U9aHR0cHMtM0FfX2RvY3Mua2VybmVsLm9yZw0KPiA+IF9hcm1fbWFy
dmVsbC5odG1sJmQ9RHdJRGFRJmM9bktqV2VjMmI2UjBtT3lQYXo3eHRmUSZyPWVUZU5UTEVLNS1U
eFhjDQo+ID4gempPY0tQaEFOSUZ0bEI5cFA0bHE5cWhkbEZyd1EmbT1RbnZ0SUNnWXJrbkJjcko0
U0JZa0w4elV4TnRxbzNBNDBiakUNCj4gPiBUbUNIaEJiZFdRT1VhUmZma2lNZ3R1UmtRMldFJnM9
UWlOdnhjT1NwRE5PVGdpSzhudUNaMThwZ0pSS0J0Z1Z1LVNlRw0KPiA+IEU5bjdDWSZlPQ0KPiA+
IA0KPiA+IEZvciBPcmlvbiB0aGVyZSBpcyBsaW5rZWQgRGF0YXNoZWV0IGFuZCBVc2VyIE1hbnVh
bCwgc28geW91IGNvdWxkIA0KPiA+IHRyeSB0byBmaW5kIGluIHRob3NlIGRvY3VtZW50cyB0aGF0
IG1lbnRpb25lZCByZWdpc3RlciBhbmQgY2hlY2sgDQo+ID4gd2hhdCBpdCBpcyBkb2luZy4NCj4g
DQo+IE1QUF9ERVZfQ1RSTCByZWZlcnMgdG8gcmVnaXN0ZXIgYXQgYWRkcmVzcyAweDEwMDA4LiBB
Y2NvcmRpbmcgdG8gdGhlIA0KPiA4OEY1MTUyIHVzZXIgbWFudWFsIGl0J3MgJ0RldmljZSBNdWx0
aXBsZXggQ29udHJvbCBSZWdpc3RlcicgT2Zmc2V0OiANCj4gMHgxMDAwOC4NCj4gDQo+IEJpdHMg
ICAgRmllbGQgICAgIFR5cGUvSW5pdFZhbCAgICAgRGVzY3JpcHRpb24NCj4gWzMxOjBdICBSZXNl
cnZlZCAgUkVTIDB4MDNGRjAwMDAgICBSZXNlcnZlZC4gTk9URTogTXVzdCBiZSAweDAzRkYwMDAw
Jy4NCj4gDQo+IERFVl9EWzMxOjE2XSByZWNlaXZlcyBubyBoaXRzIGluIHRoZSBkb2N1bWVudGF0
aW9uLCBvbmx5IHRvIA0KPiBERVZfRFsxNTowXSBhcmUgcmVmZXJyZWQuDQoNCkluIGxpbmtlZCBw
dWJsaWMgZG9jdW1lbnQgSSBmb3VuZCBzYW1lIHRoaW5nLiBSZWdpc3RlciBpcyBmb3IgODhGNTE4
MiByZXNlcnZlZC4gKFlvdSBoYXZlIHR5cG8gaW4gY29tbWVudCwgaXQgaXMgODhGNTE4Miwgbm90
ICo1MikuDQoNCj4gTWF5YmUgODhGNTE1MSBpcyBkaWZmZXJlbnQsIGhhcmQgdG8gc2F5Lg0KDQpJ
IGhhdmUgZmVlbGluZyB0aGF0IGZvciA4OEY1MTgxIGl0IGlzIG5vdCByZXNlcnZlZCBhbmQgaGFz
IHRvIGJlIGNvbmZpZ3VyZWQgY29ycmVjdGx5LiAoQWxzbyB0eXBvIGluIHlvdXIgY29tbWVudCwg
aXQgaXMgODhGNTE4MSwgbm90ICo1MSkuDQpCdXQgSSBoYXZlIG5vdCBmb3VuZCBhbnkgY29weSBv
ZiA4OEY1MTgxIHVzZXIgbWFudWFsIGRvY3VtZW50IG9uIGludGVybmV0Lg0KDQpJbiBwYXN0IDg4
RjUxOHggYW5kIDg4RjUyOHggZG9jdW1lbnRzIGFuZCB1c2VyIG1hbnVhbHMgd2VyZSBhdmFpbGFi
bGUgcHVibGljbHkgb24gTWFydmVsbCB3ZWJzaXRlLCB2aXNpYmxlIGZyb20gd2ViIGFyY2hpdmU6
DQpodHRwczovL3VybGRlZmVuc2UucHJvb2Zwb2ludC5jb20vdjIvdXJsP3U9aHR0cHMtM0FfX3dl
Yi5hcmNoaXZlLm9yZ193ZWJfMjAwODA2MDcyMTU0MzdfaHR0cC0zQV9fd3d3Lm1hcnZlbGwuY29t
X3Byb2R1Y3RzX21lZGlhX2luZGV4LmpzcCZkPUR3SURhUSZjPW5LaldlYzJiNlIwbU95UGF6N3h0
ZlEmcj1lVGVOVExFSzUtVHhYY3pqT2NLUGhBTklGdGxCOXBQNGxxOXFoZGxGcndRJm09UW52dElD
Z1lya25CY3JKNFNCWWtMOHpVeE50cW8zQTQwYmpFVG1DSGhCYmRXUU9VYVJmZmtpTWd0dVJrUTJX
RSZzPWsxdm4yLU5WRVUyT3NKWVZUbXVXTVJLZE4ydDFNUTlwZHVUa0dhYXNVNHMmZT0gIA0KDQpC
dXQgTWFydmVsbCBkZWxldGVkIHRoZXNlIGRvY3VtZW50cyBmcm9tIHRoZWlyIHB1YmxpYyB3ZWJz
aXRlIGFuZCBmb3Iga2VybmVsIGRldmVsb3BlcnMgdGhleSBhcmUgbm93IHByb2JhYmx5IGxvc3Qu
IEkgZG8gbm90IGtub3cgYWJvdXQgYW55IG90aGVyIGJhY2t1cHMuDQoNCg0KRWxhZCwgY291bGQg
eW91IHBsZWFzZSBoZWxwIHVzPyBEbyB5b3UgaGF2ZSBhY2Nlc3MgdG8gZnVuY3Rpb25hbCBzcGVj
aWZpY2F0aW9ucyAvIHVzZXIgbWFudWFscyBmb3IgODhGNTE4eCBhbmQgODhGNTI4eCBvciBoYXZl
IGluZm9ybWF0aW9uIGhvdyBrZXJuZWwgZGV2ZWxvcGVycyBjYW4gZ2V0IGFjY2VzcyB0byB0aG9z
ZSBkb2N1bWVudHM/DQpIb3BlZnVsbHkgdGhleSB3ZXJlIG5vdCB0b3RhbGx5IGxvc3QuIFdlIGp1
c3QgbmVlZCBleHBsYW5hdGlvbiBmb3IgcmVnaXN0ZXIgJ0RldmljZSBNdWx0aXBsZXggQ29udHJv
bCBSZWdpc3RlcicgT2Zmc2V0OiAweDEwMDA4Lg0K
