Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3F5F610E25
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 12:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbiJ1KM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 06:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbiJ1KMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 06:12:12 -0400
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFC3C1B4C76;
        Fri, 28 Oct 2022 03:12:10 -0700 (PDT)
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29S7LRTh017513;
        Fri, 28 Oct 2022 06:11:29 -0400
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3kfagc1vsr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Oct 2022 06:11:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g6e5NAuLAzRi9fw/obPNGRz4nkS69CpAPWl6sxkaKvu1w2PHHXewIJZpym2EIjldcgKk6CcL8MVk+cPUdzEepADQkMGfqyH0J87LqAZAJw2BW0FBnGkYtdpynaw2MrdCvYZ+CXyGLlVVV1tsChw0tUSIBWyut/wWTg6th7Owg1RrfgIq3Kdx5EJaaAAIy30vpN8QURhysET7cUfLtviZ1X8gvYoeXaoh5Dt6gMS2kjzAgXQUO9226PzsiGTtx/3CuJOArdWsvmnzBvLbNpuNmOFdcuysH8Qqw1hzbm02i2b7t5TiiRhj+O8r7F8fVISl9uFJHYw/vBruobdEafDv0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wMEf83KZ4EXtFw8PPB61lUcaA+0ZId0vt2mbetBwtzc=;
 b=Kd4Mb09z1r/jWNniZKe6k+fkZcIy5u9QxtGkdZ3I8YnAb6+7dROOG66q5v1FQWCdCtvv5G7hTf1Vqi4bu20obrfZ4zN7UebDyA+UvjRulxuXvkOVlZ/BB863TmRuUKSOkgGVJK3m12YzezB38wSXN75uB8sqyGf6sXGk+zJP0TgcHvWiTbbcOCfvd/a6K+JsiBBOe7Yg+NdXYs1T+PoNwRPDIMkxS4un5t+MXjGPlkbptc0zpQdUctR+zbz7fO8U79dvk5eEtiAN9yX9rfxYyf4+2/5Ihu2vLgfE1yUvLOlfvJ7pFMLslWBdSkPaF2mc1/xYVFkrUMsCcGYmewIPsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wMEf83KZ4EXtFw8PPB61lUcaA+0ZId0vt2mbetBwtzc=;
 b=DYZ47tMn2f0dlVoMZTYqdUW4vysKn/qCYBI1mMr+0cAxs1bt69fwUPaEkQzrf1sO2UIBuYQpdkM4nwdSKRQwSf+6qlIgo+GLIwDFXGTDCLrtMEGUKCWaTnydwAkPGYB3VC6GrfGVGAm3oBIpMloOM67yjWaRdoN54L5G7xZQd2c=
Received: from SJ0PR03MB6778.namprd03.prod.outlook.com (2603:10b6:a03:40d::22)
 by PH0PR03MB7019.namprd03.prod.outlook.com (2603:10b6:510:172::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Fri, 28 Oct
 2022 10:11:27 +0000
Received: from SJ0PR03MB6778.namprd03.prod.outlook.com
 ([fe80::df11:95b:623d:6bb9]) by SJ0PR03MB6778.namprd03.prod.outlook.com
 ([fe80::df11:95b:623d:6bb9%7]) with mapi id 15.20.5746.028; Fri, 28 Oct 2022
 10:11:26 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Deepak R Varma <drv@mailo.com>,
        "outreachy@lists.linux.dev" <outreachy@lists.linux.dev>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] staging: iio: ad5933: Use div64_ul instead of do_div
Thread-Topic: [PATCH] staging: iio: ad5933: Use div64_ul instead of do_div
Thread-Index: AQHY6ks4nrCWT2KFn0+DLX/dNrKI2K4jloMg
Date:   Fri, 28 Oct 2022 10:11:26 +0000
Message-ID: <SJ0PR03MB6778EAAB4132374270E96FFB99329@SJ0PR03MB6778.namprd03.prod.outlook.com>
References: <Y1r4EaDvEipzhaaf@ubunlion>
In-Reply-To: <Y1r4EaDvEipzhaaf@ubunlion>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbnNhXGFwcG?=
 =?iso-8859-1?Q?RhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?iso-8859-1?Q?OWUzNWJcbXNnc1xtc2ctZTA0N2E1MGMtNTZhOC0xMWVkLWI2YjgtYmNmMT?=
 =?iso-8859-1?Q?cxYzQ1ODgyXGFtZS10ZXN0XGUwNDdhNTBlLTU2YTgtMTFlZC1iNmI4LWJj?=
 =?iso-8859-1?Q?ZjE3MWM0NTg4MmJvZHkudHh0IiBzej0iOTYwIiB0PSIxMzMxMTQyNTQ4ND?=
 =?iso-8859-1?Q?U4MDAwMjUiIGg9IkIxRkFnby96cVVlQnQ5d3dsZk9nQzhtemZPbz0iIGlk?=
 =?iso-8859-1?Q?PSIiIGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk5DZ1VBQU?=
 =?iso-8859-1?Q?VvQ0FBQlo3cCtpdGVyWUFmVHJrdGF1T0lZSjlPdVMxcTQ0aGdrREFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFIQUFBQURhQVFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFFQUFRQUJBQUFBWDVsMkt3QUFBQUFBQUFBQUFBQUFBSjRB?=
 =?iso-8859-1?Q?QUFCaEFHUUFhUUJmQUhNQVpRQmpBSFVBY2dCbEFGOEFjQUJ5QUc4QWFnQm?=
 =?iso-8859-1?Q?xBR01BZEFCekFGOEFaZ0JoQUd3QWN3QmxBRjhBWmdCdkFITUFhUUIwQUdr?=
 =?iso-8859-1?Q?QWRnQmxBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBR0VBWk?=
 =?iso-8859-1?Q?FCcEFGOEFjd0JsQUdNQWRRQnlBR1VBWHdCd0FISUFid0JxQUdVQVl3QjBB?=
 =?iso-8859-1?Q?SE1BWHdCMEFHa0FaUUJ5QURFQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFRQUFBQUFBQUFBQ0FBQUFBQUNlQUFBQVlRQmtBR2tBWHdC?=
 =?iso-8859-1?Q?ekFHVUFZd0IxQUhJQVpRQmZBSEFBY2dCdkFHb0FaUUJqQUhRQWN3QmZBSF?=
 =?iso-8859-1?Q?FBYVFCbEFISUFNZ0FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFCQUFBQUFBQUFBQUlBQUFBQUFBPT0iLz48L21ldGE+?=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR03MB6778:EE_|PH0PR03MB7019:EE_
x-ms-office365-filtering-correlation-id: f24ce96d-d80a-412e-4517-08dab8ccc67e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LtEfdlxU8Aym+WIaSKtebw9aiWIVHZ7/QQMRGu+OJI3Ia5cLoPiY70QDo/lqdMWO2ryFTM4Du8nQnfAe5yZ/bWo7Nm5eTi9lKVPdDDpeCYemUqX2J5lgUAlDVwZjdUafS9/ccNHTal5IIynLTFkXdvU3pinKUI/WhSFMF+LWGgdqarBjDdS/VHDViLJ1C0W1KdsSwkZRyAgQK7aSucMWMLuqjTyI/9rt8nc5jgMrbmqQ0hBIposau18Q9uLLKzWf5MGOM1Lf9Vc1a6PlOW77LMDu0wU3jwRTmp9os9KwFStZATTTLsn1djpIsITl7zbyq5F1ugq9gGcf6xdryScc33g/E/+7k7hOKaZWz1nnwynfbShGJ+W9Dr6F2ZP5+w2Nst0M6oWle06RD4k5RmZl58P/Ou00VENcnp243+1eR1knX2uOUZb/lO/aaoDbdobJqVpdY4BlO+YCPLIZsbN93fd3Qmbeg0SE62P/UK3LvnD0qpOsy/F+HfK2gIbdE1HzONG0AgqwM7JE9qMWis+ppGK1ITjYL7/dqhKYhbthoXMRXQcHbjFZBXIY4VqDD3aLphH/ntI++Nq3MAUWJpYoEpPHo+BkLLd6Y3M3MUcB60QbJ7pcf59Jl3uoDZHxjbBIM5ACR3bakf+KGrDRvvI8ieN7+NoUbdrMu2QDX/KHKN5JvEKomoccXXGv/R+fWQFdkjAZLeZqcQNWbxfc0t5BrqB7MeP6SCV9TGFj0AaN7YvxrK4UGISE/WwIsUTDgUS6SgVxkyF36t7TCMLWDDfkaH4ITrhOiQoSYGXL++AbX9A=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6778.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(39860400002)(376002)(346002)(136003)(451199015)(83380400001)(38070700005)(921005)(33656002)(41300700001)(122000001)(86362001)(186003)(38100700002)(52536014)(110136005)(71200400001)(5660300002)(9686003)(4744005)(26005)(66446008)(8936002)(66556008)(66946007)(66476007)(55016003)(8676002)(478600001)(64756008)(76116006)(2906002)(6506007)(53546011)(7696005)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?kPAIjwDNu+/AYwNywJ+Mf/AOF8ZAzb4/kX+KxjdgIqSSVJw9S0v8yUZvhj?=
 =?iso-8859-1?Q?XW2VAUxuPyqWi39IvoiL57bE98MBT+5PXWfx7b5pTGNEl0K8rpZj/Yxnkj?=
 =?iso-8859-1?Q?DQ2qmPzLc5dJDtFzi46wH5kU7X0eGRFb9GaUGwFzGUXkV7/koMyqZknyAL?=
 =?iso-8859-1?Q?3CvRir0LtGspEdmQzNyrGKnOyp4pEtwdqrwHNy3DOKhIjKUsbZ2wzzBtMm?=
 =?iso-8859-1?Q?sOfHPkzVEZ5dxkPSCB39MKq3Pgq9UB9t30BJFhdIBDlyovsJjm23k9OVfA?=
 =?iso-8859-1?Q?CXTW7thhO7cD5UFN34Y7/zJbVf/ZEiwGctId58uHSZuZs9TfeVo1EsH9uh?=
 =?iso-8859-1?Q?GpOUmwl5vjKaLP3WZamc8tzNTIWN8AaFjetDmCEJ8pBCxNEzHByncYMujD?=
 =?iso-8859-1?Q?8NUWNFEpN08toiTVv25SYGvxWrac7fPGqHQ32bHWyFb+WeHe6MbPw79Jgf?=
 =?iso-8859-1?Q?7T+2OvnZdV0BRqWXmcgPYG0sGMmwnyCKj9Qo1Yer5KD9zJnA8nEEB4kiq2?=
 =?iso-8859-1?Q?d3/Uta13pRCFwlikRrhJQ0JFyuYNoW1Nu4zhXVBFhpT68cuT09m1i9ylsP?=
 =?iso-8859-1?Q?w5T7AJl1SSPJaQDVmE3ma59Lb1ZgpCc66CuNHhGw687wWjWBON2GnSmN7a?=
 =?iso-8859-1?Q?XtRAgm47CnANfdeYir09Ho52U6mJWdaWl+yibOKZC34V1u8CxGOsedIeE3?=
 =?iso-8859-1?Q?nhuIOQQ2VR6r/sv/ooxkrMhgaeGBCBodAV1zY+ZelqR8h55VLWH/PNr2u/?=
 =?iso-8859-1?Q?F1y/2X61N7JAAUQtPfdb9wyuLzsPx2bcM01gJ5HOpAOtz9vTXcLO/E7fHm?=
 =?iso-8859-1?Q?8vxM8yVGOKpjGie298Tgj8/fr/5YHcrrQh34syfYWOZq4Dw2LOj5EzdLgU?=
 =?iso-8859-1?Q?dxDM9gzchhAYXho9tWXD4NtsbNaPFimvsnL/idLRcHmf7WB7qahtBgLu6Q?=
 =?iso-8859-1?Q?MT+5kROF+yOuVmCQEXCd6fsVDIM4woZ5BlJ2biVNWQ1PoTiTcWJ+KrHQBZ?=
 =?iso-8859-1?Q?ZYjId/FqZFpyDfPq3lG6CpTeCPVbzYSx9uFn/4C6GLld6ewBX2hX8XnW3S?=
 =?iso-8859-1?Q?VDEddhqJYeyCA5QMOJMXpAjf7XT/SHpGhf1LyJL74vxdq7sXpLTGEuiyd9?=
 =?iso-8859-1?Q?coyZexrF6YrLab2O5yi4KVhU9pZsDEbnNooqayCv92T24/8K5984arsrFG?=
 =?iso-8859-1?Q?xIZP9RuNHaBUPlZTr4oVt5UO3UwJj+hSpjUrF+v4jnD8zxgxddxqu7Dhdk?=
 =?iso-8859-1?Q?O5ePOF4YdJ6279T0Gf3QRjVhiAgZABgJ4EBpD5W9OWyyN7/4R+4M8k2pgd?=
 =?iso-8859-1?Q?wwnS3uQs1ZYolQaxqHBlCeROspzSwT0PEElDrkUAg85O7bX8r+C5eTNEdi?=
 =?iso-8859-1?Q?bCkfoOqDAVDugUChXe/AoTFLq09p8uJjAf3RJ1QOshLPcvDgcTeSWWY1PE?=
 =?iso-8859-1?Q?q8kpvzCkDYw9nupXn5H5v8RIR2zw66gYxloZ61NrQPihMwKcXz/b4QEiKw?=
 =?iso-8859-1?Q?kLyb3ORVraRFu8EByNlSD9Tq/OqP5xxX/ayGbu9PNBgX0xX60OVduUChov?=
 =?iso-8859-1?Q?3fJH0k+rBFK3Vr9E7/WkRmNg2X0Sw+TM6+kTSXmRyoufEpp8MNHlfINegL?=
 =?iso-8859-1?Q?Af3h6YxKIlsNI8NunNmeF9Apov08kh2cLJ?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6778.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f24ce96d-d80a-412e-4517-08dab8ccc67e
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2022 10:11:26.9037
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5btWpUMhGTKXbQ4vfpfWqt/Merz6M8+UTkmreWfv2HpPjZCEvJmeLv5Do59zv8Zfcb3q559LqfPB2UKbKPjb4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB7019
X-Proofpoint-GUID: 4EplaXg3FlkvWLzYTXqWKB5tB-Y-6g0_
X-Proofpoint-ORIG-GUID: 4EplaXg3FlkvWLzYTXqWKB5tB-Y-6g0_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-28_04,2022-10-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 adultscore=0
 malwarescore=0 impostorscore=0 phishscore=0 bulkscore=0 spamscore=0
 mlxlogscore=930 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2210170000 definitions=main-2210280064
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Deepak R Varma <drv@mailo.com>
> Sent: Thursday, October 27, 2022 11:29 PM
> To: outreachy@lists.linux.dev; Lars-Peter Clausen <lars@metafoo.de>;
> Hennerich, Michael <Michael.Hennerich@analog.com>; Jonathan Cameron
> <jic23@kernel.org>; Greg Kroah-Hartman <gregkh@linuxfoundation.org>;
> linux-iio@vger.kernel.org; linux-staging@lists.linux.dev; linux-
> kernel@vger.kernel.org
> Subject: [PATCH] staging: iio: ad5933: Use div64_ul instead of do_div
>=20
> [External]
>=20
> do_div() does a 64-by-32 division. Here the divisor is an unsigned long
> which on some platforms is 64 bit wide. So use div64_ul instead of do_div
> to avoid a possible truncation. Issue was identified using the
> coccicheck tool.
>=20
> Signed-off-by: Deepak R Varma <drv@mailo.com>
> ---

Reviewed-by: Nuno S=E1 <nuno.sa@analog.com>
