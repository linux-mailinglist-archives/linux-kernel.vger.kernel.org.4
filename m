Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 575E26B0056
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 08:57:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjCHH5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 02:57:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbjCHH51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 02:57:27 -0500
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A78299BA69;
        Tue,  7 Mar 2023 23:57:25 -0800 (PST)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32870bOR000488;
        Tue, 7 Mar 2023 23:56:56 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=to : cc : from :
 subject : message-id : date : content-type : content-transfer-encoding :
 mime-version; s=PPS06212021;
 bh=2C7rLQGIKMxRpxTgBcz+nIxW2bd2ZyzFgcwNo4O78Ug=;
 b=PNnC6RMGxY2qKtv4C6Vwh9s1+tF7AGMTyWlhoErslFYJ0gO7s5WIj+j7w+wM6Fjqgqou
 /SygniAXF29y0lC8nyS3UfLslDo5n3qwhtAktjudaK9Is36qbfD+4iCsY5bv6ehMYntB
 quTujB8R827l9EhfGKwoC8croVIIIco9O2Hs0KX/C1QP7I3NdGAfgT3jWJ0W+ghKa/Sf
 uKzY90IrXd3g8ALjr18yc/io+KfqMraeZhyaBe6uNfgrvYQzenwoc88m+0Bv/B1exhbs
 7Dt82FYc+XFNk29wT6yh0Ba2ybzZ8nn4I3QB/SBoFOWYAuPeBFWzc6XQZrVAObXUjjnJ wg== 
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2045.outbound.protection.outlook.com [104.47.51.45])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3p6ffd09c2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Mar 2023 23:56:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PzR5J3UNAIMTJcSSSTgN/nO62sxvOAYSSIq+mo1sMz/J9p++h4CdPPn0ti1wqM5proxlnzrXOteOiVzrO7e9h06UA2n212azNYgNyeEiLVh6WD2frlu55qgyeIgt1B6C4c97cxd51wk3IA2OOBovcMsZZeBQ8nioUvPuZ0KSKoomTbqy/WvsOUKbqZVTvNHfpocGhCu1ZClDnc+rh2wgxu9mk9v/+dlwALGq78fPF24ZzaEKAJA6QoEq7KBxCEwY6zKqvrMIxxkUKKvp4Nth6LPsW7u5NaBSZ7q8t9n9s/dbpv0k1hLxxf7Kax79t7fFMZfrFfst+lL1rVvjZHANww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2C7rLQGIKMxRpxTgBcz+nIxW2bd2ZyzFgcwNo4O78Ug=;
 b=bGEQBGUwz2A+D5kPK7tr15QSBsyMzM985lg1eeBAsl2yU7TgBMtJi1nyLTaztAJfNvlE/axJaWUVCQ+AdXvbwQxqkYR/PdSZ2CC1YvNydSwackmycjf8o13xS7BbKzHcmB1Q25u78x8KVVnhCj72AClhOF3l7k9xiSmurSsSgvxLYapUFyjHtAGZMnAZ/D54syX+ywpI0xFpaxsMY/OP+Vpt5dAELF3PB8K+l6RkrI9O8fuXq03Sxl1Huk4tDLXcM9ixlf8eoQAZS7UiO4VZpZ6mXS2QZglwYRSa8ObeHS6IGp7dXLBEPUs/jawL0itWkDLqXBnRWT1vBxdyfQV37A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MW5PR11MB5764.namprd11.prod.outlook.com (2603:10b6:303:197::8)
 by MW4PR11MB6984.namprd11.prod.outlook.com (2603:10b6:303:22e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Wed, 8 Mar
 2023 07:56:51 +0000
Received: from MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::7709:2bed:5653:b4d1]) by MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::7709:2bed:5653:b4d1%4]) with mapi id 15.20.6156.028; Wed, 8 Mar 2023
 07:56:51 +0000
To:     will@kernel.org, mark.rutland@arm.com, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, linux@armlinux.org.uk
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
From:   wangxiaolei <xiaolei.wang@windriver.com>
Subject: perf record -e branch-misses ls > /dev/null
Message-ID: <08994540-d132-6e49-f6a0-82d8dfd1f3f0@windriver.com>
Date:   Wed, 8 Mar 2023 15:56:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: SI2PR04CA0006.apcprd04.prod.outlook.com
 (2603:1096:4:197::13) To MW5PR11MB5764.namprd11.prod.outlook.com
 (2603:10b6:303:197::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5764:EE_|MW4PR11MB6984:EE_
X-MS-Office365-Filtering-Correlation-Id: b042ed92-91fa-4613-1c8e-08db1faaad42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pO57rFPQmrL96kJiI7H+GgSb2cjHet+5Nyhzhn19mdv+knaTzzwc/tqipwnoDvFKMztrshhjAE3cuHUcu5VaOtspyaae+tyisQ3Z/JeiSnNxzVX7NXCHJQUep8RNvIpojJp2IytYQiabAv7Li90bSYexRV92iiHs4UIlXL9TTzT/u7+kWnfNMWwfmXngLIaT/VNyc0qHPUqnPtYwYVxOx34KuvzgE0RhW9Ax5XdVkAFMe+24Tta+qPvYhphxm0nOFGlEgrnEoBYt0gYLDpOUBLgeIDhTaxSwlVZGhH1UVsp6QZGdKbAOOy1+VY8K07/1ADgftqKcZeZ+rvQIOPQ6iMYQkGkhM6TeCtiwvYnJtTG8gVzY/Ai/kbu9iAx3+X+OedXxPHiNSVBQhhjA01I6atO6TUhwz/0hJADFaI7/ijsCM/Me2TzJgGqW1tW/Ec/Tyc5CyLTz+9uuOMY2ddZhmv1QBNk8LAJVvBFDmHT764f7CdLMA98izNLiUaOyMEJ3xaa3z+5H6dkifKmLPz8ntYGqyW+q3zkGjfP0vLlElJo0KcEJbfexO+QX4reeEl9OADJjvObBaLMfE6PdqeYb7FJzqwCiVX7fBzoVPyS8WphHPzOZPrBVauIB4CXnkaA6HywNO3PMzdcWtkidARJoxXFfhwgc3EVZqxbHMLNehMk6wA8vwkK124PgFR/ZVLK2kMi6+rTpxtLmA5nSU/0ow0twlQTKnqUcbvgxFIpz/BDcyOBs7synL58G/XHY1iYild9YDgN+ZK3mavhJ9CP5fyonnLEclJdHkcakwbUSYghU8xGFnONwDHE3umunDBmi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5764.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(376002)(396003)(366004)(39850400004)(451199018)(36756003)(316002)(31696002)(86362001)(31686004)(2906002)(6486002)(186003)(41300700001)(26005)(5660300002)(66556008)(8676002)(66946007)(66476007)(4326008)(478600001)(6666004)(6506007)(2616005)(7416002)(6512007)(8936002)(921005)(38100700002)(43062005)(43740500002)(45980500001)(159843002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?THg1UjdIL2lZelJBUXcvcjdWNkdVVHN6Qk1lcWx5UmNzOEp0WjBUVC9jYWhG?=
 =?utf-8?B?bjFaU2RGUjl4dXB6N2lNSVVvVEFQUEp3dzc1K3ZNcnVIYWdVSHhjQ0l2WSt4?=
 =?utf-8?B?Ymw4S0JnSkJSeEVTZlRrejNxVHVIQW1lRmY3Z0VkNlhXUFJDVTJQNzQ0ZkFX?=
 =?utf-8?B?NzhLajd0MXREU1dCWDZIRWloV0lMS1FOYXlPbWN6b2grNWRjRmFzNk52dkow?=
 =?utf-8?B?ajZpbFcxZmtsU25oTWI2Um9UQkZWL3EwM2pYaW9KanFUUEl5OE9HbEJDdnQv?=
 =?utf-8?B?T1F1U2Y2OGh0b1BENjE3KzltRFI2RkxYb0ZTR0N2cnZIQ2lKUnp1VnpFYzBw?=
 =?utf-8?B?eXAzc05uUDV4cENuQUxPeUVITEhnVUx2UXpYV3ZXek1UWmd4eFcvTWFVTk9K?=
 =?utf-8?B?LzFUMHFXbmtPWGtTU0JVYXBxQm1QczVzQ05pTFFSMzVSWDVIS2VJZDNueFhY?=
 =?utf-8?B?K1BCMGR4eWFOYnNyZWtxRFVCN2p2dk1XTVd2aG15ZEs2V1ZZYzVpcVVwS0JX?=
 =?utf-8?B?V3Y4QWxmZUVkbHZVampsbVA3R1ZiUStIalBHNzh1MzUveVh6NjQzYmhPVWZN?=
 =?utf-8?B?T3AyRnF2MmF6VU5UQWlGbjVpbGp4YmZDNXRkajVkei9FY1Y3cnE1UEtsM2xN?=
 =?utf-8?B?Q2lXQkNZMlorZGU5WGNwNllyT2VOeGlZT3pyWDFlK3RwdnZRN1hNUzJmcVJZ?=
 =?utf-8?B?MUMvODhiZTFxcXUyZHVRSE95eWp4NGJ6Vmo5b2RrejB5WUdQN3FUbzI1MW9O?=
 =?utf-8?B?Q05wdGZzUlluUkZwV2xzM0prc0hLeWxTTVZqUENUVWx0TnNXeFI1UnhwWS9m?=
 =?utf-8?B?TnpwS1QzRVdodmI1UFJJWHBzVjhNbmZ2WHE4cVJPZ2VzOFBLdnB0UzJxSkNa?=
 =?utf-8?B?OXk4QmNHdCtiK1JpSTVhck1DLzFyOW02OWdIN00yYjh3WG5wazlXWXpaWFFp?=
 =?utf-8?B?ZktEVy8ydmVtVE83WGV5SVhxcVlJVmN5bEdVME9BQ040UVVuQ0RrTU5VdE80?=
 =?utf-8?B?anQ3b1p5OGg1Q0lnN0NIZmdGVldkNmVVWFZMemdzRWduZlgvbCtaSEdwZ043?=
 =?utf-8?B?WnU1cnR2ZFFyOEs1czNDT0FDNUNqUFhyV3g1SDlmb1NiNDNlY2VZejRKbURQ?=
 =?utf-8?B?QVhqTWphQ092VUZyQWNIQ0lTMjZUQjJxY0xwNW0vYTJ1aDlnWGtYU2Z1M0x5?=
 =?utf-8?B?V2V5K1JpUmk4alhZTFhjbDFQZERZbVhtaENnM3dpUm9Pb0tWNkMrMGdjb3hR?=
 =?utf-8?B?aklFMDFlUlZGMHIzNHNkZnhiZnJva0pIQUg3eTBPVjZUME8wTnJWTUhDSFZD?=
 =?utf-8?B?b0c4M2J3UE5DWTBTNFp4M3FDWE1tbDY3UFlyY1ROQWRBbnUvbGVXc29JcDNC?=
 =?utf-8?B?UWFPMzQ5VXF4YU8xL0ZKQUoyM1dmR0JpSFFLelA4dy9aaSt2ODZwSXl6Vy93?=
 =?utf-8?B?c09aUGJmRjYvekRheDN2VVAvU2x0WUdvY2t1c29nZXBWdmt0WmRyRnpNZDZp?=
 =?utf-8?B?TjYxQ21LaWsyQVcwNFNTdnNDOWQxTFdoUWZNeHcrdDEvZXArL1NsbGJJZjVX?=
 =?utf-8?B?WTJlNWdMMStmQmhVWFQybTRmMnJjcURUUHBXbHFMd1N5VFYvcUZvNjE3aS9z?=
 =?utf-8?B?Y3BaVW9NWmJtbGhWMmhLUW5IbVVuL3JjRTF3MUJLOFlNY0tNYmxKSjRYSHJh?=
 =?utf-8?B?ZWZzeTBmejFJamdySXQ3QjlDcmNIZTBDU0JYQmh5bUpmeEtXd1V1NU1hVGRS?=
 =?utf-8?B?RXB2NkJjZE5qVDFsamJqU1BYRElERGovTVFaR0daaFBENVhxWm8wSld3Rktv?=
 =?utf-8?B?WTZhRlhaaEExejVKYTFVUGlsc2FUVW1NOXZMSDhOUWpzSWxDZWgvMEFteW9Y?=
 =?utf-8?B?VFgxeWtTOGdNT2o4d0haSllSSmw5MHArcWdJRzdybm5aNXpreGJOSHhIeFdX?=
 =?utf-8?B?ZzN1ZXppcGVXamQ5Z3NZajhRZnBQVHJOcys3MzVkV3R0bk9ob3hscVFGaFZm?=
 =?utf-8?B?TnlPdmtrY3Y1VllOQk54enlaY0YzZTZ6Y09mcnNPcE5qN0ZIc1R0alhQOUtk?=
 =?utf-8?B?ZTdYTkZYNmlsWmFWOFl4ZGdLY08yOHBEUDdDZmU4bWhEamVqWWdrdUxEcmN2?=
 =?utf-8?B?bTdUalNrYUYvaDk4b0VoRlc5NkRQWFowUlZRME9vUU1LNFZTMGpjQ1FOMWh4?=
 =?utf-8?B?Qmc9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b042ed92-91fa-4613-1c8e-08db1faaad42
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5764.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 07:56:51.5530
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zywcSBVaQ/o0tQxUbuxv2kW+JG9Vx6yRWZlw5MVPPVZQ53gSD8LOy6oayMd2aV0DzQhkVqQBtApW0/eleeGN1YMPkmdHP6VL2APg4j1mPDM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6984
X-Proofpoint-GUID: SFZLtreg4Au7eSki4rHLEFZYxwvHgGJn
X-Proofpoint-ORIG-GUID: SFZLtreg4Au7eSki4rHLEFZYxwvHgGJn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-08_03,2023-03-07_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 malwarescore=0
 clxscore=1011 phishscore=0 priorityscore=1501 spamscore=0 mlxlogscore=643
 mlxscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303080068
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi

When I use the perf tool on nxp-imx6sx, the CPU is armv7 cortex-A9 to 
test, I execute the perf record -e branch-misses ls > /dev/null command, 
but the perf report result is indeed:
perf report
Error:
The perf.data data has no samples!
# To display the perf.data header info, please use 
--header/--header-only options.

root@nxp-imx6:~# perf list hardware

List of pre-defined events (to be used in -e):

    branch-instructions OR branches [Hardware event]
    branch-misses [Hardware event]
    bus-cycles [Hardware event]
    cache-misses [Hardware event]
    cache-references [Hardware event]
    cpu-cycles OR cycles [Hardware event]
    instructions [Hardware event]

And not only this one hardware event, only cycles are working normally 
in the following supported hardware time, other hardware events are not 
interrupted and reported, and the value in the read PMXEVCNTR register 
is always -1, and the PMCR register E, bit[0 ] it will be written to 0 
before reading the PMXEVCNTR register. I don’t know if the value in the 
PMXEVCNTR register is always -1 for this reason. Does anyone have any 
good suggestions for debugging this problem?


thanks

xiaolei

