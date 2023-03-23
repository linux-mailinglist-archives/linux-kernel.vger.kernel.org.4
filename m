Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7223D6C676D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 12:59:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbjCWL7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 07:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230517AbjCWL7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 07:59:22 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on20615.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe59::615])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B93919B9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 04:58:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AYYeq5BgSuseRbmzVQ55z9GLHEz8oxWLYikO4XQiHkMnmfzJzsGY3Hsd5EkeGOmFaojTwmQenbXnBHP4vq0065PU/pjeNxatE56MmA+VUaVh7nISWdmQs0UYDTueq+nD5hJrRau6obgrKzHZjhS4oO201mv+K1rm09E/YSVeIcCqjcnjuYVFJr+9i4K5j1MCK877oCgTQYysyIZhhuzh/yP2sYaCBQ3e4k0rA0FZG5RCNuyWY8b/WuAdLXO+whgWX2gwTa44hkFcsmpu5DIX7Vicsz0YCiNZfIU9ACv/St9Fi8BC7wGh67zAmkOXO5AHH8eqkbzBXCJEltaK5I9viQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BnsvHZ/6p1raD5QqSfNbk9GXxc1nvqfb7eK5CrIacTk=;
 b=bpAKocGh0ahUJ/7zU2EmvWjN5ESUrbyrMF/6mleRzLmsJYf7v5n/lDPbTSrOHGehz+wSqwS/Qg/UmGeNGYQ5deZ5LY1gkbQQnhcI3QaZbQuLKlGPPijmmEVoVVlDiERSesc/ue+397quTjunZJyra4lCO4QvB50qKIMlhYuAvZPcDhJ41IYTlLdeKwlr7KbyhWY57ZJzJWG2vbSFLl3uBQvyP+7Y4e6aMZAs/E2ckfUrI+ryw1Je9M660vPVw+1oePZxoL3EWplqXdrwZ+f/WRz+2eFSBaUQm6IrUT3HJHIdqYTSHw10F5NXu5M652fFDZwJ8PrIFFnXbdmGWrNd6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BnsvHZ/6p1raD5QqSfNbk9GXxc1nvqfb7eK5CrIacTk=;
 b=tcMzMkME847B4L/xgfQ+jm1ilXev/pISL6TZgDDhl3J5xL58rxZkQ4V5rX0CY6J8SL7bxzsIZhuiNg6GsnVRyMSwGkQDy6zQ+xe9rrXclWs+f4Ckc8glIc2nDPehio7W1EgQGETMc4TB6ogu2VAnXk+XASO6Q2iASxwSaazkZ0CwtJ/Y4BlUQ4Mdawk639JHgScPViI9ZaHJdX+GFBaW46tYLeWXIM2lhYz7RWit21E5RH/yXS+Hs6oKWyFfhmDBPtpU3SYzFjqFAVirEjj2bNGGVa7MvzmXHJcpRbT/SGa8wwgnTHeGfUTalnNKP6wlRJH+QBDT+LcqOQuA/cCijw==
Received: from DM4PR12MB5769.namprd12.prod.outlook.com (2603:10b6:8:60::6) by
 CH3PR12MB8583.namprd12.prod.outlook.com (2603:10b6:610:15f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Thu, 23 Mar
 2023 11:57:55 +0000
Received: from DM4PR12MB5769.namprd12.prod.outlook.com
 ([fe80::bca7:6774:36b1:78a0]) by DM4PR12MB5769.namprd12.prod.outlook.com
 ([fe80::bca7:6774:36b1:78a0%9]) with mapi id 15.20.6178.038; Thu, 23 Mar 2023
 11:57:55 +0000
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     Hillf Danton <hdanton@sina.com>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "peterhuewe@gmx.de" <peterhuewe@gmx.de>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [Patch V8 2/3] tpm_tis-spi: Add hardware wait polling
Thread-Topic: [Patch V8 2/3] tpm_tis-spi: Add hardware wait polling
Thread-Index: AQHZTL4LmmU2weVzlkGZavw5z7vfj68CRGuAgAYeA0A=
Date:   Thu, 23 Mar 2023 11:57:55 +0000
Message-ID: <DM4PR12MB5769823E40D7F2C15F8C2012C3879@DM4PR12MB5769.namprd12.prod.outlook.com>
References: <20230302041804.24718-1-kyarlagadda@nvidia.com>
 <20230319142737.2191-1-hdanton@sina.com>
In-Reply-To: <20230319142737.2191-1-hdanton@sina.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5769:EE_|CH3PR12MB8583:EE_
x-ms-office365-filtering-correlation-id: 754163a7-f6c2-462c-edc5-08db2b95d674
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +8kug7pMSKhaFf/qgG/jl2iyRFITMlaOw+wNrPs7ZBTax8LN2h1wghd3Zr52gA7Zc18wW7mzyJIR+63q1zR4V4lihUV5XoQGFwu8zfcOMTazWPa2KJQZZ8FnI08UZKxmtf5Vb3KdY8de6G4HeJHBy3Ks2PnJVvKInfjx7lss7M1zekY0cIKouMANnyM0+1cQsLGpGgEPsPPrl8hcpkc0ZEC8UPSyzcSuRrRKOdrvANtmntFT7fSg/9dQfDpZ/fCK7s6A9SfnTkKMrzSZMnGlskxIQ8kYLNMc2erF0Gnn2A3bYdik2g4lWrJL3hyHuXw+LD1XBdOIfpOYvH7lIS8iKB6PT4LqwgMbVsB9mRJ1pji/2fVUs2qkGrh4Ai9jLQxqJ6fD5yXJhvywYnYlA1iZPGr2ZgNKAJmkGojw9VCKuNDihA5tbxBpedDTLyIOy6GKOm0twviIFPkp0+M4cNogDaVkYr2aYwaBc3RQnmJaq5baJKFJZeuvASxF8DX8VloKSEcUuZplIwsN+wU3HZkXtyvK1BSYROcy0p/dfGAgyqs2UcVZ/WaX3BSw3EBMF6gu71eTamz7Z0PJtD/62cSJqz3jySf0STVUrh7ENWVT1WATf5Cx55Ch8BtlRYq3bLWxC8sEBRghXF1mFqFzvmRsLGcCQ6cBMUSWsUA4PdewOnr4HpKWpjkCY1DwrERXjhigxHZG2y9DDFWskTXNQgubmA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5769.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(366004)(39860400002)(346002)(376002)(136003)(451199018)(186003)(53546011)(26005)(6506007)(83380400001)(55016003)(86362001)(38070700005)(33656002)(38100700002)(122000001)(9686003)(5660300002)(52536014)(8936002)(6916009)(8676002)(64756008)(66476007)(4326008)(71200400001)(66556008)(66446008)(66946007)(76116006)(54906003)(41300700001)(478600001)(316002)(2906002)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?K9MRTGtrFT74MHZphDJJuZg2TWPL5gzqTc9Sz/9u45yZXZm0gqyaZEuDiIwK?=
 =?us-ascii?Q?HPYEExFyrImjVYSdWJDcWFKbjp1E+AGxor9bhqvvPB4bWgNVt7dMMOB59nKq?=
 =?us-ascii?Q?79GX2hjWIdGbtOoe7DwPnfKlQ+R65P/dr/TaWwnZgzw0kuCVGe3YJwW/RCSG?=
 =?us-ascii?Q?hBJ7OTq6EIw5xUSdEThU4EDOmRRTS2YLMut/yajzNzRpXhvMuqSIGPv5Ln+C?=
 =?us-ascii?Q?YfVNjqRblj2GmjmBeKnqgkQ29/A4jdOH9YFfYMmlGO/weU8M31yb5ZgPriNt?=
 =?us-ascii?Q?C4TXMYlFHO0pttHNgK4anPkXLSTLJNTFke+iP7jJ3Wun52YtXD36aUW2RHlM?=
 =?us-ascii?Q?pkSBzcjiSRUuYOaNuDGEb0aZ55Z9OLjXrrcvVxlyfa+asmIQ46TCudmNPx2q?=
 =?us-ascii?Q?is6zU8fWXMDJuIppWDIvrrIMdKCdyowxO33EGyms5+wa53X1dZWorNOewB23?=
 =?us-ascii?Q?Xk6aVktqV95wFsQcQM7w465kW+/UbcKM8D54/bSbpyMANc8WFDsZf+Drl+mX?=
 =?us-ascii?Q?7YjJ3g6Wl2zXsOQ7DX0jERVUf8Ofo65qNvjqjAfG59hRNOvVQg5rCerQOdhj?=
 =?us-ascii?Q?0pOpwNdcwqRqRI6nyweL5oqifT/AhCyePb6AAESl/rNQzTumdttLUlYoGz3p?=
 =?us-ascii?Q?yJebrW0u0t5SRsL5nvR+91mc3OlK3r87Nx5jB83aOMzbfKOa0XUW0YQu5YxV?=
 =?us-ascii?Q?tFZ63oAV3XdQpT4fJxe/ZAGV6mGFpgDCdlwBniRRIa4IFRrwIpitMxwfT6R7?=
 =?us-ascii?Q?HCYCBOH85QcaT+Jvdh5Ymgo6RTesZpWI7P8wmcLUiU/XVyrbhFjA+llJSoDJ?=
 =?us-ascii?Q?A6kSue2kA5b5WkBp0tDtIsJEHrCGbwEJClbY6YGlH2HphrtR5eIxE5iYkjq2?=
 =?us-ascii?Q?KETW26fQahAF483WE8l5B2P39JpUZuQn1QusRXy1OJ80ieMKLlkLxDDYIaCJ?=
 =?us-ascii?Q?vBDauKV1P8CB6xBLnmBeQ2ZudISrtat9ehnLklW+DHu/H3SDETwzzlk6l7h4?=
 =?us-ascii?Q?ULjVT2JfL5SBKOMKQFjzf10VWPcVvvE4UFFhetIGHvlugElajTUAVVO8x9JO?=
 =?us-ascii?Q?IolGoprfoyCS85+ap/9/tfl8MvmaD/cjklak+N9RulPJbfp3JTGhsi3zp6Jp?=
 =?us-ascii?Q?n5ygGkTV4cBnTM/lTwaOiwB3meJjoq/jsx2VvVWdyvX5hR8iDSgLdpG04IHO?=
 =?us-ascii?Q?Xc6urgws9Qb5qRTSrsHIZZPEiLwOWfLhBk1Sj4ax26JtKoJ2QcK2l5ELrmmo?=
 =?us-ascii?Q?CJ1SsjC8sCtr87rHHbVHnk0K3hMbqCbnX8esaf60YRddVzVpVALZyZN/bntJ?=
 =?us-ascii?Q?35ymu7LRC248WR5bl6RtbN/GhjBQrnkgBcBn0u2YY+rhauodUV4Ry5M1Y3gl?=
 =?us-ascii?Q?9HY2tpi02lOMH8SgL3Uo6R/CZRJ22dSB1NGxcNEfylUZcXEadoms/qlb4oV9?=
 =?us-ascii?Q?lsgmiHy8ZWJOB5Xrg/bzfScr9dN3NfeWlaVMBUVrtd6G7QiGiUhQpfcH8GIa?=
 =?us-ascii?Q?cJj/VqxxcYadHwWWhix7JnSvYq6+XSh4FYkuXenjdP+eTXLo7WyrmMkux7cQ?=
 =?us-ascii?Q?UHNBGOYw6BHrsn39F2mfHblx+/v6/lWA3wt+TZt6?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5769.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 754163a7-f6c2-462c-edc5-08db2b95d674
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2023 11:57:55.0697
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ADZ3S88u1VNIuYxBSOzShGNISnj0CEYze6jPOzFMnt2vTWdG0phtbJCu3zAxJHKckLral2dDGoVE01/TOgOEbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8583
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Hillf Danton <hdanton@sina.com>
> Sent: 19 March 2023 19:58
> To: Krishna Yarlagadda <kyarlagadda@nvidia.com>
> Cc: robh+dt@kernel.org; broonie@kernel.org; peterhuewe@gmx.de;
> jgg@ziepe.ca; jarkko@kernel.org; krzysztof.kozlowski+dt@linaro.org; linux=
-
> kernel@vger.kernel.org
> Subject: Re: [Patch V8 2/3] tpm_tis-spi: Add hardware wait polling
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> On 2 Mar 2023 09:48:03 +0530 Krishna Yarlagadda <kyarlagadda@nvidia.com>
> > +static int tpm_tis_spi_hw_flow_transfer(struct tpm_tis_data *data,
> > +                                     u32 addr, u16 len, u8 *in,
> > +                                     const u8 *out)
> > +{
> > +     struct tpm_tis_spi_phy *phy =3D to_tpm_tis_spi_phy(data);
> > +     struct spi_transfer spi_xfer[3];
> > +     struct spi_message m;
> > +     u8 transfer_len;
> > +     int ret;
> > +
> > +     while (len) {
> > +             transfer_len =3D min_t(u16, len, MAX_SPI_FRAMESIZE);
> > +
> > +             spi_message_init(&m);
> > +             phy->iobuf[0] =3D (in ? 0x80 : 0) | (transfer_len - 1);
> > +             phy->iobuf[1] =3D 0xd4;
> > +             phy->iobuf[2] =3D addr >> 8;
> > +             phy->iobuf[3] =3D addr;
> > +
> > +             memset(&spi_xfer, 0, sizeof(spi_xfer));
> > +
> > +             spi_xfer[0].tx_buf =3D phy->iobuf;
> > +             spi_xfer[0].len =3D 1;
> > +             spi_message_add_tail(&spi_xfer[0], &m);
> > +
> > +             spi_xfer[1].tx_buf =3D phy->iobuf + 1;
> > +             spi_xfer[1].len =3D 3;
> > +             spi_message_add_tail(&spi_xfer[1], &m);
> > +
> > +             if (out) {
> > +                     spi_xfer[2].tx_buf =3D &phy->iobuf[4];
> > +                     spi_xfer[2].rx_buf =3D NULL;
> > +                     memcpy(&phy->iobuf[4], out, transfer_len);
> > +                     out +=3D transfer_len;
> > +             }
> > +
> > +             if (in) {
> > +                     spi_xfer[2].tx_buf =3D NULL;
> > +                     spi_xfer[2].rx_buf =3D &phy->iobuf[4];
> > +             }
> > +
> > +             spi_xfer[2].len =3D transfer_len;
> > +             spi_message_add_tail(&spi_xfer[2], &m);
> > +
> > +             reinit_completion(&phy->ready);
>=20
> What breaks without reinit? Or what sense made by init-ing it again?
When length is over frame size, this loop will run for more than
one iterations. Reinit to start transfer again.
KY
> > +
> > +             ret =3D spi_sync_locked(phy->spi_device, &m);
> > +             if (ret < 0)
> > +                     return ret;
> > +
> > +             if (in) {
> > +                     memcpy(in, &phy->iobuf[4], transfer_len);
> > +                     in +=3D transfer_len;
> > +             }
> > +
> > +             len -=3D transfer_len;
> > +     }
> > +
> > +     return ret;
> > +}
