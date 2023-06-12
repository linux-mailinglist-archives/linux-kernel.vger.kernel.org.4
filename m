Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D93C072CC11
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 19:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236886AbjFLRIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 13:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbjFLRIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 13:08:11 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2082.outbound.protection.outlook.com [40.107.102.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54800E7E;
        Mon, 12 Jun 2023 10:08:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=czBrTJdH/jk+V3SHS5axofx+JNsXKnDNQ0QmwOn79QwoCwmb/UU1Rha4LcP3/mclY6hrLUAxhiR98x84xygcGbxBli2QFnc3zc+X3CoN3k/UvT33cRAkOrSKvXtV1MfnUHDJgs9W6EhcHUkgMEA0Ul8YVErbsOWWOLB1U/9JDmNwIhIhjt6Wjtw7nj4lYdxfJLr8rX15gSoO/m3hSDY7DCdfnneXuY1FwiTQswuvLVE1sbHM+M5edOzaZE7ARJWkHm4HVP3/W7e2pOs/s3aCS4PqN4fjzeCbgpj2AtD1RT5UD90WFX8OJwCkKyZ5kcl8CwmLtAJjl7c/6oDxiB79uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yxML0lwYDUUX1Mv1UAzgC/N5+fraMMgJl/sjNGPZdzE=;
 b=n0FXxJmFnanzjOWOEkA42hfN4S3Gz+vvZnLBn1SHetnQCVjG6Zz07enVlYfarQiMbZSVaaOY831SGnJo8+JdhH2SUTu+r9i+xrmzVy8tBU1AR7Nhg+kkN1K0e2omE2o4w94whAGEScVtO33hnEWJGW18U8ZqPGr72tRTV+5WVSemBxi1K/7s5un9iUCH2IfrfXiSdCcfENbB5mJQZ2ZZJYmOs97+/J1uV++P1rN117vUwQNZEElwdmsz0eKotYzCqb+EvSF4d35YZqKAnDyuByxeexOugzaihtsYzsmGhq/OHDUkFt+zWosA1ok0XL+jUFqV0kKd61X6IUw3YUBH9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yxML0lwYDUUX1Mv1UAzgC/N5+fraMMgJl/sjNGPZdzE=;
 b=mGYlRuMt6NCUmvNi22guM8w5qIZtOIF+zA3gR9ZMJvykkrFn62wBCW6A8y75puaPVLb0nfkIaDF6wIBDWqyx4qYv9jjhdpggfbMUnhrTmO/8H1gF/Jc7Y9Pm1oXWy5rWXC15cE+NtD8HRCldeRt2SGtWBPrIh7Gh6bZvyeRL9dc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21) by SJ0PR08MB8389.namprd08.prod.outlook.com
 (2603:10b6:a03:4e5::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Mon, 12 Jun
 2023 17:08:02 +0000
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::ca3a:84ac:381c:1506]) by SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::ca3a:84ac:381c:1506%4]) with mapi id 15.20.6455.043; Mon, 12 Jun 2023
 17:08:02 +0000
Date:   Mon, 12 Jun 2023 12:07:59 -0500
From:   Jeff LaBundy <jeff@labundy.com>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        linux-input@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 4/4] input: touchscreen: add SPI support for Goodix
 Berlin Touchscreen IC
Message-ID: <ZIdQ723G8/a0tNEZ@nixie71>
References: <20230606-topic-goodix-berlin-upstream-initial-v1-0-4a0741b8aefd@linaro.org>
 <20230606-topic-goodix-berlin-upstream-initial-v1-4-4a0741b8aefd@linaro.org>
 <ZIaRoTHar/s5yZAh@nixie71>
 <a87160e5-b895-3dae-bba0-94fc67c92679@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a87160e5-b895-3dae-bba0-94fc67c92679@linaro.org>
X-ClientProxiedBy: SN6PR08CA0034.namprd08.prod.outlook.com
 (2603:10b6:805:66::47) To SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR0801MB3774:EE_|SJ0PR08MB8389:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ee2f39e-ef8e-4757-bcba-08db6b6794be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8wvCwYZW/8F2MPixtC3ae3tyEX2BMtis8auMt6O+vAc3Guo+OK0MDIt1xvF7oOQpeSPssI4TxWGf3msjd2TWddYAMJ8wuOVRU3L00T51akK7zu4sJl2xwVpOYmykfxgM2RQR3uN0qdxIl012Gn12wFFVoZO2gb8RNmdpDb8W8L3bABablLong3MDO506xftYNuHkaY5LB/jZOHymOm00SuYRBQCyvHMPPYBE141xZzSHWAb6PYbAgaKTh7yhIqiO1fl1Yaxk7MslSQMEfaZyFStW9RvABz/0Yz7vXANFgnI68eCYw6WqSXdmjCw9329lu/ldqheUV+qA01JZAJAOES7H5DtJ/ij1ccjGWZxCE6zkggXZcmGlSylZjHB6CH5zpPAlZHuv4RpM0Ut9fFVM8lWim6jzD1telckW6JKup33UsvA+mOrU+V8TCC9JDu8uu3pIzt20qcauAis56HeJj6kspxP/Zuq4R5IL67NUtVTXhgqher6/dMKT41x4rY2eEOKJ9sXamzqAQ12YpuC7SPkmA6SXPSDdtB743Ukmnaz6cRoWAUqyvg4Sz3Ywmahj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0801MB3774.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(366004)(346002)(136003)(376002)(396003)(39830400003)(451199021)(86362001)(38100700002)(33716001)(478600001)(54906003)(4326008)(6666004)(6486002)(8936002)(8676002)(4744005)(2906002)(5660300002)(7416002)(66556008)(66946007)(66476007)(6916009)(41300700001)(316002)(186003)(6506007)(6512007)(9686003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iqhEF7col5armp7pK2+F+1WY7XuksrqFJE5V/oLEOd9NiNJmmsBCtlTzqx18?=
 =?us-ascii?Q?ncVDmTdeXTMWSDqu6kkwXdvF2JNEcYL0Ri+9l9rgiZ+H5Z8qc0i6DIL8yA7l?=
 =?us-ascii?Q?m8fMD2nyhi02E35npY3oT2FAQsyWgbkh5x3Ii2SzjghPWu2WJWBrOAnQXc4V?=
 =?us-ascii?Q?TYn19OpOVWIcPGEFtX+VYzJ4FQECWXdskbq6BeggwdtYH5mkMM2CA6UxteMP?=
 =?us-ascii?Q?MvDENwEstX9J7G7QL4VQMko8dRwaIbR9Qz0UD6hnTH8qz//1+5LEGfhtdAPD?=
 =?us-ascii?Q?6uwaDVBJb5ouAIIFgXe3TIpltlU9gT15O9oDz+WHNf9jUk5HxA8pMxBNAiHY?=
 =?us-ascii?Q?8zphR1Zc801QgGIwTHgXLVc7bir+yb9mQP+kVMSDVET2Uf/dsksgM3g/anz7?=
 =?us-ascii?Q?sSe4SnMGpZ3KY4JL9MMlxY4fnBYF3oCtbLO/9ZQ9zYD4YzxvP5P7VvTkPTZ4?=
 =?us-ascii?Q?jq7nt9dpS5bK99Olz1qk1QeozuqQ7JjaSH3/Ld2s1o9QcLT7zVU53MEB8xHf?=
 =?us-ascii?Q?4DZyzr9sQorrOFCxDP9s87WEqahp5GJVQwBnHDWT1bqU98i5zxZkCULvBZ79?=
 =?us-ascii?Q?1oc1fkjgZOs9YfcfpaqSwdFzOd542g1fGVUdd/CCA2YMt2KR+KvLCtRUPcSx?=
 =?us-ascii?Q?zGxup/40WZujgQ6vXlMjCHTkxGT4SBfMcJjq6Yi6p4CFsbqkV3D30nNF+63r?=
 =?us-ascii?Q?Nzrh0+j1Uq7bqVSwDBdjyUTxgV0bBKMaSB1+mMa5ysmqjuv3nqBu4PPoR4Y8?=
 =?us-ascii?Q?U1qdZSc/C5ClAlF+Ma+FBtmoVcP+cu+T+yTwXXjVf3QPUp3fDJdG/ZlGYtoS?=
 =?us-ascii?Q?RoqI1R9FI7tQ/luG3oO56/NJklhshl3Vji934rZbdyR/ULGxepB9suYAz94/?=
 =?us-ascii?Q?CVLuBQG6+oEK7EuVHEGUUn5qscNcBz2AoyBNn23tqVF6qgr2IcoyEoDy0RM9?=
 =?us-ascii?Q?xEsm6+BOhAcrHN5fXZ5IB6LS/LMGUw/iaQAs/7VJkXYpXbdriAZ5BXXoR67b?=
 =?us-ascii?Q?nos21qQ1x+M9bGE4GRSWnkgxGm/GCtV6xASkku3Nnx72c2YI4pF4OrMY4796?=
 =?us-ascii?Q?y3dlvmoD/8NLKgMLIydbA0jSOH0jFW9hIufG6f2hD/qcF1Ynxne2e2Su5pwo?=
 =?us-ascii?Q?vlscUC/Rx+YYnoeWvYlKHfycpH34Ge3ljrNQccFCB166sJEDuAh42nuqnEAZ?=
 =?us-ascii?Q?O8L6GO/ob2Kn2Y43N9JOp1nlN/4+iWpB9uGGlnu/HuDLkE5PUt7UByQMqCP9?=
 =?us-ascii?Q?pHwK1WENnUEDcOCs7Y4lMnNdxNxosUlG/il5hH2bsXn5iqf7baoa2W3M01l2?=
 =?us-ascii?Q?MkQ/Rv23vDQb1iIiGtmCqI1fIZe+JyGYTMlcr9WZZimYZeWgU6iqtetsZEUY?=
 =?us-ascii?Q?iO+cLbMo1UlGpg0XhF14QurUzWJ2ABshyIdEJ8cLAznSj/wVlNacjNWnwAHG?=
 =?us-ascii?Q?RJhBZxnULpz+okGnVcmVjbHWv0T0Mbpx5DNCOVAnWi4O4/Ko1XlqHIc/9/cH?=
 =?us-ascii?Q?aztiL+AZ63fMJPBmhs15PSTa9lg3YF0aB/lE7it3ndlqNN/J0/GBNKj4FFCu?=
 =?us-ascii?Q?cmbvD/hWX0yXvtu2f3dtgXKtfBdiqH6RBVy1Uqv0?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ee2f39e-ef8e-4757-bcba-08db6b6794be
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0801MB3774.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 17:08:02.5630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 23KPo6q3tfYI7okA+c2sjkDd5RUJYwL6EBCE2vkfrpMRwBqaRwAWxHd4A13jXmv2tPyvAxfxBbf1NDl3R04OKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR08MB8389
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

[...]

> > > +static const struct input_id goodix_berlin_spi_input_id = {
> > > +	.bustype = BUS_SPI,
> > > +	.vendor = 0x0416,
> > > +	.product = 0x1001,
> > 
> > After having seen these in the I2C counterpart; consider defining them
> > in goodix_berlin.h.
> 
> To be honest, I blindly copied it from goodix.c because the vendor
> driver puts random values here.
> 
> input_dev->id.product = 0xDEAD;
> input_dev->id.vendor = 0xBEEF;
> 
> So what should I set ?

If there is no explicit guidance from the vendor, I would simply leave
these unassigned; in theory one would imagine that this controller would
have a different product ID than other models.

[...]

Kind regards,
Jeff LaBundy
