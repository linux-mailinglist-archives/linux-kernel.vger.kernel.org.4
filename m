Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CACFC6C18A3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 16:26:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232749AbjCTP0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 11:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232878AbjCTPZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 11:25:51 -0400
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17E86C66A;
        Mon, 20 Mar 2023 08:19:03 -0700 (PDT)
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32KBWGVF022011;
        Mon, 20 Mar 2023 11:17:55 -0400
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2045.outbound.protection.outlook.com [104.47.73.45])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3pd72bt92x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Mar 2023 11:17:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oLl6vlstHeGFW6ZmTefg+esG28zl/HXYfzkcKpG27Bc/V6RJP6qoemskvQqOciy9ACwbx6IS6Lc/1FKS6uwa/cwEKj1yzjbR8cwwCqRPNfyCshCpcFH1HQcj86fTJAcXR3WtiuY3xPNaVtlY22vvqVvt09ccxXPhtvkBgojKodzhhZo8kT8T3/2DwgxJNi9vUFQUTfAnKXhjeQSZ5PewYHitFysPZ0U8RbnyFWuy5QdOPnZaaPOhzYa0T865OkSz+90O3u0g2eZDgVTYhkRexo76wYpi+EqxEyHBbmyZEC8vqfz1ppkTBbz+IDjGurvswNgriLYnxrj693zbaaYmqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sVLdPw5M+9WZSM7xmUsIMDQkIFZAvvg84gq0YlIA2Ig=;
 b=nLiUM0Zg+B2JLMn6y0JoQTEC5Ml8JxKM3vCh6QdkHA2JrQ5/MhJsmm+2bQ4xZakktJSPlomjbZT+UHfGtSEc1eKc4G/yW/7Ks+O0A1NBdbnDNulXQhSB6s7QdowmgMkEiFLSNfEiuo0JlPN07X9lagqhRAsNAgljZV+K6f5RqnNwzHirlf40iJ5ZGitTiMC5fK2e3tdWxkta83+iHhNCkuxsLPR01dnz6GMlLnHfIL+aw3ihXxxNmmomYxVx6whZ6RAZFxWCz/Mv+NJaxNw+R0LACWIZrtKCcA6maSFmY4OsPB3/4IFvzsILPLWLsMVqUK/u7kz1nD9lIyzxuC8lQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sVLdPw5M+9WZSM7xmUsIMDQkIFZAvvg84gq0YlIA2Ig=;
 b=vlG8hwhhGl/HS7Mh+vTr7TeUDD349GbQRjMsyoSCoXrgA3GfdaXmPA46QiOj5jnh1v4dkcgm0JfSQbclVpLHnMlC+6L+Mloh36hJpH48v9KBOgId5lojZ8kZCd5EmB9hhkisEuhtPZlXiG19D6S+bJ8ilL2ODrIiICsBoMmG1Ws=
Received: from CY4PR03MB2488.namprd03.prod.outlook.com (2603:10b6:903:39::12)
 by BL1PR03MB5992.namprd03.prod.outlook.com (2603:10b6:208:30a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 15:17:52 +0000
Received: from CY4PR03MB2488.namprd03.prod.outlook.com
 ([fe80::3ebb:ede8:1ce9:2528]) by CY4PR03MB2488.namprd03.prod.outlook.com
 ([fe80::3ebb:ede8:1ce9:2528%6]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 15:17:48 +0000
From:   "Tilki, Ibrahim" <Ibrahim.Tilki@analog.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
CC:     "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "Arslanbenzer, Zeynep" <Zeynep.Arslanbenzer@analog.com>
Subject: RE: [PATCH v4 1/2] drivers: rtc: add max313xx series rtc driver
Thread-Topic: [PATCH v4 1/2] drivers: rtc: add max313xx series rtc driver
Thread-Index: AQHZV1mc87DShX4HhkCo07nQFM6kS67/hjcAgARDJnA=
Date:   Mon, 20 Mar 2023 15:17:47 +0000
Message-ID: <CY4PR03MB24881D7C8597BCB3A6E72A2096809@CY4PR03MB2488.namprd03.prod.outlook.com>
References: <20230315161626.247-2-Ibrahim.Tilki@analog.com>
 <202303172150163e1de7e3@mail.local>
In-Reply-To: <202303172150163e1de7e3@mail.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-rorf: true
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcaWJyYWhpbS50?=
 =?us-ascii?Q?aWxraVxhcHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUt?=
 =?us-ascii?Q?NmI4NGJhMjllMzViXG1zZ3NcbXNnLTViNjY3YjBiLWM3MzItMTFlZC04ZTdj?=
 =?us-ascii?Q?LTdjYjI3ZDcyMzFhYlxhbWUtdGVzdFw1YjY2N2IwYy1jNzMyLTExZWQtOGU3?=
 =?us-ascii?Q?Yy03Y2IyN2Q3MjMxYWJib2R5LnR4dCIgc3o9IjExNzUwIiB0PSIxMzMyMzc5?=
 =?us-ascii?Q?OTA2Mjg3MTk4NjMiIGg9IjV5Ui90a1loMnVMSmNDOWpHa3AzY1gvQlpoVT0i?=
 =?us-ascii?Q?IGlkPSIiIGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk5DZ1VB?=
 =?us-ascii?Q?QUVvQ0FBRDMvQUllUDF2WkFRcGtsWUdaSVhZY0NtU1ZnWmtoZGh3REFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFIQUFBQURhQVFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFFQUFRQUJBQUFBUWRpazVRQUFBQUFBQUFBQUFBQUFBSjRBQUFC?=
 =?us-ascii?Q?aEFHUUFhUUJmQUhNQVpRQmpBSFVBY2dCbEFGOEFjQUJ5QUc4QWFnQmxBR01B?=
 =?us-ascii?Q?ZEFCekFGOEFaZ0JoQUd3QWN3QmxBRjhBWmdCdkFITUFhUUIwQUdrQWRnQmxB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBR0VBWkFCcEFGOEFjd0Js?=
 =?us-ascii?Q?QUdNQWRRQnlBR1VBWHdCd0FISUFid0JxQUdVQVl3QjBBSE1BWHdCMEFHa0Fa?=
 =?us-ascii?Q?UUJ5QURFQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFB?=
 =?us-ascii?Q?QUFBQ0FBQUFBQUNlQUFBQVlRQmtBR2tBWHdCekFHVUFZd0IxQUhJQVpRQmZB?=
 =?us-ascii?Q?SEFBY2dCdkFHb0FaUUJqQUhRQWN3QmZBSFFBYVFCbEFISUFNZ0FBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFBPT0i?=
 =?us-ascii?Q?Lz48L21ldGE+?=
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY4PR03MB2488:EE_|BL1PR03MB5992:EE_
x-ms-office365-filtering-correlation-id: 59e2c9ab-fefe-4412-d868-08db29564384
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7xJwy9lA7mRT3/Ho4feOoLTV6tjLLGw4zaG9x56qLnInd2I2dIEUiEODKEcjZJjSmuTIl9tqR/c77kt0XbDu/CKveAhvKNIdIcvvEA19Ww2Bzc1r11FqrqTxXbGK9ktRlVyp6xYSkJT+E7JwBqLY2xQVGv4h+lnG89UGKUUKPS4SwWCBA2q+bMjln1oPwAzj7O35CkTfqfubv2BlXNyjptoELTf8KKGcSisMAbQk+qglf5X9hk2R6rHjBd4i8H/5UNlbBQtJP7MPAqmakHp+r0CPJKWW2jyEmwyKGLslpMCSabAA30+M8ZE/ZWubhCmUeyVzgrhMix+AEaFeYLzdHavJpQh0r7Vd1qQqGdqwnKNsPatjtmZz8sPDKcO8E/d4EX3FrAnSZPOwCf9l0WWJoqVpBfbs+VZ7gkHb6wpzMvHKaEUImdyyM9MIGl+RAAzZpGZL+qh9aqo1w7MGH/0qTcGrYBuHgFv7vdxwurhmpvUpLVWPPXllEzFjuJEEqsODg542TkCCQCE/CBibAovBmhUyzYC6LGBP92jNlb51WDwSQXgyk0jK8cjJq+h/EOkInEjwDVuEmllL/6MiLEIi285YzlKcj/jEOUA/T7BckBy15fLnDp+F738vToh7T3ds+q7Hvd9nxpJmRRoZwgFbgYYMRba4g9Rj59pXVblDWEP4JyQTu5Sxv9tYJ6xCSE+9
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR03MB2488.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(366004)(346002)(396003)(39860400002)(376002)(451199018)(86362001)(55016003)(7696005)(66446008)(83380400001)(316002)(6916009)(4326008)(8676002)(64756008)(66476007)(478600001)(66946007)(54906003)(186003)(66556008)(26005)(6506007)(33656002)(966005)(107886003)(9686003)(76116006)(38100700002)(38070700005)(71200400001)(52536014)(8936002)(5660300002)(30864003)(7416002)(41300700001)(122000001)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OjyvA1n8kV/mck+YbnqkGUTWHPFhQhfoSzeCgBKrSpbEoAA9gDRqKFnLoxeO?=
 =?us-ascii?Q?ymoZfAA9fgH/1xKYz4V72B94dacwywGy94O+Yh7u9ygnMUFAd2PBNb6SEQNs?=
 =?us-ascii?Q?y+SxGqcUYQ94ZlKs6PPb6+yaUl4I6XpV0nAUKzvZax3nT9WSxHTCNMJkSppX?=
 =?us-ascii?Q?G3eHl5TFOlsy6FVPkkzCrXHnzG50jVLhWn6FQ6Z9wXWWDI8sey6VzPfnSVVQ?=
 =?us-ascii?Q?WpDcVTew/8x+2NHxGuUhiILOxzNoYWdJbchXCGOkhZrTSq46GMNyJxLq+YQ3?=
 =?us-ascii?Q?ql9Q9bwnfZckxkLUrdh9oXckJeNcH/FeWc9x8OYgfsvtUVH3RUP4SzlsAgK/?=
 =?us-ascii?Q?moKhJFKHd6CVgmnek+nBnttmbVvDaDIAMt4FpETl4R72N1E41hXqYhbz1EUD?=
 =?us-ascii?Q?IabGU7gJHd7mxdP2IRarCqBYzqunVjATK+oMbp/dAhBpCVeK+F6U5ZooLwKL?=
 =?us-ascii?Q?bRwoU38uX5kio3ToAaR5CtqCgGx2QvD/Q4O4ncwlRWsWr7FXnmOgsIV93fib?=
 =?us-ascii?Q?vSJGZjTk0zzQoQ2g9aUu1ll4IrGer/jgnpU8A+x3ire2dZe1Kj1RJI+0Ax6e?=
 =?us-ascii?Q?YkgWgflrBmNZBHT8Omo+vMj6U+uWbZZO79eO39jaO+I5dkMUyzTbnp7xBgA6?=
 =?us-ascii?Q?ak4KeaDdq4Yh3cVk99AIUjK9AaSRhxQW44IKmQyvUiVfKQLOKb9hkg8ujMpA?=
 =?us-ascii?Q?54LN//J4ukmRqTGN1BQJOTzxVu1ybGorzTQxcoFJN6H/me5he12YhFzTEbx9?=
 =?us-ascii?Q?SXPu2EfYvGXHGqy8hM/dXbZF6QVOFwCST/ya3XYmJCjYyLWRvT5uQ25QfhQV?=
 =?us-ascii?Q?lARC/QUe5Q560KT6DZVDhRcvXJ+K4TG+lLYznDrWGaO4a4ryTId8BPc49vkM?=
 =?us-ascii?Q?mVOP9mIoZwoRIxOg3OLmo8q3mlIciV7iUa5QwwXfFQ/GD1BglJhk1Y7k87vl?=
 =?us-ascii?Q?4rVHGa+C0SwVKfA7xb2FRYbB5RoYyZSzYdrLMU/lQJtEgwSCcPhyDC3NAbVw?=
 =?us-ascii?Q?mEZY0ZB/pqeGN5UXQB/Ex/Rfvc+cLhSiSnhNpXlqu+3Lz9myrxqSe6EsXv/8?=
 =?us-ascii?Q?bQZ1e1w8pwaeUv2yK22qZtboS/IBp+mE6iqz4AvHdMsxwABkqu6OUIgbLMvr?=
 =?us-ascii?Q?WTrE28jvljp+YFVx2I9tWuQVr24pm7hqWHiJB4ig7/On2+SYpt17RDLfvkGX?=
 =?us-ascii?Q?fltn+pfNuzSjWBYzOIt27t29vGiPThRomNSTEfVh7mCXotP2MZkLhgnumfPa?=
 =?us-ascii?Q?qpfJB6s1frvSbf7TIvCFStJsQ24h6IEM/uPfhczmEePiPiGGvksrDvh8eSYK?=
 =?us-ascii?Q?rGCqwfB4M0w2CXhzHXNn0pS73/q/B2B+ZdlTsTNalWjQnTuDg1stCI5939En?=
 =?us-ascii?Q?dzX2+FRPX5+kUucrXwp+pAmsjddycdRlCWFrH2CS/QVb54eZYNbUFUtte4hD?=
 =?us-ascii?Q?fPpvHp8ANYZ4GYqlc+Ldfk3EyOTvZ2ow6Ftrv/G5uacR23OYrsLhgm+i9PL+?=
 =?us-ascii?Q?Qd0keJhThLw6sCusqQgm08jS4u9ipELlclVswxz0ozPXqw/md/t6t3HguLhf?=
 =?us-ascii?Q?92sK0ysggDzMSzRBP0sQukPKKAF9uzIq1LLswky6?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR03MB2488.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59e2c9ab-fefe-4412-d868-08db29564384
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2023 15:17:47.9294
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kU85QDuJMZttq8dQycRbCOxOkDG/GXATsooa1k2c+JsPEKz1/TX+LZ/eyttu3SLzi8+t0u+UqcdEsT3uf2Pz8BHzW8OJghcREqk8c35mVC4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR03MB5992
X-Proofpoint-ORIG-GUID: fNYQwE4w89_JglffEJsZ_4HATcibC5yQ
X-Proofpoint-GUID: fNYQwE4w89_JglffEJsZ_4HATcibC5yQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-20_10,2023-03-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 priorityscore=1501 impostorscore=0 clxscore=1015
 bulkscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303200129
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On 15/03/2023 19:16:25+0300, Ibrahim Tilki wrote:
> > +static int max313xx_trickle_charger_setup(struct device *dev)
> > +{
> > +	struct max313xx *rtc =3D dev_get_drvdata(dev);
> > +	bool trickle_diode_en;
> > +	u32 charger_en =3D 0;
> > +	int index, reg;
> > +	u32 ohms =3D 0;
> > +	int ret;
> > +
> > +	device_property_read_u32(dev, "aux-voltage-chargeable", &charger_en);
> > +	if (charger_en > 1)
> > +		return dev_err_probe(dev, -EINVAL,
> > +				     "invalid value %d for property aux-voltage-chargeable\n",
> > +				     charger_en);
>=20
> This is too verbose, you can simply return -EINVAL here. dtbs_check will
> report the invalid value.
>=20

will do.

> > +
> > +	if (!charger_en)
> > +		return 0;
> > +
> > +	trickle_diode_en =3D device_property_read_bool(dev, "adi,trickle-diod=
e-enable");
>=20
> There is no point having this property, simply use aux-voltage-chargeable=
.
>=20

I will remove this and add enum value "2" to aux-voltage-chargable for char=
ging with a diode.

> > +	device_property_read_u32(dev, "trickle-resistor-ohms", &ohms);
> > +
> > +	if (!rtc->chip->trickle_reg) {
> > +		dev_warn(dev, "device does not have trickle charger\n");
>=20
> Simply return 0, no string.
>=20

will do.

> > +		return 0;
> > +	}
> > +
> > +	index =3D find_closest(ohms, max313xx_trickle_ohms,
> > +			     ARRAY_SIZE(max313xx_trickle_ohms)) + 1;
> > +
> > +	switch (rtc->id) {
> > +	case ID_MAX31329:
> > +		reg =3D FIELD_PREP(MAX31329_TRICKLE_ENABLE_BIT, 1) |
> > +		      FIELD_PREP(MAX31329_43_TRICKLE_RES_MASK, index) |
> > +		      FIELD_PREP(MAX31329_43_TRICKLE_DIODE_EN, trickle_diode_en);
> > +		break;
> > +	case ID_MAX31331:
> > +	case ID_MAX31334:
> > +		reg =3D FIELD_PREP(MAX3133X_TRICKLE_ENABLE_BIT, 1) |
> > +		      FIELD_PREP(MAX3133X_TRICKLE_RES_MASK, index) |
> > +		      FIELD_PREP(MAX3133X_TRICKLE_DIODE_EN, trickle_diode_en);
> > +		break;
> > +	case ID_MAX31341:
> > +		if (index =3D=3D 1)
> > +			index =3D 0;
> > +
> > +		reg =3D FIELD_PREP(MAX31341_TRICKLE_ENABLE_BIT, 1) |
> > +		      FIELD_PREP(MAX31341_TRICKLE_RES_MASK, index) |
> > +		      FIELD_PREP(MAX31341_TRICKLE_DIODE_EN, trickle_diode_en);
> > +
> > +		ret =3D regmap_set_bits(rtc->regmap, MAX31341_POWER_MGMT_REG,
> > +				      MAX31341_POWER_MGMT_TRICKLE_BIT);
> > +		if (ret)
> > +			return ret;
> > +
> > +		break;
> > +	case ID_MAX31343:
> > +		reg =3D FIELD_PREP(MAX31329_43_TRICKLE_RES_MASK, index) |
> > +		      FIELD_PREP(MAX31329_43_TRICKLE_DIODE_EN, trickle_diode_en) |
> > +		      FIELD_PREP(MAX31343_TRICKLE_ENABLE_MASK,
> > +				 MAX31343_TRICKLE_ENABLE_CODE);
> > +		break;
> > +	default:
> > +		return -EOPNOTSUPP;
> > +	}
> > +
> > +	return regmap_write(rtc->regmap, rtc->chip->trickle_reg, reg);
> > +}
> > +
> > +static int max313xx_find_clkin_freq_index(struct clk *clk)
> > +{
> > +	unsigned long rate =3D clk_get_rate(clk);
> > +	int freq;
> > +	int i;
> > +
> > +	i =3D find_closest(rate, max313xx_clkin_freq,
> > +			 ARRAY_SIZE(max313xx_clkin_freq));
> > +	if (max313xx_clkin_freq[i] =3D=3D rate)
> > +		return i;
> > +
> > +	for (i =3D ARRAY_SIZE(max313xx_clkin_freq) - 1; i >=3D 0; i--) {
> > +		freq =3D max313xx_clkin_freq[i];
> > +		if (freq =3D=3D clk_round_rate(clk, freq))
> > +			return i;
> > +	}
> > +
> > +	/* supplied clock cannot produce one of desired frequency rate */
> > +	return -ENODEV;
> > +}
> > +
> > +static int max313xx_clkin_init(struct device *dev)
> > +{
> > +	struct max313xx *rtc =3D dev_get_drvdata(dev);
> > +	int rate;
> > +	int ret;
> > +
> > +	rtc->clkin =3D devm_clk_get_enabled(dev, NULL);
> > +	if (IS_ERR(rtc->clkin)) {
> > +		if (PTR_ERR(rtc->clkin) =3D=3D -ENOENT)
> > +			rtc->clkin =3D NULL;
> > +		else
> > +			return dev_err_probe(dev, PTR_ERR(rtc->clkin),
> > +					     "error while clkin setup\n");
> > +	}
> > +
> > +	if (!rtc->clkin) {
> > +		switch (rtc->id) {
> > +		case ID_MAX31329:
> > +			return regmap_clear_bits(rtc->regmap,
> > +						 MAX31329_CONFIG2_REG,
> > +						 MAX31329_CONFIG2_CLKIN_EN);
> > +		case ID_MAX31341:
> > +		case ID_MAX31342:
> > +			return regmap_clear_bits(rtc->regmap,
> > +						 MAX31341_42_CONFIG1_REG,
> > +						 MAX31341_42_CONFIG1_CLKIN_EN);
> > +		default:
> > +			return 0;
> > +		}
> > +	}
> > +
> > +	rate =3D max313xx_find_clkin_freq_index(rtc->clkin);
> > +	if (rate < 0)
> > +		return dev_err_probe(dev, rate,
> > +				     "clkin cannot produce required frequency\n");
> > +
> > +	ret =3D clk_set_rate(rtc->clkin, max313xx_clkin_freq[rate]);
> > +	if (ret)
> > +		return ret;
> > +
> > +	switch (rtc->id) {
> > +	case ID_MAX31329:
> > +		ret =3D regmap_update_bits(rtc->regmap, MAX31329_CONFIG2_REG,
> > +					 MAX31329_CONFIG2_CLKIN_FREQ, rate);
> > +		if (ret)
> > +			return ret;
> > +
> > +		return regmap_set_bits(rtc->regmap, MAX31329_CONFIG2_REG,
> > +				       MAX31329_CONFIG2_CLKIN_EN);
> > +	case ID_MAX31341:
> > +	case ID_MAX31342:
> > +		ret =3D regmap_update_bits(rtc->regmap, MAX31341_42_CONFIG1_REG,
> > +					 MAX31341_42_CONFIG1_CLKIN_FREQ,
> > +					 FIELD_PREP(MAX31341_42_CONFIG1_CLKIN_FREQ, rate));
> > +		if (ret)
> > +			return ret;
> > +
> > +		return regmap_set_bits(rtc->regmap, MAX31341_42_CONFIG1_REG,
> > +				       MAX31341_42_CONFIG1_CLKIN_EN);
> > +	default:
> > +		rtc->clkin =3D NULL;
> > +		dev_warn(dev, "device does not have clock input\n");
> > +		return 0;
> > +	}
> > +}
> > +
> > +static int max313xx_irq_init(struct device *dev, const char *devname)
> > +{
> > +	struct max313xx *rtc =3D dev_get_drvdata(dev);
> > +	int ret;
> > +
> > +	switch (rtc->id) {
> > +	case ID_MAX31328:
> > +		/* max31328 sqw and interrupt pin is shared */
> > +		if (rtc->irq > 0 && rtc->clkout.clk)
> > +			return dev_err_probe(dev, -EOPNOTSUPP,
> > +					     "cannot have both sqw clock output and irq enabled");
>=20
> This still doesn't work, having a clock registered doesn't mean it is
> used or muxed. Also, you want to always register it so it gets disabled
> when it is not used.
>=20

I can't wrap my head around this. What is the point of registering a clock =
when the pin
is used for IRQ? What should the driver do if a user wants to enable clocko=
ut?
Wouldn't that cause continuous interrupts? Or should the driver simply don'=
t care?

Same condition also applies for other RTCs that have two interrupt lines.
What is your comment on the default case below: "irq not possible when both=
 clkin and clkout are configured"?

> > +
> > +		break;
> > +	case ID_MAX31331:
> > +	case ID_MAX31334:
> > +		if (rtc->clkout.clk) {
> > +			/*
> > +			 * interrupt muxing depends on clkout so enable clkout
> > +			 * if configured before requesting interrupt
> > +			 */
> > +			ret =3D clk_prepare_enable(rtc->clkout.clk);
> > +			if (ret)
> > +				return dev_err_probe(dev, ret,
> > +						     "cannot enable clkout\n");
> > +		}
> > +		break;
> > +	default:
> > +		if (rtc->clkin) {
> > +			if (rtc->clkout.clk && rtc->irq > 0)
> > +				return dev_err_probe(dev, -EOPNOTSUPP,
> > +						     "irq not possible when both clkin and clkout are configured=
\n");
> > +
> > +			if (rtc->irq <=3D 0)
> > +				break;
> > +
> > +			/* clkout needs to be disabled for interrupt */
> > +			if (rtc->chip->clkout->en_invert)
> > +				ret =3D regmap_set_bits(rtc->regmap,
> > +						      rtc->chip->clkout->reg,
> > +						      rtc->chip->clkout->en_bit);
> > +			else
> > +				ret =3D regmap_clear_bits(rtc->regmap,
> > +							rtc->chip->clkout->reg,
> > +							rtc->chip->clkout->en_bit);
> > +
>=20
> What if you want alarm1 on INTA without any clkin? This doesn't seem to
> be configured.
>=20

alarm1 interrupt is muxed into INTA/CLKIN pin by default.
So if clkin is not configured, no action needed since the clkin is already
disabled in "max313xx_clkin_init", alarm1 is muxed into INTA in that case.


> > +			if (ret)
> > +				return ret;
> > +		}
> > +		break;
> > +	}
> > +
> > +	if (rtc->irq > 0) {
> > +		return devm_request_threaded_irq(dev, rtc->irq, NULL,
> > +						 &max313xx_irq, IRQF_ONESHOT,
> > +						 devname, rtc);
> > +	}
>=20
> You still want to parse wakeup-source in case INTA/INTB is connected
> directly to a PMIC for exemple.
>=20

will do.

> > +
> > +	clear_bit(RTC_FEATURE_ALARM, rtc->rtc->features);
> > +
> > +	return 0;
> > +}
> > +
> > +static int max313xx_probe(struct i2c_client *client,
> > +			  const struct i2c_device_id *id)
> > +{
> > +	struct device *dev =3D &client->dev;
> > +	struct max313xx *max313xx;
> > +	struct device *hwmon;
> > +	const void *match;
> > +	int ret;
> > +
> > +	max313xx->irq =3D client->irq;
> > +
> > +	ret =3D max313xx_clkout_register(dev);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret =3D max313xx_clkin_init(dev);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* IRQ wiring depends on the clock configuration so parse them first =
*/
> > +	ret =3D max313xx_irq_init(dev, client->name);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (max313xx->chip->ram_size) {
> > +		max313xx_nvmem_cfg.size =3D max313xx->chip->ram_size;
> > +		max313xx_nvmem_cfg.priv =3D max313xx;
> > +
> > +		ret =3D devm_rtc_nvmem_register(max313xx->rtc, &max313xx_nvmem_cfg);
> > +		if (ret)
> > +			dev_warn(dev, "cannot register rtc nvmem\n");
> > +	}
> > +
> > +	if (max313xx->chip->temp_reg) {
> > +		hwmon =3D devm_hwmon_device_register_with_info(dev, client->name,
> > +							     max313xx,
> > +							     &max313xx_chip_info,
> > +							     NULL);
> > +		if (IS_ERR(hwmon))
> > +			dev_warn(dev, "cannot register hwmon device: %li\n",
> > +				 PTR_ERR(hwmon));
> > +	}
> > +
> > +	return max313xx_trickle_charger_setup(dev);
> > +}
> > +
> > +static const struct of_device_id max313xx_of_id[] =3D {
> > +	{ .compatible =3D "adi,max31328", .data =3D &chip[ID_MAX31328] },
> > +	{ .compatible =3D "adi,max31329", .data =3D &chip[ID_MAX31329] },
> > +	{ .compatible =3D "adi,max31331", .data =3D &chip[ID_MAX31331] },
> > +	{ .compatible =3D "adi,max31334", .data =3D &chip[ID_MAX31334] },
> > +	{ .compatible =3D "adi,max31341", .data =3D &chip[ID_MAX31341] },
> > +	{ .compatible =3D "adi,max31342", .data =3D &chip[ID_MAX31342] },
> > +	{ .compatible =3D "adi,max31343", .data =3D &chip[ID_MAX31343] },
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(of, max313xx_of_id);
> > +
> > +static const struct i2c_device_id max313xx_id[] =3D {
> > +	{ "max31328", (kernel_ulong_t)&chip[ID_MAX31328] },
> > +	{ "max31329", (kernel_ulong_t)&chip[ID_MAX31329] },
> > +	{ "max31331", (kernel_ulong_t)&chip[ID_MAX31331] },
> > +	{ "max31334", (kernel_ulong_t)&chip[ID_MAX31334] },
> > +	{ "max31341", (kernel_ulong_t)&chip[ID_MAX31341] },
> > +	{ "max31342", (kernel_ulong_t)&chip[ID_MAX31342] },
> > +	{ "max31343", (kernel_ulong_t)&chip[ID_MAX31343] },
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(i2c, max313xx_id);
> > +
> > +static struct i2c_driver max313xx_driver =3D {
> > +	.driver =3D {
> > +		.name	=3D "rtc-max313xx",
> > +		.of_match_table =3D max313xx_of_id,
> > +	},
> > +	.probe		=3D max313xx_probe,
> > +	.id_table	=3D max313xx_id,
> > +};
> > +module_i2c_driver(max313xx_driver);
> > +
> > +MODULE_DESCRIPTION("Analog Devices MAX313XX RTCs");
> > +MODULE_AUTHOR("Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>");
> > +MODULE_AUTHOR("Ibrahim Tilki <Ibrahim.Tilki@analog.com>");
> > +MODULE_SOFTDEP("pre: regmap-i2c");
> > +MODULE_LICENSE("GPL");
> > +MODULE_VERSION("1.0");
> > --=20
> > 2.25.1
> >=20
>=20
> --=20
> Alexandre Belloni, co-owner and COO, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com

Regards,
Ibrahim
