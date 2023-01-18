Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0F95671AD8
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 12:39:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbjARLjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 06:39:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbjARLi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 06:38:56 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2053.outbound.protection.outlook.com [40.107.244.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EFD12365F;
        Wed, 18 Jan 2023 02:57:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aS9Dkanpf2eydn9tVRz7L2hox/GqB7cuM+dVJN/LYVPTYrxUnlOWsCfdCRsEIAP6kJ/XrVqat9QYvoG9XhdlY472aNlUO7f4CRLiRSNGs49HtEy/JH96xOnMa0JUnIb5Vey2yh1Obzpb/DIaRDtZwitlc4TY4NeTduLF2Df0OIri6p9qe/IIwDGykOQtto/G15MFWRK89O+ERWH6VwQ3w64Ud4az9YzXm0rsXts9QP5nA3x5lSV8LYJyvHPQN+JBscCrMhxIgW+QkPwj0niDzwc8KOhFWYpquGOq3paZMmwoHIxGol5dr9qIlVZ1Jck5VYYG0J2pG6yBdlJ5fM3yxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uOV9WmykFzY22rfu32nQMZ6/pyd8S6cbWc9sXkA9/P0=;
 b=f8YWiHGV/uow+dWgWq088eN2rAodlIMCAw0yufV2KG4vNIn/b9xqI4WUYQnO+SvV1RP7NrsKqKQxyPiayl9LhoJctlNi1fys79JbSGizuIkCQn50k7bc9lSsqOW1E++CKmrtOgjslwHLt0Fh2bPRkDx5usvnQMhYarM05M6dNPa+p/CQ2db+cEyLPfvsVGwKgeNa7s5mEYYN8oKtA4i3eduqtstuPyd8a8FZVEnSEATgjekT8LzqCj3B2CKbwmMqqihvccfFjOpO4pD1MOKxLWW9acy5i0LnJcL54PUzkMy4TzTJXYMZTo7DfmfILe4VNZsUZKoU6i9ol6lLbc11gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uOV9WmykFzY22rfu32nQMZ6/pyd8S6cbWc9sXkA9/P0=;
 b=Kc6hdlCx91rpvyTC0IQolozsXySAbKK46vjtxrCLUd5VpDkv3F22yut6iylqUSI0RbNNaViVpg4OkST1GXs4iXd8/dhclW7LyLukllXOk7bv1EDbKk9a0LViTMGn28AlCkF6427+XwhxjKBz6avv9jpHJaVfLf5ItoSPZfo3IuE=
Received: from DM6PR12MB3082.namprd12.prod.outlook.com (2603:10b6:5:11b::12)
 by PH7PR12MB7161.namprd12.prod.outlook.com (2603:10b6:510:200::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Wed, 18 Jan
 2023 10:56:34 +0000
Received: from DM6PR12MB3082.namprd12.prod.outlook.com
 ([fe80::12bb:9697:46d5:c65d]) by DM6PR12MB3082.namprd12.prod.outlook.com
 ([fe80::12bb:9697:46d5:c65d%6]) with mapi id 15.20.6002.024; Wed, 18 Jan 2023
 10:56:28 +0000
From:   "Gupta, Nipun" <Nipun.Gupta@amd.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
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
Subject: RE: [PATCH 01/19] bus/cdx: add the cdx bus driver
Thread-Topic: [PATCH 01/19] bus/cdx: add the cdx bus driver
Thread-Index: AQHZKnmCjxCOIOBZ9k2Vsnzl39LOTq6ipP4AgAD1B4A=
Date:   Wed, 18 Jan 2023 10:56:27 +0000
Message-ID: <DM6PR12MB308253BE2951700BD7F43013E8C79@DM6PR12MB3082.namprd12.prod.outlook.com>
References: <20230117134139.1298-1-nipun.gupta@amd.com>
 <20230117134139.1298-2-nipun.gupta@amd.com> <Y8arhmVo7LPLuxqr@kroah.com>
In-Reply-To: <Y8arhmVo7LPLuxqr@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-01-18T10:56:25Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=1487b8af-c50d-4d9d-b5ce-0ce04214c99b;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB3082:EE_|PH7PR12MB7161:EE_
x-ms-office365-filtering-correlation-id: 97dacf63-7bb2-4ef2-c3f2-08daf942a653
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WfmkyZpRyv4SEQd3ZMd0fr5QM8eqy6ggrwbDQ31U9YDTUJAoYl+L5tKyqTslDJjjRaGf5mLm5HDt0BDp8Ye57ZMdUa6cI8xmJFcdxuMHXcK3aXNk4dfoIxqve/NBvjWxpDUF1KeDTBw2STIN+fYEAtXvkpDpqpHvaqrpbDJLTkc7e35FkeRHQLgdtUW6UwKTNx7qpg6aQrKmQqexsOzBRArfr27V/R2w8icI0tijnTg/rM6tYHkZIUbhVPVwLEvxSC9LWi0BbhuQax98LGJTewh2h7hADFpOLPKzoV4Z5/Q2PMU48stjZzN1RHp2WZ9vjG4OXAlJR21Li0acA3gWNlUzRa6jz6hbD5MwsB8FfU//ZWLXRAydYzN6wuX0AemXyvEKqQVmoMMEQwtXDaKWsvs9jAKdpS2hLzg+rXSbRn51h1rK0fQohsbmlVZudtJ5pzqQytHds5fzaKppfP5WMQLSz7Fa5RySL5Imvacs5j0xz8bM9X/FDV5vECQ+xEqZ5J/JN6Sywy8C7Kv9wbkYAytQwdauhFO1d3WVV93AdGByouQjWYmWbcM7j8Ife99qFAGH+FhBcPQQNoMLtS81lYxSf8c1OT4Dg836BP6oeU0GIkuuQs+rXUh1zsn2q+6YbE6+C6g2u4SVEfnY8Ea6C4DU0sqiHZdNRiO4V8IxpV/zq9EZNZYud7qkVprlfn/yFU8HGAKXh0q+zdrWqTwgKA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3082.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(346002)(376002)(396003)(366004)(451199015)(83380400001)(38100700002)(66476007)(122000001)(33656002)(38070700005)(86362001)(8936002)(8676002)(55016003)(2906002)(4326008)(7416002)(5660300002)(52536014)(66556008)(6916009)(66446008)(76116006)(64756008)(66946007)(41300700001)(53546011)(26005)(9686003)(186003)(6506007)(54906003)(7696005)(71200400001)(478600001)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8smYDMOdef58u0xumKWtpkaScs1CLIBQqp2JLiD+JV7Wxr8CyclBPGIREGBL?=
 =?us-ascii?Q?0lR2WZH6FR8ttdxITHs2d78rwutJYodJwkLkupplaEmA1VLQn5COQ/9pjo0/?=
 =?us-ascii?Q?hhab11IXrZLYHkKt3eTByWoUmDChZcwr/N+U15ff0VvwiVl1gIgrJQhGaFtq?=
 =?us-ascii?Q?vEvQZp66Tx6pOp4Do7MzTGbZSFmLV17gembunvtfO3CmAoH5BE/Mzfy9Qa7Q?=
 =?us-ascii?Q?6LiHnunmwuXy2T3It9BMab3LCxRVA732HElseFby/mUSCHZfmGA/V7gnsjyp?=
 =?us-ascii?Q?43j+44RQKnmCmMQ3Sjv85MNqCFSCo8Xipa7e1r5VSl5Ommuu33Wdsvu54Ayc?=
 =?us-ascii?Q?G+SuXzqenVytUZk04QS4UY0tAJQJvgvKPzSnKQ/uAmRYTGzfyJDs4tUzsNyr?=
 =?us-ascii?Q?9pIaQz8q2H8hp73VdFsgqMNk6/H0mhBjY+Uy4NWJgc4kcsXYQ+QN88OLX/a0?=
 =?us-ascii?Q?ichSMRqaLJvO8Q7gvFznkL5ld9wnmTeNdta71dj1W+D09/My41w/q/omqdNN?=
 =?us-ascii?Q?WXhCSKomSVn0GdoLMKgwaLDBQ3cLtWVMLimqcHkptnfIKHi3dOzUy6pyrswr?=
 =?us-ascii?Q?q8hWUpLjaelJxKZseGmkoW/w7t7DCeVLXBKQJ30FxvyPDdjaIm+8I/gul0+x?=
 =?us-ascii?Q?QXIzb0AfDwRJK80wUIifo9Sa1VHKYFSgrcS4sRKnjOfzbcA6GBNpbe2zVStD?=
 =?us-ascii?Q?rSCrXiKGUALnlb/U0gFlqqnSkNbsN4YUqk14D36HEZ7apf4qPHvn1r+qvdeq?=
 =?us-ascii?Q?aZNml4bYfUZLijEo8OEuTXrUpf270zGBx56eU2d65Q18ye2cKWwH8G+7z87n?=
 =?us-ascii?Q?eaNO2abBV4hzZ3x04vfJG+fhTJpQEN8sLNb15hSax9n3+DLA6AYC+Ghkzt4g?=
 =?us-ascii?Q?Frsoysdyk3Jbah07MsQQWWO1W1hqHsltEqtNTZTkK/jwS4MjNC2dOQz8GmHU?=
 =?us-ascii?Q?sNd2UBLsWzwsb75oCPtQVHhRrKqpiRaIWyaaT9PfHs4PC9OmOTt+gmTjikeJ?=
 =?us-ascii?Q?9CRdyOiVYl+BQ9S3xa2Sd4IU/bYAZNWcAQnZn+6d4t5/o6zVw+ndjBDUSx2I?=
 =?us-ascii?Q?ClUJLGapjIjvWsUOEdOPxhXCaIJaOvm+EkhD/lfY9pjZ3Cjhun21vUSLTDtA?=
 =?us-ascii?Q?eDFtu6ll2d+Sls5BFzp9Pe2JMoKfS7/1F49NagyOaVdGwUpv/Q5Nn0CI2uxd?=
 =?us-ascii?Q?IUzsgdWK8ki4SvB1gIO3ofAXX48O5Wk1Eoaba+N9QRc0mQQOW4yxnpJIKBaH?=
 =?us-ascii?Q?TgXSK+X4gqzF3egCPGpWF6Q9WhFyfgm548dlXEIk7Edz4SiDMdSYp0tuSC7d?=
 =?us-ascii?Q?k0eMGgJB8niYKEBJ+osYSsU+GAyBaR3AR8wFWu8SS3gmMET9WMa94jMASdhk?=
 =?us-ascii?Q?VOpJIk+Qo2+XAgXi8tFucaMmZmKOliG7EoCiPlYI2eqeVMfEiYfjh2QBafGl?=
 =?us-ascii?Q?/6uWz86952gDUndP8CM9QRNCbobPbV8+KIFocKwChwOfdQtMCfvywKOPQtn1?=
 =?us-ascii?Q?FRjwWGwYBxMsmqqUhap0BNa9DUERIskMCnVKODHsE3yfJDn1DLyvLqv8N9y/?=
 =?us-ascii?Q?pXDdDSp3afI3HQcJEtQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3082.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97dacf63-7bb2-4ef2-c3f2-08daf942a653
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2023 10:56:27.9386
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XtNg6KZkKCxZ2cjg3TQETWjadtWV1QONk6ey0I8CjTOqIvdlIjw63yzp6TTyNGcs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7161
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[AMD Official Use Only - General]



> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Tuesday, January 17, 2023 7:37 PM
> To: Gupta, Nipun <Nipun.Gupta@amd.com>
> Cc: robh+dt@kernel.org; krzysztof.kozlowski+dt@linaro.org; rafael@kernel.=
org;
> eric.auger@redhat.com; alex.williamson@redhat.com; cohuck@redhat.com;
> song.bao.hua@hisilicon.com; mchehab+huawei@kernel.org; maz@kernel.org;
> f.fainelli@gmail.com; jeffrey.l.hugo@gmail.com; saravanak@google.com;
> Michael.Srba@seznam.cz; mani@kernel.org; yishaih@nvidia.com;
> jgg@ziepe.ca; jgg@nvidia.com; robin.murphy@arm.com; will@kernel.org;
> joro@8bytes.org; masahiroy@kernel.org; ndesaulniers@google.com; linux-arm=
-
> kernel@lists.infradead.org; linux-kbuild@vger.kernel.org; linux-
> kernel@vger.kernel.org; devicetree@vger.kernel.org; okaya@kernel.org;
> Anand, Harpreet <harpreet.anand@amd.com>; Agarwal, Nikhil
> <nikhil.agarwal@amd.com>; Simek, Michal <michal.simek@amd.com>; git
> (AMD-Xilinx) <git@amd.com>
> Subject: Re: [PATCH 01/19] bus/cdx: add the cdx bus driver
>=20
> Caution: This message originated from an External Source. Use proper caut=
ion
> when opening attachments, clicking links, or responding.
>=20
>=20
> On Tue, Jan 17, 2023 at 07:11:33PM +0530, Nipun Gupta wrote:
> > Introduce AMD CDX bus, which provides a mechanism for scanning
> > and probing CDX devices. These devices are memory mapped on
> > system bus for Application Processors(APUs).
> >
> > CDX devices can be changed dynamically in the Fabric and CDX
> > bus interacts with CDX controller to rescan the bus and
> > rediscover the devices.
> >
> > Signed-off-by: Nipun Gupta <nipun.gupta@amd.com>
> > Signed-off-by: Tarak Reddy <tarak.reddy@amd.com>
>=20
> First off, very nice job, I didn't find any obvious issues with this
> integration into the driver core.
>=20
> That being said, why do you want this in drivers/bus/?  Why not
> drivers/cdx/ ?

Thanks, Greg, for taking time out for review and providing your valuable
feedback. We do not have strong affiliation to drivers/bus/cdx so will move
it to drivers/cdx in the next spin.

>=20
> One minor comment to make the code smaller:
>=20
> > +static int get_free_index(void)
> > +{
> > +     unsigned long id_map;
> > +     unsigned long mask;
> > +     int index =3D 0;
> > +
> > +     mask  =3D (1UL << MAX_CDX_CONTROLLERS) - 1;
> > +retry:
> > +     id_map =3D cdx_controller_id_map[0];
> > +     if ((id_map & mask) =3D=3D mask)
> > +             return -ENOSPC;
> > +
> > +     index =3D ffz(id_map);
> > +     if (index >=3D MAX_CDX_CONTROLLERS)
> > +             return -ENOSPC;
> > +
> > +     if (test_and_set_bit(index, &cdx_controller_id_map[0]))
> > +             goto retry;
> > +
> > +     return index;
> > +}
>=20
> Why not just use the idr/ida structure instead?  That will handle all of
> that logic for you and get rid of your bit twiddling.

Agree. Using idr/ida seems more appropriate. Will update the code
accordingly.

>=20
> > +/**
> > + * struct cdx_dev_params - CDX device parameters
> > + * @cdx: CDX controller associated with the device
> > + * @parent: Associated CDX controller
> > + * @vendor: Vendor ID for CDX device
> > + * @device: Device ID for CDX device
> > + * @bus_num: Bus number for this CDX device
> > + * @dev_num: Device number for this device
> > + * @res: array of MMIO region entries
> > + * @res_count: number of valid MMIO regions
> > + * @req_id: Requestor ID associated with CDX device
> > + */
> > +struct cdx_dev_params {
> > +     struct cdx_controller *cdx;
> > +     u16 vendor;
> > +     u16 device;
>=20
> Are these in little endian format in memory?  Or native?  Or something
> else?

While reading from the hardware, these values are little-endian; and
they are converted to CPU endianness by the controller code using
le_to_cpu32() and then passed as CPU endian while registering the
CDX device.

Thanks,
Nipun

>=20
> thanks,
>=20
> greg k-h
