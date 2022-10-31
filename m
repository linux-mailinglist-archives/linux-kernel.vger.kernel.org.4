Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC72613467
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 12:21:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbiJaLVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 07:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiJaLVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 07:21:43 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A720ADFBE
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 04:21:42 -0700 (PDT)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 29VBAP2i026674;
        Mon, 31 Oct 2022 07:20:44 -0400
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2044.outbound.protection.outlook.com [104.47.57.44])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3kj68w21c6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Oct 2022 07:20:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dfp84nBT6gEUdpOXj343A8QO6c2BVtfmofGnzKJp7O497UdOCUeEs+8PNBKpnzCiah3Xjj+NGOVunTsTHkXlG1fx0ldvErcBEaacVww8nEEk4qHvk3ygaoU7urQKooSoE57j8WHpcuB+0JveTmTCJh03TVclBp9FoUqiC6FIrlhnWNLXJpkL+hEs2cCxN3w/Wt/wi1bmcZsAXi/HAtz+AJ+jVGBrhWJZ/u6QgA7b5Lo2xFNi4sFIaywfmAqvCGBrbysN/IwlwcDW6v6fdeYwiPjzq2en6f5xXTmtibdTxyEbjPRDF0Tz5jkwAFW5C9/zdbmVQTVkhwMged8/p9SG0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uXjb5rb4RVn2iHyx7i8P8n9E2pA7tlVYDOPR+cKIYgA=;
 b=nkqAjnEHelwn+MrOvp/5P2aZxfJZX/OgGoga1+vBrodK3DMz12j906PiFJHax8jsoy+Z3riJeUNjZuxOuQUnazMRHubUb8mgRxePylIz564oofQamlugzCbKY2qbTW0WwXCfWR2D0co/zVzRIYCfMKojE3coSlZzrQ6eJlV8kVWrD+UaVXVRdVJVS5vP+fpFdf6ZMcUp3zsqYN30wq0Kiyfbngfo4Ipj+1t/1lhRDB2IhvZq+H9UGfucOqVkE4x+uxXYKUSFyfuAevJfLJDPSeq5UOcml/yp2/de1p+xjnwyMGDrIAKrptoG2QeGwx07VGtzv36fexim25MAAOv1XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uXjb5rb4RVn2iHyx7i8P8n9E2pA7tlVYDOPR+cKIYgA=;
 b=bz1sohtRifENHfksp/uq6v7Hbuo12DytLLYKX4hXeoU77MzMuOP8OYZxAIRSlN4yyE1qqQnD78ysACS4jVpsz4+M9IPmMSx8a7smjX7Z0XCUtWZWOylGwHNCw4HK5QtM0SdJqQe4JqKe+kzActFt4Da/Q0vMaaLBhHvHT8TH2bA=
Received: from SJ0PR03MB6778.namprd03.prod.outlook.com (2603:10b6:a03:40d::22)
 by MW4PR03MB6635.namprd03.prod.outlook.com (2603:10b6:303:12a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Mon, 31 Oct
 2022 11:20:42 +0000
Received: from SJ0PR03MB6778.namprd03.prod.outlook.com
 ([fe80::bdbe:d510:d09e:8abd]) by SJ0PR03MB6778.namprd03.prod.outlook.com
 ([fe80::bdbe:d510:d09e:8abd%6]) with mapi id 15.20.5769.019; Mon, 31 Oct 2022
 11:20:42 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Maarten Zanders <maarten.zanders@mind.be>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/3] ASoC: adau1372: fix mclk
Thread-Topic: [PATCH 1/3] ASoC: adau1372: fix mclk
Thread-Index: AQHY6uG2O57QBw25i0+j33gkklPZ4a4oX71w
Date:   Mon, 31 Oct 2022 11:20:41 +0000
Message-ID: <SJ0PR03MB6778A0EB0CD15A3A917BFE4A99379@SJ0PR03MB6778.namprd03.prod.outlook.com>
References: <20221028152626.109603-1-maarten.zanders@mind.be>
 <20221028152626.109603-2-maarten.zanders@mind.be>
In-Reply-To: <20221028152626.109603-2-maarten.zanders@mind.be>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbnNhXGFwcG?=
 =?iso-8859-1?Q?RhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?iso-8859-1?Q?OWUzNWJcbXNnc1xtc2ctMGM5OGM3ZTMtNTkwZS0xMWVkLWI2YjktYmNmMT?=
 =?iso-8859-1?Q?cxYzQ1ODgyXGFtZS10ZXN0XDBjOThjN2U1LTU5MGUtMTFlZC1iNmI5LWJj?=
 =?iso-8859-1?Q?ZjE3MWM0NTg4MmJvZHkudHh0IiBzej0iMTA4OCIgdD0iMTMzMTE2ODg4ND?=
 =?iso-8859-1?Q?A0MjYyOTc0IiBoPSJaNThzN2c2ZkpYOHdoam03Q05xU01Rd3hucWM9IiBp?=
 =?iso-8859-1?Q?ZD0iIiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQU?=
 =?iso-8859-1?Q?FFb0NBQUErQVBIT0d1M1lBUUE0Z3NGdC9zenpBRGlDd1czK3pQTURBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBSEFBQUFEYUFRQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBRUFBUUFCQUFBQVg1bDJLd0FBQUFBQUFBQUFBQUFBQUo0?=
 =?iso-8859-1?Q?QUFBQmhBR1FBYVFCZkFITUFaUUJqQUhVQWNnQmxBRjhBY0FCeUFHOEFhZ0?=
 =?iso-8859-1?Q?JsQUdNQWRBQnpBRjhBWmdCaEFHd0Fjd0JsQUY4QVpnQnZBSE1BYVFCMEFH?=
 =?iso-8859-1?Q?a0FkZ0JsQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdFQV?=
 =?iso-8859-1?Q?pBQnBBRjhBY3dCbEFHTUFkUUJ5QUdVQVh3QndBSElBYndCcUFHVUFZd0Iw?=
 =?iso-8859-1?Q?QUhNQVh3QjBBR2tBWlFCeUFERUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFBQUFDZUFBQUFZUUJrQUdrQVh3?=
 =?iso-8859-1?Q?QnpBR1VBWXdCMUFISUFaUUJmQUhBQWNnQnZBR29BWlFCakFIUUFjd0JmQU?=
 =?iso-8859-1?Q?hRQWFRQmxBSElBTWdBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQkFBQUFBQUFBQUFJQUFBQUFBQT09Ii8+PC9tZXRhPg=3D=3D?=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR03MB6778:EE_|MW4PR03MB6635:EE_
x-ms-office365-filtering-correlation-id: b14b09c0-3835-4679-405d-08dabb31f253
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r0Qk8TwVae1Ti3LoBRZNQWltugf5dyo3sP2nolMzATyBwBGWKvdLZA7BDUbqRHMTZlhlZp/bnZBsLi4FYOWjcAg0aT0h29hEa17F/57D5ORkjUbRbUVZD8mTT9PChXJ+lF1VIMZM6XfSVs/nLUtxJ3SW1zjlaTN0Eu+OVOmFjDM/+G3roT5cUCfHpGtQZgxq0jPFGThOi8ycVFxKQV3iDwMkEBILCCOPV6H+uk2QxHXeNzAA1MftLoYScPE6xvAs8dGcFsuSY8Bzv2O/YbeGEebLS3Hi3GnoMCWueMptiH/rYLc/3VCPMc4M0xcFrZg7o6QpMxCZXYSb28Ea93kbD+I5ekLrvjKgJBojVcseJSCxD7IF9bko1GrGB08329KFqN/KN/eJ/8hviPjP1SFEmISbdbLxyOdDWwYujPvu/Y0klEmQfe+RD/I2oQB8euxrpuXl7rURVozBSjgNHMLoal1LtVG/yG8o2rnGW10K3lNyblk6n+f8u9LHbA07ugPZKX6Ej/uhAC2FRCa05cBEhKqQenpJ33epHzz8Dn3qzQtJAggMkJybYc7Ks71adm0a9WbFctvwcIvGEXJyFKb6XS43wq58rWy2x+X8JE71bSEulN5Wud65rxrixCP0vqP1v/88sW41AT00xc1/G8eze/z/GNB2S5JUmFzNVgWdoGJRLevjL1mvh/WZlDl9frtUZNrlAamVItWNtFS5GrHGZhnhPA34vBPbFjVT5/otvP15Cfcwau70Ydduts4+E88bX6GOtuBAfjeJLXfX56SC4Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6778.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(346002)(376002)(366004)(396003)(451199015)(38070700005)(55016003)(33656002)(86362001)(38100700002)(122000001)(110136005)(54906003)(8676002)(316002)(53546011)(478600001)(7696005)(6506007)(71200400001)(9686003)(26005)(76116006)(41300700001)(8936002)(5660300002)(4744005)(52536014)(64756008)(66476007)(83380400001)(66946007)(186003)(66446008)(66556008)(2906002)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?gEHxsWvAHwETe3l6vyFV5qGtcpzdsORFx900NcKCY071NSQwyGczjIC2V+?=
 =?iso-8859-1?Q?xP7jyqb1fv37ZBIPnLisO1JikopQ7UDtvcLMhohc8a0Ck5Cc+NNUJ5/ctB?=
 =?iso-8859-1?Q?hQnkMM9zKYs6f13fgmWSIuqPtQcLjIbEULuBF73QIoN8HFNaD7KSz2dk+C?=
 =?iso-8859-1?Q?fCmHoxJ204XHf7VtLld0T4lCfWxpDT37PxlGvzCYdo8a/WZt/yqqa25ftA?=
 =?iso-8859-1?Q?uJD3OBk2b6bCRoyouTx5qfoWR0EQ2KLo7NlUsiw9PtgHsz+PI1JuYKzqrO?=
 =?iso-8859-1?Q?Jd8YuWgRxfXuO66iS6M+zNxx+mxP0Dch+6pZBpkHbABJvKM8goJkj622gI?=
 =?iso-8859-1?Q?o3H6B/Z2wDAYPpAse7vIen7A7dGjU0Bweza1JM2djh9H7g/9quEGd7JEvs?=
 =?iso-8859-1?Q?eu9j5SU75aieA4FFnbVkcpJ8/ADbfA21F7fSA4OaFeKGCOfKlF8veSqt+K?=
 =?iso-8859-1?Q?qc/kJ/5STEFx232KWRISCJwVBUtceKC//VAx9g6cNNcTJUp9iacBI5Ds9z?=
 =?iso-8859-1?Q?Vx2EGVUbWRGdcla8NsfkQZkjfmShyOfGZZbPrOmXLHnAGQT5t8XFMdE8kD?=
 =?iso-8859-1?Q?61Br9E51pX0DPUzsww5vRAlFsBF93FYYgkcSzO7ULnTrX7YxElDH6Q5GAV?=
 =?iso-8859-1?Q?LEXvR2pR5JCQNaLRJSOXnzKJ3mUhILObkEyE1lDIoMewnRS42QqCeQAcI1?=
 =?iso-8859-1?Q?Nj+kRpDPY/y8uVrNnCdeNwbcxqOUj26WI0/tcIrnt4+rGG3p2+QInr+VnP?=
 =?iso-8859-1?Q?aO94LzEE8cdMcfuDfGIGLdtuyCCpXWtRGea6L1huDl8PGK3bZ05faqhfUL?=
 =?iso-8859-1?Q?GNzJH+1QkFZniS6OVzavvnEqi+NmzEz2/V5x2qyWYLC60tRQaRLPGFEQ59?=
 =?iso-8859-1?Q?VuVzUHY+c7mVD5kcfR5JZ4w07lEMptiv5efqTt70iIBUjW/nmlncggw4kl?=
 =?iso-8859-1?Q?VGBvSXamapGwQWf4f1y2uy4cUPRftaYfMPF8SZrMgn1pj7vH0Osjh0tBdw?=
 =?iso-8859-1?Q?1OIUc9UxKgIq7/Rc82lYy1jR58+FOe1C3ZN+cicEPWRYhbiiST+dzo9Lob?=
 =?iso-8859-1?Q?CoYuFrgYMd0ZlnFL0BX06f8oI9rL/lCA3tpCaBJd3L2QFWpxwe5oeTi04f?=
 =?iso-8859-1?Q?D4EH0Wqy+LNbYiEODPzdwJDEkOr+s08vHQLKi0xj0dLojb06bi6bd7iF2N?=
 =?iso-8859-1?Q?f1agmVYyDNettHfcrApCfcsGcupQDwttmUZrTGFAFCCkfe4zvAXUhVamnW?=
 =?iso-8859-1?Q?Nabl/WIte4wbXbxjUk1ByiH07M+WsTE44rGX/q7Gl9FL8EQR5p3pS7UOS7?=
 =?iso-8859-1?Q?naDmNcFIiRiLj1HKXxrrqPqiQIzZcw9meH0c3PVYMXwfKlA1s/tY1rlbJ2?=
 =?iso-8859-1?Q?ImxBlH05dz7G6e0iHz9i/oQwiaWZR6/s/dgvjKp6BNKZ/WlEAFE3zIDflQ?=
 =?iso-8859-1?Q?mTlkbGEawVYch8yKhdBlCYKgKM70yHnozDzpAn/tIuaeAWNrdPq3fi0bnG?=
 =?iso-8859-1?Q?LuL1M+ixuRTZ91GSK1UBXT8biL3pxZNuaB4bVwLBK7sS6UEi0w/nDrhBti?=
 =?iso-8859-1?Q?9w3yLC2Jmq6CRfeCS4LXDuBmW7aC9RIbjcHSn8NlCLXFjChpRewuy/zyzk?=
 =?iso-8859-1?Q?RSZ7/tRGNd735XY3K+0EGmhgF0gui/q6cD?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6778.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b14b09c0-3835-4679-405d-08dabb31f253
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2022 11:20:41.9055
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iFR7VJgqsdjrnxgwTBKn8DEIobJMzVw81PHiXT+T/BgccHb6EZUr0vTfpcjBZwlxgmfRAOox1938jr+CJMtfdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR03MB6635
X-Proofpoint-GUID: nQOfb4wHRDQhJnQd0HFgjSlSXrzh87bV
X-Proofpoint-ORIG-GUID: nQOfb4wHRDQhJnQd0HFgjSlSXrzh87bV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-31_06,2022-10-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 suspectscore=0 clxscore=1011 impostorscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 priorityscore=1501 mlxlogscore=672 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2210310071
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Maarten Zanders <maarten.zanders@mind.be>
> Sent: Friday, October 28, 2022 5:26 PM
> To: Lars-Peter Clausen <lars@metafoo.de>; Sa, Nuno
> <Nuno.Sa@analog.com>; Liam Girdwood <lgirdwood@gmail.com>; Mark
> Brown <broonie@kernel.org>; Jaroslav Kysela <perex@perex.cz>; Takashi
> Iwai <tiwai@suse.com>
> Cc: Maarten Zanders <maarten.zanders@mind.be>; alsa-devel@alsa-
> project.org; linux-kernel@vger.kernel.org
> Subject: [PATCH 1/3] ASoC: adau1372: fix mclk
>=20
> [External]
>=20
> "mclk" is retrieved from the configuration and assigned to adau1372->clk.
> However adau1372->mclk (=3D=3DNULL) is used for clk_prepare_enable() and
> clk_disable_unprepare() which don't have any effect.
>=20
> Remove .clk from struct adau1372 and use .mclk throughout.
> This change ensures that the input clock is switched on/off when the
> bias level is changed.
>=20
> Signed-off-by: Maarten Zanders <maarten.zanders@mind.be>
> ---

I guess this needs a Fixes: tag?

- Nuno S=E1
