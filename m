Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1DA68D1DC
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 09:56:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbjBGI4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 03:56:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjBGI4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 03:56:06 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 855AE37F3B;
        Tue,  7 Feb 2023 00:55:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HZAVwHBr1DnCHAJJGHKdBY2OrVYnatAK0KpmA9eNsGULSfG5r8r3QLC+xEcWDDcpYOsiwU/qU51muX8nkD1yk0afRJATpSw/mX6Iep7PbAHc5G3y7kUSnSxQfvYZ+4FCuBvlmV8K+VlDnB8DG570L9wBrGI15CgClf3rBe6l2/5kdNcOXH1Qw38crcaC0YeLKLFdPLXgiGZajyiJkrA8RQkeMno3YImL2oEH9RsTLCqD2GM/CPxLc1tq5XFvrXVNceqU/lUBUtyzn8S5XuBBy4dqzvFAiYpVSl7y4sMjfuNluNeUPiQ9l6HeCzVUu+iPOLxStiEn29w2FjDglO8w6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4oSqoWxnLsTtBW1uRbXBh1Y5ZvDSUYjPXqKBkisucPM=;
 b=fwcSAgSdbl6OsdJ19ivlM4q45iOOCUPg1BUmdasABRbQtXDyXBXPQmtFtYWAGJTvkKVKds2rZC3hd9ijir3FPYBdFyI7E0CEpJre2fAPa7iwKflkcPix6LRcq6GDF5PO+iRcR6nQftOuUFK36S5oENjAJh1ihfil8TmvtcGqVMbnAdTkVJUt/ptyKRhfdwwv5u5fYfSzMraHwQUIpVpAL8hVqp0Bwfdjjg9FS/5UKU+LaV9oq3MoySshra5ex+cpCkV8l8b/FEyzV/BF2DgDSP2kBBQatQboG1ZtgB9zOOat5BKL/2DoXcSd/jETjmenErls/BJemaefoVX9ARM//Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4oSqoWxnLsTtBW1uRbXBh1Y5ZvDSUYjPXqKBkisucPM=;
 b=eyIYO0HgNWjb11eqhzmgsAVUmC4Cpss/JhtJ5eFO1iM4dd07v6avKlfQ0+LfxfKxGXZiVBVJ36mkpd1NixPPQdbHBxgGf8sngAI96ETau8okf6TIvdU3hk24zZMTTLZ1qGuCRr7EleYygy8XtDD7aI5zoVcaL/xELrx3cBh4LzY=
Received: from DM6PR12MB3082.namprd12.prod.outlook.com (2603:10b6:5:11b::12)
 by MN2PR12MB4191.namprd12.prod.outlook.com (2603:10b6:208:1d3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.36; Tue, 7 Feb
 2023 08:55:40 +0000
Received: from DM6PR12MB3082.namprd12.prod.outlook.com
 ([fe80::12bb:9697:46d5:c65d]) by DM6PR12MB3082.namprd12.prod.outlook.com
 ([fe80::12bb:9697:46d5:c65d%6]) with mapi id 15.20.6064.034; Tue, 7 Feb 2023
 08:55:40 +0000
From:   "Gupta, Nipun" <Nipun.Gupta@amd.com>
To:     Rob Herring <robh@kernel.org>
CC:     "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
        "song.bao.hua@hisilicon.com" <song.bao.hua@hisilicon.com>,
        "mchehab+huawei@kernel.org" <mchehab+huawei@kernel.org>,
        "maz@kernel.org" <maz@kernel.org>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "jeffrey.l.hugo@gmail.com" <jeffrey.l.hugo@gmail.com>,
        "saravanak@google.com" <saravanak@google.com>,
        "Michael.Srba@seznam.cz" <Michael.Srba@seznam.cz>,
        "mani@kernel.org" <mani@kernel.org>,
        "yishaih@nvidia.com" <yishaih@nvidia.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "jgg@nvidia.com" <jgg@nvidia.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "masahiroy@kernel.org" <masahiroy@kernel.org>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "okaya@kernel.org" <okaya@kernel.org>,
        "Anand, Harpreet" <harpreet.anand@amd.com>,
        "Agarwal, Nikhil" <nikhil.agarwal@amd.com>,
        "Simek, Michal" <michal.simek@amd.com>,
        "git (AMD-Xilinx)" <git@amd.com>
Subject: RE: [PATCH v7 3/7] dt-bindings: bus: add CDX bus controller for
 versal net
Thread-Topic: [PATCH v7 3/7] dt-bindings: bus: add CDX bus controller for
 versal net
Thread-Index: AQHZNU/YpDV0RwkJikC6UJPDVGpD+K66VkCAgAjiKlA=
Date:   Tue, 7 Feb 2023 08:55:40 +0000
Message-ID: <DM6PR12MB3082B4C2A0486CA742DD20C2E8DB9@DM6PR12MB3082.namprd12.prod.outlook.com>
References: <20230131084049.23698-1-nipun.gupta@amd.com>
 <20230131084049.23698-4-nipun.gupta@amd.com>
 <20230201171301.GA3606391-robh@kernel.org>
In-Reply-To: <20230201171301.GA3606391-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-02-07T08:55:37Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=cda62fa8-d345-46a0-8db2-82617edb9c3c;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB3082:EE_|MN2PR12MB4191:EE_
x-ms-office365-filtering-correlation-id: ed22aa5d-b120-459f-6ea1-08db08e916c4
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nq3AdJC/3vwv3MWwdDaIhGWqfasU67WcUw4a8dXOoXZfZ/SmXIE2N96hYLyGkN52PD1T/6dIBVuUzkDexl4CQCBe3QeqG+B6uHHbr8Bpv1jlNYixjmOvQbjALVyF/Mif3WFSFPHwVnkoRn3vkjFZKY2BGD2buPCJRNeMnoaghyB8WerOE4xcb780PfoAS2lfIQQemv9tyrk8vrsHw7S14gAmaQVO9vlZrXPiwGBop798Bid1nDt3uoo5JeHLGuG0Hv+tA5IYjr8GeYKko268bOJbLAQrHbRleHiNZWJEKxFCTU2irk+BM+wJrdy+lCSFSF0GwK9RatPnUlAMXsepUiuIcEr18iqFDvhbNSrTiRuCj5sm9r0X5rJVMrCs3EpLyXIoDZtnlXWhETqTj1ioMrGnZDvvYSNwpM8YNpNL5IMfZUryqgOdTwWJadcrPKv8z/vHwOR7RCvAj7YYddgqrzeEZDQKE65fowCJY1H394vkDxa5//wgr/18DEwPwx9cVfh8z7H55rmST6RW5WegMF3mRr1iwUOtX82rtBKOb8nTdTiP4z7pXB6wRqAGgqugUMu77D2zXi123X0d8k2cxYNuw3froiF5Z6pLPCth+WlHkDVbWQOIhqCfwwhPpfxw8FmbZgCILCkbbX32jAJcMplgE6fcRKNL97t/cQbACn9+d775pKkgsvHCSpc3zOGuVXmsy9lDegbveAmAMJ5dfl8wVzFsz5e6u1hBSdKlXxrLAvQiocR6wZ2PqD8LpMo75N3/aJH2BuoVx4xS1E7eng==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3082.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(136003)(396003)(366004)(39860400002)(451199018)(186003)(6506007)(26005)(53546011)(9686003)(122000001)(38100700002)(83380400001)(7696005)(71200400001)(966005)(478600001)(38070700005)(4326008)(76116006)(8676002)(316002)(54906003)(6916009)(66476007)(66556008)(64756008)(66446008)(41300700001)(86362001)(8936002)(52536014)(7406005)(7416002)(5660300002)(2906002)(66946007)(55016003)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YKn8KkaUPWFMGb8pPzkHT1NmAhfCnpMDwiKB5ZAKZ4kcfon3kkYkz4Sagitw?=
 =?us-ascii?Q?+cWX2HE/Ueuu9A50P/VBJFPU3KNgIbCm/UKhEQuCowiOuwT/7JPistNjzIQT?=
 =?us-ascii?Q?wn/fznjXWt0ewNNrXEsDBMeuc7Y+/hLX//s8mQkeYANX3d+SiGHii9h7WpuG?=
 =?us-ascii?Q?cWr3ejZf30MFWI+ZBdSMh3+Vhm5rVFLVQZoY50N4avTLeh2OVNzvOeoZ458S?=
 =?us-ascii?Q?1wKQPAUZ6SEoRb2emRRO3Qjcg6ZNEa8HPYmuSRW8+t8iYP23AyADqS21O7o+?=
 =?us-ascii?Q?pgIzqkNpomto3N0q107yqpjkwUku3lUU++KjQqEUB8xwjHJp+7nX44TqRRit?=
 =?us-ascii?Q?zrBcIyevQMwIyrj2aD/9YSiMGRVlLn44RGoDSRGm8kz3qf7gPZV/REZSxaf3?=
 =?us-ascii?Q?C6RP1X+HN+8Mo/9VJqE19nyqL+5JrNDq+dhU9OSQccI/Hx46eOgCTEBPs5op?=
 =?us-ascii?Q?UX4Zv1zI0prClncM0RZ1pPqeImgbswCRQ3a7a7Uis8El2+jYnU1FlNhDVn8u?=
 =?us-ascii?Q?+PKlVTeCCeXVhQc9Ho/VpR4nbod9Tpj8cUw33rTXpRcStn7tqJtYw9DOR5KV?=
 =?us-ascii?Q?JcrhmauZWwecFQgtB5A0PQGMOfsEGFg0lWGml3jgoDlRyxRayKzW7dXZXVK8?=
 =?us-ascii?Q?D+1gDJSRJp1R9zdExE6lUEsUe3RSByF4sM+uOuVqLaNGJkzKY9ScUIMvXr/a?=
 =?us-ascii?Q?i/tNpEdPCpj5rD1t2t3LDTley8+5A8VC5Qy07MHqE1dP9mV1opk1M0Ccm2WJ?=
 =?us-ascii?Q?tHu0tQu6vJTrUD5adUQjkQSa7DMd9iO15e7jf88ZjgQVDj5E0mM4W7zEPtyi?=
 =?us-ascii?Q?OkoHjvGRuxV7AouiTreFoqXMzox5kCUJmIeKNoP7AsGBoN/YpX3NmemVqfc+?=
 =?us-ascii?Q?vnuCN23d5Q1TON1aHzzlYJn9XzUvqS/KUGEyfRykgtmjUy1lElgypX4BxDII?=
 =?us-ascii?Q?1Iu6UJf5ZxE9OxZr9LkzxzepBpFboIgwvL0bXlY/YXcLYjRrLFqTfyLtACbA?=
 =?us-ascii?Q?gpzD9vjoZM3dGyUBtiyPa+CEh16Qlrqieu3qx79DwkmsTwOyn1s+nzbT/x9o?=
 =?us-ascii?Q?d5h5O//iAm4p0SYvxcsf5WDmIZcsh2BfSse6t2OPOpCTiRaS/cIFOXUCWT3q?=
 =?us-ascii?Q?0QuMlOwOC8o5NyNCKgy7jkXOQ3sLDDviMiPPQYPSzBVYyIiRdUoObGO8Wyob?=
 =?us-ascii?Q?YPq1d3bskWwK/5adzSV9I2tZ0TeP0rFmDQeFAWVibR+cDhA1NU9SdUu8An3r?=
 =?us-ascii?Q?rAmxHiNXinp5pjBn2TncZ3fHAxfZP52Y14uHTSz96h7UXdfWonjIuog+zn4y?=
 =?us-ascii?Q?hqXeyte8dRP5BmL40WreMj29HxQVLvWD8YdSHVHGW2pm9cXIEp8fK/LvdGpb?=
 =?us-ascii?Q?By6hMtLhQS5WRVLXsS7MwDh9nv/KQvMEvv3q33/d0xQ35PBjTRHFsbbZxuJ1?=
 =?us-ascii?Q?UoToWn/J1nnZtogxQBUvpbcuRvJJB05LObTAS8q15MtEpvbmpygnDQpOjjTz?=
 =?us-ascii?Q?jcK3laITnuM6POrGqUVuf5iZqzm0dntKw9/20+OXRqKRzO/4oyy00z/fwNTc?=
 =?us-ascii?Q?4BBvH9fsoNv3ergLWBo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3082.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed22aa5d-b120-459f-6ea1-08db08e916c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2023 08:55:40.5275
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1xzGpp/ctUtCzJalE1NROyq8eOtI8YwdFBeuvtEXxKNfgiclL+p1Ss+aksaQ5cn2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4191
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[AMD Official Use Only - General]



> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: Wednesday, February 1, 2023 10:43 PM
> To: Gupta, Nipun <Nipun.Gupta@amd.com>
> Cc: krzysztof.kozlowski+dt@linaro.org; gregkh@linuxfoundation.org;
> rafael@kernel.org; eric.auger@redhat.com; alex.williamson@redhat.com;
> cohuck@redhat.com; song.bao.hua@hisilicon.com;
> mchehab+huawei@kernel.org; maz@kernel.org; f.fainelli@gmail.com;
> jeffrey.l.hugo@gmail.com; saravanak@google.com; Michael.Srba@seznam.cz;
> mani@kernel.org; yishaih@nvidia.com; jgg@ziepe.ca; jgg@nvidia.com;
> robin.murphy@arm.com; will@kernel.org; joro@8bytes.org;
> masahiroy@kernel.org; ndesaulniers@google.com; rdunlap@infradead.org;
> linux-arm-kernel@lists.infradead.org; linux-kbuild@vger.kernel.org; linux=
-
> kernel@vger.kernel.org; devicetree@vger.kernel.org; okaya@kernel.org;
> Anand, Harpreet <harpreet.anand@amd.com>; Agarwal, Nikhil
> <nikhil.agarwal@amd.com>; Simek, Michal <michal.simek@amd.com>; git
> (AMD-Xilinx) <git@amd.com>
> Subject: Re: [PATCH v7 3/7] dt-bindings: bus: add CDX bus controller for =
versal
> net
>=20
> Caution: This message originated from an External Source. Use proper caut=
ion
> when opening attachments, clicking links, or responding.
>=20
>=20
> On Tue, Jan 31, 2023 at 02:10:45PM +0530, Nipun Gupta wrote:
> > Add CDX bus controller device tree bindings for versal-net
> > devices.
> >
> > Signed-off-by: Nipun Gupta <nipun.gupta@amd.com>
> > ---
> >  .../bindings/bus/xlnx,versal-net-cdx.yaml     | 68 +++++++++++++++++++
> >  MAINTAINERS                                   |  1 +
> >  2 files changed, 69 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/bus/xlnx,versal-
> net-cdx.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/bus/xlnx,versal-net-cdx.=
yaml
> b/Documentation/devicetree/bindings/bus/xlnx,versal-net-cdx.yaml
> > new file mode 100644
> > index 000000000000..8452185b9d70
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/bus/xlnx,versal-net-cdx.yaml
> > @@ -0,0 +1,68 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/bus/xlnx,versal-net-cdx.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: AMD CDX bus controller
> > +
> > +description: |
> > +  CDX bus controller for AMD devices is implemented to dynamically
> > +  detect CDX bus and devices on these bus using the firmware.
> > +  The CDX bus manages multiple FPGA based hardware devices, which
> > +  can support network, crypto or any other specialized type of
> > +  devices. These FPGA based devices can be added/modified dynamically
> > +  on run-time.
> > +
> > +  All devices on the CDX bus will have a unique streamid (for IOMMU)
> > +  and a unique device ID (for MSI) corresponding to a requestor ID
> > +  (one to one associated with the device). The streamid and deviceid
> > +  are used to configure SMMU and GIC-ITS respectively.
> > +
> > +  iommu-map property is used to define the set of stream ids
> > +  corresponding to each device and the associated IOMMU.
> > +
> > +  The MSI writes are accompanied by sideband data (Device ID).
> > +  The msi-map property is used to associate the devices with the
> > +  device ID as well as the associated ITS controller.
> > +
> > +  rproc property (xlnx,rproc) is used to identify the remote processor
> > +  with which APU (Application Processor Unit) interacts to find out
> > +  the bus and device configuration.
> > +
> > +maintainers:
> > +  - Nipun Gupta <nipun.gupta@amd.com>
> > +  - Nikhil Agarwal <nikhil.agarwal@amd.com>
> > +
> > +properties:
> > +  compatible:
> > +    const: xlnx,versal-net-cdx
> > +
> > +  iommu-map: true
> > +
> > +  msi-map: true
> > +
> > +  xlnx,rproc:
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +    description:
> > +      phandle to the remoteproc_r5 rproc node using which APU interact=
s
> > +      with remote processor.
> > +
> > +required:
> > +  - compatible
> > +  - iommu-map
> > +  - msi-map
> > +  - xlnx,rproc
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    cdx {
> > +        compatible =3D "xlnx,versal-net-cdx";
> > +        /* define map for RIDs 250-259 */
> > +        iommu-map =3D <250 &smmu 250 10>;
> > +        /* define msi map for RIDs 250-259 */
> > +        msi-map =3D <250 &its 250 10>;
> > +        xlnx,rproc =3D <&remoteproc_r5>;
>=20
> There's no addresses associated with this bus? Like the address range
> the devices are at.

Hi Rob,

There is a remoteproc device which is associated with this controller, whic=
h
exposes the address for CDX bus controller and hence no reg/address require=
d
in this node.=20

> You should have 'ranges' whether Linux needs it yet
> or not.

Agree, will add this to the next spin.

Thanks,
Nipun

>=20
> Rob
