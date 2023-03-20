Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 701176C1DE1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 18:27:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232661AbjCTR1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 13:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232486AbjCTR05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 13:26:57 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEDA12057D;
        Mon, 20 Mar 2023 10:22:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FhUYbCv/wHRsLlAEmVsl18MulNdbkmzkhiox2uC8Ad78opiTZidxERSGk8emxx1nyitVyWSgCBwLO631qUvDnIjyXS4ASD8L7qO3/eEk2jeTO32oPhejxGMeV73vrxZhSUAIxrgcAsZPxGnoP7ephIRRknnCqCCcvi1tcibAfgVagWZg9yIN5XSaqwPmO34aHmfNjo9c9pg9lDBvGavAnDgGFA38muP06XGMOayiFDzhLvNoW62J8ua4QukRLpwHTx1ASYyjKwFEOb8JQc1UNrowZCp/TypGk+EXbAElsmJ9qcIuNcmS1D+PkKAVWA2qw/O3RmDAj9UPJFLrsEvTQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=doorOYSCLYdEa9kYnXmUy7K/J3QWkgH4iW3DML5xkPc=;
 b=fG//3hbqPT1j5eWCGM8SoiwPgMpVqyXdFnB5sJ4arG8vn/uUdegkbxZrNDoqOzKxpIFPAQJ0kxjnm5357rvPTaXJlScbHsk+cjNbJCDIjjvf/m+48c52JHTSH7un8287qm5at1rHf2XJETFxZeuvfTAjNXujkk5CLkOyUdjVxaozSfXfNpOpe3CXgACTyAnzBoBHURj3HIj0BT+T8FNahKReY+GtR4pVHv4qNVQIgp85e5e8B+I7HQ7OaUj+jNn2iDzdfVZ/RXMJtbq0SqbQIUP69mlyksIGZ1XojUsXTHtQF1cQtpkPdnw//ayMkhcPC5lDZk66M+WzTm6Gc/G0DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=doorOYSCLYdEa9kYnXmUy7K/J3QWkgH4iW3DML5xkPc=;
 b=mT5lbj5jyPEgaOnDYL1DIHWAIE2tzY/kxF+OPv8zMHIhtkkFMqXO4TSTQttelvuA4bh9ZO3Weps2dgk/jskv1nXotvefQH8yfGqyTQkbFO5s06zKIctTJVh31AS7xT/5P/fXAL3IQGdoE6QAndesbJbe8cTAROM3dfEmGPtzNjs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BL3PR01MB7027.prod.exchangelabs.com (2603:10b6:208:35a::9) by
 DS7PR01MB7854.prod.exchangelabs.com (2603:10b6:8:81::18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.10; Mon, 20 Mar 2023 17:21:55 +0000
Received: from BL3PR01MB7027.prod.exchangelabs.com
 ([fe80::ef17:958:5c42:3d26]) by BL3PR01MB7027.prod.exchangelabs.com
 ([fe80::ef17:958:5c42:3d26%3]) with mapi id 15.20.6222.010; Mon, 20 Mar 2023
 17:21:55 +0000
Message-ID: <0453c753-681e-4d42-65e5-a5967697f6ca@os.amperecomputing.com>
Date:   Mon, 20 Mar 2023 10:21:51 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Content-Language: en-US
To:     rafael@kernel.org, viresh.kumar@linaro.org,
        george.cherian@cavium.com, pprakash@codeaurora.org
Cc:     scott@os.amperecomputing.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Yang Shi <yang@os.amperecomputing.com>
Subject: [QUESTION] The delay between sampling for CPPC
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0409.namprd03.prod.outlook.com
 (2603:10b6:610:11b::17) To BL3PR01MB7027.prod.exchangelabs.com
 (2603:10b6:208:35a::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR01MB7027:EE_|DS7PR01MB7854:EE_
X-MS-Office365-Filtering-Correlation-Id: 567bca8b-cd63-46bb-77c8-08db29679a22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WanSN3D5Pk9YG7Upns+fXIqqSehuecqaf8BLjoKTrPa/5lxgos8kdqGAr10eXB9c2r5Tb5gboo4B5nwP7346YTOodO2hX2/O1vNpctc5PzjDzEdQKcWpUic70y+u8Rqpi/KphTaU+RFTPJGMFANn5bPOVwze8S01AJiwiOJBOptSxiOizpmP4n8RW9RRpGJmQLklwQCK0ITps6Unod5SeYokVjK6WudMB0p66IPjIG6pPwvAWRBa0P8RmHX/fI0hu4MsZKMPDvwgo822vLjdwR59PzpOuAz9g0chsIv3NrAFBzGRd8IJQ3RgqItVeu2kARmZquAQeFfkXfZrgXQVQiwtgjeQ3Bh8gdYBnAkVLSu5XV2G/85rFRuoiw6XV4KSwWK9+tNnO8tidJr/tV8sGpOPQJXtNAeIaLLXiCcCgnZlzeE0SEWKgWDvz0Z3Iho6xH4wFdwkcwLo6basWVu7XumniSOIvGJ4yiIv0+xDy2FSO28RHfQ9CR4Ar6GOmw9Vif9glayY2FRybP0orRNfnixAkbfBMXL5wEOlluIdQA1yWJCC1s+YAFb4UZKVWTldlCJHAl+0GEkQSsHSDT99q3OyfvtKoh81hzxmmYa/zD460Uw2To4tbnlBP6fcmMtUqq8bRbe6rDG9CiLMgRlShyUY0t0skZMkhS/1WIsuwLukC6beeNcV40TfB5ePYCIPLXWo/Jsln0R8AMsHh2AdBo9tx19MoM6vwiy3pPTvpGU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR01MB7027.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(39850400004)(396003)(346002)(136003)(366004)(451199018)(26005)(6666004)(6506007)(186003)(38100700002)(4744005)(66556008)(4326008)(66946007)(66476007)(83380400001)(41300700001)(5660300002)(38350700002)(478600001)(8936002)(2906002)(2616005)(316002)(52116002)(8676002)(31696002)(6512007)(86362001)(6486002)(31686004)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YnlDY3BoYjdlL0k0QkFOdjVScVN1TndQcUxDdGM4eHA5U3NKbVFZRG1yd2N5?=
 =?utf-8?B?b05BNmg2QU5MamhNUGk3UzQrY2hPMEpOYUZzblluRnZjbEtNMk1wS082TFg0?=
 =?utf-8?B?RVFzTm9neFpxMEVtc3JHeEgzdlFMMEZaakxPdGlHRDdVQVY2YTRjMWpJSEhz?=
 =?utf-8?B?M010aDI4Sm1BTGNGYnpEaU83cHZmR3hZK1czNXVWOXNnOXZiRGF6em56dkZ4?=
 =?utf-8?B?UC82OUF6NjFnWENiaGRCaFBLeUlTcjJ1Ri9IbDg0N3Axc0k5UEdQYWJ6N2N2?=
 =?utf-8?B?cXRuUHJHclpvNnNxaXI0b0lTOU1xTmtENDc5Q1UzcGlLMjhweUdnakRqbDBa?=
 =?utf-8?B?NTZyZVNVVFlLaitNWlFUSFh3VWQ1S3F0RnFtT2lTU3d4NitOY25vSmtRbDlK?=
 =?utf-8?B?UHRYNjlURjBINXk2NDB5Wk9Fd2pySThxQmJsSU1EdXUwN2VTajlxejVRSmtV?=
 =?utf-8?B?Y2tDSkhzT3oxU3RJb2JTUjI5bHFjRGM2bEQzU2E0VkcvTjltTWdHTzhJMFQw?=
 =?utf-8?B?OXpQb3d0OVVITnZnZmN5VkdITERHR1FhajhmNUs4Um5zOXJxVVNZUDRUN0d2?=
 =?utf-8?B?USt5RnV6N1gvL1ROOG42OTdJdDg3YkwxU04wRklzZHdJWUN2YW1adTNiRUlQ?=
 =?utf-8?B?ay9FSTc5Y0RwWEZQdG1nd2VZZng4WXd6b1dJa1RQSE4zWU1rRm85eHEyb1lE?=
 =?utf-8?B?QkdURWtvYk1Nemh4c25iYlBXZU5hMXFHbHVzME9HcjZHQllBQnh6RkVRVTlt?=
 =?utf-8?B?SDhaNTBBZUcvdXRkeUpaalVYVXVqWDN6UzZnZ0Z2Q3dLc1psQzRLa3NuY0lQ?=
 =?utf-8?B?NGZGb1hTbDdJa0FYbnk5M2dxTndaVElhOUxaOENvVjRHREdXL0hCYkdqa3FL?=
 =?utf-8?B?VUFOOFhVTmVhNnZQK093dWI0TTFtR0pwWC9URm5JRmJsbGtwVlF6NGdkcVRE?=
 =?utf-8?B?U0lJT2QzemZKMjgxUlFMOEFsTm1LMXdzRW4xbzB4SWF4MTBoVXZlS1FxSndr?=
 =?utf-8?B?dkR3dGMzcEduT1VUVFV0NXBBb3hRZ0NHWTBrM3JQcWEwUHNKWDZOSkh6UjFl?=
 =?utf-8?B?U3A4b2ZYdTl5bXB5dDVISTdFRSs2WEF5Sjd6bXkwZUhTTTFJRE9Va2NITWhx?=
 =?utf-8?B?NmI2NzBlVHF6THpGMVQwekF5citaN3k1dUVldDNBdlA3L2pnSUZubmMwSG5J?=
 =?utf-8?B?SEhtMVN4TWtpZmY0SEJNQnpLTElRbkE3VHJkTEl5aGtnU0FOMFlwVUN1a3ly?=
 =?utf-8?B?bUJtYlEvRG5zU3ExQ2xRL1dtUmVLVFRCeVBvREVadlBDUDJKYWtZZGkxTlBZ?=
 =?utf-8?B?THg1dmxIYVZTL3Z0ZjRtanZPblFzYVVnWU1nSjJsODhjaFY4RWFqU3grcFhE?=
 =?utf-8?B?d01ZRkZxWFlUZzJaRDI4allGVGRwN2lVeWFWcHYzVmkyKzUrTWs4OC9JL2N0?=
 =?utf-8?B?ZTdlc3Q1T2YrMkY1cnF3Vkt5SHJSSnpRa21HN3QrVDVpS3ZHYXRaV1gxZVh0?=
 =?utf-8?B?VjREOXc1bXFZSEQzQTFkVFBETE5RbWYzc1VNRHZaaWs4NXBidUgzS05SRUN1?=
 =?utf-8?B?cCt0N09QUThvUDRsNHdPeFhZNVdTeFd3bUNyQmd3dG9XSHBWaFpDMDBxbkk2?=
 =?utf-8?B?QUNUMDNEY2F5WCsraW1RWEE5OTNteDZCaHpFVWZnenlmZlNqVWo4UUxibTUy?=
 =?utf-8?B?Ym9qRHM1Tm91WGcxeGNVNTR1NldJZDcxNGNIRVRQb1JycWpVbnZCcU9Bemx2?=
 =?utf-8?B?ckwxOVlyUVoxdXRYVm9FVzN0Y0liY1g0R0c4MzBoTDNiNTdUaDBBd0ZCUlNN?=
 =?utf-8?B?YXhkSEdaMHZHc3dhV2VNSUQwSWVLZ0d6cVlIMHcxcnhTUXVxYTg0SXdET0R3?=
 =?utf-8?B?YWtBNmVoTjMzY3o5T0dWY3MwOU90bnh3NUtTLzlRdjhNWUY3bnRkUTU4bGJx?=
 =?utf-8?B?VjBzazdvMzYvZURJY0NZblFKd292VWV0Y1ZEaE9ia0haVi9DVTdqTHNHRlF5?=
 =?utf-8?B?M05TVGNOY0xaL09kZklMSFMydFJTRUlid1RmVDQ4NisvVlB2K0YwVERUK2FL?=
 =?utf-8?B?Yld4Rm5STE8rWEdGbzRoUXZ6K2l5Ni9rOHZhTkRiekVEVUtuSTdvN1k4b2lo?=
 =?utf-8?B?TmFJM3ZqTTlFOXFxdm40dExYeXVrbzlISW9hQlprc0tLUzlXQlZiTGlWRFFE?=
 =?utf-8?Q?a8wlFpMMvV+HNjUxhQsaRCM=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 567bca8b-cd63-46bb-77c8-08db29679a22
X-MS-Exchange-CrossTenant-AuthSource: BL3PR01MB7027.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 17:21:54.8846
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WRzF45ChC2tSvWzP6vDvqVwglAMBE5yqN+Z339//3pM66fJWwnlrmVTgC5dxHnwFSSEBH+6tmY5LzEg/3Eytc25RvCYChyZ80BeBz5pWZHk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR01MB7854
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

When testing CPPC cpufreq on our platform, we noticed the error may be 
quite high and it (high error) may happen quite often. For example, our 
platform max freq is 2.8GHz, when the CPUs were fully loaded (100% 
load), we saw cpuinfo_cur_freq may show 4GHz, it means > 40% error. And 
the high error (> 1%) happened 256 times out of 2127 samples (sampled 
every 3 seconds) in 2hrs test.

We tried to change the delay to 100us, things got improved although we 
still saw high error, but it happened much less often (22 times out of 
3623 samples).

So why was 2us used as the delay? Does it make sense to use a larger 
delay, for example, 100us used by our test, or even larger, for example, 
ms granularity?

Thanks,
Yang
