Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 564FD75098B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 15:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233113AbjGLNYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 09:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233688AbjGLNYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 09:24:01 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2047.outbound.protection.outlook.com [40.107.220.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A3D1736
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 06:24:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XcqoiRxnls1/i4ohdH8CNSgxhlN25bJDV7TWCTg4pyeF5DD9ZU50Eh8LOIBpufDav+Mhv28rLkLwE4UTjHovog6Imc7OQ760dnw5pLizkVeXNVeyaboZlElbiLOO37jiDzlO7JBRZSQGRfNe+GuJkn+kFP5+onpxwb/ysvXO6r5836C8s51PDPt3Pan0Q8o8OPQnQpxviIUhA5Y4v6sT+/o36bgzrYtAgPZCwkBLWpvraYJtkkVYnE5brnnntc+HVKWYbgNDeVnqIv8kPfXGXEgfYVOFdzjuDr6vpkUSxIzbi7Cs7hyGg+vvilZgqCRwvfxd8uqe+EQrGL8NJA0hbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R1YORnNONHStUHIGjrg0oPm++i7IRRq2x16vnHNKrME=;
 b=PxbNIK48H+JNdzZTeBCKK/lFRukp5Za/vupAd944LMSQYoSqnHy+JfGF3V6XrKb2hoP1cvSbQfvVNQhcuAGatt17ldchlmhNZyJ2PlqzKJDw0DMFCT7kzL1cGKZyZtewjauZxbaDlW64eMN4JBuLtPJLgQgEM9+SVlddxbwL5vbaQvwNAV29MuYl2sgDLByGUzITUQUDrKKk0HM8kWy7wgBRnPoQq0G+xFMaPeqksLKGlqV6Z33RRNx6dIEZhc1DrCp23kD15k2ym2nyshYy6ecaWQJGQtPa8yb3qO1TpKlOWz/hp/jT/ZMZtHuoLhSBjf/spYxvSNcKJAlR5aSrVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R1YORnNONHStUHIGjrg0oPm++i7IRRq2x16vnHNKrME=;
 b=SgPBzzwjVStmjgi/UbyZbZ4QJecYRBLLM/+8tfNeaY3c9iW3g1xT8eYi+1lHCncW0ExMutbEnVANUdmVYd8rsbUetH62DcNhQ5GmjknZK6yq3XJk2PHsJKT3gnCWuauzktRK5zSO/rImdTyXJl4q8LVgprUn19rxrwJayFzZIeo=
Received: from DM4PR12MB7765.namprd12.prod.outlook.com (2603:10b6:8:102::7) by
 DM4PR12MB6303.namprd12.prod.outlook.com (2603:10b6:8:a3::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6565.32; Wed, 12 Jul 2023 13:23:58 +0000
Received: from DM4PR12MB7765.namprd12.prod.outlook.com
 ([fe80::8d98:f5c2:35b:e9ff]) by DM4PR12MB7765.namprd12.prod.outlook.com
 ([fe80::8d98:f5c2:35b:e9ff%6]) with mapi id 15.20.6565.028; Wed, 12 Jul 2023
 13:23:57 +0000
From:   "Gangurde, Abhijit" <abhijit.gangurde@amd.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Gupta, Nipun" <Nipun.Gupta@amd.com>,
        "Agarwal, Nikhil" <nikhil.agarwal@amd.com>,
        "Gupta, Puneet (DCG-ENG)" <puneet.gupta@amd.com>,
        "git (AMD-Xilinx)" <git@amd.com>,
        "Simek, Michal" <michal.simek@amd.com>,
        "Jansen Van Vuuren, Pieter" <pieter.jansen-van-vuuren@amd.com>
Subject: RE: [PATCH 4/4] cdx: add sysfs for subsystem, class and revision
Thread-Topic: [PATCH 4/4] cdx: add sysfs for subsystem, class and revision
Thread-Index: AQHZs/EtE5KWIbDMMki7B114CBd4nq+0mMIAgAF/UTA=
Date:   Wed, 12 Jul 2023 13:23:57 +0000
Message-ID: <DM4PR12MB7765D5B3FC16399E7A1428898F36A@DM4PR12MB7765.namprd12.prod.outlook.com>
References: <20230711121027.936487-1-abhijit.gangurde@amd.com>
 <20230711121027.936487-5-abhijit.gangurde@amd.com>
 <2023071144-reason-defraud-b8b5@gregkh>
In-Reply-To: <2023071144-reason-defraud-b8b5@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=80781d6e-b78b-4928-ab47-78059514ec32;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-07-12T12:54:22Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB7765:EE_|DM4PR12MB6303:EE_
x-ms-office365-filtering-correlation-id: 62909a12-65de-459b-aca5-08db82db3f8c
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FABeJYf/1QqqJkSZwQEFEC8DppI8KRpnjZNGmWvUxKCYMkzA5Bxfhj3/9JhvTmrs3hb08iqZU4TDxYENR3hmXm6k1KLdai/4QbkYbdY0DqF3lxZkNv2F1/7VLCY1djaXD2dPMJ1Mr+hDqC69w08M19GPosc2g485NR7+NZwg7csDFylQT7PkgbYFcUGb6Lxb0HWH/oT+qDgO1PINS7WwEF2JkI2AftmjgPtwAISRDdKeuWNkNTKxxxJZannMt1XsA1AW+g0EZclwC1dUgu/2oibpG7XuKOiPWE0KaBnpqLoBl5NdklrJSi+7M1DaBEfA2df25YKEMWa3n4DTiH/XFq+hWBXFx+gLvcVyBR9ddIYeC9Rr9RizUz7rv4+LrK8mv0RfD6VYmm/993Rv0BcFafior+hswnEEuDQtnOPP6T+pzWutuKKb66nEAyXaltpjWy1NOlT2PY7a1WbJdwncngYkQtI8CRmeO4QYzUFuxkRbdgFE+1DysM5/5I9m8Yuxv70s5YU828wO9mn4bvW4JzuE69L2sekOmXXlWaEZZH8Oc1Eq1yZWH6J3gRqxqYix5uk2XVKbI5B+czhXOHhy0MYfQzLp7Ghoynlxsk2rWLgT+kvfLfIo0uaaZNvjap8r
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB7765.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(396003)(376002)(366004)(346002)(451199021)(71200400001)(186003)(9686003)(478600001)(316002)(54906003)(76116006)(66946007)(7696005)(66556008)(66476007)(64756008)(66446008)(4326008)(6916009)(41300700001)(8936002)(8676002)(55016003)(86362001)(6506007)(52536014)(5660300002)(33656002)(83380400001)(38070700005)(122000001)(38100700002)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+tescV2k4oVM+UgQdGeFHr8lIHIuo5Xcxa4x2N51I7Vxu88WRaS25TyzxjT6?=
 =?us-ascii?Q?Jx8BT3AvmfMdL+ad6tAFDKO6pU39AepsPgv/f5WjgmZXo0MH5vK8pZAsmGw/?=
 =?us-ascii?Q?WFTX0dYDgW4azfOSFaTyz0pUXWKOUDpOdQRD6BVmmN0YY0uu6jura0uW7Z4o?=
 =?us-ascii?Q?5FAI9FYcwHLTa6QBRBcaOLoC0Brqv/nzg0pd6lcXymcXbMIbpCqqOR9AYrRu?=
 =?us-ascii?Q?m2urjn8FqAh1fkV2wuNUT5oARGZ3G4RJWAGe6TXB5gT/CdVha5GW5RtUVGlY?=
 =?us-ascii?Q?7LFBlAGpYtg5K7wAFdljq5HcQZ54JVMrYRLXR3avyQz91EEewCvxynKSY5xh?=
 =?us-ascii?Q?47UO+TprQRAaMZ5i1zUCn9/5XA/bGotj5+wiF4UwHkiyVKr78GCRfwds29w9?=
 =?us-ascii?Q?DiHD1ik6OkaIoYdPPGu3D5R8pXIgGL9CO5axk8I+WpayPjA9SBFzaON7PtvG?=
 =?us-ascii?Q?9Qad/HhHTTnu4yBV7Gbvw20SKV9d9ewT4CK7ZKtG+9sOls01GnAjy6ILRF+j?=
 =?us-ascii?Q?KJkb2196GDq1BzrzijBjWQ+GcnJiLRii7D5CQFhJe8Myw8GiAhWqHyrA7CK/?=
 =?us-ascii?Q?IJesd2wvjJL2Ckw/EXv0zZUtC2WJ5/T7vNIhle3r3VmIUyxQUHET1YHMx7Ur?=
 =?us-ascii?Q?wlvXoXq5eM3MUlxY6YjaDYY8n3sIJQZ5yV1qcxCEMD0Ce0QQYRSBT4yS9Thc?=
 =?us-ascii?Q?g5B7nVAaxcD5rhRrZS8F+muto6GrwpGBTYZW3VPB0h/IjLm09fn990QCA0eY?=
 =?us-ascii?Q?QQJUNwfS3Xa4oZh1ZccMpNeZt7OMxkTy5HvL8Y5L/0r+JEqlUAO7r0vi0eG6?=
 =?us-ascii?Q?gQL3n1Uldt/QTK4I0XUdtBPXeSIEQZ1CKWKSQjXt1kxuh9e/Tppflqh0wa6h?=
 =?us-ascii?Q?D6vOoZk8DN6RLhxwsu3SJBRdsobonWrxr3KKjgQEX8Ors/kqsoJUK+OGklB6?=
 =?us-ascii?Q?Asclhw3dohfP0wOD/+YaIwy1oRSlXiHV8Fc3GFuEoF74DcwfIlTgabx6LhQ5?=
 =?us-ascii?Q?IepAChYmfQxQhM0lxiYmqkEJzFsd/xv2BdKqeaRjFKWk4+qmIStZaH5ycOZB?=
 =?us-ascii?Q?dUbXJH5dwYicvq/pBoBVJgVtIMADrdEFji/5CoIhuKO/MKmZh+bPcaAnYXMH?=
 =?us-ascii?Q?16R7fbQg77/zpU3OiWWGhRYDWEC5mcCKKvMIzXVbHHDODgKYstQyJB8Obr0S?=
 =?us-ascii?Q?L+HoF/7OsCIWmz0IfxKjZFe6s8GqdBOoI4NsNLVmuLswhNJ5qSrAsIvzjJHi?=
 =?us-ascii?Q?8YkVMy/Qtqtea90u4u8FFS26+pLCkg7HUqyW6kXSKXEBOaF13gNLbF1V42aR?=
 =?us-ascii?Q?Yvb/hdyPCUDxsB8BRqBUVLzxzCBpDd6UwhUxV4DCPU3rtqh4TC7YxdqtgcbL?=
 =?us-ascii?Q?hmPijTm1DGGvaUzlLb54t0hZrGvTkbBjkIwg+BV87Y2Zuszmr4au81iYpSj6?=
 =?us-ascii?Q?ngiDtUctT+RNbrbL43ks5QzDIWgABXc/c2i2C+mC/vb97uVTuGfMPuCRIJ/h?=
 =?us-ascii?Q?4H2vyOmFu1YLGKzg6BOppmxdJAO1iDNSZXHTlbxPhvBWwjPBxddWhtLZ+rFH?=
 =?us-ascii?Q?jSLAJPYd25UZrM+KEoPV248ynBbHDn+jsIoi4F61OqrZBertf+1LzFC/Zny2?=
 =?us-ascii?Q?A77ltSkgssTSqshhrIB5Mtg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB7765.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62909a12-65de-459b-aca5-08db82db3f8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2023 13:23:57.8638
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mHN1Fuh3fHzupjZ1UO3jS46CUUJbRwF8GzC/FwqxyeQwBSwfJl08Hiovlmv6iJ+AumqdKatmF0WM0fxvLpapUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6303
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

[AMD Official Use Only - General]

> > RPU provides subsystem_vendor, subsystem_device, class and revision
> > info of the device.
>
> What is "RPU"?

RPU is the remote processor on which firmware runs(controller). Will update=
 the patch description in v2.

>
> > Use the Subsystem vendor id, device id and class
> > to match the cdx device. Subsystem vendor and device combination
> > can be used to identify the card. This identification would be useful
> > for cdx device driver for card specific operations.
>
> Why aren't you binding devices to drivers based on this like all other
> bus types do?

We are using similar binding to match the device to driver. Would update th=
e patch description in v2.

<snip>

> >  /**
> >   * struct cdx_ops - Callbacks supported by CDX controller.
> > @@ -84,6 +99,10 @@ struct cdx_controller {
> >   * @cdx: CDX controller associated with the device
> >   * @vendor: Vendor ID for CDX device
> >   * @device: Device ID for CDX device
> > + * @subsystem_vendor: Subsystem Vendor ID for CDX device
> > + * @subsystem_device: Subsystem Device ID for CDX device
> > + * @class: Class for the CDX device
> > + * @revision: Revision of the CDX device
> >   * @bus_num: Bus number for this CDX device
> >   * @dev_num: Device number for this device
> >   * @res: array of MMIO region entries
> > @@ -101,6 +120,10 @@ struct cdx_device {
> >     struct cdx_controller *cdx;
> >     u16 vendor;
> >     u16 device;
> > +   u16 subsystem_vendor;
> > +   u16 subsystem_device;
> > +   u32 class;
>
> What endian are these attributes?  Please be specific for all of them
> (also for vendor and device, right?)
>

Will update this in v2.

Thanks,
Abhijit
