Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 174896FB257
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 16:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234480AbjEHOM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 10:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233971AbjEHOM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 10:12:56 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2055.outbound.protection.outlook.com [40.107.94.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEC86658B;
        Mon,  8 May 2023 07:12:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pn/JTuC2GOqLsWiVD/K9xvHvSGo5G1yZqU5EimUBfoql4IlmGCbiI2RDxswQktA5G8ppipbdJfgQl0/DdmXUWlQBaULsdVmUDCbgEwvZNXahAAbm1mwOYUpvYhaLCPU1eFRkjYSZUM1IbBSz4O/2NolB8GBRC+z1VyIUBRif0UbejMwvzfO9bBRBxZAQEXjAoVeVroUIAtWDOxrwugn8rQmaomyOqFCkGAqQQsnaFa7iV4lhMxe6kDQWwRG2UIksGNjMjMqy4bPi37axwCX4JgW6jojRGe0hnAM9Dj1l/6ymiWcGzMCFCw/58KkJPPvoRk/BMOSA4bZ73abnQHl24w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yvdVcix3EKZL02iyqz8QSv4I/kKlndFiHlbx7gI1fdo=;
 b=VyGQSjP/xxUq1WhgehLI7rZyxKbtEHKI4mK7giJdiu02wH8JYNUrTv1qhjnt5svTzwQBMssB26XyzOioKN6wISuoze7GfmjPhqGGsgINl96x4hWNE9M/7cyy+I2CdHkiUiPxsk0vkEwlBvGtAik6DazVKiuZQ29Q0Tsgx4ZfE6NvSTFDN3UNgCRzW7lL2M4INdv5Qh++Sx37YSr2PQaWIX1FeL+SiRftjV9vJK1PWsf+nWVVtiNPAJ1xpvcU2mah4tR5LaJWF0hqnphKqIbXnxztvpz14gO4BxJfznqDVdvnjAWTV6YKTR8nYydvy1aSublalHo0E1xjbfl0oA8WJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yvdVcix3EKZL02iyqz8QSv4I/kKlndFiHlbx7gI1fdo=;
 b=MhMx1VyfwzgJbjFCRnCdflEda8UtIwJb0LK5kmXp5xFN4h/sfmzP05j3jMf+l9Otow9plhxVRtaOeuISot2S/WlHk5pjofPBP+eUqkMevBMRxFsvMrCWjoe/yfKH5gWKzneih/vP62sYeRqN7uZeX9BqLM2asB5t8MsPzoMoDRe/aGluXy1C2yOsuqZfB8vfQMUhQ03bJwSjT0D2Og6WAZr3myeZiB0lg+IhSDZ4lNQ45q4TULJQ5hPFm+eyg1LrsGt9OpVqATnOZu88lYWVxljkEliNp3kVHYoOV3JD6Z5pZKHKRb5WlwHYsackCHKTsNS8QNDEsUJI0zRzB8TDaw==
Received: from MW3PR12MB4346.namprd12.prod.outlook.com (2603:10b6:303:58::20)
 by MW6PR12MB8868.namprd12.prod.outlook.com (2603:10b6:303:242::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Mon, 8 May
 2023 14:12:49 +0000
Received: from MW3PR12MB4346.namprd12.prod.outlook.com
 ([fe80::42f0:9bed:2b:32e8]) by MW3PR12MB4346.namprd12.prod.outlook.com
 ([fe80::42f0:9bed:2b:32e8%4]) with mapi id 15.20.6363.032; Mon, 8 May 2023
 14:12:49 +0000
From:   Peter De Schrijver <pdeschrijver@nvidia.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stefan Kristiansson <stefank@nvidia.com>
Subject: Re: [PATCH 4/5] dt-bindings: Add bindings to support DRAM MRQ GSCs
Thread-Topic: [PATCH 4/5] dt-bindings: Add bindings to support DRAM MRQ GSCs
Thread-Index: AQHZgah4ktUTN2aU+EKhTdV7EHkSYK9QaM8AgAAAstQ=
Date:   Mon, 8 May 2023 14:12:49 +0000
Message-ID: <MW3PR12MB4346ED32BBE6EAA7CB8C91A8B1719@MW3PR12MB4346.namprd12.prod.outlook.com>
References: <20230508122048.99953-1-pdeschrijver@nvidia.com>
 <20230508122048.99953-5-pdeschrijver@nvidia.com>
 <43945fad-f57b-cfd9-78bd-9ec9e6628382@linaro.org>
In-Reply-To: <43945fad-f57b-cfd9-78bd-9ec9e6628382@linaro.org>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR12MB4346:EE_|MW6PR12MB8868:EE_
x-ms-office365-filtering-correlation-id: 7e471ca5-a949-4494-59d1-08db4fce4e38
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: J7F1TtdRFvw8aeK4r5v3b46Thlu0hmPf77hAzVG/aj4dskta9Dm7CCV5RE7U5pAbj3G8XDq/eHsNOPM/Kah1eeP4i9n50ohZhBMfiQV1RftYhAIebRMCGJ04pIq8J1NPNWLxVpQITSGeEhSfV51ussQLY2wjeD6UfziWS71r0f0LTIeZu7eWMBFiWPJdbcSIHMgFkw5VIYmTImcu4pX99+x1hEaWXOx1Os1wNYjnge9jf7uB1UQbLqoupI6raq/vgPWZK0SNqJZxwtSW3FlbZCOD6LEUDvUiQpTh0LC7VMQ6tq1fokI70o45aJKarBoVmn6ccfRt7VDyTte2DDd1gi+LX0HiNmKAZy+riW1T8MaOpRU6vUAc3A7SkWa1trcqqyIEvKD3oo5cDG4thYQI5WhXJEeTzeu5s3H1iuASml+oTr60jPPDdkoJ8Iag6liazxuqCBLG7hWWgJVI1Csfmgq5TtN8ig5zqGxVKRUr6un/TD1ditfBkReOm5ewbSe8Q6H/UyZ7AyhRJpck3iXYoM9Pp+7WiwSN7+dKc2akvHzFBXpFJ0ektlBSm9z/tLniENB1bX6JidcADj5kan66uYmPWWTQdySy9Wp30itlqo3p/UptfMib7dJFLEZEGxv6XutOZlwUmKAd4gkUjrO3XC3aiRl2Iz52S4MXGdOwIuDW6idU6N38zvWkowwesdYi
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4346.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(396003)(346002)(376002)(136003)(451199021)(53546011)(9686003)(26005)(6506007)(107886003)(7696005)(966005)(83380400001)(55016003)(38100700002)(33656002)(122000001)(86362001)(38070700005)(186003)(110136005)(41300700001)(2906002)(54906003)(5660300002)(6636002)(4326008)(64756008)(66476007)(66446008)(66556008)(316002)(8936002)(8676002)(478600001)(91956017)(52536014)(76116006)(66946007)(71200400001)(586874003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?i5zMRey/er4A8z/+WrNWxxIPSOi+r0KNoH4igOJLRN3xNPRa/RKyAIyr2F?=
 =?iso-8859-1?Q?/Sl0SWWFtnBUntWO7Ehd/lhgKYXqg8lQ3mnXlxDyCR2A8s95nkUuOit93T?=
 =?iso-8859-1?Q?UnqsrpbZCYAvOLGhMbcO7MiZGepv4h65kOFoGUIYm5VcJXMxW4y5cvYJzN?=
 =?iso-8859-1?Q?S3s4JwY1SRX6GU9vz0qoP8YosIf862DNdTZ8SUGbpM634zvd3MDDio33pl?=
 =?iso-8859-1?Q?Pm2nizjMMH4iYKEP2mGWEtCGvUoeo657A2VYUq0lnpUSkbMN92f4ciO7Bs?=
 =?iso-8859-1?Q?0bSE6gqm4z3RYAtj5xY31y5yLsUYjSzqRX74MVWrLTDRSovRbGmzbJY5+8?=
 =?iso-8859-1?Q?uJ7eCCtMnDqJYDrM3aWPZbUeEoirDQBgkS/DJkCQdDpc1v4wMbcqPI+WqB?=
 =?iso-8859-1?Q?rq/C0dum1e5KaEAiWROhl9szKTIYiK8kF+Q+nOGkePn+MQGY0/s38PSWf6?=
 =?iso-8859-1?Q?WNDltQhXrRjCnYcCCGz+SyTxoHKPAuWeCk7xmuvkqoniBHsqMGt0F3Vfwb?=
 =?iso-8859-1?Q?+8PnJ1sUZsHQA8d5Wl5JmwlzPQb117Ijv0Dedrlc8INO3ZAisuO61RLBDZ?=
 =?iso-8859-1?Q?emOklrL8e0Zp5KtqQ3TJiYhizuk0mUv2R3cvNy0srQeCWfyn697Vc3b//U?=
 =?iso-8859-1?Q?FxGF5R3O4Y4P8Mfv02z5WlnYf65WLovT0SSObn19ROJ8eUsTXk2mjxnyVM?=
 =?iso-8859-1?Q?iRSfi881XD69+dSQ5W+XfLQ+T6fhD6JaewEuvsil1A63CfAXVXa5rIyAK6?=
 =?iso-8859-1?Q?kFf5DrWpyaJ6qqzAbMO34cIH3ROhrUcOHzRNT7n3mMV61iT/VH03G3GPBI?=
 =?iso-8859-1?Q?GJdUtIKFlB9NKBKU+LYtTdP8UTpA7vgVK25gkBj37xHItpHOakWILCHZ03?=
 =?iso-8859-1?Q?gbY81MI2jZWFpsdEkAzQESRqzNSGRWoXXTlwu014irS1KesIQW6Yvm0HiV?=
 =?iso-8859-1?Q?lw0w7tlGttsd3s9Sg8FlQrXuXa9Y3yjTMLC50S09W5hzoTnjHVL3U0+CdZ?=
 =?iso-8859-1?Q?luNnel+XBO+FgByQo6M7ACnlQy/V8I+z+/VB1hARlfcBbVoaAut8UxBsc7?=
 =?iso-8859-1?Q?iG6r2Z940o2xk0/gmAAuRJ95Nmu//TGWH04+e4peddqg42wEg68zz1MEjl?=
 =?iso-8859-1?Q?dFU4hQD/j8KzebyLnFM4FE2OL8TzCq/m/sqxLD/p+0dDC/8w235tZQz+j2?=
 =?iso-8859-1?Q?qUhdIpm/QeIWWb8Sooije+kEAVvqqgamFg7OSzir9zrbIpEoyHFX6bNkVq?=
 =?iso-8859-1?Q?rGa8uP3otdTpmB2pjobZzGHnDgevuARHQbxbWE0+MwOBV12xtWl3o/8jln?=
 =?iso-8859-1?Q?DwsdP6EbmSOtBBnFKHlUFffrvcYDCgt7ZxRkGg8dGPp0VMiM496eASyW+/?=
 =?iso-8859-1?Q?YTdgDHGeqtvMzgSUJMONr5MF/plAiR6X39n565vceFd91a6GDE1lNYiBcR?=
 =?iso-8859-1?Q?eWYATJLWSWAt8toBFpJ04gVeRyOsTURp7igWOqbudpQsX88CgZP06anWvW?=
 =?iso-8859-1?Q?IbK7/idYGfS0en+H92fTqhO3YlKbtPYa9qOflqRhg+qSxW6wLP9sxuajDx?=
 =?iso-8859-1?Q?LLPdtZdtk5o5Q8cIkCkRuoY6k+RNfsQK1lIdevKHYIPkpaVju+1bPnY8kw?=
 =?iso-8859-1?Q?Iir8akgfWuUpv6yAakjCZaemI4eSQdXF22?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4346.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e471ca5-a949-4494-59d1-08db4fce4e38
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2023 14:12:49.7188
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qcAhe8gKshjSJ3AvSIFllP/LGMRVoFfn5wKjZkhaYSyrM7VLrIamVwddPZIGpm24IvTweZuZniwpW9BXY5dpqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8868
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=0A=
=0A=
________________________________________=0A=
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>=0A=
Sent: 08 May 2023 17:04=0A=
To: Peter De Schrijver; thierry.reding@gmail.com; Jonathan Hunter=0A=
Cc: robh+dt@kernel.org; krzysztof.kozlowski+dt@linaro.org; conor+dt@kernel.=
org; devicetree@vger.kernel.org; linux-tegra@vger.kernel.org; linux-kernel@=
vger.kernel.org; Stefan Kristiansson=0A=
Subject: Re: [PATCH 4/5] dt-bindings: Add bindings to support DRAM MRQ GSCs=
=0A=
=0A=
On 08/05/2023 14:20, Peter De Schrijver wrote:=0A=
> Add bindings for DRAM MRQ GSC support.=0A=
>=0A=
> Co-developed-by: Stefan Kristiansson <stefank@nvidia.com>=0A=
> Signed-off-by: Stefan Kristiansson <stefank@nvidia.com>=0A=
> Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>=0A=
> ---=0A=
>  .../firmware/nvidia,tegra186-bpmp.yaml        | 69 ++++++++++++++++++-=
=0A=
>  .../nvidia,tegra264-bpmp-shmem.yaml           | 40 +++++++++++=0A=
=0A=
> Why touching two files?=0A=
=0A=
Because both are needed to support having MRQ GSCs in DRAM.=0A=
=0A=
>  2 files changed, 106 insertions(+), 3 deletions(-)=0A=
>  create mode 100644 Documentation/devicetree/bindings/reserved-memory/nvi=
dia,tegra264-bpmp-shmem.yaml=0A=
>=0A=
> diff --git a/Documentation/devicetree/bindings/firmware/nvidia,tegra186-b=
pmp.yaml b/Documentation/devicetree/bindings/firmware/nvidia,tegra186-bpmp.=
yaml=0A=
> index 833c07f1685c..d818cfe1d783 100644=0A=
> --- a/Documentation/devicetree/bindings/firmware/nvidia,tegra186-bpmp.yam=
l=0A=
> +++ b/Documentation/devicetree/bindings/firmware/nvidia,tegra186-bpmp.yam=
l=0A=
> @@ -57,8 +57,11 @@ description: |=0A=
>    "#address-cells" or "#size-cells" property.=0A=
>=0A=
>    The shared memory area for the IPC TX and RX between CPU and BPMP are=
=0A=
> -  predefined and work on top of sysram, which is an SRAM inside the=0A=
> -  chip. See ".../sram/sram.yaml" for the bindings.=0A=
> +  predefined and work on top of either sysram, which is an SRAM inside t=
he=0A=
> +  chip, or in normal SDRAM.=0A=
> +  See ".../sram/sram.yaml" for the bindings for the SRAM case.=0A=
> +  See "../reserved-memory/nvidia,tegra264-bpmp-shmem.yaml" for bindings =
for=0A=
> +  the SDRAM case.=0A=
>=0A=
>  properties:=0A=
>    compatible:=0A=
> @@ -81,6 +84,11 @@ properties:=0A=
>      minItems: 2=0A=
>      maxItems: 2=0A=
>=0A=
> +  memory-region:=0A=
> +    description: phandle to reserved memory region used for IPC between=
=0A=
> +      CPU-NS and BPMP.=0A=
> +    maxItems: 1=0A=
> +=0A=
>    "#clock-cells":=0A=
>      const: 1=0A=
>=0A=
> @@ -115,10 +123,16 @@ properties:=0A=
>=0A=
>  additionalProperties: false=0A=
>=0A=
> +allOf:=0A=
> +  - oneOf:=0A=
=0A=
Keep just oneOf and drop allOf.=0A=
=0A=
> +      - required:=0A=
> +          - memory-region=0A=
> +      - required:=0A=
> +          - shmem=0A=
> +=0A=
>  required:=0A=
>    - compatible=0A=
>    - mboxes=0A=
> -  - shmem=0A=
>    - "#clock-cells"=0A=
>    - "#power-domain-cells"=0A=
>    - "#reset-cells"=0A=
> @@ -184,3 +198,52 @@ examples:=0A=
>              #thermal-sensor-cells =3D <1>;=0A=
>          };=0A=
>      };=0A=
> +=0A=
> +  - |=0A=
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>=0A=
> +    #include <dt-bindings/mailbox/tegra186-hsp.h>=0A=
> +    #include <dt-bindings/memory/tegra186-mc.h>=0A=
> +=0A=
> +    hsp_top0: hsp@3c00000 {=0A=
> +        compatible =3D "nvidia,tegra186-hsp";=0A=
> +        reg =3D <0x03c00000 0xa0000>;=0A=
> +        interrupts =3D <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>;=0A=
> +        interrupt-names =3D "doorbell";=0A=
> +        #mbox-cells =3D <2>;=0A=
=0A=
> Why HSP example is here?=0A=
=0A=
Because it's referred to further down the example.=0A=
=0A=
> +    };=0A=
> +=0A=
> +    reserved-memory {=0A=
> +        dram_cpu_bpmp_mail: shmem@f1be0000  {=0A=
> +            compatible =3D "nvidia,tegra264-bpmp-shmem";=0A=
> +            reg =3D <0x0 0xf1be0000 0x0 0x2000>;=0A=
> +            no-map;=0A=
> +        };=0A=
> +    };=0A=
=0A=
Drop, fairly obvious and should be in that binding, not here.=0A=
=0A=
> +=0A=
> +    bpmp {=0A=
> +        compatible =3D "nvidia,tegra186-bpmp";=0A=
> +        interconnects =3D <&mc TEGRA186_MEMORY_CLIENT_BPMPR &emc>,=0A=
> +                        <&mc TEGRA186_MEMORY_CLIENT_BPMPW &emc>,=0A=
> +                        <&mc TEGRA186_MEMORY_CLIENT_BPMPDMAR &emc>,=0A=
> +                        <&mc TEGRA186_MEMORY_CLIENT_BPMPDMAW &emc>;=0A=
> +        interconnect-names =3D "read", "write", "dma-mem", "dma-write";=
=0A=
> +        iommus =3D <&smmu TEGRA186_SID_BPMP>;=0A=
> +        mboxes =3D <&hsp_top0 TEGRA_HSP_MBOX_TYPE_DB=0A=
=0A=
^^^ refers to hsp_top0.=0A=
=0A=
> +                            TEGRA_HSP_DB_MASTER_BPMP>;=0A=
> +        memory-region =3D <&dram_cpu_bpmp_mail>;=0A=
> +        #clock-cells =3D <1>;=0A=
> +        #power-domain-cells =3D <1>;=0A=
> +        #reset-cells =3D <1>;=0A=
> +=0A=
> +        i2c {=0A=
> +            compatible =3D "nvidia,tegra186-bpmp-i2c";=0A=
> +            nvidia,bpmp-bus-id =3D <5>;=0A=
> +            #address-cells =3D <1>;=0A=
> +            #size-cells =3D <0>;=0A=
> +        };=0A=
> +=0A=
> +        thermal {=0A=
> +            compatible =3D "nvidia,tegra186-bpmp-thermal";=0A=
> +            #thermal-sensor-cells =3D <1>;=0A=
> +        };=0A=
> +    };=0A=
> diff --git a/Documentation/devicetree/bindings/reserved-memory/nvidia,teg=
ra264-bpmp-shmem.yaml b/Documentation/devicetree/bindings/reserved-memory/n=
vidia,tegra264-bpmp-shmem.yaml=0A=
> new file mode 100644=0A=
> index 000000000000..6cd9a61cd31f=0A=
> --- /dev/null=0A=
> +++ b/Documentation/devicetree/bindings/reserved-memory/nvidia,tegra264-b=
pmp-shmem.yaml=0A=
> @@ -0,0 +1,40 @@=0A=
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)=0A=
> +%YAML 1.2=0A=
> +---=0A=
> +$id: http://devicetree.org/schemas/reserved-memory/nvidia,tegra264-bpmp-=
shmem.yaml#=0A=
> +$schema: http://devicetree.org/meta-schemas/core.yaml#=0A=
> +=0A=
> +title: Tegra CPU-NS - BPMP IPC reserved memory binding=0A=
=0A=
Drop "binding"=0A=
=0A=
> +=0A=
> +maintainers:=0A=
> + - Peter De Schrijver <pdeschrijver@nvidia.com>=0A=
> +=0A=
> +description: |=0A=
> +  Define a memory region used for communication between CPU-NS and BPMP.=
=0A=
> +  Typically this node is created by the bootloader as the physical addre=
ss=0A=
> +  has to be known to both CPU-NS and BPMP for correct IPC operation.=0A=
> +  The memory region is defined using a child node under /reserved-memory=
.=0A=
> +  The sub-node is named shmem@<address>.=0A=
> +=0A=
=0A=
> Open other files there and implement it similar way. I really wonder why=
=0A=
> this should be done differently than for example other nvidia stuff -=0A=
> without reserved-memory schema?=0A=
=0A=
Because up to now, the GSC was kept in sysram which is considered to be a d=
evice by the kernel. Now part of the DRAM will be reserved for this, so the=
 kernel needs to know about it.=0A=
=0A=
> +properties:=0A=
> +  compatible:=0A=
> +    const: nvidia,tegra264-bpmp-shmem=0A=
> +=0A=
> +  reg:=0A=
> +    description: The physical address and size of the shared SDRAM regio=
n=0A=
> +=0A=
> +required:=0A=
> +  - compatible=0A=
> +  - reg=0A=
> +  - no-map=0A=
> +=0A=
=0A=
Does not look like you tested the bindings. Please run `make=0A=
dt_binding_check` (see=0A=
Documentation/devicetree/bindings/writing-schema.rst for instructions).=0A=
=0A=
> +examples:=0A=
> +  - |=0A=
> +    reserved-memory {=0A=
> +       dram_cpu_bpmp_mail: shmem@f1be0000  {=0A=
> +           compatible =3D "nvidia,tegra264-bpmp-shmem";=0A=
> +           reg =3D <0x0 0xf1be0000 0x0 0x2000>;=0A=
> +           no-map;=0A=
> +       };=0A=
> +    };=0A=
> +...=0A=
=0A=
Best regards,=0A=
Krzysztof=0A=
=0A=
