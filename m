Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A40156FE372
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 19:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235791AbjEJRqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 13:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbjEJRqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 13:46:19 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2111.outbound.protection.outlook.com [40.107.93.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D1A2119
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 10:46:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h/NiSIFj8zLaKDkqyhPEWFPVV7pk1L1JNn5VyM9WmSnDDk2gUbnGJWx83LtcxPCJvF6m9U687SI4A21PYVXV4C4NmnMUcyLkmukMmfamz2y0g/Nq18Q+HGgTkmQOTFP+ejMQC26zhnJQS233cFRUtEUZQ7y5F2msi2pPQga1TnXJgsdmsi0NbHELTsHeDuaUZkHXauMPHF7pjdcYWGBJYZEvs71I8yQlFkmnns0vCQXNudeJrraamQ/txSdEqmgY5C7+8UpJlS3TVeDBv0x7qMfBpOlUzGxlmd05rMdQ20hSR5cjmEWhki9tlgJ+sUtRAj/9UMbfSOICp9tvXKA1Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lyAqBqZjGUQ+OEYalsxumy8V0g/FXYhtswx8/ca3lZY=;
 b=mrBgnvq/PBElGzxQ5ooza5eE9eaQ3W0/ETGdstyERDEVaUlBIRedyFRZAU/uvieOgi+eqA8m6OCHumpOsfcm/Tf63xMOFHilomgPTl7RkvuPUOjL8d9Q5ri0hG/Lb40P2g2s0a96cg7ykL43cONnRGItM0eeyv5PNExJrlEExi8P7ICkizxRma4OM8Rwjj1x+pwVlKccwG7/vPdeBeUwTNietOBW0buSB9aiWqHX4fv+1h4YFzGk9FDtzSJP6N24xwNsVMdZYCMfAStjarb+dsW8Scdano9sU5CmO3owOIUAJugkv+d7F1gBZbmVNNUhb3hPTHczwbxaCQHSI0meuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=in-advantage.com; dmarc=pass action=none
 header.from=in-advantage.com; dkim=pass header.d=in-advantage.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=inadvantage.onmicrosoft.com; s=selector2-inadvantage-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lyAqBqZjGUQ+OEYalsxumy8V0g/FXYhtswx8/ca3lZY=;
 b=Ht80PO88kdTBOZN6tNDxATI8fG7fGcIdAtyllzJw6rzjaLoSvupcnD6vhbidtag777g7Mlandx4SWdLPjJhdNYhrZ210ju8ZS4VymoZXsgqpRPw3Fqhe9e9v24q4+adOEnQlwZgkV2Wv+Ck2F2fzPl6/lTqNz8WuQBczlYMho/4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=in-advantage.com;
Received: from MWHPR1001MB2351.namprd10.prod.outlook.com
 (2603:10b6:301:35::37) by IA1PR10MB6219.namprd10.prod.outlook.com
 (2603:10b6:208:3a4::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Wed, 10 May
 2023 17:46:14 +0000
Received: from MWHPR1001MB2351.namprd10.prod.outlook.com
 ([fe80::8374:2506:121a:5612]) by MWHPR1001MB2351.namprd10.prod.outlook.com
 ([fe80::8374:2506:121a:5612%5]) with mapi id 15.20.6363.030; Wed, 10 May 2023
 17:46:14 +0000
Date:   Wed, 10 May 2023 10:46:11 -0700
From:   Colin Foster <colin.foster@in-advantage.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Subject: Re: Kernel 6.4-rc1 ARM boot fails
Message-ID: <ZFvYY1EPZSovEsuK@colin-ia-desktop>
References: <ZFs6DNgzBHNarr6D@euler>
 <CAMj1kXG5+fhKA_+TMT1KfSZ0_hGZOdw5xtwuN9Y+Sev=rt97rw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXG5+fhKA_+TMT1KfSZ0_hGZOdw5xtwuN9Y+Sev=rt97rw@mail.gmail.com>
X-ClientProxiedBy: MW4PR04CA0125.namprd04.prod.outlook.com
 (2603:10b6:303:84::10) To MWHPR1001MB2351.namprd10.prod.outlook.com
 (2603:10b6:301:35::37)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2351:EE_|IA1PR10MB6219:EE_
X-MS-Office365-Filtering-Correlation-Id: 40865880-db81-4b0f-f43c-08db517e735a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F+AKuAMhBI5qi2zosjDnxqsVS4YcLiatuDsBGXvbSFOmupqGVlsJgoSxT+xTW/0D681XDtyFLepGJwhb3LlSEtb4B7/rY9rno5QlgYO6HcSTppz2213V953AQF4gUpWDI/PoLK/kJBOvCgd6VT2FyfWOdwOu08WUBm3Q/euGYicgqVcSdP2nZ2F7EabOEmvVzYjDGjRYnFSaMy55kvTsbV8VZg/0gU3glt7JHqLmXUzT5O7iriPMk1Y8RRkYXf8rih+X2E2KTW5/cT+wuGlX27g/HC8rDSW1WHcqYj0pTH8ssM9ZPL1vJGwWPKbU0fDJEFit6bce/gX2oDWaKfBAS2UFwdoLMzVcpWmaxLFSWeq9L5NI7OSsuYWXDUK62JxvHtvQ3bMTp4YPyesgit9UHNXTcbfn0zJcdfvoA7LKNbC28YYL05+YaxcpF1/12rnlja+JbelZmcF1QyFP6NbXkdUzV3pS8ii6IBEb2uATIS/1+AJVYXyJZRSZ8kxahTyX1Eb92slhpeCfg9MehXucmyX2PpVFtNwEBGR0AIoUxFY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2351.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(376002)(396003)(136003)(39840400004)(366004)(346002)(451199021)(966005)(6916009)(6666004)(478600001)(66556008)(66476007)(6486002)(66946007)(4326008)(54906003)(316002)(16799955002)(6512007)(9686003)(6506007)(86362001)(26005)(8676002)(41300700001)(2906002)(8936002)(4744005)(5660300002)(33716001)(186003)(38100700002)(44832011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OLE/IvDcf6Vq5PYCawLQCxFZ2C3EYw5ZYClQGhh1M0qlOcl3dMIO3gI/dZl1?=
 =?us-ascii?Q?U4nQCGMiFl+qTKcX/roa1WMJwj3ehsiWrcTiqBf64iVb1IvXqAag4qz1ueDl?=
 =?us-ascii?Q?0Gia4WKHr2kn+1ovcYp+ru9qlA5hy53dzdBr/5R+LZceUYU3u1KX2n+em0O8?=
 =?us-ascii?Q?juuD661BPvmp6ItoGG8fqOUlI8NuuMJxMDK1byxk3yWT4JoEokuXdQpdF2TQ?=
 =?us-ascii?Q?QJmZUX5wOID/lQZsKw0rhN+8YmPAqEx/CsT0CIMIXEETGUN1QRkzjaA0C4ei?=
 =?us-ascii?Q?FnjXSvo5B/u50mck6ubRaGMeZc2onvF+HBbgJv0nzg7c2AbeiVT394hwD/yc?=
 =?us-ascii?Q?iE6Oda500uBF8xP8bq2ynve5ROpuC42OzmOMJiJ9IUkEkx4Uj/vdDxt4B424?=
 =?us-ascii?Q?3c+aPIh3edi70nJHqZr0sWPlg421tUyjgLfnAqzPi+Caog5Qfh7hr+lyvtaJ?=
 =?us-ascii?Q?kPhJdX4D+8vOelUm1TFA2VPIXBM7ouluTExYm2aSRj1luwvHFT+be1LmvT6P?=
 =?us-ascii?Q?SqEogPLdMKd1VIf0MPVAenpZ0so8kSRig7iEFP0u0LTiFHqq8eZUWiTSTgYJ?=
 =?us-ascii?Q?bzw1b+lLQ3avnvWYXlh0ipxXjSeTtoeYq+wK6G/uVzNK1EtvEUGbUaSFStGO?=
 =?us-ascii?Q?UVe61ZQmPP2wST0kcVl6/bczmfBmGzXwhvO9vI6pMg/g2VV3N5Xj6gbba0Oa?=
 =?us-ascii?Q?JvPQjXIrq4M0HwVqcryIQPho+MmWGiBRcRMRN2edt5BMek9ufcXgeXyQOK9p?=
 =?us-ascii?Q?eE6j5GfmeawxqWnXtIZAQqa39dQVQaxPg71Ck/y0fU8VjoER8ewoR5eFoFJJ?=
 =?us-ascii?Q?zyv/MUdPw0G+DULNHkIX8rvqEjkB2R8zLqqPCFdUeKrwC9ErnTIleuwDQogE?=
 =?us-ascii?Q?3zuAMuhSNa56GqjrVMFgrBRE7pxU9n3xD6n8Izj0epsVvqEYRkjTce8yA/w1?=
 =?us-ascii?Q?Rsfl9Tc6j1yyEVVFiZJeLdEUoY65uB2nEkeCAGQ8rO2YkBOWDz7HSUE1Xqtm?=
 =?us-ascii?Q?YCfMCHWPNEK1amm/KC+9lCIJEpk29+jy7agTDYvCw9fS/786kA+TO1Wr537M?=
 =?us-ascii?Q?I5pUHEz9a1Y/cm4fxtgS8Ce5TFYe04tlbGJsbPL29vsyHCK3qKVoxnD/PLeM?=
 =?us-ascii?Q?B35vcJsMOOXVyRhKz+bcHcKpbwnyQxjfGoQXdlxCcRqNg6LFI5E8xnqZrbJa?=
 =?us-ascii?Q?jI7rDrSPzZ8FfHeFd+PF4BWZ0h84kym77xiKU0l+5qKjEHak2+/nd5wGqtMt?=
 =?us-ascii?Q?MWmzYatnX7GUifqnlx3yFV9r7hp2zjsDsU69G7d2SclQEAJ6gxNWt05lwYqE?=
 =?us-ascii?Q?xg2YHzcJXTU5SMFlGnwtthFIKuZO1rCt8tuxksBkLf+wMZGJB+QAHGp21+v5?=
 =?us-ascii?Q?58PIrg3z5OFOO0hE4AdBVLApVZqQHRgsmkAUzkQ5iXloWm3dwCbMvhT8NVZ0?=
 =?us-ascii?Q?buOknL+5zq/jRfLK0wRyLz6Xce4mHUWbFcc58ZQ99iLiFYtceRZR48VIhd98?=
 =?us-ascii?Q?4aEgGMJ4UOktbCogqDte5Jh7w6JyPs9qz0aRTnelbYH8xzkQmsZIg+EyFKZc?=
 =?us-ascii?Q?bnUmC6qJLcv+HiQNgKajC5TzBz60uEEDu+diu8Tjyq+H4IJPByaYEG8myhht?=
 =?us-ascii?Q?CT1r9e7kNAxWVAB8ILXEdIE=3D?=
X-OriginatorOrg: in-advantage.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40865880-db81-4b0f-f43c-08db517e735a
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2351.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 17:46:14.7285
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 48e842ca-fbd8-4633-a79d-0c955a7d3aae
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /GuG531o9v723Lwyao98Zise2MJXMEX0k0MgAYpyE1jqca0TPAJfATenUfr+firhGsmJg+8GiISWmEwsXSV6FZJen0dHQLehaiI6bzTGLPY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6219
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2023 at 08:33:00AM +0200, Ard Biesheuvel wrote:
> On Wed, 10 May 2023 at 08:30, Colin Foster
> 
> Thanks for the report.
> 
> This should fix it:
> 
> https://www.armlinux.org.uk/developer/patches/viewpatch.php?id=9297/1

Looks like it. I'll apply then wait for the next RC. Thanks for this,
and the super quick response!
