Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE4CF74F49B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 18:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbjGKQOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 12:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbjGKQOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 12:14:14 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8593D1A3;
        Tue, 11 Jul 2023 09:14:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QwhDBxUfIdMK11zPSQ2ESmj9AmZfpDMYk+JlHhexFJmAg6T3m0rP9dZulgDcPntfYSMIv2V01o6UN5w9pRVggaXKev8wwTM5ikRBil0hS4xOU1qCfV4TijGIIMHvzp3lfKtRiw9JvyPVCqdYJ0cyG45DYuh+eRnLYIhAa34+R+2cI3fJDKubd4cHT/ZRS8i692v6JFeBP8d72MhiZgCApzeOhVPj3OZHGuUiuEZuQI8TMQ6cm+CBUv2UxVePNn7MbqEn1NzAbbU2OHJrd3SZXg/v9eK0ciF4w6cGM/TUtai5GWKwqB0eas9hS8pSWUcTruwEgbADrOLP7jLktgOwtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6VlBl6Y84rkV5hajuU2HTIOWkR1HRHWMZj+D0lcVXLw=;
 b=m6+R6hFu7NOjDyJDKv6Z7QHHvUI8x3BE5GqiZPftxWwuxHuss5flvO8eqGYRRXK5pe4LG9DUYGF3TZVjXANqu7qPBDDRydjJTdAxCKNFtUoX9VMJ3A/PcVcK3ZDA20YupsUWBAR2p1Eyn0zZQ+bLAixvbyxW+UNxRsISpuRuLbfRnMNLlmAKlECLAobNPU3I6aMhsMUofVGdrE7beLh877qyQgK7w06tywvFOXJ/lp09eK+Uc/nbQ4J96XPJyx+Bngquf4YHSzdFuXOIkhqQC3WZT1E9UKTIK0ek9028Q8gXRwxxKXFvwqLADBG/+PqyhrAJQA+F1+E4LI9MbSJncg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6VlBl6Y84rkV5hajuU2HTIOWkR1HRHWMZj+D0lcVXLw=;
 b=JWq5hMSuB2awf0t9pmrhGR/1UqlHEFZkePl5qWw6MvVJm9cYefyjt2isOe0xt0V8t2Fby006GD2rodEp1R5De9yBlWbrzxt+DHq0wSFXznlrcgPCeaIxmh1tITUrvfhzANqboSNmT95tOqy4W1bGO2NUOna9ttKPdzdiOtzN+y8=
Received: from MN0PR12MB5953.namprd12.prod.outlook.com (2603:10b6:208:37c::15)
 by DM6PR12MB4283.namprd12.prod.outlook.com (2603:10b6:5:211::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Tue, 11 Jul
 2023 16:14:09 +0000
Received: from MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::69e5:18e:4b1b:28e]) by MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::69e5:18e:4b1b:28e%6]) with mapi id 15.20.6565.028; Tue, 11 Jul 2023
 16:14:09 +0000
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
Subject: RE: [PATCH v2] dt-bindings: remoteproc: add Tightly Coupled Memory
 (TCM) bindings
Thread-Topic: [PATCH v2] dt-bindings: remoteproc: add Tightly Coupled Memory
 (TCM) bindings
Thread-Index: AQHZqSk6LmYbRPZ6BEyxtQH90GPwHq+tJmEAgAerKVA=
Date:   Tue, 11 Jul 2023 16:14:09 +0000
Message-ID: <MN0PR12MB595357704EDA02F8EAFB7EFAB731A@MN0PR12MB5953.namprd12.prod.outlook.com>
References: <1687892226-3784452-1-git-send-email-radhey.shyam.pandey@amd.com>
 <20230706190204.GA144696-robh@kernel.org>
In-Reply-To: <20230706190204.GA144696-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB5953:EE_|DM6PR12MB4283:EE_
x-ms-office365-filtering-correlation-id: b7fb7eb6-a2e6-4a92-7f6a-08db8229dbbc
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Qw2n3Sx27HjBKlSI7ncqJSqeU6HI8m+s4bPEEhmgWqRdVXusa3s2wOCS26USlTYi9LxDvhwMDG4jh89LBXtG+KGNy/yaYXD4TM496PBeRQvsr7yMSDzZ38KO6Cp1XLCL7Q3mQkZB6TN6R0JTb0bYEx50JX7vY6cIUKRfo/UHYvXUaIou2Gc7iVTqfGyQYiGASoDt3OhJETeDSZ5BRzGs2tnRNaCMocqtutMak2w1s2Hv1IEa2/vbULsidEc+KjQYR8kSYAkJnTNynVkutIEOElIa6brC8RooJKK1J8ntDO9KWt4w/gytA1QCVZrXF0xvfi9FdtXV9OCi1InTBY4FgeLOmVUB9IGr6np4/Wonh/lIg6bQz5X4GePoabLXnVnSivV8iRQt5kWup6oKFdV+dNW6oBhjYYh5isITPBVbSH7UM1ySOoGVGr2xrHvo+t9LEcdf//oWJH6xL4aoZy6iTKUPkVhrkjlMKHi4N6ry+GafVVLajmA6/nk4U/i4l7b7jPnbRHlXiLbirYwCfNDzrryJUyw80vzGOFtP/xWqOAZCVRW2nHOI9vD2d3Y/5XMDf5CZ86FI0kpip/ljqoXPGph6xJvwsp2hf3asBw7eeaZBsFAxZpkPnPv2YlCMnn91
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5953.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(136003)(366004)(39860400002)(376002)(451199021)(54906003)(76116006)(478600001)(7696005)(71200400001)(6506007)(26005)(53546011)(186003)(9686003)(66946007)(2906002)(41300700001)(5660300002)(4326008)(66476007)(316002)(66446008)(7416002)(52536014)(66556008)(8936002)(64756008)(6916009)(122000001)(38100700002)(8676002)(33656002)(86362001)(38070700005)(83380400001)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1k6Yi2nkooAE3FFjBA9ADMZ6NZxTEZBM/YeWhshsfAllPTB2paPr2I9pEb9r?=
 =?us-ascii?Q?K2jhg3NJE0PqgEnCDBIer3l+pzibj5Z+WySuKf/2LNitTNj6e2gr+ebaSrqg?=
 =?us-ascii?Q?GVEMnpO4qn2rgMrazJLsYKr8QOZ3/g+ri/34Y24ASQJlHPwiuq2+uleDDQNc?=
 =?us-ascii?Q?H3U1D+vwElKJb53Q/cMa+W4Bp1ETkAN633fdOYWUQxdSZgK32H9k0gO8tRUF?=
 =?us-ascii?Q?JeC7Hi3JsT7tvAk1FXXt8qxEASI4E42EZopweaOgQbmi0uL98bbV9Nwu9xd+?=
 =?us-ascii?Q?vnPADqcjvQ6irOQwyNpA9tHrIiKoz7TkGUC1VDmOgXkDxmlNfsHnycXwSVs/?=
 =?us-ascii?Q?rGT3BEFuaXmI2ahfw38efleQ5rhfZ54VDNm3Za4NnoI/MTmkdo2VnHchITX2?=
 =?us-ascii?Q?54Vj0F3OhiH93+f3ku+8T/ZEik7ksdlvFMeA56oMR42hGZE+WcZEEayezgTE?=
 =?us-ascii?Q?oIXE/ERXKSagwLS32x9ku7F0aiuzMU2Pg0AscIhgC8h2JCRyqXg/VAIB4uuG?=
 =?us-ascii?Q?4vPVMFZVw/0IOw9Wa6ia40ZlIVluoyVdaJXnh/YknAzhXfvMgkoXMbezRE9f?=
 =?us-ascii?Q?Q9puk+vTRMS32dTh/2TEOCdnlQaLll5nIHHyTI+OqJJcK4GqEJP7TdkcfOEt?=
 =?us-ascii?Q?55qLwPyJpcQbP3MgYyPKXj3Tr/Gh9y2vPdVv5KacadnJBWRt4xVzaQX6QSYn?=
 =?us-ascii?Q?QbLDrVqXXXyd29vCwUX1gQqXmmxHoDbJJgo9UfDhsW/TRmjCmJaxpEWpx5TD?=
 =?us-ascii?Q?aqnphdnp8Al1KDKKdR8+IL22GaG6/VuXArS/+hK0mI02OqhRPiuf2GFa+hNv?=
 =?us-ascii?Q?Ta/EL/FeQtzNxfa586YrLlovnGP1Ijb7QA20Tbcf7QHY/7Rzd0VXXj3IoyFX?=
 =?us-ascii?Q?vHAyJDjh1oKLIcMi6gB9Z2TOGjD28SVVCBVxF5e59+3mVYl+VQfGvehSNvEz?=
 =?us-ascii?Q?l9VJgj6AEGDpqbxD1UnGrGhEQ1KgCyR7rj4GdiP/5XRDaDw41+ykrUhK9oDu?=
 =?us-ascii?Q?NzqZFIE0QksErGvR5E9ZOyp2tm3N7YccEudEFKccYWM0oQGgp0X5LTEvD+aA?=
 =?us-ascii?Q?AWkH2xu4mirN8B53OgCnRQxySrFOAAZZ45tGlwV5Edyp737jcepljH0A+ky4?=
 =?us-ascii?Q?1B0uVxdBb3fzY14bbzpvDgacRmGHF4H/w48S+vJQFTS4lTgBa1RBS5Gy88zv?=
 =?us-ascii?Q?VkH2Q1nVlPHbrf/a0GIZQckzVOXpitXkGViZ2CIZWSa7Hr5kJ9C4ImJvysTM?=
 =?us-ascii?Q?T73ewJvJ2N1aY99WHHwq6Oxj5dfdUVfWLxkGFNerVOjZ3nuaPfYSzhPm+0kJ?=
 =?us-ascii?Q?B6/H0zrG79UcKut3/AFM5+C0KLKr2lnsnYIh4EFP7lrI4xUryxtpLodnf9G0?=
 =?us-ascii?Q?mamifqS1J9kb0+90EedyNJPfz1FGh4f5SqqUgQkgx5+EPPRwnZycJi+fUo/j?=
 =?us-ascii?Q?ufKVLmVv65jBxYJfXqRq3V4Lx/QJOn4zONQlzOlS1xojmPo8dT2SYziVleNd?=
 =?us-ascii?Q?P40IdpDvMd8UnRVIL+p2tKFSaps6y3pvHp5EqnOJ1VgR7j7yT70uYgChqz+X?=
 =?us-ascii?Q?uj3xzHW0WS6QuutTXfQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5953.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7fb7eb6-a2e6-4a92-7f6a-08db8229dbbc
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2023 16:14:09.4292
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aAVUe6MIa7T5MAN6P94CpfEAKu+q7O7Ekq7z3qDWxjSnHPVZ5ZV3QvI3J57roA27
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4283
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: Friday, July 7, 2023 12:32 AM
> To: Pandey, Radhey Shyam <radhey.shyam.pandey@amd.com>
> Cc: andersson@kernel.org; mathieu.poirier@linaro.org;
> krzysztof.kozlowski+dt@linaro.org; conor+dt@kernel.org; Simek, Michal
> <michal.simek@amd.com>; Levinsky, Ben <ben.levinsky@amd.com>; Shah,
> Tanmay <tanmay.shah@amd.com>; linux-remoteproc@vger.kernel.org;
> devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> kernel@vger.kernel.org; git (AMD-Xilinx) <git@amd.com>
> Subject: Re: [PATCH v2] dt-bindings: remoteproc: add Tightly Coupled
> Memory (TCM) bindings
>=20
> On Wed, Jun 28, 2023 at 12:27:06AM +0530, Radhey Shyam Pandey wrote:
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
> > The TCM resources(reg and power-domain) are documented in each R5
> node.
> > It also extends the examples for TCM split and lockstep modes.
> >
> > Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
> > ---
> > Changes for v2:
> > - Add ranges property to r5fss cluster node.
> > - Use regex "^r5f(@[0-9a-f]+|-[a-f0-9]+)$".
> > - Drop address/size-cells and ranges from r5f core node.
> > - Mention "reg" and "reg names" as r5f core node required properties.
> > - Mention address/size-cells and ranges as r5fss required node properti=
es.
> > - Modify commit description to remove ranges from R5 node.
> > - Rename r5f node labels(r5f_0 -> r5f_0_split/lockstep and
> >   r5f_1->r5f_1_split/lockstep)
> >
> > The inspiration for integrating TCM nodes in R5 nodes is taken from
> > "5ee79c2ed5bd dt-bindings: remoteproc: Add bindings for R5F subsystem
> > on TI K3 SoCs".Once the binding is reviewed/accepted will send out
> > driver changes in follow-up series.
> > ---
> >  .../remoteproc/xlnx,zynqmp-r5fss.yaml         | 90 +++++++++++++++++--
> >  1 file changed, 83 insertions(+), 7 deletions(-)
> >
> > diff --git
> > a/Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-
> r5fss.yaml
> > b/Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-
> r5fss.yaml
> > index 9f677367dd9f..958044b08e86 100644
> > ---
> > a/Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-
> r5fss.yaml
> > +++ b/Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-
> r5fss.y
> > +++ aml
> > @@ -20,6 +20,17 @@ properties:
> >    compatible:
> >      const: xlnx,zynqmp-r5fss
> >
> > +  "#address-cells":
> > +    const: 1
> > +
> > +  "#size-cells":
> > +    const: 1
> > +
> > +  ranges:
> > +    description: |
> > +      Standard ranges definition providing address translations for
> > +      local R5F TCM address spaces to bus addresses.
> > +
> >    xlnx,cluster-mode:
> >      $ref: /schemas/types.yaml#/definitions/uint32
> >      enum: [0, 1, 2]
> > @@ -37,7 +48,7 @@ properties:
> >        2: single cpu mode
> >
> >  patternProperties:
> > -  "^r5f-[a-f0-9]+$":
> > +  "^r5f(@[0-9a-f]+|-[a-f0-9]+)$":
>=20
> If reg is required, then you don't need '-[a-f0-9]+'. Though new required
> properties is an ABI change which needs justification.


Some background: remoteproc subsystem is currently supported on  zu+=20
platform and it's TCM addresses are hardcoded in xlnx_r5_remoteproc=20
driver at path: drivers/remoteproc/xlnx_r5_remoteproc.c
With this binding change i.e making reg/reg-names required=20
remoteproc driver will still ensure stable ABI and support zu+ old=20
device trees (without reg/reg-names).

For newer platform (versal) we plan to make reg/reg-names as required
properties and prefer not to have new hardcoded addresses for them=20
in xlnx_r5_remoteproc driver. Hope that is fine. I can add
this justification to commit description.

>=20
> >      type: object
> >      description: |
> >        The RPU is located in the Low Power Domain of the Processor
> Subsystem.
> > @@ -54,8 +65,19 @@ patternProperties:
> >        compatible:
> >          const: xlnx,zynqmp-r5f
> >
> > +      reg:
> > +        items:
> > +          - description: Address and Size of the ATCM internal memory =
region
> > +          - description: Address and Size of the BTCM internal memory
> > + region
>=20
> Drop 'Address and Size of '

Sure, will fix it in v3.

>=20
> > +
> > +      reg-names:
> > +        items:
> > +          - const: atcm
> > +          - const: btcm
> > +
> >        power-domains:
> > -        maxItems: 1
> > +        minItems: 1
> > +        maxItems: 3
> >
> >        mboxes:
> >          minItems: 1
> > @@ -102,31 +124,85 @@ patternProperties:
> >      required:
> >        - compatible
> >        - power-domains
> > +      - reg
> > +      - reg-names
> >
> >      unevaluatedProperties: false
> >
> >  required:
> >    - compatible
> > +  - "#address-cells"
> > +  - "#size-cells"
> > +  - ranges
> >
> >  additionalProperties: false
> >
> >  examples:
> >    - |
> > -    remoteproc {
> > +    #include <dt-bindings/power/xlnx-zynqmp-power.h>
> > +
> > +    //Split mode configuration
> > +    remoteproc@ffe00000 {
> > +        compatible =3D "xlnx,zynqmp-r5fss";
> > +        xlnx,cluster-mode =3D <0>;
> > +
> > +        #address-cells =3D <1>;
> > +        #size-cells =3D <1>;
> > +        ranges =3D <0x0 0xffe00000 0x10000>, <0x20000 0xffe20000 0x100=
00>,
> > +                 <0x0 0xffe90000 0x10000>, <0x20000 0xffeb0000
> > + 0x10000>;
> > +
> > +        r5f_0_split: r5f@ffe00000 {
> > +            compatible =3D "xlnx,zynqmp-r5f";
> > +            reg =3D <0xffe00000 0x10000>, <0xffe20000 0x10000>;
> > +            reg-names =3D "atcm", "btcm";
> > +            power-domains =3D <&zynqmp_firmware PD_RPU_0>,
> > +                            <&zynqmp_firmware PD_R5_0_ATCM>,
> > +                            <&zynqmp_firmware PD_R5_0_BTCM>;
> > +            memory-region =3D <&rproc_0_fw_image>, <&rpu0vdev0buffer>,
> <&rpu0vdev0vring0>, <&rpu0vdev0vring1>;
> > +            mboxes =3D <&ipi_mailbox_rpu0 0>, <&ipi_mailbox_rpu0 1>;
> > +            mbox-names =3D "tx", "rx";
> > +        };
> > +
> > +        r5f_1_split: r5f@ffe90000 {
> > +            compatible =3D "xlnx,zynqmp-r5f";
> > +            reg =3D <0xffe90000 0x10000>, <0xffeb0000 0x10000>;
> > +            reg-names =3D "atcm", "btcm";
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
> > +    remoteproc@ffe00000 {
> >          compatible =3D "xlnx,zynqmp-r5fss";
> >          xlnx,cluster-mode =3D <1>;
> >
> > -        r5f-0 {
> > +        #address-cells =3D <1>;
> > +        #size-cells =3D <1>;
> > +        ranges =3D <0x0 0xffe00000 0x20000>, <0x20000 0xffe20000
> > + 0x20000>;
> > +
> > +        r5f_0_lockstep: r5f@ffe00000 {
> >              compatible =3D "xlnx,zynqmp-r5f";
> > -            power-domains =3D <&zynqmp_firmware 0x7>;
> > +            reg =3D <0xffe00000 0x20000>, <0xffe20000 0x20000>;
> > +            reg-names =3D "atcm", "btcm";
> > +            power-domains =3D <&zynqmp_firmware PD_RPU_0>,
> > +                            <&zynqmp_firmware PD_R5_0_ATCM>,
> > +                            <&zynqmp_firmware PD_R5_0_BTCM>;
> >              memory-region =3D <&rproc_0_fw_image>, <&rpu0vdev0buffer>,
> <&rpu0vdev0vring0>, <&rpu0vdev0vring1>;
> >              mboxes =3D <&ipi_mailbox_rpu0 0>, <&ipi_mailbox_rpu0 1>;
> >              mbox-names =3D "tx", "rx";
> >          };
> >
> > -        r5f-1 {
> > +        r5f_1_lockstep: r5f@ffe90000 {
> >              compatible =3D "xlnx,zynqmp-r5f";
> > -            power-domains =3D <&zynqmp_firmware 0x8>;
> > +            reg =3D <0xffe90000 0x10000>, <0xffeb0000 0x10000>;
> > +            reg-names =3D "atcm", "btcm";
> > +            power-domains =3D <&zynqmp_firmware PD_RPU_1>;
> >              memory-region =3D <&rproc_1_fw_image>, <&rpu1vdev0buffer>,
> <&rpu1vdev0vring0>, <&rpu1vdev0vring1>;
> >              mboxes =3D <&ipi_mailbox_rpu1 0>, <&ipi_mailbox_rpu1 1>;
> >              mbox-names =3D "tx", "rx";
> > --
> > 2.25.1
> >
