Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5746C69934F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 12:39:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjBPLjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 06:39:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjBPLjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 06:39:19 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C90B04206;
        Thu, 16 Feb 2023 03:39:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1676547557; x=1708083557;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BPVEH951DYCaaamZO2JzoxSy5Gl8e3fiwvZAqGLkFww=;
  b=mpwxnH73Fc6yT8Yj4UK90lZl6W6H3fwpj6CEkICXMjcQupty5pP6I6PM
   KyVTMZ3WFobXhoRQ5xWCHQO2B+e+eb6T9O/SHnfI3ds7LsTsgEhymnkFs
   PoNR0wpyEnPGJpdtcZWS8xtSXNXt6OKkbtQ0N6lOllY//QRJKfFyxFtSz
   glacjT2e4faYWyXNHfGFjKg0xeCkhnr56tLP5+yVbNWUAJk2cvcCXCCac
   vtcT5NNpEd+CdKuKNs/FOf0DJL9vBLHjXmEAqGgRjD1nA3T/1jmWS0Us0
   Ak5X/IOzvmU9890NXWdG8doS0dFxY8VR1dxSA9+U2HFQHG1BtCgjw0BGG
   w==;
X-IronPort-AV: E=Sophos;i="5.97,302,1669100400"; 
   d="scan'208";a="137540902"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Feb 2023 04:39:16 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 16 Feb 2023 04:39:16 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 16 Feb 2023 04:39:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iej0F8l72dddDGH19FiEyKFqGtsI+hlNTW8OIPPtiPNgmBtfcIy/iM1kmAzr9He51fzb4E4BfewdkO++81gnZfGyy5GWK61K9BzrHY+Jg/D4PvqeCeDNFdadApdML7gdAzJO9TLwHhYR9Pni6vqhWlxsXk1VmAijsRbuX8/gOWAc+idaYaEhUqaOEjLowYhrrIOlaRyE26wyAxJZCKrWFiiXhreHenKwnl6Dti3P4RWtAptpxZTyOvrPQssILMg6Ka+JqRME+e2SNYiKeht27Fi3a7lLZ9MRVpqNZ7rDrb1VYT/Yc7gwmbKUI0ChgnSk2tt5EtcZR537THyA/QMI0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dVHr86mXKaQvOeAGqqlsDVoY6tNJdUmkQjB6UHZzecs=;
 b=kCoGPNvAQq5IYTNntOhNFoemvPwLOe/qhtP/hjznDWGVCTENAu4Ll8HVxz8PS9kDqKG4YyPbU2SU+iWyMlE1HCTp4ysTYYY80TSrrQv47E2qK2O2/EVU58ANPkYstcyYBdK0d4o7qqcCxQppjVOOTzPV7GIAkF5Maph/zRyY52Z8XCb9pD0J3LdTokJQOiAhKlZQ4CCr+vU2Cxi1qv6jOwrkUieW3/OV7NUs5XjsVJgXU6XinrU2FJlMklrJjktRNOHaVCQmCG3JbWIs5cwJn4XA3ZdUPr4CcXOlmkrOCkMjfLCWgW+FYYlzIvJZsbNslsHeEKlY1yZ4exyyWG9faA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dVHr86mXKaQvOeAGqqlsDVoY6tNJdUmkQjB6UHZzecs=;
 b=Y0YQ4z7VEUsYeIf3nDBdf6PSD6NtsI4Yhbht+Nl0uyP2r1V9hcFe74y2e8/ZChztQD0wYsGYsSkLcwnqWkud09PkDlAaXkssOqlAGwt3iXqot/HgdWCXaeWSsNnOFHPXYOsW+GEn556rK6+fJ8/fzD5ZwCqmtcmdbBtZ9kR2cJ4=
Received: from BN8PR11MB3668.namprd11.prod.outlook.com (2603:10b6:408:81::24)
 by CY8PR11MB7339.namprd11.prod.outlook.com (2603:10b6:930:9f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Thu, 16 Feb
 2023 11:39:13 +0000
Received: from BN8PR11MB3668.namprd11.prod.outlook.com
 ([fe80::3fd7:1f03:2b5:714c]) by BN8PR11MB3668.namprd11.prod.outlook.com
 ([fe80::3fd7:1f03:2b5:714c%7]) with mapi id 15.20.6086.026; Thu, 16 Feb 2023
 11:39:13 +0000
From:   <Kumaravel.Thiagarajan@microchip.com>
To:     <gregkh@linuxfoundation.org>
CC:     <michael@walle.cc>, <Tharunkumar.Pasumarthi@microchip.com>,
        <UNGLinuxDriver@microchip.com>, <arnd@arndb.de>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <srinivas.kandagatla@linaro.org>
Subject: RE: [PATCH v5 char-misc-next] misc: microchip: pci1xxxx: Add
 OTP/EEPROM driver for the pci1xxxx switch
Thread-Topic: [PATCH v5 char-misc-next] misc: microchip: pci1xxxx: Add
 OTP/EEPROM driver for the pci1xxxx switch
Thread-Index: AQHZPpY5vK269zMPJUW175op5Ze6367OH1cAgAFGAaCAAEoeAIAACswAgAAHKBCAAAiScIAAHpeAgAFb50A=
Date:   Thu, 16 Feb 2023 11:39:12 +0000
Message-ID: <BN8PR11MB3668C37EFBB42FB3FFC7618FE9A09@BN8PR11MB3668.namprd11.prod.outlook.com>
References: <20230212035743.231353-1-tharunkumar.pasumarthi@microchip.com>
 <20230214082804.2761756-1-michael@walle.cc>
 <BN8PR11MB36680842890C294566A156C3E9A39@BN8PR11MB3668.namprd11.prod.outlook.com>
 <7276bef47792e489abd093e4bd0044de@walle.cc> <Y+yeyNCA48IbKOKC@kroah.com>
 <BN8PR11MB36680D97C97B4894E321CAD9E9A39@BN8PR11MB3668.namprd11.prod.outlook.com>
 <BN8PR11MB3668A1E8541035E257F2C500E9A39@BN8PR11MB3668.namprd11.prod.outlook.com>
 <Y+zFo4SP5L/KkT/v@kroah.com>
In-Reply-To: <Y+zFo4SP5L/KkT/v@kroah.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN8PR11MB3668:EE_|CY8PR11MB7339:EE_
x-ms-office365-filtering-correlation-id: 6c70131d-aac8-454a-1182-08db10126d2e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RIgdC6Ti6X4MyvkVc5Z9/2WTi0CMpSAzq4edqBVT+Bp9Iz6SetEEHfwvLeVt71AXJg61nlHJ1tkER4p7Yo2J0rKGi0AkFGDOT6qLN8PUqTi2orzRlPCVeTsYt9WOgdKLqWHuPrZW+Qkuu0hRjXBvhlXHBuJwzaejIK2d44xkAMdj+VYK0E6tkBF1E/sXsX5yEBfkNZrTE3djwKEIMnJH6EbJtBG/mCPiEIdKrXR/trUbujAKi3VrOmJbZpa43Aubb5j/0I9CeVf3S/oXd2jCaDkfZVAVsLw2CyxOOrCH5zR+BkrCwpGe7lS5zbhSKzU8pfexMb6L11Ct+ThsPC2f9CnR7w0z//cJNuV5M7n2RbD4L0sGXuU48rO6whJWnzDxW6CNkZQhBT37fpdkmDARdL893YHhuIYPfXjR6SipYWNivh8RUYSDLXRhQTs++zFeshzZIfPo4RRRIx7bZyGNXpMQ3JSCaSIzB1CLO+EmHKYPhP2/SS2g4O3Dczj+9yD38RDRks5qkArFjZAJ6iFjY0s4jzesMSWQdwRG+K5ULspUSdSBGwgK5pbLcEWpbK2S4Y3DU/Golf4yyB2h1GcgOFApm134mro9FPdZkENyAieeACLnLtax1AaWSFAMulQReDrbA/kuVPO0FOOcB/Eiri/bCzj1e/gqA2ZDhxP08s8Uhc5F7ZLDd40Ht1ytF7uZSFN2I0pP1cTy5ZLz5Wo8SpGoPA9B2JKqcyZ1LErgKvCad1whaV44ekEcbLDecu98DBVYNymCHWZDTjPHhPRAm3Y1XsJpLpymgRzhVi++u94=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR11MB3668.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(346002)(376002)(396003)(366004)(136003)(451199018)(66574015)(66899018)(33656002)(2906002)(86362001)(6916009)(76116006)(66446008)(66476007)(41300700001)(122000001)(5660300002)(64756008)(52536014)(66946007)(66556008)(8676002)(38100700002)(478600001)(83380400001)(7696005)(54906003)(4326008)(38070700005)(55016003)(6506007)(186003)(53546011)(8936002)(26005)(71200400001)(316002)(9686003)(32563001)(414714003)(473944003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BLlPkDEjrY9Wb6/TLTpsteXUZ79YQ23m5AOlRC+S/2616yUwFD3dGac83zpL?=
 =?us-ascii?Q?d78yLeMil2nP8C3+6sRumqtZkMGlB/KMRXtif33oVLwMc1oJnYBItNvtn0gx?=
 =?us-ascii?Q?kmZW7Lk8KlomoyJ+f2PehbgaQSC7FVPbQrTmg6wcGDU3kGf4AbdHunaNvmLO?=
 =?us-ascii?Q?I9hKk0ehg52lxIFpnUM2pv9ic/If079E0Gq8tKLuTq8gDxZwoWUhopQ3E2Tf?=
 =?us-ascii?Q?4EgAPqxXqIAhghD/z2w7C+D9vSNa4XSmjZkPhzuIZo7lWcPPPMC2xTH2BnVy?=
 =?us-ascii?Q?V63XXu7PQxn+qLo/HlNIH/ml3MGBZb/oflIbiQjtceXQzkcmSilB+lMsgcsh?=
 =?us-ascii?Q?Q7w/NW3wgZYcW9Kk8rEuYu/f+56qRBSU8SC/uPn3YvA4ErTUnmS93uo/5oPA?=
 =?us-ascii?Q?t4MHPq0t3nWoBYl0QcXlkUmQqtDfrurdLJZsWkwMCxiYqRtwORg5z9abyEco?=
 =?us-ascii?Q?zCG0FceNPdsrdwk1eIFzitZZ+4jPAFYn/CYV5yqadxBHJQtMFZ2QCwJAmYrb?=
 =?us-ascii?Q?w5ginXgxvFitRRO+PEsefNZ13jSOz564msoD1tX3bOJUHFlsskqqDzDB6Nx9?=
 =?us-ascii?Q?ZNM+tvqCEgKOYdHl8FpMuA8GUEsdn4dSwIJf6p57mCsAhq6pD/odf1pqwVEe?=
 =?us-ascii?Q?U8qZcnsM1ZMEtr5M5L75xQaGkHxSLJH/Ous2MQ8KcPRyttTZ2PsaDeqESfIO?=
 =?us-ascii?Q?T7a407/XDcotSsJY/cHaweoaatx6xctb19GsnPzTSeT1e6NRWN+sToeS/zVq?=
 =?us-ascii?Q?OHOXRWkWH1c+wHjXwTf3tXZwftehf+cKVRG/z9DpVFznZD4sTHaUKHy3RWPb?=
 =?us-ascii?Q?yf6Eyv8o+RUsh2NV/GcrFpt+CDDLD/cC/aBlySn/qJJI3r/a6JX//JzpWlMg?=
 =?us-ascii?Q?JoShJTl7WDpF1/+fTX/3KvAF997TgSXjY6XhB+l718rcWzkhBKeAaFgdOP7C?=
 =?us-ascii?Q?vsEyaSDaAHXLT6myyG45pG5MZ0hSQW0DnOv2dOQWw742tE31G2ihl9gBQe3V?=
 =?us-ascii?Q?VgGyhJcv+su/9mEqpMgvLyytdrwZZGUblyhn17PRC1vc0DTEt+QLhQ8Pz/Xw?=
 =?us-ascii?Q?+ZQm7pc5mNpuSi1Vk7HL3Lpw5S3tccWDkkzfxr948qa2iJ2Tr+EZBYukl8s5?=
 =?us-ascii?Q?lPwqE1kdSeWn4vepuM4pIMAk6eIZu+Z9H5a1TqaHedu4CZy4cOTtQ5vdwZMo?=
 =?us-ascii?Q?ZsPtXAK6D5wGEcStWCL06xbuJXxlZhNIfsEfuJ757OPz5Oo6RwAhJvz/Iho2?=
 =?us-ascii?Q?AAMQsCNnT2PAoVKE1xcCe89cDrXkJRz+6bLTKfeKbeW196cY/ZslV3GYasmx?=
 =?us-ascii?Q?R5i6tkFfcdrNC4ND87YdzVhF1TlvURJI7Rv3tXZHcvW4Pv0qB77Fl4nL0hDh?=
 =?us-ascii?Q?96gDQyFuT3LR7pSdMqPd0Vs5BMziJzwitm/1JXzLSkwxQIdmg0NSrLvSZ3mn?=
 =?us-ascii?Q?VyUBVAowfYTsuCFgY/K5WwTflST0jn3IR9z6diar8DtSDfuKU3yfujw6Tgqw?=
 =?us-ascii?Q?euPLG82na/BFGhKIecGeAjUiP2eytunIKgLJx5+aQ6F1UA7YV1oNN5+eXWWb?=
 =?us-ascii?Q?7ObH7iKXgSadjPTy//TTtVNdmnEJv7kQbMluXCIrDANMXTTKnqTe3NQ7qIiS?=
 =?us-ascii?Q?F166LgmpIs3L0c6B1WNwd0E=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR11MB3668.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c70131d-aac8-454a-1182-08db10126d2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2023 11:39:12.9779
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bT0druDaZ4TGCtMlWUnpukGmzVSGJtRm9aE69oonETuQT2Lf+BlpAJvZGduSCkFg3w8bwDoyJIPUxvXxDptqMkohilimNjGrEFge6Y4y1AeI9vR8YX2dLbJUdRPPEg2D
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7339
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Wednesday, February 15, 2023 5:15 PM
> To: Kumaravel Thiagarajan - I21417 <Kumaravel.Thiagarajan@microchip.com>
> Subject: Re: [PATCH v5 char-misc-next] misc: microchip: pci1xxxx: Add
> OTP/EEPROM driver for the pci1xxxx switch
>=20
>=20
> On Wed, Feb 15, 2023 at 09:56:46AM +0000,
> Kumaravel.Thiagarajan@microchip.com wrote:
> > > From: Kumaravel Thiagarajan - I21417
> > > <Kumaravel.Thiagarajan@microchip.com>
> > > Sent: Wednesday, February 15, 2023 3:18 PM
> > > To: Greg KH <gregkh@linuxfoundation.org>; Michael Walle
> > > <michael@walle.cc>
> > > Cc: Tharunkumar Pasumarthi - I67821
> > > <Tharunkumar.Pasumarthi@microchip.com>; UNGLinuxDriver
> > > <UNGLinuxDriver@microchip.com>; arnd@arndb.de; linux-
> > > gpio@vger.kernel.org; linux-kernel@vger.kernel.org;
> > > srinivas.kandagatla@linaro.org
> > > Subject: RE: [PATCH v5 char-misc-next] misc: microchip: pci1xxxx:
> > > Add OTP/EEPROM driver for the pci1xxxx switch
> > >
> > > >
> > > > On Wed, Feb 15, 2023 at 09:20:10AM +0100, Michael Walle wrote:
> > > > > Hi,
> > > > >
> > > > > > > > Microchip's pci1xxxx is an unmanaged PCIe3.1a switch for
> > > > > > > > consumer, industrial, and automotive applications. This
> > > > > > > > switch integrates OTP and EEPROM to enable customization
> > > > > > > > of the part in the field. This patch provides the
> > > > > > > > OTP/EEPROM driver to support the
> > > > same.
> > > > > > >
> > > > > > > Why isn't this driver using the nvmem subsystem which is
> > > > > > > usually used for OTP and EEPROM?
> > > > > > Michael, these OTP and EEPROM memories do not have any fixed
> > > > > > location registers which store values (Eg. mac address, config
> > > > > > parameters, etc) at fixed offsets.
> > > > > > It stores a bunch of records, each of which has some data to
> > > > > > be written into the device's hardware registers at different
> locations.
> > > > > > These records are directly consumed by the hardware and
> > > > > > interpreted without the involvement of the software.
> > > > > > Therefore, we don't require any OTP / EEPROM register map to
> > > > > > be input to the OS / driver through device tree or board files.
> > > > > > I only had to enumerate two separate block devices using the
> > > > > > driver so that the config binary files can be overlayed using
> > > > > > the dd command.
> > > > > > Since this is not fitting like a conventional nvme device, I
> > > > > > didn't choose the nvme subsystem.
> > > > > > Please let me know your thoughts / comments if any.
> > > > >
> > > > > So this is only for provisioning. i.e. during manufacturing a
> > > > > board which uses this PCI bridge? There are no kernel users, nor
> > > > > is there a common interface towards user-space. But just some
> > > > > block device (why not a char device?) exposed to userspace. I
> > > > > presume there is a companion userspace application for it? Why
> > > > > do you take the extra step and have a (random) kernel interface,
> > > > > you could also just access the PCI device directly from
> > > > > userspace within your companion application, e.g. through libpci.
> > > >
> > > > Yeah, why not just use userspace, I missed that, thanks!
> > > Greg & Michael, I do not want to expose the entire or even partial
> > > set of device registers to the user space access directly for safety
> reasons.
>=20
> But that's all exposed here through this block device, right?
The block device created by this driver does not expose the device register=
s to the user space applications.
The device hardware provides separate set of registers to read and write in=
to the OTP memory and EEPROM.
The driver uses these hardware registers and abstracts the programming logi=
c inside and exposes the only the memory as devices to the user space.
I don't have any user program to program the device. I use the Linux dd com=
mand only.
If I want to view the contents of the memory, I can use any hex editor tool=
 in Linux this way.

>=20
> And this is already exposed to userspace today, no need to add anything t=
he
> kernel already provides this.
Can you explain this? Are you referring to any sysfs directories / files? W=
hat is the necessity to do this? I am trying to understand this.
If this is for any debug purpose and whether kernel does this under some co=
nditional compilation or is that the default behavior?
Even if the user is a super user, should he be allowed to access the device=
 hardware registers mandatorily. It should depend on the policy the system =
owner want to adopt. Right?

>=20
> > > I think hardware registers shall be accessible only through safe and
> > > robust kernel mode components and that the user space shall only be
> > > able to access the device through the kernel mode services.
>=20
> Again, PCI devices are already exposed to userspace today, what am I
> missing?
Are you referring to any sysfs directories / files? What is the necessity t=
o do this? I am trying to understand this.
If this is for any debug purpose and whether kernel does this under some co=
nditional compilation or is that the default behavior?
Even if the user is a super user, should he be allowed to access the device=
 hardware registers mandatorily. It should depend on the policy the system =
owner want to adopt. Right?

>=20
> > > I want the user to use the hardware only in those ways designated by
> > > the driver.
> > > We were using the "busybox devmem" to access the hardware registers
> > > directly and to program the EEPROM / OTP.
> > > But we understood that it cannot be an end user solution in all
> > > cases and based on some of the operating environments, there can be
> > > some restrictions in opening the direct hardware access to the user
> space.
>=20
> What restrictions are you referring to?
I read some articles in internet that exporting the device memory + RAM mem=
ory to the user space presents a few security issues that need to be dealt =
with.
I assumed therefore, exposing the device registers to the user space may no=
t be the default behavior in some operating environments.

>=20
>=20
> > > Please let me know your thoughts / comments if any.
> >
> > I missed one more important point. This driver is targeted not just for=
 the
> manufacturing environment.
> > we want to be able to update the OTP / EEPROM when the device is in the
> field also.
>=20
> Great, then this really should just be using the firmware download interf=
ace
> if you wish to write to this hardware.  Don't expose this as a block devi=
ce, as
> that's not what this is.
As I said earlier, this device is always programmed using the Linux dd comm=
and with a 8KB file with "oflag/iflag=3Ddirect" option to bypass buffering.
Even though there is no standard file system, I thought enumerating this as=
 a block device would give easy access and quick programming time on ATE.

Greg & Michael,
I am sorry about the delay in response.
This entire week I am into some training sessions.
If required, I would want to discuss more to understand better.

Thank you for your valuable time and information.

Regards,
Kumar
