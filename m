Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ACDA6A72C1
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 19:09:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbjCASJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 13:09:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbjCASI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 13:08:57 -0500
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85BAC2117
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 10:08:53 -0800 (PST)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3217MRA9004492;
        Wed, 1 Mar 2023 12:08:34 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=PODMain02222019;
 bh=I7G7cT2Bgkv11Y/Zfg2qXEZ2xbscuM6NBAGp/ay/Krg=;
 b=V73V9XHr6werFL3PY6dl7q3f9CTLXvvMMXuDzq8wTwrDpjO6I7GmVwL/YTJA+NceQCjG
 egqvGtBBYbkR5QjufuV74m609csAgMrStcgY1PVnjhsfv15coWRvnCyvPwboVQxwYAiI
 1F4W1nMDt4sk6JZy+7j9LykQrUCSjpIQZ58P6VC1M/AzGGTuYLOOoq5hAY/4+Hj8X0XE
 iu1ieep6YyObVYBO2Siz7pSUxSLP3l2BKesK6mmFq5RVsj1BKIWFHQXIR1EVHy3FREHV
 ASpAjOb0ppyl617v0O2x9BQbspCf6qpieB2K+IXOQBjyemEtrBK1UqVUAxE6LtUxoSVX mg== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3nygm6ye3p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Mar 2023 12:08:33 -0600
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tyrleo6hg+wjJURROaqljnriUMExwRFcbifN/+vb4Lxp87PueE7f71ZOhLqtH3SKtukJLD83KEWnlZjXf8iriS/8BjE+1AxpQo4Y44r6JXjWyqhJF2CN5162X/hVZ3FJXbXi9G/xSwXFI6opD/EDPge1Xc3OMFBevWDn3gCENLDA+3Sz9eAVpFjC7SGSZRrrfqS+KobFrVqWWMvgKZa4x3ec6dGCzdvUG2sIlM7dLNwvtp0CDie1I/GKWWtqa2Vb2AmxFctGkZ/p2OnYUFtukNtMd0v6+LPZCZqAIEarhEOmUodsAYbYr5OM9aEx1/Mk6mLawUqQspBP00uh8Y0Nag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I7G7cT2Bgkv11Y/Zfg2qXEZ2xbscuM6NBAGp/ay/Krg=;
 b=iysOXj+gs6ONx7MQRCK+SadTaBgSnPoujyAsJJuzGUmBWz1q2juOIJsTmBQIEzyxp/cbhIIQBve28kJC6APq504QSe35Ji/5r4SA00OCl92cdmongHSWsfSkAceM5KZTdNaxQryzO/QeUjWUte2F/1LWSRZA7bN0t2WblhNyuvf++ecQWoYdMUJvfX36TqIn9bTGiA4b+961N2Bno9ks5xLbWo4/fNsz0HRF+gJG2xWC5q3PqAr2Q+T4Fonq+YXCVsjdv/E3FJFSHaWoxqnhKojAcFrk5On435IIcTJBlm5CyyBqMJtahTNMoC2vHe15JabMYI7crmvn+z3V/+/gcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cirrus.com; dmarc=pass action=none header.from=cirrus.com;
 dkim=pass header.d=cirrus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I7G7cT2Bgkv11Y/Zfg2qXEZ2xbscuM6NBAGp/ay/Krg=;
 b=ZXv8pkaw94Vq8EeHtZ3B/bu+QMe2cKH+Knt82spsyahLj632g23HvR2MvXdae6ytIxN34DVvcg3enaM09e1oqjDZF75P4finvJ6KD9DZ0FTg7BMpE+gEFZ7qOFhpEohcIdLWoT8fbkI+jDv+EfvXldxQ/mYYPT+eJpJUsqSpop8=
Received: from PH0PR19MB4953.namprd19.prod.outlook.com (2603:10b6:510:a0::15)
 by CO6PR19MB4786.namprd19.prod.outlook.com (2603:10b6:5:34b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Wed, 1 Mar
 2023 18:08:25 +0000
Received: from PH0PR19MB4953.namprd19.prod.outlook.com
 ([fe80::f4d2:259f:651f:8ce4]) by PH0PR19MB4953.namprd19.prod.outlook.com
 ([fe80::f4d2:259f:651f:8ce4%9]) with mapi id 15.20.6086.023; Wed, 1 Mar 2023
 18:08:25 +0000
From:   David Rhodes <David.Rhodes@cirrus.com>
To:     Lucas Tanure <lucas.tanure@collabora.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        "Takashi Iwai --cc=alsa-devel @ alsa-project . org" <tiwai@suse.com>
CC:     "patches@opensource.cirrus.com" <patches@opensource.cirrus.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@collabora.com" <kernel@collabora.com>
Subject: Re: [PATCH v3] ASoC: cs35l41: Steam Deck Shared boost properties
 quirk
Thread-Topic: [PATCH v3] ASoC: cs35l41: Steam Deck Shared boost properties
 quirk
Thread-Index: AQHZTDuh7+T0mrGra0uLMm2LbOWSaa7l1JQA
Date:   Wed, 1 Mar 2023 18:08:25 +0000
Message-ID: <080AE2AE-811A-4D06-89BC-225C8522DF19@cirrus.com>
References: <20230301124447.17672-1-lucas.tanure@collabora.com>
In-Reply-To: <20230301124447.17672-1-lucas.tanure@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.69.23010700
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR19MB4953:EE_|CO6PR19MB4786:EE_
x-ms-office365-filtering-correlation-id: cb56b16a-555d-40ed-8be3-08db1a7ff38a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PxmCuE+sj5zhRUEygZ4q8zNjLVRqqlHrx8PVtDgGAJFz3VmMuar7wMZHkmKNhiGh/MBxmMDMy/xdth/jydUlsBlAl9yRhd8d1c+VaXW7hQXlUC6eqYKvHLnzW9lgfsSA7haTLMC7j7Nk1OUKj8jhOjXGDY8C0Fdkr/QviVAeLIYhh6JajR5VWjF+gTQzM7UHIWazauOGarQ3lSWferWTBV8tklAo4ig3UOYa35DZEL/svzSKpiTYaTaB01uomAwHfhpHEfDSkfIi8Bx9jlQj5QJE/v+Ni2UZ9/nTuIbhDum18j9L9y1ftaQPj6DmAA3grNeEoQLamaCO/wGJBdU8umHm9McLQYg4vKZ91FyELTH2uf0ordk+sCgQS+SGVcbX3kUM9fs3RmMh5J6eRJW7N2LOWdoaxMBgxGFL6XsKtyfeOTERA19dyj4ZMBi1VBC4E9NiFC9xSpuTdPFxh/I8qOHDIvPFyOZAxjQM+XP/WF/hQp9eOt4kAyyyGBUwHjgIUHDX1RTouwc/4vTPnK+oJ3Ty3Y+SSXG9n9ZeTWCW3H1XIzKHsrQoGPZfqCk9DpjJ4Rtxsk7qibiZtF7ycoWMUnUcjXVKJho9DyCcLy5TDkqNudsne3jbeCVjbqtVE84usTNCrUeoMc8tBHMH6pH07dqVQNB9bloepLe5/FbMqKm5nkoy017/L3NZdtMy5as2dGm7/8MEYksq1fdlcykM8Io4d/C5pOJ+12NBIGB9k0Q=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR19MB4953.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(39850400004)(366004)(346002)(136003)(396003)(451199018)(558084003)(86362001)(36756003)(38070700005)(478600001)(33656002)(6486002)(110136005)(71200400001)(5660300002)(64756008)(66946007)(66446008)(41300700001)(4326008)(8676002)(76116006)(66556008)(38100700002)(66476007)(122000001)(2906002)(8936002)(91956017)(316002)(26005)(6506007)(186003)(54906003)(2616005)(6512007)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dmZOVXV3L0NrYWlkUG5YOGhRWWZlMzBVSWxyTk5GQ3RLYmRtZ2ZlRHg2Zk1B?=
 =?utf-8?B?Rm1NODNpRmNKTC9QSVE4RjU2NVc1ZFJNR2dSOThWVjdGd3lIN01YWUZqVjhV?=
 =?utf-8?B?TXRUaXRkVFZDSVMva1lIWk5CdUZxREFuNUhaYTVHVmZBclVnbVpyc3IvV29u?=
 =?utf-8?B?SUV6azM0UTc0NmxPQytvb2NsbGl0b0RaalZMMEU2KzF4bkgwS3hXTVRqbE5t?=
 =?utf-8?B?YzJ2OEZUWVZibEdMcFphWDdkKzdxQzg1TWlUWW9MMERDQTNZTm0rdHIyMmhJ?=
 =?utf-8?B?MlJrZ1Z5RDIyRnE1S0FiRGx3NzlaVnJZZERzV0UwOUJ6NzJPa2hJbHkyRm1r?=
 =?utf-8?B?K09kNFB1cEpyajFGSkRSRWYvcFRrOG1OQWl0bWxoOEVWL0VVTStLN2c0UnVU?=
 =?utf-8?B?bklrVkM2T2VtL2F0bHdhaytkMzhkTFZKWVV2L052bFNjd0RTeEpKMlpnbnB5?=
 =?utf-8?B?aEhodklqRU9kMXVQZDVtK2pHaWdxVnRPV2k3Y3NxNFI1SElnSkdVWnkrWERs?=
 =?utf-8?B?WE9lalFmTDI5SGo1eUhGRW9tNzVlUitqYVBGR3B6N3REaFZ4Y2xpU1czUGQw?=
 =?utf-8?B?elpXQk0zUHlGRmloa2RuNGZ2dHJucXNadWRubEdIcnhldlZtYTdCRmZERC9Y?=
 =?utf-8?B?d1JrV1o3RndkOEV4WDk1dVliMUdzc2FJZ1N0OXp4ZmFucElXd2NqUTlCcG1F?=
 =?utf-8?B?M09EOVJRa3RLRVRkK3VId0g5RG9XUFluSkxsV005RGFkTkRYd3pkZ0ZEd2dz?=
 =?utf-8?B?RGUzREJzQXZNTDJzTFdkbkdueERDNDlZeEw5K2hwYzYwV2hnL2ZTZHZzTXpi?=
 =?utf-8?B?TlRlMy9zUVdFdm54NlRVQ09tYWNpaXpERWt4dlB0RUFDMVRHVTlaNEpUZ0pU?=
 =?utf-8?B?dlF5NTZVU3dRUEkwMno2RjgrejZKVVp4cEhLaTBUdFBDTllvMjY2UkdEckMr?=
 =?utf-8?B?bmt6aFVZdjkxaXcvaWkzc20ybHN5WGF6azhISElFZ2YvRUJuMWRPRnEvM1dw?=
 =?utf-8?B?eGREZCtCMGh3WGZldVZrc0R3Zlkzb2kwTVZUMWFHRVNZcXlvM0Q3Y3p0OU52?=
 =?utf-8?B?S2orVWpDSitUNWEwaXFudEkxbVlmV0V5K2ZYOFkzS3picCtVQ1B0bG5lRUhG?=
 =?utf-8?B?VDZxalhEOEJMZXErbHJtOWU3MEpjUVRvT093QWZvc3FuczJWV2pvZ09TemFH?=
 =?utf-8?B?ak1JaE9BSldpc3Y0RzQ0QU1ZU3ZuMjl0bWNBaXJjUXk4VzR4bTd2TWkya3hE?=
 =?utf-8?B?UVVFUlEyMGViOEZTWCtnckdLRjJ6azd0ZUUybFRRWVpzZFlyenpHU3lVT2FF?=
 =?utf-8?B?RVpKYTdPc0VMelpyTDFaUzRuOXQxY3dOZng4VVMyeWdOVW55NHNBZERXLzFi?=
 =?utf-8?B?azNmRThpQWdKY3JibEx6RlhpTHcvVWwxc3l5eC9oelNqbVREUExIRWR1eHRw?=
 =?utf-8?B?SUNHM0RGeEpkMkUva25jL2p5STRZRVFud3J0V3Y1U1ZRcXVZcU4yL21EaHE4?=
 =?utf-8?B?Um5rQkhQM09DQVdBYTBVelB6alQ5d3dHaUlUNmVwakVvQ09ka1lPUHJ2bDlE?=
 =?utf-8?B?SE1oVjQwZUF5eEVTcWJnSTlNMXVlbERwY1czMmRCdHJjM3lueTJJTUN3Um1a?=
 =?utf-8?B?eGE2dXluMG1BQktJZkdqZzNKL3RqSEZEQ1NGcWZJcTNKMzBIYmF0Y0lIeXBZ?=
 =?utf-8?B?eTNNM2tBMDFmUUVaN0Q0SWFvNlUwL2lnVXNzTG4wTDd3VDhMVFRwaWxxbEpN?=
 =?utf-8?B?NmMzQmhMbGF0THpPT2xwcWRnb08wQ0t1WVlJa3dPbkZUb2Z5bEtyVHRDdURy?=
 =?utf-8?B?Wm1DVWJMdXJDZlNxQU1QZlJvSGpMNEJvTnQ2Z0RTS2FnWEl4endVeDdac20w?=
 =?utf-8?B?Qmt3aXY5dkJ5Tnhqb0swZm91dFk2VkFKWlRaeGxtcWlMSmxhQ0hPd0lzb3VG?=
 =?utf-8?B?TUZneGN3UjA2a05VSDBuYTZONGhpTGZJcE5YTnJyZko5aER2dXNoelg0L2xM?=
 =?utf-8?B?UDlmc2k5VG9HVU9COHRJUGpuQ1NmZVEvOWo0MWxMQ3hsKzRrZTJXZi9wYmtz?=
 =?utf-8?B?YlRSRDUvY0FwdWNDRm9RMXRKdXhOQ0d6bTI0Y29vMVA4MzVlQVZ6UjBqRHBx?=
 =?utf-8?B?VFljczNrUEY3eGFNdlUxbFowSW1ob09EaTlxeGJ0aE1OSVdVS3RZbWxCWm5C?=
 =?utf-8?B?WHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <61F659665752DC4AAC456A5A887C1891@namprd19.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cirrus.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR19MB4953.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb56b16a-555d-40ed-8be3-08db1a7ff38a
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2023 18:08:25.1700
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dHcyxzisNs7ovuNGO6fDfC/p5YfKm+uDpxdcUBPfiBjk1TgUJn8eKsJYFkEqYGFRwYkq7yoXwzyBKVeAqYlanA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR19MB4786
X-Proofpoint-ORIG-GUID: 3q1E70yQBl-ww3tr72Yx_lWtzKDo_LE9
X-Proofpoint-GUID: 3q1E70yQBl-ww3tr72Yx_lWtzKDo_LE9
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiBXZWQsIE1hciAwMSwgMjAyMyBhdCAxMjo0NDo0N1BNICswMDAwLCBMdWNhcyBUYW51cmUg
d3JvdGU6DQo+KyBpZiAoZGV2aWNlX3Byb3BlcnR5X3JlYWRfYm9vbChkZXYsICJjaXJydXMsc2hh
cmVkLWJvb3N0LWFjdGl2ZSIpKXsNCj4rIGh3X2NmZy0+YnN0X3R5cGUgPSBDUzM1TDQxX1NIRF9C
T09TVF9BQ1RWOw0KDQpNaXNzaW5nIGEgc3BhY2UgYmVmb3JlIHRoZSBvcGVuaW5nIGJyYWNlLg0K
Q2hlY2sgeW91ciBDQyBsaXN0LCB0aGlzIGRvZXNuJ3QgYXBwZWFyIHRvIGJlIGdvaW5nIHRvIGFs
c2EtZGV2ZWwuDQoNClRoYW5rcywNCkRhdmlkDQoNCg==
