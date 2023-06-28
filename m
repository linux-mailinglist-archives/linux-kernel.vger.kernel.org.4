Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A701741206
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 15:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbjF1NN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 09:13:57 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:13162 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231235AbjF1NNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 09:13:53 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35SBTKYs011269;
        Wed, 28 Jun 2023 13:13:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-03-30;
 bh=B3eUvsReXW5f2NLzpJqQAokxwIYjjhyvH6LecC8+WWQ=;
 b=i9WNRjoG6JUrhduebQH9diDUh1bdEem1Yl6rZCNjzbFZ/PLn90/wldzhT9uQ2eNvZ4Tu
 +faxeZ9ld/Iu5oXOw1YsZNW51kv7aHXr7ODYbLd+zPkZ+536MAToOiuRhnAjZQEGu8ep
 zpXS5JdDIdoejPp8RqIYgqw5NeVfIS08B1HCchu1+PQY7xMEfqh8m53QHgHQu0fCKFSR
 JKvRRepGpwKlJ4VvM0cYiq4BM4/djHN0/U3flcgQF6Ea2q6z/+RdFv2u8hNA8jakzEak
 FeIOHHb9MLsfTqt/TgUGD1sHX8HTuhBxw8v77ukadS4kqQVSqMWcEO7z9ip9SinJeF9d Iw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rds1u7c68-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Jun 2023 13:13:39 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35SBbZfd038205;
        Wed, 28 Jun 2023 13:13:37 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rdpxcgfjp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Jun 2023 13:13:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ClbdkqSXOW9XQ6gq0r6M1k9v1nvazreSfizMzk7kOwMAZ9/o9PbthsWwg9cqh4kK3Bx4zF/S8RS5Vmr1oPfAZ9qmGpEPQ+grnlj5w+xxjoRYptoEzCsQbK9nDy7/CIN361H0LF9t40qzRlHSBMLAbalrmJEtFfY9b8g+uaaJ+xq2PkQwV7+RRWBICAdMAo15d0IXRtin9O7yjRTJxfX3phNckvpU8s4R7w0PYbyS/tDd4q/Hb7jkW2JY192JZo2m+qY7VOiIHpwwLujk043eVWvWSpjO8WvLQ05Lhz8cwg3SBzanwWpev2zUxEsoA2+BcAKvcx+W6WQ0bi197reppg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B3eUvsReXW5f2NLzpJqQAokxwIYjjhyvH6LecC8+WWQ=;
 b=LqmhgLM6KKIm3znn1q7pvdHz48uYkAV2VerCRb/gsLjOUhFnwPsx3Dub9mkZX+pD4aaH44Yz/3sWv/+VxC5T/fLBrAjMzWCJdZo4dQSvTUgAqjwdwV2bq/6JvxNNmP5p+ea3nFqm+lfGBR0mS4iw+jmA8QK75ylRZD8v2suWCpIx3ducsj+GhT2Bzvr7V+/43ihsL+lCEpix8hA4Z/RO9Nrfnt3SRNhYSOhf9BoqMZ/9qQZmYRDlnCZN7jFJJYpgZ5ZV/bKO2gyXZ0XdMBMzo6raebnj0TfhPAIaSBi2tM+SAE1GbcyZ+X/hcY162gL6y1e7sGQUDQCFqcltOvrJEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B3eUvsReXW5f2NLzpJqQAokxwIYjjhyvH6LecC8+WWQ=;
 b=KAP2pDwcfdQnn/aHTTO6zIpOQIqjbN1PtIBqEVAsKxQ0pQwnpVSCJIdF+/bVNhprX7Dud8LqjduVt1+HLGQ+aYChFEkFU8EQZ0a0STIR2V3XBbEiSJxB2dSQWO+O1y/hUSFNdXaCzpAOAf1VnEDgXpBKDrc17LnsHxDUrLgJ7Wg=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by IA1PR10MB7472.namprd10.prod.outlook.com (2603:10b6:208:454::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Wed, 28 Jun
 2023 13:13:33 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6521.024; Wed, 28 Jun 2023
 13:13:33 +0000
Date:   Wed, 28 Jun 2023 09:13:30 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     David Woodhouse <dwmw2@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/mmap: Fix error return in do_vmi_align_munmap()
Message-ID: <20230628131330.ufrp57vnfpynlapq@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <ef2c7c0eeb166acf050597f49eb118d94f18bd39.camel@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ef2c7c0eeb166acf050597f49eb118d94f18bd39.camel@infradead.org>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0400.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:108::10) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|IA1PR10MB7472:EE_
X-MS-Office365-Filtering-Correlation-Id: 7626e85d-359d-40e1-410a-08db77d979b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SkjNjXupBVsq2SkGXUvzGk1rOwEfN1oQ2Gfj/TrKn8HtlQuA+jYlbN7R86PJEiM0u8EqQC4523qKwBmQD4Q15+TFnMZavR4Mg7D1BkqR3MzJycIz/yy0KrFTBZPj+y9N8uDDJZb88UyzLsSR+ukdbrkPqr1sx2J4y499i2Z+FokKcxMR0z8bpfn3CSPFcLndM/4FdGGYPaXfrEO9yy9JwvW4suWBwBS/eA5rzz1mJGquKIyUi/5SJ/BkcU7XsgGp0EDCyOLn0L70rGk4pbe3swvK4Y/CmbXqu4YiKgS6w4qGfGZrSieoRePSz6C1n5CvY7jTNNwqKvdE3UYx0CKdJMuHKrCyFB63oQeqIQtojyKcZ7aMP0Jlv6I4IlRxFdxmRW+QjgS9sN+AjpBedKZW813n56mccJJfPXa7zDqGhCnggN3jrnXyJGGI+NsRcyc0G5HasYA5PjzJsHEDZGI8wQagPJZcDvzA3RS9tBReOOkLeNbXDDREVDaoMNrbWhtxhIOqkKCpud99iCesknohyGOxbNz7//Ptg2GRPqC9U2g036kv6jwDs1hzPJR+sZ/+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(39860400002)(366004)(396003)(346002)(136003)(376002)(451199021)(6512007)(33716001)(6916009)(66556008)(4326008)(8936002)(66946007)(8676002)(41300700001)(66476007)(86362001)(316002)(38100700002)(5660300002)(9686003)(1076003)(186003)(6506007)(2906002)(26005)(6486002)(83380400001)(54906003)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MVU2OGhQWkhhNkg2M1VvSllydTR4V1BUTzV5cVdGZXp6NmIrMHhQdzh0bDYz?=
 =?utf-8?B?cDJ4NWtNcUN6VzBrQ1ROcHFQbkhYM0R4NFZpWXFPY0ZaOXRmM3d5Q1kvbmEr?=
 =?utf-8?B?Y2M4SjdFczZMNTN3aGF6UFNlOGV5eW8weUhvb2JpQ242V0NyRlErVzJub2lq?=
 =?utf-8?B?bHg4UDh6ZDI0WmgyYnJrUDBFY1h3aTBVcjU1VWovQStwOVhZaXFIQ1lWRWxF?=
 =?utf-8?B?Q0cyeW1FdWgzMVV4ZXZ0VmI3Njh2MkROWGZwajd6MktBdkk3RW5iS254UzhY?=
 =?utf-8?B?eTJsVU9mck01LzRYNGpEd1ZVaUdiZlZBdXEvWFpqRTlKaTk3WFlTdlVMZXMx?=
 =?utf-8?B?V1BCWW1pY1ZvYlVQeFZ4bGlxWEVBUWpSVEtYWmp1U2I4MGNVb1Z2UWRFeTF0?=
 =?utf-8?B?K2FmZWJkY2pEL2t5VXUxamQ2MkUwL3VFVzh5Ni82MUxUa0cvWVdjZ2tCUmxt?=
 =?utf-8?B?VVJ6bW9UcFFEUmMyZGo4RUZ0TDIwSUo1TGZ0VmdVUjNKeHlGaiswVC9Da0Zl?=
 =?utf-8?B?N0YvQ0NBNGthbVZHUjdTamNOTzhwdCtjazFQWjhkRDhxdjZ5T3llaGpPM0dU?=
 =?utf-8?B?eDFOZ1hkdG9MSENBQ2k2VVJySWJUOElFV1VrR3dsM094QlZCNmkyVlJCMWdY?=
 =?utf-8?B?VDNMWWF5SWtwLy9tRkdkaUVONzB6eTZZMkxiclpRTmpPaUJTNXYwcU1jdElF?=
 =?utf-8?B?WlhwYk5aZkN1S295QWViNXh1ek96V1ZtOFRKY20xTmtxUmxZOUgydkdQSWJ5?=
 =?utf-8?B?MmUyUUxabStVbzlITVpSSlYyOVVydDVUTmZQLzNISTkrSlMxZFlVYlAxRFpu?=
 =?utf-8?B?bjM3TDVLdnVDRjNYQlFLUDQ0YTlLMXJHMVpKbnhTYWlYbEZyWjY5eUlNNmhT?=
 =?utf-8?B?UjdZRUkrS0VlQlpTa3BxYUk4b0ZwdUtjR3U5L29nNlJIVWh0VGlNdktxOE9X?=
 =?utf-8?B?RG1OQTFhajFzVC9lcEtuUDNHUmpLUG1wMkFMKzhUb045K1NTL0k0QzczaUlT?=
 =?utf-8?B?eVVsT0tBVzhzZjYzQW5rWkgveEk4cWtVSC9vMDBRKzBFWmlGL1VWdzJkZUlq?=
 =?utf-8?B?dHVMT0pOakc3OW5OOXVNdndqaTlzT0RLSEF4RitNWngxV3B3dTZaR1JEWHIw?=
 =?utf-8?B?aHRoOTZjNDFaSW9CRlQxVUFkU012UGhiMmFnUy9SOU51cG1PUHZjaDZRZ092?=
 =?utf-8?B?YWVkWEtFR3gxcFdOVHNGbUFDUGltbVVHbVJsSmVIRHc0Q0xtN285L3hleDZH?=
 =?utf-8?B?dmRkdTR1UHp1eWo2WUg5YW01ai9UN2FKcFI5aHBiTVprTmQ5bTUyU2tFQk5j?=
 =?utf-8?B?b2QyY3RPMHRFYi9ZdnRoMVB4ZkJGOGUxVklKTi8rRERFNjdjTlZjOElDQmVI?=
 =?utf-8?B?VzhMOWl4cFY2WlMraEZYc0FETVpLMFZjVURrMFl1ZW0wNHFDUlNqa1FTYlRt?=
 =?utf-8?B?dDNGYU4waVlIeVZxODByL0VTMHd1cnNSWitKRldaY1l3dWRoVTNMMlhuUkFm?=
 =?utf-8?B?a280ZFZzKzcwQ1BmbUZmenVGQWF2R21HQ1lpUlZLay9MVCswUHpVWlFzOUVQ?=
 =?utf-8?B?RGRIU2ViQlhZaGZwaUszbDRRbDVlZGVDT0k3UC9lVFI0M0VKb3FLMkdjVXlL?=
 =?utf-8?B?OTFJU01Zb0dWSkdTTDM0dWtTeUZ1SmhJSzloUmFVcHlKSnE1OCt1dmRmS1pJ?=
 =?utf-8?B?NG5qaEhrSnc5KzZkUGdqbDl4QURGaWd5NXFQRERQNFV0SDB1cHNFdnNNZFB1?=
 =?utf-8?B?WWJFYW44WFJIQmtaNmxzSU5sQTNuR3JSR1FXaVlhL1VuNk16OEhkSzl0cUp5?=
 =?utf-8?B?Nm16NnpDMlMrU0lKaHhNamhKK1BNeFcvaVZqZ0ZTcVNhWTJSb2dyK21NNTVX?=
 =?utf-8?B?a0srNTlDaGkwSUtVUCs5b1hScjdJaytXVzF1aU1jdnlxNFpoOFRxaWU0djVa?=
 =?utf-8?B?UU5GNlZYSVA5b0U5bG1xd2ZaWHc1NThRM2cxV0JiN2l2bk05TXhlWEo0RjY5?=
 =?utf-8?B?R2laUUVMbFk4cVE2Q05qdWV4eGtNWFdVSmt5c3MvZHZCQTVoNVVXTTZMWTlT?=
 =?utf-8?B?dnJJTEgxTDFhZVVQaUhTbk54U0hBbXd6TUR6MmFwc25vcUtTZHZvclduT21a?=
 =?utf-8?B?UGtsaGxYbzhneGJiMVBNbEFVVGkrQi9NSURESzhNUWN5blR5WTFNZWpGVS92?=
 =?utf-8?B?dkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: WcyGu6wbRtHaxaZ8+Nr8Ophk84GzugwkxXAw/pD/nikOzeiF8+nJ10R9fOG0Ij6HCMkqy/lIiYezqm2f3pbqUL2jQBkO1AIOb8T2C1qcplm085HR/GlsgbNXEJi0+NwRGhHe8T/HuWp6aO8vgKi/w93IqADnzqi8BJBmmM2xpmykM8Yz8eJ7SULwbRvOa8ivdoSs7HQmQz+0/oB0okcn9gtQ0NjdCZwlt1uNQX5sCD6JXgDXjTgPNuNj/hl2+5pHMsoQsAgOjlfU8nYVP2ydhpsrt171/b6oaPOrI1nMju3Nu52tM+lIrVkmOBTH6lhgJSGpULh4Cg9FiZtWa/7dYO2pgNQnXwyBmQ+OwHMImPWYvvA4huFNnISQV7uvH6Gk6Hv/87LA0uwSu4qJbMmqBLuJpCXeStRzoRGxruN/pIufF7DRtw9WVz21SadltmuXg0D6nW0hrEXqqeEPv+Mmn6ANT4gO/p1l5n2VEkTuMk5RARvxFITkWl4AF80UvXCP8W4q7in/5qAAxYDfWFJ3iGfLZH3c/IPoJd5de9yp7iIz2aIQ4l4OPCfjbXhvzm9+pPPyIUQoKf7LPmfvBKf4Z++aIjzXY0HwUN9y15jZLEvcWCSR03Ag2Tk5XEnQP4CzQkSdJX0OpcsyPyxiwH3HUlxD6GekCr+WChcpAl0+LmjrAR2wPJnAMrXkPiU1s5uukGfzVwXZvtHvPwwg6yYKDDTSBYcEsNRffDZ2zYoGvll0iqDtGReIocL/i1cyb3Pz5A31wia2RC6yGFs5rcRxs6kZsgsswNhLaG8SnQZx3MOInzD9TAiwf64jDwhWjWk8J6vvKKcv4slhtcHwoB3eLDdHO8s7p60pAgTwp+Ybw6HtXhDwcsPDTKE1vA4lVVHd
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7626e85d-359d-40e1-410a-08db77d979b0
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 13:13:33.7342
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A4muFoJFdCD9Ma7M0lbQGjrN8sbYjutdg/Rkuwp2aPDWTrv57Se2GcRVU1+GnEGproX/THmkzqawhyhOi1DUjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7472
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_08,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0
 mlxlogscore=884 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306280118
X-Proofpoint-GUID: oXacdQ-h-FlBBcwMSTGLAISZvXZW6821
X-Proofpoint-ORIG-GUID: oXacdQ-h-FlBBcwMSTGLAISZvXZW6821
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* David Woodhouse <dwmw2@infradead.org> [230628 06:43]:
> From: David Woodhouse <dwmw@amazon.co.uk>
>=20
> If mas_store_gfp() in the gather loop failed, the 'error' variable that
> ultimately gets returned was not being set. In many cases, its original
> value of -ENOMEM was still in place, and that was fine. But if VMAs had
> been split at the start or end of the range, then 'error' could be zero.
>=20
> Change to the 'error =3D foo(); if (error) goto =E2=80=A6' idiom to fix t=
he bug.
>=20
> Also clean up a later case which avoided the same bug by *explicitly*
> setting error =3D -ENOMEM right before calling the function that might
> return -ENOMEM.
>=20
> In a final cosmetic change, move the 'Point of no return' comment to
> *after* the goto. That's been in the wrong place since the preallocation
> was removed, and this new error path was added.
>=20
> Fixes: 606c812eb1d5 ("mm/mmap: Fix error path in do_vmi_align_munmap()")
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
>  mm/mmap.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>=20
> diff --git a/mm/mmap.c b/mm/mmap.c
> index d600404580b2..13128e908470 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -2387,7 +2387,8 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struc=
t vm_area_struct *vma,
>  		}
>  		vma_start_write(next);
>  		mas_set_range(&mas_detach, next->vm_start, next->vm_end - 1);
> -		if (mas_store_gfp(&mas_detach, next, GFP_KERNEL))
> +		error =3D mas_store_gfp(&mas_detach, next, GFP_KERNEL);
> +		if (error)
>  			goto munmap_gather_failed;
>  		vma_mark_detached(next, true);
>  		if (next->vm_flags & VM_LOCKED)
> @@ -2436,12 +2437,12 @@ do_vmi_align_munmap(struct vma_iterator *vmi, str=
uct vm_area_struct *vma,
>  		BUG_ON(count !=3D test_count);
>  	}
>  #endif
> -	/* Point of no return */
> -	error =3D -ENOMEM;
>  	vma_iter_set(vmi, start);
> -	if (vma_iter_clear_gfp(vmi, start, end, GFP_KERNEL))
> +	error =3D vma_iter_clear_gfp(vmi, start, end, GFP_KERNEL);
> +	if (error)
>  		goto clear_tree_failed;
> =20
> +	/* Point of no return */
>  	mm->locked_vm -=3D locked_vm;
>  	mm->map_count -=3D count;
>  	/*
> --=20
> 2.34.1
>=20
>=20


