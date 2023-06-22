Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EFAD73A8DE
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 21:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbjFVTRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 15:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbjFVTRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 15:17:08 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A497EEA;
        Thu, 22 Jun 2023 12:17:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jvg82bjTkp24Liz4soZrROSGhgf70UxiK01jMlhv/ZSqOWUhZsaivWEGxvEUPt80L7b971IS+LlyfQI6VYVODA1OOPJsjIQmhXOXrLw6p4ECqAy9QfPF7oqyniVZ7WxgoCzfjKbSDpvE7D+QLjjpA+rDVNjA9eU84nbdoXiKSTFggMRXj85qdG5KhLAqZs1e44N1Q2GjuU3evX64XRtbngeYYcptplzYEU1a4zEK6R7ssOFKIY/f98DK+ZDwtdD248IWQWP6aMmiefQGS7YFPs0XnBcCQNfmXtainlCWAgnuEyhINKwegWo8ifZ+m8XCGcUJTAz/cgOqZtajIV/8ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hLjaAV6+7PyVsLj8c7zw3upmoOPC2jQMtDNatdCDsjI=;
 b=Xx7iCptY5y28fLECEldKlsRkqKbTuurmNWBVTtuat/eCsemn8VatTRsn2pHrA3sCkjRQy4sLkBQ7dtu9Ey71c2/02XHqsaexFVG4tO/7wKeh+uxa8kmx9NDhocLB4gfKcp9CNLOyIN8yb99A8BzP/85CrhVPxx463+evSfZZ6jfFUa/5RlqA7+JO/oj+UmaUNlQqiIQFi0neHvQ96U23K7GyHSHZlfNepjhidPmOnpY9pGlq+mmuWyxPQtdM91XrimR+wnZ4pwc3R3mhQOkHtKXacx99gFJB58rmKjwDXaGap7+rmW0J44OIO+ZGx+VKgM01dzWTEd0Sc6bdjjSmdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hLjaAV6+7PyVsLj8c7zw3upmoOPC2jQMtDNatdCDsjI=;
 b=3CE0ElbB22erLh6DyGXh1xEqMqGYfPRFWH0QuktVUbZprxwpjsWvEV3d1F4LJyxy9mRdYwItTMLC1EreqN6nGHX/52CEjnLFAnqGdOyIl5quAJZKO2idn5SoN1ZqeEYiSUUbFsyNyHO1o08LLox+hurLligLbbIbBv+kYVWelvY=
Received: from MN0PR12MB5953.namprd12.prod.outlook.com (2603:10b6:208:37c::15)
 by MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 22 Jun
 2023 19:17:02 +0000
Received: from MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::8368:23:db50:8f88]) by MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::8368:23:db50:8f88%5]) with mapi id 15.20.6521.020; Thu, 22 Jun 2023
 19:17:02 +0000
From:   "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
To:     Rob Herring <robh@kernel.org>
CC:     "andersson@kernel.org" <andersson@kernel.org>,
        "mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "Simek, Michal" <michal.simek@amd.com>,
        "Levinsky, Ben" <ben.levinsky@amd.com>,
        "Shah, Tanmay" <tanmay.shah@amd.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "git (AMD-Xilinx)" <git@amd.com>
Subject: RE: [PATCH] dt-bindings: remoteproc: add Tightly Coupled Memory (TCM)
 bindings
Thread-Topic: [PATCH] dt-bindings: remoteproc: add Tightly Coupled Memory
 (TCM) bindings
Thread-Index: AQHZoE8KBE6u3kfKBUagIUdcnS3pjK+T8cGAgANH7NA=
Date:   Thu, 22 Jun 2023 19:17:02 +0000
Message-ID: <MN0PR12MB5953AC6EB4375BA16D3D9785B722A@MN0PR12MB5953.namprd12.prod.outlook.com>
References: <1686918865-2330677-1-git-send-email-radhey.shyam.pandey@amd.com>
 <20230620170351.GA3815971-robh@kernel.org>
In-Reply-To: <20230620170351.GA3815971-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB5953:EE_|MN2PR12MB4488:EE_
x-ms-office365-filtering-correlation-id: 56dc5bb2-185b-4db6-f0d3-08db73554266
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: t7C71G/kaZatObsLB6RqY/g4fY3O6K8+UWku6eW9pHR6Ve6FwOVOrFYfz/bht0s5JXcVF/smTAAW8YAbV1TPD0JF3ozUROfl+KpbyBzgNVeRnbKbmh0CRc+yKtuMYsKKOLVZE3fYz5hkg/ml6slXUf6CTp+MzGE2Cnx18/De7GB/vDz4ujNypIS2FDk9gvKmL7F/ov6tLOmFvbWeGeDh7ap8E2wv/nTrzNosk9+X8scPsPCL/u6FLMgtH8xa2wu1hnUJz9YaFk5n20t4WBQQn8g01D5SRDr0qpr+9oZeEyGJ2n8fp9XUfScSL1agTGHBurMMJUh3qyLmZ96Qu79AJ4nFlm+dDxwzt7M7XhwkV+hmQPrumvJuuNxopHjLBrpoFAIofF2JDkurnvMgfiZzK58TeGMNwIr1JwmFs+u7DiVaPKCqJIeSKP2Px3iWZN7/xmO0k50lYaMDbeOGe9cQ0W7uyxBR/Hva/D//ITFzWQjvjGhilylM1TqTaGunc3SnzLA+8FQ6PuEWoZUgB8G2Bkvzenwggf3YEojYWv+tOkuYYt/V3710i8tV1pSCsep7qt4RcXUGSr2IP0RE4Al7bxHROf1mKz5k5m/WsqaSX9ELAOnUpU20fzS5KV2w2SO1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5953.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(366004)(376002)(39860400002)(346002)(451199021)(38070700005)(122000001)(38100700002)(55016003)(86362001)(316002)(66446008)(64756008)(66556008)(66476007)(6916009)(8676002)(41300700001)(8936002)(66946007)(4326008)(76116006)(33656002)(7416002)(5660300002)(6506007)(7696005)(53546011)(52536014)(71200400001)(478600001)(54906003)(83380400001)(9686003)(186003)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?236lDRSbO7VteP2IpyL6lnQt4L3EgUKRMJhFBR6iUmWJSqYjdgdXnveVmO17?=
 =?us-ascii?Q?QSW9FaIqDCxlkwWYmkuPrWmvS2Nj3fZsfK7t63lyYZkxDlYpSJ6fc5Wf1BOD?=
 =?us-ascii?Q?fJQZujpd29lzYtBXRqe9VZqrnPOCG/d752iy37+hmDAVin1G+dSlvD2htN4s?=
 =?us-ascii?Q?qkQBH6QnhPCEdOPLWAUSJZ2Dcn6IxljG8bU2JC8RPoujd72FVR9NwfusxZJ5?=
 =?us-ascii?Q?leafswjT2DV6+edY9d7jxEa4PZr20xk0tTOZjF2yBdUjl5E3xjGXR7HqGrs0?=
 =?us-ascii?Q?HPWnQ2hiehQ2tMXs6MydLX0vJZursV6+AC/gZxVs4D0NPcJhmzPy2+5uj8iO?=
 =?us-ascii?Q?RfS0ry+D58eveaAmMtC1mvVDz/1oKuQpxq7qwFVSURP5tky+WVgbJfx14KEJ?=
 =?us-ascii?Q?CJPFeHTH3xlvbZZ/PlI/SyvRbHf87beU+bXLI0//7qaFp7bOFjaA0gGxVgjJ?=
 =?us-ascii?Q?hNHXwAKJMzFH074zLbnWzxzyqaltYZR9xJZr2SI4FjE4A8YID0gLD1cYpw5D?=
 =?us-ascii?Q?/2blQFOECgRyDi3p1fXiw4u3fYbEe/EcVJf15XRWQJDYWOwTzrjzj/Ix7BfG?=
 =?us-ascii?Q?yUkZ5JzWiuiYNDzH4hWaRxMyHBAeeIny6PxJ196cVKPe07Zh5lmZEGVdY5xT?=
 =?us-ascii?Q?znLJ8jswbWxKfiTMsvIbJDxDhsyngRP0ujK85OLFc/VIgPVLnfMeLV4fk1Gc?=
 =?us-ascii?Q?4f+iwNw4PvcplOmobMgD8b41ZJCr58dD2zQd/506fn+G6DaRAukJVmVl2e7X?=
 =?us-ascii?Q?N5OnoclOavZ6uxG25vdS0acphQixQ2Rrs81INMiO0Xwdg1r222hxbBiBSLA9?=
 =?us-ascii?Q?xxJMpIGpSZR2EQ34nQ9SHjhYYAdYgElt8z/7QxFZzDuNe1uYkgI8IGuyOMFC?=
 =?us-ascii?Q?ov3SJWu7/PRLPgB4FbYgf1FxDJOTM0QYNpsNhdESLbPp80iaXDKMF1fH0ic/?=
 =?us-ascii?Q?+C42CuRR1H6QraX3S6pxVvEKJmJRgPs38T+LjIch2AoeWt25lwG/A2tDhtMc?=
 =?us-ascii?Q?JUNifTeqBMr3c3P+16MP+gofwfdSf0Wo2xvk/i1Jkeqw0u3s6HgImvLhDFkb?=
 =?us-ascii?Q?WZiMLxs9sLhv3Dmq4lSCyHMaBP41OdPt8uzNSSjA5igJdfgf1GG+ua+ea8fu?=
 =?us-ascii?Q?+YUsykCErcGO5rVaEtn0d4rF6SF3iOGcHVlq+q8wCPvZBaPEVlFKPEjkd7cB?=
 =?us-ascii?Q?2jeydxZl64udyZHw5l3y1Xoc8J8CjU+ABPqYZ5McdQAPr+kIh/Uye+EMY9WP?=
 =?us-ascii?Q?K+0ytSQHhUpxnR7ilRvn/jiLajj6Sah03EEn3gPm+OZ1WHhmsvPZ4NlqRx40?=
 =?us-ascii?Q?2DRXKgDh4j1xw1/L2HNjbp+BTASvd3MDzwuUu5bFz7RHuRmGz0SraFvnMmxk?=
 =?us-ascii?Q?vcBwja/xMRGMLeIYGz9d3mp6UMb4whkjICaHUdTg5Qhs0IsOwXejOVFmY9kk?=
 =?us-ascii?Q?in0OpXGqPaJyWffyu7m2fMrLpw7CYlSsNR+NepbfZR/2waeJmvhGIGivgv74?=
 =?us-ascii?Q?D0c8OvmCrQjf8WbOWgK/l+IVfvevpSNkq3j/TR4BLfbcFLpDtR1nryWFl0Ch?=
 =?us-ascii?Q?MPgj43vTjQo1/MZny3bcNtJXqaFfBo3yv9UOB4Rp7rR23WIAsaU63tTNGGas?=
 =?us-ascii?Q?h2XRc6JQmf1Q0vCejLsi2cI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5953.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56dc5bb2-185b-4db6-f0d3-08db73554266
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2023 19:17:02.6449
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qjvA2Ds5otSIDLv0IqbOyW4zcJL0h5oE34xEny48uRSVbDMi/JXEqv2Q65VyieXx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4488
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: Tuesday, June 20, 2023 10:34 PM
> To: Pandey, Radhey Shyam <radhey.shyam.pandey@amd.com>
> Cc: andersson@kernel.org; mathieu.poirier@linaro.org;
> krzysztof.kozlowski+dt@linaro.org; conor+dt@kernel.org; Simek, Michal
> <michal.simek@amd.com>; Levinsky, Ben <ben.levinsky@amd.com>; Shah,
> Tanmay <tanmay.shah@amd.com>; linux-remoteproc@vger.kernel.org;
> devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> kernel@vger.kernel.org; git (AMD-Xilinx) <git@amd.com>
> Subject: Re: [PATCH] dt-bindings: remoteproc: add Tightly Coupled Memory
> (TCM) bindings
>=20
> On Fri, Jun 16, 2023 at 06:04:25PM +0530, Radhey Shyam Pandey wrote:
> > Introduce bindings for TCM memory address space on AMD-xilinx Zynq
> > UltraScale+ platform. As of now TCM addresses are hardcoded in xilinx
> > remoteproc driver. This binding will help in defining TCM in
> > device-tree and make it's access platform agnostic and data-driven from
> the driver.
> >
> > Tightly-coupled memories(TCMs) are low-latency memory that provides
> > predictable instruction execution and predictable data load/store
> > timing. Each Cortex-R5F processor contains two 64-bit wide 64 KB
> > memory banks on the ATCM and BTCM ports, for a total of 128 KB of
> memory.
> >
> > In split mode, TCM resources(reg, ranges and power-domain) are
> > documented in each R5 node and in lockstep mode TCM resources are
> > documented in any of the R5 node.
> >
> > It also extends the examples for TCM split and lockstep modes.
> >
> > Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
> > ---
> > The inspiration for integrating TCM nodes in R5 nodes is taken from
> > "5ee79c2ed5bd dt-bindings: remoteproc: Add bindings for R5F subsystem
> > on TI K3 SoCs".Once the binding is reviewed/accepted will send out
> > driver changes in follow-up series.
> > ---
> >  .../remoteproc/xlnx,zynqmp-r5fss.yaml         | 86 +++++++++++++++++--
> >  1 file changed, 81 insertions(+), 5 deletions(-)
> >
> > diff --git
> > a/Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-
> r5fss.yaml
> > b/Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-
> r5fss.yaml
> > index 9f677367dd9f..0bc3a8bb8374 100644
> > ---
> > a/Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-
> r5fss.yaml
> > +++ b/Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-
> r5fss.y
> > +++ aml
> > @@ -20,6 +20,12 @@ properties:
> >    compatible:
> >      const: xlnx,zynqmp-r5fss
> >
> > +  "#address-cells":
> > +    const: 1
> > +
> > +  "#size-cells":
> > +    const: 1
>=20
> If these are translatable addresses, then you are missing 'ranges'.

Thanks, will add ranges property in v2.

+  ranges:
+    description: |
+      Standard ranges definition providing address translations for
+      local R5F TCM address spaces to bus addresses.

>=20
> > +
> >    xlnx,cluster-mode:
> >      $ref: /schemas/types.yaml#/definitions/uint32
> >      enum: [0, 1, 2]
> > @@ -37,7 +43,7 @@ properties:
> >        2: single cpu mode
> >
> >  patternProperties:
> > -  "^r5f-[a-f0-9]+$":
> > +  "^r5f(.*)+$":
>=20
> That's just '^r5f'. If adding a unit-address is what you want then make t=
he
> regex define that: "^r5f(@[0-9a-f]+|-[a-f0-9]+)$"

Will use this regex in v2.

>=20
> >      type: object
> >      description: |
> >        The RPU is located in the Low Power Domain of the Processor
> Subsystem.
> > @@ -54,8 +60,27 @@ patternProperties:
> >        compatible:
> >          const: xlnx,zynqmp-r5f
> >
> > +      "#address-cells":
> > +        const: 1
> > +
> > +      "#size-cells":
> > +        const: 1
>=20
> These (and ranges) apply to child nodes, but you don't have any at this l=
evel.

Will drop address-cells and size-cells from core(xlnx,zynqmp-r5f) node
and address it in v2.

>=20
> > +
> > +      reg:
> > +        items:
> > +          - description: Address and Size of the ATCM internal memory =
region
> > +          - description: Address and Size of the BTCM internal memory
> > + region
> > +
> > +      reg-names:
> > +        items:
> > +          - const: atcm
> > +          - const: btcm
> > +
> > +      ranges: true
> > +
> >        power-domains:
> > -        maxItems: 1
> > +        minItems: 1
> > +        maxItems: 3
> >
> >        mboxes:
> >          minItems: 1
> > @@ -112,13 +137,64 @@ additionalProperties: false
> >
> >  examples:
> >    - |
> > +    #include <dt-bindings/power/xlnx-zynqmp-power.h>
> > +
> > +    //Split mode configuration
> > +    remoteproc {
> > +        compatible =3D "xlnx,zynqmp-r5fss";
> > +        xlnx,cluster-mode =3D <0>;
> > +
> > +        #address-cells =3D <1>;
> > +        #size-cells =3D <1>;
> > +        r5f_0: r5f@ffe00000 {
> > +            compatible =3D "xlnx,zynqmp-r5f";
> > +            #address-cells =3D <1>;
> > +            #size-cells =3D <1>;
> > +            reg =3D <0xffe00000 0x10000>, <0xffe20000 0x10000>;
> > +            reg-names =3D "atcm", "btcm";
> > +            ranges =3D <0x0 0xffe00000 0x10000>, <0x20000 0xffe20000
> 0x10000>;
> > +            power-domains =3D <&zynqmp_firmware PD_RPU_0>,
> > +                            <&zynqmp_firmware PD_R5_0_ATCM>,
> > +                            <&zynqmp_firmware PD_R5_0_BTCM>;
> > +            memory-region =3D <&rproc_0_fw_image>, <&rpu0vdev0buffer>,
> <&rpu0vdev0vring0>, <&rpu0vdev0vring1>;
> > +            mboxes =3D <&ipi_mailbox_rpu0 0>, <&ipi_mailbox_rpu0 1>;
> > +            mbox-names =3D "tx", "rx";
> > +        };
> > +
> > +        r5f_1: r5f@ffe90000 {
> > +            compatible =3D "xlnx,zynqmp-r5f";
> > +            #address-cells =3D <1>;
> > +            #size-cells =3D <1>;
> > +            reg =3D <0xffe90000 0x10000>, <0xffeb0000 0x10000>;
> > +            reg-names =3D "atcm", "btcm";
> > +            ranges =3D <0x0 0xffe90000 0x10000>, <0x20000 0xffeb0000
> 0x10000>;
> > +            power-domains =3D <&zynqmp_firmware PD_RPU_1>,
> > +                            <&zynqmp_firmware PD_R5_1_ATCM>,
> > +                            <&zynqmp_firmware PD_R5_1_BTCM>;
> > +            memory-region =3D <&rproc_1_fw_image>, <&rpu1vdev0buffer>,
> <&rpu1vdev0vring0>, <&rpu1vdev0vring1>;
> > +            mboxes =3D <&ipi_mailbox_rpu1 0>, <&ipi_mailbox_rpu1 1>;
> > +            mbox-names =3D "tx", "rx";
> > +        };
> > +    };
> > +
> > +  - |
> > +    //Lockstep configuration
> >      remoteproc {
> >          compatible =3D "xlnx,zynqmp-r5fss";
> >          xlnx,cluster-mode =3D <1>;
> >
> > -        r5f-0 {
> > +        #address-cells =3D <1>;
> > +        #size-cells =3D <1>;
> > +        r5f_00: r5f@ffe00000 {
> >              compatible =3D "xlnx,zynqmp-r5f";
> > -            power-domains =3D <&zynqmp_firmware 0x7>;
> > +            #address-cells =3D <1>;
> > +            #size-cells =3D <1>;
> > +            reg =3D <0xffe00000 0x20000>, <0xffe20000 0x20000>;
> > +            reg-names =3D "atcm", "btcm";
> > +            ranges =3D <0x0 0xffe00000 0x20000>, <0x20000 0xffe20000
> 0x20000>;
> > +            power-domains =3D <&zynqmp_firmware PD_RPU_0>,
> > +                            <&zynqmp_firmware PD_R5_0_ATCM>,
> > +                            <&zynqmp_firmware PD_R5_0_BTCM>;
> >              memory-region =3D <&rproc_0_fw_image>, <&rpu0vdev0buffer>,
> <&rpu0vdev0vring0>, <&rpu0vdev0vring1>;
> >              mboxes =3D <&ipi_mailbox_rpu0 0>, <&ipi_mailbox_rpu0 1>;
> >              mbox-names =3D "tx", "rx";
> > @@ -126,7 +202,7 @@ examples:
> >
> >          r5f-1 {
> >              compatible =3D "xlnx,zynqmp-r5f";
> > -            power-domains =3D <&zynqmp_firmware 0x8>;
> > +            power-domains =3D <&zynqmp_firmware PD_RPU_1>;
> >              memory-region =3D <&rproc_1_fw_image>, <&rpu1vdev0buffer>,
> <&rpu1vdev0vring0>, <&rpu1vdev0vring1>;
> >              mboxes =3D <&ipi_mailbox_rpu1 0>, <&ipi_mailbox_rpu1 1>;
> >              mbox-names =3D "tx", "rx";
> > --
> > 2.25.1
> >
