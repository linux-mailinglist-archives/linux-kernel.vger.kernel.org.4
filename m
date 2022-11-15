Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4F9262AFB2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 00:53:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbiKOXw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 18:52:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiKOXwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 18:52:54 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0197DD2FF;
        Tue, 15 Nov 2022 15:52:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gI48pwUweW5LT/WKj0KXszXHYMAyCwfbjHREASitY9rlPIuJD1vvf46QPQ8fvrcppUITrZDtYnzSs/saUu4ovvS81JRZau1bZbL5jsGs/3tXVS0P9h9/yRtftdjapvwSKSrBO/M3OBAhOajw/QJGumbH+MeFzhsb/W8nKrhMWIUIRiL2fCoxHTqawwAbkONS8HZ9QoDYvtvp9cN1vNzQzJTz45X/XPV5kzQlLJ9BmMk+MzpNb5WIkYX6gWzsxZSzMXGI2AKGuZFdoOxvFXCArHarDmCKI4d5RTo1bOjKGf9XEDmmisQAdpZ2cGmy57ewuEib1eAYVxSTblXzoinsGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=22NO8ngiErE4YOH73QhHucI/dwYmIALIZHIjUPzDMeY=;
 b=Bn07Or9eiqY2TG3QRGIwy94ZSGbCB0XcTbli6wsDMgMuhTdTgdRXL4di3g9DBe/Z+Kx7vxF0K3oTfOJY2u32lKigWjpHb8Xy7OlA7Yvb1tLWZ3XeljaYMFalkuQ2SCv+NaUjqvOxPD3cyENsG83+K4gJVuLilgQOMWKGyytowTm7kljK2AMstuTRFvd71ASV8DpHIvZ/zvla6GCxhApQmLYHr5bRCVmdD4fhkH5Ys6oW71MDTu6bXK2I0CzFDZpTL4nVpFaFVyEXN9R3m2y2VwtS6gY47bS95ful/uZnXknXpX74HHQKgj/zf80/3eu57XGpUipZdttOEl1e1rjY1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=22NO8ngiErE4YOH73QhHucI/dwYmIALIZHIjUPzDMeY=;
 b=kFxulxxoONhuCmKCeahvFOhsyLQ4oeaAsADJd7NCUEQxNSVpV7plBCEjoeYHhqlEuV0KlkGpPigUruoo3g7W7Wq3zE710FZS0H67+nks2XBi2yGrnafIq7dJcoMLU7C0SOZlUi3J40rWsZkm7Gd2cQ4MKQ4DcnjDbZjU8rSyybWuTLelcYnqdLAn6wj2SeD9a3wP6KFsNKlM3yplY7BcxHYw7zsBnOXOC6ORVhYHZRrPdufgfo/JkojEnp+PL7F+nSwOQJFD1uLeKDkw2RGw7QifQCqtOEiovIRlYJGhQtcKxFLshfGsyyn8VoxULnIQm0Iu8mjd9YKD9X41txoSRQ==
Received: from SJ0PR12MB5676.namprd12.prod.outlook.com (2603:10b6:a03:42e::8)
 by CH2PR12MB4246.namprd12.prod.outlook.com (2603:10b6:610:a9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Tue, 15 Nov
 2022 23:52:52 +0000
Received: from SJ0PR12MB5676.namprd12.prod.outlook.com
 ([fe80::46c4:5346:c449:9bd4]) by SJ0PR12MB5676.namprd12.prod.outlook.com
 ([fe80::46c4:5346:c449:9bd4%3]) with mapi id 15.20.5813.017; Tue, 15 Nov 2022
 23:52:52 +0000
From:   Besar Wicaksono <bwicaksono@nvidia.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Suzuki Poulose <suzuki.poulose@arm.com>
Subject: RE: linux-next: build failure after merge of the arm64 tree
Thread-Topic: linux-next: build failure after merge of the arm64 tree
Thread-Index: AQHY+T4w2yZkiIZ58Ua1lVlSj6Es9K5AqEEw
Date:   Tue, 15 Nov 2022 23:52:51 +0000
Message-ID: <SJ0PR12MB56762CFC0B8D680B05828EF8A0049@SJ0PR12MB5676.namprd12.prod.outlook.com>
References: <20221116090401.0cd5ccc7@canb.auug.org.au>
In-Reply-To: <20221116090401.0cd5ccc7@canb.auug.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB5676:EE_|CH2PR12MB4246:EE_
x-ms-office365-filtering-correlation-id: a6efa887-6d98-47bd-9a06-08dac7648220
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kKh2PL2266GGxbZdoSQVmt5yBtzJptkG5KYH/4VcDOrF3mXtQhuoht0mmHvnZfp5UHZcTSQV7fc9KJsdoETsVZxWtpnmMvjlMYcsE7/pZEuDIY2MD/tiie4keN3eFv30bEDRPFEIQVF80lRqAP14wN4HOCmUjBIma90M2BVL9TN5lu7buUY0f543Mm3eabltRhFHBAikVcwnX8vacmFr04A2PwoQ3hRoIfljfOBczJZolISGvO7dEP7rDKh4eT2Su5+EaDLuytW1FFp6kmhLhxHb56CUJ7qQLq5TaD3IJOok549uF57gLutSnUtJTHWI35/Xcr0Om2EfdUudw1aI/fOSYzkXe2BTiH5VxTqS5eilNTUUAY2zuzKPFihMDGLi8z6Xazuf26357emvOhMhaK4rYUDpeQUYopWlwYCoKczjTq/QZFjIYdaiFJqan23dScEDc25LZ11HLXyqyXL4Wq3tHCKHV8UEVGJIQr6PRktWpFISKUPme8fjCLLLTRJkGCZgsSaJbvOG2X3I6H5ZhSW1T5/omB+SF0Kl982ZrqK21Wux+wLjwSMZ+dbCJwmAIgUIlnT30obeQ8LGCh2b42iF9q0lTQH0Mw3Khs2KSU3Jmsh6v/Ahl+OlmI4aD19KcR8873Tp99bmy8BBL2H+y/3oGWmHZcSM/3hMz4Gn9Q/2/R7ETN+xBlEeYA3jbCJVR0itjuPLMzh6lFnzS2o3aq4Umd2Ja2neHGFGww9eWvHfvShqJiHvFqHlBrUCQK4HtZA3aGjs8SZe4QkEw2v27Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB5676.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(376002)(396003)(136003)(39860400002)(346002)(451199015)(478600001)(71200400001)(55016003)(110136005)(86362001)(316002)(53546011)(2906002)(52536014)(41300700001)(33656002)(38100700002)(122000001)(54906003)(7696005)(6506007)(64756008)(76116006)(66946007)(4326008)(8676002)(66556008)(66476007)(83380400001)(66446008)(5660300002)(186003)(8936002)(9686003)(38070700005)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HOSs8/LMmXMaYRMYm+eqz7pwO/Y9OV5YdS3/r3bf4M52ryibxrTJ3cQ4W6iS?=
 =?us-ascii?Q?MXKowZi+16t5FDfXsxYKu/4kCeH+m/eB8Z3z7RRG5BApQEbAJSCSJDhsr4Z0?=
 =?us-ascii?Q?ZK/XlZLyiL9FyhK9rBUTxSSUb6vhUNwvRV2TpLkpnynB1PqcZin1kodZuhDR?=
 =?us-ascii?Q?NSQoqDhGruRN2VS1l9AvMd0s5enjE1LB9onfYXS1N4UCALfyUlOdk6qbDXaM?=
 =?us-ascii?Q?dEddPHJHYYccOpQkKsx5C+hxCg5VXy1Sgd0ac6wTivz0dvUNH/xMeQeD7JCg?=
 =?us-ascii?Q?qK1iD8Bn7K3jF1C1qN97cOvVpId/rhBNsnmArFLlC4EG6UlgkfF+dtr4XQBV?=
 =?us-ascii?Q?76b4sehOjDjxWFhZA7C28xBHo2RQpGLttrHdElwCl6HbXV9+Y4Ytnqzxubkh?=
 =?us-ascii?Q?UTw8VqvFxr07lglCFOkkOTEL8dUuUBelK1DRkmiH5GiTHVoMs0uX43SxX5Hs?=
 =?us-ascii?Q?qf08nJHq9sxR28ULCIYrqYKCzvJlzW1Fdo5zts3s1BGQPJ7HySK0RoxJ7+kM?=
 =?us-ascii?Q?kAhUhWbnZ8SawqXXlylFqVn6C6VahZd8yUUxqCbaTVr/6IQLYdP9X1wEL7U5?=
 =?us-ascii?Q?qPHbMXNmcGAtDGCEX/lvkq5Af/umL84GRI7ntvW0fAmRnQJSjYuVtXyIaDfM?=
 =?us-ascii?Q?geceEOSFgGoAC7fWL7Y3Ra6suLVL79MjoaLNZQt7Exd9aKWjkb7SzbTpm7iA?=
 =?us-ascii?Q?pjaHHL/KrpdBzqCAGB0Uxa90Cn5fljJ7Ky+vXB66aihh0UDzqAyU+9uEbSvA?=
 =?us-ascii?Q?e6Zxr/FxDL7IrbmVGqOlc5EpUElWJNRQyjMZNoTarcca2RyqGXHcffxCfFe1?=
 =?us-ascii?Q?XE4S/CjAj1nRnKM44U4bODRteNWL/Ncvat32tMHlhWZ1sTgnzLP4Le0dsGmW?=
 =?us-ascii?Q?2c1dbtwOT0wrndoMvCeC9O64vmHHbpycsA9gUiOF3F61Tk2UiITz4tsdK1Xi?=
 =?us-ascii?Q?AbLa2g3ZcXif7M3kwqMrjcLcWXdn1JpqVVbl1wIjAicwSOQByxfPZLUOIKfi?=
 =?us-ascii?Q?qR26/3/ExxnwA1+b0JJtbB3pIpYpeq6YHckJx8vbYrp3FTA242ao2L10PdYF?=
 =?us-ascii?Q?tB6lYh0G1Hw8MVSK/092RBV0jw174F7stgIK/+FX9GaiPOxTXR0k5RfA8skW?=
 =?us-ascii?Q?pCxsghToPWLct6iC7B2bwezZeKeJF+q80nsxxQNxuVj6OwCFjfBvKS7ZoBUd?=
 =?us-ascii?Q?tvx3Bta78HRF78kEOIKnK0vEuGJfuwQXdU5uL8d0hXQyOGfgsR7Cb/poE2gf?=
 =?us-ascii?Q?FZbIVv+rGeMI/capFElC/AfDHsJQG8JboPFG9gjKbMkGLgSbOz2cf+RMuBrW?=
 =?us-ascii?Q?BzrSj0Yu4PFUa0ztClqQA+6sct1DCZzXnghghV+iAzSQrubNhDvIK8JyWqoZ?=
 =?us-ascii?Q?EnJZZGFui/ldEtmGWD3XMKx55LFkX43zpGSW7AYJcjY8ywH0LHuEoSmU0DdB?=
 =?us-ascii?Q?67I48JVaWysxqPqSL5v8fV8oKfFyyAwIWJdeyXPDI22Bx21ejj6uSNUwaX9+?=
 =?us-ascii?Q?9Myqqr/GI2IIjPeJDLvoUXTYAbSMGF0lyeMY/Vpk/3KFZTprvSZfS0+j8fLG?=
 =?us-ascii?Q?Ml1hLlUGTmh7THlbMLqRyaAT0xLy0MNs1DS0TSQV?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5676.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6efa887-6d98-47bd-9a06-08dac7648220
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2022 23:52:51.9553
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +YChEL2uHyP6wQNaRJv0h68WgP9k6Tr2lAY156PYiPSUurGiALo/ZTlsjE3OjSxu7s9Ko3QqifPwtcYLCdsheA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4246
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Sent: Tuesday, November 15, 2022 4:04 PM
> To: Catalin Marinas <catalin.marinas@arm.com>; Will Deacon
> <will@kernel.org>
> Cc: Besar Wicaksono <bwicaksono@nvidia.com>; Linux Kernel Mailing List
> <linux-kernel@vger.kernel.org>; Linux Next Mailing List <linux-
> next@vger.kernel.org>
> Subject: linux-next: build failure after merge of the arm64 tree
>=20
> Hi all,
>=20
> After merging the arm64 tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
>=20
> drivers/perf/arm_cspmu/arm_cspmu.c: In function 'arm_cspmu_get_cpus':
> drivers/perf/arm_cspmu/arm_cspmu.c:1114:29: error: implicit declaration o=
f
> function 'get_acpi_id_for_cpu' [-Werror=3Dimplicit-function-declaration]
>  1114 |                             get_acpi_id_for_cpu(cpu)) {
>       |                             ^~~~~~~~~~~~~~~~~~~
>=20

+CC Suzuki for awareness.

This function is used for searching CPU with matching ACPI Processor ID in =
PPTT.
I will check if adding PPTT dependency to arm_cspmu would resolve this issu=
e.

Regards,
Besar

> Caused by commit
>=20
>   e37dfd65731d ("perf: arm_cspmu: Add support for ARM CoreSight PMU
> driver")
>=20
> I have used the arm64 tree from next-20221115 for today.
>=20
> --
> Cheers,
> Stephen Rothwell
