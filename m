Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A76AD6EFB52
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 21:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233555AbjDZTtu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 15:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbjDZTtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 15:49:47 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ED9DE5A;
        Wed, 26 Apr 2023 12:49:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i8KMV3mK03GZXcaj/gk53Q5ZX/erdEiGcPzY92SknqiIUIawX2+idP6DRzlmlELYogfg7cyKiAiVJhaOH3uPCFjAeJv90G7DLyyuQwau1IYEE995lXTpgj9PviaVFeI1z5CT+BbLv0xa6IiR4eVtTpvrwuV1AjOGdSy82PHfMiteYoeWknqdqWgGGbc9q6C8kXN5wmjjGQQW8+OPJdE6TFZtKGloN8Tj9HnwUHXtpMWAw+Aop0puFSA3rPpdHqQyeKBUq4xv4WZuYUkc7e65CwkfuT+W2Fkto1a6siGmma7XLkGxd8dHfjB4iZPEBFwMZJ1xKUDOo9uQT9hpvhSakw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VTxxftcQuFR742AHDJMeFoL2sqQ/0JtZTAb3Avu0bv8=;
 b=UuY8NAqDh16W/CCFW3IlZY8zxsa0oAxXh4KQRUllKeC4D/AxWeTP2rPPFtytMhN8Dglc7EE/DnPF0XIDLf5lq/Be2zQJTieSkYimLANQb4KlL+cMcNQ2RPJ2tyKeFuk2ZRMKsrXSsqa+AW1nslBf57Z2KN8CXlbNMkmlPaxBwt0NaXjqTqnA1KR+7yQ6AqiTIiOHmEcSU+owxXG69PoTVdC55UVp8Eti5smWPJukRLxt+ZooKKVTFnj1R6PvOa4qMbT0KMMV+oqbegnRYvON8o/M/KRR6WDWGtcYDQWQEvrrqHNE29C+ZXDttanmNLYUYev0BdRr3ohvErGKTk/Nww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VTxxftcQuFR742AHDJMeFoL2sqQ/0JtZTAb3Avu0bv8=;
 b=PoF2lHwg77pY1C3blpw5uFIxNhGQshO9JLj7FhFzDwKrot96rUTHSNwCH9eMu3X3lY4nxsanXw8vhTm/prph2JS8ZIklSeWHLVMU9xzuL1MWhkt9+GdnfhV81qvCVT+m7EU4rSLViZjqBdzXfJV/XOGQgniQYbHsNb7cYJefcD8=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CY5PR12MB6228.namprd12.prod.outlook.com (2603:10b6:930:20::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.34; Wed, 26 Apr
 2023 19:49:43 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3f45:358e:abba:24f5]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3f45:358e:abba:24f5%3]) with mapi id 15.20.6340.021; Wed, 26 Apr 2023
 19:49:43 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
CC:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        "S, Sanath" <Sanath.S@amd.com>,
        "Gong, Richard" <Richard.Gong@amd.com>,
        "Mehta, Sanju" <Sanju.Mehta@amd.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 2/2] thunderbolt: Move Intel quirks into quirks.c
Thread-Topic: [PATCH v2 2/2] thunderbolt: Move Intel quirks into quirks.c
Thread-Index: AQHZdubWAcb5sEiBAE+bsaAPEhDC6K89bt8AgACTl/A=
Date:   Wed, 26 Apr 2023 19:49:42 +0000
Message-ID: <MN0PR12MB61014BF2B5C3B36ACAE7E7D4E2659@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <20230424195556.2233-1-mario.limonciello@amd.com>
 <20230424195556.2233-2-mario.limonciello@amd.com>
 <20230426110040.GA66750@black.fi.intel.com>
In-Reply-To: <20230426110040.GA66750@black.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-04-26T19:49:40Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=0df7eecd-8759-4540-bccf-0dc5b3d51f5d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2023-04-26T19:49:40Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: e6169c07-4493-44db-9a91-838ad50cec48
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|CY5PR12MB6228:EE_
x-ms-office365-filtering-correlation-id: 27bd0a54-2101-4133-ef13-08db468f60f9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X9bcFe957KPEhj3+f1Sq87oOrB6Fa6UVwol0r5UI+lB1WFBABd8q8JWWREYqixIrclEDsnOS/2xbwP9yrcuiucNMgSXzgKngw4KVkVablJEp/IWQjPgtEIQPEu4vIIoGCBbZZf1Do33z52iYmLWdeHmj/1iQW+AS1moYnMBoDuzzIPSU3swBLXJn1OTmSIiqrLDZfo8OrCQGLIgYJtqytifw54TW5T9sikZCDmLC8yVRa2YcyaLavYo9pFF48lPWIZMkdBiORrBFARhGzfNdiqAHEP9AevvPreY8RjemyGExZJ3CMyUJo0J+LKJXhUbVktLK+XhGDX9P+91rx7Arh9oU/qT70f5dFJ9nHgs9eJiRdffYwFxZ/p05yQMYYBpBzRt3yVzdQhcXSetxfRyBMhKdHUVLkjNhnVScKi86jHA1cihP4JTsphr6OwwnKVZ9EyE5bF/OJFgehFoUKJxn8wU1TcX8rA6Az4vfRlYjm1kI6mfpVIzzZzTQng+egVMdHCHl0yblV9FlTCDnq8s3myJfKulFNRNZ7+C1SiRKkBMYsunbW+SDpR822DJBpqtPyzLaIKiQl09rracB5/hKoqi9go435RJkglAxTBjYWNFm9zM64ai0TRWhFdAdnO1H
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(396003)(39860400002)(366004)(136003)(451199021)(66476007)(66574015)(76116006)(54906003)(478600001)(4326008)(7696005)(9686003)(186003)(26005)(71200400001)(6506007)(52536014)(5660300002)(2906002)(122000001)(38100700002)(33656002)(86362001)(41300700001)(66556008)(6916009)(64756008)(66446008)(66946007)(55016003)(38070700005)(316002)(8676002)(4744005)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aDlCNUFsOHljbWhIZkZsa25GSmRvWVQydmRZOFQ3NVo4V2ljZU5HaysvQTJF?=
 =?utf-8?B?UGlqMjNhSS80WHREM1VJT0ZKeDZXNmNuM2UxWFpOVDF3NGtzU1RlOUNGNGkv?=
 =?utf-8?B?WGw0TVNSOFhLdzVkenE5RENlZ0lHNDIzRExzeFNIZ25NcmJjM0VNQWhKN1p3?=
 =?utf-8?B?Q24ralNGNDdwbHAyZmNldURIUXpMR01kc2dLdmUvWDhMUW13di8wZHcxYjda?=
 =?utf-8?B?WTI1L0V2SEtmVHZDbE9iaWRtTDkzY3g3eFZxT05tL2xOTDhjRmtaYjJnd1Nu?=
 =?utf-8?B?cHUvcGpzUzlwd3hUcjFSN3NHalBsS25VeU5JUnozeHNMd1FvZ0xCS0NmVVk4?=
 =?utf-8?B?MG9xWXJtVDdhdFRUYTlodGhVem9FRnZWdFlnMmdOaDhvUU8yWkhNVUpxbXgw?=
 =?utf-8?B?N3ZKKysvU0FzclFTR1dRbzhsRXNrUmcxRUJkbTk1OXNLUXlpTzhHYzY3Y0VN?=
 =?utf-8?B?NjNnVTJoKy94QTIxWXV0M0NOTVhZYmtuT1k3eW42MFpHbTh1UzhQcGcwVUhw?=
 =?utf-8?B?SVZ2elE3QURSbndnSjFVKzNjYVFGNXhVRW1IQUdmcXZWeGQ3NkxDV3poMXp5?=
 =?utf-8?B?QnhPWnJMem9IZGw3OWNwQWNpeDdQN1BEajdmRGxqenlkbE56aGtBRmNKT28v?=
 =?utf-8?B?WHdZNGd6cmlrVDVPVlZndzg2c3diS2ZuakUzbGdGY0hVR0Z6UEw2OFVxQWhP?=
 =?utf-8?B?NkdpUTcvQXYrQUhLd2pVWWd4NEFuc2IrRStFREN4d3Bhc0hPblQ5eFVqWXNn?=
 =?utf-8?B?OTJxajlHWEovU1BNYlFBRUpRMFVmRE0yRm0vSm01Wm9peGFXVTEvQkNSZXha?=
 =?utf-8?B?WjBlTEhaTk94UUNOcHRJVE1nc1pZYVoyaGJ2d1JpSE80aE8zSjVXNStRbWtt?=
 =?utf-8?B?YlRuRXdxR3hBNSs4VFpIMlkrTHpKckpjTDdJMEJhZUUrL3Q0ZkdUYW80anRR?=
 =?utf-8?B?T0dwTWh1QWM2eDRqUG51ZE1uU0w0dUd2UGhGZ21IZ0ltVHVra2tBU2xCclZV?=
 =?utf-8?B?OXoyUGh4MFIwdUFrTUhvWDFHd1JiYktzVzc0cGZTZU5yaXRPT0FqTk5XR25C?=
 =?utf-8?B?d2I2NlBOVHh3TXh4TTZyUWNHc3VnaUVxRkNlNWNoSExkL3VaeW1wSU1uTktx?=
 =?utf-8?B?bkVtazFDRVpPb21rcTdYakZMMHpnOUVSQ2xDbXlJM0o5K2djWXViREpENHZx?=
 =?utf-8?B?bmRFeUVoZ3dnTUdkSXdOUU1leDlIM1BhL3BZOXBINzRudm1URGp5UEVBUkJG?=
 =?utf-8?B?Mk5TejVVZ2xjWEMySWVGWWZlQy9HRVJrUWZ6eEpXVFpGYURiVHRweTZBalMz?=
 =?utf-8?B?VEV2NDd0ajJ2NDJ3Y1RCNWt4dGVrcGdGeEw1ZEk0MkthMDhwcEhTK1BDR09D?=
 =?utf-8?B?ZndwcVo0U0gvd25ETmVidmJHSnFKdVVYNWpVUXdlOUZMd3lqcUJPQkExV0Mr?=
 =?utf-8?B?ZUZLSUxmMWNKTnl1Si9NbFhtUXloMlh4QnNpM3R0bS94OTU1WnJvZnN6R0tO?=
 =?utf-8?B?RkFCNlI5YWU4QTlGSFRrdFBlZHVDR3gyN1RqdFA4NURvVzdGa0MrTnU4SlFi?=
 =?utf-8?B?Qm1FNCt5K1ZrVmltRDFyVnRkMzlwRUVJcC8vN0lPZHVXeGxxRWlMTjVVdmQy?=
 =?utf-8?B?TFBPcGF6elNUYm9xRlJhemdEbjFjL3JFR25DdXJ4Y3lUeFFuVTJ2RFppSnN5?=
 =?utf-8?B?ajZuUkNBVFdXV1RQTnhKKzRneHRiTmxFeE10TUJIOVoyWjZWRUFUUHB3a3VW?=
 =?utf-8?B?RFE1WnZjTktHdEpiUW4ybUxCK0dhU1FuSDhnM2l1ZUJUdHlzWDd5emtPUFFv?=
 =?utf-8?B?Mnp5NEtvQ3lkbFBzUi8vbTIrODcweFhJc0dXbXJpZzlMMVNKUDU2d2ZrTFAy?=
 =?utf-8?B?YnI0MlFia3FoS25nZHJzVGNhRWNNTjdTSlczejRodGdCSTdFYml4K3FRTW96?=
 =?utf-8?B?QXdnN0prZ01VaE1BMWFYOHVNUXpiU3MvK0o2bVh5NElRU2VwK1V2QTlnc3M5?=
 =?utf-8?B?ZDFlVHJTSzlVcVFhV3VIVU1keUg4N053NVV3S0NpTEZab3RJckJHbXVQSnMy?=
 =?utf-8?B?U2RMUGV3SWRBeUZJa0ZDTzloTG9PaW1QWnZJYlBvL1FLMWlKNDdvUHp3VGY0?=
 =?utf-8?Q?lhaw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27bd0a54-2101-4133-ef13-08db468f60f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2023 19:49:42.3971
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RK5aPu4AsS1NYzQlX6oU36mLWtdMw5MY0BtKpuiKHLrkQVqZkdgGFpTnrb/4swU1hlit4IT+KSSsxHVisjf1OQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6228
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W1B1YmxpY10NCg0KPiBIaSwNCj4gDQo+IE9uIE1vbiwgQXByIDI0LCAyMDIzIGF0IDAyOjU1OjU1
UE0gLTA1MDAsIE1hcmlvIExpbW9uY2llbGxvIHdyb3RlOg0KPiA+IFRoZXJlIGFyZSB0d28gSW50
ZWwgc3BlY2lmaWMgcXVpcmtzIGZvciBhdXRvIGNsZWFyIGFuZCBlbmQgdG8gZW5kDQo+ID4gdGhh
dCBhcmUgbm90IHNwZWNpZmllZCBpbiB0aGUgcXVpcmtzIGZpbGUuICBNb3ZlIHRoZW0gdG8gdGhp
cyBsb2NhdGlvbg0KPiA+IGluc3RlYWQuDQo+IA0KPiBxdWlya3MuYyBpcyBmb3IgVVNCNCBkb21h
aW4gcXVpcmtzIChyb3V0ZXIsIHJldGltZXIsIGFueXRoaW5nIGFjdHVhbGx5DQo+IGNvbm5lY3Rl
ZCB0byB0aGUgVVNCNCBkb21haW4pLg0KPiANCj4gbmhpLmMgaXMgdGhlIGNvcnJlY3QgcGxhY2Ug
Zm9yIGhvc3QgaW50ZXJmYWNlIHF1aXJrcyBmb3Igbm93Lg0KDQpPSywgdGhhbmtzLiAgSWYgbm8g
b3RoZXIgY2hhbmdlcyBhcmUgbmVlZGVkIGZvciBwYXRjaCAxIHBsZWFzZSBqdXN0IGRyb3ANCnRo
aXMgb25lLiAgSWYgY2hhbmdlcyBlbmQgdXAgYmVpbmcgbmVlZGVkIEknbGwgZHJvcCB0aGlzIHdo
ZW4gSSBzdWJtaXQgYSB2My4NCg==
