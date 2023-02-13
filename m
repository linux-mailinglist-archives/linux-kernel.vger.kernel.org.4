Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C40846947FD
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 15:28:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbjBMO2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 09:28:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjBMO22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 09:28:28 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2110.outbound.protection.outlook.com [40.107.255.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 701865270
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 06:28:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C74Zku+bJdYXMdzw176F//9WksxQ2aWzOW6uHgmchTvwlDQ+3XeqFmM8BReHIIvbOMnNW7I+RZvtviTnbqTQVjEMXmlRmkqM//RqDS8+kCtcNXE6K1D9faqkrEqcxtW7YmgsssY7V/ezLKo7z8eLSilMD0ANdA2zQ55l811brOIRto21pL97rDM4DPgQ0CP3IR0ZSfJu43pdLPor8HfWnf7fujC53awP1p+Gk82XUNh77u4BA0SlkJ+w0D4EQmqvYDMUudM7aOgPu5vsTYY40fvDAAPJrntlTvTXqcwzwiR7n6xbskUMXNR7lMcAqXFHABQ7VbwNBvuF6kUQYqfm+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O8WdxxNSKMC2zYp85qilVuhHP8ARrjmTd0+tkuvP27A=;
 b=jS0JcHanvZvZ1PE6v4owa+R4lN/Y2Ys89HzcPmaFJY3PqAYt5odK9BF3GtX3V3FziUiURoKkfOqeeiisB1Ul3hev3Hh69FGiCQ1oyEO680CbFjYk4pXFMYNR9cgSyexDJPSj+FgxML/X90F1+kgsJdarVbQaeu43x50Xk4e5i9rUNmw1Zoj8KGzdJ+AxF4EfLA3Iu895lTlj8g3JYO4fiAo1TAMoX3+MqIWLvckYPsPuFl59M8tL7qMK9F0aCHPAqRWT6ej3hA4MI8XLpYRPL8aoK1ampF1oCNrq6YaSXWn1dpa0EK/EXpSUPBNyvFvY5/5ybcWxsBYNJzdBc0FCdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O8WdxxNSKMC2zYp85qilVuhHP8ARrjmTd0+tkuvP27A=;
 b=n21j/3g8DH5h+ek7CiJuKP7YjHgqB6uvIhUF7Cq3FFRWLCAiUvyfWkDwQaKRFFxdpwMTC066u5Wybq7vza4EbKDnUwtkuId4P95QKFzLKQtouiG35Hi64m76k6lgLabhmTp8sag3PdGZf0MmrDERXyWhhlPAtRuFCQIr2/ExGIa8YuIfkucag5n4cGTJ25RNj3jJoh+EjSegnLYZH8g2VWkCXnDnCbtoFARKXCH0sZyxncljRVFy8T6V5FLc50uTe+lCQxTAg10ijHqhYe0ipyctlaZcPsN/flIGWQPaL53KshotTR38c6crEevDKaprP2rL6IpGj2uWBL8+aMXGYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR06MB6234.apcprd06.prod.outlook.com (2603:1096:820:d8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.10; Mon, 13 Feb
 2023 14:28:24 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869%9]) with mapi id 15.20.6111.010; Mon, 13 Feb 2023
 14:28:24 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, hanqi@vivo.com
Subject: Re: f2fs: fix to release compress file for F2FS_IOC_RESERVE_COMPRESS_BLOCKS when has no space
Date:   Mon, 13 Feb 2023 22:28:15 +0800
Message-Id: <20230213142815.24095-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <Y+a3a0eSkhVUh/RG@google.com>
References: <Y+a3a0eSkhVUh/RG@google.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0059.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::19) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR06MB6234:EE_
X-MS-Office365-Filtering-Correlation-Id: de50e1ba-358c-437a-566c-08db0dce9066
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5LtH8TWBCfwkct4o0zaecJuB8xbjjA9wXQF95SILS2Q1ME3eeY2lk7WZxTnDvHJ9zzRG0LDQ0m6wjDTn8YxDNxonYMMA4BEUtrXzYSDr2rmJMfpfb4NX3nmoC+G1D25/P9dF+l+ruH5/5G9V8GcQh34zR8hzj63AGYSmY6nfh3WMhSNPOna3JcwY1qYY8QcFoAY3EZx+Sb1uvMwmGdnYxnQQfq5gASLl+dNJgtOuqB6wWTGtDeDRMaMXco7lOHLdKXgx/etUTPRKaznywaOaz/199gL0D0gXz6ozsyiBOEKQMjF/UObKdH+CJXFh3x2508xaVb2ndHcmQOqYlQ4yUfyULxJ+4ZgPMTDoSUll1tywnfsS4XTYvFet2VhTx7eAxkuCq/ceUeJsDEM+idO4cQvXBIPkP36sFluJDjYCJu3RlLurz7MsdTgw8RsFc9361yxR3CM9+LjjXF/gWSFiktWpajzXmhKK55f2oVXtubtRLiF4fNnjDcZZ5jCWIo8MMSDP6tkKKnoo224mrZZxX3zTpk9HJ8tk82r8+7TqqznsurSVquvWHagms1IjoQAo9KUbZXSjyzxBKprC1bDhPkQhtL5M4vTnRXVxwExwf0ziUpiPXl5qGn149Deqbi1c1X0tYR35EFH6IW0wC45ec9jdJMNCdd1lpLHrhHZmu4CTVi8l1YqHeLiAnMaZ2XSOwHos/eXuZydOzaSP2zH8uA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(396003)(136003)(366004)(39860400002)(451199018)(1076003)(26005)(186003)(6506007)(6512007)(4326008)(66946007)(8676002)(66556008)(66476007)(52116002)(41300700001)(478600001)(6486002)(83380400001)(86362001)(2616005)(36756003)(316002)(107886003)(2906002)(6666004)(38350700002)(38100700002)(8936002)(4744005)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uyqUaIeIqSFCc7d+Ljgq2tdfLgu43e3FqJ9tqtHA6d7cIXslpYUo6twKD59h?=
 =?us-ascii?Q?5MS1mL8y79fH6ES02IaS5IbhGZwFTzIxvdGBKeIS2knQBDImyytIjbwxnc79?=
 =?us-ascii?Q?ICmFGespJHoxaqqaNCrvdau6t9aK9Sn03/CCQo2hmFq7Fbz3Mh2VKiROc367?=
 =?us-ascii?Q?g++StyFxujUOwo3e+75P66VtoOKNWLesQgfqyBmn+4KV2Li9PLFnIK/09Q4J?=
 =?us-ascii?Q?l8L4NnESVKzTEuNh13bgxeivN5tKIhLoq1NiPBfw1gv5Ib5Kgn58eTeVKCVx?=
 =?us-ascii?Q?YhqWYpQqfZ1uDuHT26zSgw6g3F0xB0tkBvCHZIaTxx+LWnJlmf9tAcaO8REk?=
 =?us-ascii?Q?k1ZCJ7OEFz0+llt6n8qa/n5IcSE1jHUoYKFJZ6gZe2jmK/4399ydH205vvbk?=
 =?us-ascii?Q?EKNlE7qoFCNoVLsC7iDp+WJxfaO+v8+8oDKWojtI2BBI+zSmQi8dVaVwGNv1?=
 =?us-ascii?Q?9ua+VkdvDZqh+91hyfuDzJ2fhsR8XSz6UL8eQqo4zG0w1jiXpPVQzsU+Hcy/?=
 =?us-ascii?Q?ir1/gx3HpdPiE4Ghluwks5cFTFaYi/W9vYbx7HAL9FJbKPJnzYnsnIuS/i26?=
 =?us-ascii?Q?kQdS1KZmjbl+d1fPTJVexSuwOtMgw/Iv1fd6PQgctp26P4azS6Lnnb5o3oTu?=
 =?us-ascii?Q?sXwpKhvGthDNZ1sNoC/bEGQpvlBf0IMq/FJPJbmGXMKgt5ZNJLJT3z0i8419?=
 =?us-ascii?Q?X1neot3iIDOryZMw2IPihwyRxUZFQ/nzmtNmMVvp/xnbX0+MdtHtX6y5R16N?=
 =?us-ascii?Q?Oe5N0nrv3gqC+HqBdHSkZ6H/2FX+mTtWFjkS8IRM9R6fc0Fw2jTD9MMW1Guw?=
 =?us-ascii?Q?q4gTDuseYyFqUQPBkBQVZyrtR63qRS76i4IsxazSjM8ZxKSfqtTxiD8ui3+A?=
 =?us-ascii?Q?pzPIr1+B2erZN5mawOGgTbP4+k3sZyBzFShN/XypaEXazLxwDz4tiPmDv3aV?=
 =?us-ascii?Q?MACaLB6/j1hcLQLqBrNt7dDsXyGJT0IfmuCgtzahAW3F8KEIcPQOaeoC165A?=
 =?us-ascii?Q?Ez76r1grSPz5slzfPnQvYZkbyCCJQfbGzaN9EMTLq31ALf22arwUJxTUkiY/?=
 =?us-ascii?Q?Q6BlhpeGSk+YQVSf/rXY8GD/MBtwiUjrDOXzpw3zPnTo0Y0qxyMzQYLr1/JL?=
 =?us-ascii?Q?jy1c8Az5a1I4944nDKCNGAakoiNV22BXKk+w46M1Hp6PDOf05h5RzIWAGxmt?=
 =?us-ascii?Q?b4V48iXpGcGYQ5Y4Nwt0zLqdoZNJr5C+9j5atk5lPv5HsFRM8+D9HNsNcwmA?=
 =?us-ascii?Q?fQfYdajPrezTwT6XF8d3/6fiBvhiNttX70wvqumRI/Q+gEB3ReQvxw2AaC25?=
 =?us-ascii?Q?Uv8bdp1KGgxBwEGrSt82dhdE5FMHfuXjTI5yxn85yPAmdzjw2lzKgtGPShU+?=
 =?us-ascii?Q?uAEc0Iad5N5PddFfPIJtGVqpq+yrDZ1HUKO8gbGrARbD1SXoJwgdY4DLaTTS?=
 =?us-ascii?Q?PLgj1Zi0XNpTMO/TIp3ZzKJ3Vb7ToC0EFWJbka+WzGJwyk4jmD/f3G0RvSxT?=
 =?us-ascii?Q?xarFa12Gz+0IQ9SukeGaJQw+fNqLTq9vOsmmVGIb0uUoQzTaz1X1F7jK6cBe?=
 =?us-ascii?Q?/jUPqZjHeYr9K3qlkdFl5syqGKakRq3nftIwn+73?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de50e1ba-358c-437a-566c-08db0dce9066
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2023 14:28:24.1981
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YNMi0RWjB+DjzNRTfSbb0xQnv7O2vA12hD+DXgEP455YFf8kwBVJ/9Nwb3htcXs1U152cSNpTizbkcqYyAMgzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6234
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > -		if (reserved != cluster_size - compr_blocks)
> > -			return -ENOSPC;
> > +		if (reserved != cluster_size - compr_blocks) {
> > +			dec_valid_block_count(sbi, dn->inode, reserved);
>
> This looks breaking the consistency?

Sorry, I didn't get what you meant. Can you tell me which data is inconsistent.
After executing the F2FS_IOC_RESERVE_COMPRESS_BLOCKS ioctl call,
use the fsck.f2fs tool to check and find no abnormalities.

Chao, any comment?

> > +
> > +			for (i = cluster_size - 1; i > 0; i--) {
> > +				dn->ofs_in_node--;
> > +				blkaddr = f2fs_data_blkaddr(dn);
> > +
> > +				if (__is_valid_data_blkaddr(blkaddr)) {
> > +					dn->ofs_in_node -= i;
> > +					return -ENOSPC;
> > +				}
> > +
> > +				dn->data_blkaddr = NULL_ADDR;
> > +				f2fs_set_data_blkaddr(dn);
> > +			}
> > +		}

Thx,
Yangtao
