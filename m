Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F78B74185A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 20:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231582AbjF1Sxu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 14:53:50 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:44202 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231185AbjF1SxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 14:53:19 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35SGwv53019748;
        Wed, 28 Jun 2023 18:52:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=K+AA+kYbNK2C8VbAVOrXqomOnTOwqL7DHRi/gDse0kY=;
 b=oNMMB2wqdsWthy3UL+qaumkXQNV0ed+uAL0MY5oMz+iwQG9rm0wdWDGvOZfQWPeqhB1i
 bsAIMo+tI1c94O1v5/paLmTNjMJcrFWKM0P1/Stjgygd36Wrub/7JY+CgCcQQfo5JJv/
 Rowpq1pUiWBf9XbfrAlakdIBjvky7+49xTr+IuKT2v7ksH/uAm8sz/7QfRw4oKiZYtaN
 dvHNghsMi0Rf63h/oIy31ykzWFKAcQo7VDpC7HYXKbu+b/QLOlalDHfTR+a+LW96tALb
 QCcywlof3Ihc++5Z5XywkKltIaEyvLnMSQVTcVh3pWCD5mc2xUsVESZCBN0fTt3l9MKB 3A== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rdpwdgjwc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Jun 2023 18:52:52 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35SHaNjK013088;
        Wed, 28 Jun 2023 18:52:51 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rdpx6n2wd-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Jun 2023 18:52:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z8GXQC3vrH2rbq09lM1BqcChX+nVwk94WjCqKn9bhnv2UZ+I4zHOwm97jieKQVAgRlkBV62ECZ1kc+6FeTht8K9cd5H8qOJ1lblKizUldESFOZnxjEgO5vbNBk4UpE8bbp+sMSO4VcyNHBaN8uf+qOj3YEwZelWBTwBz0uUuTAvQqyaWHlNa+OtShYyZsk3bfpi2CovBuK15uJ7VI/ksorCx4MC/KHmIsk9T7U4pYFNQ3KXdrlaGpeUSll7rmGetY1c5TC2Q2+Brxmo/eTG72kMdc+3C6w80MD97yHVZ3/Px/gu/ZZAd8sFgsFNu4UogO1ekGi9aSkSZhEaxyxHlpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K+AA+kYbNK2C8VbAVOrXqomOnTOwqL7DHRi/gDse0kY=;
 b=R0fdBzqJOvtGShFpugEA2N+tHgjPAxPHwzKC2usAqZ+KD1GwvGRgUGtJFYpI3M87/NsdBXdp/GMQPRiWHMptC+v0xmevIvPUhomRkjBUe9Pt/pZ3kXF31I9uDkW/LzVDuuwcJIUTCcGKUkydlYiNp2i2w3qCjcYVUQxXEvWWmNbarIuDfif70ee+d5XASOqIa0xGWrTSHnzEpBcKopL1ZOvSYnNVN+blxcWj3VGBj3nVN6BsgoGkLhNBycX0mdvrvw8CC+VQHMdRSt7MkvnVxkNCwQYaGKkr8Q0t3zLNipi+BZaN6cXsIreYJHZOylDWz+84SEB1+iqejcKzktFIEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K+AA+kYbNK2C8VbAVOrXqomOnTOwqL7DHRi/gDse0kY=;
 b=Y2bn9dkQsqk8Kmh/AM9ytwLCc5g//3X+AUsKgxDNv3GqE33nfo9ngltW9YpCtOqpQu+Uk+YjnLxL9yQev2v/ew4fkSyEn25g+LEKulye4i3v/Vjb8Vwwr6XYn0VXKcN0XB6xzaCIyJUuR/OC5gUiOlb4bpt70PNPV8uA4H0APQg=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by LV3PR10MB7820.namprd10.prod.outlook.com (2603:10b6:408:1b4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 28 Jun
 2023 18:52:48 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::8b8f:b4b1:bb78:b048]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::8b8f:b4b1:bb78:b048%5]) with mapi id 15.20.6521.024; Wed, 28 Jun 2023
 18:52:48 +0000
From:   Eric DeVolder <eric.devolder@oracle.com>
To:     linux-kernel@vger.kernel.org, david@redhat.com, osalvador@suse.de,
        corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, bhe@redhat.com,
        ebiederm@xmission.com, kexec@lists.infradead.org
Cc:     hpa@zytor.com, gregkh@linuxfoundation.org, rafael@kernel.org,
        vgoyal@redhat.com, dyoung@redhat.com, lf32.dev@gmail.com,
        akpm@linux-foundation.org, naveen.n.rao@linux.vnet.ibm.com,
        zohar@linux.ibm.com, bhelgaas@google.com, vbabka@suse.cz,
        tiwai@suse.de, seanjc@google.com, linux@weissschuh.net,
        vschneid@redhat.com, linux-mm@kvack.org, linux-doc@vger.kernel.org,
        sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com, eric.devolder@oracle.com
Subject: [PATCH v24 08/10] crash: hotplug support for kexec_load()
Date:   Wed, 28 Jun 2023 14:52:13 -0400
Message-Id: <20230628185215.40707-9-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230628185215.40707-1-eric.devolder@oracle.com>
References: <20230628185215.40707-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0050.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::25) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|LV3PR10MB7820:EE_
X-MS-Office365-Filtering-Correlation-Id: f32b46f7-2006-4e83-5792-08db7808ddbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /l0M4CV7VgRzVCfpzNoW6LdtuGs6k2vQme6TRtX1P6/giIdNeiKquzw/WheAiUpHklMP6u1r1YhnrS2J0xx27g0iQ1FXRP5IbZneRSoFm73chqMgFpzcl81Q5Vrq7EdYognF9Bo3v6/EXqztjnqqtHzRk5u2a6miODQHMo8Si4+ptahhgIXb7NG3VnmAVPq9lZk6b7rTzBUN64GbnKjv9cOHdF+DQYdq4pxzrwTOFeZqEl5u4zLbA075gHk25LBM8eJAEt10FvVRqDWFnoYECoFMGW4GIwRTWL1Alpnme6n6658xNGs8fj3cW01dfl5eFNHeYjTCGQrB/Z8jPblxeA5FYlCrFmwepHQZP2hDdnJfu3kZdWJGrZBRUethBQCzraUUJ0uurWUoBQs5EPF1YI+gVWYE0PrQ1K53yrUd2FYjoPWmnu2NPUGZTewZoVTo3WdUb6BQYhSpDIhG33JXSp3HgPOv98vhgQnBRl5U2otfPcA3TOZXBTeBkVDF7PTDTzAJfw0X8JoRM02HaM+rtBlhjOxZWyfE48Ukj0qdypC1Rg88k7GiNpcrDLU20NXW7WM80DKJzWyaH2tgu0ppEbJv+RXtXuPrquIFQf+LtdQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(366004)(346002)(39860400002)(136003)(451199021)(2906002)(83380400001)(316002)(30864003)(26005)(6506007)(6512007)(1076003)(6666004)(6486002)(186003)(478600001)(86362001)(107886003)(921005)(2616005)(66476007)(41300700001)(8936002)(7406005)(7416002)(4326008)(66556008)(66946007)(8676002)(36756003)(38100700002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nK+gZPPL1ASswyUZn7UswpYYvCbA/Hup6a3J4fiB5nwA/gR+LEbuMCQUawpE?=
 =?us-ascii?Q?/WGGuvAE+BIPBqhJzVEnRIWQQFtLmzrefDjj3RH8iXM5UGwZaOJL9bUx2ihf?=
 =?us-ascii?Q?xLu9SYzqEe70LxrnYKOPHnAcZM1PcP1zLIijpM0x8ghzu/+8Db0ApT8AHMGK?=
 =?us-ascii?Q?0GgYwU2p4O5REmayzsOvcXz2PF8qPpe3vjYhkIyBknHVAFn+Jd6Sn6hEe8zQ?=
 =?us-ascii?Q?8NFriwZpKpXqfQCcWTpH95LpcbiYmdYpPQ9C+O+jh9riz6EH+ZF65qcBAYJY?=
 =?us-ascii?Q?6FFWZVHjATO9yX49yRaiSmikqEGTadTELiEFphJbVeOeuA+A7oBXHJzfqUvf?=
 =?us-ascii?Q?Pl+nkuhLAT0xtMByBudbSbbu6yUcl1pKRiWEJyUP3kgSUXVImkRz+I0HZYD/?=
 =?us-ascii?Q?o6bZe8Jnax7YhnfgeJMblheUrFN+9/Bb8xW2XeEHqVeXkbQflyOV6lr+7VP3?=
 =?us-ascii?Q?f4YAF/XHa8UNp8oc/kDaFJF2LgZB8NST6QX7Eejo8ZaOgJXfpz5eXlGqkuYE?=
 =?us-ascii?Q?u2QCo2FMmEAWSp9yz2cFYfOzOZLOw29YfUbbYjvZvTovUaEai27vxb6/3ZKu?=
 =?us-ascii?Q?++tyJ7SKVeeS300D62F05ERQEaWDgDENwG7LieepMp9W2usVfdTPbFCs6ofu?=
 =?us-ascii?Q?AX5KaNagxPBFi6/1F+3F/KHIjxcLFK2hUNj1pPupav0OthGM3Md9uSZ3JW9I?=
 =?us-ascii?Q?S+BSQj1ILE0uhxyniw1pVsWnR1GQl8vWem5RkZTojqrtiWwzw5agkuFuJbMm?=
 =?us-ascii?Q?O0QkQD8pz6e+pVoQvmy3BeeJj0yCJ1XAkT0XUf/p+eUXpJIrGKoWWuVQJ2U1?=
 =?us-ascii?Q?piGo6nClq1ylmEnkGst8yts4PGcNdiAsZjC8SAuheYpHlgkbNTh8KqLVa1Me?=
 =?us-ascii?Q?o03yMyUneZVeJzTnp9RnrGy7hK1H5/Tde3evPHmi4w/YmsyrZ/pbHq6vlo7k?=
 =?us-ascii?Q?h0zJyHwiQkkczYRhAcF3URk23cLg9KiEO4pOnn9nvrbdJTfnG4EkBzOF/wFg?=
 =?us-ascii?Q?xtz1JI5jXvpTy3V79wn8LIlS9B7KLEGvjWaUmWNMgOADYYvMgB7FSt9ygFWy?=
 =?us-ascii?Q?MYGAlk5Pu+8vP4qNBRYez5yS0Pk7U238VC1C4RO0wNtFZF5u9YcuZkt0W7l+?=
 =?us-ascii?Q?gOw4+7j5IDrNcglipWQK9GocHaGgPAkTE5QgRAtZfpA1Ze5se4iuMYX4xAY0?=
 =?us-ascii?Q?6x90l18WVJIl/mP8sy6HXKpTXjbK7bAfVnC/ErmirOMJ+uxcxIWWqDVKSKVr?=
 =?us-ascii?Q?MyfqvUutpzS1b7O2eiAIDU5n3Q1ZzG2bM/OArIw28VD0IqxvBhePRsRkgkl8?=
 =?us-ascii?Q?FJo9v0BeIQ1pk78ltnkXkvDY5SzX+UYx2amKEw6YNR0jSfo3lteB5oK7BtQU?=
 =?us-ascii?Q?pwzKDwMRnu8SPrHhnTpnrWs2iXiM6tIF9WGxESbRNUqgBU5AkV6mvEYRYdo6?=
 =?us-ascii?Q?ysJy0gwrASmumrqX1FOOkSz4TfYrXGaa/mmShN3I7ODM5VZUHVXqOy/62Nya?=
 =?us-ascii?Q?WGz/3cUbLWkZc22J613XNN35kKJl2XuwEYw97rtvF91sxeWcL2IMIFA0Ez0N?=
 =?us-ascii?Q?qyYrhTn4lf4BnbGmx0J4C0rTSveSBv6X6LlcaT0o6nw2ZDZLSQ6s8OzZbxLO?=
 =?us-ascii?Q?GQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?LZcPN4+jlkYhKBuezatZeRNFz31jv3i3k3Qe4C5UfSc2pH7hNorf0d4UKyA8?=
 =?us-ascii?Q?369XHT2sJkCTaQpPF9WcYmwT0ZdJRF2a1n7oE7wHRvwEuvAqsgBNU3/9mcji?=
 =?us-ascii?Q?F2OLZ5Vb9uS/ObFNGV/JMoOmcbVrFC7BRkmA7HITFgUK4guqhP4mJxJYy8zV?=
 =?us-ascii?Q?Y09f95+owIW6Ani5AaTYJyIh+3dITARyTJdXsx5ePD4iqnZgXQlRCuANQBZ0?=
 =?us-ascii?Q?Q2RGhAAwjd5b5rvX9e/5mSgcUQaPE8v88inyRbJJFu6UH3O6m5Srmjkx6BZO?=
 =?us-ascii?Q?cQKC8aeg7XB9tglJt2xPtqTUqTm9Bg95hsEmaJoZpdGCEBkStIZ8Noy62NjA?=
 =?us-ascii?Q?+BaMMY090YyJfdv4oIWBjvdFpZwPKmbrazmYOya8m2lhFjXm/N1M1EYNAFfH?=
 =?us-ascii?Q?QkGjmXcafsOFVoGRWsYFl4pXSWv2IPldSQSugXWIDslq6WmqCmp0+N3L9aFM?=
 =?us-ascii?Q?WMAXa2PYcCvqMX5AANvwZuCZFjg7GULjAPfJWWcPV25Nct4qPgMAxAvinqTE?=
 =?us-ascii?Q?lwaNFnIYxSRppzMhxSAM5cZKZvb7lJssBXUNK757TJlgt2K2NN8BVmwmgI7L?=
 =?us-ascii?Q?9+NhLYiCYrYDv8VL734eKVFEDVFQjV8Xu1LyrKC3i0wYDsvBGSJAUM/Im0SK?=
 =?us-ascii?Q?KfdxswPH65O4wHmsTFLzCH3SEevgGQDYAqhpk7RsK58NbBP5JwKYNfSZYGda?=
 =?us-ascii?Q?jbQSOJ7Q/9VO4rNouIhyComR/z3/D6ong1KnlCT2dmdfyXuAkjFEPM5dzhHA?=
 =?us-ascii?Q?SME+WkOINkN4W8TX8DXFgYoDXLoB6ZeIBVkw8EgaFTZrQck9SLInAHo5DQcV?=
 =?us-ascii?Q?aRgVDWImt2BDH6+GqVbITvDpGi7C8NmlQT1TN+CL3nnmNJReLbuDRPHPyQOZ?=
 =?us-ascii?Q?/F0ryuEJl37auBQuJwU0jJ0+jkeSFDk31318t6tVp7Vsk/A/ZpPBIi3npQFc?=
 =?us-ascii?Q?qA3ymr3VaebEostheibBr8E6tTphsweynSPjPCP19qL1Rk7wHm/lXL0GqeBE?=
 =?us-ascii?Q?2kqBj/kbNyARu9uIqJgKtjiXvPl24jWp2J09KEV079Pnp4lHrXNZ4/MIQJ5z?=
 =?us-ascii?Q?eSTTJt3cmZa/KImDOdx12aNBXsBhWqPtD1JhOkDFjJv2jfg+bLeOCNJBD2IV?=
 =?us-ascii?Q?quAIMbdebK5qLXXCFNUt8PnGQOAe8Hyc86t/QPy7BvDB9JjWuoKVeAhbBKq7?=
 =?us-ascii?Q?eH8sPaq6wHkKlb4XaU/P1Zd6U/PjRFtoHbYJD7md431TqF6sCgMFNFg1woMy?=
 =?us-ascii?Q?XUHmyuJ+uC8B1zJ/GXN9LUvieYSFk4dXbxGv7CxKwQX3hLPv3jDzcmKZNbWh?=
 =?us-ascii?Q?44rX5M1AS1VgEcIciZjlKNpednf+qcvxppWC9KxQXFSRbN4HV00Wc2g2DwrI?=
 =?us-ascii?Q?hFQjunTW+hwCFYag9oyl6JwTnufrqbW7Zkv6F7XbutHhfrhR2+oRFiq8jcP5?=
 =?us-ascii?Q?TbWeos8SUV0=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f32b46f7-2006-4e83-5792-08db7808ddbf
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 18:52:48.1396
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: buQ82kh7nptB+cR8Bad5CfgKFwG0tdKlaqITvyPutrbzXgjRbOEHk07AFdp4xWblGz68AithYbjIS1j8hghzI3zPEq/4DAR1a1LGu3ORw9U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7820
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_13,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 phishscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306280168
X-Proofpoint-GUID: GqseLKS8eIVBm_HvSl0UYkg-imuAHoJZ
X-Proofpoint-ORIG-GUID: GqseLKS8eIVBm_HvSl0UYkg-imuAHoJZ
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hotplug support for kexec_load() requires changes to the
userspace kexec-tools and a little extra help from the kernel.

Given a kdump capture kernel loaded via kexec_load(), and a
subsequent hotplug event, the crash hotplug handler finds the
elfcorehdr and rewrites it to reflect the hotplug change.
That is the desired outcome, however, at kernel panic time,
the purgatory integrity check fails (because the elfcorehdr
changed), and the capture kernel does not boot and no vmcore
is generated.

Therefore, the userspace kexec-tools/kexec must indicate to the
kernel that the elfcorehdr can be modified (because the kexec
excluded the elfcorehdr from the digest, and sized the elfcorehdr
memory buffer appropriately).

To facilitate hotplug support with kexec_load():
 - a new kexec flag KEXEC_UPATE_ELFCOREHDR indicates that it is
   safe for the kernel to modify the kexec_load()'d elfcorehdr
 - the /sys/kernel/crash_elfcorehdr_size node communicates the
   preferred size of the elfcorehdr memory buffer
 - The sysfs crash_hotplug nodes (ie.
   /sys/devices/system/[cpu|memory]/crash_hotplug) dynamically
   take into account kexec_file_load() vs kexec_load() and
   KEXEC_UPDATE_ELFCOREHDR.
   This is critical so that the udev rule processing of crash_hotplug
   is all that is needed to determine if the userspace unload-then-load
   of the kdump image is to be skipped, or not. The proposed udev
   rule change looks like:
   # The kernel updates the crash elfcorehdr for CPU and memory changes
   SUBSYSTEM=="cpu", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"
   SUBSYSTEM=="memory", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"

The table below indicates the behavior of kexec_load()'d kdump image
updates (with the new udev crash_hotplug rule in place):

 Kernel |Kexec
 -------+-----+----
 Old    |Old  |New
        |  a  | a
 -------+-----+----
 New    |  a  | b
 -------+-----+----

where kexec 'old' and 'new' delineate kexec-tools has the needed
modifications for the crash hotplug feature, and kernel 'old' and
'new' delineate the kernel supports this crash hotplug feature.

Behavior 'a' indicates the unload-then-reload of the entire kdump
image. For the kexec 'old' column, the unload-then-reload occurs
due to the missing flag KEXEC_UPDATE_ELFCOREHDR. An 'old' kernel
(with 'new' kexec) does not present the crash_hotplug sysfs node,
which leads to the unload-then-reload of the kdump image.

Behavior 'b' indicates the desired optimized behavior of the kernel
directly modifying the elfcorehdr and avoiding the unload-then-reload
of the kdump image.

If the udev rule is not updated with crash_hotplug node check, then
no matter any combination of kernel or kexec is new or old, the
kdump image continues to be unload-then-reload on hotplug changes.

To fully support crash hotplug feature, there needs to be a rollout
of kernel, kexec-tools and udev rule changes. However, the order of
the rollout of these pieces does not matter; kexec_load()'d kdump
images still function for hotplug as-is.

Suggested-by: Hari Bathini <hbathini@linux.ibm.com>
Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
Acked-by: Hari Bathini <hbathini@linux.ibm.com>
Acked-by: Baoquan He <bhe@redhat.com>
---
 arch/x86/include/asm/kexec.h | 11 +++++++----
 arch/x86/kernel/crash.c      | 27 +++++++++++++++++++++++++++
 include/linux/kexec.h        | 14 ++++++++++++--
 include/uapi/linux/kexec.h   |  1 +
 kernel/Kconfig.kexec         |  4 ++++
 kernel/crash_core.c          | 31 +++++++++++++++++++++++++++++++
 kernel/kexec.c               |  5 +++++
 kernel/ksysfs.c              | 15 +++++++++++++++
 8 files changed, 102 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
index 9143100ea3ea..3be6a98751f0 100644
--- a/arch/x86/include/asm/kexec.h
+++ b/arch/x86/include/asm/kexec.h
@@ -214,14 +214,17 @@ void arch_crash_handle_hotplug_event(struct kimage *image);
 #define arch_crash_handle_hotplug_event arch_crash_handle_hotplug_event
 
 #ifdef CONFIG_HOTPLUG_CPU
-static inline int crash_hotplug_cpu_support(void) { return 1; }
-#define crash_hotplug_cpu_support crash_hotplug_cpu_support
+int arch_crash_hotplug_cpu_support(void);
+#define crash_hotplug_cpu_support arch_crash_hotplug_cpu_support
 #endif
 
 #ifdef CONFIG_MEMORY_HOTPLUG
-static inline int crash_hotplug_memory_support(void) { return 1; }
-#define crash_hotplug_memory_support crash_hotplug_memory_support
+int arch_crash_hotplug_memory_support(void);
+#define crash_hotplug_memory_support arch_crash_hotplug_memory_support
 #endif
+
+unsigned int arch_crash_get_elfcorehdr_size(void);
+#define crash_get_elfcorehdr_size arch_crash_get_elfcorehdr_size
 #endif
 
 #endif /* __ASSEMBLY__ */
diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index c70a111c44fa..caf22bcb61af 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -427,6 +427,33 @@ int crash_load_segments(struct kimage *image)
 #undef pr_fmt
 #define pr_fmt(fmt) "crash hp: " fmt
 
+/* These functions provide the value for the sysfs crash_hotplug nodes */
+#ifdef CONFIG_HOTPLUG_CPU
+int arch_crash_hotplug_cpu_support(void)
+{
+	return crash_check_update_elfcorehdr();
+}
+#endif
+
+#ifdef CONFIG_MEMORY_HOTPLUG
+int arch_crash_hotplug_memory_support(void)
+{
+	return crash_check_update_elfcorehdr();
+}
+#endif
+
+unsigned int arch_crash_get_elfcorehdr_size(void)
+{
+	unsigned int sz;
+
+	/* kernel_map, VMCOREINFO and maximum CPUs */
+	sz = 2 + CONFIG_NR_CPUS_DEFAULT;
+	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
+		sz += CONFIG_CRASH_MAX_MEMORY_RANGES;
+	sz *= sizeof(Elf64_Phdr);
+	return sz;
+}
+
 /**
  * arch_crash_handle_hotplug_event() - Handle hotplug elfcorehdr changes
  * @image: a pointer to kexec_crash_image
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 6a8a724ac638..bb0e614f2a05 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -335,6 +335,10 @@ struct kimage {
 	unsigned int preserve_context : 1;
 	/* If set, we are using file mode kexec syscall */
 	unsigned int file_mode:1;
+#ifdef CONFIG_CRASH_HOTPLUG
+	/* If set, allow changes to elfcorehdr of kexec_load'd image */
+	unsigned int update_elfcorehdr:1;
+#endif
 
 #ifdef ARCH_HAS_KIMAGE_ARCH
 	struct kimage_arch arch;
@@ -411,9 +415,9 @@ bool kexec_load_permitted(int kexec_image_type);
 
 /* List of defined/legal kexec flags */
 #ifndef CONFIG_KEXEC_JUMP
-#define KEXEC_FLAGS    KEXEC_ON_CRASH
+#define KEXEC_FLAGS    (KEXEC_ON_CRASH | KEXEC_UPDATE_ELFCOREHDR)
 #else
-#define KEXEC_FLAGS    (KEXEC_ON_CRASH | KEXEC_PRESERVE_CONTEXT)
+#define KEXEC_FLAGS    (KEXEC_ON_CRASH | KEXEC_PRESERVE_CONTEXT | KEXEC_UPDATE_ELFCOREHDR)
 #endif
 
 /* List of defined/legal kexec file flags */
@@ -501,6 +505,8 @@ static inline void arch_kexec_pre_free_pages(void *vaddr, unsigned int pages) {
 static inline void arch_crash_handle_hotplug_event(struct kimage *image) { }
 #endif
 
+int crash_check_update_elfcorehdr(void);
+
 #ifndef crash_hotplug_cpu_support
 static inline int crash_hotplug_cpu_support(void) { return 0; }
 #endif
@@ -509,6 +515,10 @@ static inline int crash_hotplug_cpu_support(void) { return 0; }
 static inline int crash_hotplug_memory_support(void) { return 0; }
 #endif
 
+#ifndef crash_get_elfcorehdr_size
+static inline unsigned int crash_get_elfcorehdr_size(void) { return 0; }
+#endif
+
 #else /* !CONFIG_KEXEC_CORE */
 struct pt_regs;
 struct task_struct;
diff --git a/include/uapi/linux/kexec.h b/include/uapi/linux/kexec.h
index 981016e05cfa..01766dd839b0 100644
--- a/include/uapi/linux/kexec.h
+++ b/include/uapi/linux/kexec.h
@@ -12,6 +12,7 @@
 /* kexec flags for different usage scenarios */
 #define KEXEC_ON_CRASH		0x00000001
 #define KEXEC_PRESERVE_CONTEXT	0x00000002
+#define KEXEC_UPDATE_ELFCOREHDR	0x00000004
 #define KEXEC_ARCH_MASK		0xffff0000
 
 /*
diff --git a/kernel/Kconfig.kexec b/kernel/Kconfig.kexec
index 7eb42a795176..8a524b8ff6a2 100644
--- a/kernel/Kconfig.kexec
+++ b/kernel/Kconfig.kexec
@@ -138,4 +138,8 @@ config CRASH_MAX_MEMORY_RANGES
 	  memory buffer/segment size under 1MiB. This represents a sane choice
 	  to accommodate both baremetal and virtual machine configurations.
 
+	  For the kexec_load() syscall path, CRASH_MAX_MEMORY_RANGES is part of
+	  the computation behind the value provided through the
+	  /sys/kernel/crash_elfcorehdr_size attribute.
+
 endmenu
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 53d211c690a1..fa918176d46d 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -704,6 +704,33 @@ subsys_initcall(crash_save_vmcoreinfo_init);
 #ifdef CONFIG_CRASH_HOTPLUG
 #undef pr_fmt
 #define pr_fmt(fmt) "crash hp: " fmt
+
+/*
+ * This routine utilized when the crash_hotplug sysfs node is read.
+ * It reflects the kernel's ability/permission to update the crash
+ * elfcorehdr directly.
+ */
+int crash_check_update_elfcorehdr(void)
+{
+	int rc = 0;
+
+	/* Obtain lock while reading crash information */
+	if (!kexec_trylock()) {
+		pr_info("kexec_trylock() failed, elfcorehdr may be inaccurate\n");
+		return 0;
+	}
+	if (kexec_crash_image) {
+		if (kexec_crash_image->file_mode)
+			rc = 1;
+		else
+			rc = kexec_crash_image->update_elfcorehdr;
+	}
+	/* Release lock now that update complete */
+	kexec_unlock();
+
+	return rc;
+}
+
 /*
  * To accurately reflect hot un/plug changes of cpu and memory resources
  * (including onling and offlining of those resources), the elfcorehdr
@@ -734,6 +761,10 @@ static void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu)
 
 	image = kexec_crash_image;
 
+	/* Check that updating elfcorehdr is permitted */
+	if (!(image->file_mode || image->update_elfcorehdr))
+		goto out;
+
 	if (hp_action == KEXEC_CRASH_HP_ADD_CPU ||
 		hp_action == KEXEC_CRASH_HP_REMOVE_CPU)
 		pr_debug("hp_action %u, cpu %u\n", hp_action, cpu);
diff --git a/kernel/kexec.c b/kernel/kexec.c
index 92d301f98776..107f355eac10 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -129,6 +129,11 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
 	if (flags & KEXEC_PRESERVE_CONTEXT)
 		image->preserve_context = 1;
 
+#ifdef CONFIG_CRASH_HOTPLUG
+	if (flags & KEXEC_UPDATE_ELFCOREHDR)
+		image->update_elfcorehdr = 1;
+#endif
+
 	ret = machine_kexec_prepare(image);
 	if (ret)
 		goto out;
diff --git a/kernel/ksysfs.c b/kernel/ksysfs.c
index aad7a3bfd846..1d4bc493b2f4 100644
--- a/kernel/ksysfs.c
+++ b/kernel/ksysfs.c
@@ -165,6 +165,18 @@ static ssize_t vmcoreinfo_show(struct kobject *kobj,
 }
 KERNEL_ATTR_RO(vmcoreinfo);
 
+#ifdef CONFIG_CRASH_HOTPLUG
+static ssize_t crash_elfcorehdr_size_show(struct kobject *kobj,
+			       struct kobj_attribute *attr, char *buf)
+{
+	unsigned int sz = crash_get_elfcorehdr_size();
+
+	return sysfs_emit(buf, "%u\n", sz);
+}
+KERNEL_ATTR_RO(crash_elfcorehdr_size);
+
+#endif
+
 #endif /* CONFIG_CRASH_CORE */
 
 /* whether file capabilities are enabled */
@@ -255,6 +267,9 @@ static struct attribute * kernel_attrs[] = {
 #endif
 #ifdef CONFIG_CRASH_CORE
 	&vmcoreinfo_attr.attr,
+#ifdef CONFIG_CRASH_HOTPLUG
+	&crash_elfcorehdr_size_attr.attr,
+#endif
 #endif
 #ifndef CONFIG_TINY_RCU
 	&rcu_expedited_attr.attr,
-- 
2.31.1

