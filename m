Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6B3B609D95
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 11:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbiJXJNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 05:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbiJXJNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 05:13:12 -0400
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 592035AA36;
        Mon, 24 Oct 2022 02:13:10 -0700 (PDT)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 29O8uWBv001555;
        Mon, 24 Oct 2022 02:12:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=PPS06212021;
 bh=1i+bnQ+N8ER3goQwjY56qvcmWkfIF2EZs4CgJMd7H30=;
 b=CDEwInpNrTYy9qsL456H8pCw2ZfRqDBro11dUs6+8sFTk9Omj+hwT3ZEbIB6cqHr2ukf
 CBGK4XhXHFKlYmKMkNMdl5mkm/z545fHnr5NYulzVKi1UqAWX74CKkAPUDGzN0q3zdgw
 8nAnjinKCEPR/QIWCQ7Mb0WSf02Pxxml0W8SQjL4AHw3cAW44oskmxOk7be9nmoHxyIn
 36J70AeJS5Xxv8lIhFVJx9utzfvAboeMrqFrQeo2DJ/eRyevyA61hZZvGUmP4CfOZ0xQ
 0weTfTATssl+wgrkc69nGxWYTYavBWVtxOOUHPFe4SWLrtHrXPd05BHDgFOUq5Z4k/f+ dA== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3kcbt51wrd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Oct 2022 02:12:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S/t56r2+jRPpk00B9JFTZQtkwpjgFy9rxHFajZumB44mo6rDNhP+7u4go//m6m+i2wyFVMLdA3YAupofjB6B2TpRonPsdgT3xT6YVskGW+x2SfqocdLLVQKmfFKfLHaX01N5eihTS5oaabHdQcuE37XXhYUvlJvE/1JzNIbK00b0rt4RwbEH3tdfI5i7NX0TjA4UcGALyUDYW75AETaG/3XdMRl3Tpisii9EiIpRAlEEGJwD8BSlS2BO3TF5U90/VahyxfFNWhcZWHPQs0KTLUAjeA/tzkr8qEdvHgsjao3jg7ZZLYZ9g7Yp5wTeF5i7dPARvhfI5YBSyfE1w7vySw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1i+bnQ+N8ER3goQwjY56qvcmWkfIF2EZs4CgJMd7H30=;
 b=MXL6c/j9nlvZph77U4UkPq4jHWmyPqIWnq0RAzTOK4YUwV3x2mz7BbnwBbEGSkaEDfyjkEoUpt7ibVIZqkX/RSVsvxBoUCxSFU/LWSpmMn4fqFAnMn84EDXaufgE+uz4+KyHFzaOEOgjcLKwyavl9dqElAliogtnV0unOZxa2BY/6lU4dahqVHAGTrXKA1M5eXP3JZpiYNEvD+YsoXs5CqUfKkFjhhvw0o0b62soq69oWdMp26acGnUrxiYWR8aMX/HLounvB9CPB9TOOTohW3rK07V4KupYw966tVRD0984e1z82KgxcOcgnLsNismWT2B1S97zb0rzs5yluIFfZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MW5PR11MB5764.namprd11.prod.outlook.com (2603:10b6:303:197::8)
 by DM6PR11MB4721.namprd11.prod.outlook.com (2603:10b6:5:2a3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.27; Mon, 24 Oct
 2022 09:12:37 +0000
Received: from MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::9824:acbc:5799:6cff]) by MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::9824:acbc:5799:6cff%6]) with mapi id 15.20.5723.033; Mon, 24 Oct 2022
 09:12:37 +0000
From:   Xiaolei Wang <xiaolei.wang@windriver.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org, lukas@wunner.de
Cc:     fugang.duan@nxp.com, sherry.sun@nxp.com,
        ilpo.jarvinen@linux.intel.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] serial: fsl_lpuart: Skip the reset for the early console port
Date:   Mon, 24 Oct 2022 17:12:20 +0800
Message-Id: <20221024091220.1619822-1-xiaolei.wang@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SL2P216CA0214.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:18::20) To MW5PR11MB5764.namprd11.prod.outlook.com
 (2603:10b6:303:197::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5764:EE_|DM6PR11MB4721:EE_
X-MS-Office365-Filtering-Correlation-Id: ff128b12-dcee-47e6-d3db-08dab59fe52e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WefFjpbXWRUrcF0D4WuNVrbuipz9D7ndiK/fk7otRUEQIm2QlS4d+DDZvA2TnzzbydJvuSt+rQtWw17pd+pXFxVuV7IL7hu+r/f3RhNu+cXfiGzs4JpzTSHiaOGLKXsSS7IqetKlMWAjNssvKGdaEGpbP3h8fuY1U7EZmTQV2hqKsBDo2ms5KmctVQ23NEc3FZsOKBJpa6/LxeQNYtyGk5gtUbhAZY50U24XuSyUhSKjjXhpimUDphOxvvRXgn08zBkOMNA02Qth5YYZnJwf9JxOPKN7kpf5kganxAWQBSpOr082wkgIIScC76N6VVIkh9Hg0PhOqCEw1eZQ7fS2zLbJsxmuk/NIhP81dsCnjG/6lw/rZsTImAiLZQn/b/y14JuhCgg6odfdUeDQ2jwVLUBnmlY3htf61A7QCWQhZEbjJIYzFcINlgBBkxSBKYZSWveB58TcovQ3Tjj8BtmUOS3XmP7IRAd/pmETo8U5IvhkF3AYgn4vNXhMoZo1MYd+V5N1k0Yb//Q7HHlM/kRBAmT0puG/d7rkI77P5gfSkHJngrUNc+RP3yEIHQaDlA5i0a9cA06HcqJ+4HvWFVqh7chct/2ThFi5Yo4cLYmc1jy2hfXjVrGT1LXE7FAgkbExgFR6UjDuvtiVyA8NhQQuJ48QQ43VYTen6tTN2sTWud9Ke8x8DlP5qZamgGZIhW1f6h+TxXao4ol5AcfYNKU55HEMlVq+sZgSC/X2qfcNpDyrHgaUT7u/nb0O8cOpX23iORA7ukiJakLuSIzYLBecUg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5764.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(39840400004)(346002)(396003)(366004)(451199015)(36756003)(86362001)(44832011)(2906002)(38350700002)(38100700002)(1076003)(186003)(2616005)(83380400001)(6506007)(52116002)(66946007)(4326008)(6486002)(6666004)(6512007)(26005)(66556008)(316002)(8676002)(66476007)(5660300002)(8936002)(41300700001)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kLby+DvxTYAmbiePREo5JCpNfKwTEzxRbMJ7NuPe+ny4/sp8E15vx8RThmfZ?=
 =?us-ascii?Q?/Wz78u2zYZNWN2K0GxEkKlDDdmK8d+EH5btKEZSvziuorTUCTIx+OK9979OM?=
 =?us-ascii?Q?8i3J96lIoIysvpfFsQB5uQ0YsavrqJf/6+wt4QR3vwpX1CrxWPyoQL4vy7Ob?=
 =?us-ascii?Q?a+s/afCjc3rxUkzEQAWhplP9muT6VU2aEavn3cbQQILiWptrsU74kQm/eGt5?=
 =?us-ascii?Q?qrJB9qELF18gy3UZlpfWkLZUTgnjCVwKqRNae5YjmOcieEyCYVtm22ljV5CC?=
 =?us-ascii?Q?cdbAhS7UmYAWiS6DrVOukmIVFA214EMm5RTa8HOpnPnfSDmtY3YLaBNuApRI?=
 =?us-ascii?Q?iKmBmrX1O88rfEvMRa7aUO5jlxbDeNoh6HtMZ4rldUZ7+BnfXnp2f7z/xdvt?=
 =?us-ascii?Q?1hdqHtnNxRiSCPG5CNIukr7aPeAcvikt0ueD5Slh1BMPuIhXLq26WEXbBr8G?=
 =?us-ascii?Q?W1zzkXrVg27jMbki7pLbUI/bqqpm24mgFvAu5czdUiICtnCKG4g0irFCh1K1?=
 =?us-ascii?Q?NYTt0p0bgRJdRGPziOk0jObySc6AQMiqtwxeadbx8A0+VuEOOHzxDM788fqA?=
 =?us-ascii?Q?3p/ZnMx9EMiNA3obLWxd33ExoHVSMINiQqKuiQIz+VYIHkpWsm0AQ1WNCG1N?=
 =?us-ascii?Q?GNzPhppmD8OFdRBpAAda/p1cvQwrRUrvH2JBF3FpUl16UEJIfVJWjEUZBk+G?=
 =?us-ascii?Q?I0Lode5Df/CJn/aRnnFo0xBA4m58KdiiXpCc1c2NTwRLGYP0ON0j9pAiTOQj?=
 =?us-ascii?Q?NpBF1nZkhyC9QsviHIb35HjwIujVivOKGWFc1i4oRNV/gqs3dIjTq/NTznu8?=
 =?us-ascii?Q?yg2SAfJjA4Kw6n3OhWDHf41IyqHUNn7WRrXhbRMOvjEgliFgmst9eDXyHCnC?=
 =?us-ascii?Q?59r1F2OeENQGaYCUCpUW/rhtcFWUhW1bG1JflmUM0YReckVhCaJMowZ2xGiX?=
 =?us-ascii?Q?Doo64hhBW2iH31KEcDQXOhCQTuK80H52mpVZ+EkIfBdafkOfktMO5UyAKjtc?=
 =?us-ascii?Q?eCzr2ckcqV8rnvtYUfsfkp8/M/vjKd7oP2JQw7usFK9Bd/PHJorzmXqWkSs+?=
 =?us-ascii?Q?QWrN/GwzSHad4hxrt7NGAWowKkXfDAwdJToAmC/RzGMVRi4Dne1QkQvUbLzu?=
 =?us-ascii?Q?AD+/dnoniU2Uw9b7qmQkY6FCMbp6bKDAXAyGSOAIW4SxJ9E+otPo2c/egdpI?=
 =?us-ascii?Q?lg4rmVP1K5sHpto0RnDyMmBmWbF6wQn8F80tqn4OgJYm6lkSFkfhV7nnhNZv?=
 =?us-ascii?Q?eXK1lP4CtV0e9yqoObHy7Neqs05Bmvssetj4RS2/LxA8wzYocekLq8wMMirx?=
 =?us-ascii?Q?xtLI7fDr6z6nv7o/F6r+KZNDRe4hIpW3zNDUgWZfQz7IqNscER+PoDns60Bd?=
 =?us-ascii?Q?9PdIehZNgxlYkTteanF6taka2EXs/4TmbncwJriVRyTP+RxjdwsfazFpuC2/?=
 =?us-ascii?Q?uUNjhOoU7OIIFVkRREinDVYV+LuvrW9ZKb2uop2gq7keAPVA9jq7S9A9rkSl?=
 =?us-ascii?Q?tKJFk5/sklHsoceDKSgkSEDStFnVpVcVAloUIdW+N/zlRQ15jXTDZBrgP3GY?=
 =?us-ascii?Q?fmEpOogzMmkd8nl+acfnYy5guLqCXbww4wtFy3/kPn6IaWDvByFmsVzWYe6u?=
 =?us-ascii?Q?Lg=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff128b12-dcee-47e6-d3db-08dab59fe52e
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5764.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2022 09:12:37.8336
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +k9gL7NVu+/gRkq6NaK1y0ztXZQL1exbdcogg0/jHR6LHFKZYtuhaeU+xSaUltnRbLLXU4F+dlEtOOM8Q+jH55bCH/IystPgfNgDjuGhWHw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4721
X-Proofpoint-ORIG-GUID: FT9xUM-goo1Gbh8uCJQId4m071VvhU3I
X-Proofpoint-GUID: FT9xUM-goo1Gbh8uCJQId4m071VvhU3I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-24_02,2022-10-21_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 clxscore=1011 adultscore=0 phishscore=0 bulkscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 priorityscore=1501 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210240058
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 60f361722ad2 ("serial: fsl_lpuart: Reset prior to
registration") has moved the reset before the port registration,
this change makes the uart_console() in lpuart_global_reset() no sense
since the port is not registered to the system yet. So drop it.
But we sill need to check if the port is used as an early console
before performing the port reset, otherwise the reset will hang the
system.

Fixes: 60f361722ad2 ("serial: fsl_lpuart: Reset prior to registration")
Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
---
 drivers/tty/serial/fsl_lpuart.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 67fa113f77d4..d0efeba5c695 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -239,6 +239,8 @@
 /* IMX lpuart has four extra unused regs located at the beginning */
 #define IMX_REG_OFF	0x10
 
+static resource_size_t lpuart_earlycon_mapbase;
+
 enum lpuart_type {
 	VF610_LPUART,
 	LS1021A_LPUART,
@@ -410,7 +412,7 @@ static int lpuart_global_reset(struct lpuart_port *sport)
 	void __iomem *global_addr;
 	int ret;
 
-	if (uart_console(port))
+	if ((port->mapbase - 0x10) == lpuart_earlycon_mapbase)
 		return 0;
 
 	ret = clk_prepare_enable(sport->ipg_clk);
@@ -2604,6 +2606,7 @@ static int __init lpuart32_imx_early_console_setup(struct earlycon_device *devic
 	device->port.iotype = UPIO_MEM32;
 	device->port.membase += IMX_REG_OFF;
 	device->con->write = lpuart32_early_write;
+	lpuart_earlycon_mapbase = device->port.mapbase;
 
 	return 0;
 }
-- 
2.25.1

