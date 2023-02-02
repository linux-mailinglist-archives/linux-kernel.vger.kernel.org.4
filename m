Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0458A6874C8
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 05:58:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjBBE6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 23:58:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231617AbjBBE6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 23:58:34 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF2032412B
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 20:58:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I/za+c/9eEpB1M8YIA8j4nGUJdv0CZFT1K0n8syZAAx3ksvRwj5adGQeKgcPYLNBvH7TjDoTCf/6QyQPYCSCQOm24xgp0dbwzww92W2/i/HliRpZxe5TTLU/TWlFbS+m5RyP4kk0Zv3Gl79nzA56fFEUFPRUSqWbSfx/B+gDHR19lvB+vRjXkpQTEz95raMTh85VkdTmQ3DvmztRTG8xHc+aLPJYPPgLR6diXwjS0Mp5oG29PeGwS77FteTaaigouEu2pczDMxNEze/Auav3UNPPaaq/Pb1HOrJ3BNYgvwG/Rwxv723/oNX4TlKVh1kDHbb4wPnsSaP/bxK9tEAyiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rk2uNVE92RX2UYiSS0SOKJH3C/kzbkazgqni15wgco8=;
 b=Qtbw90OxDOEbNbiRuFNHJWLHX2GBFNDWFlhbrvH7I8TRxao2W2onfBjAw0YxC7tGwSGvQ4FxYLfKDzDD4XgbuJ3Kc2hYRhw6JkeFVknPZW9LIOormIvthx6b9ayl5y9Lz+6GWOkpex3Qg+J+f+NyhwO0Xlq37BBgAMKzETxKayUlVEqvqzH8pc/3IdUWEx3r1DgJ9mxella+Rd6fh+SL+ShyZTdb+umEvi8zxycEdYMv6Xhrkl3QmZIFA6HXtLbBxkgmeoN8fzow/bvyHEPDK5krftzAQWWeiT5Pz4pE9NbvZpXradMGhFnK7FrZuWdO2sfpyeYpmlDsNf29W0AgrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rk2uNVE92RX2UYiSS0SOKJH3C/kzbkazgqni15wgco8=;
 b=er3InxOfiaY0BeU/XWJtLJIG9xInqKHsNcWzwRAqpX26TfQWJGOzQiqMK4KL8idFcHL+P8E2uljnYCg6Q6czyOwTAunf4xerRVkHdBUl1y8EEJ4PnMjXB+lYxejbzjCQfGq37n/JCda0+aurMbofRep41GJ/O6iZkv/poldXRrLC0f4YiTWVfV5Dlmhg3dbvFYiBZ3UHUVJQOfnaRznsWPWFagTZHyddK1EPRDlgXdI7+/0IcyGc/GDCV+qCQoSG8dmcEoDZp2cn39jYMBxdpLj2UOfVMzP7r4oHzlJPgRDc4AoKUbi+4Az33hPCCjVT+mvOi22Xq/oqfVcr05tZ5g==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by SN7PR12MB6910.namprd12.prod.outlook.com (2603:10b6:806:262::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.27; Thu, 2 Feb
 2023 04:58:31 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::a891:beb7:5440:3f0]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::a891:beb7:5440:3f0%4]) with mapi id 15.20.6064.025; Thu, 2 Feb 2023
 04:58:31 +0000
From:   Parav Pandit <parav@nvidia.com>
To:     Si-Wei Liu <si-wei.liu@oracle.com>,
        "mst@redhat.com" <mst@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        Eli Cohen <elic@nvidia.com>
CC:     "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 2/7] vdpa: conditionally read STATUS in config space
Thread-Topic: [PATCH v2 2/7] vdpa: conditionally read STATUS in config space
Thread-Index: AQHZNcrt16j1tjEdlESo1L34RWyIYa67GkzA
Date:   Thu, 2 Feb 2023 04:58:31 +0000
Message-ID: <PH0PR12MB54810E49707E9C06F177D24ADCD69@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <1675207345-22328-1-git-send-email-si-wei.liu@oracle.com>
 <1675207345-22328-3-git-send-email-si-wei.liu@oracle.com>
In-Reply-To: <1675207345-22328-3-git-send-email-si-wei.liu@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SN7PR12MB6910:EE_
x-ms-office365-filtering-correlation-id: 154fe27c-531c-4b56-16d0-08db04da21a4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yUwGAI+sw/F/1zQPL1uTk3yS4p6nKL1SATgjPQdm1WXsSJFaYDxN8Dz3dBMozxHMXZibN/KWXTD6YjzoqTGO5xinQh1MIZx/FeDfEcD6Dw1QEWDjNPej/ZqOi0hdhAWPV2DlTpbvudGlPMFLE7JMeZqpECwo0mL2lfMF/y2QcM2CZ/LcPwLB6FiXhmXAx+sSsdTWbBZKqmc+sLaUy5aWp8lEa6h3dqv5fkqyfrGjBMFkY+KC42Y+9vmr+1BcN9sSTaCqiS6tLVsfaWu8+eW/46L7GdkpkjbKBpoKI8bpmCszFCgtBxuJh5mVFigHowbGd+nljXN6x98fngk7ZauyVALOY1n40KlhNafHK+97XPRH2YLnu5OyTt65L3f+0+SZd84iwBciib3FhscgMYyGqjYcN+tYdIgRy54tWfO/Xm96kD12X+exequNOMZaPlYOwErdr2K57WZJDiUSva1fZjYbi4g966eyAjvDPD6BGB7oSW9jwZTB95LXeFtPhTyPpxFFNcvu+ounV5WTZGq2nVf8/5h1hFuctYfP8AGpSHKs64cRrAhy2Qquar1hFDCqbKO1xWQDyULhGfb7GiNPW60O/ym9Da3JkEuoJUj+OeS5SCC5rEwwsjay7Z/UN1FBeBPl20A7on8qlG5DIF0sBpDMQbaiK0F103mHyOZnbH5kC4tlEY/MrMl+sx8s+9h4xe3l32sJWsX0Koiom93Jjg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(366004)(376002)(39860400002)(136003)(396003)(451199018)(55016003)(41300700001)(26005)(186003)(9686003)(6506007)(38100700002)(54906003)(110136005)(122000001)(8936002)(38070700005)(52536014)(2906002)(316002)(6636002)(71200400001)(7696005)(76116006)(66556008)(66946007)(83380400001)(33656002)(66476007)(86362001)(5660300002)(8676002)(64756008)(66446008)(478600001)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+Kvii9ohilq3G/cbe6RhSU+WSys2LdAAsfYBu7t3KHxmjRoAFDrodsmryEWr?=
 =?us-ascii?Q?/NczVx1Um6SlPMxDgrvJZhmulll0wekvXONER7piJ7vi1CQEx7h4GF60/vc8?=
 =?us-ascii?Q?qyrcIt3n+E68O8gEhvYxF39H+e2KPfNCIg8wdYOebTRxtHbWn8BhJL82T1eG?=
 =?us-ascii?Q?3f5hGfVUcGevUtNh7S8qi2O+e1yj4ANAJhrvDdtpOodAKHL6ZrqqSUDmGcoQ?=
 =?us-ascii?Q?xBOxaEpGDz162YU9NnNbvxhCzLR1k6tdGca8lqMH0Uba/ebhM2Zaqu11AW6k?=
 =?us-ascii?Q?x998yS+mX6hM6AI8scEb5m78Wm0F0Azz+XCe8fQwACUSLq9RwGqsg42Mo8Ia?=
 =?us-ascii?Q?jPaGymNygdJTKDG6hbrRLo08qCaU2At33/UzmIvqfegntzmRJB72s0THVU4+?=
 =?us-ascii?Q?1gkbArz717hvZBhgr4ZGoiZqPcggL/RwywXADlefYJYQAnnXUcoaS1FhHv/s?=
 =?us-ascii?Q?/ZO1hvXpDSFCLhYpdgrU4JyHqcvPZD+PUE/yO13DBn57hExfx+BfYgpRjrop?=
 =?us-ascii?Q?GHZieebtOxqAswNfnnth/qreCbiIHsxXHF/Ce8sXpg33PIT7K+nbIOlRF2xv?=
 =?us-ascii?Q?F6ZtOiFVmUY25wpkabgxC9AFRMFEtMxn6AVEe/Lg+PPjTgtlJes31aogwRRj?=
 =?us-ascii?Q?uzGXh1nqK32Zd57HmoTe2bD98HN43LboAUaXI99y9/pfv1jzB+otu4Z6h/X+?=
 =?us-ascii?Q?MDnIN4v3a74YcMTTmKFG+DYR91XJL35Wh7nMpHp8Z+GkG7goXDAQdz8iCizv?=
 =?us-ascii?Q?ZR8LhohTBG5DPPMmBSCarPLRec844bXQRT5+8FHr2PISrLqqQalVS61rNxPS?=
 =?us-ascii?Q?CuJrM0BXdIBbAhTB8qh3KI7QiVdj3shbXn7HOCLojC1+snQpYs0gaLSvI4lK?=
 =?us-ascii?Q?t53AfFtkZ8tqT6gxTLE1YjAemcdR9xyZF5icxs8ptgPpF9FP7HfR5WnXOE3f?=
 =?us-ascii?Q?4rmn9plhz6N7bBXENBoN02vQrnLTwvnEwv6dciNimV7Rb3NLOPSYXOaRkZnr?=
 =?us-ascii?Q?d8dKN/RGQC7DV6/1kMGGu7x/b00srVBCsuhU4KFZlbxrg3GChGGwUTxzmbGn?=
 =?us-ascii?Q?60pk38rCmzF/zLOc36GmEPp6ST39W0UeCuK2sN6lAnPbBqW9QNW9aOQ9h6oi?=
 =?us-ascii?Q?cuoK1uMJnCorHnbNMkFFhVkCJ+KUJTDv6NkCPydekS7HtNta2mtQaWn78P2H?=
 =?us-ascii?Q?7HE9UeppeXjIOsUlCgpAE5RCbOR/u/eXTNMt+41KBUjmzsLN1ffhfivKBfPd?=
 =?us-ascii?Q?PEpxq+BFklK4/eSzx8UKuKapucOcx9VbIPwyXWZbFu3MMb8QViQe/Dsz7dXt?=
 =?us-ascii?Q?wQ3x40n4yLn4wHCboNOQY/SykrcZEMMSZlX+WfjCTsptEV8SaZLFwBlF33Gx?=
 =?us-ascii?Q?BhTjPuajMbZVixsTpuXRatE4FLuzPems/Mj+k6RMI2uYEhI3IIpEPifULFE9?=
 =?us-ascii?Q?ftr05dodmM4iPwGPkugqnIrtKMfqPvHF0NAEHBeEkFPKRMtlIC91Sk5Ym/DN?=
 =?us-ascii?Q?PHmkIhAncTN2u7F1XfUCY7KFgwF9XxlP/U+6ZVamKPxn7QlvTJgw6q9GZ9+t?=
 =?us-ascii?Q?vNpWh6h8ecg2O0fqNbc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 154fe27c-531c-4b56-16d0-08db04da21a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2023 04:58:31.6528
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TjgjzcG6M5uSMr1pPHzTzeSLmv1NCTF+WAaCaPYKcXyp8c5Vk33fFHqtEKuUZ9clW/+NHiBpYCXoG6wi/5ab1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6910
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> From: Si-Wei Liu <si-wei.liu@oracle.com>
> Sent: Tuesday, January 31, 2023 6:22 PM
>=20
> The spec says:
>     status only exists if VIRTIO_NET_F_STATUS is set
>=20
> Similar to MAC and MTU, vdpa_dev_net_config_fill() should read STATUS
> conditionally depending on the feature bits.
>=20
> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
> ---
>  drivers/vdpa/vdpa.c | 20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c index
> 3a82ca78..21c8aa3 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -843,18 +843,25 @@ static int vdpa_dev_net_mac_config_fill(struct
> sk_buff *msg, u64 features,
>  			sizeof(config->mac), config->mac);
>  }
>=20
> +static int vdpa_dev_net_status_config_fill(struct sk_buff *msg, u64 feat=
ures,
> +					   const struct virtio_net_config
> *config) {
> +	u16 val_u16;
> +
> +	if ((features & BIT_ULL(VIRTIO_NET_F_STATUS)) =3D=3D 0)
> +		return 0;
> +
> +	val_u16 =3D __virtio16_to_cpu(true, config->status);
> +	return nla_put_u16(msg, VDPA_ATTR_DEV_NET_STATUS, val_u16); }
> +
>  static int vdpa_dev_net_config_fill(struct vdpa_device *vdev, struct sk_=
buff
> *msg)  {
>  	struct virtio_net_config config =3D {};
>  	u64 features_device;
> -	u16 val_u16;
>=20
>  	vdev->config->get_config(vdev, 0, &config, sizeof(config));
>=20
> -	val_u16 =3D __virtio16_to_cpu(true, config.status);
> -	if (nla_put_u16(msg, VDPA_ATTR_DEV_NET_STATUS, val_u16))
> -		return -EMSGSIZE;
> -
>  	features_device =3D vdev->config->get_device_features(vdev);
>=20
>  	if (nla_put_u64_64bit(msg, VDPA_ATTR_DEV_FEATURES,
> features_device, @@ -867,6 +874,9 @@ static int
> vdpa_dev_net_config_fill(struct vdpa_device *vdev, struct sk_buff *ms
>  	if (vdpa_dev_net_mac_config_fill(msg, features_device, &config))
>  		return -EMSGSIZE;
>=20
> +	if (vdpa_dev_net_status_config_fill(msg, features_device, &config))
> +		return -EMSGSIZE;
> +
>  	return vdpa_dev_net_mq_config_fill(msg, features_device, &config);  }
>=20
> --
> 1.8.3.1

Reviewed-by: Parav Pandit <parav@nvidia.com>
