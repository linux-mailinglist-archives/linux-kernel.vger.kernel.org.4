Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0A7C627067
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 17:18:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235147AbiKMQSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 11:18:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbiKMQSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 11:18:30 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2081.outbound.protection.outlook.com [40.107.92.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2743B4A9;
        Sun, 13 Nov 2022 08:18:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ltU+dRJXdOU71EuFZBI6DMi46oBmEQDetIpfZRC+w0R/OgcDV1Ufsy+yPCGn1Vp0+AXofgxHjlvir/i2xxRiYWyRpDS/Ughe83b2I3w6HFmQrEWmC07/55dnGD59T2OUs3PnEZNddcbPfkDyhJKrwtaOUxwthqSoUPw9o2uwXimS5mo2zvUT/Mm9yuas6847yRZaNp7wsyaR7gZYWpTbqEduPNLPwwusczZcm7ruOPXXKuwWCrSQVuIQwLMDxau8TVjwxRF3vol2+xF1vUpKI7CeMBePP5A0Xdx2GXYtPdeOJjEaeJcE8VjtVY3Sd+o5dmx989E+PoMJ4n+73KAQbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XRPZolNXxDPvO1KAe+2yOBkldzoGkOigR98gDz/diE8=;
 b=d+w3zq8lrYc8p1S7X6gZwPjPjZfPqxvYiz9dZd/jZFF5vNynaWyPC5+KnXrfwa0I5n8cw7QsSMPO0nZEWwin6nCMlucJPcEnrHnFdymRhWB67ndKruhOAq0fn6iZ/skxOz76f8SRjaj0OOFgUfKs6f6+UlW6yTtu7TkxcGTyfcKlYL2gMgaXQeM/spXRcEWV0Gb0vqOqil2mG/l+S+5p2BHrYiATA2qbF7wAVIH4YedC28QvqAoSEdTl28mHjAoNERNFDRI9sTBbhGSHHEfc7RnZQfyDcUNs3sGmaBhDe/l3YmgxP9r58psep9Yokv4h3qiicOnOsNRbkukC9IonFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XRPZolNXxDPvO1KAe+2yOBkldzoGkOigR98gDz/diE8=;
 b=C9tEwwi5JmlirOI89dBTl+eOWqlJxlPMfVu/5oytWwOZ7F1HhdF9w4lr9uZjcKqfCJwkqLKr8jkOzQ9zyAfmagcVaxLPWLyVqxeUWhbg2EExr1t9RxfnCEnEcXx2721GLFo+kshEA7hnseufyLfADVmV4zeEl7BD4yg5Y1paU+o=
Received: from DM4PR12MB5278.namprd12.prod.outlook.com (2603:10b6:5:39e::17)
 by PH7PR12MB6695.namprd12.prod.outlook.com (2603:10b6:510:1b2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Sun, 13 Nov
 2022 16:18:23 +0000
Received: from DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::514f:bcdf:d10f:fedf]) by DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::514f:bcdf:d10f:fedf%8]) with mapi id 15.20.5813.017; Sun, 13 Nov 2022
 16:18:23 +0000
From:   "Yuan, Perry" <Perry.Yuan@amd.com>
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "Huang, Ray" <Ray.Huang@amd.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>
CC:     "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Huang, Shimmer" <Shimmer.Huang@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 8/8] cpufreq: amd_pstate: add driver working mode
 status sysfs entry
Thread-Topic: [PATCH v3 8/8] cpufreq: amd_pstate: add driver working mode
 status sysfs entry
Thread-Index: AQHY8tKg0TEIlpfng0+1tBYIRiFTga4zwskAgAlOZiA=
Date:   Sun, 13 Nov 2022 16:18:23 +0000
Message-ID: <DM4PR12MB52789F0D712CEF9245E34A559C029@DM4PR12MB5278.namprd12.prod.outlook.com>
References: <20221107175705.2207842-1-Perry.Yuan@amd.com>
 <20221107175705.2207842-9-Perry.Yuan@amd.com>
 <72f8e103-b5d1-0def-685a-280b061fa759@amd.com>
In-Reply-To: <72f8e103-b5d1-0def-685a-280b061fa759@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-11-13T16:18:19Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=a9032290-8e47-4eaf-bfd3-e0bee7fd6679;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-11-13T16:18:20Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 8a3f8e2e-9776-4c5c-9321-3e54227b845f
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5278:EE_|PH7PR12MB6695:EE_
x-ms-office365-filtering-correlation-id: 7f437039-6f3a-4bff-7be3-08dac592b013
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 48vLsx+n9Hcu5fOj9YUQ+oeSAsOdXx8c+nw7IxO7gj48kkkAk2+ryXgMGDGXs/QOoJ8H8o9JBNv2tupRSdcPpcpvfZN53mT4HGgRrcGYeA8kT+gocuxeaubo/u2aI7dgw2p1wwBhNSOWCe7roGa9tLCx+u2aW56ferXLrxfghr3b2BNkAZ39qAoiqWDM+xjvlq7bWKx35dEM9aFJihfs0jeY9eUOuWUMNvptI1+nZwMahzMHTSAFPup5/qLKUGIfl6qVQ/10obnyvgApcYAklTTD69s5/gY4vCn4dc9T473lnskCH3LwKjzLv2ZgIh+GBwssLGLj8wHlz0PRAqjfi08akpq/zi8DxELDmJ3OuIZbB1s5WZ+7Jkf3rtEMARaqaxrYmwwFwYnLeb27PzXBxLKvI206DPL1zavr+Nz5X7chRG2fGN3kIpmZEuW5I+QqplnVZajSX0j7CTBCB6TvVWWhl8B0xjb/GkSq+Ucp4e4fvnaRWdMzk8+MfnP88UTDS6uoNW/mTUOJNjg/w+PvTgerqpVuqCZB8fv/hUcLNcOrZUwET9hOFZfvCstsYD8bRs0yTeiVbew8oTpciOs/aMscwNDHLM/LvcSte2/nm6yNCgdD3hqRgGKOYbdMS/LBJLt+XF9XhWRwPgJ6pkh0Dc4qOKxl6YBxbbDBiV6cQDGUNIRpgULok7WWIbzkixuBuUsQKbx1eoOtM+GVesudQpzy+laAfuakuE6uibstX4wOKiB8tPyYZnJTZCs3VmfV/rmrhRR8PtP40DThve26jw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5278.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(376002)(396003)(346002)(366004)(451199015)(9686003)(122000001)(26005)(71200400001)(54906003)(110136005)(316002)(186003)(66476007)(66446008)(66556008)(76116006)(33656002)(8676002)(64756008)(2906002)(66946007)(55016003)(4326008)(86362001)(52536014)(83380400001)(5660300002)(7696005)(6506007)(478600001)(38070700005)(53546011)(41300700001)(8936002)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RzZWQzBvcjBkSjBvZ05iUTRsWWRYYXhBOVo5TjJXQzRqYndzYnovZjV5b2I1?=
 =?utf-8?B?ek9ZMXJKYXQ0bWx0anA0UnkyemVnRVBlbnVwclJId1djVGVCS0J1VjlPN3pH?=
 =?utf-8?B?QWJnV2VlUmFJajgzazhsOWtQZEFIQmJsaG12SG01WUNnY0tkajZ5eGdWM1c0?=
 =?utf-8?B?R2h3bktzRTVvMmMzZDlYUlY1b3NIT1IxTFRacWliWTd1T01BZy9XUmNxT0Fk?=
 =?utf-8?B?SittWmErbEltU3RoSE5CdGhGeXRkU2RUN2VoSDV2TnQzQXhhN2RGZkRmUzA2?=
 =?utf-8?B?ZllYdFI0QWJBMExhdFVBUFc2VEVNMDVocmhQeVhQODY3MjlhWlhBR3g3SWRR?=
 =?utf-8?B?QnZuaGhFY1ptQTkyV1FvbUg4RGM0b1IrMGVOSnZxZnJrRUg1WjVqV3JJM0Iw?=
 =?utf-8?B?bzdYaG4yOGRCN3JlY2FHL1Zrbml3WVd3YmR5RVRuZTVjQ0s5c0RiYXR6czhu?=
 =?utf-8?B?SVQxZHM5eklFc0JmSm5mT21qRERnelN5ZFNsTkRidHZtbWdNNkpWRVVPSE5x?=
 =?utf-8?B?Rm1XcGRiOGg0c2EzZys4aGE2VE5vZndwL3JWa0pFSEgvZ0tZMXBVTzlPTGdL?=
 =?utf-8?B?MGlLWGZXdEl2UmZnQ2R4Y01uNFdYSXpxN0VwbXVkS2JZempLVExKT1Nkbi9E?=
 =?utf-8?B?clpzR3duRy9xQ1Q1eCtHb29mSzJ2UU16UHZkTGZwZWl5VXd4MXYzNERQOGht?=
 =?utf-8?B?Kzh2dWMvMXMxZXFFM25DRkxNNm40MXdxTkZydWpvSGprSHY0SmM5OXhLTlJS?=
 =?utf-8?B?TkRTQlpXRlZienRVa3pOWE5RZThZL2lKNi9iUUFUand6bnF1RHoyaDlCaFRF?=
 =?utf-8?B?bnB5NVoxS3c5RnRJdWcwaVBZQythM3cxS095RmxSMmhOOWlGWUtWYXZ1RFRh?=
 =?utf-8?B?czlhVzZIeDZyZnNOaHlxZVkyeml6OTNETVdZTWZYRFVjKzJ3ZldyYjFkSHlT?=
 =?utf-8?B?dUxyOENwMjZhdXhpTkF0c3hudDd4L29mKzdqK1gzVDFtYzZaVnlyQkJRbk1O?=
 =?utf-8?B?dUgrUVU2SDdpa0VoYWJ3cmJtbzEyVGdNM2FIQmlWNjFKUXZ2aHRRaWc3T0NB?=
 =?utf-8?B?aEhzczVDc0FKdUpYN21KVVR5ZkVyOHdTaTFZVVZxa1BHemtiQ3RvK3kwR3RB?=
 =?utf-8?B?NVBQMDRKTEZaM3pJQk1NRzV6eU9mV0lUTC9nWG1UbkVPR01lamhtMUcrLzdH?=
 =?utf-8?B?UWQvQ2dhSldaOTdpS2xlSmlxT3doalFrSjJjK3AxdDlkODFudzl3ci9zY21Q?=
 =?utf-8?B?MzJHVC8vR1BEZTVhT01Ga2Rtays4dVlSa3dqSk5tTmZ3OVNqdjVUanRjQTIv?=
 =?utf-8?B?d05mcTcrRzZWTHZDWVZ3RWZOQmZpdHEvQVpSNlhMTTNnUTBHb0dscDRzU2JF?=
 =?utf-8?B?TjZpampMdkxlc3E2T0JFRVBOanJ5UEtxcFRWaTRXOFFjeW5IaG1kdVgyaDU4?=
 =?utf-8?B?cDQyZHlZWkdCM0N4M3k0KzdYNHRqZ3FOditqZ2tsbExXNHR1QTF1K0tvYkhi?=
 =?utf-8?B?MFhMd1M0VlNKWERHWkplTHBCc3E0ODdBKzlQNWZRSEt5ODdnUExDZmdWYllt?=
 =?utf-8?B?SHk5K1BmanA0VEVUS2RDUGRZaE41ejZJRTBrTllaS01WYjQwVXVQRjk2N1du?=
 =?utf-8?B?MGw4cStDQ2twV0lEK1FTQVNMSHhPbmdxalQrbWhRWGlsL3F5M3pxbkJkVUJT?=
 =?utf-8?B?enQzY2dOWktJUW1NRHAxZzd2R0pSZ2RJa1lEYWhVQ2REVVpITzZhLzZjOEIz?=
 =?utf-8?B?amI1ZlNyY2FKb3luZFNSZnFvTy9DV3F4VWl6OFRrbC83aXQ1Q2FhY1pnREVD?=
 =?utf-8?B?V05TbWFSbzc0VWd0RStZcm5jd3c0QVpDVFM5WWNpbnppdys0Q1N5ZkFaUzhO?=
 =?utf-8?B?YjlhcVFxNjFPdUhDK0NMbHRhZGtUdStNQVFzZ3lPSVVHUmk3eEpzVzJ5YUpj?=
 =?utf-8?B?UWlFSHFVWU0rMXE0a09QZldaWkVzcFdmYTk4R3JTNEM3cERYUzdZdWRLM3Zl?=
 =?utf-8?B?R1lJNzFFWldpbEVYMEpxK2UwNndTV2R6RnJKSTNFZUZMcU1RYlVPdXpQV3dD?=
 =?utf-8?B?c2ZGQ2xuUG9JczU4bDgxM20waVBqNjVuWDljUTdEazVXU211dVhRbnhEOUpv?=
 =?utf-8?Q?5n3yxxAdqPDwK816//seahU0O?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5278.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f437039-6f3a-4bff-7be3-08dac592b013
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2022 16:18:23.5842
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qKPX66D97krH/LhW9yOPYOgwbHvnUnSg8b6fuAQexdVnpDK25hmxjw8mnfhxuJxlQTSA96anitMi2PoPWhbxwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6695
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkhpIE1hcmlvLg0KDQo+IC0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IExpbW9uY2llbGxvLCBNYXJpbyA8TWFyaW8u
TGltb25jaWVsbG9AYW1kLmNvbT4NCj4gU2VudDogVHVlc2RheSwgTm92ZW1iZXIgOCwgMjAyMiAy
OjEwIEFNDQo+IFRvOiBZdWFuLCBQZXJyeSA8UGVycnkuWXVhbkBhbWQuY29tPjsgcmFmYWVsLmou
d3lzb2NraUBpbnRlbC5jb207IEh1YW5nLA0KPiBSYXkgPFJheS5IdWFuZ0BhbWQuY29tPjsgdmly
ZXNoLmt1bWFyQGxpbmFyby5vcmcNCj4gQ2M6IFNoYXJtYSwgRGVlcGFrIDxEZWVwYWsuU2hhcm1h
QGFtZC5jb20+OyBGb250ZW5vdCwgTmF0aGFuDQo+IDxOYXRoYW4uRm9udGVub3RAYW1kLmNvbT47
IERldWNoZXIsIEFsZXhhbmRlcg0KPiA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IEh1YW5n
LCBTaGltbWVyDQo+IDxTaGltbWVyLkh1YW5nQGFtZC5jb20+OyBEdSwgWGlhb2ppYW4gPFhpYW9q
aWFuLkR1QGFtZC5jb20+OyBNZW5nLA0KPiBMaSAoSmFzc21pbmUpIDxMaS5NZW5nQGFtZC5jb20+
OyBsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwu
b3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgOC84XSBjcHVmcmVxOiBhbWRfcHN0YXRlOiBh
ZGQgZHJpdmVyIHdvcmtpbmcgbW9kZQ0KPiBzdGF0dXMgc3lzZnMgZW50cnkNCj4gDQo+IE9uIDEx
LzcvMjAyMiAxMTo1NywgUGVycnkgWXVhbiB3cm90ZToNCj4gPiBXaGlsZSBhbWQtcHN0YXRlIGRy
aXZlciB3YXMgbG9hZGVkIHdpdGggc3BlY2lmaWMgZHJpdmVyIG1vZGUsIGl0IHdpbGwNCj4gPiBu
ZWVkIHRvIGNoZWNrIHdoaWNoIG1vZGUgaXMgZW5hYmxlZCBmb3IgdGhlIHBzdGF0ZSBkcml2ZXIs
YWRkIHRoaXMNCj4gPiBzeXNmcyBlbnRyeSB0byBzaG93IHRoZSBjdXJyZW50IHN0YXR1cw0KPiA+
DQo+ID4gJCBjYXQgL3N5cy9kZXZpY2VzL3N5c3RlbS9jcHUvYW1kLXBzdGF0ZS9zdGF0dXMNCj4g
PiBhY3RpdmUgPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFBlcnJ5IFl1YW4gPFBlcnJ5Lll1YW5AYW1k
LmNvbT4NCj4gPiAtLS0NCj4gPiAgIGRyaXZlcnMvY3B1ZnJlcS9hbWQtcHN0YXRlLmMgfCA0NA0K
PiA+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiANCj4gWW91IHNob3Vs
ZCB1cGRhdGUgdGhlIG1hdGNoaW5nIGFtZC1wc3RhdGUgZG9jdW1lbnRhdGlvbiBmb3IgdGhpcyBu
ZXcNCj4gc3lzZnMgZmlsZS4NCj4gDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgNDQgaW5zZXJ0aW9u
cygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY3B1ZnJlcS9hbWQtcHN0YXRlLmMN
Cj4gPiBiL2RyaXZlcnMvY3B1ZnJlcS9hbWQtcHN0YXRlLmMgaW5kZXggNjk1OGM1ZmQ5ZTFjLi5l
YWRjYzlkNjFkMzkNCj4gMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9jcHVmcmVxL2FtZC1wc3Rh
dGUuYw0KPiA+ICsrKyBiL2RyaXZlcnMvY3B1ZnJlcS9hbWQtcHN0YXRlLmMNCj4gPiBAQCAtNjUs
NiArNjUsOCBAQCBzdGF0aWMgaW50IGRpc2FibGVfcHN0YXRlX2xvYWQgX19pbml0ZGF0YTsNCj4g
PiAgIHN0YXRpYyBpbnQgZXBwX29mZiBfX2luaXRkYXRhOw0KPiA+DQo+ID4gICBzdGF0aWMgc3Ry
dWN0IGNwdWZyZXFfZHJpdmVyICpkZWZhdWx0X3BzdGF0ZV9kcml2ZXI7DQo+ID4gK3N0YXRpYyBz
dHJ1Y3QgY3B1ZnJlcV9kcml2ZXIgYW1kX3BzdGF0ZV9lcHBfZHJpdmVyOyBzdGF0aWMgc3RydWN0
DQo+ID4gK2NwdWZyZXFfZHJpdmVyIGFtZF9wc3RhdGVfZHJpdmVyOw0KPiA+ICAgc3RhdGljIHN0
cnVjdCBhbWRfY3B1ZGF0YSAqKmFsbF9jcHVfZGF0YTsNCj4gPg0KPiA+ICAgc3RhdGljIHN0cnVj
dCBhbWRfcHN0YXRlX3BhcmFtcyBnbG9iYWxfcGFyYW1zOyBAQCAtODE5LDYgKzgyMSw0NiBAQA0K
PiA+IHN0YXRpYyBzc2l6ZV90IHN0b3JlX3BzdGF0ZV9keW5hbWljX2Jvb3N0KHN0cnVjdCBrb2Jq
ZWN0ICphLA0KPiA+ICAgCXJldHVybiBjb3VudDsNCj4gPiAgIH0NCj4gPg0KPiA+ICtzdGF0aWMg
c3NpemVfdCBhbWRfcHN0YXRlX3Nob3dfc3RhdHVzKGNoYXIgKmJ1Zikgew0KPiA+ICsJaWYgKCFk
ZWZhdWx0X3BzdGF0ZV9kcml2ZXIpDQo+ID4gKwkJcmV0dXJuIHNwcmludGYoYnVmLCAib2ZmXG4i
KTsNCj4gPiArDQo+ID4gKwlyZXR1cm4gc3ByaW50ZihidWYsICIlc1xuIiwgZGVmYXVsdF9wc3Rh
dGVfZHJpdmVyID09DQo+ICZhbWRfcHN0YXRlX2VwcF9kcml2ZXIgPw0KPiA+ICsJCQkJCSJhY3Rp
dmUiIDogInBhc3NpdmUiKTsNCj4gPiArfQ0KPiA+ICsNCj4gPiArc3RhdGljIGludCBhbWRfcHN0
YXRlX3VwZGF0ZV9zdGF0dXMoY29uc3QgY2hhciAqYnVmLCBzaXplX3Qgc2l6ZSkgew0KPiA+ICsJ
LyogRklYTUU6IGFkZCBkcml2ZXIgZHluYW1pYyBzd2l0Y2hpbmcgY29kZSAqLw0KPiA+ICsJcmV0
dXJuIDA7DQo+ID4gK30NCj4gDQo+IFNvICJFZmZlY3RpdmVseSIgdGhpcyBpcyByZWFkIG9ubHkg
cmlnaHQgbm93LiAgSSB0aGluayBpdCdzIGJldHRlciB0byBtYXJrIHRoZSBzeXNmcw0KPiBmaWxl
IGFzIHJlYWQgb25seSBhbmQgbm90IGJvdGhlciB0byBwb3B1bGF0ZSAic3RvcmUiDQo+IGNhbGxi
YWNrIHVudGlsIHlvdSdyZSByZWFkeSB0byBhbGxvdyBkeW5hbWljYWxseSBzd2FwcGluZyBiYWNr
IGFuZCBmb3J0aC4NCj4gDQo+IElmIHlvdSB3YW50IHRvIGtlZXAgdGhlIGNvZGUgdGhlcmUsIHRo
ZW4gSSB0aGluayB5b3Ugc2hvdWxkIHJldHVybiBhbiAtDQo+IEVPUE5PVFNVUFAgZXJyb3IgY29k
ZSBmb3IgYW1kX3BzdGF0ZV91cGRhdGVfc3RhdHVzLg0KDQpZZXMsIGNoYW5nZWQgdG8gcmV0dXJu
IEVPUE5PVFNVUFAgY29kZSBpbiBWNC4NClBsZWFzZSBoZWxwIHRvIHRha2UgYSBsb29rLg0KVGhh
bmtzIC4NCg0KUGVycnkuDQoNCj4gDQo+ID4gKw0KPiA+ICtzdGF0aWMgc3NpemVfdCBzaG93X3N0
YXR1cyhzdHJ1Y3Qga29iamVjdCAqa29iaiwNCj4gPiArCQkJICAgc3RydWN0IGtvYmpfYXR0cmli
dXRlICphdHRyLCBjaGFyICpidWYpIHsNCj4gPiArCXNzaXplX3QgcmV0Ow0KPiA+ICsNCj4gPiAr
CW11dGV4X2xvY2soJmFtZF9wc3RhdGVfZHJpdmVyX2xvY2spOw0KPiA+ICsJcmV0ID0gYW1kX3Bz
dGF0ZV9zaG93X3N0YXR1cyhidWYpOw0KPiA+ICsJbXV0ZXhfdW5sb2NrKCZhbWRfcHN0YXRlX2Ry
aXZlcl9sb2NrKTsNCj4gPiArDQo+ID4gKwlyZXR1cm4gcmV0Ow0KPiA+ICt9DQo+ID4gKw0KPiA+
ICtzdGF0aWMgc3NpemVfdCBzdG9yZV9zdGF0dXMoc3RydWN0IGtvYmplY3QgKmEsIHN0cnVjdCBr
b2JqX2F0dHJpYnV0ZSAqYiwNCj4gPiArCQkJICAgIGNvbnN0IGNoYXIgKmJ1Ziwgc2l6ZV90IGNv
dW50KSB7DQo+ID4gKwljaGFyICpwID0gbWVtY2hyKGJ1ZiwgJ1xuJywgY291bnQpOw0KPiA+ICsJ
aW50IHJldDsNCj4gPiArDQo+ID4gKwltdXRleF9sb2NrKCZhbWRfcHN0YXRlX2RyaXZlcl9sb2Nr
KTsNCj4gPiArCXJldCA9IGFtZF9wc3RhdGVfdXBkYXRlX3N0YXR1cyhidWYsIHAgPyBwIC0gYnVm
IDogY291bnQpOw0KPiA+ICsJbXV0ZXhfdW5sb2NrKCZhbWRfcHN0YXRlX2RyaXZlcl9sb2NrKTsN
Cj4gPiArDQo+ID4gKwlyZXR1cm4gcmV0IDwgMCA/IHJldCA6IGNvdW50Ow0KPiA+ICt9DQo+ID4g
Kw0KPiA+ICAgY3B1ZnJlcV9mcmVxX2F0dHJfcm8oYW1kX3BzdGF0ZV9tYXhfZnJlcSk7DQo+ID4g
ICBjcHVmcmVxX2ZyZXFfYXR0cl9ybyhhbWRfcHN0YXRlX2xvd2VzdF9ub25saW5lYXJfZnJlcSk7
DQo+ID4NCj4gPiBAQCAtODI2LDYgKzg2OCw3IEBAIGNwdWZyZXFfZnJlcV9hdHRyX3JvKGFtZF9w
c3RhdGVfaGlnaGVzdF9wZXJmKTsNCj4gPiAgIGNwdWZyZXFfZnJlcV9hdHRyX3J3KGVuZXJneV9w
ZXJmb3JtYW5jZV9wcmVmZXJlbmNlKTsNCj4gPiAgIGNwdWZyZXFfZnJlcV9hdHRyX3JvKGVuZXJn
eV9wZXJmb3JtYW5jZV9hdmFpbGFibGVfcHJlZmVyZW5jZXMpOw0KPiA+ICAgZGVmaW5lX29uZV9n
bG9iYWxfcncocHN0YXRlX2R5bmFtaWNfYm9vc3QpOw0KPiA+ICtkZWZpbmVfb25lX2dsb2JhbF9y
dyhzdGF0dXMpOw0KPiA+DQo+ID4gICBzdGF0aWMgc3RydWN0IGZyZXFfYXR0ciAqYW1kX3BzdGF0
ZV9hdHRyW10gPSB7DQo+ID4gICAJJmFtZF9wc3RhdGVfbWF4X2ZyZXEsDQo+ID4gQEAgLTg0NSw2
ICs4ODgsNyBAQCBzdGF0aWMgc3RydWN0IGZyZXFfYXR0ciAqYW1kX3BzdGF0ZV9lcHBfYXR0cltd
ID0gew0KPiA+DQo+ID4gICBzdGF0aWMgc3RydWN0IGF0dHJpYnV0ZSAqcHN0YXRlX2dsb2JhbF9h
dHRyaWJ1dGVzW10gPSB7DQo+ID4gICAJJnBzdGF0ZV9keW5hbWljX2Jvb3N0LmF0dHIsDQo+ID4g
Kwkmc3RhdHVzLmF0dHIsDQo+ID4gICAJTlVMTA0KPiA+ICAgfTsNCj4gPg0K
