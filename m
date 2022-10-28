Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6958610E26
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 12:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbiJ1KMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 06:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiJ1KMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 06:12:15 -0400
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58CF21B4C79;
        Fri, 28 Oct 2022 03:12:15 -0700 (PDT)
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29S7VFch017472;
        Fri, 28 Oct 2022 06:11:58 -0400
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3kfagc1vuc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Oct 2022 06:11:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ak+ERn4NmeuU3HpVK69CQLM1wRI0re/B/A2x6XhNloTt0HiVBQ/IwDrIhCh5Jo/Vlk6zfL8aG/G4H5F6Y/G+1mm2MCJbBYqrURfKSxTtvZDF25gwp6azeLPoHqX2pR/u66dwekwjoAKv++pTriHrei2g3xT5AiiUvs4Q9ZJ1iptEsCl0sfeMMR95ZkAhMuuP5C218itFvEUGA3CjNStI+PTIeFNXwt0ueY8tT50NGOmDZ/rr3XscWj75iq9Bl94AUYT3xb56MsaTQuzJnvKC/VL21Qb8nDRGGadGy/sXUJ8rR5QYh04A+h8HC45yM+LXpp5ZWJc+gI8+tcrb6qvuAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CjjPkvYWFwNvo43Nyn9NrZFLtMdQJevMxnenFN9+xio=;
 b=n3htrGEfP8FesOY6CxEjM1RSpXEPpmmHnQuEcrgRX5qmp4tLZh1QLQ2hfFgexvp/ypXIsCSl0AKTis5fyJG0ROdakReSyOIDpl9A0bZ4MYtoRZCjwaOoH45W+MHFbvAnGvGGrVQ1wAJ8NBA55mOkMV4rRlJE7ZS2B1ofJl6DFnQHLw8Hwir4hVtCjZECC07Nwf87Y2Sx3T/nX5uYZnbQ2qyyzTFIYSgJMx5vzRnfnTPjP4rBaqWzJeYcZvs9oyWp43RlVkeFR06Oy/ZYlCUOjI9h+XJm59+2ppfZXKdvJkTmlSYJoWSWe11OPmL5wgUtz3b3B/pfvAKNe6mSajJYiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CjjPkvYWFwNvo43Nyn9NrZFLtMdQJevMxnenFN9+xio=;
 b=a2bIRe5MW7SxwaxloiRUTdJ5voXdNpX7F8qAA+7k5IyusT4NxOGtdVzjMkSXt2FRB0mlJjORygffSEpaZagutC+qTjGOkyQ1fYz9vJQ3FsXj+TEd0+MRYnA3NfJzR9NQI0WW/tZvaCwiMa2rzNTaz3t2xoLJZYWyOpUMiMFVLtU=
Received: from SJ0PR03MB6778.namprd03.prod.outlook.com (2603:10b6:a03:40d::22)
 by PH0PR03MB7019.namprd03.prod.outlook.com (2603:10b6:510:172::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Fri, 28 Oct
 2022 10:11:56 +0000
Received: from SJ0PR03MB6778.namprd03.prod.outlook.com
 ([fe80::df11:95b:623d:6bb9]) by SJ0PR03MB6778.namprd03.prod.outlook.com
 ([fe80::df11:95b:623d:6bb9%7]) with mapi id 15.20.5746.028; Fri, 28 Oct 2022
 10:11:56 +0000
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
Subject: RE: [PATCH] staging: iio: frequency: ad9832: Use div64_ul instead of
 do_div
Thread-Topic: [PATCH] staging: iio: frequency: ad9832: Use div64_ul instead of
 do_div
Thread-Index: AQHY6k7DnQp2SplYGki6cxLkETG9uq4jlr6g
Date:   Fri, 28 Oct 2022 10:11:56 +0000
Message-ID: <SJ0PR03MB6778033906F79121A66C32DD99329@SJ0PR03MB6778.namprd03.prod.outlook.com>
References: <Y1r+EHqpVz/HYrIm@ubunlion>
In-Reply-To: <Y1r+EHqpVz/HYrIm@ubunlion>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbnNhXGFwcG?=
 =?iso-8859-1?Q?RhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?iso-8859-1?Q?OWUzNWJcbXNnc1xtc2ctZjI3NjVjY2UtNTZhOC0xMWVkLWI2YjgtYmNmMT?=
 =?iso-8859-1?Q?cxYzQ1ODgyXGFtZS10ZXN0XGYyNzY1Y2QwLTU2YTgtMTFlZC1iNmI4LWJj?=
 =?iso-8859-1?Q?ZjE3MWM0NTg4MmJvZHkudHh0IiBzej0iOTgxIiB0PSIxMzMxMTQyNTUxNT?=
 =?iso-8859-1?Q?A4MDI0MTYiIGg9ImIrTkNHZmFYdjNMNkxFK2wvUjMvUXNmV3JQST0iIGlk?=
 =?iso-8859-1?Q?PSIiIGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk5DZ1VBQU?=
 =?iso-8859-1?Q?VvQ0FBRHc1YzIwdGVyWUFhb0JWYUpPazVLM3FnRlZvazZUa3JjREFBQUFB?=
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
x-ms-office365-filtering-correlation-id: 8152ab7c-1135-4984-31fe-08dab8ccd816
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Dfrb+2O6oujxf2LPVvgNxN7sNxgTtAAWQ7iaDLduWiBwiSD6smPtFhW2W8Jm89yV+nJImKUd9BHFJvMH9c1hqg78EqiHiVF0LP2i+ZhqWlfEQt5Ln84jcZA3zAVj8k0Ze9PZjw3nVk2BipW9q2ZpCWUO8Ycw5wJsFNvPaUg/hboVFyHPbFVB4NVuCK1nTbKaDssdF1627faXcQXoOsAywPZK4QyCthSYOOf7rX7rQyrgsR6tbDGxU8z5z0J9uQ11JRnqMMKeEfZ1J0+5nptdF0gAIfqooDJNPsGG92NMgdX11z3q9kAjCM/hre8wGbNNjVHNfYrTZV9fJ3no0GT+bCWNjHlyVteWdpdQok2BZm1YWSzC5nAHJP3Hocs7QZVbwsqp7Vsb72UNOXS+Tsf294f/MhkgwSV7PC8/dNc/F73V62+im7WzyJLsMY6s5B1p4EYYVBpQEUuaAlqlRcjpLepUvl6GIPXUzSHaD+KMErrZA3/QJXx7zVgzcvtU7ptmPQCMwyZ5oNtYp+TmadksxYJ8+wmm5JYteV9+BF3l2rnwiYFR+fumolkMZzlCzqtQjiPaVInCAv1VHMVFqXncgzZKKcRv5KOJs45uFzkvTQ2y7zzB/NGwkHto+2FjVkPDWfIZMak1V57HwYLNeYCg6rEISSUoXwQZI1mLKLy2PpzY42gnNNKohINBMIzUKd6zCBgYYeLxG/K/QrZ7ODCrWoF+vBnY8UuHJVnBzKn9DAUWFVG+N34omBZtJRw/tmmJZOAUX6KGTgjkgXHwaS/GrnX+1MG7bwoG9b9n6easvXE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6778.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(39860400002)(376002)(346002)(136003)(451199015)(83380400001)(38070700005)(921005)(33656002)(41300700001)(122000001)(86362001)(186003)(38100700002)(52536014)(110136005)(71200400001)(5660300002)(9686003)(4744005)(26005)(66446008)(8936002)(66556008)(66946007)(66476007)(55016003)(8676002)(478600001)(64756008)(76116006)(2906002)(6506007)(53546011)(7696005)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Y28Not9wbRRy+GqD+B1D8VrZefWBBicSRpXHXJ02XLT+pdSUm59P/RQbmE?=
 =?iso-8859-1?Q?JenEt9sqo3yOczwbpPsLwzHSZ1gcDgoH6vcIsBYytpEJ6sIeFcZwjkb1Yu?=
 =?iso-8859-1?Q?XxywSRGBkinM2W9bC8mOT/McLsL4NmplnurzTstjf0OCuTmIHLSjuu46/r?=
 =?iso-8859-1?Q?5FKOX33rbpAoeXm8MSiy1gsqlGOrAvdZ1sspxPR63Wa2y7NIQIjFpgIA4F?=
 =?iso-8859-1?Q?Pv/wGENyaslzGdQ54pvWysIDcqUGrA7sX9V64IQL8rm4CywoCykoOWA6l/?=
 =?iso-8859-1?Q?a+IqrUF1SD909/o9/q287H0vqSJbMPnXsuhWuSxySJBzluraGP30gsMzCw?=
 =?iso-8859-1?Q?ZOWRYLAvKPlvtdRQLP8o1xLOLT6bekbEwWwgZt9EPNJHrI3O3a+OvpooQi?=
 =?iso-8859-1?Q?5fOIUa/XsC6YR3BGRsP3p2Gs1p9tfvoGB1DAfCj/vrvRlXsp1dATtRlwr8?=
 =?iso-8859-1?Q?U0G9KQdoOdigzfE+azDjnfC1jUthVMgTjx2UJtDgK3FMwpJ2k2QxKqCcHF?=
 =?iso-8859-1?Q?pWYExbezKE0Lh8YrOb92Tzgyk8UCZBD9lhizNcsB3xOpX8WyeMSHU3DTWn?=
 =?iso-8859-1?Q?8t4EvHEFQH7GTYLL7tWs0BINlbV4vuUwa0s/kvzn+1rOQt+TFXkpZt3IBL?=
 =?iso-8859-1?Q?B6H6NSEoYa4OsYg+lOg7leY4crXlRdnE2NZXeWcHIgxBDU6QTJ8ThTx2gm?=
 =?iso-8859-1?Q?BBykTw8XYOq+vmj5KX9g24/y2F1hrwiEMZAQ2oSrJPPCPYSbA0P8Uo1RMu?=
 =?iso-8859-1?Q?4V1dftinvdsWh5Tnpa06il8v+tjDEUQzMLM5Wyn0lvTn6FuO6+Ri+HVO5a?=
 =?iso-8859-1?Q?uiiIipKcwO1uZqjIaODrxhPQr526ipLMm0dIMSeKqlrf2hOEP7i+bVhGsK?=
 =?iso-8859-1?Q?QM1W0YtTr96MZbhf6rWbqBcMu+YdlZlapJIksoy/eBNABqseX2d1hDxRse?=
 =?iso-8859-1?Q?8ZgE/WZInMS0Rp2Jp1JCw9HmbVWFuRiSDUvmv1RkQMpyhxCawSoPcJC65N?=
 =?iso-8859-1?Q?DZDXiU9QTZbHa8+6PW/2awFXa8zc4zIw5qLk0WCpXNimKa5kGPWUNwD/bL?=
 =?iso-8859-1?Q?xhAVisPwQc73bJQqOF/fxzHddCNLijYPxUPM00xdzicYIXR10bjnYilRpP?=
 =?iso-8859-1?Q?xeMqcn6TvShN5H0+ulFEYRAUpVdVKuE4wDTc9kU+yaN923vUDKBBVVTVnz?=
 =?iso-8859-1?Q?Z9uMuPjUynYWWPmjTkGaG7TVU5THGB0cR6rDJl3ph3B3BvE/fC36sGlUJJ?=
 =?iso-8859-1?Q?brOIZOpudtopdZMUm2zwJ0K7B5B1VmyEbX8joCpdTPNMbQ6qGRl1kzy3v9?=
 =?iso-8859-1?Q?jF3iT1n5bN3zbMXgN3SjZGJlD/cQbXw5YGFEammJaVQ9aEdQSwfQjo1DoV?=
 =?iso-8859-1?Q?nHnG+4Z/ksWHfHmKXr6jGSjH9VAaStChETsA/KAmwUEvT0XcpQRs1OILy5?=
 =?iso-8859-1?Q?RkDTQV/oZrw8blWKLA4zMu3NhSr18o8PUwuNplBzi+i/AlJKbVrqzSMxrE?=
 =?iso-8859-1?Q?4mUdCgYo8HlCbnh/HW86mIw+Gbrx9sxeNy03AUu2XeaSW/OGBd+dH3R3Qr?=
 =?iso-8859-1?Q?fd5GdFxzdYD08npqzaPhm6txoeDGnE3WRALtDtwMdurbxnK1or1Br+CPA0?=
 =?iso-8859-1?Q?Iqiis/OI3al+1gZ7hHyzf0ngZSyNP4Yi+c?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6778.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8152ab7c-1135-4984-31fe-08dab8ccd816
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2022 10:11:56.4035
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5Byd3iFWyj8Xq4QvykwBwtjBcR7zYKfjCasXHY3vaDn2Mf9Iy+YOhR2HtEj7HrjyQASvJhJEhv0S7M9/kKZxsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB7019
X-Proofpoint-GUID: OLPnrNrbDWa-E4FTJgTJrztEUJWSMyd5
X-Proofpoint-ORIG-GUID: OLPnrNrbDWa-E4FTJgTJrztEUJWSMyd5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-28_04,2022-10-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 adultscore=0
 malwarescore=0 impostorscore=0 phishscore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 suspectscore=0 classifier=spam adjust=0 reason=mlx
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
> Sent: Thursday, October 27, 2022 11:54 PM
> To: outreachy@lists.linux.dev; Lars-Peter Clausen <lars@metafoo.de>;
> Hennerich, Michael <Michael.Hennerich@analog.com>; Jonathan Cameron
> <jic23@kernel.org>; Greg Kroah-Hartman <gregkh@linuxfoundation.org>;
> linux-iio@vger.kernel.org; linux-staging@lists.linux.dev; linux-
> kernel@vger.kernel.org
> Subject: [PATCH] staging: iio: frequency: ad9832: Use div64_ul instead of
> do_div
>=20
> [External]
>=20
> do_div() does a 64-by-32 division. Here the divisor is an unsigned long
> which on some platforms is 64 bit wide. So use div64_ul instead of do_div
> to avoid a possible truncation. Issue identified using the
> coccicheck tool.
>=20
> Signed-off-by: Deepak R Varma <drv@mailo.com>
> ---

Reviewed-by: Nuno S=E1 <nuno.sa@analog.com>
