Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A95E6B71E2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 10:01:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbjCMJBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 05:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbjCMJA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 05:00:29 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2072.outbound.protection.outlook.com [40.107.6.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A55A113D4E
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 01:56:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EcUSvuG3LI8hudVWwnOro6Di8KqxQSUXzGFb7/b2RvO5TWAIg3NQyiFAvXnhVMr1H2mK6YqDYxl1ENeLUar0auIgN5m03Rv3VLXaQXhEbmO9+tt+FLJEVBok62Fpcsxqylxk5VQe8QgjwR+sLlOm2sWKm1ZQTdJRbjKHs0nRk+X4hYYMu3e+Jy3gF9BVCpgw3vLYhfoJrZjjr4IpTFcsZM+bZHaRUkWXde8Jh+3Zn99P2merImrjmHC7/viKrlDNMWWg9ChDpiAPVPuixC/Rjv8o8NNmF1euJodNn4RgXBMYYfc+q2rHBAIhLNvgfEoDNpTyHzSlWVkxTEZfLpyi7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O1GRPH4gcnwl1nKO2F29Z2xtdSV33mgi6MSIfLNjV9A=;
 b=g08lFcHHPukd3lKyyf2Lz26qkr5GG4cl83EbnZNRt4hClFidQn20PBuYdMUwAcPKCn2cl0Ox7RUTySHclRChZYek5JlZQQjFhJkRyzDlURO5iD9JDRo2a96BzX0jR8Io4DnmXVY+BgS0fpx0iyLvokMGo3mi1hXfn03GetVgQ75C3B1/juVTuh1oeVeFQIij9sSKPnAmOVej0I55ptnZ+dt5P5nqM0Pi1Ta7SnuNcWwlNiEcoevVGPevWATAwIH+wXVHEAhZbqeSfmh4Y/8pcz37gkQ51Y1IgFI4sUbItvcpwn6pcYb9vO9kp20RKDTI47diAeI+SuO3AK/gZNJ9Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O1GRPH4gcnwl1nKO2F29Z2xtdSV33mgi6MSIfLNjV9A=;
 b=Cfejqyik9wqIc2r2ZWkjds3g/YOvKc/ZhvFUdi4Xwf1T7lBLP7UuNZPiVptsP0YSr0W27rx02FTli28wpHDJ4A/OEUbIgGbaxL6twsBOTan1Uidsm1LU6h0D/B/GwzGdC59AsrfBwoqjvGFZjkLBlCvChHoqMMGYTF6bRqAvLOnY68Chg/VAadNDjDpRwamjlHgLQJbL0wEWZrpUr16XngEC2VkyDi9+gCLOFmOmgQh3u70Mgf4p4jqfee9ukFlBB4HhCHpAKSNSr/xYx5CRpp64V42jt00YCx5IycmySVjCWe6/1z+3iztT1nCEtvHYsd9sFyt2FGRJm7i/5bpCxg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VE1PR04MB6560.eurprd04.prod.outlook.com (2603:10a6:803:122::25)
 by GVXPR04MB9851.eurprd04.prod.outlook.com (2603:10a6:150:118::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Mon, 13 Mar
 2023 08:56:56 +0000
Received: from VE1PR04MB6560.eurprd04.prod.outlook.com
 ([fe80::154e:166d:ec25:531b]) by VE1PR04MB6560.eurprd04.prod.outlook.com
 ([fe80::154e:166d:ec25:531b%5]) with mapi id 15.20.6178.024; Mon, 13 Mar 2023
 08:56:56 +0000
Message-ID: <ea0e3852-87ba-984b-4010-5eeac3d6c507@suse.com>
Date:   Mon, 13 Mar 2023 09:56:55 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [RFC PATCH 1/5] x86/xen: disable swiotlb for xen pvh
Content-Language: en-US
To:     Huang Rui <ray.huang@amd.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Stewart Hildebrand <Stewart.Hildebrand@amd.com>,
        Xenia Ragiadakou <burzalodowa@gmail.com>,
        Honglei Huang <honglei1.huang@amd.com>,
        Julia Zhang <julia.zhang@amd.com>,
        Chen Jiqian <Jiqian.Chen@amd.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
References: <20230312120157.452859-1-ray.huang@amd.com>
 <20230312120157.452859-2-ray.huang@amd.com>
From:   Jan Beulich <jbeulich@suse.com>
In-Reply-To: <20230312120157.452859-2-ray.huang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0050.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::13) To VE1PR04MB6560.eurprd04.prod.outlook.com
 (2603:10a6:803:122::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB6560:EE_|GVXPR04MB9851:EE_
X-MS-Office365-Filtering-Correlation-Id: 15a2d32a-ce2a-412f-efa9-08db23a0e5c3
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GIHVkA2CN8woGBWUqHUIJJ4V8xwP7wMBxGRyv/6jrEhqdC/LSCyhHOb89oSLQ2sUfnnOF7d9Nj096V3rfRh+71ERSExNd8wmlRf5UmIx02t3CiewVfjXqSWDrRzC7/rdnEEFCuW/oZ8FN2JOfZk1dhAnf/xv89voXzfYsMUq7vuCciZr60w9XbV+oU6MPdLta+30Ha8XwCci4AiIerEGc5/s41S7YlHzmGrD8hYQvt8ylLbrUnxEFZ26/QpPfSZipveFz3y9PXNWI29LpYFJExGmZBdjsgfZkg79hlQMkANqbLQt5K14XaURPIJMX8JxmAtBevw1dwaigwdMcz1RR1onvUHdG4MwBZbo31kt1tvOH1AJprvKSqYeotDq909HAIz+QHkQlF8mF+LAS6Ktu1jssW2LpTZBNHbOtxE6RFg6cm8FaKlsCW1vE2dqCylipVoFqkGUa50JQvYsB8Lr9qIKsuw/DnbsDDTqCSVRF73gLBkfNqH6fglZ4FmLLwBxjlQi4R+ClRL8z4ovwF3ALJH7CXCNoqqGbTVM5qZMLcko2ehLhK7p2bOgLrJ0Af3c2MiAYbAkhpWKcXgFGaHVYzDOQ/wxjoaRmoxTIfUB2VvDUqFIIEm+UAl0+lg1B8RGlBVRku5MDMT0BpxLL0I2rlTCc16Le7lm9aozIPLaosXoE5fA2ggSS+OFkNRkgNKQvy+wv3mDJlaR1hVGesBaaGm7Nljf0nO6NkkCpDSedvw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6560.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(366004)(39860400002)(376002)(346002)(136003)(451199018)(36756003)(86362001)(31696002)(41300700001)(186003)(26005)(6506007)(6512007)(53546011)(5660300002)(7416002)(4326008)(2616005)(6916009)(8936002)(316002)(54906003)(478600001)(66946007)(8676002)(66556008)(66476007)(6486002)(38100700002)(4744005)(2906002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dGo3NHFGZWdSUlhYcWRPajNxQlZ4WEppSnBLQTQ0eG1SbndKL2Y5R2hNYnFU?=
 =?utf-8?B?Tm9mbzFzL1gycE5FNmpVUzNXMnlxSWhtVkNPSjJYMHAzMkM4OVJXeUNMcnp3?=
 =?utf-8?B?am9VVWNZSDlYSEZjSXFMUWhwZEVsWm5JSndlSHhzcDRqMyt4VC8zaUYzYWF4?=
 =?utf-8?B?WXBlbWlVSXNwakMxSUsyTUhtRW9vY1dKKzJyUGNYU29qZjFpVWttMEhIaGNK?=
 =?utf-8?B?azNydmZ5aVdTRHpzeG8vWnFiZXc2YklucFltRU93QUtVM2o5ZE4ybTdqTU1v?=
 =?utf-8?B?c0VIeDZUWmd4ZUxzSUhJZ3ZxVmU5TEZzdU5JOXpPWWxqMGhSbVowdXoyb0J0?=
 =?utf-8?B?WDdDN3FldW41M1FjeSt1U2xpTFN4TXE2MEZmSTQ5Y2NNelY4amt6WWZ0L293?=
 =?utf-8?B?YXFzVDRSelF6UTkyWEZhV1ZlYU8rMnRCdnhQTHpGL2Vyd3VqbmhYOXpaT3gy?=
 =?utf-8?B?RXA4YlhmOXRlTEN5QzY1WVVyWXE3RXNIMmZHQ3BwV2VuRWJTMDNlUnZYcE9v?=
 =?utf-8?B?L2xNNDNjallIL2MvR2w0K2kvVGZSRXA0ckZtS2JkL05pRzV3WjZBWDZQM2pz?=
 =?utf-8?B?QWxBWE1wUGNnYTlZeFEvSUZiV3dUWkgxdXRRaUxpUGV6ZFE0WS8wTVZYc1NV?=
 =?utf-8?B?d2YzSlgyL1Q0VmhMc0VVa2xSZENHeUlvU3pOVHZZUlRkWkJYTkUzdVpWMXNn?=
 =?utf-8?B?OFcwSFdZUEN2ODYyS01WNHhVaWlhM3dBV01ZOUlaWmhjenFYOHNVWlQ3bXk0?=
 =?utf-8?B?bGJIUjVHS2VTY1RESDNaWDdQNUdWb3lCQVF0cWFwMWdqa0ViQzRIMGZZZ0Zh?=
 =?utf-8?B?UEFHTXo0ajVoeERPdVJwb3hsZGJxaUIvN1k3R3FJYXB5KzZpbFJQQzBqM1pH?=
 =?utf-8?B?byt0NGhNdTBBS3k3Sk9PbU02Y2hZVlNrSmoxd1Uwb2c3ZzdHbk9mc1pzV1pR?=
 =?utf-8?B?eGFVQUhmdk12ekhkdzJWa1RHRWhOSnl1cFNPbVZQMDU4dGlKczBRbkVKeFdi?=
 =?utf-8?B?UXl1cU9RL0FQQmlld2NlNkVEQ2JtbEtSRy9DeUVoMW5iQ1ZIN1ZxUHU2MktF?=
 =?utf-8?B?bTJyWTk1Z0xuR0RvTkNVNkVIRzlMcU9zVEJ4SUpzU3NqZWUzVC9tdzV6WkNM?=
 =?utf-8?B?MXlLek53anpBNDk0WHgrNC8rU1dybGtZRlFhYlZvT1JhcFd5a1EwZDRSN3U0?=
 =?utf-8?B?TCt1QXBPbWN6TGVWNGdSTnNHMUY3UFpKTnNKTDZROTIvYkRMSHhGNjZXSERM?=
 =?utf-8?B?bFNOTTJYNHhmNlZsWTZsUWRwTC9rallWRjluS0dXSUVLNFh4M2lhU1lPQzFF?=
 =?utf-8?B?V0svWURiVVBCQlpocTJCZGNjMU5lSXFPcm5yMm54ZlcyWFBuRXJESkNBL2VM?=
 =?utf-8?B?RncyMExQYWRBeHRiNXNsRTE4dTM4cnd6dTVSbXZDRjY4dHFIelFnNjVic0lN?=
 =?utf-8?B?LzJGdWJpRHF6Z0VBdXFjc2NsRjZFSVFqYUh6TS9Cd3pMMWdqckhnOHEweUVV?=
 =?utf-8?B?K042eFJ1ZnllbUM2Yk1oVmxnT3lMLzNMZm1TbStmdE9ZaTh0aklpNy9uQUVI?=
 =?utf-8?B?VG13c3ljNmdVa2xIUmJBUG9UcTNabURXTHZna1FjdmMxNzg1TDAzZ2xseGg0?=
 =?utf-8?B?ckJwOEhmTTdXa3JscTZQNWRMczlhSlV4bCtUaE1qRGRYQTRWSkZYL05tc214?=
 =?utf-8?B?MHhEcEhDNTNHYkpJekhiQmpJRnBXcXlqWFV0Z3lDNkxCZmJPWG5lbzZNTW5v?=
 =?utf-8?B?ZnllVFdTc1Z5Q0oxOEhyK05pT0h2eWYzemZtTVlaV1MyMGc2OEFMcDJBbktM?=
 =?utf-8?B?amtEUXBwMVI4YmswdUwycktXaDlRV0NxbjNGdkkxcHpSb3VQNFhCb1RBVTBj?=
 =?utf-8?B?ZEFuZVRSdFljNFJJZDlQOEtjMm44UERnUVhVWDBJbFVVdjJLU2I3T1hiMTFt?=
 =?utf-8?B?bEdQL1JXblM5bGhpZHBCRzlDUXN4YlhLS2FPZFUwRldTTEZWNVZGN1FJeERp?=
 =?utf-8?B?Z1FsWWNFUWhVUWF2WlBCSStBT2xQcjUyRmNCMGM1TTRjVGVwNWltYWp0LzJL?=
 =?utf-8?B?aEsxK3JjdCtMWGlOWTZ4RFA3aExsMWtETC9QQWhVSEE1cm5QZVh4WXd2Ti9J?=
 =?utf-8?Q?VvHlqWSVBNOA0msNkouuyxNbd?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15a2d32a-ce2a-412f-efa9-08db23a0e5c3
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6560.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2023 08:56:56.1807
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r7X2Ze86+cNZIAGtBuCOO6Wt7TQZvCJ7VrifXRVr/lfC4kK5Z37uIJis9cD6Ifx9m0BCa7SYeqzz0jZzj6tuqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9851
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.03.2023 13:01, Huang Rui wrote:
> Xen PVH is the paravirtualized mode and takes advantage of hardware
> virtualization support when possible. It will using the hardware IOMMU
> support instead of xen-swiotlb, so disable swiotlb if current domain is
> Xen PVH.

But the kernel has no way (yet) to drive the IOMMU, so how can it get
away without resorting to swiotlb in certain cases (like I/O to an
address-restricted device)?

Jan
