Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E03E67329E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 08:40:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbjASHkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 02:40:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbjASHkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 02:40:17 -0500
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B927E613C2;
        Wed, 18 Jan 2023 23:40:07 -0800 (PST)
Received: from pps.filterd (m0134424.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30J7Wg7m028740;
        Thu, 19 Jan 2023 07:39:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pps0720; bh=3w8CwCIa60nNg3L8fc9CIoXJ04OEEbqY1n3A8DbHVw8=;
 b=fJe2PA4951iNV+FlU4H3HVnHslcHeGX1smuyKBmW/e4zYgG5l2jeW+QKHsruQxqR+2X9
 Zrq534SWIDQCzajkjVC/hlGkRXCcueXcFR8mzRmPr/Vc9HKpMC2K5TJMgyWZO1HjLRrJ
 IYO0QA2JelqYNGU3WBwKVVISgWvY8dbWIuGVqgmee+8WCir9Ob7PaHNuoeBNamgiXcRm
 o7teEwl6nlQUuIdZNhPynj4XaBZzzGg0nA0wvpgn8umHSXbAx0suue4q9LZR/QdGcYo8
 toY/zH/4m50YRDV0yfeHV7w8KK7ypzQJq+sKPSRyNNob8N9uWX1CS9XfvLS4qNfL/Wbl vQ== 
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3n6wcya7mh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Jan 2023 07:39:43 +0000
Received: from p2wg14938.americas.hpqcorp.net (unknown [10.119.145.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id F17F7310E7;
        Thu, 19 Jan 2023 07:39:41 +0000 (UTC)
Received: from p2wg14934.americas.hpqcorp.net (10.119.145.213) by
 p2wg14938.americas.hpqcorp.net (10.119.145.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 18 Jan 2023 19:39:41 -1200
Received: from p2wg14934.americas.hpqcorp.net (10.119.145.213) by
 p2wg14934.americas.hpqcorp.net (10.119.145.213) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 18 Jan 2023 19:39:40 -1200
Received: from p2wg14932.americas.hpqcorp.net (16.228.19.38) by
 p2wg14934.americas.hpqcorp.net (10.119.145.213) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36
 via Frontend Transport; Wed, 18 Jan 2023 19:39:40 -1200
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (192.58.207.38)
 by edge.it.hpe.com (16.228.19.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15; Wed, 18 Jan
 2023 19:39:40 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lnEXIvmGEJjfTl+tgrndLiWTPIOK2vhJI4AZcvNAJfwoV05549Qm7kzsDZUKHfl6iUMFO3u/GjVB+Q5Q2KE61WhLO32Pp4StzdghnmIUyAlDkBt9sI9M2qrECpslJhoMws2C4IEDLkroWsc0fpq2SQJNnYXdYEsguUUs7PTQhmwi/0SXaChcDhDXWD+wYpzkscSdOhF/ph6d+T4aaJxsjNt66k9IQk2mYEpukAtvtH6bgAkOyqGKGZv+VuDUBdl6UCkuCMETmJBLhn2/uzBfrH/vdxBW/PKtr/lQMIJS+27FPFDrZ+UR6RHy20MkoKJDwKqEjnod/om7NaDFGDYNSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3w8CwCIa60nNg3L8fc9CIoXJ04OEEbqY1n3A8DbHVw8=;
 b=LoEkXp1ZlSX3H3mHeSyUn3kysSBVViEvs7JT9+y34o9SOv6whFJ1OLkOLjV74j27OFj+ZGpTmBEo7g04Fq7f/fnv3vX+B7FFkoPoBKizXrX7g1oJoHGCAX92qFnpS4ItT3zkN1Ej+oPBV0eQ7lkWYWtAIGF16m8bdfRRJYC3rG0rWDtNuPOrn/62B9KQUqllNFxY1bJD2662dwleT2mSoYut/Tv3Hwuh752iGGQ/gAfy8otRPM5Cfq/uW7Im5NZIb/5YO7lZwZw2um2qQn7VTx+Zvg5Fbbhl/Oxw1xvXVySAz1v223jIP8VqQm2KxEtFxewux/OyUg72YQHlDj+/Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from PH0PR84MB1480.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:173::21)
 by DM4PR84MB1661.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:48::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.25; Thu, 19 Jan
 2023 07:39:39 +0000
Received: from PH0PR84MB1480.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::337:c28a:4e41:d735]) by PH0PR84MB1480.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::337:c28a:4e41:d735%8]) with mapi id 15.20.5986.023; Thu, 19 Jan 2023
 07:39:39 +0000
Date:   Thu, 19 Jan 2023 15:39:30 +0800
From:   Clay Chang <clayc@hpe.com>
To:     Arnd Bergmann <arnd@arndb.de>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <linux-kernel@vger.kernel.org>, <soc@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>,
        "Verdun, Jean-Marie" <verdun@hpe.com>,
        "Hawkins, Nick" <nick.hawkins@hpe.com>,
        Rob Herring <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 2/5] dt-bindings: soc: hpe: hpe,gxp-srom.yaml
Message-ID: <Y8jzsmC3azFgbZLP@enigma.ccjz.io>
References: <20230110042533.12894-1-clayc@hpe.com>
 <20230110042533.12894-3-clayc@hpe.com>
 <110af65f-9c18-524d-a073-ef7be60d1f5a@linaro.org>
 <Y8AIHDizIqu9u9BR@enigma.ccjz.io>
 <48cd3e28-f1db-487d-8971-473dc8c12c09@app.fastmail.com>
 <Y8VUOENIhe72sqMO@enigma.ccjz.io>
 <55f09599-b553-4429-aa79-ca99ccf95cda@app.fastmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55f09599-b553-4429-aa79-ca99ccf95cda@app.fastmail.com>
X-ClientProxiedBy: TYCP301CA0039.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:380::16) To PH0PR84MB1480.NAMPRD84.PROD.OUTLOOK.COM
 (2603:10b6:510:173::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR84MB1480:EE_|DM4PR84MB1661:EE_
X-MS-Office365-Filtering-Correlation-Id: 632b5771-c9ce-4427-cd89-08daf9f051f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yFl+rLesWeNrpcHQN3319u7sOjoURZgX7so52l7glheHwrXQV/fbKU2/Mfq+FkbkFc3v3EV7IQC+lBh6BHndPS6LOxcqDEJJZmvJ/kWxki7VwikqDhTIwbunhVNPWfA5iegR8X2g6Mb74COM4F9Iz9yYjWcmx80fbgqE4YM2f1lagIrvN1nq8GSVQ2kbwijxJpcrs4pOeVwM15NoQcJzLAfsQD47QNzo5tX1MgOwzELN6BJkzwxqeUB0i4VPrpcDgN3gjgcqMp242vJgB+r7MJR2zFJH/xjgAeMwDzZeX06v2IajbZ7jVrpnF1ZC+5MoXMYVF/CUccncr96toEJDgWIAkIsrQG8y3OKNuusmTEi9GOruiBTruAhWQQg1TUHnp5YTZJKpXIMr+tLctNbjcYBeEh5FyzCc3oFc+WuQh+YK977fwnkuFQOcUhyhrrtIlJj6I4ktEkC42CGfnkxvsxy2gQ1senqqkI/YfZV7TEz7PQRVm7LrathUd8PvrMP9Cry6A3sUruk8wzrt8PLl2/UIEFHW8ownrU+RJX4LuldJAGNHkdJeBUENGFiPDFnh6jJaBfCIzf0UJyO9/1kqvSMovkynB5/h/tucJEG5OiApgJnD6Nah51PQ3RgJG9RB7B1zK0Pox1y1WSTZDNtPVw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR84MB1480.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(136003)(39860400002)(346002)(396003)(451199015)(8936002)(316002)(5660300002)(86362001)(6486002)(478600001)(6666004)(6506007)(2906002)(54906003)(83380400001)(38100700002)(66556008)(66946007)(4326008)(6916009)(8676002)(7416002)(66476007)(82960400001)(186003)(6512007)(9686003)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?L31uKCUtoZNKZ7dITOna4t4IUf5tECZkctYe62V9K73ccmQkJEqnPwyssIng?=
 =?us-ascii?Q?J6aVRTR/tOgdF4rzK6AhSdFf5X0Eai2nf9GaSxVOsFInm8hMit6HXEiWpcGJ?=
 =?us-ascii?Q?yPTYYPsX9am0mnsVXf9ey655pyhBfdafqurjMpESU5Kf3eH7RFFFjSPODd6w?=
 =?us-ascii?Q?pVjEserjxP5b+fmL22DR4xh3NQzHxzESm02YNx6Cwo8XAi+hcgkzA99fRK7S?=
 =?us-ascii?Q?GuFBp0cAA+Ls6qCE6Wg3ggdhp5YhO3/eDDH8+AlcPgFsrPx120Ul4rOP8O0D?=
 =?us-ascii?Q?TMOe5i1h6u2rDSUxw1NZOxMuuzAl23U5MndM+LI7G002HflS94hHRA2ZIXp5?=
 =?us-ascii?Q?9BgY38uy6eVPb55sKRAwFeRv5chK4pk/y2nmaJDJCaA5DcVMBs+NH0skR58m?=
 =?us-ascii?Q?7niqzDcUqErVjU6U8ckWcpYVyAKeGCa2gAWJ2IzTp0b3wIwJF4wqYmnJ1ltK?=
 =?us-ascii?Q?mURbYMN9DgHgypNHweVDYC3gPYcCIx6B1KC4R/+GWSBdLRZqBR498bb1erPB?=
 =?us-ascii?Q?f57fGeUHriYd60lZ/qTB+eWUyvEsc5+VAGxGwOoVa7FYP7DJ8id9TwtIx6W5?=
 =?us-ascii?Q?SMB5acKfmLJtj1l21mLy+Lz3URQ3gaUWe6bIdpia9OYh7qYTuLIBY8YTsWJi?=
 =?us-ascii?Q?LnAU4s2lH61Rpe/0Z+jYGV6UBqAFnsZTF1xVSuDoUa0FMOEWiHIkoXpTOQ8i?=
 =?us-ascii?Q?emsNZoXj7CVUPsLKvJOLW0OY7ZPpVGzX82xpGpTb+5hvVQE/+hn+Gkj4dPEt?=
 =?us-ascii?Q?El6SWOW6qp3MK405siN6PH+iElrsrkFXCdLmmz84aV0Qjy8tMumaxefO8i7i?=
 =?us-ascii?Q?R1VsrMXndicYUWYXeWsQ705GPqwfaet2wiT9+vxiKLrxURjcBFW3QjtSIFna?=
 =?us-ascii?Q?iqEbN8V36TLdnKXabbI2a7ZjQI0BtsUtDfqGvBBF+HWdaFG3zM1h61jEncXd?=
 =?us-ascii?Q?/FAgi4S3xVqj62OJyVu8EVJWvvaxazT5E5JSGwUaGU813Uff9OWNn2/lPr93?=
 =?us-ascii?Q?QRYzkTzrRJXrCs2Ph6eMzraqnqO2iP/ByCgd0s8SCz6ktkCfH3PJiDwbkSBC?=
 =?us-ascii?Q?/23vMuDzK8T+LgMvawgq0fGDhUu7Nqgx7O6nVdlY2zv0wGdoXulQ822NX4DG?=
 =?us-ascii?Q?q0EH3JUOVNckoEFxsOiJTtoWBPJKsfQ3Ak5ZlrnRLQuLIuWWb0MwncL+d8nT?=
 =?us-ascii?Q?bXGTn/KYv1SGfA1hP0e2toBzAw5ckGpBgH6jvsKOxhJzCFBsUaNcUwGltpTK?=
 =?us-ascii?Q?PlKDEqKd0VGcedGBAs41qFQu7tRDGL0Dd289rN6hac5K1NqDeZML7Qq7gyAh?=
 =?us-ascii?Q?F+a60sJQhh9wSew4xjCKgyH84vHBhGTSdyB6aUmYZT85tuyXpNxY/0dNBFRR?=
 =?us-ascii?Q?PucTfwvauOdZ/Hqe7CMMczv5sIwvjCFcdsk1zmRYsiG4OLlB+qrix6nWYp6D?=
 =?us-ascii?Q?wDFFIh2/zgJl18DJiIzv0pjE3iW+ojiTmMYK9sb2qKk7jqBGbrcz52EeT53Z?=
 =?us-ascii?Q?0vwYXvp36i9L6P8R4QlAOrPhMZEc+cfVU5Z+6+xVGGgN2J8Xbc4EfMi6yhK8?=
 =?us-ascii?Q?0zg2cKHD3An8xsgspM4fgA4e5CXcgsH641rr3KIPVZPS1ECK4/3RZ0OOTGEm?=
 =?us-ascii?Q?WQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 632b5771-c9ce-4427-cd89-08daf9f051f0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR84MB1480.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2023 07:39:39.1048
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SV+6bXtXcsZBGZZq6tyy7Y/ShzT/u8VoS6ODIY9GlkYyNoMW0UC489KHxfp32ai2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR84MB1661
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: D4dnwJK9ThEuoZkr9g3YLWc1bJHWEEHe
X-Proofpoint-GUID: D4dnwJK9ThEuoZkr9g3YLWc1bJHWEEHe
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-18_05,2023-01-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 phishscore=0 spamscore=0 mlxlogscore=762
 suspectscore=0 adultscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301190062
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 16, 2023 at 04:18:59PM +0100, Arnd Bergmann wrote:
> On Mon, Jan 16, 2023, at 14:42, Clay Chang wrote:
> > On Thu, Jan 12, 2023 at 02:37:53PM +0100, Arnd Bergmann wrote:
> >> On Thu, Jan 12, 2023, at 14:16, Clay Chang wrote:
> >> For the user interface side, I don't really like the idea of
> >> having a hardware register directly exposed as driver in
> >> drivers/soc, this generally makes it impossible to have portable
> >> userspace that works across implementations of multiple SoC
> >> vendors, and it makes it too easy to come up with an ad-hoc
> >> interface to make a chip work for a particular use case when
> >> a more general solution would be better.
> >> 
> >
> > I agree with you. I have one question though: if we create a 'hpe'
> > directory under drivers/soc, and put all HPE BMC specific drivers there,
> > do you think this proper?
> 
> It certainly wouldn't be right to put "all HPE BMC specific drivers"
> in there. Most drivers will fit into some existing subsystem, and
> should be moved there instead. drivers/soc is used primarily for
> drivers using soc_device_register() to provide information about the
> soc, and we also use it as a place for drivers that just export
> soc-specific helper functions that can be used by other drivers.
> 

Sorry for not saying it clearly. I meant to put those HPE BMC related
drivers that are "not specific" to a particular subsystem in
drivers/soc/hpe. For those fit into some existing subsystems go to their
designated places.

> >> Again, it's hard for me to tell why this even needs to be runtime
> >> configurable, please try to describe what type of application
> >> would access the sysfs interface here, and why this can't just
> >> be set to a fixed value by bootloader or kernel without user
> >> interaction.
> >
> > The register is used for communication and synchronization between the
> > BMC and the host. During runtime, user-space daemons configures the
> > value of the register for interactions.
> 
> That does not sound very specific. What is the subsystem on the
> host that this communicates with? Can you put the driver into the
> same subsystem?
> 
>     Arnd

This is a control register in the BMC chip that partially controls host
boot behaviors. When writing to the register, privileged mode is
required. That's why we rely on a kernel driver for writing to the
control register. And, there is no corresponding subsystem in the host
OS. For this case, is it acceptable to put this driver under
drivers/soc/hpe?

Thanks,
Clay
