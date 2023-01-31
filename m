Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29C0C682F6F
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 15:39:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231563AbjAaOi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 09:38:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjAaOi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 09:38:58 -0500
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAD4C3C1F;
        Tue, 31 Jan 2023 06:38:56 -0800 (PST)
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30VC14qW030380;
        Tue, 31 Jan 2023 09:38:37 -0500
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3ncxbfkrwp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Jan 2023 09:38:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SmVLmO5+kgTjKd5ROMjtisRDRT1cPXro3zyxetRemlSk2RyBLCx+W6mSFA/uTAd5Py2lt4Y2kwq2tPOT0JAeaT8zaVhnatGox1aw3iokBq9k6jIDoOWe/YI5sXFcDO3Rub1V8Q9/biFmjsr76nYBBs/OvMmkFrrJRPBZ2ebY5XXxCBS+qYkWVNI4RQeGYLjXH0IRkFVvQuAzBoI9qc4CV2ro/WtyeODCCQYPfVpcYeRYutE3zP1+kQ4UKsn7viaMQmn6/gJausVFsEsemOTL6zWUtRd0AhZ58OiyUh/NFmKFaofs9AiVeTRPR1avtX0SdyzjmpslaMEqUduZAddCpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jvv52hrEAR8SQ4GOH+WqICW5C4DSrl57l+4Y0Lf3nMU=;
 b=M42Sap0MrmMRghVrOlBtJT7XsGbPhUZ2u306Fk8l9YOjYyRGqofv+grXlF0tXo0kj5FjEmNALtt00+gcUnMhjFy+FgxlaHC7TGOn0PZCmbpJUk8PdId07JYbPmTz4MP0R5hN3b/9+bt6jo5qHM+NXmPpnJ4Xon2iD2IhSpSCBfvcxXwILPxJuqQXe4s9AfJ/J+eYkIvv4DRURzuSGi7JM8gILd3+N5RoYcO+aQIA3a9nGU9n96A/xTlF/mSNBXN1t1oRKlv7zP+adyYh2AP8/SG9YOckKw2Jw9xfyoxNniPXwS9MHQpPGTsoMPRAn3YXas2sYN/2wiZd9LjW6AK2zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jvv52hrEAR8SQ4GOH+WqICW5C4DSrl57l+4Y0Lf3nMU=;
 b=v0+V6YryGiVMuu8tuuuJdVdEVUrueT+DU3UpsivbYg4ComVzAtZ6o2rpdIbH/xhjoRy17w2gyw1Tc6lc0rL9YNyXk2bgfIAT06mNZxHbOEVQi5gttzJztmL5eCjexvc0yebag25CjWj5I5CzpY7jLuqp9QzSKPnwOTiWyYPAAwo=
Received: from BY5PR03MB5153.namprd03.prod.outlook.com (2603:10b6:a03:22c::21)
 by BN9PR03MB6092.namprd03.prod.outlook.com (2603:10b6:408:11d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Tue, 31 Jan
 2023 14:38:33 +0000
Received: from BY5PR03MB5153.namprd03.prod.outlook.com
 ([fe80::f306:167:891a:c68]) by BY5PR03MB5153.namprd03.prod.outlook.com
 ([fe80::f306:167:891a:c68%3]) with mapi id 15.20.6043.038; Tue, 31 Jan 2023
 14:38:33 +0000
From:   "Sahin, Okan" <Okan.Sahin@analog.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        ChiYuan Huang <cy_huang@richtek.com>,
        "Bolboaca, Ramona" <Ramona.Bolboaca@analog.com>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        William Breathitt Gray <william.gray@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: RE: [PATCH v3 3/5] drivers: regulator: Add ADI MAX77541/MAX77540
 Regulator Support
Thread-Topic: [PATCH v3 3/5] drivers: regulator: Add ADI MAX77541/MAX77540
 Regulator Support
Thread-Index: AQHZKwfLM9q3yL8ciUSLt6aTy9zYOq6j1SEAgBRcQ/CAACJtYIAANL4AgAAM2mCAAASrAIAAApHAgAAJjICAAASo8A==
Date:   Tue, 31 Jan 2023 14:38:33 +0000
Message-ID: <BY5PR03MB5153A0972FD89DA362813F06E7D09@BY5PR03MB5153.namprd03.prod.outlook.com>
References: <20230118063822.14521-1-okan.sahin@analog.com>
 <20230118063822.14521-4-okan.sahin@analog.com>
 <Y8erlpofdk24vwCC@smile.fi.intel.com>
 <MN2PR03MB5168EC97926AB33D4D806FCCE7D09@MN2PR03MB5168.namprd03.prod.outlook.com>
 <MN2PR03MB516865804044A798AEB5B6C0E7D09@MN2PR03MB5168.namprd03.prod.outlook.com>
 <Y9kJEsjkG8h79tcR@smile.fi.intel.com>
 <BY5PR03MB5153C18E65B954E9FEFD96B1E7D09@BY5PR03MB5153.namprd03.prod.outlook.com>
 <Y9kXxP/cEBJ5gyoB@smile.fi.intel.com>
 <BY5PR03MB51539CB52778A945C8CB788FE7D09@BY5PR03MB5153.namprd03.prod.outlook.com>
 <Y9kh7QI+1RqvLr2G@smile.fi.intel.com>
In-Reply-To: <Y9kh7QI+1RqvLr2G@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcb2thbi5zYWhp?=
 =?us-ascii?Q?blxhcHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4?=
 =?us-ascii?Q?NGJhMjllMzViXG1zZ3NcbXNnLWViY2I2MWUyLWExNzQtMTFlZC1iZTk2LTU4?=
 =?us-ascii?Q?NmMyNWQzYzNlNFxhbWUtdGVzdFxlYmNiNjFlNC1hMTc0LTExZWQtYmU5Ni01?=
 =?us-ascii?Q?ODZjMjVkM2MzZTRib2R5LnR4dCIgc3o9IjM5NDMiIHQ9IjEzMzE5NjQ5NTA3?=
 =?us-ascii?Q?MzI5NTE2OSIgaD0iY1RONnIvTkZVTCtVcDMvUC9DZ056bXFxcjJJPSIgaWQ9?=
 =?us-ascii?Q?IiIgYmw9IjAiIGJvPSIxIiBjaT0iY0FBQUFFUkhVMVJTUlVGTkNnVUFBRW9D?=
 =?us-ascii?Q?QUFCQnV5dXVnVFhaQVJqT0NoVXVMM0tRR000S0ZTNHZjcEFEQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUhBQUFBRGFBUUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUVBQVFBQkFBQUFSczFnRlFBQUFBQUFBQUFBQUFBQUFKNEFBQUJoQUdR?=
 =?us-ascii?Q?QWFRQmZBSE1BWlFCakFIVUFjZ0JsQUY4QWNBQnlBRzhBYWdCbEFHTUFkQUJ6?=
 =?us-ascii?Q?QUY4QVpnQmhBR3dBY3dCbEFGOEFaZ0J2QUhNQWFRQjBBR2tBZGdCbEFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBRUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFHRUFaQUJwQUY4QWN3QmxBR01B?=
 =?us-ascii?Q?ZFFCeUFHVUFYd0J3QUhJQWJ3QnFBR1VBWXdCMEFITUFYd0IwQUdrQVpRQnlB?=
 =?us-ascii?Q?REVBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFD?=
 =?us-ascii?Q?QUFBQUFBQ2VBQUFBWVFCa0FHa0FYd0J6QUdVQVl3QjFBSElBWlFCZkFIQUFj?=
 =?us-ascii?Q?Z0J2QUdvQVpRQmpBSFFBY3dCZkFIUUFhUUJsQUhJQU1nQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUE9PSIvPjwv?=
 =?us-ascii?Q?bWV0YT4=3D?=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR03MB5153:EE_|BN9PR03MB6092:EE_
x-ms-office365-filtering-correlation-id: 1399e7d7-1e7a-414d-2efa-08db0398d447
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mHGsmDESHZzAYxXiAk+P5Bt9U2PqPtRtTtlvcqhqA2qX0ayLOplNpsvqR+K+caiSA0Do/rSLGQpplOYpZDK+pfV877gmPFm3MkFINrMAG40ieZoY5y+1ozVuiZfLyrityF01J4n7PsRLRuBqo5dTQsr0QJWBxadvRkCTTsocJ1f5HGcs4ipey0s49YCrwwyh5MDXCdDGzvGtJr5xxTJceeeXbQiG0gKXLwQBqdgcFpQ8yiHBQ9Ijy/m7UL5Pqw8ACA5qKR9jK6AUoEFwCyfuPKOpbvLvr3cp6pPbJWbJu16IjeZX+uckvr1pCkYOtOBR7A7uASugn6F5Kf27w4q/lzmQe/6VJCbJn7VVkQ3f2MVep4ZsYIwNUmTXc/VZxkjo4snjD3J6y+tRHFsZ3Knfdh0hegxOMEJGxu5jPIAiNf7x0nSGr54G1e9YPruTd+zt7BXgQydUDSSNDAAX7Ntkj1oOthNXiGNcTh0HGxgXdrSUTUuvcTOLrIuvjqg2EpHjl1srBFklCkKC+82oY7DO6WMDofG5IKMuja3wqdojKa7zSYFLlwTyIgq99ZaTcRqH+oZ1cnBryi1Ir1r5FqquPEKAYBWf6YKGwmGGZGeBhnwSC9sN8jafXzw/6HU2YUpQLKDUE1GGIpPyHQO0fEfwmvMZ5LpbPhPXAroubuWPQ7Qz8thA3LUTGdSS/tYs5tl+1dLSsrxZkZC/yq3WVytT1g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR03MB5153.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(366004)(346002)(136003)(396003)(451199018)(38100700002)(316002)(41300700001)(55016003)(38070700005)(7696005)(8936002)(52536014)(71200400001)(83380400001)(86362001)(6916009)(64756008)(66446008)(4326008)(66556008)(54906003)(66476007)(66946007)(8676002)(76116006)(5660300002)(7416002)(478600001)(33656002)(186003)(26005)(6506007)(9686003)(2906002)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?p/i1roBd/d/rSDIEpFRn277gcCVJcdvmDWzp7uPGR+qcGjRZ54d485EsibMM?=
 =?us-ascii?Q?+qbSGs4NmQGH8ouA+APBdgOU7izlxo5MCvRmuBn3XnY+vGzTwIREiml/NCMa?=
 =?us-ascii?Q?NfCPBqFRkhnhKrH93FW0iI7i385ejQfNqAoZLu6ly0vjd12gpjNSsoL/ljUi?=
 =?us-ascii?Q?yQFHU1QsbGAGnx68hg5F4Yll6qXjl0GpSkkeDwxQApiz6eXJoNaX5ktrSnqe?=
 =?us-ascii?Q?/7hslsrHdk6QLSlIfjgdSQsbYHvw+B8btd6DO1NA3XNjDCuILm4ISFGo7aHV?=
 =?us-ascii?Q?MjSBEjr5yMdUT/eXk4CxtUzBqXASuqOdZNvFPoVNY8p/CBnFoAZvu3tb/vhz?=
 =?us-ascii?Q?qfddeFtd+ZP0GZKwZRpK5Yinhx+5uOv7H2x/0NsefYpkLSkwRRg3mmIDGnWl?=
 =?us-ascii?Q?t4SISwvbhDoTCyoRxFNqd6BCTnAPcyzRru4DmO3NCPQdLDw4eF3ij6CVMPHE?=
 =?us-ascii?Q?3xOnm1YIUgA3hjHNxXIxxeuSzYh/z/nnRSxEreoxyk30pbHA44glA0wzugGX?=
 =?us-ascii?Q?P36R3hj5jlIxXTt5GcsaX/MXayd51tP9LVpyIqeToBVH4kEn31ZhQjcJCSSM?=
 =?us-ascii?Q?R175nIaeZ9zpZ0HeGUlsTCXsXPu8V0X/G8nwc/WWEFpJAMnTU12pzJlHz/uG?=
 =?us-ascii?Q?NSDGBANdxO5CSc3oJ8VRyKFc8MRQtY5pBCgf3PFaE+YmoXsQCiE6AArGq+Ew?=
 =?us-ascii?Q?fTmmorsZCioZ9+f8foPi3lgZ3ENnq31Dx+j8m6ttMqZIN5b9P0hdX724p6KS?=
 =?us-ascii?Q?A8K4sxihXAfWMbVLOvxRmGDsjhhNmx6QZ4VbNNqLGXfQM2JEc5u08RXV3HEQ?=
 =?us-ascii?Q?CwCk6oImdjBdCRMw6x4Rok7kJgefxFvxzdvz9nlwgsUHS/ezqnx19bDDsHs2?=
 =?us-ascii?Q?8Q5vdh1wTMjFs4ApdmDUlo0yIumyzWmxgrzk6YECrUsJMbOQdQt3ojxbYsq9?=
 =?us-ascii?Q?4UNkmc/FU0nS9F5tVXf3QqdbDUqqV3oKolXWZPZQM4R6GKoYF/dklR+2sI60?=
 =?us-ascii?Q?umCvskS0IDHxkOLwB5DRcYMtnxsbNT614Ggyt/MdIcj8mBbKfDTHCZG+WwsD?=
 =?us-ascii?Q?H+I4O34Mqpsiz1RztALwiar2lWPdsIv3OUdQ/DUeT30AGzB6Z4M1+r64o25d?=
 =?us-ascii?Q?xmInIoyOMucaDI/72rufJl1Z0zD/fwCf+N3NDk59heVx5ttktQ9gpGNDJbY8?=
 =?us-ascii?Q?ZLO2g1N+FHsOmjCwAR96LnCpqZ2digpgQllhpg5tk36YGNhkLvygeZck8VpU?=
 =?us-ascii?Q?cqyBYrAVHfouM7cnW+/Hlq+LM8h3c7C4u78cqmBLis4MsWSN/y81cSr/16iB?=
 =?us-ascii?Q?TqvgQrmgxmi5iqlEwZ7VdLE7q0GDu6JdSYDz2khnxEGrNRkT2wtklwgqUjer?=
 =?us-ascii?Q?3gx6EKnbwiXq4BDkxMRP2cditAO2eM5xXL9HvXKLUOdBlUUw65IJfEDxzQt7?=
 =?us-ascii?Q?viBzpmMwyo8UgJLLMlCJDcQnIic979qF70THKbwtKf2+SsgCehVTqxu0qavK?=
 =?us-ascii?Q?X685E79vm+JRGAW2BgrT8gl7P+IsFQWccFWnLgEbGChPozglllwYUzZARzoZ?=
 =?us-ascii?Q?b3IBwUIja/kgfefOWDfpG59zREFz9rxa/MINNfhk?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR03MB5153.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1399e7d7-1e7a-414d-2efa-08db0398d447
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2023 14:38:33.3935
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yHcVyKd6X/4lFDdHo5gbql2v0uXBcs4jXxD7jX5edrr+CYAz89R1XkKnkqjwZx5N4rwHLvy2iKnHwuHEcYs4fA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR03MB6092
X-Proofpoint-ORIG-GUID: WQHiQLurGz12JpbAUXfplvh_GPXBxdEC
X-Proofpoint-GUID: WQHiQLurGz12JpbAUXfplvh_GPXBxdEC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-31_08,2023-01-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 adultscore=0 clxscore=1015
 spamscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301310131
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Jan 2022 4:30 PM
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

>On Tue, Jan 31, 2023 at 01:59:45PM +0000, Sahin, Okan wrote:
>> On Tue, 31 Jan 2022 4:30 PM
>> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
>> >On Tue, Jan 31, 2023 at 01:23:33PM +0000, Sahin, Okan wrote:
>> >> On Tue, 31 Jan 2022 3:27 PM
>> >> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
>> >> >On Tue, Jan 31, 2023 at 09:27:48AM +0000, Sahin, Okan wrote:
>
>...
>
>> >> >> Sorry for second question. I do not want to bother you, but I
>> >> >> realized that I need to be sure about driver_data before sending
>> >> >> new patch. You said that you need to use pointers directly for
>> >> >> driver_data then I fixed that part in mfd, but I do not need or
>> >> >> use driver_data in regulator since chip_id comes from mfd device
>> >> >> so I think using like below should be enough for my implementation=
.
>> >> >>
>> >> >> static const struct platform_device_id
>> >> >> max77541_regulator_platform_id[] =3D
>> >{
>> >> >> 	{ "max77540-regulator", },
>> >> >> 	{ "max77541-regulator", },
>> >> >> 	{  /* sentinel */  }
>> >> >> };
>> >> >> MODULE_DEVICE_TABLE(platform, max77541_regulator_platform_id);
>> >> >>
>> >> >> static const struct of_device_id max77541_regulator_of_id[] =3D {
>> >> >> 	{ .compatible =3D "adi,max77540-regulator", },
>> >> >> 	{ .compatible =3D "adi,max77541-regulator", },
>> >> >> 	{ /* sentinel */  }
>> >> >> };
>> >> >> MODULE_DEVICE_TABLE(of, max77541_regulator_of_id);
>> >> >>
>> >> >> What do you think?
>> >> >
>> >> >If you have got all necessary data from the upper layer, why do
>> >> >you need to have an ID table here? I'm not sure I understand how
>> >> >this OF ID table works in this case.
>> >
>> >> I added it since there is regulator node in device tree. With the
>> >> help of devm_regulator_register(..), driver takes parameters of
>> >> regulator node. I also used id to select and to initialize
>> >> regulator descriptors which are chip specific. So far there is no
>> >> comment about OF ID table so I kept it. I thought I need to add
>> >> both of id table and platform id table as name matching is required t=
o
>initialize platform device from mfd.
>> >
>> >For platform device is one mechanism how to enumerate device, and
>> >bind it to the driver. The OF ID table needs to be present in case
>> >you are using it for direct DT enumeration (there is also something
>> >related to MFD child nodes, but you need to check and explain how your
>device is enumerated by this driver).
>> >
>> >I.o.w. please clarify how the OF ID table is being used.
>>
>> I do not use "of id table" directly in max77541-regulator.c so do I need=
 to
>exclude it?
>
>Exactly my point. How does this OF ID table affect the device enumeration?
>
Since this is sub-device, it seems OF ID table does not affect the device e=
numarion, but as I stated before, I thought I need to add OF ID table becau=
se regulator's parameters are initialized via DT with the help of devm_regu=
lator_register(..). It scans all the nodes under regulators node.
>> However, devm_regulator_register(..) method initialize each regulator
>> with the nodes under "regulators node". If of_match in desc and name
>> of node matches, then regulator will be initialized with parameters in
>> the node under the regulators node in the device tree. Since I am
>> using device tree to initialize regulators, I added of id table. I
>> hope I explained the situation clearly.
>
>This is confusing. If your regulator is enumerated via DT, why do you need=
 MFD?
MAX77541 has also adc that is why I added MAX77541 as mfd device
>
>--
>With Best Regards,
>Andy Shevchenko
>
Hi Andy,

Thank you for your support and your time.

Regards,
Okan Sahin
