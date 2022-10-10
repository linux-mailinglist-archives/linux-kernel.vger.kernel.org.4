Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35BCE5FA778
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 00:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbiJJWBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 18:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiJJWBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 18:01:17 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2089.outbound.protection.outlook.com [40.107.101.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDA2461728;
        Mon, 10 Oct 2022 15:01:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gVAf4wZNCz/esvc8pUmbWZMS0SH83nwO6gExoYWKNKwSTEFbbSEnOVGmDNdUKjVX8MBw+1VrKXrvywaWVJFr2S3fL7OCUhRUoPYCWbPYp4BRJFICSAZp03ppdEbaWCRQz8pyy3z5QgNis5jMJ84yzDxIG3UwG34k+SOCgLAW7U9DiCk1mrrOGShobG7VDJGirLUsIcqOgUeHRB/n7B5jV3B8TqJOwAZJzyhVcFupADqYG0hy/+NNP0Zd8U4DWTGyLx42KhlIpovWm82zointQq4YkO1zuQX8RQ40AcB3DaFOIDvLmv4bpNH4/d1lvC0CreJBQKAwbQGviLKfVbOlGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G7yG0Hyuzv/Z6hdlpJOhDo46mp4vCUKVzeR0/smonvI=;
 b=PTP0K9k9sya1EfIdcaXsC4q1f7r+z9WQ2S3++yd8mA9bxTnsvGLmj91nrAUjuHzhazmql+0ZJyqyLSipFc0ww0ingD2oJES/GCc8+SyxFDG9UfXkcgi0/o724bmAdcQ/GTQBf01fjSVi3ibN+WLQLJoA/BsIcglFzcJCKw8mZsIwchGoP9rFFi6IAZ49DdzmfSLCwwal1ByzUcfkOgHHby6sniVHXBm8yVoIOfOvuGa16sXqWzqAY5LyDDubquASeM9+Nt+lGWc7UNZjjJ0Gq9g9U9mNk/rE911lqG73mkvTfjThJNDN2iI7P2oSFWL0CPAz3Edbb61lt1OBc/n5WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G7yG0Hyuzv/Z6hdlpJOhDo46mp4vCUKVzeR0/smonvI=;
 b=zhjZC6BdYdSPUFuID1j+ntpSyiEbNMofQ8dez6Hpc21WyAunFGB+WcFNLJYQbQPtwmO34tB4PqHuA/H6sVRV2Dt8bAu+i8yyab6rC1cexgmVMgt5/bsHsHR9xKRWm8NXXUcaylnsiAHGNzwKpGAP6jpnIO+Oqq5sJtPgwadeSQo=
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by MW4PR12MB6706.namprd12.prod.outlook.com (2603:10b6:303:1e2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Mon, 10 Oct
 2022 22:01:14 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::2d5:77ac:6d39:e57b]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::2d5:77ac:6d39:e57b%7]) with mapi id 15.20.5709.015; Mon, 10 Oct 2022
 22:01:14 +0000
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
Subject: RE: [PATCH v6 12/12] Documentation/x86: Update resctrl_ui.rst for new
 features
Thread-Topic: [PATCH v6 12/12] Documentation/x86: Update resctrl_ui.rst for
 new features
Thread-Index: AQHY3OcrRKalZCpQ8EWuO2j/so63B64IJUmAgAAFoXA=
Date:   Mon, 10 Oct 2022 22:01:13 +0000
Message-ID: <MW3PR12MB4553F83C5D83E46A2D20BDA495209@MW3PR12MB4553.namprd12.prod.outlook.com>
References: <166543345606.23830.3120625408601531368.stgit@bmoger-ubuntu>
 <166543384024.23830.1715326237069935949.stgit@bmoger-ubuntu>
 <915c3983-e65a-da98-120a-1aa70b9fea3a@intel.com>
In-Reply-To: <915c3983-e65a-da98-120a-1aa70b9fea3a@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-10-10T21:50:49Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=5ed378f7-9821-478a-8303-b68b1e84d2a5;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-10-10T22:01:12Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: a3f6014d-352b-4d1b-9455-3e20c834dcf1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR12MB4553:EE_|MW4PR12MB6706:EE_
x-ms-office365-filtering-correlation-id: a6713f9b-95f0-4555-3aa0-08daab0af2f0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hBdAaN9UqBbeCOY1+9iX5VZ2NwvTNMSFJ8c3tMLG5OBkcj3PLTrAjhb6czbgS3YZbSDehxgtS2/o9LuarooHnPM4HObT6l8cjKebaO1yG2YgYwbM+cVNmqW5jydTM3LnqCHzm0oJxG8pw1dsVr2ZPvbHT8abXkHfSzX7ghaxAJtRdD9axveUtC3a48gVIGMB89QwTqJDd1OfiXDRu5R+kUqlzgqxHkXMhENldskc9XBYG+kQDTux6anf3WZgREILVD1E+/bK44tgXcnXo5NhX23ryuPAZ76489KHKhWlCKWCWs6MhxFNKAFAVRR+2+31zPLGkhbJ+mfGjf/keUsp7TL12TYwwrEFjfH6hYScfx7X3H5qgk4c6P69i06VuEX1prFrllmLSxZnGxe61AUIr7upg7q0WiAKB0GtnDuO4e0IGoZ8BQg7nqV1u80ZY/zNakL1IvsOt3Y7geA1yqXUEiHoJgs5T4K8S5laTAGi4934zmgQYtqb1Z2qvq1rnXVU4agvTC+pAMpmf8YtNWzky4p7rkAMLzAcBS83QdaCGzmoOVRZ9qvEfPVuGbyxvKo9d7REPSLbDSwiIGvwF2Op0+VGO8uVMP4XewDq50kAd0t1EzUCJCvCKT2I156+qL7CUWpNIs5hSGGfwQqphNP7uVy1g7osOzqLpZEMZ1ZCwHL78uouFuidKoAf9of7dlBpDLrh/6N3fBG9/LLQ25kq93rKu618cCsu4L3y/j5B8qOYeSZUQlri/Tj8gVuf+NBvRkgGtKugdCbtEDmBDAoGaA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(376002)(396003)(346002)(39860400002)(451199015)(186003)(66476007)(66946007)(83380400001)(66556008)(8676002)(478600001)(76116006)(71200400001)(4326008)(110136005)(8936002)(54906003)(122000001)(66446008)(55016003)(316002)(7696005)(64756008)(38070700005)(15650500001)(9686003)(52536014)(86362001)(26005)(41300700001)(33656002)(6506007)(2906002)(5660300002)(7416002)(38100700002)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y2pPZVZtSXZJL25hbFAxM2lNYkFhYlBWTXIwSlZOcmxoVlBqQmxiTFo4di9y?=
 =?utf-8?B?RllFVHY5OHdlcWh2dXp3cWp2OFExQW9LbEg4R1lwWW5rTGw0K2NzRCtSU2oy?=
 =?utf-8?B?YlppS2hia2xoV0E4VmNnZWoxMUJEZGV3TjJjT0dwWHJIMnhueUZqTzg2Q1pz?=
 =?utf-8?B?QnJpQkJ1bENNd1R6cHRzRlRPbVpXVE9qbVlNRGFXVmRFSVJEM24yT3lWeWs3?=
 =?utf-8?B?cGJHU0M4dS9kTDBmNFJXaWFadXB2Zk9hZzJ5Ti9IOWVGcFRZd0k4Mnh4d1dD?=
 =?utf-8?B?WkE4cmE3dkc3RG5pdHQzZFViUnkyaFBScm5HcG96LzdWSzNIdUViTHdoc0dq?=
 =?utf-8?B?aFVBSTI1eWtEVjc1cG9ldEprdWlYemFIMVRWekNQUUcraVRLM0ZSdEZHUlZy?=
 =?utf-8?B?aklzUyt3S0l3cW1zcHBiUGFYcGlFTmc3RjFUYmNyM2dkRDRxcmhRSHo2TFAx?=
 =?utf-8?B?UEZhQUdmVlgvb2djR0hseGVKNmp1SnczcjUrUUVyclJUemRWeUZyMWMwcXRw?=
 =?utf-8?B?ZGM5S1A2TFRLV0NEUm9QMTBFS1RpdnZjWm9XNXhxUm5Eb21zaDk5WWVMNjYy?=
 =?utf-8?B?THNCOElXQ0EvbDNoS3BYRjViSkJORTZmbWt1Um41ZGxDKzFkR0NHdUMwN2Z2?=
 =?utf-8?B?Um03NVlVZGRyUzZrQ0wwdWJyTC8valdzV1ZMdWZMdld1MXdkZnNkU0dWNFhB?=
 =?utf-8?B?RTEvOC9EVEZvTTNQaXZ1dXN6bE9ZdFU0L2dDcUk0b3Y1N0hSZkNTcWlkYThx?=
 =?utf-8?B?QmhlYmRVTjNxWE1aSW9lTGg0cnNyY3M5S0o3ck43c2gwZTU1THNYUzZyZUlV?=
 =?utf-8?B?Tk5rUjBrUUF2VEU5Q05RcVBvczZEenFHSUtKSm0ycm5WQ2RvZmdvcDQxOXRP?=
 =?utf-8?B?Y0Rqb2NqUlAzTUZTbUFjc003Umk5WWhSbmVoQ0Z1dHlGM1JTTFdGRnpYQkF5?=
 =?utf-8?B?WGZqK0svR1BwWTBxN2luVU5PT3dLL0VHa2htYzUwanhFVHY4MUlzcXM2TkZh?=
 =?utf-8?B?ckNYSG1rYmlnWVg5aytCSFo3Y1QwKzBzUHpuR1JsVHFSYWprWFdJeTgvT2g5?=
 =?utf-8?B?TFQ4YnhSS1NGMmc0SHRDTjFIZG1pKzdrSGV5SDYzODI0N3U5MW9MVWJERGhG?=
 =?utf-8?B?QWk1bVlEMFhPSnBqYmlTcGdTWER0UWQ3anhkYUtvNCt0YllnSVNyWGg1RDl0?=
 =?utf-8?B?MUJmYUNYRU9vMXBQM1BCRHdYQVN6Z2lXMExuZjd2K0oyMXJhbGdLY0doY2pU?=
 =?utf-8?B?NHovaHlDZUFMN3djRFJkY08yS3ZxUDNxRmYyeXQ2dWF5R2lCeHlqK1k1cktW?=
 =?utf-8?B?bVc2Nk5FaUZ4RXdTZGhMaURDaGtvR01YWHZWcnIwUVgxdEYrZzZYczlXZks4?=
 =?utf-8?B?VU4zQkFFVkdyUTNvQWpnN09HZTA5NlBkY20xekIyNURYZkdTWnR0aHdpRGFj?=
 =?utf-8?B?SGhUOHIvYWhGamp4UjFVSlByMkFhV1NTNkJNUzRGVjVvTGtCalRhZTZxbUZa?=
 =?utf-8?B?ejdGY1lQd1hsU1JSVUJCSFFoUU1TWFEzNHNUcEpKMkx5eUpROGd4MWFsNHFo?=
 =?utf-8?B?bU8yQlJDN09XYVVMSzBNTUs5TUVoNEl0U1kzNktlYmVFby9SbWovZEl1TmZ1?=
 =?utf-8?B?TWRqanhGN3RLZ09qQVA2YUhVaVluRVNMMXg3ZEJ4YlkrUjVEU1NUVG1uUUUx?=
 =?utf-8?B?VlNweHFTRFhyRHdLWVR5Z2N5WHhjRDlqdFZkRUw1ZE5wNW9XNnF6cHpWTkJV?=
 =?utf-8?B?R0YyM0I5cm5KM2g1elc5UjRvSDZ4RGFXdWZPRHFQeGhTSkZER21TMGlyREJO?=
 =?utf-8?B?TURxOHZLSUNuWmNCODByd2Z3TzdHa01TMHRlZ25MV3BCdzNhTitmTGUwNG8r?=
 =?utf-8?B?RW95dmtLMW9aRGMzTkZTdUFTeW5OZUVpWXA4WUtZTm44SjEzR3FtTWZodkVm?=
 =?utf-8?B?VU1hcEpwR0VheWphMFpIVHdoaHcwc0VmZmhOdEFXOHU3RlVTR2grdi93NkJ6?=
 =?utf-8?B?QXpPeDhjNEtCWHBSUndSTjRIMXY0ZlhublFIU1JiT2hzeEdiYmQxeWlkblRC?=
 =?utf-8?B?MVNjb1p6YXk4RjVZdU9VcmJadmtKeXVKMlJKQ1hEaklBb1RKRVZpbk1pYkZR?=
 =?utf-8?Q?MkUI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6713f9b-95f0-4555-3aa0-08daab0af2f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2022 22:01:14.0042
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LSBhLoBMoToVWJm1Hz9Ncq4PsbD3ZU5WAJxObWWkxM5hKRmBhTHv42WtQlO9M8Rv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6706
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkhpIFJlaW5ldHRlLA0KDQo+IC0t
LS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFJlaW5ldHRlIENoYXRyZSA8cmVpbmV0
dGUuY2hhdHJlQGludGVsLmNvbT4NCj4gU2VudDogTW9uZGF5LCBPY3RvYmVyIDEwLCAyMDIyIDQ6
MzEgUE0NCj4gVG86IE1vZ2VyLCBCYWJ1IDxCYWJ1Lk1vZ2VyQGFtZC5jb20+OyBjb3JiZXRAbHdu
Lm5ldDsNCj4gdGdseEBsaW51dHJvbml4LmRlOyBtaW5nb0ByZWRoYXQuY29tOyBicEBhbGllbjgu
ZGUNCj4gQ2M6IGZlbmdodWEueXVAaW50ZWwuY29tOyBkYXZlLmhhbnNlbkBsaW51eC5pbnRlbC5j
b207IHg4NkBrZXJuZWwub3JnOw0KPiBocGFAenl0b3IuY29tOyBwYXVsbWNrQGtlcm5lbC5vcmc7
IGFrcG1AbGludXgtZm91bmRhdGlvbi5vcmc7DQo+IHF1aWNfbmVlcmFqdUBxdWljaW5jLmNvbTsg
cmR1bmxhcEBpbmZyYWRlYWQub3JnOw0KPiBkYW1pZW4ubGVtb2FsQG9wZW5zb3VyY2Uud2RjLmNv
bTsgc29uZ211Y2h1bkBieXRlZGFuY2UuY29tOw0KPiBwZXRlcnpAaW5mcmFkZWFkLm9yZzsganBv
aW1ib2VAa2VybmVsLm9yZzsgcGJvbnppbmlAcmVkaGF0LmNvbTsNCj4gY2hhbmcuc2Vvay5iYWVA
aW50ZWwuY29tOyBwYXdhbi5rdW1hci5ndXB0YUBsaW51eC5pbnRlbC5jb207DQo+IGptYXR0c29u
QGdvb2dsZS5jb207IGRhbmllbC5zbmVkZG9uQGxpbnV4LmludGVsLmNvbTsgRGFzMSwgU2FuZGlw
YW4NCj4gPFNhbmRpcGFuLkRhc0BhbWQuY29tPjsgdG9ueS5sdWNrQGludGVsLmNvbTsgamFtZXMu
bW9yc2VAYXJtLmNvbTsNCj4gbGludXgtZG9jQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVs
QHZnZXIua2VybmVsLm9yZzsNCj4gYmFnYXNkb3RtZUBnbWFpbC5jb207IGVyYW5pYW5AZ29vZ2xl
LmNvbQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY2IDEyLzEyXSBEb2N1bWVudGF0aW9uL3g4Njog
VXBkYXRlIHJlc2N0cmxfdWkucnN0IGZvcg0KPiBuZXcgZmVhdHVyZXMNCj4gDQo+IEhpIEJhYnUs
DQo+IA0KPiBXaXRob3V0IG9wZW5pbmcgYW55IG9mIHRoZSBwYXRjaGVzIGZyb20gdGhpcyBzZXJp
ZXMsIGJ5IGp1c3QgbG9va2luZyBhdCB0aGUNCj4gc3ViamVjdCBsaW5lIG9mIHRoaXMgcGF0Y2gs
IGl0IHdhcyBpbW1lZGlhdGVseSBjbGVhciB0byBtZSB0aGF0IHlvdSBkaWQgbm90IGZvbGxvdw0K
PiBteSByZXZpZXcgZmVlZGJhY2suIExldHRpbmcgeW91IGtub3cgYWJvdXQgdGhlIHR5cG8gKHJl
c2N0cmxfdWkucnN0IGRvZXMgbm90DQo+IGV4aXN0KSBpbiB0aGUgc3ViamVjdCBsaW5lIHdhcyBv
bmUgb2YgdGhlIGZldyB0aGluZ3MgSSBtZW50aW9uZWQgYWJvdXQNCj4gdjUgYWZ0ZXIgdjUgYWxz
byBkaWQgbm90IGZvbGxvdyByZXZpZXcgZmVlZGJhY2sgZnJvbSBtZSBpbiBvdGhlciBhcmVhcy4N
Cj4gDQo+IFByb3ZpZGluZyBmZWVkYmFjayBpcyBub3QgYSBnb29kIHVzZSBvZiB0aW1lIGlmIGl0
IGlzIGlnbm9yZWQuDQoNCkkgYW0gcmVhbGx5IHNvcnJ5IGFib3V0IHRoYXQuIEkgaGF2ZSBjaGVj
a2VkIG11bHRpcGxlIG92ZXIuIE5vdGljZWQgaXQgbm93LCB0aGF0IEkgbWlzc2VkIG9uZSBvZiB5
b3VyIGNvbW1lbnRzLiBCdXQgSSBoYXZlIGFkZHJlc3NlZCBhbGwgeW91ciBvdGhlciBjb21tZW50
cy4NCkkgd2lsbCBnaXZlIGZldyBkYXlzIHRvIHJlZnJlc2ggdGhlc2UgcGF0Y2hlcy4gWW91IGNh
biB3YWl0IGZvciB0aGUgbmV4dCByZXZpc2lvbiBpZiB5b3UgbGlrZS4NClRoYW5rcw0KQmFidSAN
Cg0KDQoNCg==
