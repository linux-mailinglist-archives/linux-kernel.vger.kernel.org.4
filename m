Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5B6629B83
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 15:06:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbiKOOGG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 09:06:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbiKOOF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 09:05:57 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1CF62A272;
        Tue, 15 Nov 2022 06:05:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1668521155; x=1700057155;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PhDoAex47hhMOZugOu2jv+jsSNWUzpFNoA+Fai7PrUk=;
  b=PkKI14pt7r2413gQxCVPzjcOjIV7krQLaTuzm1xbbWtNkSCePdBQId32
   oHrwnc+qh2POx2PmPjWut+Kl/7zvvusU0V6S8hgKOh3yYsGVK78XHnG4B
   K3vTeuFbGuu2eMjqt2wL4dJrt98nodpYEpvvTRksVG13IpKa5Vn0fkb08
   esFhxjZtXKrJbJqyhpEyvw30LCXtN6F2u+EovLNtqH48PZJtCCBiG/ZGI
   5eYf9yIpsIWZC/8MfvH8tn82c9HSB2iN6WK8fSmjufsSnO5oLQNoTjAZo
   JO3DNGPFDbxwdsjS7gCLDCsfHUflVPWhMbxWFWawKJxCYuK42gfRbddJ9
   g==;
X-IronPort-AV: E=Sophos;i="5.96,166,1665471600"; 
   d="scan'208";a="187057423"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Nov 2022 07:05:39 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 15 Nov 2022 07:05:39 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Tue, 15 Nov 2022 07:05:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JMo0plQ3iRBBSMTjApx70us7qrN/KAeAlmOsMoJBaZX3bxOECop85+hPqoIfzOeauoT4uoJMb3lWjDrU9qksbis5KPesb2tZbDSVXjX5b6lIs9F0ZzxZ3RJW/KqGWm+v7JSjH0TXiM7pwMom+7JwHR0km9tbWOHxaVAipiEsIlQALauFrD+7D+gsBeEOBOydAUr9keWzBrgEEmNcGAtuto17LMpSZ6D7CerJ2S+F0xz4Kr0CzpkTHf6nf3UX0IIsgIqFPNQEt4abd+Amik5OBljVUKfy4ekZGTx1dKdvTlVC+h7EBwgF2KJLl9czQgexrUI/HmoAo0OE2YgjQ6oFcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PhDoAex47hhMOZugOu2jv+jsSNWUzpFNoA+Fai7PrUk=;
 b=kGsD4Sw54YwgVDOAtRfz61E32X+FjcoyGsObXm+riAu0PEfftVWAS0Gi3lkCR56nYCgB5/bkeVCzU7BcjL4CNhJPcY4QVYJlS4V8j4fxK8083+pHeNhnIhC4WNQF81bxmVYMLjs5KMc0QI6g7M271m/4edwBSEaCuQAYoec+dVTbwnSF83s5EUvoZVXkaBtYeG139EEaRNHp5b8/ZI6nK7o6xjDV6iji6UP6FRXgDWOcLqaOEyWO+lbPHrCLU6+m4l8FhZjOmebHsLpEcM0gDD+Z6P9kwKQyg1AxEIw+Nh8IDQdatG/j+Umxz7+W6Pf4uwfBjr1yewDQ34Aq9Js58w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PhDoAex47hhMOZugOu2jv+jsSNWUzpFNoA+Fai7PrUk=;
 b=R6/i77hUF0Oi0Wjh3jhm5R7AXwxoOjHxbkCMY2oAraVB4iMP9Bkgjkkh4wc1yD4XMReP5Fl7tattyc1SeAABQb5QnQPjPgPP7yPzCKXuc8A2ALNZ3Y6yiTlieeE7kdjWMwr5L2OBq9W6Wv/DuSSII64zoioPwuehCCrmJvQD12s=
Received: from BYAPR11MB3606.namprd11.prod.outlook.com (2603:10b6:a03:b5::25)
 by SA1PR11MB7131.namprd11.prod.outlook.com (2603:10b6:806:2b0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Tue, 15 Nov
 2022 14:05:36 +0000
Received: from BYAPR11MB3606.namprd11.prod.outlook.com
 ([fe80::29ed:b573:91d9:2288]) by BYAPR11MB3606.namprd11.prod.outlook.com
 ([fe80::29ed:b573:91d9:2288%7]) with mapi id 15.20.5813.017; Tue, 15 Nov 2022
 14:05:35 +0000
From:   <Sagar.Biradar@microchip.com>
To:     <james.hilliard1@gmail.com>
CC:     <martin.petersen@oracle.com>, <khorenko@virtuozzo.com>,
        <christian@grossegger.com>, <aacraid@microsemi.com>,
        <Don.Brace@microchip.com>, <Tom.White@microchip.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 0/1] aacraid: Host adapter Adaptec 6405 constantly
 resets under high io load
Thread-Topic: [PATCH v3 0/1] aacraid: Host adapter Adaptec 6405 constantly
 resets under high io load
Thread-Index: AQHXQsZcat53f5Y0GUewzbFQW8Fr6KygDOeAgAIrQgeBaIqnAIAOgRQAgAskdwCAAV8v8IAa0mqAgALSqOA=
Date:   Tue, 15 Nov 2022 14:05:35 +0000
Message-ID: <BYAPR11MB36065EE0321C0AE6A4A3ECC7FA049@BYAPR11MB3606.namprd11.prod.outlook.com>
References: <yq15zo86nvk.fsf@oracle.com>
 <20190819163546.915-1-khorenko@virtuozzo.com>
 <CADvTj4rVS-wJy1B=dgEO1AOADNYgL3XkZ01Aq=RTfPGEZC+VMA@mail.gmail.com>
 <ffdb2223-eed3-75b4-a003-4e4c96b49947@grossegger.com>
 <yq135kacnny.fsf@ca-mkp.ca.oracle.com>
 <CADvTj4qfPhEKy2V0crGs+Hc_fq=P5OKWFohG9QbTHK3i+GWc=Q@mail.gmail.com>
 <106f384f-d9e2-905d-5ac5-fe4ffd962122@virtuozzo.com>
 <CADvTj4rd+Z8S8vwnsmn2a7BXDPBwx1iqWRmE+SbtWep=Lnr20g@mail.gmail.com>
 <BYAPR11MB36066925274C38555F20FB17FA339@BYAPR11MB3606.namprd11.prod.outlook.com>
 <CADvTj4qH5xuK9ecEPi3Pm9t962E=nnH0oTBqWv4UPmibeASqdQ@mail.gmail.com>
In-Reply-To: <CADvTj4qH5xuK9ecEPi3Pm9t962E=nnH0oTBqWv4UPmibeASqdQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR11MB3606:EE_|SA1PR11MB7131:EE_
x-ms-office365-filtering-correlation-id: 52344245-8446-4f22-ad8a-08dac71277c5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dF5DdQZd0HBFizZj/ibf7dBtmIHIU8ABxm0/nufFayyWrv3oRhDANpPHupl/ib98S3tJN6m46WwZMvYXEMSTULrOynrHHfe0PVp/hyEKMkOf9RiPY/qbi/lq0NlaWvOUKOp2pRNQBGEQgQCYnWXNO1ICO8Gk5sG0RD7Sdm16v+rEwRq/6o5a5fNc68BOeSXFmuSZJkW1dSca67lcxfm5yF+GJkI8Z5SC1MmRskrxv8PCBj8VfZpVxarXoVo8o63iKu440nFUwho89r12q+dejzJ0UF1k012M3cQzNXPHZKQ2e9K1nwnSbB05doe/BqiEQamXc0XmYS+/VZ4XoOdi+jHsMDrK1Z7hmkJkWyedT0m60NkPI2KL3w52bOSTdhdbkrh/a8nuIbqypeoWJz4P8B/ybMadXJmxmY/u7rmz+GCvUeQgFyd1JqOxu6P1xXdMmn9n6GW3a9rYzhULYAE9vRF/O2s5ih7OFIRRJo8VvI8SSZxml7JV8c/0N4BOlygc5AQN2StaDOMwRgOOXgxcDcIAvsXJXtE7Hn+ARGRMkfQo3mdqFAzSIyJF+lipEwxeg+/51034jE9lkZ22HqeGk8mmot0lrp2R157dMQcUnfHylLROkIA6L6W+krw8aJGevIMsBSSoF+MFgxC73kfoskrTJTMR7zTL3d/FzuU5kcTg7SROS6eWj41YMngvDv8vhYxjL01uob26/FkJhbZAqxRTYo2jd8nXKQspUjQvqJOgCo1sKqCxDIv9EGE10a8ebsuEQaPGpbfrcq7MLKur5w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3606.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(39860400002)(396003)(366004)(346002)(451199015)(38100700002)(8936002)(122000001)(33656002)(38070700005)(86362001)(41300700001)(5660300002)(53546011)(966005)(4326008)(55016003)(52536014)(66446008)(66476007)(316002)(64756008)(45080400002)(66946007)(8676002)(66556008)(76116006)(71200400001)(6916009)(54906003)(186003)(9686003)(83380400001)(478600001)(6506007)(66574015)(2906002)(26005)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WFNadDkwczdHL1loMytNQS9YNktPME12cEs4UlkwTTl0d3liSTBHUGtSbklx?=
 =?utf-8?B?VjgrQllUSEl5eWMzVGxFS3dYNG5vbUtPZHF4TEt4aDYxeUEzWXgvcUdiNGkw?=
 =?utf-8?B?dFZGcDBhVjdhand6ZVJtN3JHdHJlMWhHVmc2eCtFSy9jZkpYNDEybTNBbjd1?=
 =?utf-8?B?NDVOQkZnVXBmKy9LdnZEMVM3VU1PejFIVFBwR3AxQXZjRTVTd1lvL2dFTlp0?=
 =?utf-8?B?Q214Y3JMTm1IT3kwZWk3SXEzMUlEelJOcDFTSU0wUzJyckZBSWdJVUNnYXRo?=
 =?utf-8?B?UW9Ec3Iya0paVDhwYjVtanI4ZHlGY3RURFlMeTkyQnZLQ2E4NTlKNWpqN3J3?=
 =?utf-8?B?dW95VGx5bmVpM1l0b3ZGRkIzVElla0NvRVNyUUhxeDF0Z2c1Y045dEl2T2Ju?=
 =?utf-8?B?ejZlZGEwR01GOC9kWVpqOXYvM3Q0VjQ1ZUJpUDUxRklKU2xSRWZLUVErUkQ3?=
 =?utf-8?B?NkNEdDRJRVpZNFVaZlNwdUh4WlZ4UGtzc1BBQ3o2NGl4bkpwc21hajZqRVY4?=
 =?utf-8?B?aGRNTmZFQlE1YlNsRXlxWWtMUldGWHYxeTMwTFNkaFp6TW1VZjBpL3dtM3Zm?=
 =?utf-8?B?U2syUStQc2p4cnJDbHBPWVZrdHBIa0FGcUxvTW12R0ZRNDVGS2xEelczQzV0?=
 =?utf-8?B?R1dYM09senVjcE5iRFNqaEJUdGRka2dGRVhCZFdzdG1jY2owOWFQenpXa1FY?=
 =?utf-8?B?cFJsZlFySjdxcWcvV1lPdFF2WnppbC85MktNb2pBVW9pNUliQktvbUpyWVgv?=
 =?utf-8?B?QUVPcEtUaFFacnEyR0tXdWcrcERTb2RwcDlvVWI3UnFiWUtkM2xLanBUL2JU?=
 =?utf-8?B?RVNEV2IzUGZpL0JmV3dMdG54YWlMZ3ptMzdoWmhvSWh6L1RadWxXZHN0RkFj?=
 =?utf-8?B?MFNncmNrdFBXdFF1MFU2a09WS1VCVllKN1A5SFRQTzFMRXhoSDFPdHllSzll?=
 =?utf-8?B?OG9WUGl4dXdCeXJJMU5iNWZGeHhDY2NkaGlOTXpJdm5LM2dtclNxVWdsWmV3?=
 =?utf-8?B?UFRkZ3hxQ0ZYWXQ3SnFXNWwrK0dqcDh6bjFMMjl1SE9INVpETG5HZ3dsanFK?=
 =?utf-8?B?L202YXBKS2NwYzllclZTU0ZBQ2ExbmlaYkVOTWZWaTVZb01aeDgvODlXdDdO?=
 =?utf-8?B?bHJPUFM2TnFuTVRNcHAxV1NvV2Fsd1hBQVdiSDc4VW0ycDNqZ3A3OVlpWGVk?=
 =?utf-8?B?WlVHd1IrbEEvTmRqZ2EzaFgrYkMvQzNGc0VnS05tcmEwbHJRSWxIeUZKMWFr?=
 =?utf-8?B?R2wzaWdGUitIRWZHTnB5eHZRd0toQTg5YndLT01DSTErTGhETjdJMXdwWDUz?=
 =?utf-8?B?bHBzVnVTc0Rhc01ja2hKVkZ1U1VxZjQ4Z3dVZzNEMSs1dEd2VmliMDJhV1M0?=
 =?utf-8?B?REViYk5HVVBRN0hlN0NrVHA2L3c2WlhzZ29WT0lkcnErbmRIUllRSXBIWUpy?=
 =?utf-8?B?WjhOaFlzZUJ2MkIydmpOcDFsY1BBYU55SmZFdEtBVjNjMWt2clZXbkxmQ3FB?=
 =?utf-8?B?TVNFU2p2S1k0eUR2eUJ5YUkybFd6eVVSL3AybGVSVTdEWU15VmNkVTBEdVk5?=
 =?utf-8?B?eFpuL3Avb0dJNndzeWJBamxoOGkwakRqUkNqNldKRk9lZWMxUzdRS2QvZXcw?=
 =?utf-8?B?anV0Z1QwRmtLZVU2aVcyMFowSTJHQ2NtWFhGeEZtSkxHQUNleHdsTGpma0Z1?=
 =?utf-8?B?Vkl2OFRPUXdpV2VTeDdkTGFjNXhENkhmSjNENDVUdW44LzByZzBWbi94d0JS?=
 =?utf-8?B?NEpJdEkwNG5LN1Flb1FETXpvUnNuRHJhdWYvR21DWWxFYzI2ODM2RUlJRWhC?=
 =?utf-8?B?U09kSnpxUnpVVzJGc1RiZFVMM0JhYjNDdlRHbk41cHVGbmhJblQ2VkRCV3JD?=
 =?utf-8?B?Q2ozZXY4dUpMaDl1RG9Wb0plUUlWM3NPdFdSNmJQT1ZvT096RVFpVlM4Rysz?=
 =?utf-8?B?YitvNVVCYXlkSWgzamU5YVA4eENsOE9oaDVYQXhZYjY1YjVQV3Z2K3F5ZUxv?=
 =?utf-8?B?YWJjT1E1aERUaHkreFlvZXhUVUxpQXYzNENBdlltQmhiOURpSWU4NWs1VWp0?=
 =?utf-8?B?U1pBL2phVmRvSkZoVGtqeXVhVFk2cStOOGRRT2tTWC9mT3dqWkRHdTFyQWl5?=
 =?utf-8?Q?gS4jNA/k7jkxaikz9Ir3tPAzM?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3606.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52344245-8446-4f22-ad8a-08dac71277c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2022 14:05:35.8660
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HmjhlHmtiaws8L/pHrT4YQ6SJpIv2SR1mHfhZHlOHeQGjycYlJkMJfT50SJmUXkh5KaQ2F9Zx2hdBmp0C1zvSKgaJnTv6lQRQUG78WNSS34=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7131
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSmFtZXMsDQpJIGhhdmUgbG9va2VkIGludG8gdGhlIHBhdGNoIHRob3JvdWdobHkuDQpXZSBz
dXNwZWN0IHRoaXMgY2hhbmdlIG1pZ2h0IGV4cG9zZSBhbiBvbGQgbGVnYWN5IGludGVycnVwdCBp
c3N1ZSBvbiBzb21lIHByb2Nlc3NvcnMuDQoNCldlIGFyZSBjdXJyZW50bHkgZGVidWdnaW5nIGFu
ZCBkaWdnaW5nIGZ1cnRoZXIgZGV0YWlscyB0byBiZSBhYmxlIHRvIGV4cGxhaW4gaXQgaW4gbXVj
aCBkZXRhaWxlZCBmYXNoaW9uLg0KSSB3aWxsIGtlZXAgeW91IHRoZSB0aHJlYWQgcG9zdGVkIGFz
IHNvb24gYXMgd2UgaGF2ZSBzb21ldGhpbmcgaW50ZXJlc3RpbmcuDQoNClNhZ2FyDQoNCi0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBKYW1lcyBIaWxsaWFyZCA8amFtZXMuaGlsbGlh
cmQxQGdtYWlsLmNvbT4gDQpTZW50OiBNb25kYXksIE5vdmVtYmVyIDE0LCAyMDIyIDEyOjEzIEFN
DQpUbzogU2FnYXIgQmlyYWRhciAtIEMzNDI0OSA8U2FnYXIuQmlyYWRhckBtaWNyb2NoaXAuY29t
Pg0KQ2M6IG1hcnRpbi5wZXRlcnNlbkBvcmFjbGUuY29tOyBraG9yZW5rb0B2aXJ0dW96em8uY29t
OyBjaHJpc3RpYW5AZ3Jvc3NlZ2dlci5jb207IGFhY3JhaWRAbWljcm9zZW1pLmNvbTsgRG9uIEJy
YWNlIC0gQzMzNzA2IDxEb24uQnJhY2VAbWljcm9jaGlwLmNvbT47IFRvbSBXaGl0ZSAtIEMzMzUw
MyA8VG9tLldoaXRlQG1pY3JvY2hpcC5jb20+OyBsaW51eC1zY3NpQHZnZXIua2VybmVsLm9yZzsg
TGludXggS2VybmVsIE1haWxpbmcgTGlzdCA8bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz4N
ClN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMC8xXSBhYWNyYWlkOiBIb3N0IGFkYXB0ZXIgQWRhcHRl
YyA2NDA1IGNvbnN0YW50bHkgcmVzZXRzIHVuZGVyIGhpZ2ggaW8gbG9hZA0KDQpFWFRFUk5BTCBF
TUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBr
bm93IHRoZSBjb250ZW50IGlzIHNhZmUNCg0KT24gVGh1LCBPY3QgMjcsIDIwMjIgYXQgMToxNyBQ
TSA8U2FnYXIuQmlyYWRhckBtaWNyb2NoaXAuY29tPiB3cm90ZToNCj4NCj4gSGkgSmFtZXMgYW5k
IEtvbnN0YW50aW4sDQo+DQo+ICpMaW1pdGluZyB0aGUgYXVkaWVuY2UgdG8gYXZvaWQgc3BhbW1p
bmcqDQo+DQo+IFNvcnJ5IGZvciBkZWxheWVkIHJlc3BvbnNlIGFzIEkgd2FzIG9uIHZhY2F0aW9u
Lg0KPiBUaGlzIG9uZSBnb3QgbWlzc2VkIHNvbWVob3cgYXMgc29tZW9uZSBlbHNlIHdhcyBsb29r
aW5nIGludG8gdGhpcyBhbmQgaXMgbm8gbG9uZ2VyIHdpdGggdGhlIGNvbXBhbnkuDQo+DQo+IEkg
d2lsbCBsb29rIGludG8gdGhpcywgbWVhbndoaWxlIEkgd2FudGVkIHRvIGNoZWNrIGlmIHlvdSAo
b3Igc29tZW9uZSBlbHNlIHlvdSBrbm93KSBoYWQgYSBjaGFuY2UgdG8gdGVzdCB0aGlzIHRob3Jv
dWdobHkgd2l0aCB0aGUgbGF0ZXN0IGtlcm5lbD8NCj4gSSB3aWxsIGdldCBiYWNrIHRvIHlvdSB3
aXRoIHNvbWUgbW9yZSBxdWVzdGlvbnMgb3IgdGhlIGNvbmZpcm1hdGlvbiBpbiBhIGRheSBvciB0
d28gbWF4Lg0KDQpEaWQgdGhpcyBldmVyIGdldCBsb29rZWQgYXQ/DQoNCkFzIHRoaXMgZXhhY3Qg
cGF0Y2ggd2FzIG1lcmdlZCBpbnRvIHRoZSB2ZW5kb3IgYWFjcmFpZCBhIHdoaWxlIGFnbyBJJ20g
bm90IHN1cmUgd2h5IGl0IHdvdWxkbid0IGJlIGdvb2QgdG8gbWVyZ2UgdG8gbWFpbmxpbmUgYXMg
d2VsbC4NCg0KVmVuZG9yIGFhY3JhaWQgcmVsZWFzZSB3aXRoIHRoaXMgcGF0Y2ggbWVyZ2VkOg0K
aHR0cHM6Ly9kb3dubG9hZC5hZGFwdGVjLmNvbS9yYWlkL2FhYy9saW51eC9hYWNyYWlkLWxpbnV4
LXNyYy0xLjIuMS02MDAwMS50Z3oNCg0KPg0KPg0KPiBUaGFua3MgZm9yIHlvdXIgcGF0aWVuY2Uu
DQo+IFNhZ2FyDQo+DQo+DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEph
bWVzIEhpbGxpYXJkIDxqYW1lcy5oaWxsaWFyZDFAZ21haWwuY29tPg0KPiBTZW50OiBUaHVyc2Rh
eSwgT2N0b2JlciAyNywgMjAyMiAxOjQwIEFNDQo+IFRvOiBNYXJ0aW4gSy4gUGV0ZXJzZW4gPG1h
cnRpbi5wZXRlcnNlbkBvcmFjbGUuY29tPg0KPiBDYzogS29uc3RhbnRpbiBLaG9yZW5rbyA8a2hv
cmVua29AdmlydHVvenpvLmNvbT47IENocmlzdGlhbiBHcm/Dn2VnZ2VyIA0KPiA8Y2hyaXN0aWFu
QGdyb3NzZWdnZXIuY29tPjsgbGludXgtc2NzaUB2Z2VyLmtlcm5lbC5vcmc7IEFkYXB0ZWMgT0VN
IA0KPiBSYWlkIFNvbHV0aW9ucyA8YWFjcmFpZEBtaWNyb3NlbWkuY29tPjsgU2FnYXIgQmlyYWRh
ciAtIEMzNDI0OSANCj4gPFNhZ2FyLkJpcmFkYXJAbWljcm9jaGlwLmNvbT47IExpbnV4IEtlcm5l
bCBNYWlsaW5nIExpc3QgDQo+IDxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPjsgRG9uIEJy
YWNlIC0gQzMzNzA2IA0KPiA8RG9uLkJyYWNlQG1pY3JvY2hpcC5jb20+DQo+IFN1YmplY3Q6IFJl
OiBbUEFUQ0ggdjMgMC8xXSBhYWNyYWlkOiBIb3N0IGFkYXB0ZXIgQWRhcHRlYyA2NDA1IA0KPiBj
b25zdGFudGx5IHJlc2V0cyB1bmRlciBoaWdoIGlvIGxvYWQNCj4NCj4gRVhURVJOQUwgRU1BSUw6
IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyAN
Cj4gdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPg0KPiBPbiBXZWQsIE9jdCAxOSwgMjAyMiBhdCAyOjAz
IFBNIEtvbnN0YW50aW4gS2hvcmVua28gPGtob3JlbmtvQHZpcnR1b3p6by5jb20+IHdyb3RlOg0K
PiA+DQo+ID4gT24gMTAuMTAuMjAyMiAxNDozMSwgSmFtZXMgSGlsbGlhcmQgd3JvdGU6DQo+ID4g
PiBPbiBUdWUsIEZlYiAyMiwgMjAyMiBhdCAxMDo0MSBQTSBNYXJ0aW4gSy4gUGV0ZXJzZW4gDQo+
ID4gPiA8bWFydGluLnBldGVyc2VuQG9yYWNsZS5jb20+IHdyb3RlOg0KPiA+ID4+DQo+ID4gPj4N
Cj4gPiA+PiBDaHJpc3RpYW4sDQo+ID4gPj4NCj4gPiA+Pj4gVGhlIGZhdWx0eSBwYXRjaCAoQ29t
bWl0OiAzOTVlNWRmNzlhOTU4OGFiZikgZnJvbSAyMDE3IHNob3VsZCBiZSANCj4gPiA+Pj4gcmVw
YWlyZWQgd2l0aCBLb25zdGFudGluIEtob3JlbmtvICgxKToNCj4gPiA+Pj4NCj4gPiA+Pj4gICAg
c2NzaTogYWFjcmFpZDogcmVzdXJyZWN0IGNvcnJlY3QgYXJjIGN0cmwgY2hlY2tzIGZvciBTZXJp
ZXMtNg0KPiA+ID4+DQo+ID4gPj4gSXQgd291bGQgYmUgZ3JlYXQgdG8gZ2V0IHRoaXMgcGF0Y2gg
cmVzdWJtaXR0ZWQgYnkgS29uc3RhbnRpbiBhbmQgDQo+ID4gPj4gYWNrZWQgYnkgTWljcm9jaGlw
Lg0KPg0KPiBDYW4gd2UgbWVyZ2UgdGhpcyBhcyBpcyBzaW5jZSBtaWNyb2NoaXAgZG9lcyBub3Qg
YXBwZWFyIHRvIGJlIG1haW50YWluaW5nIHRoaXMgZHJpdmVyIGFueSBtb3JlIG9yIHJlc3BvbmRp
bmc/DQo+DQo+ID4gPg0KPiA+ID4gRG9lcyB0aGUgcGF0Y2ggbmVlZCB0byBiZSByZWJhc2VkPw0K
PiA+DQo+ID4gSmFtZXMsIGkgaGF2ZSBqdXN0IGNoZWNrZWQgLSB0aGUgb2xkIHBhdGNoICh2Mykg
YXBwbGllcyBjbGVhbmx5IG9udG8gbGF0ZXN0IG1hc3RlciBicmFuY2guDQo+ID4NCj4gPiA+IEJh
c2VkIG9uIHRoaXMgaXQgbG9va3MgbGlrZSBzb21lb25lIGF0IG1pY3JvY2hpcCBtYXkgaGF2ZSBh
bHJlYWR5IHJldmlld2VkOg0KPiA+ID4gdjMgY2hhbmdlczoNCj4gPiA+ICAgKiBpbnRyb2R1Y2Vk
IGFub3RoZXIgd3JhcHBlciB0byBjaGVjayBmb3IgZGV2aWNlcyBleGNlcHQgZm9yIFNlcmllcyA2
DQo+ID4gPiAgICAgY29udHJvbGxlcnMgdXBvbiByZXF1ZXN0IGZyb20gU2FnYXIgQmlyYWRhciAo
TWljcm9jaGlwKQ0KPiA+DQo+ID4gV2VsbCwgYmFjayBpbiB0aGUgeWVhciAyMDE5IGkndmUgY3Jl
YXRlZCBhIGJ1ZyBpbiBSZWRIYXQgYnVnemlsbGENCj4gPiBodHRwczovL2J1Z3ppbGxhLnJlZGhh
dC5jb20vc2hvd19idWcuY2dpP2lkPTE3MjQwNzcNCj4gPiAodGhlIGJ1ZyBpcyBwcml2YXRlLCB0
aGlzIGlzIGRlZmF1bHQgZm9yIFJlZGhhdCBidWdzKQ0KPiA+DQo+ID4gSW4gdGhpcyBidWcgU2Fn
YXIgQmlyYWRhciAod2l0aCB0aGUgZW1haWwgQG1pY3JvY2hpcC5jb20pIHN1Z2dlc3RlZCANCj4g
PiBtZSB0byByZXdvcmsgdGhlIHBhdGNoIC0gaSd2ZSBkb25lIHRoYXQgYW5kIHNlbnQgdGhlIHYz
Lg0KPiA+DQo+ID4gQW5kIG5vdGhpbmcgaGFwcGVuZWQgYWZ0ZXIgdGhhdCwgYnV0IGluIGEgfnll
YXIgKDIwMjAtMDYtMTkpIHRoZSBidWcgDQo+ID4gd2FzIGNsb3NlZCB3aXRoIHRoZSByZXNvbHV0
aW9uIE5PVEFCVUcgYW5kIGEgY29tbWVudCB0aGF0IFM2IHVzZXJzIHdpbGwgZmluZCB0aGUgcGF0
Y2ggdXNlZnVsLg0KPiA+DQo+ID4gaSBzdXBwb3NlIFM2IGlzIHNvIG9sZCB0aGF0IFJlZEhhdCBq
dXN0IGRvZXMgbm90IGhhdmUgY3VzdG9tZXJzIA0KPiA+IHVzaW5nIGl0IGFuZCBNaWNyb2NoaXAg
Y29tcGFueSBpdHNlbGYgaXMgYWxzbyBub3QgdGhhdCBpbnRlcmVzdGVkIGluIGhhbmRsaW5nIHNv
IG9sZCBoYXJkd2FyZSBpc3N1ZXMuDQo+ID4NCj4gPiBTb3JyeSwgaSB3YXMgdW5hYmxlIHRvIGdl
dCBhIGZpbmFsIGFjayBmcm9tIE1pY3JvY2hpcCwgaSd2ZSB3cml0dGVuIA0KPiA+IGRpcmVjdCBl
bWFpbHMgdG8gdGhlIGFkZHJlc3NlcyB3aGljaCBpcyBmb3VuZCBpbiB0aGUgaW50ZXJuZXQsIHRy
aWVkIA0KPiA+IHRvIGNvbm5lY3QgdmlhIGxpbmtlZGluLCBubyBsdWNrLg0KPiA+DQo+ID4gLS0N
Cj4gPiBLb25zdGFudGluIEtob3JlbmtvDQo=
