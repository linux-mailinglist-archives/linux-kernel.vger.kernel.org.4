Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1ED626FBD
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 14:33:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231972AbiKMNdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 08:33:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235270AbiKMNdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 08:33:12 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F285FCC6;
        Sun, 13 Nov 2022 05:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1668346389; x=1699882389;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EO0UWUDNDptxC6Z6q9l4TUI9IR+YP91SegqNX3O9Doo=;
  b=dvme0FTlYHTTgLEMO9wMIdoCxfJOzvhVkgwWUlRkaNewokcz/2rzWN2E
   hQ35JBT+HHSeHanjUTNpkNg6lOiepf+L2GRlQW2c49hiDh6JIlJ996oBQ
   sqLs9LmVN7FQmIO/5umx8h8v9CQBgpg4QPAbWBDHhrA6c1RJofNiISGJg
   S3h2ym7xYUN9N8YuZMXRyVB1zx5KbzWJEp5Y6UgvhAE0fOag+jTCiNDwx
   0JYYbpZLoN5j71qF2N/pXwT9MLf0DZF+yGBvpPqQQfu75KcGnVPNbzMSD
   WKUGSdQ4LG7rvljznnrz+6FLPjLG02NEDQC6waufBqX534XEvCPhjyOj8
   w==;
X-IronPort-AV: E=Sophos;i="5.96,161,1665417600"; 
   d="scan'208";a="320494819"
Received: from mail-bn1nam07lp2041.outbound.protection.outlook.com (HELO NAM02-BN1-obe.outbound.protection.outlook.com) ([104.47.51.41])
  by ob1.hgst.iphmx.com with ESMTP; 13 Nov 2022 21:33:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F3T+nMMX9xbY8Wg6tWJheODJ8CJvn4H0TWWNhA8Wpe7L3FHOSa288y10liqE/gmFpssHyoo75urhP2lxh/QUR4ywhqFhg+SpdWlT7qQgdDPAhkNDxpGHYIcDeXtVOkyK3t3UiDbb6dlbciI640FayJSAUfpw6PMVYcRl2Mzefny1/YyTHrgn0G0VawPnGaxNtil/Pdssdj4C6xsi5PAG+1cbYilUOVBscTj/aedOR4APKX0Obod+yCDy+ZycwDTWcgbj2V9d8fCWR659b3Q30MEILWqvWOd3SaPhcJEhHzGqV6J8tcmYPXJHJm2aZF8BvVKmlXsvOCGAd7lOaOOp5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EO0UWUDNDptxC6Z6q9l4TUI9IR+YP91SegqNX3O9Doo=;
 b=FE1OXraImyXAnMAGmdyZ7m2zEkqxyuRuqHL6aIlHWV29eibz5F/2cKXt2Z55m5fgFn9H6354C9S49TFdohWYveW6V/+S8yfW65zJiX9+Yt7fweFQyhC4whu/2W75/q0K6nzzPHs/wI0kXg3QKTcnRTXfASNfDJX6xXlJn0RydiV0nav7dE9yf9a2bIDGWSkdij+CGfrkzDwASp7uQ1mhHmFxfw5GGSmDQJq+07b41w1OZBcAW4j8hYI2VKjbo1HyCluzZWtcAvzW8S8R6tO+a+S4dD79moO7G3f2YfBSjd1ed2YLRvnWdJRqlHVKtYAq9C2J+4OBKML0wT76UARbQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EO0UWUDNDptxC6Z6q9l4TUI9IR+YP91SegqNX3O9Doo=;
 b=DV7s05IL+cFWYCdUBDUHcTV8qRUOxsOOt1DrmkNO7WiM8F8oOlhYuuwMuPL3019q0rsRISos+hxLy2Nhkj1/cMioi/J4uDqbO2L2Asvdbf025+BOEt8a3bRrV57mGCV3z1zKHglJESWmZM0x6IWj811EP3HbsXF6rOfdPPEcC20=
Received: from BY5PR04MB6327.namprd04.prod.outlook.com (2603:10b6:a03:1e8::20)
 by BN7PR04MB4339.namprd04.prod.outlook.com (2603:10b6:406:fb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.16; Sun, 13 Nov
 2022 13:33:06 +0000
Received: from BY5PR04MB6327.namprd04.prod.outlook.com
 ([fe80::5819:f0e0:8608:aa8c]) by BY5PR04MB6327.namprd04.prod.outlook.com
 ([fe80::5819:f0e0:8608:aa8c%7]) with mapi id 15.20.5813.013; Sun, 13 Nov 2022
 13:33:06 +0000
From:   Arthur Simchaev <Arthur.Simchaev@wdc.com>
To:     Bean Huo <huobean@gmail.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
CC:     "beanhuo@micron.com" <beanhuo@micron.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 2/4] ufs: core: Remove redundant desc_size variable
 from hba
Thread-Topic: [PATCH v2 2/4] ufs: core: Remove redundant desc_size variable
 from hba
Thread-Index: AQHY7seUjkiehHhrgkidNRHtOYqMJK4565UAgAL+yiA=
Date:   Sun, 13 Nov 2022 13:33:05 +0000
Message-ID: <BY5PR04MB6327DF1BBF48BBBC0BFEF64EED029@BY5PR04MB6327.namprd04.prod.outlook.com>
References: <1667399353-10228-1-git-send-email-Arthur.Simchaev@wdc.com>
 <1667399353-10228-3-git-send-email-Arthur.Simchaev@wdc.com>
 <b3e92294-0aa7-edc1-115b-7552b13f9e7d@gmail.com>
In-Reply-To: <b3e92294-0aa7-edc1-115b-7552b13f9e7d@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR04MB6327:EE_|BN7PR04MB4339:EE_
x-ms-office365-filtering-correlation-id: 86731459-73cc-43e7-0bb2-08dac57b9890
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oY5Ktzgd8hzWtfklj/1PE+COGkpXIrg5UX029xlpzkBAByprIkQSIcAsGsJDSCcmusQjoemRc2cG0THfK6930FoOX5KLR242fYmmSCoD7NRg9BrA3mYLP0KiqZHQJXWrY8BlVbG/q7SD0Mj1VNNAzJSxAMSDin5W5KfUgU9cbpYHO7naPF6glU5564p99FUrEd6sLrOpBLWrWlIaJHnR/X5UIRq81pTKIh4Mkul+OB9+7agr90Qw/selKHnYjXNtAmO5AvAV6UNYk+zvrmK2uZBTeJDFs3k0majkVCnJ872HHPzYV8QyxD210w3wAJIQn+eP6rmjLoA4InCYMRI+8wljplG5iK127TQBNzQqsvtly1YBleRICRTEk53KdmeMAl9b1sT5ydYD6y55uABER58fhn3xWlElVjb3GMwhnV+lPenbcc8c3XNPZSEEDFm9g9Vo76myKVoBsE9XRrrthVSR5ItSKCN3WiUjt4dUHNFoAuP0j+hv1MWjt3jC08GgPuLW1bKiIz9bfie6ZDhpliq4Y0Jdo1OTsysSlYxQiwj5SXJZ/SjD5i16jDyvNfZZ94kqXgEviFEDLjhGK2Y2nO6Q9QidAMdX87eWNoLA3A5dx5PGYO8p4QH5letn1PWxV/6W75AHG/l5x6EwFAa+INfQtqga0GZFN+FcbXUxwHi7+ex4/xcrxQaHJe1q0DQIQxQZBIJSBxGI2qP4n/m+ykrcQFAVkaY9Mpl927xPKOSxKLxzfLE45S5Eunpxbj3O
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6327.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(376002)(136003)(346002)(39850400004)(451199015)(2906002)(66476007)(4744005)(76116006)(52536014)(66946007)(122000001)(64756008)(66446008)(8936002)(33656002)(4326008)(8676002)(5660300002)(41300700001)(54906003)(110136005)(66556008)(316002)(38100700002)(478600001)(86362001)(71200400001)(82960400001)(83380400001)(6506007)(9686003)(7696005)(26005)(55016003)(186003)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TlMwaXcvc3dSaW9aTUdMUHg3NUpIRmhjdHhHVVRJQXAxR2JSNFAvL21xZE56?=
 =?utf-8?B?Z3VYbVkvYWd3NkEreEZDNXlGdVU3UGh0by9JS2NUQzFyWXhvQkxKSlBkbGJT?=
 =?utf-8?B?YkhQRFRnVmV4TjhiMXptUCtaUFJRYmUyRUxqY3BadlNXTlRWYjRNeGY3QkRZ?=
 =?utf-8?B?ZGQ3ajhJYVhwNWhlTWk0L29QWTZLWFlrdllISEZNcHRMdk5yNjZGUjhQRDht?=
 =?utf-8?B?cXdYTURjOWpveUtFa1VEQ3Azc1Q4MHFhYVpNeHBiUVc4NER3alFiNWpZWE9z?=
 =?utf-8?B?UW5FamVjUi94SlFIUXpOTnNVQ3hFUTVhYnRkM0FNZFU5WW01ODBZS0JUelNY?=
 =?utf-8?B?VVZaNU1KVjhGa0hpU1BlaDRadTFPTUJZOXBkb2EyUyt1amNvU2k0YVBMVkla?=
 =?utf-8?B?RHJmZXUweXVTcFdPVXFyTjNvY2hXcUU3azhTRkxoeG14Mi9jYVhHT0wxVDlh?=
 =?utf-8?B?T3dMSE9DYmRNeXJSK3Z1MXErd0Joa1N5bm1BbVBobU5HSjJTQjNUbzF2U1Qx?=
 =?utf-8?B?L3hSVkFsRkpnYm8rc3o1MFA3N1VIcE55U0lzMmRKODdSSXQ2SHU0ZVhyZWNa?=
 =?utf-8?B?UzRUbGJnbC8rVmh0Y0lPaEsxOTI3YldPTFJZTXk1VzBzZ3UrYU5kcjViemcv?=
 =?utf-8?B?RzFkWm9vbk9Qc1RTbktpN0JMMmtaMjJNSkNBNzJSU3RLMDVPdlY2S2psSVFi?=
 =?utf-8?B?VW1ReVprRU8vYStIcExMSzV0TVExNlhNTmxocTJKc25xTERsNXdPMjJYZjU2?=
 =?utf-8?B?YkE0UTJObUhiclY3ZHkwbm5yaVN6bTFPbEk1c0JuaGZyeUJVMlNaQUs0SnhU?=
 =?utf-8?B?K2lRUWpHUUQ0VDcycEdhQzJKa3o4L3lsaDgyV1R4WXJyQmtkcUs1MUx4c3RE?=
 =?utf-8?B?UlFzVmV2L0FaMExORzBwNjJVb2YvSEVJazZsV3BMU3hZUGtCNVFBSk5UOXBK?=
 =?utf-8?B?NkhTUFZDVUZzdGc2blFoL0ZEZkE4MUQ1U2JSMjM4MlpKM3JTSGhlSEhRMk5M?=
 =?utf-8?B?MGVsalU4U3Y0SzI0czgwTkJTeUJ3Z3o5UU5hUmtrRDhyVFIvSGY5dkRzTmJ5?=
 =?utf-8?B?bXA2UGJXL3NUVTRIV1hndWltNVQyRWFqOFhNRkZqaGhENng4L21neWNwZGtD?=
 =?utf-8?B?UTM1ZldGTzVvS3RqODdIMW1LemdOWjJOMlFKRXpYelF5Vko1NkZvQ2w2OVU5?=
 =?utf-8?B?RDQyU2dkN0pWWGp5NFdidFNEb1p1UnNwcTV5Zyt0c1p2bkN1WFVKODdsZ2Np?=
 =?utf-8?B?OHNuWUZXUUZURHQ3M3NBK1FlVi9TOFkyeEttL3RWSlV3UEJaQmZ2ai81bW9l?=
 =?utf-8?B?clBpLzJ6WEx1V2xlckkxbGErK2o5S2hMNVB4QzNDOVpvbEorS0hEQU5zeCty?=
 =?utf-8?B?bzZNQzRJQmZObnZSeWpyZTM0THZqaTZYemdKcktBWXZkK1hiSGxxeExHNjh1?=
 =?utf-8?B?cWhJQlRWNWNSOGdXTjVvZjBrZTlZOFBPNmx0M3FUcHJUTUxQSlJ6cUtJNTZW?=
 =?utf-8?B?a2I2YTVWbTMwcXNnSi85ZzJZQ2g1WS9jcCtWZEszYTIrejZPd2Z3RDQ4ZjNy?=
 =?utf-8?B?Z3pBdlNwSklxK1Ruc0xXV1ZsQ2JBTk1TbkNrSXBwbkFUNTliNGJISHZkT2FC?=
 =?utf-8?B?MmFIc1I4ZnpMZ3A2K1krdUtTeHdXSkVTK0daaTFBVmRpK0pvNkNyZFNLS2RM?=
 =?utf-8?B?T3AwWDVKcmZEeGVYc1h1MmtQeExaSTh3Y0ZrcGRkWVRlOCsrdTU0V2JTNWYy?=
 =?utf-8?B?QlRYYkVSOVZXOFg1dEFPakt4VHk3cTRxUjVYb09Ga0lGQ24xRlNHOG4xN3Z6?=
 =?utf-8?B?RVgzZzhvdzZXd1ozUkFaVi9FVGZjSlkySHBISnZhdEt2ZDNuWVMxbTdMa0Jr?=
 =?utf-8?B?L1Q5ZmdQejFWSmhLSmdzUU04bXd5RUROVGs4YS96S2IwemRuYVA3ejkrQXJW?=
 =?utf-8?B?a0d5L0dUcEFlVXQ5TGRUT1FWeUJuMHI0aXFxS05welBiWnhIcjRFRGFzUHFL?=
 =?utf-8?B?QzlhUjdpY3R1L25TNVI4ZnFmY1VmTmRield4NkFVZG9FVFUyMVEwT210NFNQ?=
 =?utf-8?B?bkZGdHJ0anNMZUJ4ZHFuWnZhejREWFhUK2ZMN1FOUDc4amZWVkFPaWtFVmoz?=
 =?utf-8?Q?oWUFjX8kzxIoDjycp8IvHSoXR?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: OxrYHuxnJB8IbnGRVcFjvix+f2QmkodEJINLDDSYia2AcHPMs7QzvhrkW9BEZZpys+c0azLz/yE8AUf9m6CedSY7EwPT3sNTpq4VI+OzQTRXv7W8nJvauBfwn+zAOEO3G8ZOKibiOZ5RPzulb/SUdjGeqXNV4Yzvj/6uAxIID2dbUkiTWb/6TPsXnHhE9wnHhrtK+Uha4jLK3ltcJdMQP2YtwB9FDO6BPHU6nSeahKMQ5vrqV2iCN3Evc3Z0j/H3kPC4HFkJZCOq1qfCJnpfc/3a91RlyDK2y4QN0//b44jB6oknZH+3r1iix9rsycWRJmtGSo1dowQZj0naqkc5mzBWS+fs47uilXNB8WI2VZG6/92lagzbahtEFI5CAkH6WLLu4RiSSGz5PmtctB8kjZdrCuCBb9hOEMoFrlOwlK3KvbKK98P1+X0kxWoaHy/1t3qbxQdMjPgYXvMIaiShyiy8ZMDrbkmIJPaG4e7gpDrPZVgrZFsnPxawuZQCLS+fL9v+/cp/MHQ9HsbIYCfv6kghi9d+2oabwQB3STXIDXknf3tES75mtD2QxCl+NwD9C2X0MIutzsLaxEIVs0AStXW+ZeZLrqVT+AbsHsTDvQyxJeFp7eIOON7w6VM/571QTg7DBjspUHV3YIa5Cd6R+O2CF+pFigIPrd0cGS6sgZTjYcBco7+1hylvbeG4wDQS1ZtHjLZ2R/h18dLXDpyfTt4KND+LAZ7avV0wWVko3N5rxeV8Si27GeZZmPV2sVF+CpnnZw3meXRpIlcitfbk8UIPYImiY6bnjfX/CP+YG/o37RnIGhxY4Rdx5aVkv19Ujq0o4L4o68/ueyTzApH9aYJeMo+V4MtHftdcJfJ4XhpqA2V/OAKGwP9EOJO92X8L+8O0z2Ef8h6oHitcOa03W2o4qeC7jJ0rTkWiJwQdYus=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB6327.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86731459-73cc-43e7-0bb2-08dac57b9890
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2022 13:33:05.7416
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t6MWXqmeYb0Vyq7mO0tL8jiiFFe7oVlKXytWAe24ywofWSe7cgySuq0Gk88YDD5Houh0epxFuIKVmi8H6Ff48Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR04MB4339
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBIaSBBcnRodXIsDQo+IA0KPiBEbyB5b3UgdGhpbmsgaXQgaXMgYmV0dGVyIHRvIHVzZSBremFs
bG9jIG9yIGttYWxsb2MgaGVyZT8gSWYgaXRlbSBpbiB0aGUNCj4gDQo+IGRlc2NyaXB0b3IgaXMg
bm90IHN1cHBvcnRlZCBieSB0aGUgZGV2aWNlLCBpdCB3aWxsIGJlIDB4MDAgYW5kIHRoZW4gdGhl
DQo+IA0KPiByZWxldmFudCBmZWF0dXJlIHdpbGwgYmUgbWFya2VkIGFzIGRpc2FibGVkIG9yIG5v
dCBzdXBwb3J0ZWQgb24gdGhlDQo+IA0KPiBkZXZpY2UgZmVhdHVyZSBjaGVja3VwIGxvZ2ljLg0K
PiANCkFncmVlLCBiZXR0ZXIgdG8gdXNlIGt6YWxsb2MuIERvbmUuDQo=
