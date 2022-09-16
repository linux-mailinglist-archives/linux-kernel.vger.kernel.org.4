Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFB735BB3E4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 23:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbiIPVXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 17:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbiIPVXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 17:23:50 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2052.outbound.protection.outlook.com [40.107.95.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7F62A00FE;
        Fri, 16 Sep 2022 14:23:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eUoHttRND9otVSu1RCM3Sv8w/xW8f1V/BW3XauvnLiD6dqJuERtm69MQZ8eJOihMkH27dSy0404N0ebo20pYBKpVQ/1rpqVM630OMNioeW0AZWQuPwG2bPM+xHD7l7g83x5Pnu7cKKbb2ls1KliQH2WurnDFCaZPmMYJBcM0QdOb/Yyi9MqBK3BqLudlPzhR36PpsZkDJ4b6LeSU+zVL+PgpzOE4V5/5C5yaCrX2haiHDxesrIDnahbv+veqyBi3wN7oVznv2Pi/CdvLcxn5+Jk54hI8qK7L6WiFJXWqmgomFq655xEfAUrZIXTb+FmyHKrY+U1ObH4s7M3ZlerXMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nRr3m9K5mBdrc4ND50PIsmpFTdzSu2cV5NwCH7CX2wA=;
 b=Dch96g5lStV2haHR1IjbxgNvit/ueejQxs+1+j1Akl+HOLdno3j6UzzLJHF54nqVRbaaKw2+EpwDNmSETH9+lvwoTmIgBLCgjkpK/2ps9T0g/ooFVAKIT+C/KL3EZh93t+Al3CkpAVTi15hrH63BWOokRm3Wdhv2cR8bNJonsjS5j6TP3KG1K30cSm3MMYGNvYhHjp0FrKHpAV2+LY+WiCuQkA2Iuc/FEIKKGLEv8x1xukaC1j9eI4R1eB+tMgWE1e27KstPpCxMjl8Q5TBoNfyMXaeqBLJIl/dNqg1OEtiXppQEJuJrI1+hadfWULsqpT9u4rMTU21xi2oh3Ugu7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nRr3m9K5mBdrc4ND50PIsmpFTdzSu2cV5NwCH7CX2wA=;
 b=S+yace730EjDwos1c3IN3fEvwdCQS87fn+iej6DDpb7yW/gWSW3ptnWJXJRrTlvw/OeVJvqErExjxQ2FrWtMNRYUZK/jTV48vz27BQw3xFefv8y+k+tZmbcJwSUrsuzegB1K9kcsepZ7/dswqFDNeBt0pdlosDMDm8mNRVlzDUU=
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by IA1PR12MB6353.namprd12.prod.outlook.com (2603:10b6:208:3e3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19; Fri, 16 Sep
 2022 21:23:46 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::4120:60cf:46a8:7109]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::4120:60cf:46a8:7109%7]) with mapi id 15.20.5632.016; Fri, 16 Sep 2022
 21:23:45 +0000
From:   "Moger, Babu" <Babu.Moger@amd.com>
To:     Reinette Chatre <reinette.chatre@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>
CC:     "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
        "songmuchun@bytedance.com" <songmuchun@bytedance.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "jpoimboe@kernel.org" <jpoimboe@kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "chang.seok.bae@intel.com" <chang.seok.bae@intel.com>,
        "pawan.kumar.gupta@linux.intel.com" 
        <pawan.kumar.gupta@linux.intel.com>,
        "jmattson@google.com" <jmattson@google.com>,
        "daniel.sneddon@linux.intel.com" <daniel.sneddon@linux.intel.com>,
        "Das1, Sandipan" <Sandipan.Das@amd.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bagasdotme@gmail.com" <bagasdotme@gmail.com>,
        "eranian@google.com" <eranian@google.com>
Subject: RE: [PATCH v4 08/13] x86/resctrl : Introduce data structure to
 support monitor configuration
Thread-Topic: [PATCH v4 08/13] x86/resctrl : Introduce data structure to
 support monitor configuration
Thread-Index: AQHYwuPLYEtGlcG+UUmid83t9FiGqK3iQ/WAgABbOHA=
Date:   Fri, 16 Sep 2022 21:23:45 +0000
Message-ID: <MW3PR12MB4553D5D73F22B5EBCE8DD55795489@MW3PR12MB4553.namprd12.prod.outlook.com>
References: <166257348081.1043018.11227924488792315932.stgit@bmoger-ubuntu>
 <166257365519.1043018.5600209070890797172.stgit@bmoger-ubuntu>
 <02960d50-6ca3-e64b-8d84-d2234eceded4@intel.com>
In-Reply-To: <02960d50-6ca3-e64b-8d84-d2234eceded4@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-09-16T21:22:52Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=32a295d5-01f2-4776-8873-21f6578dcf2f;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-09-16T21:23:44Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 8b7b1287-e92d-4a8e-90c2-2a0ffee6f8c4
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR12MB4553:EE_|IA1PR12MB6353:EE_
x-ms-office365-filtering-correlation-id: cd729bd9-7541-4cf2-0099-08da9829bd07
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SeOUOlV7lmT1TgocDPuLtSG/kDMe4Sv4FK5HOMnx0X6WGAgKfqERW38oKC1f7/4+KugqAa3s1mhq6sne5ROZ/HKOh5/UUxXEUFK9Zi5TY/5fD2txN2+jV4pArZ/clkNjuBXPJwpvk1uYCzk2Ii6BL3+GdhxuFX89/I8Rx76pApKe9u850cMcPtu2sjX6KQQy9NS5JdEOQKaetqVGeDxU/s8l+gE6OF/jzP1uYPjkcR4folVFWJP0+1FzkouUo8cJBp5AVdUJSbIlT/XqtZOnhpP5b9+s9DSWeB0/bdW7gO7AyTZJz0mWQJqpE0VCRFHRfZoN3zvcut36zbbEy7CPhQagP8L6W49f1SEjWxkvS1JsaNNMaQ4LIjJktKGgBetZLl8UigvlCWVzS5DmrboiEuNyWVi7ohCRMdUBznzuoMa2WzXULW2zzF9I7H9R+3wYYePA+77ICbqmAqgB0GF65GzHEhkGbodngrJd5YYqBI79UFSaEeyqJUzF53BNFlRv4v8X6nh5Q36BJRwJZ6Q6D4G4rDmQj5CMfPk1EWTOexrqvSY6AUm+AWywv7G/3FN4UeShmydqA3uFWLPh47YflH5k0uEXbHl9Y02NgB55qhkk/zDkpuGYJ1Ccrgw0hYyNPGBeDdDPvfNs8KznC1CqgIXjKR67np4UouhVHOQeGR6B+Zz9jen5m/VLXgfFYIbrsVSd8AXJMi+jS+4hpWcqrRA1TKLHvXjw46doGBh7U3SFkHQKw6vBagBmnWJbT7iGFfTKBZuK6KvZb+kcyhuPaQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(346002)(376002)(366004)(136003)(451199015)(76116006)(41300700001)(110136005)(5660300002)(8676002)(66556008)(316002)(7696005)(26005)(53546011)(7416002)(38100700002)(52536014)(86362001)(38070700005)(55016003)(64756008)(6506007)(9686003)(66476007)(33656002)(54906003)(66446008)(66946007)(8936002)(71200400001)(4326008)(83380400001)(2906002)(478600001)(122000001)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MG5lajcxS0JjK0VNNm1LVDBHWkhsNlZJV0tQZFRqWjE2UHBMeUN1RDVBeXFW?=
 =?utf-8?B?Tk50Mk1zb1E3QURVMnpONGxYRGxaU3kwM2J6T3kzVEYyd2diR0EzOHdSMmdG?=
 =?utf-8?B?cjVkRzlubzVOYlFUNURsMk0zc2MyQkZhUE80YlkrQmZJLzFQTldpNWhBM1ZC?=
 =?utf-8?B?bmtSTGdrZEdYcnVmd0xqRFdBa2F0SlFwb3JhMHE4VkIvTTBGY0FDL2FtNEwy?=
 =?utf-8?B?QzJMcHR3Y1dvdkU3WnpNYVcrOVdEaWtTUDVBMHVvc0l0T2h6OG9BbWJnaENE?=
 =?utf-8?B?UUFtaWFjZmVkMmlVa3V4OCtzTm5MU0xCb0svTEZvSll2NXgzR0ZOYjEweE4x?=
 =?utf-8?B?K2xpOWVEV0ROeHppVTlRbkRZWk5wREliaytxdndFbU9uMlN1Z3lnU0FHRkky?=
 =?utf-8?B?bW1DK0J2Rk53Nmh4RXZBajBZdnMvQlo2Tzh4d2V6S3BHUVh5MjcvNzY4d0ZZ?=
 =?utf-8?B?d2RtT3dqNjdHbWpFVmxTd0JZL21xT1R6REZHeFdOM09KY3loekFkZkRtTzJH?=
 =?utf-8?B?VFhCOVh0eUxsamZWM1V4NWpybk5DenZyNU5iR3hPdUxtL3JWd3RRRkh0c25v?=
 =?utf-8?B?bkRKRU41SzlwNkxQN1kyMkNFeHNORnFvVUlnM2E2U1E2Q0VkakxpUkk4UFZo?=
 =?utf-8?B?S1ZMYml6cEdyaGsxSHJ3MzZuVEc2SWdycE0zTEJtbHpUbkJibjAvUE55SFRG?=
 =?utf-8?B?UnAzWk1jQkpqRm5WTHhQTkl1eTlxWjlVL0hYQ2wwZjQveUF1WWZXckZZQjdH?=
 =?utf-8?B?OHQ4eWF5ME92NGJ0SlNNUFJoZ1QxZjFFcG9qTDlHUE9sSndCd1JxcUtndk54?=
 =?utf-8?B?OWN6VTUycUZ3R25rKzBKbFRLc2pHeGMzYVU4d0Urelc1eXQ0OTExdFM4MDJa?=
 =?utf-8?B?NWh0bnFHQlErSlFNbk11Y1ZGelozeVRwalR4VEUzVm9lSkU3VnZScWJ6NjFx?=
 =?utf-8?B?bFFFTU5FS3FYbEtvQ1liUTBpcDh3VGJLQ01KL01lbTJrNU5pZ3FWcWt3YW9v?=
 =?utf-8?B?QlZXY2VTU3BkSXAzVWlwTitpT1B3UE92UkRGaXczT3BlU2g1aENYcEhNK2FW?=
 =?utf-8?B?aDVQbXlHN2hUTlZscGd4TWlJc0RkQ1pEdVp4Z2UvajVaZTgxbkxVL3N1Mk96?=
 =?utf-8?B?OVpiREdKb01nb3RGWmFSaGNjdExWc0Z2eEFvZnBFckVmN0NTY0RaSDFHL0g3?=
 =?utf-8?B?MU9HMHNzK1duQ1VKY1ZoTGJ6Z2JhdEhBQlhSUkNZSWlqbkI3eWJSUlg3Zzh4?=
 =?utf-8?B?UWljM2phZXpBNjV0ZmMyTWg1bzBhZFpURURpNzh4Nm1FQkdBMEZQY3JrSklK?=
 =?utf-8?B?RFlXUkxGcmpQbzVEZEkzSzVzcEhSQWhOMnhmZmg3ZHg2ck0vOUY1QU90QW85?=
 =?utf-8?B?VWpYUk9lZ24vNzN6QWtobjl0SW1saGZydXZXWUVWMWptODRZMzdQODdDUCtV?=
 =?utf-8?B?dFFtUGova0NENEgySUhsVnRaQ3RuSnhwQjBOMjVaYUxnWE5SVWtjYklmRlJO?=
 =?utf-8?B?eVVwVnJZVUp4OXdlLzJaMTFxV09UcDdmLzhKNFhEQ0c0V0hudXZabjhYNlRt?=
 =?utf-8?B?SlJudmFiOVA2SmJnZVBTbk04cSswNjRLeldJcGxEaXN4cXBkdDFRRXVzMGVt?=
 =?utf-8?B?OHVyZzhJMGdLUmNOUkEyRFM5Mk9mamZ6dGgyODl6SXJVWkhLdFY5U0RDYkx4?=
 =?utf-8?B?TmZya2p6c1JPVm5ZZUxqMklqdFNjaS90N2pMdkI5LzErUUdPSlZNRzA3TEQ5?=
 =?utf-8?B?T3hLZXhPcFN4ZCszZDlaSTR1TkNGWkFuc1paK3NXTnkrektkZXA0a2ZGc2hX?=
 =?utf-8?B?TW10ZzQ3MGJzd3phV2hGYnhOZE1mdEhFSnZkeDhCa011RXB2TEg3a0ovalF6?=
 =?utf-8?B?WnlnQjVLUFVTUTdlQTZtOEgwK25YQ3RvNVdJUEFMZUI1c0FOalhaeDIwbWpD?=
 =?utf-8?B?djVmbEJVOG9Xc20zTVdsRHplTWlOTDdzdmdad0FZS2tla0FEWG1tS3UzMlFv?=
 =?utf-8?B?ZUVpMmhPckpwQTllSHZmS0c5TjNMWXRuNWlkNTZ5TDdlSkYrOFhCQUVWZnJQ?=
 =?utf-8?B?a0k1c1orVmZLK2JDRnhSa3JKcWtoUGJLWEU5RkhoOVJwekNURzZwdHJIQzJ3?=
 =?utf-8?Q?1Dyc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd729bd9-7541-4cf2-0099-08da9829bd07
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2022 21:23:45.8137
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MehcV0YlIcp7PdBDhM2jn+K0zkgMmVVAAThGn4kzRPLlUTda7z9GHSiH3dY57HWo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6353
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCg0KDQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IFJlaW5ldHRlIENoYXRyZSA8cmVpbmV0dGUuY2hhdHJlQGlu
dGVsLmNvbT4NCj4gU2VudDogRnJpZGF5LCBTZXB0ZW1iZXIgMTYsIDIwMjIgMTA6NTYgQU0NCj4g
VG86IE1vZ2VyLCBCYWJ1IDxCYWJ1Lk1vZ2VyQGFtZC5jb20+OyBjb3JiZXRAbHduLm5ldDsNCj4g
dGdseEBsaW51dHJvbml4LmRlOyBtaW5nb0ByZWRoYXQuY29tOyBicEBhbGllbjguZGUNCj4gQ2M6
IGZlbmdodWEueXVAaW50ZWwuY29tOyBkYXZlLmhhbnNlbkBsaW51eC5pbnRlbC5jb207IHg4NkBr
ZXJuZWwub3JnOw0KPiBocGFAenl0b3IuY29tOyBwYXVsbWNrQGtlcm5lbC5vcmc7IGFrcG1AbGlu
dXgtZm91bmRhdGlvbi5vcmc7DQo+IHF1aWNfbmVlcmFqdUBxdWljaW5jLmNvbTsgcmR1bmxhcEBp
bmZyYWRlYWQub3JnOw0KPiBkYW1pZW4ubGVtb2FsQG9wZW5zb3VyY2Uud2RjLmNvbTsgc29uZ211
Y2h1bkBieXRlZGFuY2UuY29tOw0KPiBwZXRlcnpAaW5mcmFkZWFkLm9yZzsganBvaW1ib2VAa2Vy
bmVsLm9yZzsgcGJvbnppbmlAcmVkaGF0LmNvbTsNCj4gY2hhbmcuc2Vvay5iYWVAaW50ZWwuY29t
OyBwYXdhbi5rdW1hci5ndXB0YUBsaW51eC5pbnRlbC5jb207DQo+IGptYXR0c29uQGdvb2dsZS5j
b207IGRhbmllbC5zbmVkZG9uQGxpbnV4LmludGVsLmNvbTsgRGFzMSwgU2FuZGlwYW4NCj4gPFNh
bmRpcGFuLkRhc0BhbWQuY29tPjsgdG9ueS5sdWNrQGludGVsLmNvbTsgamFtZXMubW9yc2VAYXJt
LmNvbTsNCj4gbGludXgtZG9jQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2Vy
bmVsLm9yZzsNCj4gYmFnYXNkb3RtZUBnbWFpbC5jb207IGVyYW5pYW5AZ29vZ2xlLmNvbQ0KPiBT
dWJqZWN0OiBSZTogW1BBVENIIHY0IDA4LzEzXSB4ODYvcmVzY3RybCA6IEludHJvZHVjZSBkYXRh
IHN0cnVjdHVyZSB0byBzdXBwb3J0DQo+IG1vbml0b3IgY29uZmlndXJhdGlvbg0KPiANCj4gSGkg
QmFidSwNCj4gDQo+IChQbGVhc2Ugd2F0Y2ggZm9yIHRoZSBzdHJheSBzcGFjZSBpbiB0aGUgc3Vi
amVjdCBsaW5lIGJlZm9yZSB0aGUgIjoiKQ0KDQpPaC4gT2sNCg0KPiANCj4gT24gOS83LzIwMjIg
MTE6MDAgQU0sIEJhYnUgTW9nZXIgd3JvdGU6DQo+ID4gQWRkIGNvdXBsZSBvZiBmaWVsZHMgaW4g
bW9uX2V2dCB0byBzdXBwb3J0IEJhbmR3aWR0aCBNb25pdG9yaW5nIEV2ZW50DQo+ID4gQ29uZmln
dXJhdGlvIChCTUVDKSBhbmQgYWxzbyB1cGRhdGUgdGhlICJtb25fZmVhdHVyZXMiLg0KPiA+DQo+
ID4gVGhlIHN5c2ZzIGZpbGUgIm1vbl9mZWF0dXJlcyIgd2lsbCBkaXNwbGF5IHRoZSBtb25pdG9y
IGNvbmZpZ3VyYXRpb24NCj4gPiBpZiBzdXBwb3J0ZWQuDQo+ID4NCj4gPiBCZWZvcmUgdGhlIGNo
YW5nZS4NCj4gPiAJJGNhdCAvc3lzL2ZzL3Jlc2N0cmwvaW5mby9MM19NT04vbW9uX2ZlYXR1cmVz
DQo+ID4gCWxsY19vY2N1cGFuY3kNCj4gPiAJbWJtX3RvdGFsX2J5dGVzDQo+ID4gCW1ibV9sb2Nh
bF9ieXRlcw0KPiA+DQo+ID4gQWZ0ZXIgdGhlIGNoYW5nZSBpZiBCTUVDIGlzIHN1cHBvcnRlZC4N
Cj4gPiAJJGNhdCAvc3lzL2ZzL3Jlc2N0cmwvaW5mby9MM19NT04vbW9uX2ZlYXR1cmVzDQo+ID4g
CWxsY19vY2N1cGFuY3kNCj4gPiAJbWJtX3RvdGFsX2J5dGVzDQo+ID4gCW1ibV90b3RhbF9jb25m
aWcNCj4gPiAJbWJtX2xvY2FsX2J5dGVzDQo+ID4gCW1ibV9sb2NhbF9jb25maWcNCj4gPg0KPiA+
IFNpZ25lZC1vZmYtYnk6IEJhYnUgTW9nZXIgPGJhYnUubW9nZXJAYW1kLmNvbT4NCj4gPiAtLS0N
Cj4gDQo+IC4uLg0KPiANCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYva2VybmVsL2NwdS9yZXNj
dHJsL2ludGVybmFsLmgNCj4gPiBiL2FyY2gveDg2L2tlcm5lbC9jcHUvcmVzY3RybC9pbnRlcm5h
bC5oDQo+ID4gaW5kZXggYzA0OWEyNzQzODNjLi40NTkyM2ViNDAyMmYgMTAwNjQ0DQo+ID4gLS0t
IGEvYXJjaC94ODYva2VybmVsL2NwdS9yZXNjdHJsL2ludGVybmFsLmgNCj4gPiArKysgYi9hcmNo
L3g4Ni9rZXJuZWwvY3B1L3Jlc2N0cmwvaW50ZXJuYWwuaA0KPiA+IEBAIC03MiwxMSArNzIsMTUg
QEAgREVDTEFSRV9TVEFUSUNfS0VZX0ZBTFNFKHJkdF9tb25fZW5hYmxlX2tleSk7DQo+ID4gICAq
IHN0cnVjdCBtb25fZXZ0IC0gRW50cnkgaW4gdGhlIGV2ZW50IGxpc3Qgb2YgYSByZXNvdXJjZQ0K
PiA+ICAgKiBAZXZ0aWQ6CQlldmVudCBpZA0KPiA+ICAgKiBAbmFtZToJCW5hbWUgb2YgdGhlIGV2
ZW50DQo+ID4gKyAqIEBjb25maWd1cmFibGU6CXRydWUgaWYgdGhlIGV2ZW50IGlzIGNvbmZpZ3Vy
YWJsZQ0KPiA+ICsgKiBAY29uZmlnX25hbWU6CXN5c2ZzIGZpbGUgbmFtZSBvZiB0aGUgZXZlbnQg
aWYgY29uZmlndXJhYmxlDQo+ID4gICAqIEBsaXN0OgkJZW50cnkgaW4gJnJkdF9yZXNvdXJjZS0+
ZXZ0X2xpc3QNCj4gPiAgICovDQo+ID4gIHN0cnVjdCBtb25fZXZ0IHsNCj4gPiAgCXUzMgkJCWV2
dGlkOw0KPiA+ICAJY2hhcgkJCSpuYW1lOw0KPiA+ICsJYm9vbCAJCQljb25maWd1cmFibGU7DQo+
ID4gKwljaGFyCQkJKmNvbmZpZ19uYW1lOw0KPiA+ICAJc3RydWN0IGxpc3RfaGVhZAlsaXN0Ow0K
PiA+ICB9Ow0KPiANCj4gUGxlYXNlIGVuc3VyZSB0aGVyZSBpcyBubyBzcGFjZXMgYmVmb3JlIHRh
YnMgLSB0aGlzIGlzIGEgY2hlY2twYXRjaCBmYWlsdXJlLg0KPiBSdW5uaW5nIHRoaXMgc2VyaWVz
IHRocm91Z2ggY2hlY2twYXRjaC5wbCBlbmNvdW50ZXJzIHNldmVyYWwgZm9ybWF0dGluZyBpc3N1
ZXMuDQo+IENvdWxkIHlvdSBwbGVhc2UgcnVuIHRoaXMgc2VyaWVzIHRocm91Z2ggImNoZWNrcGF0
Y2gucGwgLS1zdHJpY3QgLS1jb2Rlc3BlbGwiDQo+IGJlZm9yZSB0aGUgbmV4dCBzdWJtaXNzaW9u
PyBUaGUgd2FybmluZ3MgcmVsYXRlZCB0byBjb2RlIHdoZXJlIHlvdSBhcmUNCj4gZm9sbG93aW5n
IHRoZSBleGlzdGluZyBzdHlsZSBuZWVkIG5vdCBiZSBhZGRyZXNzZWQsIGJ1dCB0aGUgInNwYWNl
cyBiZWZvcmUgdGFicyINCj4gbGlrZSBhYm92ZSwgdW5uZWNlc3NhcnkgZW1wdHkgbGluZXMsIGFs
aWdubWVudCBpc3N1ZXMsIHNwZWxsaW5nIGlzc3VlcyAuLi4gcGxlYXNlDQo+IGFkZHJlc3MgdGhv
c2UuDQoNClN1cmUuIFdpbGwgZG8uDQpUaGFua3MNCkJhYnUNCg==
