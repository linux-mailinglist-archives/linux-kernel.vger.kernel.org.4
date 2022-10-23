Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E331F609722
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 01:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbiJWXDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 19:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbiJWXDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 19:03:31 -0400
Received: from GBR01-CWL-obe.outbound.protection.outlook.com (mail-cwlgbr01rlhn2155.outbound.protection.outlook.com [40.95.80.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B226919A
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 16:03:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BedNMsES5dRF+GxeumKfrJN7MdN9rUOJ1SGe+z06qIjIBBae5XSE7hJPU08qzUy7Wi61NrQ/RUPLfwbFEp8ZC7QIeskADh0jeaJBuzdP73v8FspILwjllNTfUdSWpkCqIUODvQnTHLqFsViKGrQg4i3BRJiLJB5262VrBE3jy1jPXT2NNJSbb/B/xPp+WygVZWp16ZVAfbDGvh3XzI1PDhwnMdJpJJV7xAiQQHE4OLtKHFIJPQ9itB1iTTOTU9jmd0NiXlKgMApos5M9tH1CLJixOMIMNFzjQh2fHD1sd0PIVqV6XElheLOmGVMUOfmhZoQnqYP3mGZxTRFfTrbY1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nq4MqPwcsOWaECz0wSV53g2tUCbwHfCMZsI8dJAoqjQ=;
 b=gqfE1GtSelKxhU56GLSbnv17fTn+D4OxtLyWDY3vOXd/m3QXADeKFCWBXOhUihJWk7GEWjx/CvXdvbLgvfhgfMqTzJZ/mnetp5jqaxNomKMnIE072tC0bMKwembKFVbyYWpBiY1T2hA4MnnGCjxJPnlEsMqAvETfvmmVbYl3u8QESlxdTkUAjR6H6XCUBCqLvAa3ucqUWjMvO5ys1X7H0AgbDaNwgaeOXxaRIDKKmPmLOVHhVo33ZQ1fGzy0c7vkc8yYqMFA5Q7fJUFNSMLeCdNbPhdYx6AO0NlMnkGwjhuMhEbgMmZz5lVgrUfCn0wpxUo06PXwqL/2Mks3fZBEtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 213.105.56.180) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=gmail.com;
 dmarc=fail (p=none sp=quarantine pct=100) action=none header.from=gmail.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=brineleas.onmicrosoft.com; s=selector2-brineleas-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nq4MqPwcsOWaECz0wSV53g2tUCbwHfCMZsI8dJAoqjQ=;
 b=GGkP6+KkUj7d3GKJ6FGfNMyv8bzZp6Pte4Vax92/9QC93lxPRm9KkU/YmjERQP4ydEcH836g3CwoVyA42XE2iWxRL3DHMHPmSsig+lEo5k1x4eHcS5yauhwNmGfqA+t3AdigHrsZYJ6Dxjdqt2y5lgarf/1Vy5eWDRLIr4sZ0T8=
Received: from LO4P123CA0099.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:191::14)
 by CWXP123MB2983.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:32::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Sun, 23 Oct
 2022 23:03:26 +0000
Received: from LO2GBR01FT013.eop-gbr01.prod.protection.outlook.com
 (2603:10a6:600:191:cafe::a2) by LO4P123CA0099.outlook.office365.com
 (2603:10a6:600:191::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.27 via Frontend
 Transport; Sun, 23 Oct 2022 23:03:26 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 213.105.56.180) smtp.mailfrom=gmail.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 gmail.com discourages use of 213.105.56.180 as permitted sender)
Received: from webmail.brineleas.co.uk (213.105.56.180) by
 LO2GBR01FT013.mail.protection.outlook.com (10.152.42.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5746.16 via Frontend Transport; Sun, 23 Oct 2022 23:03:26 +0000
Received: from BL-EX01.brineleas.local (172.16.0.40) by
 BL-HBD01.brineleas.local (172.16.0.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.14; Mon, 24 Oct 2022 00:03:15 +0100
Received: from gmail.com (192.3.223.142) by BL-EX01.brineleas.local
 (172.16.0.40) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 24 Oct
 2022 00:03:13 +0100
Reply-To: <chooleech@gmail.com>
From:   <adaincle@gmail.com>
To:     <linux-kernel@vger.kernel.org>
Subject: Partnership
Date:   Sun, 23 Oct 2022 16:03:13 -0700
Message-ID: <20221023160313.311AD1622E043B7F@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BL-HBD01.brineleas.local (172.16.0.41) To
 BL-EX01.brineleas.local (172.16.0.40)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2GBR01FT013:EE_|CWXP123MB2983:EE_
X-MS-Office365-Filtering-Correlation-Id: d0bd973d-7bb5-4f7a-3c6f-08dab54acb2b
X-MS-Exchange-SenderADCheck: 2
X-MS-Exchange-AntiSpam-Relay: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b0dlcnR5VjJmU1RlM2k3ZHdZc0kvS2F0NXNNYlV4ZHI2ckhZY0NnVXc2MHNO?=
 =?utf-8?B?Zko0aWRlSnd3aElQY3BScW1lYnpLSXB4UERmNGFFT2lUTmpYUElTNk5WQkRt?=
 =?utf-8?B?SE80RGU4OXIvS0RHODRRN3JjOXBDVTR6OWxYcVNWYU13V1Z0SkRXSHE0bGJj?=
 =?utf-8?B?Ynh0Nk9wY053WjFwSzJ5NEZXK29mSmNaZmRHNXlMelBiZG1uN2drVHZIbGpE?=
 =?utf-8?B?UlhwTjcwQXVhTGNiaDVqcnlXd1Z4UnV0RkxkWHJmWEZOeFpKRVc2NG5jNDRr?=
 =?utf-8?B?MGdtdklZd21zcWhNOE4xb3MzeXlYQjBiYXlkQ0RMR3ExM0FMazduRjZRMVNH?=
 =?utf-8?B?aUp3am8zbnliTFRRMDhvUFIvLzFtbjJCS0ozUEVabGh5RDN2QTlKTCttcVJG?=
 =?utf-8?B?MUkrRTJDVWp5VGxlb21FV2srUlZEcVNLTFBRUjBoZkx4Wkk3SHo5Nmx2ZUwz?=
 =?utf-8?B?SzhVUStpWU05dmNTemlpUSs1aDhvZnJBdHoyUllHVTdiQkhSM2trd3Z6bjg1?=
 =?utf-8?B?NDB6VExuOHpGUTNEemU0bHdSTExwM041d2FPRVR2TW9ZU2tKZ1FWT1RJVWpW?=
 =?utf-8?B?L0xQaFFsdjIra0lWVXNmbEVnRFpoNXo0VG1GRzUyczEwdWFLc0IrdGJBV2I2?=
 =?utf-8?B?Zk5nc01CczdQQy85MUZNNCtUUmkwT3FtU1pGcWZJLzJHOGx4THJVZFlFclMx?=
 =?utf-8?B?R244REtBdm5RZ2t3dEtFUi9Pb1ZxRTVFWXFJMkY0b1p0YlVMblN5VE00dmtK?=
 =?utf-8?B?YVhxdTM4cXQxRWhQSWRscDJSYlh2eVh6OG5QNkhtVXdwQ3I0T2RqK29KQVZp?=
 =?utf-8?B?VVhzaXZ5SWNjV2wzWU9ZODZITE01b1JZSGJ5dmV6ZC9ENTRKaVBod25RRHZK?=
 =?utf-8?B?WTc5MU1MR3U5MDUzR3pXS1dUdTlmbFBqOENrU3Irc1cvbGpMUGNpK0M4RWMw?=
 =?utf-8?B?OGNQYjFFNUhxeDZTd1k1MGU3OWpqa04rRktsc2xlbWJZZjNKdS9rZCtzY3FO?=
 =?utf-8?B?ZlJEbjBvRFFIZmlKK0xzdkdZRUE5L29mZXpZRG9ROUphb0VoTmtjUUJLbWdv?=
 =?utf-8?B?K29PTFNjejVIOFlGNWdRS1BXS0pLUDBFNGdOaGhMNDFTaWtuZVhTSTlseS9G?=
 =?utf-8?B?ZzdQZFVhMFRzRDJyaVYwQzFGU3kyUXQwMU5EMkNRNjRLVlBzQWR4TEpEQXM4?=
 =?utf-8?B?Si8vLytFclVyaXI5ckYvTGlYNTBnVXM2ckVnUU1tK09BU20zZ0h2NlpvdERn?=
 =?utf-8?B?M1hMcEtjazQwdGUzakYrN0x3eUo5THZMM3paVXhvUG5wZFlIbmhWYVBnVk1m?=
 =?utf-8?B?UkJYbmszUzFrS2p2bFVBMUt2ZUNuZmJjRmVOeE42RGpVb3p3bjNIMkQ3NHpp?=
 =?utf-8?B?M01YTlYrT09XcTdDellmbWRBWmh0U1puZDA0aGhMTkk2NXV5NllKT3dOS3JO?=
 =?utf-8?B?cWwyOGc3Z2xWdWpnYXBoY2VJREw5UGYrdm5nSVpsQVEycWE5VzVlMnlrL0k1?=
 =?utf-8?B?eUNjQVBHQ2lGSGluR1puUmdNOCt0bnR5RFgxcE5GNExGNThwb01LN1lsTXZF?=
 =?utf-8?B?ZkJCcHhDVHlGL0luQ2hQYVZ3cmMxWFdqRnRoeDFWdFNBc3RGRmkxUVlwWTJW?=
 =?utf-8?B?a0ZXbm5xRlRyOUllQVM1MWtFczZUcGc9PQ==?=
X-Forefront-Antispam-Report: CIP:213.105.56.180;CTRY:GB;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:webmail.brineleas.co.uk;PTR:180.56-105-213.static.virginmediabusiness.co.uk;CAT:OSPM;SFS:(13230022)(396003)(136003)(376002)(346002)(39860400002)(451199015)(46966006)(40470700004)(36756003)(33656002)(7696005)(55446002)(86362001)(40460700003)(2876002)(2906002)(82740400003)(3480700007)(35950700001)(47076005)(1076003)(2616005)(82202003)(5660300002)(956004)(356005)(336012)(83380400001)(73392003)(70206006)(70586007)(7116003)(103936005)(26005)(316002)(786003)(40480700001)(6916009)(2860700004)(54836003)(76482006)(8676002)(82310400005)(8936002)(41300700001)(55016003)(4744005)(498600001)(41320700001)(135420200001);DIR:OUT;SFP:1023;
X-OriginatorOrg: brineleas.onmicrosoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2022 23:03:26.6323
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0bd973d-7bb5-4f7a-3c6f-08dab54acb2b
X-MS-Exchange-CrossTenant-Id: 41a4300f-9b0d-411a-a67e-115d58d05597
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=41a4300f-9b0d-411a-a67e-115d58d05597;Ip=[213.105.56.180];Helo=[webmail.brineleas.co.uk]
X-MS-Exchange-CrossTenant-AuthSource: LO2GBR01FT013.eop-gbr01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP123MB2983
X-Spam-Status: Yes, score=6.4 required=5.0 tests=BAYES_50,DKIM_ADSP_CUSTOM_MED,
        DKIM_SIGNED,DKIM_VALID,FORGED_GMAIL_RCVD,FREEMAIL_FROM,
        FREEMAIL_REPLYTO,NML_ADSP_CUSTOM_MED,PDS_HELO_SPF_FAIL,
        RCVD_IN_DNSWL_NONE,SPF_HELO_FAIL,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [40.95.80.155 listed in list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 SPF_SOFTFAIL SPF: sender does not match SPF record (softfail)
        *  0.0 SPF_HELO_FAIL SPF: HELO does not match SPF record (fail)
        *      [SPF failed: Please see http://www.openspf.org/Why?s=helo;id=GBR01-CWL-obe.outbound.protection.outlook.com;ip=40.95.80.155;r=lindbergh.monkeyblade.net]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [adaincle[at]gmail.com]
        *  1.0 FORGED_GMAIL_RCVD 'From' gmail.com does not match 'Received'
        *      headers
        *  0.0 DKIM_ADSP_CUSTOM_MED No valid author signature, adsp_override
        *      is CUSTOM_MED
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  2.0 PDS_HELO_SPF_FAIL High profile HELO that fails SPF
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  0.9 NML_ADSP_CUSTOM_MED ADSP custom_med hit, and not from a mailing
        *       list
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am Mr. Lee Chong, Business Relationship Manager at Nanyang
Commercial Bank in Hong Kong, China. I have decided to contact
you regarding the state of the client who managed an investment
under our bank many years ago. If you are interested in
partnership kindly reply to my emails for more information
email: Leechong@asia.com
Respectfully,
Lee Chong

