Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C06C4638B86
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 14:47:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbiKYNrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 08:47:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbiKYNrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 08:47:31 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5671DD7F;
        Fri, 25 Nov 2022 05:47:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1669384049; x=1700920049;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ciPA93NZvx8QoHd2lw74Ax7rd/eVNIC+4jhl5kXJHok=;
  b=r6d/LN5hyscehySz0eGIep1q/xMSpck/caB+yXHq9lFvGxTs1JrgCINs
   4wlqiz4k3V/CdMQ//1aBvTwm6bA8p5513zfO0AfV2H1NxpYNDey61AhpT
   U6ppKNQmi4yNOyK+1/ipUWoLEKW54jxO9pjyCYFayNEz7q+sKTDO7aew9
   TAK+LMMU8w7lWeUhUFdFCLSltBjf4kQEW8BxkJLJXc4bsmHkPDKp7xWo2
   61MtQ0I/fk8t11OA/4SuuB1W/5pEyyoV0wWt0wQyyz7bjUXAP8yBu9d0V
   79evkQ2Yg4JjFhWXSNp9Hf1fZzH0JgjLsJrfVL6JFEXXWXyeS6JebdPSn
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,193,1665471600"; 
   d="scan'208";a="190545439"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Nov 2022 06:47:29 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Fri, 25 Nov 2022 06:47:28 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Fri, 25 Nov 2022 06:47:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hLDePDxre7p//uR+gYLRPse3kFY1V15kHHeD3kra5c48ZXSuZVe+oYQ1L1RNeUU+37WFdP/5n+xMTHwOtWearhl0J7vvwDjuJhDurjYbL8TTF60Ys89rrHaTNfZGO+AkL/Q6mQJP7enX42HK8ONg7O3NukGMXxWDqyVZi0X72IMX2bepuibyqbR+M2buG4AyB+gkm/QLdEisP2ZDrWljsvpE2KtHjtaY7RPDrh+UP1h9Q9eTS3ZE6pqu+qwOS/Oz5zXYS9eqFS8ZJkSM9+UP3QWTQ4HUqm8FkqBgaYYGHt/+me7qBeEJ3Wo/1XvdvEgLZQjAHOD1daHmnWipL76dNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ciPA93NZvx8QoHd2lw74Ax7rd/eVNIC+4jhl5kXJHok=;
 b=KhDbRcsjYCUP/X0nJSlo+j0aStLzVK2qF5VpU15wHJG9HlhFb2/eutBmo1eQM3Iu0n3ZBHcFjaIR0Haa0TWWUexVcIcIt77ak9xAAaNjHnEpchnYycW/nyzbltA04gHF+injGSIUpRx7b1CMXNDWDWD/G6XqzaIED8pM+r4Zt1hwpxG1sUb0tF1C54adqrVK7mpCV6weAlW1Klzo1tOLD2BbMLWDY7rMA+r5xrVSjEwPko2XGuxOOxB2HhyexlqmmX+7DJDSiCqM/yfWRZ8PhHJ38WFo53s0rQSOSlrholKaQE20iUVq30i7X5CbRqgD81w52KsfOY3IsD4DCSwS0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ciPA93NZvx8QoHd2lw74Ax7rd/eVNIC+4jhl5kXJHok=;
 b=gfYNG0FQv7A8wMtpMwyGPQqS6ANNC4kmKc6CDkWy0oyNtY3lEH2tNwjY+24PlsYp2L1PPuxHSdFRyTwJMHDHNutnLAo2MI0bPVcg0/zL7XwMQLHhboQ++kB6DnUg3tmez7pXpj9h8l8Q9XgZ1kTAk7zfjJbsy7CyzZC44yPphg0=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by DM4PR11MB6237.namprd11.prod.outlook.com (2603:10b6:8:a9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19; Fri, 25 Nov
 2022 13:47:27 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::98f6:c9d1:bb68:1c15]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::98f6:c9d1:bb68:1c15%10]) with mapi id 15.20.5857.017; Fri, 25 Nov
 2022 13:47:27 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <Eugen.Hristev@microchip.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] ARM: configs: multi_v7: switch to new
 MICROCHIP_ISC driver
Thread-Topic: [PATCH v2 2/2] ARM: configs: multi_v7: switch to new
 MICROCHIP_ISC driver
Thread-Index: AQHZANR0m+bUj4H6M062HyytjBUCaQ==
Date:   Fri, 25 Nov 2022 13:47:26 +0000
Message-ID: <561fbce8-a920-2791-26dc-d834edbcabd9@microchip.com>
References: <20221125130646.454084-1-eugen.hristev@microchip.com>
 <20221125130646.454084-2-eugen.hristev@microchip.com>
In-Reply-To: <20221125130646.454084-2-eugen.hristev@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR11MB1953:EE_|DM4PR11MB6237:EE_
x-ms-office365-filtering-correlation-id: 95e2a524-6589-47f9-930d-08daceeb96e2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jmfHcSDH6OTyimvSddwsgmPU0npjlOeURXKkGrPjzSmeyFj3bGQBxocyIy/ZzP2ZAbsThX0I2o587GVEIBpZEqWBACNBQ24/WFjJm1LhW3rzwjtDMlJWXpDLScbR5tLSd/2eF8BkxNZAZiv7A8dkDWYHEYUpw5rXM4eW7N8p7hCSFLOxfY0lDzVD7Nn+JFabhoW+hrUKq3eX6CUgPHvLPpk13B9dBkiFo3p6FoRIokI4Fu+EC/0b0IK6k6aB24DCpANmjWiqSUxX6KuOhnudDuaRiS/v1bPbHRF+CtJ8d00ynVcMIweaOBU24R1BIC3hrhMjSTA6JDDsQ41BNeGuMeMnYXcFb62+1JobijVyCUO6w4YAkcWEJBVuEsM0o/7zUQXDelcEdohFOIuCpCAc/bcdy4vt9GPwrFFaqRLqqzUMnKpisxBd0d/9pvJdfr/6dqcoYD7nmvI1lL8m/+tYL7fHH8qNnRbArZTNFNbW+7SqcyGuv/QUBBFDPRe7c6zSgS21o8EWHz2jagRFt+Jzv31DurD3FOtkDVSt3nDfyT7wSPNaQm9ordU/qx59VfVNMR5mXLoKmGZ9btylRvA+lgAxQPOso4P0+fR9PGiCtbCdWw3Jq8PxQA5JjOIQ3l9hBPDel7c6n6F7hsJTarSDePnjJBHW70p1kGRlX2gEiAm5jSspUqmE6e3a3eNSMkysT/CrgnCm935P4n2tiK6andAVfUw4j6BAT3O7q3DpCr41jDISC2whdabSWwRVxXL/7jB/0goF7zVqlKt3dtoLjQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(396003)(39860400002)(136003)(366004)(376002)(451199015)(31696002)(86362001)(76116006)(66556008)(64756008)(66476007)(66446008)(66946007)(8676002)(4326008)(91956017)(41300700001)(38100700002)(54906003)(6636002)(316002)(6506007)(8936002)(6486002)(5660300002)(2906002)(6862004)(83380400001)(37006003)(71200400001)(38070700005)(186003)(478600001)(2616005)(53546011)(122000001)(6512007)(26005)(31686004)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T3JDZ0oyVFVKRnB3KzQ3d0FESHZodVVsZDk2RGVxbENJTkRGVVpIaUx3S25U?=
 =?utf-8?B?SjVWUlZJck5Ib3NwODBPS0hoUWxoMmFqUTYyd0pwejlQNFgxR2xLRHBvMkJR?=
 =?utf-8?B?Z1kzaG9Jd3Y4Skt1ak92WGJVOTR1N3NyS1lQeTF0d0FKZFJwNU1FNlRPK2V1?=
 =?utf-8?B?dExFZnAyMGR0QTRBU20xQ1lpaHYxRS9EZFZXSVZlRXBWaHBzMXFxNlYzZ3Rx?=
 =?utf-8?B?RWJrRVdycGFrbDFiMlV6TDhLd2N4KzErUVU2MEptaVU2WWhiSTQ4NDg3ZTU0?=
 =?utf-8?B?MFEveGdKeXlMaW9tT2xyNXN2bW5Ua0VBSHBka2VTRWVGTmlCUWlaY0toeVU1?=
 =?utf-8?B?WmFvaEhVb282NFBYWnJUeEd0Z2RWYXZDREkzSmNaeVpYSmFnM2lTT25jVDdE?=
 =?utf-8?B?aFZmeG9vUmJHUW9IcjFHenBmeGF1YzBnYjRtOVhJV3V2K3dvdGI3VmpKVEZV?=
 =?utf-8?B?RlRJTTlqYW0wT3dXS0lncTRCLzl5emhFL0FjKzBLZDNZbXdKN3p6bHRKY2oy?=
 =?utf-8?B?dTRZbFhob2RqSzRTRVVVeS82cStsRjZ3VkZ3ZFhJR0pyTXpEbTJQc3c2Ny83?=
 =?utf-8?B?OWI2eUtDblFoQkFCVm5QVFZBek9zdDF5T0FUdUVpa0RWTHMwVzQxcktMamNx?=
 =?utf-8?B?VUh4VVA0UjdVRjdSb09nU2pyaGpXZUx5cGhJR3RJZkRFOWVSSUR3QXVkQjEr?=
 =?utf-8?B?SHhTMEdKdGZnSGxVMXB5WkZwNG8yMDB2MGJWei9ncmovZXpBbHMvWnpSTWFr?=
 =?utf-8?B?eitESkZPWk5FZGc3Qk9vM1ljNXNFbUNDUWNBNk5WZHR4dk8ycVJNRlVQU1Ar?=
 =?utf-8?B?WC9tR2JIeFlYNVJmSENLbVptMkhoUmhCOFN1c3RRYlJxcTEwQVVmSzVNSEFv?=
 =?utf-8?B?aStmV2xyVG9vYURLMS85dXlhWnNLV3B3OTY3ZmsxY1pZY0dicG5kVHB2Q1VO?=
 =?utf-8?B?TzRGNWx4Uzl5L1gyVmtnc2g5SEtCendJUmFJSEdmcUVaYTVrZm0zaUJSaE9z?=
 =?utf-8?B?YmZJUk54RWZ1V0pnUDJxWVJjYTVLdG0zV1FvQ1VyMitlWFIvd2tsWkdIZEZo?=
 =?utf-8?B?ZTN2VkVoZlRqNjFEQ00yd0xUZ2lOVXo5aWRWVzc5eCt5K0RRdEFib3RvL0VB?=
 =?utf-8?B?a2dKdVNNb0VkUTlEa09CUVJzTUljcURMT29GSklQV1JVSVFvcGg4Ri94YlAy?=
 =?utf-8?B?OFpOY0V1YTJHYnFtWTdQN3oveEFaQlhMMkFoTmlQODBWdDcvbnpPMGJqUncw?=
 =?utf-8?B?czM5Y2RYenB2QXhXYnVHeXJlL2JqWkZwTVFyQjR2U0dzVDFFcDFlWW1VeU9U?=
 =?utf-8?B?eFFzMkgwS1p5YUpYdWhGNE1qRnMvMkljKy94VGgzWlpzSEl6L2t1Q2VsNXNH?=
 =?utf-8?B?YmQ1WWZSbk5ralNnVWtnbTNYUkU3cWxncGtWSGdqS0ZtTmIrV0lBdzVSS05s?=
 =?utf-8?B?bzhPcDNOUmxxZjk2cTNuMUxOSEJIUGtSM3AwN1k1WWtNd3FWMjBBU3pBRlRE?=
 =?utf-8?B?RVZheWpoek43Um53U3ZNOGttdHF5bjFFTFFUMXNsbG9nU1NBWEdnWC9McWU1?=
 =?utf-8?B?M0V5M3dRS3psZ1pGWGI2K2Z0VEl5cVVhUXVsWkYyTVhJTll6dzJ0QUpOcXhR?=
 =?utf-8?B?bUJ0cXlMTW10bnBSMGZENy91TGM2SkNOTnd6TUt5TTVQN3U1Z0NHSFVFZGJ0?=
 =?utf-8?B?aXlZc3RVUjRqSGE0UWxHbDNHb3FWSmh5cmhFeFA2SGdqdUlabVN4amxwb3A5?=
 =?utf-8?B?aHQ4bXU5eVpaQ2ZEdk9WSGF0UUJFZVJiSWF1NFlQSHZPc3dselZybmo3K0hn?=
 =?utf-8?B?MGhOZENFTSsxc2ZJMlhxcWJzalNFV1EyUEs2SzVuclRhZ1F3VmRsTHFnU3hh?=
 =?utf-8?B?bHVLWVBXejl0SkZrRTIyVnluNDRUeGY2alErM3RMbWZBUGNVWlhxVTlMQTVp?=
 =?utf-8?B?MVhuUkF0RHkzTUlkQUdteVlWVXhhSGJ5MThFeUVsQXNsQWxlQ0g2RGhwcDBu?=
 =?utf-8?B?SjZIZmI1bnNJalhDVVVaU2lpYlBSVnc1bjdXUjZBajEyaUNRM3JBUys4ckRo?=
 =?utf-8?B?REh2MEdYVWZtQUVGa1hlUUtyN2hyUThWSG5PbnpyQ2FrZ2wzSnlqSXg5bGpa?=
 =?utf-8?B?S3ZQdkdvdnhMZ3pKcGpyM0VJanRnbmR1Nk9mWE9RL2F4emlVK3ArUU9nK1NN?=
 =?utf-8?B?TFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <02EEA0F1010FA741805ECF4FA679CF51@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95e2a524-6589-47f9-930d-08daceeb96e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2022 13:47:27.0101
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DK9D0DvQSmfgE23qq1FXGSSmyVneR9YWXf9+hqoK0AshDrSshRxt4y0MIZ8jxEyIIknil19HurKswpk+JjyDZd9ysYCgKqoqtHH7LMAar4k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6237
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjUuMTEuMjAyMiAxNTowNiwgRXVnZW4gSHJpc3RldiB3cm90ZToNCj4gVGhlIEFUTUVMX0lT
QyBhbmQgQVRNRUxfWElTQyBoYXZlIGJlZW4gZGVwcmVjYXRlZCBhbmQgbW92ZWQgdG8gc3RhZ2lu
Zy4NCj4gVXNlIHRoZSBuZXcgTUlDUk9DSElQX0lTQy9NSUNST0NISVBfWElTQyBzeW1ib2xzIHdo
aWNoIGFyZSB0aGUNCj4gcmVwbGFjZW1lbnQgZHJpdmVycy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6
IEV1Z2VuIEhyaXN0ZXYgPGV1Z2VuLmhyaXN0ZXZAbWljcm9jaGlwLmNvbT4NCg0KQXBwbGllZCB0
byBhdDkxLWRlZmNvbmZpZyAoYWZ0ZXIgcmUtd29ya2VkIGEgYml0IHRvIGtlZXAgZW50cmllcw0K
YWxwaGFiZXRpY2FsbHkgc29ydGVkKSwgdGhhbmtzIQ0KDQo+IC0tLQ0KPiANCj4gY2hhbmdlcyBp
biB2MjoNCj4gLSBzcGxpdCB0aGUgbXVsdGkgdjcgaW50byBzZXBhcmF0ZSBwYXRjaA0KPiANCj4g
IGFyY2gvYXJtL2NvbmZpZ3MvbXVsdGlfdjdfZGVmY29uZmlnIHwgNiArKystLS0NCj4gIDEgZmls
ZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0t
Z2l0IGEvYXJjaC9hcm0vY29uZmlncy9tdWx0aV92N19kZWZjb25maWcgYi9hcmNoL2FybS9jb25m
aWdzL211bHRpX3Y3X2RlZmNvbmZpZw0KPiBpbmRleCBiNjFiMmUzZDExNmIuLmQxNjg2YmM0MGU1
ZCAxMDA2NDQNCj4gLS0tIGEvYXJjaC9hcm0vY29uZmlncy9tdWx0aV92N19kZWZjb25maWcNCj4g
KysrIGIvYXJjaC9hcm0vY29uZmlncy9tdWx0aV92N19kZWZjb25maWcNCj4gQEAgLTY2MywxMSAr
NjYzLDExIEBAIENPTkZJR19VU0JfVklERU9fQ0xBU1M9bQ0KPiAgQ09ORklHX1Y0TF9QTEFURk9S
TV9EUklWRVJTPXkNCj4gIENPTkZJR19WNExfTUVNMk1FTV9EUklWRVJTPXkNCj4gIENPTkZJR19W
SURFT19BU1BFRUQ9bQ0KPiAtQ09ORklHX1ZJREVPX0FUTUVMX0lTQz1tDQo+IC1DT05GSUdfVklE
RU9fQVRNRUxfWElTQz1tDQo+ICBDT05GSUdfVklERU9fQVRNRUxfSVNJPW0NCj4gLUNPTkZJR19W
SURFT19NSUNST0NISVBfQ1NJMkRDPW0NCj4gIENPTkZJR19WSURFT19NTVBfQ0FNRVJBPW0NCj4g
K0NPTkZJR19WSURFT19NSUNST0NISVBfSVNDPW0NCj4gK0NPTkZJR19WSURFT19NSUNST0NISVBf
WElTQz1tDQo+ICtDT05GSUdfVklERU9fTUlDUk9DSElQX0NTSTJEQz1tDQo+ICBDT05GSUdfVklE
RU9fVEVHUkFfVkRFPW0NCj4gIENPTkZJR19WSURFT19SRU5FU0FTX0NFVT1tDQo+ICBDT05GSUdf
VklERU9fUkNBUl9WSU49bQ0KDQo=
