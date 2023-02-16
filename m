Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ADC769909E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 11:01:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbjBPKBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 05:01:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjBPKBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 05:01:33 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 813B910EF;
        Thu, 16 Feb 2023 02:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1676541692; x=1708077692;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Vaw/xLBCiFgUUfui4ipBxOphabndfS8E2JLsaIRhgD0=;
  b=xtgArd/HAYzS+hfFYyKjE5t+pWUgVt2Wr9WwEvVORgVCj0po5Q1vqJI1
   WuPYrafU5EbL8x0ow2V/pOGqFRkWMJdJVL8k6cAQvQ3w2Q1Wr8v73Ydgm
   FYfKN2JjRwMj3SuLDxBzeNZbJ7ygN2vyWqauSWFHzH0dZfIx4uzxANG19
   GMhwjJjfKV/t9AXGgV1iU2pnvqZBG2dbWb6blnS8FEA1G0gv/IPFR0WtU
   KCY9lA9VsIN34VDvPrlsLxAXK7UK4fBswybIVe+q8ohz0l+TkwWEc3knG
   b/AaHqv3hdL+QkmeQGpmRJEZ+6YYtyagfmc7kZeF39ogbOu7Fzxrhha6R
   A==;
X-IronPort-AV: E=Sophos;i="5.97,302,1669100400"; 
   d="scan'208";a="212287077"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Feb 2023 03:01:31 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 16 Feb 2023 03:01:31 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 16 Feb 2023 03:01:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D7XJNl+SXpUrGSV1B0sQ937zpMu5FHDWEvLPuE5EZQVJ3voBbXx8fu1zqjqXyUwshb1W0Ca5GLJHuzScVEKorjDPpafNUDzLI7aduI2rzi08U/0Lc77BWyW5m4QnVm9v/L/FNkQaMcTgcwAcQVASCCGhTO6QLeKkfeI+x/PKAOq04XeV7PEGcg+ZNlLvH7ZRKZz2+hZ/j7qiegvswhl3JRo2jnPALjJsZjuNNY23xM1yRNaHp7sx4CCxbpDajnW7L+oCnt2qO8mcpXgsl0Zw23pf1rb0GL+7tiXsirI/xMI5y/To1KHbx1jJcCd+tkjSGAIeGmgCttkMcaIlE/+p+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vaw/xLBCiFgUUfui4ipBxOphabndfS8E2JLsaIRhgD0=;
 b=nMsT69Whwqj+IEs5sywl/fQDOon62kvbHRWjI4cdj/0AHN3PEQAjG0pc9NmJceeVaCEmtF6ayBCGsBad7jYeK91nFy8gnyrbgFefqlNVTulUCzUQV72qG6Mo+OlOKmgiDTh39RK7MZlR4meaEEW+HLGV8bQxuzflVE34hNoXiqXZNbv49rWbipWNcfxiIs0RrTCWuUZxlxrxhz+ngIheAqgVrC5SUNFbtIDS1nWK1jHYHaJBvQqfdrcUTQhEfr4v59n90J2C553WhESpuwjcefVYejdbEGVVOeAsmTQD8EreaO3eOj2mlTmpFN8qN/gamkd883U5WtyNljmXDqP0rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vaw/xLBCiFgUUfui4ipBxOphabndfS8E2JLsaIRhgD0=;
 b=aIWvy+/hgxvx6FVeB6dmr1LsQp4EG2RmJ7h7HTOUMDcr5yE2P7BdWjfHdhlJoNRDGUegDo05d12W0AiekXCITQSxscyrY4DDkl2A6xh+gqTe534JSwFy3XUaDTUx5Oj0WtR0cFAb4p28oMi+0Vqq7meCFYMFl9drCHwd50MVUaQ=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by BL1PR11MB5349.namprd11.prod.outlook.com (2603:10b6:208:308::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.27; Thu, 16 Feb
 2023 10:01:29 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::6eb8:36cd:3f97:ab32]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::6eb8:36cd:3f97:ab32%5]) with mapi id 15.20.6086.027; Thu, 16 Feb 2023
 10:01:29 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <ye.xingchen@zte.com.cn>, <sre@kernel.org>
CC:     <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: =?utf-8?B?UmU6IFtQQVRDSF0gcG93ZXI6IHJlc2V0OiBhdDkxLXBvd2Vyb2ZmOiBVc2U=?=
 =?utf-8?B?wqBkZXZtX3BsYXRmb3JtX2dldF9hbmRfaW9yZW1hcF9yZXNvdXJjZSgp?=
Thread-Topic: =?utf-8?B?W1BBVENIXSBwb3dlcjogcmVzZXQ6IGF0OTEtcG93ZXJvZmY6IFVzZcKgZGV2?=
 =?utf-8?B?bV9wbGF0Zm9ybV9nZXRfYW5kX2lvcmVtYXBfcmVzb3VyY2UoKQ==?=
Thread-Index: AQHZQe2jHequh57PZ0SPhQIpZy0v5w==
Date:   Thu, 16 Feb 2023 10:01:29 +0000
Message-ID: <188f341c-cc4e-16ae-d551-184bb48f09da@microchip.com>
References: <202302151449285733136@zte.com.cn>
In-Reply-To: <202302151449285733136@zte.com.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR11MB1953:EE_|BL1PR11MB5349:EE_
x-ms-office365-filtering-correlation-id: e37b0fe1-3b1c-4057-2c0c-08db1004c627
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Jrhq4DWFLnJHnVYXI6TU85amZSsQ+ZSuLfCtq3rI92AbYM1kfj8AP9G/Nu3tFGqoX3G61WXgyCxM4GSo5cIgc2IJ1amc+RqIsqaih9+/lpOsgzQzTs4f6EnyHkyM+AS2zLj+6Jm3sMHehUSMy9F5tv6Utj6sE+H3mjkVO/FzGNcb3Z4Zdc+qxFNXX03KKRGSl8STz3ntc4mAF0yVJSuA0jF3BCq48wihBNG/cjVw4q+ta2RDZyeTzvRicu/6Uxmem/hGbW1IqkfmX/n3VnnxlQBTKfdt1AnNEyagqWsRQAAe5So8X0gkslcQhbBk1EpEdE9qa2QMGEltD4VRTN4hZ5Ud07E36rzNEXVAjlmhzWM302YeTd8wux6yuJf2Dd15D0KQ7vsHsTwix8q3gIUlGvgai+LD1oQhYhSQPsVIid6WmcC1vx2mPdfP8/D21UQhXS2ggfDVZog10baaqWqm3IgSOOIsKHIr+5AFmbF7hUWbcMeExKKNL0v41j0p+dvjluObFRiqjGOs8z7GwsnJncN7U3LMt5RfprT/A65V8RFLYFzgsXsFBMml/OcoUObdWvo3HL/S/fu4u+49gZx5yfGZIv3JvpuExwCOPWH7ksbdFeXf2zKB1mIH+XIgEQmkz7XAXvhEd6nAq3l0cCyTwA7GAEAwE0dR0/+X27O1OrABoboGlEORlCXjgMvcOFA66mzU+inWB0ZMljDun8gIWk4fa6FtN4OLGk5a74Jmfy64gf35IpwMxRZry+VjCLvZQiDRYbQ1DUEcB9n5Js2c2wMR3RGfkzLZMLJtY5Eb2PF/Z6eeY2LmXpjNOvv4q/7v
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(136003)(366004)(39860400002)(346002)(376002)(451199018)(4326008)(66476007)(91956017)(76116006)(66446008)(54906003)(8936002)(110136005)(316002)(2906002)(478600001)(6486002)(41300700001)(66946007)(66556008)(31686004)(53546011)(26005)(186003)(6512007)(2616005)(6506007)(83380400001)(38100700002)(122000001)(31696002)(86362001)(5660300002)(71200400001)(36756003)(38070700005)(64756008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ek0rQ08zNk9RZU5aeUQrYTBONkpOZCt1QnJSV1lEbmgrclFNeWQvTnh4VU5m?=
 =?utf-8?B?T3ZGTDhOVEZja1gzdGdmWkVyVDNHa2tFaVF2bWw0NmtobGhxUTZpaXZIZHZR?=
 =?utf-8?B?OUZ5ZjZwRFBKUDhZRFZDNWxKc1FkN081NEM0Y3IxS3R3SWg0YTN3M0tycnZw?=
 =?utf-8?B?MmJFalNQUGZRbDZIRGU1Vld6V1pPaGREUHpuRkgyM3BSaW5aYStIUWcwdzZK?=
 =?utf-8?B?dHN2amZCM2ROMGt4b21rdEI3d2dqUnNFNHRUMUtNbmhRYzJsYkF4cXBCRUJO?=
 =?utf-8?B?K2J6THhrVEFtTWt0eGQ2dmx0T0NZL3ZuS0YvMHJTQy9ja2FrZG9zNERDdGJC?=
 =?utf-8?B?TlBxWW1BZ3J4MEdMcHJDdFZoNElmNUdYT3B4SVJCejhLa1lWaGVlNmhaeEcy?=
 =?utf-8?B?YW1iUkwxcFpnZjVrVVJjZ0Q2R2xPVmxWWE1WbnZLeVNET2FtQkhWaG5Dd1JH?=
 =?utf-8?B?cjMzVjh2MGQxNE1MOW93UkI0NXNHd0ZJenZ4K2JrUGVYcGdYOTh2dEIwRkZh?=
 =?utf-8?B?T3g1WnV0d1g0aDR2RXpaSFpXTm8yYk45TVEyS1RhOThJL2VBNlpGNklqVVRX?=
 =?utf-8?B?c3J1aEpNKzVzNXU3L1lGbFZsR1E0RVUrZUpXSlNPcjdnZlY5WW13QlFVczB6?=
 =?utf-8?B?M3pkQTVCL0pwdWJDRitxdC9CWml1VnNEN056R0pBR3FJc01adzVxVWJSMkFS?=
 =?utf-8?B?aStkaXd0MEkwNk1ZekMvVTdoY0s2aXdseDRuWk54TG1kNU5XMHp4ODY5cEdV?=
 =?utf-8?B?cHJmUnM1SjZoQWVTTEI4VC8wRE5lbHd3Uk9OSkdCRkpPNWVLY2VBREtjcWc0?=
 =?utf-8?B?YjhQbjJlNDFMN3A3RE51QTFoeWNWd3pZNWJTSHVEWVVGdXlqV3RMdk5jeERR?=
 =?utf-8?B?Tk8zTVpheVNmbkUyV1lyZjVIanRReW1sU3lXRjYzQm9TaEdYY3VrcWFtZ05n?=
 =?utf-8?B?L2xYNXk4YWpHcGd4a0Q3aFh0UlRiM3RBa2UvcUwrOVdNc1RVUVlxSUN2WElq?=
 =?utf-8?B?dHFGOENUNS9hR2lEcmNrdllsNGdIZm5YRFJrRVIvdzlTWnczZ1BNeTlsNFJY?=
 =?utf-8?B?NXRreWxZcFozSExwVkRwK21OaVUvRnRZNEQ5ZGw2L2ZtcE1zYUNYV01Obkxz?=
 =?utf-8?B?VGRpUTNXSHFpSXFIeGVnbHlNeUtSc1dJTkc3MWhHRVdXcXMxcndpZjJSRGJV?=
 =?utf-8?B?eWd2V0tOYWVzWkpjTFJ5ZGdxenJGaHdBSmJ5Q21FUFB1d1J1Z0o5UDBMVUw5?=
 =?utf-8?B?QkxVSzR5V1JGeGJXcVgzZHdUK1pFZ3lRTUZIUmNKVW43MDBlZ0dnVDU5U2VV?=
 =?utf-8?B?d3Z5ZUtkYWdxYUFVQnR6OGhaOXBReDBocWwrVUdWWXJOenl4YVE2S29sS1BW?=
 =?utf-8?B?a0dDSVJBVktEZHQrclR2bHdsc00ydWFaY1NUS3VCbFRCRld6MTcxN2pkMGZI?=
 =?utf-8?B?OXpwS3VLRFNyRjJGZG5tL250c0wzejYwcG5EVVlJdHZnMXZ6Vk1iYUE3aS9F?=
 =?utf-8?B?Q3F1bFZUTXNxRnlHaFFJZEZ0eHUySXY4Y3IrUUx0c0R6d0lJREVOK0s5ai93?=
 =?utf-8?B?SWFTWWRDNTR2NmwxQ0MwOCtFSDNtd3RCVy9FVldPZm5WYXFyZFpQY3NKY0pZ?=
 =?utf-8?B?RDFScWdtR3lnR25iWmQ4amYvcTM3VnVNWEN6YU1CeU5vbStla1Eza0JjRnpi?=
 =?utf-8?B?L0FRQjloNU8vMTI2Z0xmNVJ3V1d5T1N0dE14NzAwNkMxWlppcHVHa1EyK2E2?=
 =?utf-8?B?aXRyK29HeDVnZXFNSTVCeHZHQlkyaGFLVjFwQ2pEdkRNMkdTOUxGMTJ2MGwz?=
 =?utf-8?B?NUQwclp0TWdaeFFhb3BKTE1GL0dWZFRDbS9hK2ZGenlyakRjcUUvS1IwL3g1?=
 =?utf-8?B?UDUrNWdMdWhMaWczWmVoc0xUdG9zYkdtSTBMTWx0OVB0cXlsemN3dGd5ZFls?=
 =?utf-8?B?aG5QN0wzRTQwdTF5eTFYejluTVkrbys3cUpsRmhIamF3d3F4T2ROMUMwaWNt?=
 =?utf-8?B?S3dMT2dJOXhVaFVlL2dSL01RY2tFZ3Z4Um50aER3YmhHQ2tENlRuWHFSNHNz?=
 =?utf-8?B?ZDYrSXlUdE1JVHpJRWhVemRreVJ5NjhpZlVHZXM0ckhCcmozMnJRQXM0dGJp?=
 =?utf-8?B?Sk1McnFGMDh1U09UUGlkd0V6eUIrUm5FbnFGakszY045cE50WlBhQ25GRytw?=
 =?utf-8?B?dEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3B66D9D0C022AA4FAFE5627AF04BBAA3@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e37b0fe1-3b1c-4057-2c0c-08db1004c627
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2023 10:01:29.2957
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3q2yGBnjaq8NWpYKYigtyb6nYBl8NYssHlRd14mCfy1SCNV1r6CI+NPzsC0uzmf8ePLg76HGRaRsjG5yJMO6JDxuoAR0dVyzBs+NR//2Dto=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5349
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTUuMDIuMjAyMyAwODo0OSwgeWUueGluZ2NoZW5AenRlLmNvbS5jbiB3cm90ZToNCj4gRVhU
RVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVz
cyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBGcm9tOiBZZSBYaW5nY2hlbiA8
eWUueGluZ2NoZW5AenRlLmNvbS5jbj4NCj4gDQo+IENvbnZlcnQgcGxhdGZvcm1fZ2V0X3Jlc291
cmNlKCksIGRldm1faW9yZW1hcF9yZXNvdXJjZSgpIHRvIGEgc2luZ2xlDQo+IGNhbGwgdG8gZGV2
bV9wbGF0Zm9ybV9nZXRfYW5kX2lvcmVtYXBfcmVzb3VyY2UoKSwgYXMgdGhpcyBpcyBleGFjdGx5
DQo+IHdoYXQgdGhpcyBmdW5jdGlvbiBkb2VzLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogWWUgWGlu
Z2NoZW4gPHllLnhpbmdjaGVuQHp0ZS5jb20uY24+DQoNClJldmlld2VkLWJ5OiBDbGF1ZGl1IEJl
em5lYSA8Y2xhdWRpdS5iZXpuZWFAbWljcm9jaGlwLmNvbT4NCg0KDQo+IC0tLQ0KPiAgZHJpdmVy
cy9wb3dlci9yZXNldC9hdDkxLXBvd2Vyb2ZmLmMgfCA0ICstLS0NCj4gIDEgZmlsZSBjaGFuZ2Vk
LCAxIGluc2VydGlvbigrKSwgMyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL3Bvd2VyL3Jlc2V0L2F0OTEtcG93ZXJvZmYuYyBiL2RyaXZlcnMvcG93ZXIvcmVzZXQvYXQ5
MS1wb3dlcm9mZi5jDQo+IGluZGV4IDllNzRlMTMxYzY3NS4uYjdlMTdhZmUzMGUyIDEwMDY0NA0K
PiAtLS0gYS9kcml2ZXJzL3Bvd2VyL3Jlc2V0L2F0OTEtcG93ZXJvZmYuYw0KPiArKysgYi9kcml2
ZXJzL3Bvd2VyL3Jlc2V0L2F0OTEtcG93ZXJvZmYuYw0KPiBAQCAtMTUxLDEzICsxNTEsMTEgQEAg
c3RhdGljIHZvaWQgYXQ5MV9wb3dlcm9mZl9kdF9zZXRfd2FrZXVwX21vZGUoc3RydWN0IHBsYXRm
b3JtX2RldmljZSAqcGRldikNCj4gDQo+ICBzdGF0aWMgaW50IF9faW5pdCBhdDkxX3Bvd2Vyb2Zm
X3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICB7DQo+IC0gICAgICAgc3Ry
dWN0IHJlc291cmNlICpyZXM7DQo+ICAgICAgICAgc3RydWN0IGRldmljZV9ub2RlICpucDsNCj4g
ICAgICAgICB1MzIgZGRyX3R5cGU7DQo+ICAgICAgICAgaW50IHJldDsNCj4gDQo+IC0gICAgICAg
cmVzID0gcGxhdGZvcm1fZ2V0X3Jlc291cmNlKHBkZXYsIElPUkVTT1VSQ0VfTUVNLCAwKTsNCj4g
LSAgICAgICBhdDkxX3NoZHdjLnNoZHdjX2Jhc2UgPSBkZXZtX2lvcmVtYXBfcmVzb3VyY2UoJnBk
ZXYtPmRldiwgcmVzKTsNCj4gKyAgICAgICBhdDkxX3NoZHdjLnNoZHdjX2Jhc2UgPSBkZXZtX3Bs
YXRmb3JtX2dldF9hbmRfaW9yZW1hcF9yZXNvdXJjZShwZGV2LCAwLCBOVUxMKTsNCj4gICAgICAg
ICBpZiAoSVNfRVJSKGF0OTFfc2hkd2Muc2hkd2NfYmFzZSkpDQo+ICAgICAgICAgICAgICAgICBy
ZXR1cm4gUFRSX0VSUihhdDkxX3NoZHdjLnNoZHdjX2Jhc2UpOw0KPiANCj4gLS0NCj4gMi4yNS4x
DQoNCg==
