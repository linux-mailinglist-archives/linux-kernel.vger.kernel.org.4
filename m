Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D48A6695948
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 07:37:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231580AbjBNGhu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 01:37:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231481AbjBNGhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 01:37:47 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DABD21C5AF;
        Mon, 13 Feb 2023 22:37:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1676356660; x=1707892660;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=i/PSGqnHXQYeelzgMakKo6LRTt+7cmoSBw7Gjz8aNxE=;
  b=wTSGsbosd/Fna0lzIgHnW0jqy30yw6A3J34TlLUlsR65eCX5+JIWcz6l
   mGkmye07SCwre8OpvijI1HY5hrwGI5f65+6MiwuiuVWUKWN2sOzeDHqIJ
   8XkUJnRTuENcKItDU45cPjGonCxFVHA/m7agh9CmoI2P8PzSZIZO9VoFw
   5WzmCT/FzW81KQQEkP6KkA2BInTT7r7NZ/+0dkttD2MqMGnAtoz/Us9no
   uO2BC6xCT+YEPch2k89R0WXxu3BrP69RKpsRONjZihoYSQC4D1BCQ2nxX
   2IQHLNjQrFCFLMuTPpsa460TN3gIteGnWV5ef2knut1pNbAlKB3DKf/pW
   A==;
X-IronPort-AV: E=Sophos;i="5.97,294,1669100400"; 
   d="scan'208";a="137041144"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Feb 2023 23:37:40 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 13 Feb 2023 23:37:39 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 13 Feb 2023 23:37:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M8vhc8ODLf6Kn5nmOygmUtVz6E+KLfgHsTdU+PA48XWXyZILnwVh/L9z9NYpFi71OajJVhHWTXmeCICshtOsuXenS5YDRSEQnlBuwpYKCUTULQRvRn7fSFPaTonuCEySGfz/c0FbkN0zmK7JHccAM/e6QEzVU8ba5R3VfJ8UDyn9gn3uASum1pWiwRjUAIBz970XmHwxCtxP3aDewQEq+1zXI4xgf7tClS8uJbIHMDVGM2ZbSk9heigyWIKIoHfmgW0eNdZIaj0jGviRn3LL2MbJOrr6YfgD2exu2JvBciQGWILTYwXyAN4Wk1lw1rUn0OrEbLfjpS0GjuA4vV9hnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i/PSGqnHXQYeelzgMakKo6LRTt+7cmoSBw7Gjz8aNxE=;
 b=OUlgcR420Xzp4q/oA4ivm5aY1YxSi7VnBf/cJkqFLg1J8V/xnco4W/6OGeTunwC9VfpgiVqglvrbgsvGmQ8qMYfd+CpQrApf9FdSDAHEfhmmYDTSsSbohQRDcmR+i22WZj+eWjGkyETNR8n6BmWECbf6ZBSSLJCFrBdk7CopA3tQvi8u+1r33GV3YcwGhpPzDoQb5utVwSx/Mzf+J50E7LjVjFao4NZCyqQVbNQhWcompfCnKTlRPI4Io9x4uJO/vnzt+Pu0rwsdN02EO4BNSYONdmRMmmYGyPKocLj2/vEidwcG2op7jaJSuCjQAgTX0MRLBJmV7AcGdTl0y/Sz1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i/PSGqnHXQYeelzgMakKo6LRTt+7cmoSBw7Gjz8aNxE=;
 b=NfCglL/KrVEcx7OymtGzHR+Qj4dm73XEdhJXxMERMrT3TmS3/AzMEEMPAqTNcV4anOP/8Ja3dF7zMZ8O/OBKYoPIMKw2cL23rwfkMw51r3IbKsVhVCbJj/ucLdsgwh+XSE8vQ3k24skDzuXBmL1Ilu51eaiaP9MWqCj/sv1HEd8=
Received: from PH7PR11MB5958.namprd11.prod.outlook.com (2603:10b6:510:1e1::22)
 by DM6PR11MB4657.namprd11.prod.outlook.com (2603:10b6:5:2a6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Tue, 14 Feb
 2023 06:37:37 +0000
Received: from PH7PR11MB5958.namprd11.prod.outlook.com
 ([fe80::cf2e:97c:7f47:9ca6]) by PH7PR11MB5958.namprd11.prod.outlook.com
 ([fe80::cf2e:97c:7f47:9ca6%5]) with mapi id 15.20.6086.024; Tue, 14 Feb 2023
 06:37:37 +0000
From:   <Tharunkumar.Pasumarthi@microchip.com>
To:     <christophe.jaillet@wanadoo.fr>, <linux-kernel@vger.kernel.org>
CC:     <linux-gpio@vger.kernel.org>, <gregkh@linuxfoundation.org>,
        <arnd@arndb.de>, <UNGLinuxDriver@microchip.com>
Subject: RE: [PATCH v5 char-misc-next] misc: microchip: pci1xxxx: Add
 OTP/EEPROM driver for the pci1xxxx switch
Thread-Topic: [PATCH v5 char-misc-next] misc: microchip: pci1xxxx: Add
 OTP/EEPROM driver for the pci1xxxx switch
Thread-Index: AQHZPpY5D8pOvjRSE0idcTrTWegJHq7K86uAgAMLz3A=
Date:   Tue, 14 Feb 2023 06:37:37 +0000
Message-ID: <PH7PR11MB59584043A6EF64BC4C7291C89BA29@PH7PR11MB5958.namprd11.prod.outlook.com>
References: <20230212035743.231353-1-tharunkumar.pasumarthi@microchip.com>
 <99b3f6a9-ab7d-b3dd-2a54-3fcd72607ec6@wanadoo.fr>
In-Reply-To: <99b3f6a9-ab7d-b3dd-2a54-3fcd72607ec6@wanadoo.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB5958:EE_|DM6PR11MB4657:EE_
x-ms-office365-filtering-correlation-id: 5788235b-522d-4139-ccca-08db0e55f689
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dBNsLXOfyeqY9Ae+eKDB+KIyjNRXCKMsSbp+dPFhMp3fbswJM/X+2Wqqm6x+24u6JeT/5NQSyV1ocCUP16vF0iHsDQ8H7g1hABuHU3QNt7ptgKufKIDJVgrIRrXj+bQKGSVHIjk/icV7PRYTl//hNgufU7toVveDf+Vpx1PR3engcuhHI8QnK5Dzb0D8/7TXsqXxSfhWDEoecp7VmS1MYT7nW6j89plkOPUpuoUENPgXxOXyV23rf2tyvVAL1RwKhb6Rfq+phYhcoViKg93e5hlE6dj8EFbceJB9cLVxpXNlklUOXqAayuX1PyWP06VOyIIlI5em5GQDiWMc8VNs//v7MlMgxkHf6hABU2aPsJI1iluR932SPnZ0pbpaR8a6OujI4Q5NnkMGEbliB1Z2d350pI7lxxEoIvrbbXJ1knB2zp0yN/E9QQT98Mhg0s1Fphl5v4jXxWid6mvccbas/cu9CB+8MyEMOLxrgJ0fRSoYU9qY4+cX00N2DfsrFtn8VPoeeuus1rLpKE51uubvO7Mq+00X/BbcBzz+tfqsVf4rcrLppl+CSpnf+eN9KUbi0tZwe5c8gIL7wwZXTQNpIk4Zyt86gdDB6vX/4P0oJ7Ft/F5RSDmUdpmZ7r+RuwRBxxFzmXqQn7PxfwQ2Ce7qGwD8Zq4WqT62Ccgi8VziMHEsP0Um2+GSHfwO6omG3cPZdN7jxAWZamFCylCJQM33Z0hDiUovDxOXownWhNLhwKNmyPrkzdw1g2DqdZacinze5PN3IYGJdv3ZUp1AANPT1pD9aubEYOvMXzNEakj2k78=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5958.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(366004)(396003)(39860400002)(376002)(136003)(451199018)(4744005)(38070700005)(2906002)(5660300002)(71200400001)(55016003)(83380400001)(26005)(186003)(122000001)(76116006)(66476007)(66446008)(38100700002)(64756008)(8676002)(4326008)(66946007)(8936002)(316002)(54906003)(66556008)(9686003)(33656002)(41300700001)(107886003)(478600001)(6506007)(53546011)(110136005)(86362001)(52536014)(7696005)(32563001)(473944003)(414714003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UHBObXZTdFZMRFFuUmpZK0I4M3Fxc2liZzJhaGQxVm1Pd1hlMFhvUzFBUGgx?=
 =?utf-8?B?WEVYVDI1azNoRXMzNE04ZmhFZEljV3hiQ1l6cURPcEZtS09Bdzk5M2IvTjkr?=
 =?utf-8?B?SmR2MEY4Qzc5VXZjK3E4M0hjbmFiS0dkV1d2elJ0bm42Q2ZKcmEzbk5UQm1w?=
 =?utf-8?B?YkJXZDdqM3dKU3Zxc2hBR1VrUXkzQWxmVHB5VEpsbjVjSkUyYThSSVdmRVR3?=
 =?utf-8?B?YnB1VkJEMTduWmliT1pFU2lWRlY1Z3JTN0Z2bmtrelk5MEtHeG9jWW9zK2o1?=
 =?utf-8?B?bmFRN29qc3lnN3EwUEpreUp4YWdLWEVHZy9XUUNlNVh4OGF3M3FLSUxFR1k5?=
 =?utf-8?B?NFBvN3IzTW1EZXRTSW5nNXN2SXhMWjR0OEdha2ZSbURlOTZUeGFIVTBjK0R4?=
 =?utf-8?B?aHlQa2JjUDJOdGhjOFkyUUdzMHdYTjIyTjkweWxkQUppR0NiMlVnUVQ4ZzRJ?=
 =?utf-8?B?L1Awbm1NSFVYK2MrY2tXME1abk5iS05kOUI2Qy85eExta2FPRkhuS1ZZeDdZ?=
 =?utf-8?B?SzZLd25aU3ZBeXFBa0RFNFF2Z1I2WmxXVjA1TmpTemZMcDgyUmN3VGdodVNU?=
 =?utf-8?B?VzhXRk0wMDN2UDdFSzdSanVZbklTQ2RvemEraXdoZ2pxUGczZWtkdnp3UktT?=
 =?utf-8?B?eG00VVhYR2pPdXd6TXhWeVJlRy95c0gyRmhLOGNMSmxsaytpY053UFJOVGFt?=
 =?utf-8?B?bzlTT1Q0SVMwc3VoYXhWbGRGVmVEUytMdFU5S1BiYlQrcXdvQzNUMHBIVTRV?=
 =?utf-8?B?Ykw3VE4xanMrTXZBTDZiczdqWWVQbGpxeitzMWh0ckJITEkwV1oydnk5SlJ6?=
 =?utf-8?B?SVhYbzV1RGtCL3RJKy9iMWx1eUNhZUpCUnV5RzAreUlrOTdqRnhhU2xScEN6?=
 =?utf-8?B?N1hHRDd6eWw2UHU4Y2Y5SEhURzZXbC9VU1liS1gwMFJZb2txUjlkZFZHcUMy?=
 =?utf-8?B?RGozVnlhMEVhN0NUdUllaTRHbUs0Q09CZXJMLzNlUm9PN1U5b1AvMzVtOTZa?=
 =?utf-8?B?MHR2OUxZT3haUjN1MWFKdVBZUkJic0tCeEtYeGtOM01CekFZU3QybjVnVGQ3?=
 =?utf-8?B?dEJSTnFucE5GL2Rva3AzdzNualhCTXhPL05KVkg4VXVya1p1elJNSVhzNW1R?=
 =?utf-8?B?b3BGV1FiZ256bmlGUWMrZS9hV1AxTExTY1RxRTcwQlZwclczMGl6VGg5K0ZT?=
 =?utf-8?B?WDUxM29maGZyRVcrSEdqa1BkVjVPaTExSHpVaVVaOTVGVU16S2JmVmw4R2l1?=
 =?utf-8?B?a0VaaVdMbG5MVk00Ri8zYVBEVm5rYUpabFR0QmcyWnJzWUcxazlKcGZLYTZy?=
 =?utf-8?B?L3cyc1ZZbW11WkYzYmhSUU90VlFUNGVVYTJ0TkVwQ2ozL0UzcXZucTNIV3BQ?=
 =?utf-8?B?ajVQd0tUNUo0RHY3aUl0eHY5RS93V00yRURZdFJWVFJYc3VobkxxT1hET3JB?=
 =?utf-8?B?UmpQNUtnVTNaUjdybTZpY3VMKzBKRnB5SCtpQ3pnVC9OWUUwQit6dkdhUWtk?=
 =?utf-8?B?ckxoOVpvdGRKK0taS2xmN21FNlg5VElXK1lxZEhUQnp4Y0NxWGljRmFSQWh3?=
 =?utf-8?B?di9Zdm9VNFZmYkNUcDB4RThSVzBiUDdIRmNiaE9EaUl0ZjRhVkE2dUVXc1B1?=
 =?utf-8?B?enpMVnNnS21HZTFrRXJhY0ZOTG52c0NyYVAya1RFR2RCM25SSHpDdVVsK0Iw?=
 =?utf-8?B?L2xCSi9tWmxPc2g5VXczQWFSNnJJak82K2NrdHpqbC9XSDhQcFpJeEpQU3ZC?=
 =?utf-8?B?VnRPNnhveXluZkRZV2NmcXBzNCsxMTRiLzF1M0h5eGI1TGZrWGJLTkN6a3dX?=
 =?utf-8?B?R0tUQUdzUjFseFZ2WXZ6enczZGpITWhhZFZlcnVPbi90Y0xHZUxDRHZkMTFh?=
 =?utf-8?B?M0JndUJKWVcrMTlmbkdKUUhFZlFqSmNIOXdOcEpOUzdwOEwrcVRoK0UwaGt0?=
 =?utf-8?B?Q1Bkc0RLUmx0Wld3bmd3M082bVhRVURIQUk4WWczYXl5UzdrcDVhK0t0NW40?=
 =?utf-8?B?bHVwU0V1S2cycHdRY0t6RGJqeTJUQUNGbXJvekZQK2pFVFc5aU1hNVZhd3RM?=
 =?utf-8?B?dnp2VjFEaGdtYUxWREYvRmpnaWFQSnVzZklGY2pQc0hjcEJiRmpJNk12Q1J1?=
 =?utf-8?B?SXR0UW9UZE5rR1NTNHlZbjRXcEtIZFRHdXR4V1RjbUgwbEljc1dyTXAwL1V4?=
 =?utf-8?Q?r5f0daVuStvIrWhm7bfNsms=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5958.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5788235b-522d-4139-ccca-08db0e55f689
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2023 06:37:37.3979
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UoGWb/IeH8tDHkLSXSVmkRLPTe2zEeCQ7bFtDXUAXQt8Fi1H218uahAM3mit5k6EXiIt0Ea4SdWTIuzIyOfIbKsS95Eha/DKPTQUElkGsz1M/n+phLpPN11j5bXT8DvV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4657
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBDaHJpc3RvcGhlIEpBSUxMRVQgPGNocmlzdG9waGUuamFpbGxldEB3YW5hZG9vLmZy
Pg0KPiBTZW50OiBTdW5kYXksIEZlYnJ1YXJ5IDEyLCAyMDIzIDE6MzMgUE0NCj4gVG86IFRoYXJ1
bmt1bWFyIFBhc3VtYXJ0aGkgLSBJNjc4MjENCj4gPFRoYXJ1bmt1bWFyLlBhc3VtYXJ0aGlAbWlj
cm9jaGlwLmNvbT47IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IGxpbnV4LWdw
aW9Admdlci5rZXJuZWwub3JnOyBncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZzsNCj4gYXJuZEBh
cm5kYi5kZTsgVU5HTGludXhEcml2ZXIgPFVOR0xpbnV4RHJpdmVyQG1pY3JvY2hpcC5jb20+DQo+
IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjUgY2hhci1taXNjLW5leHRdIG1pc2M6IG1pY3JvY2hpcDog
cGNpMXh4eHg6IEFkZA0KPiBPVFAvRUVQUk9NIGRyaXZlciBmb3IgdGhlIHBjaTF4eHh4IHN3aXRj
aA0KPiA+ICsgICAgIHVucmVnaXN0ZXJfYmxrZGV2KG90cF9ibG9ja19kcml2ZXJfbWFqb3IsICJP
VFBCbG9ja0RldmljZSIpOw0KPiA+ICsgICAgIGF1eGlsaWFyeV9kcml2ZXJfdW5yZWdpc3Rlcigm
cGNpMXh4eHhfb3RwX2UycF9kcml2ZXIpOw0KPiANCj4gSSB0aGluayBpdCBpcyBoYXJtbGVzcywg
YnV0IHNob3VsZG4ndCBpdCBiZSBkb25lIGluIHRoZSByZXZlcnNlIG9yZGVyIHRvIG1hdGNoDQo+
IGhvdyByZXNvdXJjZXMgaGF2ZSBiZWVuIGFsbG9jYXRlZD8NCg0KSGkgQ2hyaXN0b3BoZSzCoA0K
VGhhbmtzIGZvciB5b3VyIGNvbW1lbnRzLg0KDQpJbiB0aGUgZWFybGllciB2ZXJzaW9uIG9mIHBh
dGNoLCBhdXhpbGlhcnlfZHJpdmVyX3VucmVnaXN0ZXIgd2FzIGRvbmUgYmVmb3JlIHVucmVnaXN0
ZXJfYmxrZGV2Lg0KQnV0IEdyZWcgc3VnZ2VzdGVkIHRvIGNoYW5nZSBpdCB0aGlzIHdheSAtICJZ
b3UgbmVlZCB0byB1bnJlZ2lzdGVyIHlvdXIgYmxvY2sgZGV2aWNlIF9CRUZPUkVfIHRoZSBhdXgg
ZGV2aWNlIGdvZXMgYXdheSB1bmRlcm5lYXRoIGl0Ii4gSGVuY2UgZm9sbG93ZWQgdGhpcyBvcmRl
ci4NCg0KVGhhbmtzLA0KVGhhcnVuIEt1bWFyIFANCg==
