Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36DC96EFC2D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 23:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240033AbjDZVHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 17:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240032AbjDZVHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 17:07:11 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2072.outbound.protection.outlook.com [40.107.93.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF8AA3C03;
        Wed, 26 Apr 2023 14:07:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GAMYC7wp9r9PNYx2JGoXJaWVwZtCL29YbJ6Zg86RlMDVrbtobkhds1rqUHwpGRMjVZf5ktXgYQTbPlMf+PpasNA3Gq1W8Gnw0GXsO3Q+Kz+6VXfkP0xhxCtOGcruG1aCK/+eNLeFcPWSQQzaxSfqfjcukCLfkfMvIr2SsrBOTHqOax346bgOEBxytNw+jTmcUgTALkJmgUYlQbVlPk3HX/EUZgxg/pVsO6EPKQm4slEFj/esQDRYK/dz2PxsmXtkrTrrFSmbx/vp90qicrL/KWxazPyY/QmRauFmSam9HNe0XAt0tg5kfnV59weqYKHPC/kdxS70YDVubdrTbgOoig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EzOfOAkiYAkBgvnhnCqkM2ooXXNploLB62vwbuw17Sc=;
 b=Bi/TZ5PEA1xtYJpdSYWIH10LcOSoDQnJQa6kqyIzLbbb7NLJv9vrOkPhz/DIY0GmJIogcrsM9seyhVX5lYHrNM/ZV2dBxudaLg9YZd96Oy3J5CUq7YOGe6ViSmc5O2NoH4Muz5UAo+UBz+oBsOsDyGSU+X9/OljwHTbeaRgB/7pFvMf7iNbUgVEwF+GqbRusweIsGlwQPQclp+mQ3nuVgDNz/c+TB8WXtj95nvKzLUwYilA4LGvuWG+NzP0S0zWb1HrMLrgSxTfQwe8DrDhU7kZA3TfiZClGW37NfvLZHZAsJVBd+WcxRlZhcANkd+hrykeAyeATgbY24JR+5zjzSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EzOfOAkiYAkBgvnhnCqkM2ooXXNploLB62vwbuw17Sc=;
 b=UUqi+uDaF33XPObauP0IWxYnByFNpZacaL4buwZ3fx4WSciiN6a26v48Cysut/QT3uyo6c0/nqyyfSxBsvGjavrdaKq7KYYkOCvb3DgNd86xzwwY+qiG7g7stxaEs2IUs1SGwXSOvgL4+CiTzk/2Kem86WeDz9i5WcXJpTPzNQc=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CH2PR12MB4183.namprd12.prod.outlook.com (2603:10b6:610:7a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.34; Wed, 26 Apr
 2023 21:06:57 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3f45:358e:abba:24f5]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3f45:358e:abba:24f5%3]) with mapi id 15.20.6340.021; Wed, 26 Apr 2023
 21:06:57 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     Armin Wolf <W_Armin@gmx.de>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "markgross@kernel.org" <markgross@kernel.org>
CC:     "prasanth.ksr@dell.com" <prasanth.ksr@dell.com>,
        "jorgealtxwork@gmail.com" <jorgealtxwork@gmail.com>,
        "james@equiv.tech" <james@equiv.tech>,
        "Dell.Client.Kernel@dell.com" <Dell.Client.Kernel@dell.com>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC] platform/x86: wmi: Allow retrieving the number of WMI
 object instances
Thread-Topic: [RFC] platform/x86: wmi: Allow retrieving the number of WMI
 object instances
Thread-Index: AQHZeIKmrj6QHMU2Nk+x4k6HWHlasK8+FOrw
Date:   Wed, 26 Apr 2023 21:06:57 +0000
Message-ID: <MN0PR12MB6101B03167C55AA342FE69F8E2659@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <20230426210349.100838-1-W_Armin@gmx.de>
In-Reply-To: <20230426210349.100838-1-W_Armin@gmx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-04-26T21:06:55Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=93472a36-a240-4514-a56f-d7ba508e2457;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2023-04-26T21:06:55Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 7d68fcbe-81cb-4cac-93d3-55998c8af81a
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|CH2PR12MB4183:EE_
x-ms-office365-filtering-correlation-id: 31733033-1998-453e-61e8-08db469a2bb4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0P52qTlfhg2f7vbLq98AU39mwRBnDcRfy1/vRN0zv5VZ7JAE+phuG7f+mrXleGv5n1D7wi15xNACaXe2f6ol3glBeGbl574foltFnkID9susOUNCbB1zzzRnb8VTUyFlL8ozr97vG6C6YW6ANBpZhF6M1eeTiI5HZNQ5I1XjrHOEATLtUpkt+Jhn76lDjC//WwWE4Jm/VGoBMF4+9xZs4wXLs0oDPhCH9IFEdoVUco9dZj0PQZVHu4VFp+zSFRScuTYzRL051nwr3Ha3mL84LVas6xynrUUOo1aj5jPhQwIapeCA3u6Cvo9bezMi0E8C4824WWT3HskcxOitdZkuJq8JBH/DBvOR+aMmtThk3pCisT9F2+gs1sMwZdFe9avbeUQpZXPzMaD5PAs6jjj/6hhpNnbun99AOt8LmsIhuGphev+TN3BUM9/YIe72XeJfIsR8lKN/unzlz8wc1zcV2WykSdBLuh0h66bFHPJKJn0xRTQg+zj0BqY8KOWUNjs6XqoLHy2k3G1xcd88Y5SNzsbdqSB8tjTMIll7HSGf+P8tfYyX6kTcLed3nrbeGzzTcGvJRoQTwMo9ugAoprDlWxFBf9RTvuizuZl3NLYxehMdGSwt/eGnvv7d1Yl84WLa
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(376002)(346002)(396003)(39860400002)(451199021)(38100700002)(186003)(76116006)(66946007)(66446008)(66476007)(64756008)(4326008)(2906002)(66556008)(41300700001)(38070700005)(316002)(52536014)(122000001)(5660300002)(8936002)(8676002)(33656002)(7696005)(71200400001)(86362001)(110136005)(54906003)(55016003)(53546011)(478600001)(26005)(9686003)(6506007)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qF6RVtjHiup2Ialhu54dur2jskaSlbeZ2yC2IM56toAHCb7MJkNhEGMjkeqO?=
 =?us-ascii?Q?7QuB5/tDhBNinC86mqi2hTQvtNRWAL2gkCYCUoNCUV+ZAcNhohTYgua6ANj0?=
 =?us-ascii?Q?Fy0NUWSqwVUm9dgxY398CygSagMCraNaUySgr7y2KywaXJDOKQgc0KxAMZhM?=
 =?us-ascii?Q?DJCoLEoynoWFBFaEGoi1abnQz457uVWbicRxWdnUQLuID8UjWfmAeno+dhjX?=
 =?us-ascii?Q?9A9Z6rqlDwKpsY1KvPsgqFwommkcwDrhaOqaFgJgK39P1IlE/m410SRFAV5y?=
 =?us-ascii?Q?s9q8KnViW/+pOrgL9Rvz3HNfljaXwkTA7G/Z535EP8UIhyBI+U0ix9QIR9yd?=
 =?us-ascii?Q?YFKEa+9W9QhkBejHpxbXFXbzsC7mrT53utgPOybIlZoUlqs8OtN41KKewYS4?=
 =?us-ascii?Q?jv9TkpsrKfbeMf8YI5qwdIjp7QETwW/oEUqcHsLEIU5AVu4W8v+cR6GX6Mdq?=
 =?us-ascii?Q?lpRlULnKYnn4SWbtUL+a5OVRYIurpJ0r6BGXYgbO/CZI2rw38ZscqeZVP4rs?=
 =?us-ascii?Q?xRflBu+8V0S7E6B8UYy4scFCnxuga3Q537O5BB2OemxOq5O4zPxd7a3oU032?=
 =?us-ascii?Q?4AKDoRNlQ2aF6SLQ6zZei8Ly2QleY/ZfgLXNl4TZDmG1BpcS8uAe/B6QISRD?=
 =?us-ascii?Q?NVCKpkfgdb/GdcsxmCKnpDQuLT3VDj90XBxH+KxgNMeG67bXCxN57swDcSr2?=
 =?us-ascii?Q?8EPPcURPLR1h7AL+RYYjn48o68O/Q3b0JfY/fktlMVVrNdGbhXuCgLeG//y7?=
 =?us-ascii?Q?FfqvFh9Ve6yj/FEXMlFTt18PrxqozmJ+Uo1Ai3xtCV+UlYk0MeRhnZAz4pDg?=
 =?us-ascii?Q?H1fkC8ENX5yhjOwcdWHpJc9RIVrXSz0RpDY3AG735AAgkiPkIG9bZd2hneNy?=
 =?us-ascii?Q?N2JbKBE90Tww5GvqDp0MAaHWvBYM32XWRLsuxuBOOfV/pfAwtdHoLKgfqlHU?=
 =?us-ascii?Q?f0q9TXmOG18r/6Bc1R/fRP3Wa/du2hIbaPII+KJyinU4xs7+SrLSNu0xMSYg?=
 =?us-ascii?Q?EG6LnZxHDzLJBV8m9REUasnhnZ3XgTKqcdbonUrkmXZW4Cligqr83O/pnVrd?=
 =?us-ascii?Q?N9G0W7DJljAI9VVAy8+EsrZ5iJ5aqJrejPCa+enD1OPoGt4rpN7zuQ8SWMFM?=
 =?us-ascii?Q?n1WdYAQ3j+tjj/USYNaOZ4w4KFKNNhOYVedJyFOc7RPvlpkpT1a7nFzGp7UV?=
 =?us-ascii?Q?8xp0QR4ybdIEnzTs0ZWc2X3Ql2XLFqSnQDfSGXF7ZZ2FM6hvX3FgEPMwZURS?=
 =?us-ascii?Q?INVsVitdaunaB8q2U18z2tCuwLoZzoH5zNb9qOTYMiXpxuoWZeqEa2gNHBP0?=
 =?us-ascii?Q?aYl1I3wVCXy7bNTAdA6WYf4UAzpOmYp+LUY30gp2hDg4P9Crzmc8c1Ng5P3y?=
 =?us-ascii?Q?R/fp5RiNnTQzmfdYfXaYZfedoYxvjR1SpzdWYSpQtHk+yhN2tR11Yomojqol?=
 =?us-ascii?Q?CPrLdtLlH3g2h5v1pPl8C/TITzuC07eIPvz85s5AS1Ox22EyAjrvWv1v+OFW?=
 =?us-ascii?Q?Oj+qXmTFE1A9OOnHjG+Ie9CG0cxtcSzxnZseS59+/JzMebJskfm2++UxvC29?=
 =?us-ascii?Q?nj8VMhHhwauP0yQvJDE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31733033-1998-453e-61e8-08db469a2bb4
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2023 21:06:57.4700
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ug1451Cu1qxeUFXG8zq0pKZ2ExGzlmKPeYyDv/cVBtlt/enDONqBR2avRzjcfa3Cr1Cqm0KEE9O65zOl+y6RzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4183
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Public]



> -----Original Message-----
> From: Armin Wolf <W_Armin@gmx.de>
> Sent: Wednesday, April 26, 2023 16:04
> To: hdegoede@redhat.com; markgross@kernel.org
> Cc: Limonciello, Mario <Mario.Limonciello@amd.com>;
> prasanth.ksr@dell.com; jorgealtxwork@gmail.com; james@equiv.tech;
> Dell.Client.Kernel@dell.com; platform-driver-x86@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: [RFC] platform/x86: wmi: Allow retrieving the number of WMI
> object instances
>=20
> Currently, the WMI driver core knows how many instances of a given
> WMI object exist, but WMI drivers cannot access this information.
> At the same time, some current and upcoming WMI drivers want to
> have access to this information. Add wmi_instance_count() and
> wmidev_instance_count() to allow WMI drivers to get the number of
> WMI object instances.
>=20

Makes sense to me.  I think that you'll want to also update the dell driver
in the same series to use this instead.

> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---
>  drivers/platform/x86/wmi.c | 40
> ++++++++++++++++++++++++++++++++++++++
>  include/linux/acpi.h       |  2 ++
>  include/linux/wmi.h        |  2 ++
>  3 files changed, 44 insertions(+)
>=20
> diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
> index c226dd4163a1..7c1a904dec5f 100644
> --- a/drivers/platform/x86/wmi.c
> +++ b/drivers/platform/x86/wmi.c
> @@ -263,6 +263,46 @@ int set_required_buffer_size(struct wmi_device
> *wdev, u64 length)
>  }
>  EXPORT_SYMBOL_GPL(set_required_buffer_size);
>=20
> +/**
> + * wmi_instance_count - Get number of WMI object instances
> + * @guid_string: 36 char string of the form fa50ff2b-f2e8-45de-83fa-
> 65417f2f49ba
> + * @instance_count: variable to hold the instance count
> + *
> + * Get the number of WMI object instances.
> + *
> + * Returns: acpi_status signaling success or error.
> + */
> +acpi_status wmi_instance_count(const char *guid_string, u8
> *instance_count)
> +{
> +	struct wmi_block *wblock;
> +	acpi_status status;
> +
> +	status =3D find_guid(guid_string, &wblock);
> +	if (ACPI_FAILURE(status))
> +		return status;
> +
> +	*instance_count =3D wmidev_instance_count(&wblock->dev);
> +
> +	return AE_OK;
> +}
> +EXPORT_SYMBOL_GPL(wmi_instance_count);
> +
> +/**
> + * wmidev_instance_count - Get number of WMI object instances
> + * @wdev: A wmi bus device from a driver
> + *
> + * Get the number of WMI object instances.
> + *
> + * Returns: Number of WMI object instances.
> + */
> +u8 wmidev_instance_count(struct wmi_device *wdev)
> +{
> +	struct wmi_block *wblock =3D container_of(wdev, struct wmi_block,
> dev);
> +
> +	return wblock->gblock.instance_count;
> +}
> +EXPORT_SYMBOL_GPL(wmidev_instance_count);
> +
>  /**
>   * wmi_evaluate_method - Evaluate a WMI method (deprecated)
>   * @guid_string: 36 char string of the form fa50ff2b-f2e8-45de-83fa-
> 65417f2f49ba
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index efff750f326d..ab2a4b23e7a3 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -412,6 +412,8 @@ extern bool acpi_is_pnp_device(struct acpi_device
> *);
>=20
>  typedef void (*wmi_notify_handler) (u32 value, void *context);
>=20
> +acpi_status wmi_instance_count(const char *guid, u8 *instance_count);
> +
>  extern acpi_status wmi_evaluate_method(const char *guid, u8 instance,
>  					u32 method_id,
>  					const struct acpi_buffer *in,
> diff --git a/include/linux/wmi.h b/include/linux/wmi.h
> index c1a3bd4e4838..763bd382cf2d 100644
> --- a/include/linux/wmi.h
> +++ b/include/linux/wmi.h
> @@ -35,6 +35,8 @@ extern acpi_status wmidev_evaluate_method(struct
> wmi_device *wdev,
>  extern union acpi_object *wmidev_block_query(struct wmi_device *wdev,
>  					     u8 instance);
>=20
> +u8 wmidev_instance_count(struct wmi_device *wdev);
> +
>  extern int set_required_buffer_size(struct wmi_device *wdev, u64 length)=
;
>=20
>  /**
> --
> 2.30.2
