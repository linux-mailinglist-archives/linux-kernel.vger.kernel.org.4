Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CEE6740EE2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 12:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232108AbjF1Kdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 06:33:52 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:9476 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231448AbjF1KbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 06:31:14 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35S90FqT020438;
        Wed, 28 Jun 2023 10:30:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=33mijaKoOEEZVAcp47V0F2L7xqbUcCfWnB+lLnFzEzg=;
 b=TB2/nC548rB78wFCqTGV3NmywlHMAmZsSK3FrMPka3L0Nj7/plID1HmAMYD4pPdWiLpV
 CF9uO35iBfnlmpWKodyY1oU+CLZApcEPXKc/YJZd/Hq7gYpw6KnovidxaHF5GdCcsvOZ
 9sNeX70vjB36hzSMyO+0pEjgL9waZCRGgcqEsD1EqPhjfkmEycjoN2j9viQe1NVVowjz
 uccbMvibzfyEdJbqElGTH4+cvl1K0xtZPXiM0bmyBcgODMnPdoADsm76Jbi9/7Zp8vJA
 kSCd5+Wfp/enbf2JgxTg2W6FFScS0IG9APiJEkemviQ4SpGB6UaUGqPtpZLt3AMbJoFT ag== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rdpwdf5mu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Jun 2023 10:30:12 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35S8XQRS008634;
        Wed, 28 Jun 2023 10:30:11 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rdpx5tr3a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Jun 2023 10:30:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ij2r/VYj0Sf3UUAWrLC3aDf73WQZfY3jUgT7D1u+3Q5xreZ88vttz/YDgrMFeY1vvRDfb8RUjdnj9k0WPs1+5zF3NinwSsSX+wAL6NzuHrGHGkCypucVQgFRCWoNifzFwzQFpfXhQ0emGBYJwVcZEu8LwjwL8C3cttjI/7m1Pz6AUXzhT08WZuTR/3qU44THh1E334TW3D5/EVhtSPfBlMLFUUxGkg0iJlm8iwX0AxQy8p9Q+LmMvkRaNZP7sG60hJfXZcIfrJYpVIw8BERwfuX30TenJeitVzAL89Fdz/NAs4fxk2rr/9oNJcA+2WqGW0MBGPOmVkFA6L/WirRn+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=33mijaKoOEEZVAcp47V0F2L7xqbUcCfWnB+lLnFzEzg=;
 b=hbLAgozfmXqbOxBJtrFwQT1rS80cX0lAWavRZHtAeJAD8QWpQzFD9l/7cjxbAcxthxaed3lH3fanIpwO0rk56VjEJ7QppuoBto7LZ7/vHMrfKuAjm7p277Dtcgi6gFnTnRBFg9ut/6SQSw0hOnVw9BiDBWVwmHKRhlUTZ4gooCrn415hqcECpLVBI0Dm9cWAGOVZ3iqhSI4JxWibpSSzdlI4awK7fZJQO29DPyL/sN7Ij6SzEL9HRXQCvdVPZK3DdosW5bjEX3pSZ0uo6V+cyoYWE1foh0ccwG+Rk5Lzcr2CUFhio8FM6qblpv3eqjvy6p4v6CHO/JXpdQtcA3+qYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=33mijaKoOEEZVAcp47V0F2L7xqbUcCfWnB+lLnFzEzg=;
 b=ni9pCBxPHMrm3S9sS9HuInlsX8ieefZf7aZfVCfZ4ddoHCwqhg8raXPVjnglRnTU3Lh9ziN2q4XQC4A1IiZ3GDxNWUBZlZs+TW/YgDDM1i8my2nRKnjK/JbQi98fbein2HLgmFTepDgUXqHCgAGFdX+601IgrN13FdAEdA16Z4U=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SA2PR10MB4715.namprd10.prod.outlook.com (2603:10b6:806:fb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Wed, 28 Jun
 2023 10:30:09 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::e38:5b81:b87f:c1eb]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::e38:5b81:b87f:c1eb%7]) with mapi id 15.20.6521.023; Wed, 28 Jun 2023
 10:30:09 +0000
From:   John Garry <john.g.garry@oracle.com>
To:     acme@kernel.org, irogers@google.com, namhyung@kernel.org,
        jolsa@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        renyu.zj@linux.alibaba.com, shangxiaojing@huawei.com,
        zhangshaokun@hisilicon.com, qiangqing.zhang@nxp.com,
        kjain@linux.ibm.com, kan.liang@linux.intel.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH RFC 0/9]  perf tool: sys event metric support re-write
Date:   Wed, 28 Jun 2023 10:29:40 +0000
Message-Id: <20230628102949.2598096-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0193.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::18) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SA2PR10MB4715:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c884615-043c-4cd2-1cea-08db77c2a5cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7oQqv7OqqonDIJSIWMEbD58a8JwoRlg0jI490APzIiceB10JtbmlRiAM8AoKFXoinTW0cLr2aZN/SMlGnofL63QWoTowhvCjHq3mCq5mZH+66vP7rYzTtiTWTBAHCfFdYjj81TRzGuUXe9imKC47xw58xb0hi4MDXU5/F0qBbIR51tDD1y1NbafQJz4laIGOeKfQqrVA+cND+xOXaJq/PtJg7EnX8/abymAu2DrWfUjchY9VfMrkTXBojvSdhftu1951Xo+v8NnslLY630G3c4ivJ3XZonUsaO4vMfk8l28ryCa7NPle7mFypzGXjc/agS1+ru588Od5lmI8k76JbLJmqkdRLdGtAnFT9SWOXe/7/qCn2UdUN8cVtsbaG3iDsx5ffEa2zNIkSJm2wWoygPLcPMmBgw4ObOLxL1+A2mStDKDrqvznWbLTJkKJFQyttky9wFXtly35FxBpwVWtTixat/9z/PFSAlvd8mK+9xwKXxGThRp62uqf6fyrGS+Osux6wjUTAviF4b36KaCkWlv+4nUjFA4RBvdH4stm5trBdXHrz+97CaA69oAaVEst
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(396003)(346002)(376002)(136003)(451199021)(38100700002)(83380400001)(103116003)(36756003)(86362001)(478600001)(6666004)(6486002)(2616005)(8936002)(316002)(66946007)(8676002)(41300700001)(66556008)(4326008)(66476007)(107886003)(1076003)(6512007)(6506007)(26005)(186003)(7416002)(5660300002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BW0LnjovkaccLxa+oL4ZmvwUGtmm0LBnxzMZOO0apLEsCKW43gp9N/GSw9XD?=
 =?us-ascii?Q?w3F7Kgol2s2CfUz3y0Kx8Hda4WiANwApXmoBA+7eTyF5wxqpdKwl7Hx0nPfH?=
 =?us-ascii?Q?2yUw2akJf6nj39mPX9I1ekTxLmkpmRAE1IfTA8JXQ+va1UalQkFJpCKcjfPs?=
 =?us-ascii?Q?IDPUX/gsVX5JDnMPVa+1OdqGahzkJL5pPJ1f6RARWbe+gCLmQQq1yMC3wzVI?=
 =?us-ascii?Q?bGznRPGHkzJpk6J2vOKb96Jv9f+AizI2S1wU/Rs8AWL86aDXfYRlbiUBOsUC?=
 =?us-ascii?Q?TVqor7RthAVJ4Bgwjab6nb52YW6DykwThx9YcS8EjSmMm1UikjBURYtfyirV?=
 =?us-ascii?Q?pbN9K1gzKrQ3ty+1ftvily2Uq89OV2d/ynaFq9HUI7TPm6OdpqthdTi5uAFT?=
 =?us-ascii?Q?2hzPg0FOBpjKjWsASkH765Osn8nAVdjoC4Ad3SckpMcPb/cy+F0VDV2no58U?=
 =?us-ascii?Q?sO5vK6z72jtgJYnqJTAo4erWxnxVeL4fg9TpbkX7vo7fxNfCrMQSQRAgP2wq?=
 =?us-ascii?Q?iheqRn3FNR6rqr0QU9J1dN9GITJ8NgoLrhu48jUI8Yofq4hlg/8FZdxlcKtz?=
 =?us-ascii?Q?nfFzRNE1i1/fgc5dWV7f018ip1zLa4GAOv+9iqenMuOTOcK3iYiDocFXnw26?=
 =?us-ascii?Q?OGq9IYTvwefXBYzhatMBEZqNUrvQJ3DHvrPYd8EvwSmgm8WIjwiObDWGA+/i?=
 =?us-ascii?Q?bPmKo3AZNQiXMLFTJnXHMMC49mQfmVo9GkLQxN0hOEOXwh88cpEbPLfEjvfw?=
 =?us-ascii?Q?NIBo9swX4WGehqKVbrvNYQN8FrdGqM9dIs+nB3cyPl7IpiaVmft9oXF7BCRJ?=
 =?us-ascii?Q?k5915iVs3jnOuKcgLOWhQECcdVznI1PI8mSaq0rFJHE2ieeod+6bnq4hYjJy?=
 =?us-ascii?Q?zSBEGVZJEYQtswtIxWoT798jt3hh9xibsuTploV+CeU5FUf9lDTSiT8FWajZ?=
 =?us-ascii?Q?Oco5rV7nYb8GfTVPoSP+0tgFkrv3JXL3VLQnaxkJ7b6nYqcMq5rRehj34sMy?=
 =?us-ascii?Q?HS7mNzOpGQXcN4S1bo2XPU0ztMhIrma1qnF6vA5ZJshNorxweett6FZcTNqk?=
 =?us-ascii?Q?OE8JmEtd503Ls0rEToeLVqDWGWItG03HBS7dyi98AYbuVD0bHAK25SGB3AeQ?=
 =?us-ascii?Q?UBfgb0HyLPULj+CbX7289Dj0lh0fZpQAj5PvDfrJz+mgWHb5Pi+/pLFXLXgJ?=
 =?us-ascii?Q?yUEeCexkRo8M9EmQSMqEQGPKtwLRipXuvqY/4TjIGq6oyAlO13tUjagkwlCt?=
 =?us-ascii?Q?qVZYGUnXEYANjuk/6LUNgdZxVJiHNQwYq1zZu30kesgJCHMxj/12P8EGQi4q?=
 =?us-ascii?Q?A5Ss6CrWysdVR4ZCY4CIvFQZdb9Xc8y0DCJliXPYkzwkpde20UKOttf+DULn?=
 =?us-ascii?Q?ybsQmhXQz9lrcRANsnX1jRQeH+EWuAUMn5cnXUFYyY0wc68wUXFg2aBu7s3S?=
 =?us-ascii?Q?QVQ1agh2Kh5OHrcHftwKIlzy9Aavs3EG3Udjaagj1+l2+Mq7ti+58L6Tjpjq?=
 =?us-ascii?Q?jikW/M0FmhHREYQPqg/52nmM9LJ0aAba+3Z3dzr6x6rFqxF2feJNW7ruhdKg?=
 =?us-ascii?Q?J35trZSNYO02bVJ/48FWHFn60IetKDs4qKYxafeaAyz6jVpxU7gqPvUBwCNB?=
 =?us-ascii?Q?8A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?aBYMHGr/csme4w0khUG9V48LpfwxkINd6F1TiL/I+JPFqFwdvk2HaePXUkKj?=
 =?us-ascii?Q?FqikZgOVYIowU79rAbGQek8fmrwDLdqUsKTbRsyQKmn256gutyVne4yhNiAF?=
 =?us-ascii?Q?IFYc293CqMQcqqABoXRpwn+PkjphM0CBe2KgIUOsbPc5RsQRV1I0XzD/NADO?=
 =?us-ascii?Q?c+1qlDFOs8NVKrQnqoFUzx0GfHQemvda1PcaNMxL09pLV5PAv8fbRyt1wHZB?=
 =?us-ascii?Q?ZfZ+qmKeUqEADPgwG0KunCyejhlsysTQtGPG2lDyGnDrtqSpYIJi4ty9cr50?=
 =?us-ascii?Q?3jOc8/vt4yyHql5wgnVbrhddkAuxzxKwWl94t/XwTP49tGlVHLCdPTZjblzq?=
 =?us-ascii?Q?TmfcgUV9R/3hfMS+8MvOIT36LwlCdDluFA5lwl2Hls3ly9MP9OW8F3fq+A9Q?=
 =?us-ascii?Q?gkG9OjIzjQ6DzynVIA0tJtacDorFx8UXj6jmptIRbyIqcGu+AVicyEXNtuh8?=
 =?us-ascii?Q?JOZQYrXBM4oYR3Fgc5AQ1F8ILFPJNN2mdwekRWpjPEXvoltMrIbadkYEJHyK?=
 =?us-ascii?Q?6MQ57jrRFM1UUHYoFuirbFsb3ngHs4SlWACXK6JpHs9jOvvEC9dEwAbOxbGL?=
 =?us-ascii?Q?Z4rR1kxsIlgWmH/ACG/sQMSCcIAIyawyUGd584Ui8PMrDTjRqM7OcDYw0P0u?=
 =?us-ascii?Q?gtzNKbRYHkGBzvIbGyf1zzIoxLHbs2zy5nkEu3vg2YrVdd/K6cLoWYkXdBkl?=
 =?us-ascii?Q?pnycUMINKqqsgZWaGCCLy9SYqv79v5+TlRcBEBd/92x9j3Wp8yrD7nsg00gX?=
 =?us-ascii?Q?Kcv7z3+/dTLdP2CvqU6SjlAPSTOKSZ3vMjljhqOMrV11EXNYck/TCu0+gKip?=
 =?us-ascii?Q?7NO4IndSc5Hxxat84WUxD+HQL0pn1AdaZhGrV1NzJMkBlJYbF7Tgu8VeLzGf?=
 =?us-ascii?Q?mGtYyftJcpo91/acNdJeh1YmBK0pU7LU7hZTOI9OKt0pz1kuTgAgG+IGSNqE?=
 =?us-ascii?Q?l/XODjsjn672km3plbjRDEWqZxcBj0D2O6Lv2mK8+FmBD3imTG5P0ZZcBC+8?=
 =?us-ascii?Q?6q5KK/RqEFySHlCl8I886sYtXemlp99oxnEm9M8BsyYb89G+AJCePB57CNBh?=
 =?us-ascii?Q?lM2pHKGZpk5y4li/+gjaAyOzvO3JQQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c884615-043c-4cd2-1cea-08db77c2a5cf
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 10:30:09.3449
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jFRMDqe6CJq12SFhi+/J8vAqp7q6TIJ2eu/hetrDkRh3FjrhJ7/C5yNaT3A2z4380iE3sI0ePOPhiyNvxr3teA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4715
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_06,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306280092
X-Proofpoint-GUID: qZPViu0HfjSjylA9NEydAmgSoHU2ZdyD
X-Proofpoint-ORIG-GUID: qZPViu0HfjSjylA9NEydAmgSoHU2ZdyD
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current sys event metric support has some issues, like:
- It is broken that we only match a metric based on PMU compat, but not
  Unit as well, as reported by Jing Zhang <renyu.zj@linux.alibaba.com>
- No real self-test support
- Not able to use resolvable metrics
- Need to specify event PMU Unit and Compat for metric, which should not
  be necessary

This series changes sys event metric support to match metrics based on
evaluating each term in the metric expression and then ensuring it
matches an event from the same associated pmu_sys_events table.

Why an RFC?
- Even though main motivation here was to improve self-test support, that
  has proved quite tricky and nothing has been added yet.
  My desire is to test the feature that we match metrics for a specific
  SoC when PMUs with matching HW identifier are present. So I would hope
  to add sys metrics for many SoCs in ../pmu-events/arch/test/
- I still need to suppress logs from metricgroup_sys_metric_supported()
  indirect calls to functions like parse_events_multi_pmu_add(),
  generating logs like
  "smmuv3_pmcg.wr_sent_sp -> smmuv3_pmcg_50/event=0x86/" - we should only
  see those logs for when really adding the metric in calling add_metric()

Based on 82fe2e45cdb0 (acme/tmp.perf/core, acme/tmp.perf-tools-next, acme/perf/core, acme/perf-tools-next) perf pmus: Check if we can encode the PMU number in perf_event_attr.type

John Garry (9):
  perf metrics: Delete metricgroup_add_iter_data.table
  perf metrics: Don't iter sys metrics if we already found a CPU match
  perf metrics: Pass cpu and sys tables to metricgroup__add_metric()
  perf jevents: Add sys_events_find_events_table()
  perf pmu: Refactor pmu_add_sys_aliases_iter_fn()
  perf metrics: Add metricgroup_sys_metric_supported()
  perf metrics: Test metric match in metricgroup__sys_event_iter()
  perf metrics: Stop metricgroup__add_metric_sys_event_iter if already
    matched
  perf vendor events arm64: Remove unnecessary metric Unit and Compat
    specifiers

 .../arm64/freescale/imx8mm/sys/metrics.json   |   4 -
 .../arm64/freescale/imx8mn/sys/metrics.json   |   4 -
 .../arm64/freescale/imx8mq/sys/metrics.json   |   4 -
 .../arm64/hisilicon/hip09/sys/uncore-cpa.json |   4 -
 tools/perf/pmu-events/empty-pmu-events.c      |   6 +
 tools/perf/pmu-events/jevents.py              |  11 ++
 tools/perf/pmu-events/pmu-events.h            |   3 +
 tools/perf/tests/expand-cgroup.c              |   2 +-
 tools/perf/tests/parse-metric.c               |   2 +-
 tools/perf/tests/pmu-events.c                 |  29 ++-
 tools/perf/util/metricgroup.c                 | 182 +++++++++++++++---
 tools/perf/util/metricgroup.h                 |   3 +-
 tools/perf/util/pmu.c                         |  20 +-
 tools/perf/util/pmu.h                         |   2 +
 14 files changed, 220 insertions(+), 56 deletions(-)

-- 
2.35.3

