Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4B79747E8B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 09:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232014AbjGEHuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 03:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbjGEHuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 03:50:00 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2128.outbound.protection.outlook.com [40.107.255.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D6810DD;
        Wed,  5 Jul 2023 00:49:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RoBPPLEGHyPD7j/b/1BTAZ0ezt5Ze6AlrCEV0Aoshvw1czXjCGM08Jnq3kjS47jgQyKY9c6PdEiN713IWiZ9ZYThd0ymdWIkLVk3013HQC3hv1AKj7iCjqr6UhSmroQ0T3AEG1PH83PNDWq3GQhH8ZxLNIPQCKCEN4gJKS+/qJ9FybvX1hFxmtAy6KfPUtCuPlNkwl4cDsVBjJxGgmYlQTwgDiwP1DtHP8Njh5H8P42GgByq9yBgnfUnQG/R9Gb2wu3ObkWZW4sFrivvCNUYqBWQv99fW9QGluxwYzwAHB650BW3gcS1KXSX4fLqQn78gBUcQcKMfFsQLNgP9Iga6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YW7o4wPjilLbjqfBXgd/So7aRnin3fQJCkqJQL1U7jE=;
 b=RmT0bm8gnAJ/ObzlPJ+7rnCMGfUP0Rxomcvhp2LtZwF84ZpePMcD8Le7hVlEmZ+doT0NcuYhhhLOVqfcb4ptcISp6gpM80aKZ7JZJVp3TRDRyQJB0G7/xx6JA1/nlYac8LQ59QYinmpd5IBVpkX5Ttovl8CjNp9YrykXapshS+omrk+euTdSjHxK9OzmGI9zgZw2VeykGt5CAeqNYfnmXLuHPUDaFMwKNRjg5Irh2Q69K7yiNjYKXjeK4u+zuPPpDJaPIDrgx+M42sPBcNyWielPnc3dn7Dh0SkFc8TTzXdpikNLxaPs2ZvoUWrL0iPHT/XdKyBHzLkTdF65Ep8M5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YW7o4wPjilLbjqfBXgd/So7aRnin3fQJCkqJQL1U7jE=;
 b=koaFBlUg10UwVlglgfKDzP6p97Qc/6EcjnMzUeyqvI65+KXFtfv5Dh7BP+zX1Xxe+XJGmyc8YYaZKUMJ2602ZB+Ctuysl033YD3zOXOpAW//gL3J4JCGEkiU/pjQFPPLLUOCX6zISBVlDYnX+LBrYATT1P4nCwgUYv8nQTZwTut3c4L08rdNymvPeO2pivlUT57bb+IVGDNDarHJL922nSVftOiRU99fbiUXlUsh1cGI+5we+J33DvJ3bN5cqrMGE6i/1PyWXWYPQcyUrlQdFFj0y025d9GWhRb0cyNdHvV/5IfHekq0f45SSHRBctgWJ5zVbtTncHoHNZeYamvq3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEYPR06MB6663.apcprd06.prod.outlook.com (2603:1096:101:175::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Wed, 5 Jul
 2023 07:49:56 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 07:49:55 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     frank.li@vivo.com
Cc:     Jonathan.Cameron@Huawei.com, amitk@kernel.org,
        angelogioacchino.delregno@collabora.com, bchihi@baylibre.com,
        bcm-kernel-feedback-list@broadcom.com, daniel.lezcano@linaro.org,
        florian.fainelli@broadcom.com, krzk@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org,
        matthias.bgg@gmail.com, miquel.raynal@bootlin.com,
        mmayer@broadcom.com, rafael@kernel.org, rui.zhang@intel.com,
        tglx@linutronix.de, u.kleine-koenig@pengutronix.de,
        wenst@chromium.org
Subject: Re: [PATCH v3 1/5] genirq/devres: Add devm_request_threaded_irq_emsg()
Date:   Wed,  5 Jul 2023 15:49:45 +0800
Message-Id: <20230705074945.3687-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <c092b860-33d5-77c0-456c-367d545e8b7f@vivo.com>
References: <c092b860-33d5-77c0-456c-367d545e8b7f@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0053.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::8) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEYPR06MB6663:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bb82285-6094-4503-5231-08db7d2c6c95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CfIE73a8OEPHbfGRaxEYM3qolT07EH695kuf+Y4InodSH9s3rPLEFlbGpqthH7UjgYiwel3SeoinXgZ/H32xBkgNfYyROdrfdLlz5e+oJ7xYt4Ml0yVATKKrt2bF0BTR5o8jtw8bhocwjw1aXNRbCKGVhF0nE+PdHoOdY0tUjP4Mn0LEecxZvn94iWWb3odU6yRGSxm/vg6W/8WFcId4mrJsmRay/yvZiOpssXTD8PPQ5SE0dOseXmaRfNWQga2uD5dUAXTQlqBgAmprQ7FAmZV1vAeLLkh0Azxu0SyW49saySfvHUNLQmEIXIG7uWBFCON6F5/h5JaEXfMkkmooRrgQU0ziQ/bYC6ED1k1PgI++HIriR40x5T9Gf/TQoRpnmAVie6FA2tF2rnJg7EuW1wY7r803Q8743jcvG+Q5+d5rFQ5InI69mHffhJuR4xfvLzLhHtvWVTi1mZwqXanl2OVLxuDQ0y1GVdBXW/DfcNQ+VSP06xFlGQP7z0z8aptzFGB2TdstugptuDcoOz9pdaDq2eo7B9/zvK9kvv+7t3UDBjAEFxKYj11ESDfYA1no+aatMQbcPqbnS6KOp4TYzhY3hi7M0+tJOFUYgs0Dn/U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(396003)(376002)(346002)(39860400002)(451199021)(7416002)(34206002)(66556008)(478600001)(36756003)(66476007)(66946007)(8936002)(4326008)(8676002)(2906002)(5660300002)(316002)(41300700001)(37006003)(6512007)(86362001)(52116002)(38350700002)(38100700002)(4744005)(6666004)(6486002)(26005)(1076003)(186003)(6506007)(2616005)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bubtkPL9nxvts9xnHhAkvnt4NWW19rGkfpoHmS0FQ8USqTfyXoqxyW0OiWNP?=
 =?us-ascii?Q?djl5zbdBvyoOyYC6X3zlf7CHnTQJ8/YulLgW0EV4gerMP8SBQPq3MjXRBTs0?=
 =?us-ascii?Q?KoOAqYvGngdsoIkr8liLVc242nTDA56DR1UV1qKkeksoFGMVWJAslq4I+WDZ?=
 =?us-ascii?Q?yImwgeFni1C0KJyGyc+VQGFwpGIsl185aHyqyicF7JjELzXguBNAwwyTtkB9?=
 =?us-ascii?Q?91xR9jb3TGJSvRhPbvyWpvz278ioQv5yPPJ/omRCziTHor97PszatDIIgFwl?=
 =?us-ascii?Q?wUreH0wLVpDQ7XLGDmFj3BPm50CPVPQKHRKnelDGvuvQgh6F5+/YnYQlscvM?=
 =?us-ascii?Q?7pOgUiZ2e8HahgCyP5jAdrYZHd43PFK+iaValIRsAVzfGE+Fwua6H0un5Qob?=
 =?us-ascii?Q?+V/FfydRTRWy5F1T/871g898Q4pyt7h37HxseLh+m6xUZSXM4Iu8cX8p4/Di?=
 =?us-ascii?Q?dNmrJqZ6kNDo1ntT5mfBaPRVRJncqN6DKQG8IVWmJb/mnEGaiHVrICUD+9A4?=
 =?us-ascii?Q?emZrUP90xwJYvCGgCaSFTkPJ0zr0ZeDQlez+KErdkwcLpnJh+PFbXFXaWRBP?=
 =?us-ascii?Q?CJkjl1aE9Zfy/QnUqjHaJmXd2mHajPDHrBh2LXVdUidIiB4BMvRz2fNLnzZo?=
 =?us-ascii?Q?ilU67qVQ61kmWA/vBf3rVDzYXYgGjwW2kEmABwBko2MpkmND9TniFWGQ2+99?=
 =?us-ascii?Q?XDejKvBW/LGB45gXxIobiE57ZpfgJaMrqK1YxJgWCL7nUNjI3W6tMSKeJdBh?=
 =?us-ascii?Q?xBIEUakecrYBhV510clc26Ka/+glH2SsSU0sq0feoYC8Vqhu9RUWh/h6Yhrm?=
 =?us-ascii?Q?HtQ2zirH8xna7ysXW4htVh0WO+bsxuocdH47U8VWo9pB51dH2xB2gkBu4/RV?=
 =?us-ascii?Q?iYrkZplZdlkgNGrKBircHtPggcGaa1S226E72QzQkdPdb2ehbMiOay/ol46L?=
 =?us-ascii?Q?0Ch2cB0hX/w8Ua4aPKQUmBs886n2gQiSv2WP+VRQO6M9p7V0DXeYQY0m4bIs?=
 =?us-ascii?Q?kmN/pGKfjXdkO9uv2memZKdorsmhP4ldkW+w76EWAJRJP40tBNovrR/X/hfV?=
 =?us-ascii?Q?8z/5EZ0dxAByqewaQYc9N8gDExbe/NN7RxeoU2W4ktEE/ZCqjI0+qMdJ5Hvn?=
 =?us-ascii?Q?3wnJWjpzZKLWCoq8KI4OLvTZP0eV3q90phb2qnpMEKt3v8sCK8cO56e6X0RQ?=
 =?us-ascii?Q?4/Ywe/WUM4xBEFor4be9IJtXLUajwi6qmEHDmV9ktvLTqF62Qhsh0Hzyo0Vk?=
 =?us-ascii?Q?x1vCgrBatTRRRoiGFT9asqeDF/FMpXHeGsMCCGuZ+VfTNnx2SiERrFjRlT9X?=
 =?us-ascii?Q?YhHAIBtECievszLtRM0WQtQIQxgmAfC0rMrxmIzZHPU8HqTZdIBXn6xGAJB4?=
 =?us-ascii?Q?OxamzYiVyD0mVbG5w80HHxuEQmHfTkk35ARPWBemJdBYTUBrR18d9amfDPg8?=
 =?us-ascii?Q?/E/SBSLQBGK2ZApyIPVNGsR5EpdJapDdlLCZCCRTlyiYlOqjyrJISzUBrlKH?=
 =?us-ascii?Q?N52WHQLc2Pn5bardyun3avdSwkpZ4OEUfGNYj2TjbVdeRohM2I2fOpyfm5Pi?=
 =?us-ascii?Q?zR3g7JMOrxbIoknkVTw0DfMRfy4F2FqkLLllCaAX?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bb82285-6094-4503-5231-08db7d2c6c95
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 07:49:55.9110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nJdlN08zLjgLnxXfBM0Jj+aAvH5Nkf+PiVM5A306TCzPrXS24gVgZSkLrfbHRQgyHZyRRwwlvxjPJO4xAt004g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6663
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I don't know what's wrong with the email client that caused the line break to be abnormal.
I used git send-email to resend this.

int devm_request_threaded_irq_probe(struct device *dev, unsigned int irq,
				    irq_handler_t handler, irq_handler_t thread_fn,
				    unsigned long irqflags, const char *devname,
				    void *dev_id, const char *info) 
{
	int rc;

	rc = devm_request_threaded_irq(dev, irq, handler, NULL, irqflags, devname, dev_id);
	if (rc)
		return dev_err_probe(dev, rc, "Failed to request %sinterrupt %u %s %s\n",
				     thread_fn ? "threaded " : "", irq, devname ? : dev_name(dev),
				     info ? : "");
	return 0; 
}
EXPORT_SYMBOL(devm_request_threaded_irq_probe);

Thx,
Yangtao
