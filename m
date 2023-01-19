Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 860F7673B80
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 15:16:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbjASOQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 09:16:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbjASOQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 09:16:43 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA4FA172A
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 06:16:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=APIzufXub1XCFDvmv0JtmA78p42Fo9jZMUjV7U5jXnclbSw8t51rW05sXDafvqTclKYXaxKFtHELlhzYyaUlWjgVgkoRN2JJjml4OOoLZ9fV9BTUysP0msOUhhBM3NLb6DkHkFrxRSBzOIYFMwOsL1elB1kclAhKLPA7SIG/l+AB7/jzcc2L70zILXUWYt+16T2MRQgSDLkLEVCOfuEshn7xT/Yf1YbOU8syc6LsB4Keb/BZOEz3k2XVzbJRwdThTNfgVcw9TBPgpfkhSBRFku8ABtaS+OrGtxEItIhNx7aXZCTly5BMM+7thlVNF4TNoHiR7C1DVGgq9BzPwFhGRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Du46fGYN4eDUmOe+RHrx8MCGDuh1ayMt0z4/lG2c+5I=;
 b=cqgTaLniPpa2JAV5ZOGViqMqoY/LtfpmhmMCdiP9w3K34i1EuyJXtFg2awQiqKMLSW8hCst3KHGnuH2XL3zcEXHxTrh/BNLsKqu5W8LXhidvBB0zyzilJKJg0iT8taXNRJ5mcXzc1ioX53Emkok8X3PmLYfnwDkGWzvi7AdC11B0uE4MNrqMSU8XlrLJaqcShwJ+eH6wICfFBnjcLeqsltc8Pc0seWYUxI3gwnDw8zsSKXf9ojTsoPfKbzrKAYGDNc0tOjccLQqzmKN7fHWa67bOvxRsbbfgfjAgvqrJ2LOy0cChCmLdVweJLdKX/FT/uWsUZPA8Kt5TZuXg92AWzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Du46fGYN4eDUmOe+RHrx8MCGDuh1ayMt0z4/lG2c+5I=;
 b=q7h8FQUF3jykDWdED0Y+R5T1v9bYPDR5e/VoA+ZBlCdYulQSElDuWEW7rVSTQHemkXJJ6UcTPUL+Xxm38JBL6u7B+K0NMf5AB7rPDGn25tqkDHH+GuvXX6YOqBgHv6/z0fDxdrkY7cYPMNk0UCQBohHn96VjYCJH9W3314ea43a6yQnl4+JR5ZDeQf47KPX5w+M94D5zpu1monKa0YuyJtvUuBzs3PaKNZ0fD1Lm1fBaCDP7Yfo1mesT89uXJjRSxV04XbZcrJPFXSK0elcEhNaC3uOc8doeatlyV2RQmDk0kmuyTWGiReYADCCtUjo62wT0charo0IJYtPEz6qpjw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB6288.namprd12.prod.outlook.com (2603:10b6:8:93::7) by
 IA1PR12MB6209.namprd12.prod.outlook.com (2603:10b6:208:3e7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Thu, 19 Jan
 2023 14:16:41 +0000
Received: from DS7PR12MB6288.namprd12.prod.outlook.com
 ([fe80::d01c:4567:fb90:72b9]) by DS7PR12MB6288.namprd12.prod.outlook.com
 ([fe80::d01c:4567:fb90:72b9%3]) with mapi id 15.20.6002.013; Thu, 19 Jan 2023
 14:16:40 +0000
Message-ID: <88d82daa-811a-0cb7-8b83-7eb828b4fae8@nvidia.com>
Date:   Thu, 19 Jan 2023 16:16:33 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Content-Language: en-US
To:     Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>
Cc:     linux-kernel@vger.kernel.org, llvm@lists.linux.dev
From:   Gal Pressman <gal@nvidia.com>
Subject: .clang-format vs. checkpatch: Lines should not end with a '('
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P265CA0029.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ff::15) To DS7PR12MB6288.namprd12.prod.outlook.com
 (2603:10b6:8:93::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6288:EE_|IA1PR12MB6209:EE_
X-MS-Office365-Filtering-Correlation-Id: 45e2890a-ab8d-4de1-0f77-08dafa27c8d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QGc7K/GL7+WA0sX0ZaW+KTzDiKstwTmAZzpSPTJ6sVTNX73ZGmG3RduK80ZM4xzYlqRuzM4uyd7RT5a7mSIOmt2sha5LwIod5L5nB7JXu5/WBztJPooG1pniXnJM6KVssAGouhvxA6F9cnbVSg0+4rzxla526j14BgujkR9xz6MA6MNNfLId/XCxYjEMpa1zxTvjgJ8FKWAw/S1ASw0pVrm5C6QkxGACfeJWN9ByBuC4PnxQ1154LHgheH5h3ZtXEVXEcFWej2AqLdTMJ+7aIDBjDRDymCrngu9E9O9rTTVps6GixZaBek2bTfS3CwuPhk/pi/bUmlQi1is+A9rn0bNpKCTInosk93szCj3+rzA4MhT+wJpi0kBYDU6fi2A6vASyEowbJlVPbpX+BuaX+6pDRN4OJjFIzYAdfyQ5kwuER3StPviO4IwB2o0BUrywpDoAyNYvjoApll42kpRLoFSBH/muXj+LSm/dcCn3g+zeG1RrjNvMNUvK0XNMPyTQ+iC+Fz9A9rn4zOlLoq1Dq0NwSrfwmq6AjH3/zAu5/5CAfTXRGIIMio1ivMYim70H1VGXo9f7QH/dP3ZSpCMOMsd8g8ywao3GgN0xlGcsngULk49wadKgaHRgxTKRSU0zhE5Qoc8aNgP9tpOATFFPe4pgahOM/Rw7TRbtSnPo8rXHiBRE1iE8w3FCkp5dtS2Uk5thqZCKPu+E7ur7HzCxEfgzCkjpfvvNcn01fTePAz8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6288.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(39860400002)(376002)(136003)(346002)(451199015)(31686004)(36756003)(2906002)(4326008)(66946007)(8676002)(66476007)(66556008)(5660300002)(31696002)(4744005)(8936002)(83380400001)(38100700002)(110136005)(6666004)(478600001)(316002)(86362001)(41300700001)(6512007)(6486002)(2616005)(186003)(26005)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QkxQS2VSdVZFNTdjSDJOU3NUMDZFSGU2dFlZb1MrQ29PY1FJOG9yVVRzZXVu?=
 =?utf-8?B?NDNEaENBUGpFb1lGTXh4WkFXZUlBbzArSDJQbU1wMlJjY1pWODM4TVVwT1lv?=
 =?utf-8?B?L3RabjloK2E2b2NtZUVBY0R0LzZlVGJCVmFTZkVMM3hRSm9mUkRHV0tFbUtM?=
 =?utf-8?B?TVNWUE9NQzFrWVN4bDc2bFpWTHY4WkxuT1NEL2tRejIrRVc1R0xyc3cyR0R3?=
 =?utf-8?B?TVZZZ29YOUFvajV3Vk01WFVMNWJBZjlaSkY5cnBKMHpBVlVpbmNYREQrMUh2?=
 =?utf-8?B?V2ttRXZhZCtONUUwVm95NTJWRUtYaStldWE3VWRPWEZZTDNHMnoyNTdaaWJl?=
 =?utf-8?B?QzQxdGFzdlBkNlZ4YXE2UWhrOXZzU2JmRCtHVExJRURkb3RYWFdkNTJWcnBz?=
 =?utf-8?B?VktpSERNbStjbmYyT2wzRnIrZURHWFBOYnpvQ1RKTjJ1NFlMdVVDVCtqb0tZ?=
 =?utf-8?B?eFVuZlBFR1dlQ3hPTFdLeEVNajdsQTNEYi9TaDg4WEk5Qi9Tb2gwVnJXVk11?=
 =?utf-8?B?YitQR251RSt0eUJVdFN1YUI5dExBWWU2eFFmd1g2ZUlPb0UxeXMzcHJidXF2?=
 =?utf-8?B?cjB4M0oyTkN3WC9nODZpK24zYXBDRHdaT0lpc2VQY29vbkhqNER4cjZiSm1I?=
 =?utf-8?B?SVdJUVFCQXFrcGkxekV6Q3gzYVcwZHU1RDduZlBtL29MS3ZUTVRnUm9lUlhZ?=
 =?utf-8?B?Y0JTYUxsSE8vY2VGSDBCdEhrZ0RwcXBOYXJURE5uME1EcTVKbm9QME9ob25I?=
 =?utf-8?B?bWw2WkpOV3ozaVBkNmp3NkYwY1M5bDJGcDVhSkZMeUtoR0IvNytYMS9qek94?=
 =?utf-8?B?UHhORlcwVU1HbHF3Z1o3QXFBMkFRcVB1Z2c3Y1NIZXkvaUJYVmhZMTQ0WWxw?=
 =?utf-8?B?OStsRU9oSjlWNzZldzFEVU13dm5JZ3lMNTFEK1lrQTNFTXpkNG5Ock1DamlD?=
 =?utf-8?B?OVc2elpIWnEvSzVwQ1B0b2Z2QUh5dFdkQ1U5N3dxNC9FZnBsY1IzTVFyMjVS?=
 =?utf-8?B?L212OUQ2Y1FxYWE0bzhKbmhlVXljZXhSdmhnQXFtZW1Xbkg3YmtLdmVIdzJk?=
 =?utf-8?B?Qk42Vksxc2ZlUjdXYTljM01ZVnVlM3E0M2VwUGtIa3BEcjJReHNjRzI2aHhI?=
 =?utf-8?B?cSsvYW85ODBSL2VTaEpJb3ZLTDkzSHpnZ0Z1RmZvb2E5N2dUdWlUMGFlQ2dS?=
 =?utf-8?B?WjVkN01lTFNNSGM3eUFSQVZkUUpGMExJQUJISmN1YTMzNDN3T0FOQ0RKWFFG?=
 =?utf-8?B?a0FPOFdrRXdmUWNGaUF6cS9ReWlERFFJUjQ1dVQ4eTU1RzZVeTBuWUhTVUVC?=
 =?utf-8?B?WGlTTEN5ZHNiN2NOZEdxNkJuaFU1ZUsvRzZYZ3FjUVdXK2hJSGM2allZY0to?=
 =?utf-8?B?ZDVnVGZRMzh5TjhqMlJPSnBGTGhrc0NJanR2M2J5VXlDRks1bGJYbFpNV1F1?=
 =?utf-8?B?anlaN2YzclBLY2FLVVFNNzhhRDk5RUE3WlpxdXhlbXFoNDJ1VGh2Q3pZeXZm?=
 =?utf-8?B?c3VHTHFOWUlpZklrdXlDcGxJSHFpTnBPSkVPRUxrZnpyMHJnbXo0eFdhNDBV?=
 =?utf-8?B?Z2p5akhka3NYajg4STJhY1FTNU95ZXRreEVNSTlCNGNKUjYyTW5sUzhTMFFq?=
 =?utf-8?B?OXBSVWNXMk5CUGpvaUd1TEZjcXlWbDBSV0pwWTV6Z2IrRWtORStlMGFCdWpk?=
 =?utf-8?B?U0VxeWx1ekVEZHhwRGJXMFpoenFscjZqSFBmR0p6NXpsK25MZW1QcC9oVGpZ?=
 =?utf-8?B?VFVaM2s1dDNjOFlOZ1BMNTIrYW1yUFdYZ2tpR3JqU2ZIK2VXWnlLV3BTZVZk?=
 =?utf-8?B?VSthT1pCb0tpUC90cU1IaVRNT2VPQ2xLNEdOT1RKUk1IQkV2VCtoTnRiZjh4?=
 =?utf-8?B?NTEzVDZHc0oyWCtyK1V3eG1vcGVJbUtJVkhUbDZEL0pPWUJ5K3RVaFlpODZC?=
 =?utf-8?B?Mnd3TERhQWtkSktQV3BQVGlFSkthdWJlQW01YitleXpNcDhsSTRKbEgyVnJH?=
 =?utf-8?B?aC82MFpDZzVZbmh5UG40RUN2c2VCbjZNbEYrb0pRQThjYW9WU09uS1Y0bUdQ?=
 =?utf-8?B?OHFDOHhhQ2IvdnNaRGFrclZvbFlVY09YNDZoa29teXA4VE52SXlRY1IzaHl4?=
 =?utf-8?Q?Z+PHaXR2FYFdDTZacw/oPDEk2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45e2890a-ab8d-4de1-0f77-08dafa27c8d1
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6288.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2023 14:16:40.8971
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IXcOm9o3/iwXST06D9eyH0aCHN3NsiO1qoJyDhypCqr+8sv/gJMgbofabZzBBzUN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6209
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

I use clang-format to automatically format my patches, but checkpatch
likes to complain about:
CHECK: Lines should not end with a '('

I thought maybe adding a 'AllowAllArgumentsOnNextLine: false' would make
it happy but that didn't really seem to work.

Anyone else a bit annoyed by this? Maybe there's another solution I'm
failing to see?

Thanks
