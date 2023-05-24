Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29D0270EF0D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 09:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240010AbjEXHIt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 03:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239937AbjEXHHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 03:07:52 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF992E62
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 00:07:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E4KM9X8acr83sgAzivlxQn+C4ghqF2zbLVyqY2laiK7/vtdre+PYMIOTheOa6BuSLHfZFnn91UgMO60VI4QAdV92ke1AoHl/lgY+u7SVfICh10VsVUjEjqjvQDvnce8TLwoVY/+vlWIg73zYLSLqXhTp504uNcrURCe11KELO1T7gPxYAu4gnyStqeevKpgK64kqyMSGhhzguLRh135BbhBMdLjSVUDwNXwMVP3/Vck13gmqz3Eo99ZN9WL3u89qZCImTpt8rbjHqsKE2xwYe2Xaa6EbJJCctlgi5AidoCEy9otvRRF+ZZEJwltxBAsBljjd/ePHpCiF4EK1HvNvQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E01teB8XDQModV9ev2I2QBYQ2Tq8jUNFlsNy7y1pTrM=;
 b=SPGIY1OKBmlCsBafOopTwFpQbdGGOArNdDZogm3iZNg/EHQidMIv5OcnD7ztGzR7h4lEmpKRu/Lo8nzZL1t5YiTeVMWFgn3AvyzRnTd1YnBu/Ua589CBWl2R8ud3aX/2lXWLkL6xSoOsGd2AbqArE/ukQ9T+VhcFQiNWkjVQin6Uyv/ccLDxrC+J/8F1iZCong1YU+qOaKVRAe/+o8LxiRXbGUJz2K0zVKlTArRtmtMUeOwFU1P5e+Mi5lDETBBNk4rf9FVjgkbw5j0/5/pJldlMlq0TVQPE0ymXU/qeYfnlwBN1qeAE2PuLfNce+d2jgFOy+cqfRCKonpPqo7cUug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E01teB8XDQModV9ev2I2QBYQ2Tq8jUNFlsNy7y1pTrM=;
 b=ZALENtRFnDqlq6gVyI5S3EhufTWz0y8fOFSmWtnYMrggSHifVtX7xvDvBfYxOmJ/qKpwUHmg775Dq1INneC0we45ETaGOeI0mpPTo+tYXYj7PHUZC6ke8V0mXU7jIPG5o8GCFESKkTc35m2aI7xp+EQz+TKmRJc4ErECQjkpPAU=
Received: from CY4PR12MB1912.namprd12.prod.outlook.com (2603:10b6:903:11c::10)
 by MW3PR12MB4506.namprd12.prod.outlook.com (2603:10b6:303:53::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.15; Wed, 24 May
 2023 07:07:08 +0000
Received: from CY4PR12MB1912.namprd12.prod.outlook.com
 ([fe80::277f:5dbd:47ab:647e]) by CY4PR12MB1912.namprd12.prod.outlook.com
 ([fe80::277f:5dbd:47ab:647e%11]) with mapi id 15.20.6433.015; Wed, 24 May
 2023 07:07:08 +0000
From:   "Gangurde, Abhijit" <abhijit.gangurde@amd.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "Agarwal, Nikhil" <nikhil.agarwal@amd.com>,
        "Gupta, Nipun" <Nipun.Gupta@amd.com>,
        "geert@linux-m68k.org" <geert@linux-m68k.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "git (AMD-Xilinx)" <git@amd.com>,
        "Simek, Michal" <michal.simek@amd.com>
Subject: RE: [PATCH 1/1] cdx: Rename MCDI_LOGGING to CDX_MCDI_LOGGING
Thread-Topic: [PATCH 1/1] cdx: Rename MCDI_LOGGING to CDX_MCDI_LOGGING
Thread-Index: AQHZiJvOc3wJM9X4lUSiCpFeMxx06q9eKPWAgAreByA=
Date:   Wed, 24 May 2023 07:07:07 +0000
Message-ID: <CY4PR12MB19121C024831331B71899CED8F419@CY4PR12MB1912.namprd12.prod.outlook.com>
References: <20230517084404.187463-1-abhijit.gangurde@amd.com>
 <2023051703-evident-repaint-52c9@gregkh>
In-Reply-To: <2023051703-evident-repaint-52c9@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_ActionId=bc016ca9-d159-429c-92b3-1b9d8675694c;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_ContentBits=0;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_Enabled=true;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_Method=Privileged;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_Name=Non-Business-AIP
 2.0;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_SetDate=2023-05-24T06:53:13Z;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY4PR12MB1912:EE_|MW3PR12MB4506:EE_
x-ms-office365-filtering-correlation-id: 81feeb40-d170-4e9e-b4a2-08db5c257cb9
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YNyaM5x9bqp//OayjoZoxYQW/39m28LSz9joAC9dIDrj2FMQml++Zjkat5znUKZxkJHd0p1U75oEYgAret3tmltzh5eEnrncq6Qlz5AytopbO5NGeVsB1ow01A2IA+r+D467P0B6URuUuORkuGpAbd61l+BrrS9p34EFbMAi479VDq1GFKAnjmn6IFx1WFncpUtJNbDnAihNQTc0/XJRzZddR7Wx+1YI4xjQjSkrF/Avhvyq11d/fX5u9Vb27rM42kJQb6GeYFcY4yeOKHAEi1hZfQryelLeyfJPNBeWrG4X/ziLjAt9Ht+tRZg8jTpAyKyBMHIXl1h9noAxyE/mLzmPJzdfCH17o4o8zA+9/yCk5qfRrRc/8MuXXlZAyz7p+1JAzcp3Vlp808yaFbG1jOP5H8ONW+yJiRz0tt+3wwf8I+wmwu3fonU6RINzfpNW7xdf9Ke0dxq6C6JFRQHoaKhQgE6xaQtK0Y3ElDE1nfhFRgr6VcsEL10ZrSK2Gs6SlDckk4374Bo3vK8aRoZRv62JD8uM9f0Mdc8mRzyDpwWfy80At6MhTOZ5hakddf0eu4B6wIfZCSQiH7sOZyindaNTInLezSV9f7rb0wyNKzKFpxmxr7CmFuN5a0z13wjd
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR12MB1912.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(346002)(136003)(39860400002)(396003)(451199021)(8676002)(8936002)(52536014)(5660300002)(83380400001)(186003)(26005)(9686003)(6506007)(122000001)(86362001)(38100700002)(38070700005)(41300700001)(76116006)(7696005)(71200400001)(33656002)(55016003)(64756008)(66446008)(66476007)(66556008)(66946007)(316002)(4326008)(6916009)(478600001)(54906003)(2906002)(4744005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UhiGFGknp1xSuOb+PWeCbOq1e27IDbrj9UxdLhuFSlbZAtUguEUjqBZ2ZA/P?=
 =?us-ascii?Q?pFwKrSIMqtmml1xV75OU78bHqPcuyH1+eVIHvvlCsDzuo5FeMsCr3lZLyoRq?=
 =?us-ascii?Q?L1L3bmKNpLeQiZ0JPwK1CZSXXiTb47Bi3MQcTDHXd2+edJ2XHRxqPQhy0mGt?=
 =?us-ascii?Q?U6YehyJlEtd1GyLfbfb1dTZyd/h2MxmsR03XmN5e7GfKxGqT3sqIckTVSKZi?=
 =?us-ascii?Q?dBZ9BSccDD7ruGHobFSCNbLAlGVTgsRisVCNv+QbgLPomtEPpZ7CvLvDsZRl?=
 =?us-ascii?Q?oI2lAP83szQdx9G/zQkOi8OuF4gzBVDoCAcszAIic6CGreHNQLzgCsRv9lp+?=
 =?us-ascii?Q?rJ2IKRGZzLoAV5MoanJ34t3hxzVe1nXbbM9ZGcjZ9DXdFNmVhVRXqxnhXWuy?=
 =?us-ascii?Q?dRf64o6mnAJ528tUVjuAKXA9zHg8hm2L0zP6r90VebbUcGIr/IiS3BDFB83c?=
 =?us-ascii?Q?AcRYBIyDXHtsPVqTDdTiNfTCnUmEwx3eBh9JmuBySjlqPmH7AhlWOlgPv09q?=
 =?us-ascii?Q?nRHEMGJ9Gf+JZcFMRzD+sfK+gWAnw5e5q9cdwqmHKDNIxrM4OmeK5JydmKeH?=
 =?us-ascii?Q?0srFhM3P78qiwjTXa1xCf22lFrVu5f8uoqNcLQwboG3F1Csb0sqRiJFgUgrF?=
 =?us-ascii?Q?j/Lcag4g4CiwmI00CwLZe01jRNdeuNbcJ+VvL9ZXM+BLnwDPC9qBjxM2TB22?=
 =?us-ascii?Q?FByqZ/2g1FnrSuRAl5UW71qpavSi0ZdzVhJq5J27v+UtDr3IF4koxJ6BcJyD?=
 =?us-ascii?Q?q5njIchVnCYHCb7Q/28Qon93zIcjViuu0TZtT8Lwb+TZhVsMbuey60E+B0rg?=
 =?us-ascii?Q?4tV0NJ5YRY4ApwpwBs656JaAH/FWPg0tPgNElS7fS7Uc3cEz4pZiCNGqrE9R?=
 =?us-ascii?Q?uYyuY7V+qUgkq2zyxWtfGfplg95oF09UajafNs2LjWXPiRlq/XZkWH1Lox11?=
 =?us-ascii?Q?WCQa/r+ilzmthTn7pzo4f9GwoMb8q5TmBR0ERYSQeojrZZ4AY3uBSuo51SQg?=
 =?us-ascii?Q?7/BWavCdVAN7A9ODXXOtsp3sxak3t1lPc16dwgkVaile6nJ247OTNORm0GWr?=
 =?us-ascii?Q?XrskzN+tKSBSfK3jGvGKhwerik5fQQsocV9+YEx0y6wb8UVBIHVXNjZlG9jX?=
 =?us-ascii?Q?ZQksnKHVDkhh4puhqTxYRpaLAgOC7GTODroy7hWmrMmul/IuBE3XomxK/M4d?=
 =?us-ascii?Q?76uB99GVKmE63LfcjonXw0cYj4hBfkGxb0Jxb6lp5E+LtpbuWNLRofQ8XnyR?=
 =?us-ascii?Q?96I7h9wy3q7+Qo8ifP/gFYrNlgoPYg+9oFzd6TBBHheUwNQ6TiVvOuGiBI55?=
 =?us-ascii?Q?l6sU7Y2Z0wDUAp2gEPJwjhbfLX3O8au/GRgp3AmcNaJzZPHz8TYY4aDqdhOQ?=
 =?us-ascii?Q?PoyEPDLoIe/xcXylpA6n8HWhw7HWWUcmKv6GQTZhYhsI3ofS3Cic5+uUoabI?=
 =?us-ascii?Q?AmiXTKzN3K4ESNmXIqUf1ejBnoP/u1VfB2bHr9Yu+LZb6CfWGHQNxPjE084F?=
 =?us-ascii?Q?q+3Df0uYmequOsp2uaR/1lzmurBJOt2gYY9YNIu458Hzwssdf3gaRt/gea/n?=
 =?us-ascii?Q?CmMArWzQOs+g5M/pQjs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1912.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81feeb40-d170-4e9e-b4a2-08db5c257cb9
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2023 07:07:07.8963
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2Jko7nAnAPH0GQq9RjEwgaleXHT9E+iYRL8SGxyVP38JtRjDULMAfXITKRPJJM6RvgkSvxnpsCQ+fX5PLa9fjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4506
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

<snip>
> >
> > -#ifdef CONFIG_MCDI_LOGGING
> > +#ifdef CONFIG_CDX_MCDI_LOGGING
> >       mcdi->logging_buffer =3D kmalloc(LOG_LINE_MAX, GFP_KERNEL);
> >       if (!mcdi->logging_buffer)
> >               goto fail2;
>=20
> This mess of #ifdef in the .c files is not ok.
>=20
> Please move all of this "logging" stuff out into proper .h definitions
> so that it's not in the .c code at all.
>=20

Sure, will cleanup the #ifdefs in c file.
Will also update logging to be controlled by sysfs in next spin.

> thanks,
>=20
> greg k-h
