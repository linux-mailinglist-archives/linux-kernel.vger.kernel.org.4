Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45FBE5B970F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 11:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbiIOJLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 05:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbiIOJL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 05:11:27 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5596698744;
        Thu, 15 Sep 2022 02:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1663233086; x=1694769086;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QKhAK/7ZCqt5p91YzjCwITqIvp6KSWvp9ai+Lqm6aU4=;
  b=frLtpJLTMRQuiia0/yLYid2Q20UsIRpuT4ne9C4VPQwt3bIGesJtdIYa
   6faWkzQPsd/vU/5BrI6VcS3GbNbfPvWWnQDCqUWRz+37GprRgFtmTwfc4
   mEJHqnSGfGChvfvZIo9coEHIt1I7QD1D55e1vMLSwCOXsamTEBYiFZ3LV
   UgNgoGGC/g3DJ4nRhOvrvkfw0aanCvRR8C7x5rBUVhaqm/OWYlrptpoH5
   FiB4D3kQBnaRkgkUUYU/GxARBCHSFNp+aaeSKhryoOUyamJv5xOTZIhwN
   FDDirarkfyVGzVzlCpFpqGcJmgt4KwK6ZhgcYL0HK+8u4wSnCQnT82Tds
   w==;
X-IronPort-AV: E=Sophos;i="5.93,317,1654585200"; 
   d="scan'208";a="113799313"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Sep 2022 02:11:25 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 15 Sep 2022 02:11:25 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Thu, 15 Sep 2022 02:11:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KxCZovFtG7u2sb+mx/PU2R6I269iz32ucHXnZm26LlOyRmjIp7PqX2v+nJVcztYQ/mr6B2CuSfdk5SUV+w5ADfBX2y5dsIxyrf11LrjPpvwdZFmk9rgFtAhkFJJI6s7w4fDhrzo22i4euSAoQPLv7DRm5vHs7rgmk6oNuTGn/wqGmxXSX3jTjZEnO5H9n/NJN9g6YvLT74Xc3N3vpXGLxSiSDnwl/340PtTUh9qkJ14hcEGBI6zxaB78lYTefrMgIRsCA9gkrOswUndvmH2zkxCdFeUK5NqhNHdg/s6TeLSt0pL3AQwcIc1LV56BaBub7I9dMHV5joZ2xebNkcycfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ZQ2YvemN72OS2U2/I7DnfbR+ijcXUgLn0WG4b+ZGyU=;
 b=UbQiC1CL2TC5P42X4gePi+U7OCIbrTFeMTYWwoZ4S9hVvZEAXibwitXKZ/LOa4nKnvz5VGxFSwEl0qb/1vyAwaTYQVQb8MWLPidoNxK5oDtseYWBXvxz3rfbkxE2FQ2GME37SyxvZVOgGecA23QeaO28wGfSsWCm2QmyWvDqR9KvrSP/Ak0c9SzprXl8uWHg8SDFMlCtOATb99eVsyIotYuZilHLT1V/PFIrPolZhge6WPGnmrrPkczNq0L4MQB9LZWR1dQqflDJu1w1hThKZE+V9Y8NRC99tU+fEEO2IMkkynNNJpbADdBQFtY9vAbRfXA1V8FOR04bMQefRsnnbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ZQ2YvemN72OS2U2/I7DnfbR+ijcXUgLn0WG4b+ZGyU=;
 b=SkYa9beRwlBe7VcRcIjfPAA36DlU/H5JjCFcNBRDoSCeq+cki8Th36FwMx8DIbtnn2Zj9oNZTo3sgQ+c5O9QsRy04vUbzFCdSvlI4RIfypFn8QZtOsUbIMEkJ0kS/gnoVAGnym1MQArMsRo2tz76RfRcYBcZHO1Yl3/RViNraR8=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by SJ0PR11MB5199.namprd11.prod.outlook.com (2603:10b6:a03:2dd::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.15; Thu, 15 Sep
 2022 09:11:12 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::6982:4db0:989c:c097]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::6982:4db0:989c:c097%9]) with mapi id 15.20.5632.015; Thu, 15 Sep 2022
 09:11:11 +0000
From:   <Kavyasree.Kotagiri@microchip.com>
To:     <lee@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <Nicolas.Ferre@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <UNGLinuxDriver@microchip.com>, <Claudiu.Beznea@microchip.com>,
        <Sergiu.Moga@microchip.com>
Subject: RE: [RESEND PATCH v9 0/3] Add support for lan966x flexcom chip-select
 configuration
Thread-Topic: [RESEND PATCH v9 0/3] Add support for lan966x flexcom
 chip-select configuration
Thread-Index: AQHYw5Svwf7CKO45f0qSa2dMPruEEq3gPVOw
Date:   Thu, 15 Sep 2022 09:11:11 +0000
Message-ID: <SA2PR11MB48743F5E469DFBE4FAA4372992499@SA2PR11MB4874.namprd11.prod.outlook.com>
References: <20220908150658.1839520-1-kavyasree.kotagiri@microchip.com>
In-Reply-To: <20220908150658.1839520-1-kavyasree.kotagiri@microchip.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA2PR11MB4874:EE_|SJ0PR11MB5199:EE_
x-ms-office365-filtering-correlation-id: 1d207798-e4e8-46bc-aed1-08da96fa3bf2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HzrM7N6+E/YJqGiONHKfZn72djOr3fEP+pc4gFU4SDHARj8HvNHgQ11ygv6xfq60xtA8tfCmjXvKFSm0HFxJKpNY8xo2GkHMGX8J0DFmxsIsSM0EE6iNq/3ztQnDufju3jlKwYZtYUkTR0HwYGejkzrVNbSXGw5TsVdMLq6xy0bChKb65w1fw0IvJdfwIwkn5us3B/FmGPjjPZiybg/vHm4vxxTJaV4kUfFBff2Lz4bF+DxwDPKRBbrgwwqdv4aiZ74lKqSdIuKButPwaUDhPPrZ9DXkxNob60kOOFB91Ck5OM8olL2Bhup498ak1PgAydjpObb9CWCdZ2QKEbIkVKIJUxoscd9KTjJBpoljXrtcsFoCuyI8TUn6hXacxUBTXIiQsOb1jBNQ5HRO0Gs1RZX2MfV3nSrXe6oZTWku7y+rhKP8+qx9VHDqSCLkVfD9UwtGv3zbXzP2hVoPLRbwf+wEqFfjZ6Kr7d3wrOZ3nimtttoK3639mOluZXsgsEuh4dqN1CPa8gohL7Brwx1ZzZTd4aqIl8OQE8rTBldVtiP8V/OFnaQluhGY9erkxRjvSj9MtI9ldDUo0jLVjZaqAu+1RXSeZgIVwg4HV+kKQuYCFfS2OP1qsjsXAz91vH7/XJ8OU7aCO077sjOQfN38M7XBPHSZJHu3FzRJQB6MN12KDCi1nZ44ZU/tMZUHVMbz0ITG9RrjEZ8Se0SMmO70WPPWrpsIZwui3ME/plCgVl/11UgpLvbEzXPOptJLJDBiiunPu63p4OdjidJqn3GSUaU3sijGFw+Dkr55pa4hjlieMbGEjdf4SdoFvWjAffuIf7qxL2ZR6bdMFBLayMluHQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(346002)(39860400002)(396003)(366004)(451199015)(7696005)(52536014)(38100700002)(6506007)(41300700001)(107886003)(86362001)(66556008)(66476007)(66446008)(8936002)(76116006)(66946007)(64756008)(8676002)(186003)(83380400001)(122000001)(5660300002)(26005)(9686003)(55016003)(2906002)(38070700005)(4326008)(966005)(478600001)(71200400001)(33656002)(110136005)(54906003)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pUnJmCcpPVKeh+26EBlVNclBBA+/D1wQs5SpzFnp2HYmIj0Rf8ubRAjrQJYn?=
 =?us-ascii?Q?Gw0RFwKQSTyX34A1czgmnyihsFGGHMXybJdk9uEIDJ9qz31wD8z53GbW6pdE?=
 =?us-ascii?Q?XuajnHYg07dfMyTwoxbBW0Wq583OedZHu+lIIqncfwZfYZgjEgP65JjReKQG?=
 =?us-ascii?Q?VjGumidnseZlmg40B1mGlX8RlVh12Ujq6X15yejm3XWWAaQ5sbhV0NEho/ca?=
 =?us-ascii?Q?xfATIvrpDItPjb318AnVloj+mJp3r7I9Zuc3YL/lw4qMAiJ96sxf2JXSXWZV?=
 =?us-ascii?Q?jrby6XKQPecyehZowYfgaOXo57RR5ORpqs+ezhfqpAWIYej1ZeGI3mXlHQXi?=
 =?us-ascii?Q?nwMnBRS/0qHvdEhMCiSPQ4CX+pysaDCYRwyy51iAdLnlui+5FdfIy9U4k9S3?=
 =?us-ascii?Q?Tr72371HhlsKXINHr23wMXtH4erHn3JUxSj3U20f/ePEUor3SGeq97HN7sIK?=
 =?us-ascii?Q?CStsm1TlWgJEDkVGqXr19o8wotLaISIhEdbBuKyRjE+68Xz1rxasLDZpkQP9?=
 =?us-ascii?Q?/G5z5jei71mqCvdjKe1Wnpd6lYnKw99UHIz/BIH3wAw88EaDdjnycg9JyHKZ?=
 =?us-ascii?Q?uCnUlb7UdTNKd11ytznzg2wdRE7dk27BqZeLBHa6d7pzc38XYhS5i1ausBNO?=
 =?us-ascii?Q?Y2M8ArDbviUHhT2T4NRd9pPyaFkv6wYfZjJS2pkZ1jRkVMKHeb/ZcH6jI5xa?=
 =?us-ascii?Q?gkq3C/FRP4pf+8Vr9oAm53lMfXHyfaGEonKsZrc/LkhFOt456wscaDfrhKye?=
 =?us-ascii?Q?/TMqXbZkCpoc+pxUOZ3YgDozhsNJnN2El8a8YTafgWputoufFRvnqRvemkxk?=
 =?us-ascii?Q?VR9xv1C56w659Xt7Ycidw0uB8pGALM4vTYZ9WBxJAvjMsN5I1ND8lKpGOs4l?=
 =?us-ascii?Q?6wPaEydb/0K0uHRwuun2ItS38/iqNOWKXDQw7VWFj68ysCfhzK6lBxB+bYlC?=
 =?us-ascii?Q?HZ69gZHj98D7H0Wv4yRIjjhVT4SBbSBhvfedrhQ6k1Qyf2rKJkwbdNXsm26G?=
 =?us-ascii?Q?wdyzOqDpaLwQOon0rel80M9syUrT1MBGm2jxjFmEoQBqdraz+xXLlccfuvlW?=
 =?us-ascii?Q?nwCRx9XsoNQBlL7DgfLR3YrDptflztwnHFaVzffYGi+8hwcA6vwl/v+hvgX5?=
 =?us-ascii?Q?zvnUT8VndvHPRMjAt/hLDSL4chgUNDZNWrBmbmWY45dQBh5QARNUnlVSXUy4?=
 =?us-ascii?Q?LO+n9Ao0ig2zNASSzNg6QlR0kgCY4IjUHOFUgty4ydwg2Qhm6MMGgw8WaSt0?=
 =?us-ascii?Q?SeOnJYuSqYhM8zS2vLuvqad65/Y1RGhwRkCUbO2L1l+ikybgUHAVQfUqSftL?=
 =?us-ascii?Q?Mzc3Sl/xUw3ZF4hmttpeOYpxBCRVKbelrVGQTZVkgZTq2+YDrhbZnmWAOhYt?=
 =?us-ascii?Q?0TRdljOnu3xuUWRR6ccEf6RNZCWeGW0AdcoBl/8nrWWPfW6mGC8WoXfxkJot?=
 =?us-ascii?Q?Ys4n/92NKZ6mPpnOn//hu4JWAIePv6usHLKRNMdi06n2Hlhwvj6fNA7jNs+q?=
 =?us-ascii?Q?A43h1+Z3SB5G+aUysgBtdDFdoLCBkHIIVMUiukhkP020OPY8Djupwex3pYAJ?=
 =?us-ascii?Q?AIGx04AcPgOexCJIQrUp7FmE/vUhnOiGtpLuQ4i78mMnAD+k6apDKPTIwTMz?=
 =?us-ascii?Q?Xg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d207798-e4e8-46bc-aed1-08da96fa3bf2
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2022 09:11:11.7784
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jWVVFItBOldNXRO1P4zfeAZXHdE1+g+bfGAGw0zr7OTILJwVJkueK+Y5LUjIt41j2006HHb9mQcGSuqmn/v32QLdzpYFBAKvUedvXOq0qDy+J1D/h7trxq7cMqSF5DLa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5199
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> This patch series converts atmel-flexcom bindings into json-schema format=
.
> Adds support for lan966x flexcom chip-select configurations and its
> DT bindings.
>=20
> v8 -> v9:

Hi All,

Please ignore this v9 patch series. I just now found that it is conflicting=
 with https://lore.kernel.org/linux-arm-kernel/20220913142205.162399-6-serg=
iu.moga@microchip.com/
So, I will re-send my v8 patch series which is already reviewed by Rob Herr=
ing and claudiu.beznea

Thanks,
Kavya

>  - generated patches on linux-next v6.0.0-rc4 to resend.
>  - Changed reference provided for spi bindings to atmel,at91rm9200-spi.ya=
ml
>=20
> v7 -> v8:
>  - Added back patternProperties for child nodes.
>  - Changed compatible string to microchip,lan9668-flexcom.
>=20
> v6 -> v7:
>  - Change filename to atmel,sama5d2-flexcom.yaml
>  - Add #address-cells, #size-cells to flexcom node - Fixed warnings.
>=20
> v5 -> v6:
>  - Removed spi node from example as suggested by Rob and
>    also pattern properties(spi dt-bindings conversion to yaml patch is un=
der
> review).
>    https://patchwork.kernel.org/project/linux-arm-
> kernel/patch/20220629125804.137099-1-sergiu.moga@microchip.com/
>    Once this is accepted, I will add back spi example through new patch.
>=20
> v4 -> v5:
>  - Fix indentations of DT example.
>  - Fix dt-schema errors - removed minItems, maxItems for allOf:if:then
>    "reg" property as it is not required.
>=20
> v3 -> v4:
>  - Fix dtschema errors.
>  - Add a condition to flexcom chip-selects configuration as chip-select
>    lines are optional.
>=20
> v2 -> v3:
>  - changed IRQ flag in dt-bindings example.
>  - added reg property specific to lan66x which is missed in v2.
>  - used goto label for clk_disable in error cases.
>=20
> v1 -> v2:
>  - minor fix in title of dt-bindings.
>  - Modified new dt properties usage in atmel,flexcom.yaml.
>  - Used GENMASK and macros for maximum allowed values.
>  - Use u32 values for flexcom chipselects instead of strings.
>  - disable clock in case of errors.
>=20
> Kavyasree Kotagiri (3):
>   dt-bindings: mfd: Convert atmel-flexcom to json-schema
>   dt-bindings: mfd: atmel,sama5d2-flexcom: Add new compatible string for
>     lan966x
>   mfd: atmel-flexcom: Add support for lan966x flexcom chip-select
>     configuration
>=20
>  .../bindings/mfd/atmel,sama5d2-flexcom.yaml   | 154 ++++++++++++++++++
>  .../devicetree/bindings/mfd/atmel-flexcom.txt |  63 -------
>  drivers/mfd/atmel-flexcom.c                   |  94 ++++++++++-
>  3 files changed, 247 insertions(+), 64 deletions(-)
>  create mode 100644
> Documentation/devicetree/bindings/mfd/atmel,sama5d2-flexcom.yaml
>  delete mode 100644 Documentation/devicetree/bindings/mfd/atmel-
> flexcom.txt
>=20
> --
> 2.25.1

